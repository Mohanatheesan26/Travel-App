import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fly_app/Screens/detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference travels =
      FirebaseFirestore.instance.collection("travels");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Travel App'),
          centerTitle: true,),
      body: StreamBuilder(
        stream: travels.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasError) {
            print(streamSnapshot.error);
          }
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 900),
                            pageBuilder: (_, __, ___) => DetailView(
                                documentSnapshot['title'],
                                documentSnapshot['image'],
                                documentSnapshot['description']),
                            settings:
                                RouteSettings(arguments: documentSnapshot)));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Image.network(
                              documentSnapshot['image'],
                              fit: BoxFit.cover,
                            ),
                            height: 200,
                            width: 500,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            documentSnapshot['title'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 15),
                          Text(documentSnapshot['shortDetail'],
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
