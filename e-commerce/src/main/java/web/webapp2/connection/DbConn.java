package web.webapp2.connection;

import java.sql.*;

public class DbConn {
    private static Connection conn = null;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {


            try {
                Driver mysql = new com.mysql.cj.jdbc.Driver();
                DriverManager.registerDriver(mysql);
                conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/zara_store",
                        "myuser",
                        "dechasa1234");
                System.out.println("DbConn.java: Database connection established");
            } catch (Exception e) {
                e.getMessage();
            }


        return conn;
    }


}

