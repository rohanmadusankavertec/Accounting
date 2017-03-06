<%-- 
    Document   : dashboard
    Created on : Nov 02, 2016, 12:31:21 AM
    Author     : Rohan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="template/header.jsp"%>
<%@include file="template/sidebar.jsp"%>
<script src="app/js/notAlert.js"></script>

<script type="text/javascript">
    loadData();
    function loadData() {
        $.ajax({
            type: "POST",
            url: "Report?action=dashboard",
            success: function(msg) {
                var reply = eval('(' + msg + ')');
                var arrLn1 = reply.des;
                for (var f = 0; f < arrLn1.length; f++) {
                    document.getElementById("employee").innerHTML=arrLn1[f].liblitity;
                    document.getElementById("debtors").innerHTML=arrLn1[f].debtors;
                    document.getElementById("income").innerHTML=arrLn1[f].income;
                    document.getElementById("Expense").innerHTML=arrLn1[f].expense;
                    document.getElementById("account").innerHTML=arrLn1[f].account;
//                    document.getElementById("completed").innerHTML=arrLn1[f].completed;
//                    document.getElementById("incompleted").innerHTML=arrLn1[f].incompleted;
//                    document.getElementById("hold").innerHTML=arrLn1[f].hold;
//                    document.getElementById("ongoing").innerHTML=arrLn1[f].ongoing;
                }
            }
        });
    }
</script>

<div class="">
    <div class="row top_tiles">
        
<!--        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-user"></i>
                </div>
                <div class="count" id="employee">0</div>
                <h3>Employees</h3>
                <p></p>
            </div>
        </div>-->

        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-user"></i>
                </div>
                <div class="count" id="employee">0</div>
                <h3>Creditors Amount</h3>
                <p></p>
            </div>
        </div>

        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-user"></i>
                </div>
                <div class="count" id="debtors">0</div>
                <h3>Debtors Amount</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-user"></i>
                </div>
                <div class="count" id="income">0</div>
                <h3>Income Amount</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tile-stats">
                <div class="icon"><i class="fa fa-user"></i>
                </div>
                <div class="count" id="Expense">0</div>
                <h3>Expense Amount</h3>
                <p></p>
            </div>
        </div>
        <div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12" >
            <div class="tile-stats" style="background-color: ">
                <div class="icon"><i class="fa fa-user"></i>
                </div>
                <div class="count" id="account">0</div>
                <h3>Number of Account</h3>
                <p></p>
            </div>
        </div>
        

        
    </div>




</div>

<script src="resources/js/echart/echarts-all.js"></script>
<script src="resources/js/echart/green.js"></script>
<script src="app/js/dashboard.js"></script>

<!-- footer content -->
<%@include file="template/footer.jsp"%>
