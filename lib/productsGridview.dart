import 'package:flutter/material.dart';

class productGridview extends StatefulWidget {
  const productGridview({super.key});

  @override
  State<productGridview> createState() => _productGridviewState();
}

class _productGridviewState extends State<productGridview> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(""),
      
    );
  }
}