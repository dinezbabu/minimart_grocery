import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimart_grocery/pages/home_page.dart';
import 'package:minimart_grocery/services/shared_service.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

Widget _defaultHome= const LoginPage();

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // bool result= await SharedService.isLoggedIn();
  // if(result){
  //   _defaultHome= const HomePage();
  // }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Mart Grocery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/' : (context) => _defaultHome,
        '/home' : (context) => const HomePage(),
        '/login' : (context) => const LoginPage(),
        '/register' : (context) => const  RegisterPage(),
    },
    );
  }
}