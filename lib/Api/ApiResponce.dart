class ApiResponce<T> {
  T data;
  bool error;
  int statusCode;
  String errorMessage;
  ApiResponce({
    required this.data,
    this.error = false,
    required this.errorMessage,
    this.statusCode = 200,
  });
}
