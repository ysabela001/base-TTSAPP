import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';
import '../themes/theme_provider.dart';
import '../themes/themes.dart';
import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = context.watch<ThemeProvider>().themeData;
   final userLogedId = context.watch<UserProvider>().isAuthenticated;

    
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                    child: Icon(
                  Icons.shopping_bag,
                  size: 72,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),
              ),
              const SizedBox(height: 25),
              MyListTile(
                  text: "Comprar",
                  icon: Icons.home,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/shop_page");
                  }),
              MyListTile(
                  text: "Carrinho",
                  icon: Icons.shopping_cart,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/cart_page");
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                MyListTile(
                    text: userLogedId
                    ? "Sair"
                    : "Login",
                    icon: userLogedId ? Icons.logout : Icons.account_circle_outlined,
                    onTap: () {
                      if (userLogedId) {
                        Navigator.pop(context);
                        context.read<UserProvider>().signOut();
                      } else {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/login_page');
                      }
                    }),
                MyListTile(
                  text: theme == lightMode 
                  ? 'Modo Escuro' 
                  : 'Modo Claro',

                  icon: theme == lightMode 
                  ? Icons.toggle_off 
                  : Icons.toggle_on,

                  onTap: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
