IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_GetCustomIndividualServiceNote]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_GetCustomIndividualServiceNote] --1601
GO
    
CREATE PROCEDURE [dbo].[csp_GetCustomIndividualServiceNote]  (@DocumentVersionId INT)    
AS    
/********************************************************************************                                                       
--      
-- Copyright: Streamline Healthcare Solutions      
/*    Date        Author            Purpose */
/*   03/02/2015   Bernardin         To get CustomDocumentIndividualServiceNoteGenerals,CustomDocumentIndividualServiceNoteDBTs  table vlaues */
/*   09/07/2015   Akwinass          Included ProcedureCodeId in Goals Table(Task #195 in Valley Client Acceptance Testing Issues) */    
*********************************************************************************/    
BEGIN TRY    

 SELECT DocumentVersionId,
		CreatedBy,
		CreatedDate,
		ModifiedBy,
		ModifiedDate,
		RecordDeleted,
		DeletedBy,
		DeletedDate,
		ShowSelectedItems,
		GoalsOutcomesStrategies,
		NameOfService,
		ServiceEvent,
		PertinentEvent,
		Progress,
		LackOfProgress,
		ProgressComments,
		FollowUpNeeded
 FROM CustomDocumentIndividualServiceNotes 
 WHERE ISNull(RecordDeleted, 'N') = 'N' AND DocumentVersionId = @DocumentVersionId   
 

 DECLARE @ProcedureCodeId INT = 0
 SELECT TOP 1 @ProcedureCodeId = ProcedureCodeId FROM Services where ServiceId = (SELECT TOP 1 ServiceId FROM Documents WHERE CurrentDocumentVersionId = @DocumentVersionId) 
 
 SELECT IndividualServiceNoteGoalId
		,CreatedBy
		,CreatedDate
		,ModifiedBy
		,ModifiedDate
		,RecordDeleted
		,DeletedBy
		,DeletedDate
		,DocumentVersionId
		,GoalId
		,GoalNumber
		,GoalText
		,CustomGoalActive
		,@ProcedureCodeId AS ProcedureCodeId
 FROM CustomIndividualServiceNoteGoals
 WHERE ISNull(RecordDeleted, 'N') = 'N' AND DocumentVersionId = @DocumentVersionId 
 
 SELECT IndividualServiceNoteObjectiveId
		,CreatedBy
		,CreatedDate
		,ModifiedBy
		,ModifiedDate
		,RecordDeleted
		,DeletedBy
		,DeletedDate
		,DocumentVersionId
		,GoalId
		,ObjectiveNumber
		,ObjectiveText
		,CustomObjectiveActive
		,[Status]
 FROM CustomIndividualServiceNoteObjectives
WHERE ISNull(RecordDeleted, 'N') = 'N' AND DocumentVersionId = @DocumentVersionId 
  end try    
  
    
BEGIN CATCH    
 DECLARE @Error VARCHAR(8000)    
    
 SET @Error = Convert(VARCHAR, ERROR_NUMBER()) + '*****' + Convert(VARCHAR(4000), ERROR_MESSAGE()) + '*****' + isnull(Convert(VARCHAR, ERROR_PROCEDURE()), 'csp_GetCustomIndividualServiceNote') + '*****' + Convert(VARCHAR, ERROR_LINE()) + '*****' + Convert(VARCHAR, ERROR_SEVERITY()) + '*****' + Convert(VARCHAR, ERROR_STATE())    
    
 RAISERROR (    
   @Error    
   ,-- Message text.                    
   16    
   ,-- Severity.                    
   1 -- State.                    
   );    
END CATCH 