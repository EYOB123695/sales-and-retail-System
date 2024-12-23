<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Orders Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="includes/header.jsp"%>
    <style>
        .btn-img {
            border-radius: 10px;
        }
        .form-container {
            display: none;
        }
        .active-form {
            display: block;
        }
    </style>
</head>

<body>
  <%@include file="includes/navbar.jsp"%>

  <!DOCTYPE html>
  <html>
  <head>
      <title>Bootstrap Example</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  </head>
  <body>

  <% if (session.getAttribute("auth") != null) { %>
        <h2>user is not null</h2>
   <% } %>
  <div class="container">
        <div class="row">
            <div class="container">
                <p>
                    Total Price:
                    Choose Your Payment method:
                </p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <!-- Top container with image buttons -->
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3">
                                <button class="btn btn-img btn-img1" onclick="loadForm('form1')"><img src="products/cbeBirr.png"></button>
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-img btn-img2" onclick="loadForm('form2')"><img src="products/telebirr.jpg"></button>
                            </div>
                            <div class="col-md-3">
                                <button class="btn btn-img btn-img3" onclick="loadForm('form3')"><img src="products/amole.png"></button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Form container -->
                <div class="form-container active-form" id="form1">
              
                        <div class="form-group">
                            <label for="accountNumber">Account CBE</label>
                            <input type="text" class="form-control" id="accountNumber" aria-describedby="emailHelp" placeholder="Enter Account Number">
                        </div>
                        <div class="form-group">
                            <label for="CBEPassword">Password</label>
                            <input type="password" class="form-control" id="CBEPassword" placeholder="Enter Password">
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                  
                </div>


            </div>
        </div>
    </div>

    <script>
        function loadForm(formId) {
            const formContainers = document.getElementsByClassName("form-container");
            for (let i = 0; i < formContainers.length; i++) {
                formContainers[i].classList.remove("active-form");
            }
            const selectedForm = document.getElementById(formId);
            selectedForm.classList.add("active-form");
        }
    </script>


</body>
</html>
