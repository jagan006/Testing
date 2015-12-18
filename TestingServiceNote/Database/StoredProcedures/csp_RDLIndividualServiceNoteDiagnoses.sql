/****** Object:  StoredProcedure [dbo].[csp_RDLIndividualServiceNoteDiagnoses]    Script Date: 04/22/2015 12:15:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_RDLIndividualServiceNoteDiagnoses]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_RDLIndividualServiceNoteDiagnoses]
GO

/****** Object:  StoredProcedure [dbo].[csp_RDLIndividualServiceNoteDiagnoses]    Script Date: 04/22/2015 12:15:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[csp_RDLIndividualServiceNoteDiagnoses] (
	@DocumentVersionId INT
	)
AS
/*********************************************************************/
/* Stored Procedure: [csp_RDLIndividualServiceNoteDiagnoses]   */
/*       Date              Author                  Purpose                   */
/*       03/02/2015        Bernardin               To get CustomIndividualServiceNoteDiagnoses table vlaues */
/*********************************************************************/
BEGIN
	BEGIN TRY
	
	DECLARE @ServiceId INT
	SELECT TOP 1 @ServiceId = ServiceId FROM Documents WHERE InProgressDocumentVersionId = @DocumentVersionId AND ISNULL(RecordDeleted,'N') = 'N'
	
	SELECT SD.DSMCode  AS ICD10Code
		,DD.DSMDescription AS ICDDescription
	FROM ServiceDiagnosis SD
	JOIN DiagnosisDSMDescriptions DD ON SD.DSMCode = DD.DSMCode
		AND SD.DSMNumber = DD.DSMNumber
	WHERE ISNULL(SD.RecordDeleted, 'N') = 'N'
		AND SD.ServiceId = @ServiceId

	UNION

	SELECT SD.DSMCode AS ICD10Code
		,DD.ICDDescription  AS ICDDescription
	FROM ServiceDiagnosis SD
	JOIN DiagnosisICDCodes DD ON SD.DSMCode = DD.ICDCode
	WHERE SD.DSMNumber IS NULL
		AND ISNULL(SD.RecordDeleted, 'N') = 'N'
		AND SD.ServiceId = @ServiceId
		
	UNION

	SELECT SD.ICD10Code  AS ICD10Code
		,DD.ICDDescription  AS ICDDescription
	FROM ServiceDiagnosis SD
	JOIN DiagnosisICD10Codes DD ON SD.DSMVCodeId = DD.ICD10CodeId
		AND SD.ICD10Code = DD.ICD10Code
	WHERE SD.DSMNumber IS NULL
		AND ISNULL(SD.RecordDeleted, 'N') = 'N'
		AND SD.ServiceId = @ServiceId
	
	END TRY
	BEGIN CATCH
DECLARE @Error VARCHAR(8000)

		SET @Error = CONVERT(VARCHAR, ERROR_NUMBER()) + '*****' + CONVERT(VARCHAR(4000), ERROR_MESSAGE()) + '*****' + ISNULL(CONVERT(VARCHAR, ERROR_PROCEDURE()), 'csp_RDLIndividualServiceNoteDiagnoses') + '*****' + CONVERT(VARCHAR, ERROR_LINE()) + '*****' + CONVERT(VARCHAR, ERROR_SEVERITY()) + '*****' + CONVERT(VARCHAR, ERROR_STATE())

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


