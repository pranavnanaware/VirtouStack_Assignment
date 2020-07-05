import 'dart:async';
import 'package:pranavnanaware/services/Apibrain.dart';

abstract class DataStream {
  void dispose();
}

class ListDataStream extends DataStream {
  bool disposed = false;

  final StreamController<List<Path>> streamController =
      StreamController<List<Path>>();
  Stream<List<Path>> get pathStream => streamController.stream;
  StreamSink<List<Path>> get pathSink => streamController.sink;

  PathApiProvider apiProvider = PathApiProvider();
  Future<List<Path>> getPathData() => apiProvider.getData();

  getPath() async {
    if (disposed) {
      print('');
      return;
    }
    try {
      List<Path> itemModel = await getPathData();
      if (!disposed) pathSink.add(itemModel);
    } catch (error) {
      pathSink.addError(error);
    }
  }

  @override
  void dispose() {
    streamController.close();
    disposed = true;
  }
}

PathApiProvider apiProvider = PathApiProvider();
Future<List<Path>> getPathData() => apiProvider.getData();
