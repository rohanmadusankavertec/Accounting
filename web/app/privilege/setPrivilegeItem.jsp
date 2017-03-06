<%-- 
    Document   : tableEdit
    Created on : Mar 21, 2016, 2:48:15 PM
    Author     : User
--%>
<%@page import="com.vertec.hibe.model.UserGroup"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@include file="../../template/header.jsp"%>
<%@include file="../../template/sidebar.jsp"%>
<!--<script src="app/js/privilege.js"></script>-->
<script src="app/js/notAlert.js"></script>

<script>
    
    $(document).on('click', '#viewDetials_tbl2 tbody tr', function () {
    document.getElementById('permissiondiv').className = 'x_panel tile';

    viewUserDetails2($(this).find('td:first').text().trim());
});

function viewUserDetails2(prgid) { // add user details to table
    $("#usermanage").empty();
    $("#privilegemanage").empty();
    $("#customermanage").empty();
    $("#servicemanage").empty()
    
    $("#upbtn").empty();

    var xmlHttp = getAjaxObject();
    xmlHttp.onreadystatechange = function ()
    {
        if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
        {
            var reply = eval('(' + xmlHttp.responseText + ')');
            console.log(reply);
            var arrLn1 = reply.jArr1.length;

            var permission = document.getElementById('allPutty');
            
            var usermanage = document.getElementById('usermanage');
            var privilegemanage = document.getElementById('privilegemanage');
            var customermanage = document.getElementById('customermanage');
            var servicemanage = document.getElementById('servicemanage');
            
            if (arrLn1 !== 0) {
                for (var f = 0; arrLn1 > f; f++) {
                    var prid = reply.jArr1[f].pid;
                    var pritId = reply.jArr1[f].piid;
                    var piname = reply.jArr1[f].piname;
                    var pname = reply.jArr1[f].pname;
                    var status = reply.jArr1[f].status;
                    var row = document.createElement("div");
                    row.className = "form-group";
                    var td1 = document.createElement("label");
                    td1.className = "control-label";
                    td1.innerHTML = piname;
                    td1.for = pritId;

                    var td2 = document.createElement("input");
                    td2.type = "checkbox";
                    td2.name = "permission";
                    td2.className = "pull-right";
                    if (status === "NO") {
                        td2.value = pritId;
                        td2.checked = false;
                    } else if (status === "YES") {
                        td2.value = pritId;
                        td2.checked = true;
                    }
                    if (prid === "1") {
                        row.appendChild(td1);
                        row.appendChild(td2);
                        usermanage.appendChild(row);
                    } else if (prid === "2") {
                        row.appendChild(td1);
                        row.appendChild(td2);
                        privilegemanage.appendChild(row);
                    } else if (prid === "3") {
                        row.appendChild(td1);
                        row.appendChild(td2);
                        customermanage.appendChild(row);
                    } else if (prid === "4") {
                        row.appendChild(td1);
                        row.appendChild(td2);
                        servicemanage.appendChild(row);
                    } 
                }
            }
            if (arrLn1 !== 0) {
                var row2 = document.getElementById('upbtn');
                var hidden = document.createElement("input");
                hidden.type = "hidden";
                hidden.value = prgid;
                hidden.name = "prgid";
                hidden.id = "prgid";
                var elem1 = document.createElement("span");
                elem1.id = "updateBtn";
                elem1.name = "updateBtn";
                elem1.type = "button";
                elem1.className = "btn btn-success glyphicon glyphicon-edit col-md-offset-5 col-lg-offset-5";

                row2.appendChild(hidden);
                row2.appendChild(elem1);
                permission.appendChild(row2);
            }
        }
    };
    xmlHttp.open("POST", "Privilege?action=SetPrivilegeItem&groupId=" + prgid, true);
    xmlHttp.send();
}

$(document).on('click', '#allPutty span', function () { //update user detailes

    var r = confirm("Are you Sure You want to Update this?");
    if (r === true) {

        var prgid = document.getElementById("prgid").value;

        var checkboxes = document.getElementsByName('permission');


        var checkboxesChecked = [];
        checkboxesChecked.push(prgid);
        for (var i = 0; i < checkboxes.length; i++) {
            // And stick the checked ones onto an array...
            if (checkboxes[i].checked) {
                checkboxesChecked.push(checkboxes[i].value);
            }
        }
        var xmlHttp = getAjaxObject();
        xmlHttp.onreadystatechange = function ()
        {
            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
            {
                var reply = xmlHttp.responseText;
                if (reply === "Success") {
                    nom_Success("Successfully Updated");
                    setTimeout("location.href = 'Privilege?action=LoadUserGroupsForPI';", 1500);
//                    window.location = "Privilege?action=LoadUserGroupsForPI";
                } else {
                    sm_warning("Privilege is Not Updated, Please Try again");
                }

            }
        };
        xmlHttp.open("POST", "Privilege?action=UpdatePriviledgeItem&dataArr=" + checkboxesChecked, true);
        xmlHttp.send();

    } else {

    }

});

</script>


<%if (ca.checkUserAuth("SET_PRIVILEGE_ITEM", group) != null) {%>

<div class="">
    <div class="page-title">
        <div class="title_left">
            <h3>
                Privileges Item Details
                <small>

                </small>
            </h3>
        </div>

        <div class="title_right">
            <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">

            </div>
        </div>
    </div>
    <div class="clearfix"></div>

    <br/>


    <div class="clearfix"></div>
    <%List<UserGroup> ugList = (List<UserGroup>) request.getAttribute("ugList");%>
    <div class="row">

        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">

                <div class="x_content">

                    <div class="col-lg-6">
                        <div class="x_panel tile">
                            <div class="x_title">
                                <h2>User Groups</h2>
                                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                    </li>

                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <table border="0" class="table table-hover table-responsive" id="viewDetials_tbl2">
                                    <%for (UserGroup ug : ugList) {%>
                                    <tr style="cursor: pointer;">
                                        <td><%=ug.getUserGroupId()%></td>
                                        <td><%=ug.getUserGroupName()%></td>
                                    </tr>
                                    <%}%>

                                </table>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-lg-12">



            <div class="hidden" id="permissiondiv">
                <div class="x_title">
                    <h2>Privileges</h2>
                    <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>

                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content" id="allPutty">
                    <div class="col-lg-4">
                        <div class="x_panel tile" style="height: 300px;">
                            <div class="x_title">
                                <h2>User Management</h2>

                                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                    </li>

                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>

                            <div class="x_content" id="usermanage">

                            </div>
                        </div>

                    </div>
                    <div class="col-lg-4">
                        <div class="x_panel tile" style="height: 300px;">
                            <div class="x_title">
                                <h2>Privilege Management</h2>

                                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                    </li>

                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>

                            <div class="x_content" id="privilegemanage">

                            </div>
                        </div>

                    </div>
                    <div class="col-lg-4">
                        <div class="x_panel tile" style="height: 600px;">
                            <div class="x_title">
                                <h2>Transaction Management</h2>

                                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                    </li>

                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content" id="customermanage">

                            </div>
                        </div>

                    </div>
                    <div class="col-lg-4">
                        <div class="x_panel tile" style="height: 400px;">
                            <div class="x_title">
                                <h2>Report Management</h2>

                                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                    </li>

                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>

                            <div class="x_content" id="servicemanage">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" id="upbtn"></div>
            </div>
        </div>
    </div>
</div>
<%} else {%>
<script type="text/javascript">
    window.location = 'error403.jsp';
</script>
<%}%>
<script>
    $(document).ready(function() {
        $('input.tableflat').iCheck({
            checkboxClass: 'icheckbox_flat-green',
            radioClass: 'iradio_flat-green'
        });
    });

    var asInitVals = new Array();
    $(document).ready(function() {
        var oTable = $('#example').dataTable({
            "oLanguage": {
                "sSearch": "Search all columns:"
            },
            "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [0]
                } //disables sorting for column one
            ],
            'iDisplayLength': 12,
            "sPaginationType": "full_numbers",
            "dom": 'T<"clear">lfrtip',
            "tableTools": {
                "sSwfPath": "${context}/resources/js/datatables/tools/swf/copy_csv_xls_pdf.swf"
            }
        });
        $("tfoot input").keyup(function() {
            /* Filter on the column based on the index of this element's parent <th> */
            oTable.fnFilter(this.value, $("tfoot th").index($(this).parent()));
        });
        $("tfoot input").each(function(i) {
            asInitVals[i] = this.value;
        });
        $("tfoot input").focus(function() {
            if (this.className == "search_init") {
                this.className = "";
                this.value = "";
            }
        });
        $("tfoot input").blur(function(i) {
            if (this.value == "") {
                this.className = "search_init";
                this.value = asInitVals[$("tfoot input").index(this)];
            }
        });
    });
</script>




<!-- footer content -->
<%@include file="../../template/footer.jsp"%>
