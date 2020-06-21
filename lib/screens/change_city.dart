import 'package:flutter/material.dart';

class ChangeCity extends StatelessWidget {
  var _cityFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change City'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              'assets/images/white_snow.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: [
              ListTile(
                title: TextField(
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'City',
                  ),
                ),
              ),
              ListTile(
                title: FlatButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'city': _cityFieldController.text,
                    });
                  },
                  highlightColor: Colors.blue,
                  child: Text('Showing Weather'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
