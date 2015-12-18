
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_InitCustomIndividualServiceNote]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_InitCustomIndividualServiceNote] --107,550,''
GO

CREATE PROCEDURE [dbo].[csp_InitCustomIndividualServiceNote] (
	@ClientID INT
	,@StaffID INT
	,@CustomParameters XML
	)
AS
/*********************************************************************/
/* Stored Procedure: [csp_InitCustomIndividualServiceNote]   */
/*       Date              Author                  Purpose                   */
/*       03/02/2015        Bernardin               To initialize CustomDocumentIndividualServiceNoteGenerals,CustomDocumentIndividualServiceNoteDBTs tabls values */
/*       09/07/2015        Akwinass                Included ProcedureCodeId in Goals Table(Task #195 in Valley Client Acceptance Testing Issues) */
/*********************************************************************/
BEGIN
	BEGIN TRY
		DECLARE @LatestDocumentVersionID INT
		DECLARE @LatestCarePlanDocumentVersionID INT 		
		DECLARE @UserCode VARCHAR(300)
		DECLARE @GroupClientID INT
		SELECT @UserCode = UserCode FROM Staff WHERE StaffId = @StaffID
 DECLARE @ProcedureCodeId INT
 if @CustomParameters is not null                                   
   Begin                                  
	set @ProcedureCodeId = @CustomParameters.value('(/Root/Parameters/@ProcedureCodeId)[1]', 'char(10)' )                      	set @GroupClientID = @CustomParameters.value('(/Root/Parameters/@ClientId)[1]', 'char(10)' )  
   End
   if(isnull(@GroupClientID,0)>0)
   begin
   set @ClientID=@GroupClientID
   end

 
SET @LatestCarePlanDocumentVersionID =(select top 1 CurrentDocumentVersionId 
                                       from Documents d join DocumentCarePlans DCP on d.CurrentDocumentVersionId = DCP.DocumentVersionId                                             
                                        where d.ClientId = @ClientID                                                       
                                         and d.EffectiveDate <= convert(datetime, convert(varchar, getDate(),101))                                                        
                                         and d.Status = 22                    
										 and d.DocumentCodeId=1620 --Valley Care Plan  
                                         and isNull(d.RecordDeleted,'N')='N' 
                                          and  ISNull(DCP.RecordDeleted,'N')='N'                                                                                            
                                          order by d.EffectiveDate desc,d.ModifiedDate desc ) 
                                          
                                          

		
			SET @LatestDocumentVersionID = (
				SELECT TOP 1 CurrentDocumentVersionId
				FROM CustomDocumentIndividualServiceNotes CDLS
				INNER JOIN Documents Doc ON CDLS.DocumentVersionId = Doc.CurrentDocumentVersionId
				WHERE Doc.ClientId = @ClientID
					AND Doc.[Status] = 22
					AND ISNULL(CDLS.RecordDeleted, 'N') = 'N'
					AND ISNULL(Doc.RecordDeleted, 'N') = 'N'
				ORDER BY Doc.EffectiveDate DESC
					,Doc.ModifiedDate DESC
				)
		SET @LatestDocumentVersionId = ISNULL(@LatestDocumentVersionId, - 1)
		
		SELECT 'CustomDocumentIndividualServiceNotes' AS TableName
			,- 1 AS DocumentVersionId
			,@UserCode AS CreatedBy
			,GETDATE() AS CreatedDate
			,@UserCode AS ModifiedBy
			,GETDATE() AS ModifiedDate
			--,Overcome AS PlanLastService
		 FROM systemconfigurations s
	     LEFT OUTER JOIN CustomDocumentIndividualServiceNotes CDLS ON CDLS.DocumentVersionId = @LatestDocumentVersionID AND ISNULL(CDLS.RecordDeleted,'N') <> 'Y'
		
		
		
		IF @LatestCarePlanDocumentVersionID > 0
		BEGIN
		SELECT distinct 'CustomIndividualServiceNoteGoals' AS TableName
		       ,- 1 AS DocumentVersionId
			   ,@UserCode AS CreatedBy
			   ,GETDATE() AS CreatedDate
			   ,@UserCode AS ModifiedBy
			   ,GETDATE() AS ModifiedDate
		       ,CG.CarePlanGoalId AS GoalId
			   ,CG.GoalNumber AS GoalNumber
			   ,CG.ClientGoal AS GoalText
		 	   ,'N' AS CustomGoalActive	
		 	  ,@ProcedureCodeId AS ProcedureCodeId	
		 FROM CarePlanGoals CG
		join CarePlanObjectives CO on CG.CarePlanGoalId = co.CarePlanGoalId 
		left join CarePlanPrescribedServiceObjectives PSO on PSO.CarePlanObjectiveId =CO.CarePlanObjectiveId  
		left join CarePlanPrescribedServices PS on PS.CarePlanPrescribedServiceId =  PSO.CarePlanPrescribedServiceId 
		join AuthorizationCodeProcedureCodes AP on ap.AuthorizationCodeId = PS.AuthorizationCodeId 
		where ISNull(CG.RecordDeleted,'N')='N' AND ISNull(CG.GoalActive,'N')='Y' and CG.DocumentVersionId=@LatestCarePlanDocumentVersionID 	
		and AP.ProcedureCodeId  = @ProcedureCodeId order by CG.GoalNumber	 

		 Select distinct 'CustomIndividualServiceNoteObjectives' AS TableName
		       ,- 1 AS DocumentVersionId
			   ,@UserCode AS CreatedBy
			   ,GETDATE() AS CreatedDate
			   ,@UserCode AS ModifiedBy
			   ,GETDATE() AS ModifiedDate
			   ,CDTPO.CarePlanGoalId AS GoalId
		       ,CDTPO.ObjectiveNumber AS ObjectiveNumber
		       ,CDTPO.AssociatedObjectiveDescription AS ObjectiveText
		       ,'N' AS CustomObjectiveActive
			    from CarePlanObjectives AS CDTPO 
		join CarePlanPrescribedServiceObjectives PSO on PSO.CarePlanObjectiveId =CDTPO.CarePlanObjectiveId  
		join CarePlanPrescribedServices PS on PS.CarePlanPrescribedServiceId =  PSO.CarePlanPrescribedServiceId 
		join AuthorizationCodeProcedureCodes AP on ap.AuthorizationCodeId = PS.AuthorizationCodeId
		Left JOIN  CarePlanGoals CDTPG  ON CDTPO.CarePlanGoalId = CDTPG.CarePlanGoalId   AND  ISNULL(CDTPG.RecordDeleted,'N')='N'  and  ISNULL(CDTPG.GoalActive,'Y') ='Y'
		left join GlobalCodes GC on GC.Code =  (Case when CDTPO.ProgressTowardsObjective = 'D' then  'Deterioration'
										   else case  when CDTPO.ProgressTowardsObjective = 'N' then  'No Change'
										   else case  when CDTPO.ProgressTowardsObjective = 'S' then  'Some Improvement'
										   else case  when CDTPO.ProgressTowardsObjective = 'M' then  'Moderate Improvement'
										   else case  when CDTPO.ProgressTowardsObjective = 'A' then  'Achieved' END END END END END)
			WHERE ISNULL(CDTPO.RecordDeleted,'N')='N' 
			AND CDTPG.DocumentVersionId = @LatestCarePlanDocumentVersionID
			and AP.ProcedureCodeId = @ProcedureCodeId order by CDTPO.ObjectiveNumber
		 
       END

   
	END TRY
	BEGIN CATCH
DECLARE @Error VARCHAR(8000)

		SET @Error = CONVERT(VARCHAR, ERROR_NUMBER()) + '*****' + CONVERT(VARCHAR(4000), ERROR_MESSAGE()) + '*****' + ISNULL(CONVERT(VARCHAR, ERROR_PROCEDURE()), 'csp_InitCustomIndividualServiceNote') + '*****' + CONVERT(VARCHAR, ERROR_LINE()) + '*****' + CONVERT(VARCHAR, ERROR_SEVERITY()) + '*****' + CONVERT(VARCHAR, ERROR_STATE())

		RAISERROR (
				@Error
				,-- Message text.
				16
				,-- Severity.
				1 -- State.
				);
	
	END CATCH
END

GO


