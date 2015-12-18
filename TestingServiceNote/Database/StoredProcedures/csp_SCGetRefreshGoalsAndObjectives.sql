
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_SCGetRefreshGoalsAndObjectives]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_SCGetRefreshGoalsAndObjectives] 
GO

CREATE PROCEDURE [dbo].[csp_SCGetRefreshGoalsAndObjectives] @ClientID INT
	,@UserCode VARCHAR(50)
	,@ProcedureCodeId INT
AS
/*********************************************************************/
/* Stored Procedure: [csp_SCGetRefreshGoalsAndObjectives]   */
/*       Date              Author                  Purpose                   */
/*       09/07/2015        Akwinass                To Refresh Goals And Objectives tabls values (Task #195 in Valley Client Acceptance Testing Issues)*/
/*********************************************************************/
BEGIN
	BEGIN TRY
		DECLARE @LatestCarePlanDocumentVersionID INT

		SET @LatestCarePlanDocumentVersionID = (
				SELECT TOP 1 CurrentDocumentVersionId
				FROM Documents d
				JOIN DocumentCarePlans DCP ON d.CurrentDocumentVersionId = DCP.DocumentVersionId
				WHERE d.ClientId = @ClientID
					AND d.EffectiveDate <= convert(DATETIME, convert(VARCHAR, getDate(), 101))
					AND d.[Status] = 22
					AND d.DocumentCodeId = 1620 --Valley Care Plan  
					AND isNull(d.RecordDeleted, 'N') = 'N'
					AND ISNull(DCP.RecordDeleted, 'N') = 'N'
				ORDER BY d.EffectiveDate DESC
					,d.ModifiedDate DESC
				)

		SELECT DISTINCT 'CustomIndividualServiceNoteGoals' AS TableName
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
		JOIN CarePlanObjectives CO ON CG.CarePlanGoalId = co.CarePlanGoalId
		JOIN CarePlanPrescribedServiceObjectives PSO ON PSO.CarePlanObjectiveId = CO.CarePlanObjectiveId
		JOIN CarePlanPrescribedServices PS ON PS.CarePlanPrescribedServiceId = PSO.CarePlanPrescribedServiceId
		JOIN AuthorizationCodeProcedureCodes AP ON ap.AuthorizationCodeId = PS.AuthorizationCodeId
		WHERE ISNull(CG.RecordDeleted, 'N') = 'N'
			AND ISNull(CG.GoalActive, 'N') = 'Y'
			AND CG.DocumentVersionId = @LatestCarePlanDocumentVersionID
			AND AP.ProcedureCodeId = @ProcedureCodeId
		ORDER BY CG.GoalNumber

		SELECT DISTINCT 'CustomIndividualServiceNoteObjectives' AS TableName
			,- 1 AS DocumentVersionId
			,@UserCode AS CreatedBy
			,GETDATE() AS CreatedDate
			,@UserCode AS ModifiedBy
			,GETDATE() AS ModifiedDate
			,CDTPO.CarePlanGoalId AS GoalId
			,CDTPO.ObjectiveNumber AS ObjectiveNumber
			,CDTPO.AssociatedObjectiveDescription AS ObjectiveText
			,'N' AS CustomObjectiveActive
		FROM CarePlanObjectives AS CDTPO
		JOIN CarePlanPrescribedServiceObjectives PSO ON PSO.CarePlanObjectiveId = CDTPO.CarePlanObjectiveId
		JOIN CarePlanPrescribedServices PS ON PS.CarePlanPrescribedServiceId = PSO.CarePlanPrescribedServiceId
		JOIN AuthorizationCodeProcedureCodes AP ON ap.AuthorizationCodeId = PS.AuthorizationCodeId
		LEFT JOIN CarePlanGoals CDTPG ON CDTPO.CarePlanGoalId = CDTPG.CarePlanGoalId
			AND ISNULL(CDTPG.RecordDeleted, 'N') = 'N'
			AND ISNULL(CDTPG.GoalActive, 'Y') = 'Y'
		LEFT JOIN GlobalCodes GC ON GC.Code = (CASE WHEN CDTPO.ProgressTowardsObjective = 'D' THEN 'Deterioration'
											ELSE CASE WHEN CDTPO.ProgressTowardsObjective = 'N' THEN 'No Change'
											ELSE CASE WHEN CDTPO.ProgressTowardsObjective = 'S' THEN 'Some Improvement'
											ELSE CASE WHEN CDTPO.ProgressTowardsObjective = 'M' THEN 'Moderate Improvement'
											ELSE CASE WHEN CDTPO.ProgressTowardsObjective = 'A' THEN 'Achieved' END END END END END)
		WHERE ISNULL(CDTPO.RecordDeleted, 'N') = 'N'
			AND CDTPG.DocumentVersionId = @LatestCarePlanDocumentVersionID
			AND AP.ProcedureCodeId = @ProcedureCodeId
		ORDER BY CDTPO.ObjectiveNumber
	END TRY

	BEGIN CATCH
		DECLARE @Error VARCHAR(8000)

		SET @Error = CONVERT(VARCHAR, ERROR_NUMBER()) + '*****' + CONVERT(VARCHAR(4000), ERROR_MESSAGE()) + '*****' + ISNULL(CONVERT(VARCHAR, ERROR_PROCEDURE()), 'csp_SCGetRefreshGoalsAndObjectives') + '*****' + CONVERT(VARCHAR, ERROR_LINE()) + '*****' + CONVERT(VARCHAR, ERROR_SEVERITY()) + '*****' + CONVERT(VARCHAR, ERROR_STATE())

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








