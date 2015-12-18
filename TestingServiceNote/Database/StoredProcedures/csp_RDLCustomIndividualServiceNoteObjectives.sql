IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_RDLCustomIndividualServiceNoteObjectives]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_RDLCustomIndividualServiceNoteObjectives] --1630,4
GO

CREATE PROCEDURE [dbo].[csp_RDLCustomIndividualServiceNoteObjectives] (
@DocumentVersionId INT,
	@GoalId INT
	)
AS
/*********************************************************************/
/* Stored Procedure: [csp_RDLCustomIndividualServiceNoteObjectives]   */
/*       Date              Author                  Purpose                   */
/*       03/02/2015        Bernardin               To get CustomIndividualServiceNoteObjectives table vlaues */
/*********************************************************************/
BEGIN
	BEGIN TRY

SELECT   distinct CISNO.IndividualServiceNoteObjectiveId, 
           CISNO.DocumentVersionId, 
           CISNO.GoalId, 
           'Objective '+ CAST(CISNO.ObjectiveNumber AS varchar(6)) + ':' AS ObjectiveNumber , 
           CISNO.ObjectiveText, 
           CISNO.CustomObjectiveActive, 
           dbo.csf_GetGlobalCodeNameById(CISNO.Status) AS [Status]
FROM         CustomIndividualServiceNoteObjectives CISNO INNER JOIN
                      CustomIndividualServiceNoteGoals CISNG ON CISNO.GoalId = CISNG.GoalId AND  ISNULL(CISNO.RecordDeleted,'N')='N'
WHERE ISNULL(CISNO.RecordDeleted,'N')='N'
		AND CISNO.GoalId = @GoalId AND CISNO.DocumentVersionId = @DocumentVersionId
		
END TRY
	BEGIN CATCH
DECLARE @Error VARCHAR(8000)

		SET @Error = CONVERT(VARCHAR, ERROR_NUMBER()) + '*****' + CONVERT(VARCHAR(4000), ERROR_MESSAGE()) + '*****' + ISNULL(CONVERT(VARCHAR, ERROR_PROCEDURE()), 'csp_RDLCustomIndividualServiceNoteObjectives') + '*****' + CONVERT(VARCHAR, ERROR_LINE()) + '*****' + CONVERT(VARCHAR, ERROR_SEVERITY()) + '*****' + CONVERT(VARCHAR, ERROR_STATE())

		RAISERROR (
				@Error
				,-- Message text.
				16
				,-- Severity.
				1 -- State.
				);
	
	END CATCH
END