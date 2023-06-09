package web.webapp2.dataAccess;

import web.webapp2.model.Cart;
import web.webapp2.model.Product;

import java.sql.*;
import java.util.*;

import static java.lang.Double.sum;

public class ProductData  {
    private Connection conn;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public ProductData(Connection conn, String query, PreparedStatement pst, ResultSet rs) {
        this.conn = conn;
        this.query = query;
        this.pst = pst;
        this.rs = rs;
    }

    public ProductData(Connection conn) {
        this.conn = conn;

    }

    @Override
    public String toString() {
        return "ProductData{" +
                "conn=" + conn +
                ", query='" + query + '\'' +
                ", pst=" + pst +
                ", rs=" + rs +
                '}';
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

    public ProductData() {
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<Product>();
        try {
            query = "SELECT * FROM products;";
            pst = this.conn.prepareStatement(query);
            rs = pst.executeQuery();
            
            while(rs.next()) {
                Product row = new Product();
                row.setName(rs.getString("name"));
                row.setId(rs.getInt("id"));
                row.setCategory(rs.getString("category"));
                row.setPrice(rs.getDouble("price"));
                row.setImage(rs.getString("image"));

                products.add(row);
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }
        return products;
    }

    Cart[] prods = new Cart[10];
    int count = 0;

    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        System.out.println("ProductData.getCartProducts()");

        List<Cart> products = new ArrayList<>();
        try {
            query = "SELECT * FROM products;";
            pst = this.conn.prepareStatement(query);
            rs = pst.executeQuery();

            while(rs.next()) {
                Cart row = new Cart();
                row.setName(rs.getString("name"));
                row.setId(rs.getInt("id"));
                row.setCategory(rs.getString("category"));


                double pr = rs.getDouble("price");
                row.setPrice(pr);


                products.add(row);
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }

        List<Cart> second = new ArrayList<>();

        cartList.forEach ( cart -> products.forEach(prod -> {
            if (cart.getId() == prod.getId()) {
                prod.setQuantity(cart.getQuantity());
                second.add(prod);
            }
        }));

        return second;
    }

    public double getTotalPrice(ArrayList<Cart> cartList) {


        System.out.println("ProductData.getTotalPrice()");
        double sum = 0;

        List<Cart> temp = new ArrayList<>();
        List<Double> nums = new ArrayList<>();

        try {
            if (!cartList.isEmpty()) {
                for (Cart c : cartList) {
                    query = "SELECT id,price FROM products;";
                    pst = this.conn.prepareStatement(query);
                    rs = pst.executeQuery();

                    while (rs.next()) {
                        Cart crt = new Cart();
                        int id = rs.getInt("id");
                        double prc = rs.getDouble("price");
                        int quantity = c.getQuantity();
                        crt.setId(id);
                        crt.setPrice(prc * quantity);
                        crt.setQuantity(quantity);

                        temp.add(crt);
                    }
                }

             for (Cart c : cartList) {

                    for (Cart t : temp) {
                        if (t.getId() == c.getId()) {
                            System.out.println("ProductData: cart with price: " + t.getPrice()
                            + " and quantity " + t.getQuantity() + " added.");
                            nums.add( t.getPrice());

                            break;
                        }
                    }
                }

                sum = nums.stream()
                        .mapToDouble(Double::doubleValue)
                        .sum();

             System.out.println("ProductData: current sum: " + sum);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sum;
    }

}









































