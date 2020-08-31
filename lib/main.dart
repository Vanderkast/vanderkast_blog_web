import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vanderkast_blog_web/web/controller/api_controller.dart';
import 'package:vanderkast_blog_web/web/controller/url.dart';
import 'package:vanderkast_blog_web/web/injection/singleton.dart';
import 'package:vanderkast_blog_web/web/model/publication.dart';
import 'package:vanderkast_blog_web/web/view/web/feed_page.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Singleton(
      new HttpExecutor(new DioKeeper()),
      child: BlocProvider<FeedCubit>(
        create: (ctx) => FeedCubit(() async => Feed.fromList(
            (await Singleton.of(ctx, listen: false).executor.get(FEED)).data
                as List<dynamic>)),
        child: MaterialApp(
          title: 'Vanderkast\'s blog',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: Locale("ru", "RU"),
          initialRoute: "/",
          routes: {
            "/": (ctx) => FeedPage(
                  cubit: BlocProvider.of<FeedCubit>(ctx),
                ),
          },
        ),
      ),
    );
  }
}
