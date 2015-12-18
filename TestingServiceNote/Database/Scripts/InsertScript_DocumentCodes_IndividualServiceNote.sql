/********************************************************************************                                                    
--    
-- Copyright: Streamline Healthcare Solutions    
--    
-- Purpose:   Adding Screen and DocumentCodes items for New Service Note called Psychiatric Note .
   
-- Author:  Vijay Yadav
-- Date:    23 june 2015    


*********************************************************************************/ 
----------------------------------------   DocumentCodes Table   ----------------------------------- 
DECLARE @documentCodeId INT
 
DECLARE @TableList VARCHAR(500)
DECLARE @GetDataSp VARCHAR(500)
DECLARE @ViewStoredProcedure VARCHAR(500)
DECLARE @ViewDocumentURL VARCHAR(500)
DECLARE @ViewDocumentRDL VARCHAR(500)
DECLARE @InitializationStoredProcedure VARCHAR(500)
DECLARE @DocumentName VARCHAR(500) 
DECLARE @InitializationProcess INT 
DECLARE @DocumentType INT 
DECLARE @Active CHAR(1) 
DECLARE @ServiceNote CHAR(1) 
DECLARE @PatientConsent CHAR(1) 
DECLARE @OnlyAvailableOnline CHAR(1) 
DECLARE @RequiresSignature CHAR(1) 
DECLARE @ViewOnlyDocument CHAR(1) 
DECLARE @DocumentURL CHAR(1) 
DECLARE @ToBeInitialized CHAR(1) 
DECLARE @TabId INT 
DECLARE @ValidationStoredProcedure VARCHAR(500)
DECLARE @RequiresLicensedSignature CHAR(1) 

SET @documentCodeId = 70014
SET @DocumentName = 'Camino Individual Service Note'
SET @DocumentType = 10  
SET @Active = 'Y' 
SET @ServiceNote = 'Y' --For ServiceNote set this to 'Y'
SET @PatientConsent = NULL 
SET @OnlyAvailableOnline = 'N' 
SET @ViewDocumentURL = 'RDLMainIndividualServiceNote'
SET @ViewDocumentRDL = 'RDLMainIndividualServiceNote'
SET @GetDataSp ='csp_GetCustomIndividualServiceNote'
SET @TableList ='CustomDocumentIndividualServiceNotes,CustomIndividualServiceNoteGoals,CustomIndividualServiceNoteObjectives'
SET @RequiresSignature = 'Y' 
SET @ViewOnlyDocument= NULL 
SET @DocumentURL= NULL 
SET @ToBeInitialized= NULL
SET @InitializationProcess = NULL 
SET @InitializationStoredProcedure= NULL --''
SET @ValidationStoredProcedure= 'csp_ValidateCustomIndividualServiceNote'
SET @ViewStoredProcedure = NULL--'csp_IntensiveCaseManagementNote'
SET @RequiresLicensedSignature = NULL


IF NOT EXISTS (SELECT DocumentCodeId 
               FROM   DocumentCodes 
               WHERE  DocumentCodeId = @documentCodeId) 
  BEGIN 
      SET IDENTITY_INSERT [dbo].[DocumentCodes] ON 

      INSERT INTO [DocumentCodes] 
                  ([DocumentCodeId], 
                   [DocumentName], 
                   [DocumentDescription], 
                   [DocumentType], 
                   [Active], 
                   [ServiceNote], 
                   [PatientConsent], 
                   [OnlyAvailableOnline], 
                   [StoredProcedure], 
                   [TableList], 
                   [RequiresSignature], 
                   [ViewOnlyDocument], 
                   [DocumentURL], 
                   [ToBeInitialized],
                   [ViewStoredProcedure],
                   [ViewDocumentURL],
				   [ViewDocumentRDL],
                   [InitializationProcess],
                   InitializationStoredProcedure,
                   ValidationStoredProcedure,
                   RequiresLicensedSignature) 
      VALUES      ( @documentCodeId, 
                    @DocumentName, 
                    @DocumentName, 
                    @DocumentType, 
                    @Active, 
                    @ServiceNote, 
                    @PatientConsent, 
                    @OnlyAvailableOnline, 
                    @GetDataSp, 
                    @TableList, 
                    @RequiresSignature, 
                    @ViewOnlyDocument, 
                    @DocumentURL, 
                    @ToBeInitialized, 
                    @ViewStoredProcedure,
                    @ViewDocumentURL,
                    @ViewDocumentRDL,
                    @InitializationProcess,
                    @InitializationStoredProcedure,
                    @ValidationStoredProcedure,
                    @RequiresLicensedSignature) 

      SET IDENTITY_INSERT [dbo].[DocumentCodes] OFF 
  END 
ELSE 
  BEGIN 
      UPDATE [DocumentCodes] 
      SET    DocumentName = @DocumentName, 
             DocumentDescription = @DocumentName, 
             DocumentType = @DocumentType, 
             Active = @Active, 
             ServiceNote = @ServiceNote, 
             PatientConsent = @PatientConsent, 
             OnlyAvailableOnline = @OnlyAvailableOnline,
             StoredProcedure = @GetDataSp, 
             TableList = @TableList, 
             RequiresSignature = @RequiresSignature, 
             ViewOnlyDocument = @ViewOnlyDocument, 
             DocumentURL = @DocumentURL, 
             ToBeInitialized = @ToBeInitialized, 
             ViewStoredProcedure = @ViewStoredProcedure,
             ViewDocumentURL = @ViewDocumentURL,
			 ViewDocumentRDL = @ViewDocumentRDL,
             InitializationProcess = @InitializationProcess,
             InitializationStoredProcedure= @InitializationStoredProcedure,
             ValidationStoredProcedure=@ValidationStoredProcedure,
             RequiresLicensedSignature = @RequiresLicensedSignature
      WHERE  DocumentCodeId = @documentCodeId 
  END 

-----------------------------------------------END--------------------------------------------  
----------------------------------------   Screens Table   -----------------------------------  
/*   
  Please change these variables for supporting a new page/document/widget   
  Screen Types:   
    None:               0,   
        Detail:             5761,   
        List:               5762,   
        Document:           5763,   
        Summary:            5764,   
        Custom:             5765,   
        ExternalScreen:     5766   
*/

DECLARE @ScreenId INT
DECLARE @ScreenName VARCHAR(500) 
DECLARE @ScreenType INT 
DECLARE @ScreenURL VARCHAR(500) 
DECLARE @ValidationStoredProcedureUpdate VARCHAR(500) 
DECLARE @ValidationStoredProcedureComplete VARCHAR(500) 
DECLARE @WarningStoredProcedureComplete VARCHAR(500) 
DECLARE @PostUpdateStoredProcedure VARCHAR(500) 
DECLARE @RefreshPermissionsAfterUpdate VARCHAR(500) 

SET @TabId = 2 

SET @ScreenId = 70014
SET @ScreenName = 'Individual Service Note' 
SET @ScreenType = 5763 
SET @ScreenURL = '/Custom/CaminoIndividualServiceNote/WebPages/CaminoIndividualServiceNote.ascx' 
SET @InitializationStoredProcedure ='csp_InitCustomIndividualServiceNote' 
SET @ValidationStoredProcedureUpdate = NULL 
SET @ValidationStoredProcedureComplete='csp_ValidateCustomIndividualServiceNote' 
SET @WarningStoredProcedureComplete= NULL
SET @PostUpdateStoredProcedure= NULL
SET @RefreshPermissionsAfterUpdate= NULL 
SET @documentCodeId = 70014

IF NOT EXISTS (SELECT ScreenId 
               FROM   Screens 
               WHERE  ScreenId = @ScreenId) 
  BEGIN 
      SET IDENTITY_INSERT [dbo].[Screens] ON 

      INSERT INTO [Screens] 
                  ([ScreenId], 
                   [ScreenName], 
                   [ScreenType], 
                   [ScreenURL], 
                   [TabId], 
                   [InitializationStoredProcedure], 
                   [ValidationStoredProcedureUpdate], 
                   [ValidationStoredProcedureComplete], 
                   [PostUpdateStoredProcedure], 
                   [RefreshPermissionsAfterUpdate], 
                   [DocumentCodeId]) 
      VALUES      ( @ScreenId, 
                    @ScreenName, 
                    @ScreenType, 
                    @ScreenURL, 
                    @TabId, 
                    @InitializationStoredProcedure, 
                    @ValidationStoredProcedureUpdate, 
                    @ValidationStoredProcedureComplete, 
                    @PostUpdateStoredProcedure, 
                    @RefreshPermissionsAfterUpdate, 
                    @documentCodeId) 

      SET IDENTITY_INSERT [dbo].[Screens] OFF 
  END 
ELSE 
  BEGIN 
      UPDATE Screens 
      SET    ScreenName = @ScreenName, 
             ScreenType = @ScreenType, 
             ScreenURL = @ScreenURL, 
             TabId = @TabId, 
             InitializationStoredProcedure = @InitializationStoredProcedure, 
             ValidationStoredProcedureUpdate = @ValidationStoredProcedureUpdate, 
             ValidationStoredProcedureComplete = @ValidationStoredProcedureComplete, 
             PostUpdateStoredProcedure = @PostUpdateStoredProcedure, 
             RefreshPermissionsAfterUpdate = @RefreshPermissionsAfterUpdate, 
             DocumentCodeId = @documentCodeId 
      WHERE  ScreenId = @ScreenId 
  END 
  IF NOT EXISTS (
		SELECT *
		FROM dbo.Screens
		WHERE ScreenId =70014
		)
BEGIN
SET IDENTITY_INSERT Screens ON
INSERT INTO [Screens] (
		ScreenId
		,[ScreenName]
		,[ScreenType]
		,[ScreenURL]
		,[TabId]
		,[DocumentCodeId]
		)
	VALUES (
		 70014
		,'Individual Service Note'
		,5765
		,'/Custom/CaminoIndividualServiceNote/WebPages/CaminoIndividualServiceNote.ascx'
		,2
		,null
		)
SET IDENTITY_INSERT Screens OFF		
END
  

