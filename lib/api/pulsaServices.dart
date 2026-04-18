import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pulsaPackage.dart';
import '../url/config.dart';

class PulsaService {
  final String baseUrl = AppConfig.baseUrl;

  Future<List<PulsaPackage>> getPulsa() async {
    final response = await http.get(
      Uri.parse('$baseUrl/pulsa'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map<PulsaPackage>((e) {
        return PulsaPackage(
          id: e['id'],
          price: int.parse(e['price'].toString()),
        );
      }).toList();
    } else {
      throw Exception('Failed to load pulsa');
    }
  }
}