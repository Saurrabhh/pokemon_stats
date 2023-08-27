import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatelessWidget {
  final T controller;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  const BaseView({Key? key, required this.controller, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => controller,
      child: Consumer<T>(
        builder: builder,
      ),
    );
  }
}
