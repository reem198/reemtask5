class Product {
  int price;
  String name;
  String img;

  Product({
    required this.price,
    required this.name,
    required this.img,
  });

}

List<Product> product = [
  Product(img: "assets/img/reem.jpg", name: "Watch", price: 20000),
  Product(img: "assets/img/reem.jpg", name: "Watch1", price: 15000),
  Product(img: "assets/img/reem.jpg", name: "Watch2", price: 6000),
  Product(img: "assets/img/reem.jpg", name: "Watch3", price: 5000),
  Product(img: "assets/img/reem.jpg", name: "Watch4", price: 20000),
  Product(img: "assets/img/reem.jpg", name: "Watch5", price: 15000),
  Product(img: "assets/img/reem.jpg", name: "Watch6", price: 6000),
  Product(img: "assets/img/reem.jpg", name: "Watch7", price: 5000),

];
