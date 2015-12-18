IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_RDLCustomDocumentIndividualServiceNote]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_RDLCustomDocumentIndividualServiceNote] --1652
GO
    
CREATE PROCEDURE [dbo].[csp_RDLCustomDocumentIndividualServiceNote]  (@DocumentVersionId INT)    
AS    
/********************************************************************************                                                       
--      
-- Copyright: Streamline Healthcare Solutions      
/*    Date        Author            Purpose */
/*   03/02/2015   Bernardin         To get CustomDocumentIndividualServiceNoteGenerals,CustomDocumentIndividualServiceNoteDBTs  table vlaues */
    
*********************************************************************************/    
BEGIN
BEGIN TRY    

Declare @ProgramType Varchar(15)
set @ProgramType = (select Top 1 GlobalCodes.CodeName from Programs 
                    LEFT JOIN Services on  Services.ProgramId = PRograms.ProgramId
                    JOIN Documents on Documents.ServiceId = Services.ServiceId
                    left join GlobalCodes on GlobalCodes.GlobalCodeId = PRograms.ProgramType
                    where Documents.CurrentDocumentVersionId = @DocumentVersionId)	



--select @ProgramType= GlobalCodes.CodeName from Programs 
--                    LEFT JOIN Services on  Services.ProgramId = PRograms.ProgramId
--                    left join GlobalCodes on GlobalCodes.GlobalCodeId = PRograms.ProgramType

Declare @CustomGoalActive Char(1)
Declare @CustomObjectiveActive Char(1)

set @CustomGoalActive =(select CustomIndividualServiceNoteGoals.CustomGoalActive from CustomIndividualServiceNoteGoals
                         LEFT JOIN CustomDocumentIndividualServiceNotes on CustomDocumentIndividualServiceNotes.DocumentVersionId= CustomIndividualServiceNoteGoals.DocumentVersionId
                         where CustomIndividualServiceNoteGoals.DocumentVersionId =@DocumentVersionId
                         AND ISNULL(CustomIndividualServiceNoteGoals.RecordDeleted,'N')='N'
                         AND ISNULL(CustomDocumentIndividualServiceNotes.RecordDeleted,'N')='N')
                         
set @CustomObjectiveActive = (select CustomIndividualServiceNoteObjectives.CustomObjectiveActive from CustomIndividualServiceNoteObjectives
                         LEFT JOIN CustomDocumentIndividualServiceNotes on CustomDocumentIndividualServiceNotes.DocumentVersionId= CustomIndividualServiceNoteObjectives.DocumentVersionId
                         where CustomIndividualServiceNoteObjectives.DocumentVersionId =@DocumentVersionId
                          AND ISNULL(CustomIndividualServiceNoteObjectives.RecordDeleted,'N')='N'
                         AND ISNULL(CustomDocumentIndividualServiceNotes.RecordDeleted,'N')='N')                       
                         
	                                                                                                                                                                                        
                                                                                                                                                                                   

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
		case when Progress = 'Y' then 
		'Progress'
	     when Progress = 'N' then
		'Lack of Progress'
		END AS Progress,
		--LackOfProgress,
		ProgressComments,
		FollowUpNeeded,
		--@ProgramType as ProgramType
		--@ClientId as ClientId
		case  when @ProgramType = 'IDD Authority'  then
		'Outcomes' 
		when @ProgramType ='ECI' then
		'Outcomes' 
		when @ProgramType = 'IDD Provider' then
		'Strategy'
		else 'Goals'
		END AS ProgramType
		,@CustomGoalActive as CustomGoalActive
		,@CustomObjectiveActive as CustomObjectiveActive
 FROM CustomDocumentIndividualServiceNotes 
 WHERE ISNull(RecordDeleted, 'N') = 'N' AND DocumentVersionId = @DocumentVersionId  
  end try    
  
    
BEGIN CATCH    
 DECLARE @Error VARCHAR(8000)    
    
 SET @Error = Convert(VARCHAR, ERROR_NUMBER()) + '*****' + Convert(VARCHAR(4000), ERROR_MESSAGE()) + '*****' + isnull(Convert(VARCHAR, ERROR_PROCEDURE()), 'csp_RDLCustomDocumentIndividualServiceNote') + '*****' + Convert(VARCHAR, ERROR_LINE()) + '*****' + Convert(VARCHAR, ERROR_SEVERITY()) + '*****' + Convert(VARCHAR, ERROR_STATE())    
    
 RAISERROR (    
   @Error    
   ,-- Message text.                    
   16    
   ,-- Severity.                    
   1 -- State.                    
   );    
END CATCH 
END