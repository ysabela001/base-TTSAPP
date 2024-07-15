import 'package:flutter/material.dart';
import 'package:loja2/components/my_button.dart';
import 'package:loja2/components/my_drawer.dart';
import 'package:loja2/models/product.dart';
import 'package:provider/provider.dart';
import '../models/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeItemFromCart(BuildContext context, Product product){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: const Text('Deseja remover esse item do carrinho?'),
        actions: [
          //cancel
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          //confirm
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              context.read<Shop>().removeFromCart(product);
            },
            child: const Text('Confirmar'),
          )
        ],
      )
    );
  }

  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) => const AlertDialog(
        content: Text('Logo conctaremos esse app a uma solução de pagamento'),
      )
    );
  }

  //add item from cart
  void addItemToCart(BuildContext context, Product product) {
    context.read<Shop>().addToCart(product);
  }

  //decrease item from cart
  void decreaseItemFromCart(BuildContext context, Product product){
    context.read<Shop>().decrementFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    double totalBill = cart.fold<double>(
      0, ((previousValue, element) => previousValue + (element.totalPrice))
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Carrinho"),
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          //listener cart
          Expanded(
            child: cart.isEmpty
            ? const Center(child: Text("Seu carrinho está vazio"))
            : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];

                return ListTile(
                  leading: Image.network(item.imagepath),
                  title: Text(item.name),
                  subtitle: Text(item.price.toStringAsFixed(2)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //remove
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => removeItemFromCart(context, item)
                      ),

                      //decrease 
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: item.quantity >= 2
                        ? () => decreaseItemFromCart(context, item)
                        : () => removeItemFromCart(context,item),
                      ),

                      //txt
                      Text(item.quantity.toString()),

                      //add
                      IconButton(
                        onPressed: () => addItemToCart(context, item), 
                        icon: const Icon(Icons.add)
                        )
                    ],
                  ),
                );
              }
            )
          ),

          //botao pagamento
          Visibility(
            visible: cart.isNotEmpty,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Total R\$ ${totalBill.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    MyButton(
                      onTap: () => payButtonPressed(context),
                      child: const Text('Pagamento'),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}