import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.file_upload))
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                width: MediaQuery.of(context).size.width,
                child: const Icon(
                  Icons.add_a_photo,
                  color: Colors.black45,
                )),
            const SizedBox(
              height: 8,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: <Widget>[
                TextField(
                  decoration: const InputDecoration(hintText: "Author Name"),
                  onChanged: (val) {
                    var authorName = val;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Title"),
                  onChanged: (val) {
                    var title = val;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Description"),
                  onChanged: (val) {
                    var description = val;
                  },
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
