enum RequestMethod {
  get("get"),
  post("post"),
  put("put"),
  delete("delete"),
  patch("patch");

  final String name;
  const RequestMethod(this.name);
}

class NetworkRequest {
  final String url;
  final RequestMethod requestMethod;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? headers;

  NetworkRequest(
      {required this.url, required this.requestMethod, this.queryParams, this.body, this.headers});
}
