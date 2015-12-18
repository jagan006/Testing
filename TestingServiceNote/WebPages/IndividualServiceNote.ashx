<%@ WebHandler Language="C#" Class="IndividualServiceNote" %>
using System;
using System.Collections;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using SHS.DataServices;
using System.Text;

public class IndividualServiceNote : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string functionName = string.Empty;
            string result = string.Empty;
            int ProcedureCodeId = 0;
            int DocumentVersionId = -1;
            string xml = string.Empty;
            DataSet dsCurrentDataSet = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Copy();
            if (context.Request.Form["FunctionName"] != null)
                functionName = context.Request.Form["FunctionName"].ToString();

            if (!functionName.IsNullOrWhiteSpace())
            {
                switch (functionName.Trim())
                {
                    case "RefreshGoalsAndObjectives":
                        {
                            SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].Rows.Clear();
                            SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Rows.Clear();
                            xml = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.GetXml();
                            result = xml + "$R1Y9N5ATNRD$" + "No goals linked to procedure code.";
                            if (dsCurrentDataSet.Tables.Contains("Services"))
                            {
                                if (dsCurrentDataSet.Tables["Services"].Rows.Count > 0)
                                {
                                    int.TryParse(dsCurrentDataSet.Tables["Services"].Rows[0]["ProcedureCodeId"].ToString(), out ProcedureCodeId);
                                    int.TryParse(dsCurrentDataSet.Tables["DocumentVersions"].Rows[0]["DocumentVersionId"].ToString(), out DocumentVersionId);
                                    DataSet dsGoalsandObjectives = new DataSet();
                                    SqlParameter[] _objectSqlParmeters = new SqlParameter[3];
                                    _objectSqlParmeters[0] = new SqlParameter("@ClientID", SHS.BaseLayer.BaseCommonFunctions.ApplicationInfo.Client.ClientId);
                                    _objectSqlParmeters[1] = new SqlParameter("@UserCode", SHS.BaseLayer.BaseCommonFunctions.ApplicationInfo.LoggedInUser.UserCode);
                                    _objectSqlParmeters[2] = new SqlParameter("@ProcedureCodeId", ProcedureCodeId);
                                    SqlHelper.FillDataset(Connection.ConnectionString, CommandType.StoredProcedure, "csp_SCGetRefreshGoalsAndObjectives", dsGoalsandObjectives, new string[] { "CustomIndividualServiceNoteGoals", "CustomIndividualServiceNoteObjectives" }, _objectSqlParmeters);

                                    if (dsGoalsandObjectives.Tables["CustomIndividualServiceNoteGoals"].Rows.Count > 0)
                                    {
                                        DataRow drNew;
                                        foreach (DataRow dt in dsGoalsandObjectives.Tables["CustomIndividualServiceNoteGoals"].Rows)
                                        {
                                            drNew = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].NewRow();
                                            SHS.BaseLayer.BaseCommonFunctions.InitRowCredentials(drNew);
                                            drNew["DocumentVersionId"] = DocumentVersionId;
                                            drNew["GoalId"] = dt["GoalId"];
                                            drNew["GoalNumber"] = dt["GoalNumber"];
                                            drNew["GoalText"] = dt["GoalText"];
                                            drNew["CustomGoalActive"] = dt["CustomGoalActive"];
                                            drNew["ProcedureCodeId"] = dt["ProcedureCodeId"];
                                            SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].Rows.Add(drNew);
                                        }

                                        foreach (DataRow dt in dsGoalsandObjectives.Tables["CustomIndividualServiceNoteObjectives"].Rows)
                                        {
                                            drNew = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"].NewRow();
                                            SHS.BaseLayer.BaseCommonFunctions.InitRowCredentials(drNew);
                                            drNew["DocumentVersionId"] = DocumentVersionId;
                                            drNew["GoalId"] = dt["GoalId"];
                                            drNew["ObjectiveNumber"] = dt["ObjectiveNumber"];
                                            drNew["ObjectiveText"] = dt["ObjectiveText"];
                                            drNew["CustomObjectiveActive"] = dt["CustomObjectiveActive"];
                                            SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Rows.Add(drNew);
                                        }
                                        xml = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.GetXml();
                                        result = xml + "$R1Y9N5ATNRD$" + CreateGrid(dsGoalsandObjectives.Tables["CustomIndividualServiceNoteGoals"], dsGoalsandObjectives.Tables["CustomIndividualServiceNoteObjectives"]);
                                    }
                                }
                            }
                            context.Response.Clear();
                            context.Response.Write(result);
                            context.Response.End();
                            break;
                        }
                    case "GetXMLGoalsAndObjectives":
                        {
                            xml = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.GetXml();
                            result = xml + "$R1Y9N5ATNRD$" + "No goals linked to procedure code.";
                            if (SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].Rows.Count > 0)
                                result = xml + "$R1Y9N5ATNRD$" + CreateGrid(SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"], SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"]);
                            context.Response.Clear();
                            context.Response.Write(result);
                            context.Response.End();
                            break;
                        }
                    case "GoalRefreshGoalsAndObjectives":
                        {
                            int ClientId = 0;
                            if (context.Request.Form["ProcedureCodeId"] != null)
                                int.TryParse(context.Request.Form["ProcedureCodeId"].ToString(), out ProcedureCodeId);
                            if (context.Request.Form["DocumentVersionId"] != null)
                                int.TryParse(context.Request.Form["DocumentVersionId"].ToString(), out DocumentVersionId);
                            if (context.Request.Form["ClientId"] != null)
                                int.TryParse(context.Request.Form["ClientId"].ToString(), out ClientId);

                            ArrayList drHash = new ArrayList();
                            DataRow[] drRemove = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].Select("DocumentVersionId=" + DocumentVersionId);
                            foreach (DataRow row in drRemove)
                            {
                                drHash.Add(row);
                            }

                            if (drHash.Count > 0)
                            {
                                foreach (DataRow row in drHash)
                                {
                                    SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].Rows.Remove(row);
                                }
                            }

                            drHash = new ArrayList();
                            drRemove = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Select("DocumentVersionId=" + DocumentVersionId);
                            foreach (DataRow row in drRemove)
                            {
                                drHash.Add(row);
                            }

                            if (drHash.Count > 0)
                            {
                                foreach (DataRow row in drHash)
                                {
                                    SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Rows.Remove(row);
                                }
                            }

                            xml = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.GetXml();
                            result = xml + "$R1Y9N5ATNRD$" + "No goals linked to procedure code.";

                            DataSet dsGoalsandObjectives = new DataSet();
                            SqlParameter[] _objectSqlParmeters = new SqlParameter[3];
                            _objectSqlParmeters[0] = new SqlParameter("@ClientID", ClientId);
                            _objectSqlParmeters[1] = new SqlParameter("@UserCode", SHS.BaseLayer.BaseCommonFunctions.ApplicationInfo.LoggedInUser.UserCode);
                            _objectSqlParmeters[2] = new SqlParameter("@ProcedureCodeId", ProcedureCodeId);
                            SqlHelper.FillDataset(Connection.ConnectionString, CommandType.StoredProcedure, "csp_SCGetRefreshGoalsAndObjectives", dsGoalsandObjectives, new string[] { "CustomIndividualServiceNoteGoals", "CustomIndividualServiceNoteObjectives" }, _objectSqlParmeters);

                            if (dsGoalsandObjectives.Tables["CustomIndividualServiceNoteGoals"].Rows.Count > 0)
                            {
                                DataRow drNew;
                                foreach (DataRow dt in dsGoalsandObjectives.Tables["CustomIndividualServiceNoteGoals"].Rows)
                                {
                                    drNew = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].NewRow();
                                    SHS.BaseLayer.BaseCommonFunctions.InitRowCredentials(drNew);
                                    drNew["DocumentVersionId"] = DocumentVersionId;
                                    drNew["GoalId"] = dt["GoalId"];
                                    drNew["GoalNumber"] = dt["GoalNumber"];
                                    drNew["GoalText"] = dt["GoalText"];
                                    drNew["CustomGoalActive"] = dt["CustomGoalActive"];
                                    drNew["ProcedureCodeId"] = dt["ProcedureCodeId"];
                                    SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].Rows.Add(drNew);
                                }

                                foreach (DataRow dt in dsGoalsandObjectives.Tables["CustomIndividualServiceNoteObjectives"].Rows)
                                {
                                    drNew = SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"].NewRow();
                                    SHS.BaseLayer.BaseCommonFunctions.InitRowCredentials(drNew);
                                    drNew["DocumentVersionId"] = DocumentVersionId;
                                    drNew["GoalId"] = dt["GoalId"];
                                    drNew["ObjectiveNumber"] = dt["ObjectiveNumber"];
                                    drNew["ObjectiveText"] = dt["ObjectiveText"];
                                    drNew["CustomObjectiveActive"] = dt["CustomObjectiveActive"];
                                    SHS.BaseLayer.BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Rows.Add(drNew);
                                }

                                DataTable dtRGoals = new DataTable();
                                dtRGoals = dsCurrentDataSet.Tables["CustomIndividualServiceNoteGoals"].Clone();
                                DataTable dtRObjectives = new DataTable();
                                dtRObjectives = dsCurrentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Clone();
                                DataRow[] drRGoals = dsCurrentDataSet.Tables["CustomIndividualServiceNoteGoals"].Select("DocumentVersionId = " + DocumentVersionId.ToString().Trim());
                                DataRow[] drRObjectives = dsCurrentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Select("DocumentVersionId = " + DocumentVersionId.ToString().Trim());
                                if (drRGoals.Length > 0)
                                    dtRGoals = drRGoals.CopyToDataTable();
                                if (drRObjectives.Length > 0)
                                    dtRObjectives = drRObjectives.CopyToDataTable();

                                DataSet dsNew = new DataSet();
                                dsNew.Tables.Add(dtRGoals);
                                dsNew.Tables.Add(dtRObjectives);
                                xml = dsNew.GetXml();
                                result = xml + "$R1Y9N5ATNRD$" + CreateGrid(dtRGoals, dtRObjectives);
                            }

                            context.Response.Clear();
                            context.Response.Write(result);
                            context.Response.End();
                            break;
                        }
                    case "GetGoalsAndObjectives":
                        {
                            int ServiceId = 0;
                            if (context.Request.Form["ServiceId"] != null)
                                int.TryParse(context.Request.Form["ServiceId"].ToString(), out ServiceId);

                            int DocumentId = 0;
                            DataRow[] drDocuments = dsCurrentDataSet.Tables["Documents"].Select("ServiceId = " + ServiceId.ToString().Trim());
                            if (drDocuments.Length > 0)
                            {
                                if (!string.IsNullOrEmpty(drDocuments[0]["DocumentId"].ToString()))
                                    int.TryParse(drDocuments[0]["DocumentId"].ToString(), out DocumentId);
                            }

                            DataRow[] drDocumentVersions = dsCurrentDataSet.Tables["DocumentVersions"].Select("DocumentId = " + DocumentId.ToString().Trim());
                            if (drDocumentVersions.Length > 0)
                            {
                                if (!string.IsNullOrEmpty(drDocumentVersions[0]["DocumentVersionId"].ToString()))
                                    int.TryParse(drDocumentVersions[0]["DocumentVersionId"].ToString(), out DocumentVersionId);
                            }

                            if (dsCurrentDataSet.Tables.Contains("CustomIndividualServiceNoteGoals"))
                            {
                                DataTable dtGoals = new DataTable();
                                dtGoals = dsCurrentDataSet.Tables["CustomIndividualServiceNoteGoals"].Clone();
                                DataTable dtObjectives = new DataTable();
                                dtObjectives = dsCurrentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Clone();
                                DataRow[] drGoals = dsCurrentDataSet.Tables["CustomIndividualServiceNoteGoals"].Select("DocumentVersionId = " + DocumentVersionId.ToString().Trim());
                                DataRow[] drObjectives = dsCurrentDataSet.Tables["CustomIndividualServiceNoteObjectives"].Select("DocumentVersionId = " + DocumentVersionId.ToString().Trim());
                                if (drGoals.Length > 0)
                                    dtGoals = drGoals.CopyToDataTable();
                                if (drObjectives.Length > 0)
                                    dtObjectives = drObjectives.CopyToDataTable();
                                if (dtGoals.Rows.Count == 0)
                                    result = "No goals linked to procedure code.";
                                else
                                    result = CreateGrid(dtGoals, dtObjectives);
                            }

                            context.Response.Clear();
                            context.Response.Write(result);
                            context.Response.End();
                            break;
                        }
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    public string CreateGrid(DataTable dt, DataTable dtObj)
    {
        int count = 0;
        StringBuilder sbHtml = new StringBuilder();
        if (dt != null)
        {
            if (dt.Rows.Count > 0)
            {
                sbHtml.Append("<div>");
                foreach (DataRow drItem in dt.Rows)
                {
                    if (!string.IsNullOrEmpty(drItem["GoalId"].ToString()))
                    {
                        int Goalid = Convert.ToInt32(drItem["GoalId"].ToString());
                        string GoalActive = drItem["CustomGoalActive"].ToString();

                        sbHtml.Append("<table style='width:100%;'><tr valign='top'>");
                        if (GoalActive == "Y")
                        {
                            sbHtml.Append("<td align='left' class='checkbox_container' valign='top'  style='color:black;width:7%;'><input runat='server' id='CheckBoxGoal' goalidtohide= '" + Goalid + "' type='checkbox' style='cursor: default' checked='checked' onclick=\"javascript:CheckBoxJavascript('" + Goalid + "',this);\"/> <label for='CheckBoxGoal'>Goal #" + "&nbsp" + drItem["GoalNumber"] + ":" + "&nbsp" + "</label></td>");
                            sbHtml.Append("<td align='left' style='color:black;width:50%;'> <span id='spanGoalText_" + Goalid + "' class='form_label'>" + drItem["GoalText"] + "</span></td>");
                            //sbHtml.Append("<td align='left' style='color:black;padding-left:35px;padding-top:5px;width:40%;'><span  id='spanStatus_" + Goalid + "' class='form_label'>Status</span></td>");

                        }
                        else
                        {
                            sbHtml.Append("<td align='left' class='checkbox_container' valign='top' style='color:black;width:7%;'><input runat='server' id='CheckBoxGoal' goalidtohide= '" + Goalid + " ' style='cursor: default' type='checkbox' onclick=\"javascript:CheckBoxJavascript('" + Goalid + "',this);\"/> <label for='CheckBoxGoal'>Goal #" + "&nbsp" + drItem["GoalNumber"] + ":" + "&nbsp" + "</label></td>");
                            sbHtml.Append("<td align='left' style='color:black;width:50%;'> <span id='spanGoalText_" + Goalid + "' class='form_label'>" + drItem["GoalText"] + "</span></td>");
                            //sbHtml.Append("<td align='left' style='color:black;padding-left:35px;padding-top:5px;width:40%;'><span id='spanStatus_" + Goalid + "' class='form_label'>Status</span></td>");
                        }
                        sbHtml.Append("</tr></table>");


                        if (dtObj.Rows.Count > 0)
                        {
                            DataView DataViewObj = new DataView(dtObj);
                            DataViewObj.RowFilter = "GoalId = " + Goalid;
                            sbHtml.Append("<div>");
                            if (DataViewObj.Count > 0)
                            {
                                foreach (DataRowView drobject in DataViewObj)
                                {
                                    if (!string.IsNullOrEmpty(drobject["IndividualServiceNoteObjectiveId"].ToString()))
                                    {
                                        int id = Convert.ToInt32(drobject["IndividualServiceNoteObjectiveId"].ToString());
                                        string CustomObjectiveActive = drobject["CustomObjectiveActive"].ToString();
                                        decimal ObjectiveNumber = Convert.ToDecimal(drobject["ObjectiveNumber"].ToString());
                                        int Status = Convert.ToInt32(drobject["Status"].ToString() == "" ? 0 : drobject["Status"]);

                                        sbHtml.Append("<table style='width:100%;'><tr>");
                                        if (CustomObjectiveActive == "Y")
                                        {
                                            sbHtml.Append("<td align='left' class='checkbox_container'  style='color:black;padding-left:35px;padding-top:5px;width:60%;'><input runat='server' GoalID='" + Goalid + "' type='checkbox' style='cursor: default' id='CheckBoxObjective' label='lblobj' ObjectiveNumber='" + ObjectiveNumber + "' checked='checked' onclick=\"javascript:CheckBoxJavascriptObj('" + ObjectiveNumber + "',this);\"/> <label for='CheckBoxObjective'> Objective " + "&nbsp" + drobject["ObjectiveNumber"] + ":" + "&nbsp" + "&nbsp" + drobject["ObjectiveText"] + "</label></td>");
                                        }
                                        else
                                        {
                                            if (GoalActive == "Y")
                                            {
                                                sbHtml.Append("<td align='left' class='checkbox_container' style='color:black;padding-left:35px;padding-top:5px;width:60%;'><input GoalID='" + Goalid + "' runat='server' type='checkbox' style='cursor: default' id='CheckBoxObjective'  label='lblobj' ObjectiveNumber='" + ObjectiveNumber + "' onclick=\"javascript:CheckBoxJavascriptObj('" + ObjectiveNumber + "',this);\"/><label for='CheckBoxObjective'> Objective " + "&nbsp" + drobject["ObjectiveNumber"] + ":" + "&nbsp" + "&nbsp" + drobject["ObjectiveText"] + "</label></td>");
                                            }
                                            else
                                            {
                                                sbHtml.Append("<td align='left' class='checkbox_container' style='color:black;padding-left:35px;padding-top:5px;width:60%;'><input GoalID='" + Goalid + "' runat='server' type='checkbox' style='cursor: default' id='CheckBoxObjective' disabled = 'disabled' label='lblobj' ObjectiveNumber='" + ObjectiveNumber + "' onclick=\"javascript:CheckBoxJavascriptObj('" + ObjectiveNumber + "',this);\"/><label for='CheckBoxObjective'> Objective " + "&nbsp" + drobject["ObjectiveNumber"] + ":" + "&nbsp" + "&nbsp" + drobject["ObjectiveText"] + "</label></td>");
                                            }
                                        }
                                        sbHtml.Append("</tr></table>");
                                    }
                                }
                            }

                            else
                            {
                                sbHtml.Append("<table><tr>");
                                sbHtml.Append("<td align='left' class='' style='color:black;padding-left:35px;padding-top:5px'><input type='text' style='cursor: default; display:none' id=''/><label> No Objectives </label></td>");
                                sbHtml.Append("</tr></table>");
                            }
                            sbHtml.Append("</div>");
                        }
                        else
                        {
                            sbHtml.Append("<div>");
                            sbHtml.Append("<table'><tr>");
                            sbHtml.Append("<td align='left' class='' style='color:black;padding-left:85px;padding-top:5px'><input type='text' style='cursor: default; display:none' id=''/><label style='padding-left:22px;padding-top:5px'> No Objectives </label></td>");
                            sbHtml.Append("</tr></table>");
                            sbHtml.Append("</div>");
                        }
                    }

                }
                sbHtml.Append("</div>");
            }
        }
        sbHtml.Append("</table>");
        return sbHtml.ToString();
    }

    public string CreateDropDown(int value, int id, int goalid, string GoalActive)
    {
        StringBuilder stDropDownHtml = new StringBuilder();
        DataView dataViewCodeName = new DataView();
        DataTable dtStatusDropDown = new DataTable();
        if (SHS.BaseLayer.SharedTables.ApplicationSharedTables.GlobalCodes != null)
        {
            dataViewCodeName = new DataView(SHS.BaseLayer.SharedTables.ApplicationSharedTables.GlobalCodes);
            dataViewCodeName.RowFilter = "Category='XGOALOBJECTIVESTATUS' and  Active='Y' and ISNULL(RecordDeleted,'N')<>'Y'";
            dataViewCodeName.Sort = "SortOrder,CodeName";
        }
        dtStatusDropDown = dataViewCodeName.ToDataTable();
        if (GoalActive == "Y")
        {
            stDropDownHtml.Append("<select id='DropDownList_CustomIndividualServiceNoteObjectives_Status_" + id + "' ObjGoalID='" + goalid + "' class='form_dropdown' bindautosaveevents='False' style='width: 60%;' onchange='UpdateStatus(this)'>");
        }
        else
        {
            stDropDownHtml.Append("<select id='DropDownList_CustomIndividualServiceNoteObjectives_Status_" + id + "' disabled = 'disabled' ObjGoalID='" + goalid + "' class='form_dropdown' bindautosaveevents='False' style='width: 60%;' onchange='UpdateStatus(this)'>");
        }
        stDropDownHtml.Append("<option value=''></option>");
        for (int GlobalCodeCount = 0; GlobalCodeCount < dtStatusDropDown.Rows.Count; GlobalCodeCount++)
        {
            if (value == Convert.ToInt32(dtStatusDropDown.Rows[GlobalCodeCount]["GlobalCodeId"]))
            {
                stDropDownHtml.Append("<option value= " + dtStatusDropDown.Rows[GlobalCodeCount]["GlobalCodeId"].ToString() + " selected='selected'>");
            }
            else
            {
                stDropDownHtml.Append("<option value= " + dtStatusDropDown.Rows[GlobalCodeCount]["GlobalCodeId"].ToString() + ">");
            }
            stDropDownHtml.Append(dtStatusDropDown.Rows[GlobalCodeCount]["CodeName"].ToString() + "</option>");
        }

        stDropDownHtml.Append("</select>");
        return stDropDownHtml.ToString();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}