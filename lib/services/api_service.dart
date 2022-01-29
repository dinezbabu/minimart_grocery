import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:minimart_grocery/config.dart';
import 'package:minimart_grocery/models/category.dart';
import 'package:minimart_grocery/models/login_request_model.dart';
import 'package:minimart_grocery/models/login_response_model.dart';
import 'package:minimart_grocery/models/register_request_model.dart';
import 'package:minimart_grocery/models/register_response_model.dart';
import 'package:minimart_grocery/services/shared_service.dart';

final apiService= Provider((ref)=> APIService()); //dependency injection;

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseModel(response.body));
      return true;
    }
    return false;
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    var url = Uri.http(Config.apiURL, Config.registerAPI);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    return registerResponseModel(response.body);
  }

  static Future<String> getUserProfile() async {
    var loginDetails= await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };
    var url = Uri.http(Config.apiURL, Config.userProfileAPI);
    var response = await client.get(url,
        headers: requestHeaders);
    if (response.statusCode == 200) {
      return response.body;
    }
    return "";
  }

   Future<List<Category>?> getCategories(page,pageSize) async{
    Map<String,String> requestHeaders={
      "Content-Type": "application/json"
    };

    Map<String,String> queryString={
      "page": page.toString(),
      "pageSize":pageSize.toString()
    };

    var url=Uri.http(Config.apiURL, Config.categoryAPI,queryString);

    var response =await client.get(url,headers: requestHeaders);

    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return categoriesFromJson(data["data"]);
    }else{
      return null;
    }
  }
}
