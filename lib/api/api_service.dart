import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/credit_item_model.dart';
import '../models/repayment_plan_model.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<CreditItemModel>> fetchCreditItems() async {
    try {
      final response = await http.get(Uri.parse('https://api.mocklets.com/p6764/test_mint'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['items'] != null && jsonResponse['items'] is List) {
          return List<CreditItemModel>.from(
            jsonResponse['items'].map((item) => CreditItemModel.fromJson(item))
          );
        } else {
          throw Exception('Items data is missing or invalid');
        }
      } else {
        throw Exception('Failed to load credit items, Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching credit items: $e');
    }
  }

   Future<List<RepaymentPlanModel>> getRepaymentPlans() async {
    try {
      final response = await http.get(Uri.parse('https://api.mocklets.com/p6764/test_mint'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['items'] != null && jsonResponse['items'] is List) {
          return List<RepaymentPlanModel>.from(
            jsonResponse['items'].map((item) => RepaymentPlanModel.fromJson(item))
          );
        } else {
          throw Exception('Plans data is missing or invalid');
        }
      } else {
        throw Exception('Failed to load repayment plans, Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching repayment plans: $e');
    }
  }
}

