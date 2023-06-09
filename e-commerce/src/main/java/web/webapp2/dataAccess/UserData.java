package web.webapp2.dataAccess;

import web.webapp2.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserData {
    private Connection conn;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public UserData(Connection conn) {
        this.conn = conn;

    }

    public User userLogin(String email, String password) {
        User user = null;
        try {
            final String qry = "SELECT * FROM users WHERE email=? AND password=?";
            pst = this.conn.prepareStatement(qry);


            pst.setString(1, email);
            pst.setString(2, password);

            rs = pst.executeQuery();

            if (rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("username"));
                user.setEmail(rs.getString("email"));
            }
        } catch (Exception e){
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        return user;
    }

    public Connection getConn() {
        return conn;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public PreparedStatement getPst() {
        return pst;
    }

    public void setPst(PreparedStatement pst) {
        this.pst = pst;
    }

    public ResultSet getRs() {
        return rs;
    }

    public void setRs(ResultSet rs) {
        this.rs = rs;
    }
}

