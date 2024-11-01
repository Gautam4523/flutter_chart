import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search(
      {Key? key,
      required this.hintText,
      required this.searchText,
      this.width = 400})
      : super(key: key);

  final String hintText;
  final Function(String) searchText;
  final double width;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final myController = TextEditingController();
  bool isSearchIconClicked = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFE0E2E6),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: TextFormField(
              controller: myController,
              onFieldSubmitted: (value) {
                debugPrint('keyboard action');
                if (value.isNotEmpty) {
                  setState(() {
                    isSearchIconClicked = !isSearchIconClicked;
                    if (isSearchIconClicked) {
                      widget.searchText(value);
                    } else {
                      myController.text = '';
                      widget.searchText('');
                    }
                  });
                }
              },
              onChanged: (text) {
                setState(() {
                  isSearchIconClicked = false;
                });
                if (text.isEmpty) {
                  widget.searchText('');
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 6),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                    color: Color(0xFF6F727A),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (myController.text.isNotEmpty) {
                setState(() {
                  isSearchIconClicked = !isSearchIconClicked;
                  if (isSearchIconClicked) {
                    widget.searchText(myController.text);
                  } else {
                    myController.text = '';
                    widget.searchText('');
                  }
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Icon(
                isSearchIconClicked ? Icons.clear : Icons.search,
                color: myController.text.isNotEmpty
                    ? Color(0xFF232325)
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
