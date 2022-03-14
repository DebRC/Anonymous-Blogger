import 'package:blogapp/services/crud.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_core/firebase_core.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String authorName, title, desc;

  File? selectedImage;

  bool _isLoading = false;

  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image!.path);
    });
  }

  uploadBlog() async {
    await Firebase.initializeApp();
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

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
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.file_upload)),
          )
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: selectedImage != null
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 170,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
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
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: <Widget>[
                      TextField(
                        decoration:
                            const InputDecoration(hintText: "Author Name"),
                        onChanged: (val) {
                          authorName = val;
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(hintText: "Title"),
                        onChanged: (val) {
                          title = val;
                        },
                      ),
                      TextField(
                        decoration:
                            const InputDecoration(hintText: "Description"),
                        onChanged: (val) {
                          desc = val;
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
