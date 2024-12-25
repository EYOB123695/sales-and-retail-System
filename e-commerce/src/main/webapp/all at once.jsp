
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

package web.webapp2.servlets;
import jakarta.servlet.http.HttpSession;
import web.webapp2.dataAccess.ProductData;
import web.webapp2.model.Cart;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "AddToCartServlet", value = "/add-to-cart")
public class AddToCartServlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
response.setContentType("text/html;charset=UTF-8");

try(PrintWriter out = response.getWriter()) {
ArrayList<Cart> cartList = new ArrayList<>();

int id = Integer.parseInt(request.getParameter("id"));

ProductData pd = new ProductData();
Cart cr = new Cart();
cr.setId(id);
cr.setQuantity(1);
//pd.setCartAttributes(cr);

System.out.println("AddToCartServlet: Current cart object: " + cr);
// create a session
HttpSession session = request.getSession();
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

System.out.println("AddToCartServlet: session cartlist attribute: " + cart_list);

if (cart_list == null) {
// means no session attribute with name "cart-list"
// so no product in cart
cartList.add(cr);
session.setAttribute("cart-list", cartList);
response.sendRedirect("index.jsp");
System.out.println("AddToCartServlet: " + cartList);

} else {
// cartList equals to the cart list of the current session.
cartList = cart_list;
boolean exists = false;
for (Cart c: cart_list) {
// check if cart's id equals with the id that is passed through URL.
// carts's id is c.getId(), the id passed thru URL is id.
if (c.getId() == id)
exists = true;
out.print("<h3 style=\'color:crimson; text-align:center\'>Item already exists in Cart.<a href=\'cart.jsp\'>Go to cart page.</a>");


}
if (!exists) {
cartList.add(cr);
response.sendRedirect("index.jsp");
}
}

}
}
}

@WebServlet(name = "CheckoutServlet", value = "/cart-checkout")
public class CheckoutServlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
try (PrintWriter out = response.getWriter()) {
out.println("checkout servlet");
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
LocalDate date = LocalDate.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

// retrieve cart products
ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");

// user authentication
User auth = (User) request.getSession().getAttribute("auth");

if (auth == null)
System.out.println("Checkout servlet: User is null.");

if (cart_list != null && auth != null) {

for (Cart cart : cart_list) {
Order order = new Order();
order.setId(cart.getId());
order.setUid(auth.getId());
order.setQuantity(cart.getQuantity());
String formattedDate = date.format(formatter);
order.setDate(formattedDate);

OrderData orderData = new OrderData(DbConn.getConnection());
boolean inserted = orderData.insertOrder(order);

if (!inserted)
break;

}

cart_list.clear();
response.sendRedirect("index.jsp");

} else {
if (auth == null)
response.sendRedirect("login.jsp");
else
response.sendRedirect("index.jsp");
}
} catch (Exception e) {
e.printStackTrace();
}
}

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

}
}


public class Cart extends Product{
private int quantity;

public Cart() {

}

public Cart(int id, String name, String category, double price, int quantity) {
this.setId(id);
this.setName(name);
this.setCategory(category);
this.setPrice(price);
this.setQuantity(quantity);
}

public int getQuantity() {
return quantity;
}

public void setQuantity(int quantity) {
this.quantity = quantity;
}

public void increment() {
this.quantity++;
}

public void decrement() {
this.quantity--;
}
}


public class Order {

private int id;
private int Uid;
private int quantity;
private String date;

public Order() {
}

public int getId() {
return id;
}

public void setId(int id) {
this.id = id;
}

public int getUid() {
return Uid;
}

public void setUid(int uid) {
Uid = uid;
}

public int getQuantity() {
return quantity;
}

public void setQuantity(int quantity) {
this.quantity = quantity;
}

public String getDate() {
return date;
}

public void setDate(String date) {
this.date = date;
}
}

public class Product {
private String name;
private int id;
private String category;
private double price;
private String image;

private int quantity;


@Override
public String toString() {
return "Product{" +
"id=" + id +
", category='" + category + '\'' +
", price='" + price + '\'' +
", image='" + image + '\'' +
'}';
}

public Product() {
}

public Product(int id, String category, double price, String image) {
this.id = id;
this.category = category;
this.price = price;
this.image = image;
this.quantity = 0;
}

public String getName() {
return name;
}

public void setName(String name) {
this.name = name;
}

public int getId() {
return id;
}

public int setId(int id) {
this.id = id;
return 0;
}

public String getCategory() {
return category;
}

public String setCategory(String category) {
this.category = category;
return "category";
}

public double getPrice() {
return price;
}

public void setPrice(double price) {

this.price = price;
}

public String getImage() {
return image;
}

public void setImage(String image) {
this.image = image;
}

public int getQuantity() {
return quantity;
}

public void setQuantity(int quantity) {
this.quantity = quantity;
}



}

package web.webapp2.model;

public class User {
private int id;
private String name;
private String email;
private String password;

public User() {
}
public User(int id, String name, String email, String password) {
this.id = id;
this.name = name;
this.email = email;
this.password = password;
}

@Override
public String toString() {
return "User{" +
"id=" + id +
", name='" + name + '\'' +
", email='" + email + '\'' +
", password='" + password + '\'' +
'}';
}

public int getId() {
return id;
}

public void setId(int id) {
this.id = id;
}

public String getName() {
return name;
}

public void setName(String name) {
this.name = name;
}

public String getEmail() {
return email;
}

public void setEmail(String email) {
this.email = email;
}

public String getPassword() {
return password;
}

public void setPassword(String password) {
this.password = password;
}
}