using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using SHS.BaseLayer;
using System.Text;
using SHS.BaseLayer.ActivityPages;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;

//namespace SHS.SmartCare
//{
public partial class Custom_CaminoIndividualServiceNote_WebPages_CaminoIndividualServiceNote : SHS.BaseLayer.ActivityPages.DocumentDataActivityPage
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{

        //}

        public override string PageDataSetName
        {
            get { return "DataSetCustomIServiceNote"; }
        }

        public override string[] TablesToBeInitialized
        {
            get { return new string[] { "CustomDocumentIndividualServiceNotes,CustomIndividualServiceNoteGoals,CustomIndividualServiceNoteObjectives" }; }
        }

        public override void ChangeInitializedDataSet(ref DataSet dataSetObject)
        {
            base.ChangeInitializedDataSet(ref dataSetObject);
        }
        public override void ChangeDataSetBeforeUpdate(ref DataSet dataSetObject)
        {
            base.ChangeDataSetBeforeUpdate(ref dataSetObject);
        }
        public override void BindControls()
        {

            if (BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"].Rows.Count > 0)
            {
                
HiddenFieldGoalsAndObjectives.Value = CreateGrid(BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteGoals"], BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["CustomIndividualServiceNoteObjectives"]);
            }
            else
            {
                HiddenFieldGoalsAndObjectives.Value = "No goals linked to procedure code.";
            }
        }

        public override System.Collections.Generic.List<CustomParameters> customInitializationStoreProcedureParameters
        {
            get
            {
                System.Collections.Generic.List<CustomParameters> t = new List<CustomParameters>();
                string ProcedureCodeId = BaseCommonFunctions.ScreenInfo.CurrentDocument.DocumentDataSet.Tables["Services"].Rows[0]["ProcedureCodeId"].ToString();
                t.Add(new CustomParameters("ProcedureCodeId", ProcedureCodeId));
                return t;
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
                        int Goalid = Convert.ToInt32(drItem["GoalId"].ToString());
                        string GoalActive = drItem["CustomGoalActive"].ToString();

                        sbHtml.Append("<table style='width:100%;'><tr valign='top'>");
                        if (GoalActive == "Y")
                        {
                            sbHtml.Append("<td align='left' class='checkbox_container' valign='top'  style='color:black;width:7%;'><input runat='server' id='CheckBoxGoal' goalidtohide= '" + Goalid + "' type='checkbox' style='cursor: default' checked='checked' onclick=\"javascript:CheckBoxJavascript('" + Goalid + "',this);\"/> <label for='CheckBoxGoal'>Goal #" + "&nbsp" + drItem["GoalNumber"] + ":" + "&nbsp" + "</label></td>");
                            sbHtml.Append("<td align='left' style='color:black;width:50%;'> <span id='spanGoalText_" + Goalid + "' class='form_label'>" + drItem["GoalText"] + "</span></td>");
                            //if (count == 0)
                            //{
                            //sbHtml.Append("<td align='left' style='color:black;padding-left:35px;padding-top:5px;width:40%;'><span  id='spanStatus_" + Goalid + "' class='form_label'>Status</span></td>");
                            //    count = 1;
                            //}
                            //else
                            //{
                            //    sbHtml.Append("<td align='left' style='color:black;padding-left:35px;padding-top:5px;width:40%;'><span visible='false'  id='spanStatus_" + Goalid + "' class='form_label'>Status</span></td>");
                            //}
                        }
                        else
                        {
                            sbHtml.Append("<td align='left' class='checkbox_container' valign='top' style='color:black;width:7%;'><input runat='server' id='CheckBoxGoal' goalidtohide= '" + Goalid + " ' style='cursor: default' type='checkbox' onclick=\"javascript:CheckBoxJavascript('" + Goalid + "',this);\"/> <label for='CheckBoxGoal'>Goal #" + "&nbsp" + drItem["GoalNumber"] + ":" + "&nbsp" + "</label></td>");
                            sbHtml.Append("<td align='left' style='color:black;width:50%;'> <span id='spanGoalText_" + Goalid + "' class='form_label'>" + drItem["GoalText"] + "</span></td>");
                            //if (count == 0)
                            //{
                            //sbHtml.Append("<td align='left' style='color:black;padding-left:35px;padding-top:5px;width:40%;'><span id='spanStatus_" + Goalid + "' class='form_label'>Status</span></td>");
                            //   count = 1;
                            //}
                            // else
                            //{
                            //    sbHtml.Append("<td align='left' style='color:black;padding-left:35px;padding-top:5px;width:40%;'><span visible='false' id='spanStatus_" + Goalid + "' class='form_label'>Status</span></td>");
                            // }
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

            //stDropDownHtml.Append("<div id='div_CustomIndividualServiceNoteObjectives_Status_" + id + "' style='width: 99%;'>");
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
            //stDropDownHtml.Append("</div>");
            return stDropDownHtml.ToString();
        }

    }
//}