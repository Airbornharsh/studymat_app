import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart";

class Institution {
  String id;
  String name;
  String photoLink;
  List<Mat> pdfs = [];
  List<Mat> videos = [];
  List<Mat> playlists = [];

  Institution({required this.id, required this.name, required this.photoLink});
}

class Mat {
  String name;
  String institutionId;
  String link;
  String type;
  // List<String> courses;
  // List<String> branches;
  // List<String> years;
  // List<String> subjects;
  // List<String> modules;

  Mat({
    required this.type,
    required this.name,
    required this.institutionId,
    required this.link,
    // required this.courses,
    // required this.branches,
    // required this.years,
    // required this.subjects,
    // required this.modules,
  });
}

class StudyMat with ChangeNotifier {
  // List<Institution> _institutions = [];
  List<Object> _institution = [];

  Future loadMat() async {
    const institutionId = "63ef96e7f66a9c863cbcda2e";
    final temp = {};
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.getString("studymat_backend_uri") as String;
    try {
      var pdfRes = await client.post(
        Uri.parse("$domainUri/api/unsigned/pdf/list"),
        body: json.encode({"institutionId": institutionId}),
      );

      var pdfResBody = json.decode(pdfRes.body);

      await pdfResBody.forEach((pdf) {
        Mat pdfObject = Mat(
            type: "pdf",
            name: pdf["name"],
            institutionId: pdf["institutionId"],
            link: pdf["link"]);

        pdf["courses"].forEach((i) {
          if (temp.containsKey(i)) {
            pdf["branches"].forEach((j) {
              if (temp[i].containsKey(j)) {
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              } else {
                temp[i][j] = {};
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          } else {
            temp[i] = {};
            pdf["branches"].forEach((j) {
              if (temp[i].containsKey(j)) {
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              } else {
                temp[i][j] = {};
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("pdf")) {
                              temp[i][j][k][l][m]["pdf"].push(pdfObject);
                            } else {
                              temp[i][j][k][l][m]["pdf"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          }
        });
      });

      var videoRes = await client.post(
        Uri.parse("$domainUri/api/unsigned/pdf/list"),
        body: json.encode({"institutionId": institutionId}),
      );

      var videoResBody = json.decode(videoRes.body);

      await videoResBody.forEach((pdf) {
        Mat videoObject = Mat(
            type: "pdf",
            name: pdf["name"],
            institutionId: pdf["institutionId"],
            link: pdf["link"]);

        pdf["courses"].forEach((i) {
          if (temp.containsKey(i)) {
            pdf["branches"].forEach((j) {
              if (temp[i].containsKey(j)) {
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              } else {
                temp[i][j] = {};
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          } else {
            temp[i] = {};
            pdf["branches"].forEach((j) {
              if (temp[i].containsKey(j)) {
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              } else {
                temp[i][j] = {};
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("video")) {
                              temp[i][j][k][l][m]["video"].push(videoObject);
                            } else {
                              temp[i][j][k][l][m]["video"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          }
        });
      });
      var playlistRes = await client.post(
        Uri.parse("$domainUri/api/unsigned/pdf/list"),
        body: json.encode({"institutionId": institutionId}),
      );

      var playlistResBody = json.decode(playlistRes.body);

      await playlistResBody.forEach((pdf) {
        Mat playlistObject = Mat(
            type: "pdf",
            name: pdf["name"],
            institutionId: pdf["institutionId"],
            link: pdf["link"]);

        pdf["courses"].forEach((i) {
          if (temp.containsKey(i)) {
            pdf["branches"].forEach((j) {
              if (temp[i].containsKey(j)) {
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              } else {
                temp[i][j] = {};
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          } else {
            temp[i] = {};
            pdf["branches"].forEach((j) {
              if (temp[i].containsKey(j)) {
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              } else {
                temp[i][j] = {};
                pdf["years"].forEach((k) {
                  if (temp[i][j].containsKey(k)) {
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  } else {
                    temp[i][j][k] = {};
                    pdf["subjects"].forEach((l) {
                      if (temp[i][j][k].containsKey(l)) {
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      } else {
                        temp[i][j][k][l] = {};
                        pdf["modules"].forEach((m) {
                          if (temp[i][j][k][l].containsKey(m)) {
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          } else {
                            temp[i][j][k][l][m] = {};
                            if (temp[i][j][k][l][m].containsKey("playlist")) {
                              temp[i][j][k][l][m]["playlist"]
                                  .push(playlistObject);
                            } else {
                              temp[i][j][k][l][m]["playlist"] = [pdf];
                            }
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          }
        });
      });

      _institution.add(temp);
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return;
  }
}
