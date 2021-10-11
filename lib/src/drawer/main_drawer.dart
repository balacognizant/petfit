import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:petfit/Firebase/data_repository.dart';
import 'package:petfit/src/app.dart';
import 'package:petfit/src/screens/add_pet.dart';
import 'package:petfit/src/screens/add_product.dart';
import 'package:petfit/src/screens/view_product.dart';
import '/Firebase/authentication_provider.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  Widget buildListTile(String title, IconData icon, VoidCallback? tapHandler) {
    return ListTile(
      // tileColor: Colors.black,
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
      onTap: tapHandler,
    );
  }

  Widget getSignOutList(BuildContext context) {
    if (PetUtility().isLoggedIn) {
      return buildListTile("Logout", Icons.logout, () {
        context.read<AuthenticationProvider?>()?.signOut();
        Navigator.pop(context);
      });
    }
    return SizedBox();
  }

  Widget getAddProductsList(BuildContext context) {
    if (PetUtility().isAdmin) {
      return buildListTile("Add Products", Icons.save_rounded, () {
        Navigator.popAndPushNamed(context, AddProducts.routeName);
      });
    }
    return SizedBox();
  }

  Widget getAddPetList(BuildContext context) {
    if (PetUtility().isAdmin) {
      return buildListTile('Add Pets', Icons.pets_rounded, () {
        Navigator.popAndPushNamed(context, AddPet.routeName);
      });
    }
    return SizedBox();
  }

  Widget getViewProductsList(BuildContext context) {
    if (PetUtility().isLoggedIn) {
      return buildListTile('View Products', Icons.list_sharp, () {
        Navigator.popAndPushNamed(context, ViewProducts.routeName);
      });
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Products"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            PetUtility().isAdmin
                ? Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.secondary),
                    child: Text(
                      "Admin User",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox(),
            buildListTile("Home", Icons.home_filled, () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => App()));
              //MaterialPageRoute(builder: (ctx) => App());
            }),
            Divider(),
            getAddProductsList(context),
            PetUtility().isAdmin ? Divider() : SizedBox(),
            getAddPetList(context),
            PetUtility().isAdmin ? Divider() : SizedBox(),
            getViewProductsList(context),
            PetUtility().isLoggedIn ? Divider() : SizedBox(),
            getSignOutList(context),
          ],
        ),
      ),
    );
  }
}
