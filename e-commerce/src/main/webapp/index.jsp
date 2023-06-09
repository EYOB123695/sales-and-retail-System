<%@ page import="web.webapp2.connection.DbConn" %>
<%@ page import="web.webapp2.model.User" %>
<%@ page import="web.webapp2.dataAccess.ProductData" %>
<%@ page import="java.util.List" %>
<%@ page import="web.webapp2.model.Product" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="web.webapp2.model.Cart" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% User auth = (User) request.getSession().getAttribute("auth");


  if (auth != null) {
      request.setAttribute("auth", auth);
  }

    ProductData pd;
    try {
        pd = new ProductData(DbConn.getConnection());
    } catch (ClassNotFoundException | SQLException e) {
        throw new RuntimeException(e);
    }

    List<Product> products = pd.getAllProducts();

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

    if (cart_list != null) {
        request.setAttribute("cart-list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Welcome to Zara Store</title>
    <%@ include file="includes/header.jsp"%>
</head>
<body>

    <%@include file="includes/navbar.jsp"%>

    <div class="container">
        <div class="card-header my-3">All Products</div>
        <div class="row">
            <!-- iterate row with a loop-->
            <%

                if (!products.isEmpty()) {
                    System.out.println("index.jsp: list is not empty.");
                    for (Product p: products) { %>


            <div class="col-md-3 my-3">
                <!-- bootstrap default card-->
                <div class="card w-100" style="width: 18rem;">
                    <img class="card-img-top" src="products/<%= p.getImage()%>" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="name"> <%= p.getName() %></h5>
                        <h6 class="price">Price: <%= p.getPrice()%></h6>
                        <h6 class="category"> <%=p.getCategory() %></h6>
                        <div class="mt-3 d-flex justify-content-between">
                            <a href="add-to-cart?id=<%=p.getId() %>" class="btn btn-primary">Add to Cart</a>

                        </div>

                    </div>
                </div>
            </div>

            <%    }
              }
            %>

        </div>
    </div>
</body>
</html>