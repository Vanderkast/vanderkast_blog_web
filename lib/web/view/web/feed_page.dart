import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vanderkast_blog_web/web/model/publication.dart';

class FeedPage extends StatelessWidget {
  final FeedCubit cubit;

  const FeedPage({Key key, this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<FeedCubit, Feed>(
            cubit: cubit,
            builder: (ctx, feed) => feed?.publications == null
                ? Text('Публикации еще не загружены')
                : ListView.builder(
                    itemBuilder: (ctx, i) =>
                        PublicationWidget.get(feed.publications[i]),
                    itemCount: feed.publications.length,
                  )),
      ),
    );
  }
}

abstract class PublicationWidget extends StatelessWidget {
  static PublicationWidget get(Publication publication) {
    switch (publication.type) {
      case PublicationType.SIMPLE:
        return SimplePublication(publication);
    }
    return null;
  }
}

class SimplePublication extends PublicationWidget {
  final Publication publication;

  SimplePublication(this.publication);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Card(
      child: Container(
        padding:EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(publication.title, style: theme.headline5),
            Text(publication.content, style: theme.bodyText1),
            Row(
              children: [
                Spacer(),
                Text(
                  DateFormat("dd.MM.yyy").format(
                      DateTime.fromMillisecondsSinceEpoch(publication.timestamp)),
                  style: theme.overline,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
