/****** Object:  StoredProcedure [dbo].[csp_ValidateCustomIndividualServiceNote]    Script Date: 08/31/2015 17:41:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_ValidateCustomIndividualServiceNote]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_ValidateCustomIndividualServiceNote] --1561
GO

CREATE PROCEDURE [dbo].[csp_ValidateCustomIndividualServiceNote]
    @DocumentVersionId INT  
  
 /********************************************************************************                                                     
--    
-- Copyright: Streamline Healthcare Solutions    
-- "Individual Service Note"  
-- Purpose: 
--    
-- Author 
-- Date:     
--    
-- *****History****    
/*  Date			Author			Description */  
/*  24/02/2015      Bernardin       To get validations */ 
/*  18/08/2015      Venkatesh       Added one validation as per task VCAT - 330 */ 
--  30-Aug-2015     Deej Added logic for Billing Dx validation
--  09-04-2015		Njain			Added @CarePlanDocumentVersionId to @Variables
--  09-24-2015      SFarber         Added logic to set CarePlanDocumentVersionId  

*********************************************************************************/
AS
    BEGIN    
  
     
-- Declare Variables    
        DECLARE @DocumentType VARCHAR(10)    
    
-- Get ClientId    
        DECLARE @ClientId INT    
        DECLARE @EffectiveDate DATETIME    
        DECLARE @StaffId INT    
        DECLARE @DocumentCodeId INT  
        DECLARE @ServiceId INT
        DECLARE @DateOfService DATETIME
        --DECLARE @SafetyEffectiveDate DATETIME
        DECLARE @CarePlanDocumentVersionId INT

        BEGIN TRY
    
            SELECT  @ClientId = d.ClientId ,
                    @ServiceId = ServiceId
            FROM    Documents d
            WHERE   d.InProgressDocumentVersionId = @DocumentVersionId    
    
            SELECT  @StaffId = d.AuthorId
            FROM    Documents d
            WHERE   d.InProgressDocumentVersionId = @DocumentVersionId    
    
            SET @EffectiveDate = CONVERT(DATETIME, CONVERT(VARCHAR, GETDATE(), 101))    
  
            CREATE TABLE [#validationReturnTable]
                (
                  TableName VARCHAR(100) NULL ,
                  ColumnName VARCHAR(100) NULL ,
                  ErrorMessage VARCHAR(MAX) NULL ,
                  TabOrder INT NULL ,
                  ValidationOrder INT NULL
                )    
  
--Set @DocumentCodeId = (Select DocumentCodeId From Documents Where CurrentDocumentVersionId = @DocumentVersionId)  
  --select * from DocumentCodes where DocumentCodeId = 40038  
            DECLARE @ServiceGoalObjective INT
            IF EXISTS ( SELECT  1
                        FROM    CustomServices CS
                        WHERE   ServiceId = @ServiceId
                                AND ISNULL(CS.GoalsAndObjectives, '') <> ''
                                AND ISNULL(CS.RecordDeleted, 'N') = 'N' )
                BEGIN
                    SET @ServiceGoalObjective = 1
                END
            ELSE
                BEGIN
                    SET @ServiceGoalObjective = 0
                END 

            --SET @SafetyEffectiveDate = ( SELECT TOP 1
            --                                    EffectiveDate
            --                             FROM   Documents Doc
            --                             WHERE  Doc.ClientId = @ClientID
            --                                    AND Doc.[Status] = 22
            --                                    AND ISNULL(Doc.RecordDeleted, 'N') = 'N'
            --                                    AND Doc.DocumentCodeId = 40038
            --                             ORDER BY Doc.EffectiveDate DESC ,
            --                                    Doc.ModifiedDate DESC
            --                           )
            --SELECT  @DateOfService = s.DateOfService
            --FROM    [Services] s
            --        JOIN Documents d ON s.ServiceId = d.ServiceId
            --WHERE   d.CurrentDocumentVersionId = @DocumentVersionId
  
    
-- Set Variables sql text    
            DECLARE @Variables VARCHAR(MAX)      
            SET @Variables = 'DECLARE @DocumentVersionId int    
      SET @DocumentVersionId = ' + CONVERT(VARCHAR(20), @DocumentVersionId) + --'DECLARE @DocumentType varchar(10)    
     -- SET @DocumentType = ' +''''+ @DocumentType+'''' +    
                ' DECLARE @ClientId int    
      SET @ClientId = ' + CONVERT(VARCHAR(20), @ClientId) + 'DECLARE @EffectiveDate datetime    
      SET @EffectiveDate = ''' + CONVERT(VARCHAR(20), @EffectiveDate, 101) + '''' + 'DECLARE @StaffId int    
      SET @StaffId = ' + CONVERT(VARCHAR(20), @StaffId) + 'DECLARE @ServiceId int    
      SET @ServiceId = ' + CONVERT(VARCHAR(20), @ServiceId) + 'DECLARE @ServiceGoalObjective INT
      SET @ServiceGoalObjective = ' + CONVERT(VARCHAR(20), @ServiceGoalObjective) + ' DECLARE @CarePlanDocumentVersionId INT SET @CarePlanDocumentVersionId = ' + CONVERT(VARCHAR(20), isnull(@CarePlanDocumentVersionId, -1))
    
-- Exec csp_validateDocumentsTableSelect to determine validation list      
            IF NOT EXISTS ( SELECT  1
                            FROM    CustomDocumentValidationExceptions
                            WHERE   DocumentVersionId = @DocumentVersionId
                                    AND DocumentValidationid IS NULL )
                BEGIN      
                    EXEC csp_validateDocumentsTableSelect @DocumentVersionId, 70014, @DocumentType, @Variables      
  
                    DECLARE @COUNT INT= 0
                    DECLARE @IsNotBillable CHAR(1)= 'N'
                    SELECT  @IsNotBillable = ISNULL(P.NotBillable, 'N')
                    FROM    Services S
                            INNER JOIN dbo.ProcedureCodes P ON S.ServiceId = @ServiceId
                                                               AND P.ProcedureCodeId = S.ProcedureCodeId
                    --SELECT  @COUNT = COUNT(*)
                    --FROM    ServiceDiagnosis
                    --WHERE   ServiceId = @ServiceId
                    --IF @COUNT = 0
                    --    AND @IsNotBillable = 'N'
                    --    BEGIN
                    --        INSERT  INTO #validationReturnTable
                    --                ( TableName ,
                    --                  ColumnName ,
                    --                  ErrorMessage ,
                    --                  TabOrder ,
                    --                  ValidationOrder
                    --                )
                    --                SELECT  'ServiceDiagnosis' ,
                    --                        'Diagnosis' ,
                    --                        'Service Note - Dx is required' ,
                    --                        35 ,
                    --                        35
                    --    END	
  
--  IF(ISNULL(CONVERT (DATE, @SafetyEffectiveDate),'1900-01-01') <> CONVERT (DATE, @DateOfService))
--BEGIN	
--	INSERT INTO #validationReturnTable (TableName,ColumnName,ErrorMessage,TabOrder,ValidationOrder)
--	SELECT 'CustomDocumentIndividualNote','DateofService','A signed Safety/Crisis Plan is required before you can sign the service note',8,1

--END
                    SELECT  TableName ,
                            ColumnName ,
                            ErrorMessage ,
                            TabOrder ,
                            ValidationOrder
                    FROM    #validationReturnTable
                    ORDER BY ValidationOrder       
                END      
    
        END TRY
 
        BEGIN CATCH          
            DECLARE @Error VARCHAR(8000)                                                 
            SET @Error = CONVERT(VARCHAR, ERROR_NUMBER()) + '*****' + CONVERT(VARCHAR(4000), ERROR_MESSAGE()) + '*****' + ISNULL(CONVERT(VARCHAR, ERROR_PROCEDURE()), 'csp_ValidateCustomIndividualServiceNote') + '*****' + CONVERT(VARCHAR, ERROR_LINE()) + '*****' + CONVERT(VARCHAR, ERROR_SEVERITY()) + '*****' + CONVERT(VARCHAR, ERROR_STATE())                                           
            RAISERROR ( @Error, /* Message text.*/16, /* Severity.*/ 1 /*State.*/ );             
        END CATCH          
    END
GO
