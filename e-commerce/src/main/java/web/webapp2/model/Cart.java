package web.webapp2.model;

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
