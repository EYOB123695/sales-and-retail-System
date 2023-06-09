package web.webapp2.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import web.webapp2.connection.DbConn;
import web.webapp2.dataAccess.UserData;
import web.webapp2.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/user-login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()){
            out.println("<html><body>");
            out.println("<h1>" + "login servlet" + "</h1>");
            out.println("</body></html>");
            String email = request.getParameter("login-email");
            String password = request.getParameter("login-password");

            try {
                UserData uData = new UserData(DbConn.getConnection());
                User user = uData.userLogin(email, password);

                if (user == null) {


                } else {
                    request.getSession().setAttribute("auth", user);
                    response.sendRedirect("payment.jsp");

                }
            } catch (ClassNotFoundException | SQLException cnfe) {
                cnfe.printStackTrace();
            }

        }
    }
}