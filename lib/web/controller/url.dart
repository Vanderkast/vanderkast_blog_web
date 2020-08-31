String url({String path}) => "$PROTOCOL://$ADDRESS:$PORT/${path ??''}";

const String PROTOCOL = "http";
const String ADDRESS = "192.168.0.16";
const String PORT = "8080";

const String FEED = "api/publication";
