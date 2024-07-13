import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PathUtil {
  Future<String> getScreenshotPath() async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = p.joinAll([
      dir.path,
      'GoTimer',
      'Screenshots',
    ]);
    return filePath + p.separator;
  }
}
