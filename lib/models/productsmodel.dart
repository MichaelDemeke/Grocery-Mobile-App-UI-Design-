import 'package:flutter/material.dart';

class Products {

  String id;
  String name; 
  String original_price; 
  String group_price;
  String primary_image;
  String detail_images;
  bool favorite;

  Products({
    required this.id,
    required this.name,
    required this.original_price,
    required this.group_price,
    required this.primary_image,
    required this.detail_images,
    required this.favorite
  });
}