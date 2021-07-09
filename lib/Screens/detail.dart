import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const DetailView(this.title, this.image, this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(
                this.image,
                fit: BoxFit.fill,
              ),
              height: 250,
              width: 500,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              this.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Text(
              this.description,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
