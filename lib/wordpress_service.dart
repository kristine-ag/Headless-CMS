import 'dart:convert';
import 'package:http/http.dart' as http;

class WordPressService {
  final String baseUrl;

  WordPressService(this.baseUrl);

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/wp-json/wp/v2/posts'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((post) => post as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}