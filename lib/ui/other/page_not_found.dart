import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: body(),
    );
  }

  body() {
    return const Center(
      child: Text(
        'Page Not Found',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
      ),
    );
  }
}
