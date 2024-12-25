package web.webapp2.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import web.webapp2.connection.DbConn;
import web.webapp2.dataAccess.OrderData;
import web.webapp2.dataAccess.UserData;
import web.webapp2.model.Cart;
import web.webapp2.model.Order;
import web.webapp2.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.time.LocalDate;

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

