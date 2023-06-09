package web.webapp2.model;

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
