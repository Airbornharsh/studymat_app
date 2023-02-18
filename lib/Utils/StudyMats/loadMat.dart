import "dart:convert";

import "package:http/http.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:studymat_app/providers/StudyMats.dart";

Future<Map> loadMatData(String institutionId) async {
  final temp = {};
  var client = Client();
  final prefs = await SharedPreferences.getInstance();
  String domainUri = prefs.getString("studymat_backend_uri") as String;
  try {
    var pdfRes = await client.post(
      Uri.parse("$domainUri/api/unsigned/pdf/list"),
      body: json.encode({"institutionId": institutionId}),
    );

    // temp["institutionId"] = institutionId;

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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("pdf")) {
                            temp[i][j][k][l][m]["pdf"].push(pdfObject);
                          } else {
                            temp[i][j][k][l][m]["pdf"] = [pdfObject];
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
      Uri.parse("$domainUri/api/unsigned/video/list"),
      body: json.encode({"institutionId": institutionId}),
    );

    var videoResBody = json.decode(videoRes.body);

    await videoResBody.forEach((pdf) {
      Mat videoObject = Mat(
          type: "video",
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
                            temp[i][j][k][l][m]["video"] = [videoObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("video")) {
                            temp[i][j][k][l][m]["video"].push(videoObject);
                          } else {
                            temp[i][j][k][l][m]["video"] = [videoObject];
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
      Uri.parse("$domainUri/api/unsigned/playlist/list"),
      body: json.encode({"institutionId": institutionId}),
    );

    var playlistResBody = json.decode(playlistRes.body);

    await playlistResBody.forEach((pdf) {
      Mat playlistObject = Mat(
          type: "playlist",
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
                          }
                        } else {
                          temp[i][j][k][l][m] = {};
                          if (temp[i][j][k][l][m].containsKey("playlist")) {
                            temp[i][j][k][l][m]["playlist"]
                                .push(playlistObject);
                          } else {
                            temp[i][j][k][l][m]["playlist"] = [playlistObject];
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
  } catch (e) {
    print(e);
  }
  return temp;
}
