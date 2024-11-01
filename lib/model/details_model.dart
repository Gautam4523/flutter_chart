class DetailsModel {
  final String? transcript;

  DetailsModel({
    this.transcript,
  });

  DetailsModel.fromJson(Map<String, dynamic> json)
      : transcript = json['transcript'] as String?;

  Map<String, dynamic> toJson() => {'transcript': transcript};
}
