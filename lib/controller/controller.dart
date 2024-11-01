import 'dart:convert';

import 'package:flutter_chart/model/data_model.dart';
import 'package:flutter_chart/model/details_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  final RxString _detailsChart = RxString('');
  String get detailsChart => _detailsChart.value;
  setDetailsChart(String value) {
    _detailsChart.value = value;
  }

  final RxString _searchText = RxString('');
  String get searchText => _searchText.value;
  setSearchText(String value) {
    _searchText.value = value;
  }

  final RxList<DataModel> _dataList = RxList([]);
  List<DataModel> get dataList => _dataList.value;
  setDataList(List<DataModel> value) {
    _dataList.value = value;
  }

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;
  setIsLoading(bool value) {
    _isLoading.value = value;
  }

  Future<void> fetchData() async {
    setIsLoading(true);
    var apiUrl =
        'https://api.api-ninjas.com/v1/earningscalendar?ticker=$_searchText';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setDataList(
          DataModel.listFromJson(jsonDecode(utf8.decode(response.bodyBytes))));
      setIsLoading(false);
    } else {
      setDataList([]);
      setIsLoading(false);
    }
  }

  Future<void> fetchDetails(int index) async {
    setIsLoading(true);
    String dateString = dataList[index].pricedate ?? '';
    DateTime date = DateTime.parse(dateString);
    int year = date.year;

    int quarter = ((date.month - 1) ~/ 3) + 1;

    var apiUrl =
        'https://api.api-ninjas.com/v1/earningstranscript?ticker=$_searchText&year=$year&quarter=$quarter';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      DetailsModel model = DetailsModel.fromJson(jsonDecode(response.body));
      setDetailsChart(model.transcript ?? '');
      setIsLoading(false);
    }
  }
}
