import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymat_app/Utils/PdfApi.dart';
import 'package:studymat_app/providers/StudyMats.dart';
import 'package:studymat_app/providers/User.dart';
import 'package:studymat_app/screens/PdfViewerPage.dart';
import 'package:studymat_app/screens/VideoScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class AddMatScreen extends StatefulWidget {
  static const String routeName = 'addmat';
  const AddMatScreen({super.key});

  @override
  State<AddMatScreen> createState() => _AddMatScreenState();
}

class _AddMatScreenState extends State<AddMatScreen> {
  late Map institutionData = {};
  late final TextEditingController level1Controller;
  late final TextEditingController level2Controller;
  late final TextEditingController level3Controller;
  late final TextEditingController level4Controller;
  late final TextEditingController level5Controller;
  // late final TextEditingController level6Controller;
  String level6Controller = "pdf";
  late final TextEditingController nameController;
  late final TextEditingController linkController;
  bool islevel1Active = false;
  bool islevel2Active = false;
  bool islevel3Active = false;
  bool islevel4Active = false;
  bool islevel5Active = false;
  bool islevel6Active = false;
  bool islevel7Active = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    level1Controller = TextEditingController();
    level2Controller = TextEditingController();
    level3Controller = TextEditingController();
    level4Controller = TextEditingController();
    level5Controller = TextEditingController();
    // level6Controller = TextEditingController();
    nameController = TextEditingController();
    linkController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    level1Controller.dispose();
    level2Controller.dispose();
    level3Controller.dispose();
    level4Controller.dispose();
    level5Controller.dispose();
    // level6Controller.dispose();
    nameController.dispose();
    linkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final institutionId = ModalRoute.of(context)!.settings.arguments as String;
    institutionData = {
      ...Provider.of<User>(context).getAvailableInstitution(institutionId)
    };

    void clearAll() {
      level1Controller.clear();
      level2Controller.clear();
      level3Controller.clear();
      level4Controller.clear();
      level5Controller.clear();
      nameController.clear();
      linkController.clear();
      setState(() {
        islevel1Active = false;
        islevel2Active = false;
        islevel3Active = false;
        islevel4Active = false;
        islevel5Active = false;
        islevel6Active = false;
        islevel7Active = false;
      });
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: Column(
            // children: [MatListing(this.institutionData, context)],
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        ...institutionData.keys.map((i) {
                          return ExpansionTile(
                            title: Text(i),
                            trailing: IconButton(
                                onPressed: () {
                                  clearAll();
                                  setState(() {
                                    islevel2Active = true;
                                  });
                                },
                                icon: const Icon(Icons.add)),
                            children: [
                              ...(institutionData[i]! as Map<dynamic, dynamic>)
                                  .keys
                                  .map((j) {
                                return ExpansionTile(
                                  title: Text("  $j"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        clearAll();
                                        setState(() {
                                          islevel3Active = true;
                                        });
                                      },
                                      icon: const Icon(Icons.add)),
                                  children: [
                                    ...(institutionData[i][j]!
                                            as Map<dynamic, dynamic>)
                                        .keys
                                        .map((k) {
                                      return ExpansionTile(
                                        title: Text("    $k"),
                                        trailing: IconButton(
                                            onPressed: () {
                                              clearAll();
                                              setState(() {
                                                islevel4Active = true;
                                              });
                                            },
                                            icon: const Icon(Icons.add)),
                                        children: [
                                          ...(institutionData[i][j][k]
                                                  as Map<dynamic, dynamic>)
                                              .keys
                                              .map((l) {
                                            return ExpansionTile(
                                              title: Text("      $l"),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    clearAll();
                                                    setState(() {
                                                      islevel5Active = true;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add)),
                                              children: [
                                                ...(institutionData[i][j][k][l]
                                                        as Map<dynamic,
                                                            dynamic>)
                                                    .keys
                                                    .map((m) {
                                                  return ExpansionTile(
                                                    title: Text("        $m"),
                                                    trailing: IconButton(
                                                        onPressed: () {
                                                          clearAll();
                                                          setState(() {
                                                            islevel6Active =
                                                                true;
                                                          });
                                                        },
                                                        icon: const Icon(
                                                            Icons.add)),
                                                    children: [
                                                      ...(institutionData[i][j]
                                                                  [k][l][m]
                                                              as Map<dynamic,
                                                                  dynamic>)
                                                          .keys
                                                          .map((type) {
                                                        return ExpansionTile(
                                                          title: Text(
                                                              "          ${type}"),
                                                          trailing: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  clearAll();
                                                                  islevel7Active =
                                                                      true;
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                  Icons.add)),
                                                          children: [
                                                            ...(institutionData[i]
                                                                                [j]
                                                                            [
                                                                            k][l]
                                                                        [
                                                                        m][type]
                                                                    as List<
                                                                        Mat>)
                                                                .map((mat) {
                                                              return ListTile(
                                                                onTap:
                                                                    () async {
                                                                  if (type ==
                                                                      "pdf") {
                                                                    // const url =
                                                                    //     'https://firebasestorage.googleapis.com/v0/b/studymat-1.appspot.com/o/Resume.pdf?alt=media&token=05817cc7-fafc-4a39-adfa-9e3146ee3ddf';
                                                                    final file =
                                                                        await PDFApi.loadNetwork(
                                                                            mat.link);

                                                                    Navigator.of(context).pushNamed(
                                                                        PdfViewerPage
                                                                            .routeName,
                                                                        arguments:
                                                                            file);
                                                                  } else if (type ==
                                                                      "video") {
                                                                    Navigator.of(context).pushNamed(
                                                                        VideoScreen
                                                                            .routeName,
                                                                        arguments:
                                                                            mat);
                                                                  } else if (type ==
                                                                      "playlist") {
                                                                    if (await canLaunchUrl(
                                                                        Uri.parse(
                                                                            mat.link))) {
                                                                      await launchUrl(
                                                                          Uri.parse(
                                                                              mat.link));
                                                                    }
                                                                  }
                                                                },
                                                                title: Text(
                                                                    "          ${mat.name}"),
                                                              );
                                                            }).toList(),
                                                            if (islevel7Active)
                                                              ListTile(
                                                                title:
                                                                    TextField(
                                                                  controller:
                                                                      nameController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "Add Name",
                                                                    iconColor: Colors
                                                                        .grey
                                                                        .shade900,
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .requestFocus(new FocusNode());
                                                                        setState(
                                                                            () {
                                                                          islevel7Active =
                                                                              false;
                                                                        });
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (islevel7Active)
                                                              ListTile(
                                                                  title:
                                                                      TextField(
                                                                    controller:
                                                                        linkController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "Add Link",
                                                                      iconColor: Colors
                                                                          .grey
                                                                          .shade900,
                                                                      suffixIcon:
                                                                          IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .requestFocus(new FocusNode());
                                                                          setState(
                                                                              () {
                                                                            islevel7Active =
                                                                                false;
                                                                          });
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .clear,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  trailing:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            setState(() {
                                                                              isLoading = true;
                                                                            });

                                                                            if (nameController.text.isEmpty &&
                                                                                linkController.text.isEmpty) {
                                                                              setState(() {
                                                                                isLoading = false;
                                                                              });
                                                                              return;
                                                                            }

                                                                            try {
                                                                              await Provider.of<User>(context, listen: false).postMat(institutionId: institutionId, name: nameController.text, link: linkController.text, course: i, branch: j, year: k, subject: l, module: m, type: type);

                                                                              final tempMat = Mat(type: type, name: nameController.text, institutionId: institutionId, link: linkController.text);
                                                                              institutionData[i][j][k][l][m][type].add(tempMat);

                                                                              nameController.clear();
                                                                              linkController.clear();
                                                                              setState(() {
                                                                                isLoading = false;
                                                                              });
                                                                            } catch (e) {
                                                                              print(e);
                                                                              setState(() {
                                                                                isLoading = false;
                                                                              });
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.check,
                                                                            color:
                                                                                Colors.green,
                                                                          ))),
                                                          ],
                                                        );
                                                      }).toList(),
                                                      if (islevel6Active)
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 0),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: DropdownButton(
                                                            value:
                                                                level6Controller,
                                                            items: const [
                                                              DropdownMenuItem(
                                                                  value: "pdf",
                                                                  child: Text(
                                                                      "PDF")),
                                                              DropdownMenuItem(
                                                                  value:
                                                                      "video",
                                                                  child: Text(
                                                                      "VIDEO")),
                                                              DropdownMenuItem(
                                                                  value:
                                                                      "playlist",
                                                                  child: Text(
                                                                      "PLAYLIST"))
                                                            ],
                                                            onChanged: (value) {
                                                              final newValue =
                                                                  value!.trim();
                                                              setState(() {
                                                                if (newValue ==
                                                                    "pdf") {
                                                                  institutionData[i]
                                                                              [
                                                                              j]
                                                                          [
                                                                          k][l][m]
                                                                      [
                                                                      "pdf"] = [
                                                                    Mat(
                                                                        type:
                                                                            "",
                                                                        name:
                                                                            "",
                                                                        institutionId:
                                                                            "",
                                                                        link:
                                                                            "")
                                                                  ];
                                                                  level6Controller =
                                                                      "pdf";
                                                                  islevel6Active =
                                                                      false;
                                                                } else if (newValue ==
                                                                    "video") {
                                                                  institutionData[i]
                                                                              [
                                                                              j]
                                                                          [
                                                                          k][l][m]
                                                                      [
                                                                      "video"] = [
                                                                    Mat(
                                                                        type:
                                                                            "",
                                                                        name:
                                                                            "",
                                                                        institutionId:
                                                                            "",
                                                                        link:
                                                                            "")
                                                                  ];
                                                                  level6Controller =
                                                                      "video";
                                                                  islevel6Active =
                                                                      false;
                                                                } else if (newValue ==
                                                                    "playlist") {
                                                                  institutionData[i]
                                                                              [
                                                                              j]
                                                                          [
                                                                          k][l][m]
                                                                      [
                                                                      "playlist"] = [
                                                                    Mat(
                                                                        type:
                                                                            "",
                                                                        name:
                                                                            "",
                                                                        institutionId:
                                                                            "",
                                                                        link:
                                                                            "")
                                                                  ];
                                                                  level6Controller =
                                                                      "playlist";
                                                                  islevel6Active =
                                                                      false;
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        )
                                                    ],
                                                  );
                                                }).toList(),
                                                if (islevel5Active)
                                                  ListTile(
                                                      title: TextField(
                                                        controller:
                                                            level5Controller,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              "Add Module",
                                                          iconColor: Colors
                                                              .grey.shade900,
                                                          suffixIcon:
                                                              IconButton(
                                                            onPressed: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      new FocusNode());
                                                              setState(() {
                                                                islevel5Active =
                                                                    false;
                                                              });
                                                            },
                                                            icon: const Icon(
                                                              Icons.clear,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      trailing: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              institutionData[i]
                                                                      [j][k][l][
                                                                  level5Controller
                                                                      .text] = {};
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                          )))
                                              ],
                                            );
                                          }).toList(),
                                          if (islevel4Active)
                                            ListTile(
                                                title: TextField(
                                                  controller: level4Controller,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Add Subject",
                                                    iconColor:
                                                        Colors.grey.shade900,
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                new FocusNode());
                                                        setState(() {
                                                          islevel4Active =
                                                              false;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.clear,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        institutionData[i][j][k]
                                                            [level4Controller
                                                                .text] = {};
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    )))
                                        ],
                                      );
                                    }).toList(),
                                    if (islevel3Active)
                                      ListTile(
                                          title: TextField(
                                            controller: level3Controller,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Add Year",
                                              iconColor: Colors.grey.shade900,
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    setState(() {
                                                      islevel3Active = false;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.clear,
                                                    color: Colors.red,
                                                  )),
                                            ),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  institutionData[i][j][
                                                      level3Controller
                                                          .text] = {};
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )))
                                  ],
                                );
                              }).toList(),
                              if (islevel2Active)
                                ListTile(
                                  title: TextField(
                                    controller: level2Controller,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Add Branch",
                                      iconColor: Colors.grey.shade900,
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            setState(() {
                                              islevel2Active = false;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          institutionData[i]
                                              [level2Controller.text] = {};
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )),
                                )
                            ],
                          );
                        }).toList(),
                        if (islevel1Active)
                          ListTile(
                            title: TextField(
                              controller: level1Controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add Course",
                                iconColor: Colors.grey.shade900,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    setState(() {
                                      islevel1Active = false;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    institutionData[level1Controller.text] = {};
                                  });
                                },
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )),
                          )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (isLoading)
          Positioned(
            top: 0,
            left: 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: const Color.fromRGBO(80, 80, 80, 0.3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
