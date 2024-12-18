class RepaymentPlanModel {
  final String id;
  final String description;
  final double amount;
  final int duration;

  RepaymentPlanModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.duration,
  });

  factory RepaymentPlanModel.fromJson(Map<String, dynamic> json) {
    try {
      return RepaymentPlanModel(
        id: json['id'] ?? '',
        description: json['description'] ?? '',
        amount: json.containsKey('open_state') &&
                json['open_state']['body'] != null &&
                json['open_state']['body']['card'] != null
            ? (json['open_state']['body']['card']['max_range'] as num).toDouble()
            : 0.0,
        duration: json.containsKey('open_state') &&
                json['open_state']['body'] != null &&
                json['open_state']['body']['items'] != null &&
                json['open_state']['body']['items'].isNotEmpty
            ? _parseDuration(json['open_state']['body']['items'][0]['duration'])
            : 0,
      );
    } catch (e) {
      throw FormatException('Error parsing RepaymentPlanModel: $e');
    }
  }
  static int _parseDuration(dynamic duration) {
    if (duration is int) {
      return duration;
    } else if (duration is String) {
      final match = RegExp(r'(\d+)').firstMatch(duration);
      return match != null ? int.parse(match.group(0)!) : 0;
    } else {
      return 0;
    }
  }
}
