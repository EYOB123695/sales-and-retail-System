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