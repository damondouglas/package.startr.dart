// temporary fix for https://github.com/damondouglas/startr.dart/issues/3
import 'dart:io';
import 'dart:async';

main(List<String> args) async {
  if (args.length < 2) {
    print("Usage: startr_rename_project_files.dart <project name>");
    exit(1);
  }

  var renameFilesFrom = args[0];
  var renameFilesTo = args[1];

  var d = new Directory('.');
  await for (File f in
    d.list(recursive: true, followLinks: false)
    .where((FileSystemEntity f) => f is File)
    .where((File f) => f.path.contains(renameFilesFrom))
  ) {
    var pathStr = f.path;
    var newPath = pathStr.replaceAll(renameFilesFrom, renameFilesTo);
    f.rename(newPath);
  }
}
