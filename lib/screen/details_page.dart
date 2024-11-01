import 'package:flutter/material.dart';
import 'package:flutter_chart/controller/controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DetailsPage extends StatefulWidget {
  final int index;
  const DetailsPage({super.key, required this.index});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final Controller controller = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    initCall();
  }

  initCall() {
    print(widget.index);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchDetails(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transcript'),
      ),
      body: Obx(
        () => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    controller.detailsChart,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
      ),
    );
  }
}
