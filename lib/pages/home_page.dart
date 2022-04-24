import 'dart:io';

// import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:just_music/constants.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0x550F2027),
            Color(0x55203A43),
            Color(0x552C5364),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 80),
          child: WindowTopBar(naviChildren: [
            WindowIconButtons(
              ontap: () {
                openMenu();
              },
              icon: Icons.menu,
            )
          ]),
        ),
        body: Center(
          child: Padding(
            padding: kGlobalOuterPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.video_file_outlined,
                  size: 100,
                ),
                kVSpace,
                const Text(
                  'Insert the video ID or URL from YouTube',
                  style: TextStyle(fontSize: 16),
                ),
                kVSpace,
                TextField(controller: textController),
                kVSpace,
                OutlinedButton(
                  onPressed: () async {
                    var yt = YoutubeExplode();
                    var id = VideoId(textController.text.trim());
                    var video = await yt.videos.get(id);

                    // // Display info about this video.
                    // await showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialog(
                    //       title: Text(
                    //           'Title: ${video.title}, Duration: ${video.duration}'),
                    //       content: Image.network(video.thumbnails.lowResUrl),
                    //     );
                    //   },
                    // );

                    await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Container(
                            color: kDarkColor,
                            child: Padding(
                              padding: kGlobalOuterPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    child: WindowIconButtons(
                                        icon: Icons.arrow_back_ios_new,
                                        ontap: () => Navigator.pop(context)),
                                  ),
                                  kVSpace,
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          video.thumbnails.standardResUrl,
                                        )),
                                  ),
                                  ListTile(
                                    title: const Text('Title'),
                                    subtitle: Text(video.title),
                                  ),
                                  ListTile(
                                    title: const Text('Duration'),
                                    subtitle: Text('${video.duration}'),
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                      onPressed: () async {
                                        var manifest = await yt
                                            .videos.streamsClient
                                            .getManifest(id);
                                        var audio = manifest.audioOnly.last;

                                        // Build the directory.
                                        var dir = await getDownloadsDirectory();
                                        var filePath = path.join(
                                            dir!.uri.toFilePath(),
                                            '${video.title}.${audio.container.name}'
                                                .replaceAll(r'\', '')
                                                .replaceAll('/', '')
                                                .replaceAll('*', '')
                                                .replaceAll('?', '')
                                                .replaceAll('"', '')
                                                .replaceAll('<', '')
                                                .replaceAll('>', '')
                                                .replaceAll('|', ''));
                                        // Open the file to write.
                                        var file = File(filePath);
                                        var fileStream = file.openWrite();

                                        // Pipe all the content of the stream into our file.
                                        await yt.videos.streamsClient
                                            .get(audio)
                                            .pipe(fileStream);
                                        /*
                                              If you want to show a % of download, you should listen
                                              to the stream instead of using `pipe` and compare
                                              the current downloaded streams to the totalBytes,
                                              see an example ii example/video_download.dart
                                               */

                                        // Close the file.
                                        await fileStream.flush();
                                        await fileStream.close();

                                        // Show that the file was downloaded.
                                        // await showDialog(
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return AlertDialog(
                                        //       content: Text(
                                        //           'Download completed and saved to: $filePath'),
                                        //       actions: [
                                        //         TextButton(
                                        //             onPressed: () {Navig},
                                        //             child: Text('Done'))
                                        //       ],
                                        //     );
                                        //   },
                                        // );
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text('Download finished'),
                                          ),
                                        );
                                      },
                                      child: const Text('Download')),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: const Text('Fetch'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openMenu() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            color: kDarkColor,
            child: Padding(
              padding: kGlobalCardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: const Text(
                      'Menu',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    endIndent: 280,
                  ),
                  const ListTile(
                    title: Text('Version'),
                    subtitle: Text('0.1'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class WindowTopBar extends StatefulWidget {
  final List<Widget>? naviChildren;
  const WindowTopBar({Key? key, this.naviChildren}) : super(key: key);

  @override
  State<WindowTopBar> createState() => _WindowTopBarState();
}

class _WindowTopBarState extends State<WindowTopBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WindowTitleBarBox(
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Text(kAppName, style: TextStyle(fontSize: 18)),
              Expanded(child: MoveWindow()),
              Row(
                children: widget.naviChildren ?? [],
              ),
              const WindowButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class WindowIconButtons extends StatefulWidget {
  final IconData icon;
  final Function ontap;
  const WindowIconButtons({Key? key, required this.icon, required this.ontap})
      : super(key: key);

  @override
  State<WindowIconButtons> createState() => _WindowIconButtonsState();
}

class _WindowIconButtonsState extends State<WindowIconButtons> {
  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool darkModeOn = (globals.themeMode == ThemeMode.dark ||
    //     (brightness == Brightness.dark &&
    //         globals.themeMode == ThemeMode.system));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: () => widget.ontap(),
        borderRadius: BorderRadius.circular(25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              widget.icon,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: Colors.grey.shade100,
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: Colors.grey.shade100);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WindowIconButtons(
          icon: Icons.minimize,
          ontap: () {
            appWindow.minimize();
          },
        ),
        WindowIconButtons(
          icon: Icons.close,
          ontap: () {
            appWindow.close();
          },
        ),
      ],
    );
  }
}
