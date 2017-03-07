<%-- 
    Document   : sidebar
    Created on : Mar 21, 2016, 2:25:42 PM
    Author     : User
--%>

<%@page import="com.vertec.util.CheckAuth"%>
<%@page import="com.vertec.hibe.model.UserGroupPrivilegeItem"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="com.vertec.hibe.model.SysUser"%>


<c:set var="context" value="${pageContext.request.contextPath}" />

<%    SysUser user = (SysUser) session.getAttribute("user");
    CheckAuth ca = new CheckAuth();
    int group = user.getUserGroupId().getUserGroupId();
%>

<div class="col-md-3 left_col">
    <div class="left_col scroll-view">
        <div class="navbar nav_title" style="border: 0;">
            <a href="${context}/dashboard.jsp" class="site_title"><img src="${context}/resources/images/images.jpg" style="width: 200px; height: 50px;"/></i> <span></span></a>
        </div>
        <div class="clearfix"></div>
        <br/>

        <!-- sidebar menu -->
        <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">

            <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                    <li><a href="${context}/dashboard.jsp"><i class="fa fa-home"></i> DashBoard </a>

                    </li>
                    <li><a><i class="fa fa-check"></i>Account<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <li><a href="${context}/Account?action=loadOfType">Add Account </a></li>
                        </ul>
                    </li>
                    <li><a><i class="fa fa-check"></i>Transaction<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("ADD_INCOME", group) != null) {%>
                            <li><a href="${context}/Income?action=loadIncomePage">Income </a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_EXPENSES", group) != null) {%>
                            <li><a href="${context}/Expense?action=loadExpensePage">Expenses</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_PURCHASE", group) != null) {%>
                            <li><a href="${context}/Purchase?action=ViewPurchase">Purchase</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_SELL", group) != null) {%>
                            <li><a href="${context}/Sell?action=ViewSell">Sell</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_COMPANY_LOAN", group) != null) {%>
                            <li><a href="${context}/AssetLoan?action=ViewLoan">Company Loan</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_OTHER_LOAN", group) != null) {%>
                            <li><a href="${context}/Liability?action=ViewLiability">Other Loan</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_INVESTMENT", group) != null) {%>
                            <li><a href="${context}/Investment?action=loadAccount">Investment</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_DRAWING", group) != null) {%>
                            <li><a href="${context}/Drawing?action=loadAccount">Drawings</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_FIXED_ASSET", group) != null) {%>
                            <li><a href="${context}/FixedAsset?action=ViewPurchase">Assets</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_FINANCE_TRANSFER", group) != null) {%>
                            <li><a href="${context}/FinanceTransfer?action=loadFinance">Finance Transfer</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("LOAN_PAYMENT", group) != null) {%>
                            <li><a href="${context}/LoanPay?action=loadLoanPayPage">Loan Payment</a></li>
                            <%}%>
                        </ul>
                    </li>
                    <li><a><i class="fa fa-check"></i>Reports<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("VIEW_GENERAL_JOURNAL", group) != null) {%>
                            <li><a href="${context}/Report?action=loadJournalEntries">General Journal Entries</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("VIEW_CASHBOOK", group) != null) {%>
                            <li><a href="${context}/Report?action=ViewAssets">Cashbook</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("VIEW_LEDGER_ACCOUNTS", group) != null) {%>
                            <li><a href="${context}/Report?action=toLedgerAccounts">Ledger Accounts</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("VIEW_PROFIT_LOSS", group) != null) {%>
                            <li><a href="${context}/Report?action=loadProfitLossPage">Profit & lost Statement</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("VIEW_TRIAL_BALANCE", group) != null) {%>
                            <li><a href="${context}/Report?action=ViewCreateTrialBalance">Trial Balance</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("VIEW_BALANCE_SHEET", group) != null) {%>
                            <li><a href="${context}/Report?action=ViewCreateBalanceSheet">Balance Sheet</a></li>
                            <%if (ca.checkUserAuth("VIEW_PROFIT_LOSS", group) != null) {%>
                            <li><a href="${context}/Report?action=loadIncomestatementPage">Profit & lost Statement</a></li>
                            <%}%>
                        <%}%>
                        </ul>
                    </li>
                    <li><a><i class="fa fa-user-secret"></i>User Management<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("ADD_USER", group) != null) {%>
                            <li><a href="${context}/app/users/userRegister.jsp">Add New User</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("VIEW_USERS", group) != null) {%>
                            <li><a href="${context}/User?action=ViewUsers">Manage Users</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_USER_GROUP", group) != null) {%>
                            <li><a href="${context}/app/users/createUserGroup.jsp">Create User Group</a></li>
                            <%}%>
                        </ul>
                    </li>
                    <li><a><i class="fa fa-check"></i>Privilege Management<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <%if (ca.checkUserAuth("ADD_PRIVILEGE", group) != null) {%>
                            <li><a href="${context}/Privilege?action=ViewPrivilege">Manage Privilege Groups</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("ADD_PRIVILEGE_ITEM", group) != null) {%>
                            <li><a href="${context}/Privilege?action=ForPrivilegeItem">Manage Privileges</a></li>
                            <%}%>
                            <%if (ca.checkUserAuth("SET_PRIVILEGE_ITEM", group) != null) {%>
                            <li><a href="${context}/Privilege?action=LoadUserGroupsForPI">Manage User Group Privileges</a></li>
                            <%}%>
                        </ul>
                    </li>

                </ul>
            </div>
        </div>
        <!-- /sidebar menu -->

        <!-- /menu footer buttons -->
        <div class="sidebar-footer hidden-small">

            <a data-toggle="tooltip" data-placement="top" title="Logout" href="${context}/Logout">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
            </a>
        </div>
        <!-- /menu footer buttons -->
    </div>
</div>


<div class="top_nav">

    <div class="nav_menu">
        <nav class="" role="navigation">
            <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>
            <div style="" class="nav navbar-nav">
                <!-- Button -->
                <%
                    String success_message = (String) request.getAttribute("Success_Message");
                    String error_message = (String) request.getAttribute("Error_Message");
                    if (success_message == null) {
                        success_message = (String) session.getAttribute("Success_Message");
                    }
                    if (error_message == null) {
                        error_message = (String) session.getAttribute("Error_Message");
                    }
                    request.getSession().removeAttribute("Error_Message");

                %>
                <div class="" id="mydiv">
                    <strong><font color="green">
                        <% if (success_message != null) {
                                out.println(success_message);
                            }%>
                        </font>
                    </strong> 
                    <strong><font color="red">
                        <% if (error_message != null) {
                                out.println(error_message);
                            }%>
                        </font>
                    </strong> 
                </div>
            </div>
            <%
                request.getSession().removeAttribute("Error_Message");
                request.getSession().removeAttribute("Success_Message");

            %>
            <ul class="nav navbar-right">
                <li class="">
                    <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <%out.print(user.getFirstName() + " " + user.getLastName());%>
                        <span class=" fa fa-angle-down"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                        <li><a href="${context}/app/users/editOwn.jsp">  Update Profile</a>
                        </li>
                        <li><a href="${context}/app/users/changePassword.jsp">  Change Password</a>
                        </li>

                        <li><a href="${context}/Logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                        </li>
                    </ul>
                </li>



            </ul>
        </nav>
    </div>

</div>

<!-- page content -->
<div class="right_col" role="main">