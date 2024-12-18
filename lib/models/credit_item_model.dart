class CreditItemModel {
  final OpenState openState;
  final ClosedState closedState;
  final String ctaText;

  CreditItemModel({
    required this.openState,
    required this.closedState,
    required this.ctaText,
  });

  factory CreditItemModel.fromJson(Map<String, dynamic> json) {
    return CreditItemModel(
      openState: OpenState.fromJson(json['open_state']),
      closedState: ClosedState.fromJson(json['closed_state']),
      ctaText: json['cta_text'] ?? '',
    );
  }
}

class OpenState {
  final Body body;

  OpenState({required this.body});

  factory OpenState.fromJson(Map<String, dynamic> json) {
    return OpenState(
      body: Body.fromJson(json['body']),
    );
  }
}

class ClosedState {
  final Map<String, String> body;

  ClosedState({required this.body});

  factory ClosedState.fromJson(Map<String, dynamic> json) {
    return ClosedState(
      body: Map<String, String>.from(json['body'] ?? {}),
    );
  }
}

class Body {
  final String title;
  final String subtitle;
  final CardDetails? card;
  final List<Item> items;
  final String? footer;

  Body({
    required this.title,
    required this.subtitle,
    this.card,
    required this.items,
    this.footer,
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      card: json['card'] != null ? CardDetails.fromJson(json['card']) : null,
      items: (json['items'] as List?)
              ?.map((i) => Item.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      footer: json['footer'],
    );
  }
}

class CardDetails {
  final String header;
  final String description;
  final int maxRange;
  final int minRange;

  CardDetails({
    required this.header,
    required this.description,
    required this.maxRange,
    required this.minRange,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      header: json['header'] ?? '',
      description: json['description'] ?? '',
      maxRange: json['max_range'] ?? 0,
      minRange: json['min_range'] ?? 0,
    );
  }
}

class Item {
  final String? emi;
  final String? duration;
  final String title;
  final String subtitle;
  final String? tag;

  Item({
    this.emi,
    this.duration,
    required this.title,
    required this.subtitle,
    this.tag,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      emi: json['emi'],
      duration: json['duration'],
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      tag: json['tag'],
    );
  }
}
