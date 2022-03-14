import 'package:blogapp/create_blog.dart';
import 'package:blogapp/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:blogapp/blogstyle/tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = CrudMethods();

  Stream? blogStream;

  Widget blogList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder(
              stream: blogStream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: (snapshot.data as QuerySnapshot).docs.length,
                        itemBuilder: (context, index) {
                          return BlogsTile(
                              imgUrl: (snapshot.data as QuerySnapshot)
                                  .docs[index]['imgUrl'],
                              title: (snapshot.data as QuerySnapshot)
                                  .docs[index]['title'],
                              authorName: (snapshot.data as QuerySnapshot)
                                  .docs[index]['authorName'],
                              desc: (snapshot.data as QuerySnapshot).docs[index]
                                  ['desc']);
                        })
                    : Container();
              })
        ],
      ),
    );
  }

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        blogStream = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        elevation: 0.0,
      ),
      body: blogList(),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateBlog()));
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
