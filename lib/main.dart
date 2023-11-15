import 'package:flutter/material.dart';
import 'wordpress_service.dart';

void main() {
  runApp(MyApp());
}

class PostList extends StatelessWidget {
  final List<Map<String, dynamic>> posts;

  PostList(this.posts);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title']['rendered'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  post['excerpt']['rendered'],
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  final WordPressService service = WordPressService('https://www.addu.edu.ph/');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WordPress Flutter App'),
        ),
        body: FutureBuilder(
          future: service.fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> posts = snapshot.data as List<Map<String, dynamic>>;
              return PostList(posts);
            }
          },
        ),
      ),
    );
  }
}