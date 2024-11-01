class DataModel {
  final String? pricedate;
  final String? ticker;
  final double? actualEps;
  final double? estimatedEps;
  final int? actualRevenue;
  final int? estimatedRevenue;

  DataModel({
    this.pricedate,
    this.ticker,
    this.actualEps,
    this.estimatedEps,
    this.actualRevenue,
    this.estimatedRevenue,
  });

  static List<DataModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => DataModel.fromJson(json)).toList();
  }

  DataModel.fromJson(Map<String, dynamic> json)
      : pricedate = json['pricedate'] as String?,
        ticker = json['ticker'] as String?,
        actualEps = json['actual_eps'] as double?,
        estimatedEps = json['estimated_eps'] as double?,
        actualRevenue = json['actual_revenue'] as int?,
        estimatedRevenue = json['estimated_revenue'] as int?;

  Map<String, dynamic> toJson() => {
        'pricedate': pricedate,
        'ticker': ticker,
        'actual_eps': actualEps,
        'estimated_eps': estimatedEps,
        'actual_revenue': actualRevenue,
        'estimated_revenue': estimatedRevenue
      };
}
