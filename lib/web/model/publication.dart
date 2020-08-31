import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanderkast_blog_web/web/model/serializable.dart';

class Publication with Serializable {
  static const String SIMPLE = "SIMPLE";

  int _timestamp;
  PublicationType _type;
  String _id;

  String _title;
  String _content;

  Publication.from(Map<String, dynamic> map) {
    _id = map["id"];
    _timestamp = map["timestamp"];
    print(PublicationType.SIMPLE.toString());
    if (map["type"] == SIMPLE) {
      _type = PublicationType.SIMPLE;
      _title = map["title"];
      _content = map["content"];
    }
  }

  @override
  Map<String, dynamic> toMap() => {
        "id": _id,
        "timestamp": _timestamp,
        "type": _typeS(),
        "title": _title,
        "content": _content,
      };

  String _typeS() {
    switch (_type) {
      case PublicationType.SIMPLE:
        return "SIMPLE";
    }
    return null;
  }

  String get content => _content;

  String get title => _title;

  String get id => _id;

  PublicationType get type => _type;

  int get timestamp => _timestamp;
}

enum PublicationType { SIMPLE }

class Feed implements Serializable {
  List<Publication> publications;

  Feed.fromList(List<dynamic> list) {
    publications = new List();
    list.forEach((value) => publications.add(Publication.from(value)));
  }

  @override
  Map<String, dynamic> toMap() => {
        "publications": publications != null
            ? List.generate(
                publications.length, (index) => publications[index].toMap())
            : null
      };
}

typedef Future<Feed> FeedLoader();

class FeedCubit extends Cubit<Feed> {
  FeedCubit(FeedLoader feedLoader) : super(null) {
    _execute(feedLoader);
  }

  void _execute(feedLoader) async => emit(await feedLoader());
}
