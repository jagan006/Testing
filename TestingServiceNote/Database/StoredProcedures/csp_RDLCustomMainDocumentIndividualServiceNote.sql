IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_RDLCustomMainDocumentIndividualServiceNote]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[csp_RDLCustomMainDocumentIndividualServiceNote] 
GO
    
CREATE PROCEDURE [dbo].[csp_RDLCustomMainDocumentIndividualServiceNote]  (@DocumentVersionId INT)    
AS    
/********************************************************************************                                                       
--      
-- Copyright: Streamline Healthcare Solutions      
/*    Date        Author            Purpose */
/*   03/02/2015   Bernardin         To get CustomDocumentIndividualServiceNoteGenerals,CustomDocumentIndividualServiceNoteDBTs  table vlaues */
    
*********************************************************************************/    
BEGIN TRY    

SELECT     D.ClientId,D.CurrentDocumentVersionId
FROM         CustomDocumentIndividualServiceNotes CDIS INNER JOIN
                      Documents D ON CDIS.DocumentVersionId = D.CurrentDocumentVersionId
                      WHERE CDIS.DocumentVersionId = @DocumentVersionId
  end try    
  
    
BEGIN CATCH    
 DECLARE @Error VARCHAR(8000)    
    
 SET @Error = Convert(VARCHAR, ERROR_NUMBER()) + '*****' + Convert(VARCHAR(4000), ERROR_MESSAGE()) + '*****' + isnull(Convert(VARCHAR, ERROR_PROCEDURE()), 'csp_RDLCustomMainDocumentIndividualServiceNote') + '*****' + Convert(VARCHAR, ERROR_LINE()) + '*****' + Convert(VARCHAR, ERROR_SEVERITY()) + '*****' + Convert(VARCHAR, ERROR_STATE())    
    
 RAISERROR (    
   @Error    
   ,-- Message text.                    
   16    
   ,-- Severity.                    
   1 -- State.                    
   );    
END CATCH 