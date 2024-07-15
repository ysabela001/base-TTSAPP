class Product {
  final String name;
  final num price;
  final String descripition;
  final String imagepath;
  int quantity;
  double totalPrice;

  Product({
    required this.name, 
    required this.price, 
    required  this.descripition, 
    required this.imagepath,
    this.quantity = 0,
    this.totalPrice = 0
  });

  //incremento quantidade
  void incrementQuantity() {
    quantity ++;
    totalPrice += price;
  }

  //drecemento quantidade
  void decrementQuantity() {
    quantity --;
    totalPrice -= price;
  }

  //quantidade inicial
  void initialQuantity() {
    quantity = 0;
    totalPrice = 0;
  }

}