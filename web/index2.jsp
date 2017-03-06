<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Account Management Login &amp; Register Templates</title>

        <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/form-elements.css">
        <link rel="stylesheet" href="assets/css/style.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="assets/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">

<!--        <link href="${context}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${context}/resources/css/bootstrap-dialog.min.css" rel="stylesheet">

<link href="${context}/resources/fonts/css/font-awesome.min.css" rel="stylesheet">
<link href="${context}/resources/css/animate.min.css" rel="stylesheet">

 Custom styling plus plugins 
<link href="${context}/resources/css/custom.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${context}/resources/css/maps/jquery-jvectormap-2.0.3.css" />
<link href="${context}/resources/css/icheck/flat/green.css" rel="stylesheet" />
<link href="${context}/resources/css/floatexamples.css" rel="stylesheet" type="text/css" />
<link href="${context}/resources/css/icheck/flat/green.css" rel="stylesheet">
<link href="${context}/resources/css/datatables/tools/css/dataTables.tableTools.css" rel="stylesheet">
<link href="${context}/resources/css/style.css" rel="stylesheet">

<script src="${context}/resources/js/jquery.min.js"></script>
<script src="${context}/resources/js/jquery.leanModal.min.js"></script>
<script src="${context}/resources/js/nprogress.js"></script>
<script src="${context}/resources/js/bootstrap-dialog.min.js"></script>

<script type="text/javascript" src="${context}/resources/js/notify/pnotify.core.js"></script>
<script type="text/javascript" src="${context}/resources/js/notify/pnotify.buttons.js"></script>
<script type="text/javascript" src="${context}/resources/js/notify/pnotify.nonblock.js"></script>


<script src="${context}/resources/js/bootstrap.min.js"></script>

Ajax Object 
<script src="${context}/resources/js/vertec.js"></script>

bootstrap progress js 
<script src="${context}/resources/js/progressbar/bootstrap-progressbar.min.js"></script>
<script src="${context}/resources/js/nicescroll/jquery.nicescroll.min.js"></script>
icheck 
<script src="${context}/resources/js/icheck/icheck.min.js"></script>

<script src="${context}/resources/js/custom.js"></script>
Datatables 
<script src="${context}/resources/js/datatables/js/jquery.dataTables.js"></script>
<script src="${context}/resources/js/datatables/tools/js/dataTables.tableTools.js"></script>

pace 
<script src="${context}/resources/js/pace/pace.min.js"></script>

skycons 
<script src="${context}/resources/js/skycons/skycons.min.js"></script>
form validation 
<script src="${context}/resources/js/validator/validator.js"></script>
<script src="${context}/resources/js/bootstrap-dialog.min.js"></script>

<script src="${context}/resources/js/moment/moment.min.js"></script>
<script src="${context}/resources/js/chartjs/chart.min.js"></script>
        -->




        <script src="assets/js/jquery-1.11.1.min.js" type="text/javascript">
        </script>
        <script src="assets/js/jquery.leanModal.min.js" type="text/javascript">
        </script>

        <script type="text/javascript">
            $(document).ready(function(e) {

                $('#btn1').click(function() {

                    $('#middleline').hide();
                    $('#main,#context').show();
                    $('#logindivr').animate({
                        right: '180px'
                    });
                    $('#signupdivr').animate({
                        left: '250px'
                    });
                });
                $('#btn2').click(function(e) {
                    $('#main,#context').hide();
                    $('#middleline').show();
                    $('#signupdivr').animate({
                        right: '0px'
                    });
                    $('#logindivr').animate({
                        left: '0px'
                    });
                    
                });
            });
        </script>


    </head>

    <body>

        <!-- Top content -->
        <div class="top-content">

            <div class="inner-bg">
                <div class="container">

                    <div  class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong>Vertec</strong> Account Management </h1>
                            <div class="description">
                                <p>
                                    The best way to manage your accounts.  
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="row" >
                        <div class="col-sm-5" id="logindivr">

                            <div  class="form-box">
                                <div class="form-top">
                                    <div class="form-top-left">
                                        <h3>Login to our site</h3>
                                        <p>Enter username and password to log on:</p>
                                    </div>
                                    <div class="form-top-right">
                                        <i class="fa fa-lock"></i>
                                    </div>
                                </div>
                                <div class="form-bottom">
                                    <form role="form" action="" method="post" class="login-form">
                                        <div class="form-group">
                                            <label class="sr-only" for="form-username">Username</label>
                                            <input type="text" name="form-username" placeholder="Username..." class="form-username form-control" id="form-username">
                                        </div>
                                        <div class="form-group">
                                            <label class="sr-only" for="form-password">Password</label>
                                            <input type="password" name="form-password" placeholder="Password..." class="form-password form-control" id="form-password">
                                        </div>
                                        <button type="submit" class="btn">Sign in!</button>
                                    </form>
                                </div>
                            </div>

                            <div class="social-login">
                                <!--	                        	<h3>...or login with:</h3>-->
                                <!--	                        	<div class="social-login-buttons">
                                                                                <a class="btn btn-link-2" href="#">
                                                                                        <i class="fa fa-facebook"></i> Facebook
                                                                                </a>
                                                                                <a class="btn btn-link-2" href="#">
                                                                                        <i class="fa fa-twitter"></i> Twitter
                                                                                </a>
                                                                                <a class="btn btn-link-2" href="#">
                                                                                        <i class="fa fa-google-plus"></i> Google Plus
                                                                                </a>
                                                                        </div>-->
                            </div>

                        </div>

                        <div class="col-sm-1 middle-border" id="middleline"></div>
                        <div class="col-sm-1"></div>

                        <div class="col-sm-5"  id="signupdivr">

                            <div class="form-box">
                                <div class="form-top">
                                    <div class="form-top-left">
                                        <h3>Sign up now</h3>
                                        <p>Fill in the form below to get instant access:</p>
                                    </div>
                                    <div class="form-top-right">
                                        <i class="fa fa-pencil"></i>
                                    </div>
                                </div>
                                <div class="form-bottom">
                                    <form role="form" action="Admin.jsp" method="post" class="registration-form">
                                        <div class="form-group">
                                            <label class="sr-only" for="form-first-name">Company name</label>
                                            <input type="text" id="companyname" name="companyname" placeholder="Company name..." class="form-first-name form-control">
                                        </div>
                                        <div class="form-group">
                                            <label class="sr-only" for="form-last-name">Address</label>
                                            <input type="text" id="address" name="address" placeholder="Address..." class="form-last-name form-control">
                                        </div>
                                        <div class="form-group">
                                            <label class="sr-only" for="form-last-name">Contact No.</label>
                                            <input type="text" id="contactNo" name="contactNo" placeholder="Contact Number..." class="form-last-name form-control">
                                        </div>
                                        <div class="form-group">
                                            <label class="sr-only" for="form-email">Email</label>
                                            <input type="text" id="email" name="email" placeholder="Email..." class="form-email form-control">
                                        </div>

                                        <button type="submit" id="btn1" class="btn">Sign me up!</button><a href="Admin.jsp">hh</a>
                                    </form>
                                </div>

                            </div>

                        </div>
                    </div>

                </div>
            </div>

        </div>
        <!-- Footer -->

        <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->
        <div id="main" style="position:absolute; width:100%; height:100%; z-index:1; background-color: #000; opacity:0.6; display: none; top:0">
            <div id="context" class="form-box" style="position: absolute;z-index:2; display: none;width: 500px;margin-left: 30%; margin-right: auto; display:none; top:80px;border: 2px solid #ffffff;border-radius: 4px;" >
                <div class="form-top">
                    <div class="form-top-left">
                        <h3>User Details</h3>
                        <p>Fill in the form below to get instant access:</p>
                    </div>
                    <div class="form-top-right">
                        <i class="fa fa-pencil"></i>
                    </div>
                </div>
                <div class="form-bottom">
                    <form role="form" action="" method="post" class="registration-form">
                        <div class="form-group">
                            <label class="sr-only" for="form-first-name">First Name</label>
                            <input type="text" name="form-first-name" placeholder="First Name..." class="form-first-name form-control" id="form-first-name">
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="form-last-name">Last Name</label>
                            <input type="text" name="form-last-name" placeholder="Last Name..." class="form-last-name form-control" id="form-last-name">
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="form-last-name">E-mail</label>
                            <input type="text" name="form-last-name" placeholder="E-mail..." class="form-last-name form-control" id="form-last-name">
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="form-email">User Name</label>
                            <input type="text" name="form-email" placeholder="User Name..." class="form-email form-control" id="form-email">
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="form-email">Password</label>
                            <input type="password" name="form-email" placeholder="Password..." class="form-email form-control" id="form-email">
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="form-email">Confirm Password</label>
                            <input type="password" name="form-email" placeholder="Confirm Password..." class="form-email form-control" id="form-email">
                        </div>

                        <button type="submit" id="btn2" class="btn">Sign me up!</button>
                    </form>
                </div>

            </div>
        </div>

        <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->

        <!--             <div class="container">
                                <a id="modal_trigger" href="#modal" class="btn btn-success pull-right" style="width: 200px;">Add New Feature</a>
        
                                <div id="modal" class="popupContainer" style="display:none;">
                                    <header class="popupHeader">
                                        <span class="header_title">Add new Feature</span>
                                        <span class="modal_close"><i class="fa fa-times"></i></span>
                                    </header>
                                    <section class="popupBody">
                                         Register Form 
                                        <div class="user_register col-md-12 col-sm-12 col-xs-12">
                                            <form action="Quotation?action=SaveFeature" method="post">
                                                <div class="item form-group">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12" for="name">Enter Feature Name<span class="required"></span>
                                                    </label>
                                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                                        <input type="text" id="newfeature" name="newfeature" required="required" class="form-control col-md-7 col-xs-12">
                                                    </div>
                                                </div>   
                                                <br/>
                                                <br/>
                                                <div class="action_btns" style="padding-top: 30px;">
                                                    <div class="one_half last col-md-offset-3"><button type="button" onclick="AddFeature()" class="btn btn-success pull-right"><i class="fa fa-briefcase"></i>Save Feature</button></div>
                                                </div>
                                            </form>
                                        </div>
                                    </section>
                                </div>
                            </div> 
        -->




        <!-- Footer -->
        <footer>
            <div class="container">
                <div class="row">

                    <div class="col-sm-8 col-sm-offset-2">
                        <div class="footer-border"></div>
                        <p>©2016 All Rights Reserved. Vertec IT Solutions!</p> 

                    </div>

                </div>
            </div>
        </footer>

        <!-- Javascript -->

        <script type="text/javascript">

            $("#modal_trigger").leanModal({top: 200, overlay: 0.6, closeButton: ".modal_close"});
            $(function() {


                // Calling Register Form
                $("#modal_trigger").click(function() {
                    $(".user_register").show();
                    $(".header_title").text('Add New Feature');
                    return false;
                });
            });</script>

        <script src="assets/js/jquery-1.11.1.min.js" type="text/javascript">


        </script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.backstretch.min.js"></script>
        <script src="assets/js/scripts.js"></script>

        <!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->

    </body>

</html>