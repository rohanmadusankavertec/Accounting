<%-- 
    Document   : index
    Created on : Mar 25, 2016, 10:16:26 AM
    Author     : Sandun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">


        <title>Vertec Management System</title>

        <!-- Bootstrap core CSS -->

        <link href="resources/css/bootstrap.min.css" rel="stylesheet">

        <link href="resources/fonts/css/font-awesome.min.css" rel="stylesheet">
        <link href="resources/css/animate.min.css" rel="stylesheet">

        <!-- Custom styling plus plugins -->
        <link href="resources/css/custom.css" rel="stylesheet">
        <link href="resources/css/icheck/flat/green.css" rel="stylesheet">


        <script src="resources/js/jquery.min.js"></script>

        <!--[if lt IE 9]>
              <script src="../assets/js/ie8-responsive-file-warning.js"></script>
              <![endif]-->

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
                <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
              <![endif]-->

        
        
        
        
        
    </head>

    <body style="color:#73879C; background-color:#ccccff; ">

        <div class="">
            <a class="hiddenanchor" id="toregister"></a>
            <a class="hiddenanchor" id="tologin"></a>

            <div id="wrapper">
                <div id="login" class="animate form">
                    <section class="login_content">
                        <form action="Login" method="post">
                            <h1>Login Form</h1>
                            
                            <div>
                                <input type="text" class="form-control" placeholder="Username" name="username" />
                            </div>
                            <div>
                                <input type="password" class="form-control" placeholder="Password" name="password" />
                            </div>

                            <div class="col-md-3 col-sm-3 col-xs-3"></div>
                            <div class="col-md-3 col-sm-3 col-xs-3">
                                <center><input type="submit" value="Login" name="Login" class="btn btn-default submit"/></center>
                            </div>
                            <div class="clearfix"></div>
                            <div class="separator">
                                <div class="clearfix"></div>
                                <br />
                                <div>
                                    <h1><img src="resources/images/images.jpg" style="width: 350px; height: 110px;"/> Management System</h1>
                                    <p>©2016 All Rights Reserved. Vertec IT Solutions!</p>
                                </div>
                            </div>
                            <div style="margin-top: 10px" class="form-group">
                                <!-- Button -->
                                <%
                                    String success_message = (String) request.getAttribute("Success_Message");
                                    String error_message = (String) request.getAttribute("Error_Message");
                                %>
                                <div class="col-sm-12 controls ">
                                    <strong><font color="red">
                                        <% if (success_message != null) {
                                                out.println(success_message);
                                            }%>
                                        <% if (error_message != null) {
                                                out.println(error_message);
                                            }%>
                                        </font>
                                    </strong> 

                                </div>
                            </div>
                        </form>
                        <!-- form -->
                    </section>
                    <!-- content -->
                </div>

            </div>
        </div>

    </body>

</html>
