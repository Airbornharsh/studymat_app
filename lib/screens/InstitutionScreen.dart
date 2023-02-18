import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymat_app/Utils/PdfApi.dart';
import 'package:studymat_app/providers/StudyMats.dart';
import 'package:studymat_app/screens/PdfViewerPage.dart';
import 'package:studymat_app/screens/VideoScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class InstitutionScreen extends StatefulWidget {
  static const routeName = "institution";
  InstitutionScreen({super.key});
  bool start = true;

  @override
  State<InstitutionScreen> createState() => _InstitutionScreenState();
}

class _InstitutionScreenState extends State<InstitutionScreen> {
  @override
  Widget build(BuildContext context) {
    final institutionId = ModalRoute.of(context)!.settings.arguments as String;
    Map institutionData =
        Provider.of<StudyMat>(context).getInstitution(institutionId);

    if (widget.start) {
      setState(() {
        widget.start = false;
      });
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: institutionData.keys.map((i) {
                  return ExpansionTile(
                    title: Text(i),
                    children: (institutionData[i]! as Map<dynamic, dynamic>)
                        .keys
                        .map((j) {
                      return ExpansionTile(
                        title: Text("  $j"),
                        children:
                            (institutionData[i][j]! as Map<dynamic, dynamic>)
                                .keys
                                .map((k) {
                          return ExpansionTile(
                            title: Text("    $k Year"),
                            children: (institutionData[i][j][k]
                                    as Map<dynamic, dynamic>)
                                .keys
                                .map((l) {
                              return ExpansionTile(
                                title: Text("      $l"),
                                children: (institutionData[i][j][k][l]
                                        as Map<dynamic, dynamic>)
                                    .keys
                                    .map((m) {
                                  return ExpansionTile(
                                    title: Text("        Module $m"),
                                    children: (institutionData[i][j][k][l][m]
                                            as Map<dynamic, dynamic>)
                                        .keys
                                        .map((type) {
                                      return ExpansionTile(
                                        title: Text("          ${type}s"),
                                        children: (institutionData[i][j][k][l]
                                                [m][type] as List<Mat>)
                                            .map((mat) {
                                          return ListTile(
                                            onTap: () async {
                                              if (type == "pdf") {
                                                // const url =
                                                //     'https://firebasestorage.googleapis.com/v0/b/studymat-1.appspot.com/o/Resume.pdf?alt=media&token=05817cc7-fafc-4a39-adfa-9e3146ee3ddf';
                                                final file =
                                                    await PDFApi.loadNetwork(
                                                        mat.link);

                                                Navigator.of(context).pushNamed(
                                                    PdfViewerPage.routeName,
                                                    arguments: file);
                                              } else if (type == "video") {
                                                Navigator.of(context).pushNamed(
                                                    VideoScreen.routeName,
                                                    arguments: mat);
                                              } else if (type == "playlist") {
                                                if (await canLaunchUrl(
                                                    Uri.parse(mat.link))) {
                                                  await launchUrl(
                                                      Uri.parse(mat.link));
                                                }
                                              }
                                            },
                                            title:
                                                Text("          ${mat.name}"),
                                          );
                                        }).toList(),
                                      );
                                    }).toList(),
                                  );
                                }).toList(),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
