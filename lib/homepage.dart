import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_mobile_app_ui_design/productsGridview.dart';
import 'package:grocery_mobile_app_ui_design/productsdetail.dart';
import 'package:grocery_mobile_app_ui_design/models/productsmodel.dart';
import 'package:http/http.dart' as http;
class homepage extends StatefulWidget {
  const homepage(String token, {super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

 List<Products> products_list = [];

  String token = "eyJhbGciOiJQUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1YmQ3MWU0My0xNDYzLTQ4MjMtYjFlYy03MWRhMGYzNWI2ZDMiLCJuYmYiOjE2OTE4Mzk2NDJ9.z9o1rJdV7UYiGPqX_zeEirY_O-MwJRn9NP8u56CeKBt5okCIMCqmXpSFDzIBu2CV6RYO_2lSl0DfSXcucm1QD6gNVUwnI_jY3cGI6Bh6cuJqTeuNbxiYC4ospeDblgw-xgSdL4LS71csfzIh7FQarwN4FwiOJm0x33WHa2MMkz1ZawMZbs8BmYwlMeh_dOTICvW8QHQ1pyCuqAS8tT7rP8wvm4Z8ghgeiXgQ_RsBTpz3BXzUKMzTN9tgx-DA7lmA5mtaFLQz4JPcmcwcK1af6lFIc5O1OoaKuwG3ey9wMa_RHKUgKZeoW5eAEisWI7dJx2RP-FpyNiCMdKTMd-3W9A" ; 

Future<void> fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse("https://stagingapi.chipchip.social/v1/products"),
      headers: {'Authorization': 'Bearer $token',}
      );
      var data = jsonDecode(response.body);
      data.forEach((listprod) {
        Products p = Products(
            id: listprod['data']['id'],
            name: listprod['data']['name'],
            original_price: listprod['data']['single_deal']['original_price'],
            group_price: listprod['data']['group_deal']['group_price'],
            primary_image: listprod['data']['primary_image'],
            detail_images: listprod['data']['detail_images'],
            favorite: listprod['data']['favorite'],
            );
            setState(() {
                products_list.add(listprod);  
            });
      
      });
       print("Data is $data");
      print(response.body.runtimeType);
    } catch (e) {
      print("Error is caused is $e");
    }
}


@override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:RichText(text: TextSpan(
              children: [
                  TextSpan(text: "Good Morning"), 
                  TextSpan(
                    text: "Rafatul Islam ", 
                    style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                              ),
                  )
              ],
            ),
            ),),
      body: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 3/2, crossAxisSpacing: 10 ,mainAxisSpacing: 10
      ), 
      itemBuilder: (context, index) {
        Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  child: GridTile(child: Image.network(products_list[index].primary_image, fit: BoxFit.fitHeight),
                  
                  ),
                  onTap: () {       
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => productsdetail(),));
                  },
                ),
                Container(
                  child: GridTileBar(
                  backgroundColor: Colors.white,
                  title: Text(products_list[index].name, textAlign: TextAlign.left,),
                  subtitle: Text(products_list[index].original_price, textAlign: TextAlign.left,),
                  trailing:GestureDetector(
                    child: Text("Add to cart",style: TextStyle(color: Colors.red),),
                    onTap: () {
                      
                    },
                  )
                ),
                )
              ],
            ),
          IconButton(onPressed: () {
             Colors.redAccent.shade700; 
          }, 
          icon: Icon(Icons.favorite),)
          ],
        );
    
    
      }, 
      ),
    );
  }
}