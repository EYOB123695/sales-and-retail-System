<%@ page import="web.webapp2.model.User" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="web.webapp2.model.Cart" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="web.webapp2.model.Product" %>
<%@ page import="web.webapp2.dataAccess.ProductData" %>
<%@ page import="web.webapp2.connection.DbConn" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    System.out.println("Cart.jsp");
    User auth = (User) request.getSession().getAttribute("auth");

    if (auth != null) {
        request.setAttribute("auth", auth);
    }

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;


    if (cart_list != null) {
        ProductData pDataAccess;
        try {
            pDataAccess = new ProductData(DbConn.getConnection());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        cartProduct = pDataAccess.getCartProducts(cart_list);
        double total = pDataAccess.getTotalPrice(cart_list);

        request.setAttribute("cart-list", cartProduct);
        request.setAttribute("total", total);
    }
%>
<html>
<head>
    <title>Cart Page</title>
    <%@ include file="includes/header.jsp"%>

    <style>
        table tbody td{
            vertical-align: middle;
        }
        .btn-decre, .btn-incre {
            box-shadow: none;
            font-size: 25px;
        }
    </style>
</head>
<body>
<%@include file="includes/navbar.jsp" %>
<div class="container">
    <div class="d-flex py-3"><h3>Total Price: $${ (total > 0) ? total : 0 }</h3>
        <a class="mx-3 btn btn-primary" href="cart-checkout"> Check Out</a>
    </div>

    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Category</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>

        </tr>
        </thead>
        <tbody>
        <%
            if (cart_list != null) {

                for (Cart c : cartProduct) {
        %>

        <tr>
            <td> <%=c.getName() %> </td>
            <td> <%= c.getCategory() %> </td>
            <td> <%= c.getPrice()%> </td>
            <td>
                <form method="get" class="form-inline">
                    <input type="hidden" name="id" value="<%= c.getId()%>" class="form-input">
                    <div class="form-group d-flex justify-content-between">
                        <input type="text" name="quantity" class="form-control" value= <%= c.getQuantity() %> readonly>
                    </div>
                </form>
            </td>


        </tr>
               <% }
            } else {
                System.out.println("cart.jsp: the list is empty");
               }         %>

        </tbody>
    </table>
</div>

</body>
</html>
