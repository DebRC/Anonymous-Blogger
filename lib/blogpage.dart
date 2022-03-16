import 'package:blogapp/services/crud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_core/firebase_core.dart';

class BlogPage extends StatefulWidget {
  final String imgUrl, title, desc, authorName;

  const BlogPage(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.authorName,
      required this.desc})
      : super(key: key);

  @override
  State<BlogPage> createState() => _CreateBlogPage();
}

class _CreateBlogPage extends State<BlogPage> {
  CrudMethods crudMethods = CrudMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text(
              "Anonymous",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blogger",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: MediaQuery.of(context).size.height * 0.2,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: widget.imgUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 25,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              widget.authorName,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
