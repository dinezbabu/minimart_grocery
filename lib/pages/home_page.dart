import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimart_grocery/services/api_service.dart';
import 'package:minimart_grocery/services/shared_service.dart';
import 'package:minimart_grocery/widgets/widget_home_categories.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Flutter+Node+JWT"),
    //     elevation: 0,
    //       actions: [
    //         IconButton(onPressed: (){
    //           SharedService.logout(context);
    //         }, icon: const Icon(
    //           Icons.logout,
    //           color: Colors.black,
    //         ))
    //       ],
    //   ),
    //   backgroundColor: Colors.grey[200],
    //   body: userProfile(),
    // );
    return Scaffold(
      body: Container(
        child: ListView(
          children: [const HomeCategoriesWidget()],
        ),
      ),
    );
  }

  Widget userProfile(){
    return FutureBuilder(
        future: APIService.getUserProfile(),
        builder: (BuildContext context, AsyncSnapshot<String> model){
          if(model.hasData){
            return Center(child: Text(model.data!),);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }
}
