import 'package:flutter/widgets.dart';
import 'package:vanderkast_blog_web/web/controller/api_controller.dart';

class Singleton extends InheritedWidget {
  final HttpExecutor executor;

  Singleton(this.executor, {Widget child, Key key})
      : super(child: child, key: key);

  @override
  bool updateShouldNotify(Singleton old) => executor != old.executor;

  static Singleton of(BuildContext context, {bool listen}) =>
      context.findAncestorWidgetOfExactType<Singleton>();
}
