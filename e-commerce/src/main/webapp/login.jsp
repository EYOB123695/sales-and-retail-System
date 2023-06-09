<%@ page import="web.webapp2.model.Cart" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

%>
<html>
<head>
    <title>Zara Store Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
<%@include file="includes/navbar.jsp"%>
    <div class="container">
        <div class="card w-50 mx-auto my-5">
            <div class="card-header text-center">User Login</div>
            <div class="card-body">
                <form action="user-login" method="post">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" class="form-control" name="login-email"
                               placeholder="Enter your Email" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="login-password"
                               placeholder="*****" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
