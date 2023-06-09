package web.webapp2.dataAccess;

import web.webapp2.model.Order;

import java.sql.*;

public class OrderData {
    private Connection conn;
    private PreparedStatement pst;

    public OrderData(Connection conn) {
        this.conn = conn;

    }

    public boolean insertOrder(Order order) {
        boolean result = false;

        try {
            final String qry = "INSERT INTO Orders (ProductID, OrderDate, quantity) VALUES (?, ?, ?)";

            pst = conn.prepareStatement(qry);

            pst.setInt(1, order.getId());
            pst.setString(2, order.getDate());
            pst.setInt(3, order.getQuantity());

            pst.executeUpdate();
            result = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
