//=========================================================================================\\
//  Analisador de Contrapontos v0.4                                                        \\
//                                                                                         \\
//  Copyright (C)2020 Rogério Tavares Constante                                            \\
//                                                                                         \\
//  Este programa é um software livre: você pode redistribuir e/ou  modificar              \\
//  ele nos termos da GNU General Public License como publicada pela                       \\
//  Free Software Foundation, seja na versão 3 da licença, ou em qualquer outra posterior. \\
//                                                                                         \\
//  Este programa é distribuído com a intenção de que seja útil,                           \\
//  mas SEM NENHUMA GARANTIA; Veja a GNU para mais detalhes.                               \\
//                                                                                         \\
//  Uma cópia da GNU General Public License pode ser encontrada em                         \\
//  <http://www.gnu.org/licenses/>.                                                        \\
//                                                                                         \\
//=========================================================================================\\

import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.1
import MuseScore 1.1

MuseScore {
      menuPath: "Plugins.Contraponto.Analisador"
      description: "Analisador de Contrapontos.\nPlugin de auxílio na correção de exercícios de contraponto."
      version: "0.4ms232"

// ----------------------------- janela principal -----------------------
  ApplicationWindow {
    id: window
    visible: true
    title: "Analisador de Contrapontos v0.4"
      width: 700; height: 630
    color: "#020202"


    // ------------------------------ barra inferior --------------------------
    Rectangle {
            id: barraInferior
            y: 600
            width: 697; height: 30
            color: "#090909"
            border.color: "#383838"
            border.width: 1
            x: 1

        Text { x: 6; y: 4; font.pointSize: 7; color: "#aaa31e"; text: "criado por" }
        Text { x: 5; y: 13; font.pointSize: 9; color: "#aaa31e"; text: "Rogério Tavares Constante" }
        Text { x: 665; y: 10; font.pointSize: 9; color: "#aaa31e"; text: "2019" }

       Rectangle {
             id: btVerifica
             property string text: "Verificar"
             signal clicked
             anchors.verticalCenter: parent.verticalCenter
             anchors.right: parent.horizontalCenter //; anchors.leftMargin: 3
             width: bLabel3.width + 20; height: bLabel3.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea3.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }

            MouseArea {
                  id: mArea3
                   anchors.fill: parent
                   onClicked: { msgResult.close(); window.lower(); verificar(); }
             }

            Text {
             id: bLabel3
             anchors.centerIn: btVerifica
             color: "#000000"
             text: btVerifica.text
                  }
            } // botão verificar

       Rectangle {
             id: btFechar
             property string text: "Fechar"
             signal clicked
             anchors.verticalCenter: parent.verticalCenter
             anchors.left: parent.horizontalCenter; anchors.leftMargin: 3
             width: bLabel4.width + 20; height: bLabel4.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea4.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }

            MouseArea {
                  id: mArea4
                   anchors.fill: parent
                   onClicked: { Qt.quit(); window.close(); msgResult.close(); }
             }

            Text {
             id: bLabel4
             anchors.centerIn: btFechar
             color: "#000000"
             text: btFechar.text
                  }
            } // botão fechar
        }
    // ------------------------------ Apresentação ---------------------------
 Item { id: apresenta; visible: true

    Text { x: 90; y: 275; font.pointSize: 19; color: "#aaa31e"; text: "Analisador de Contrapontos 0.4" }
    Text { x: 196; y: 303; font.pointSize: 9; color: "#aaa31e"; text: "Extensão para MuseScore" }

  }
    // ------------------------------ configurações, barra lateral --------------------------
 Item { id: configura; visible: true;
    Rectangle { x: 536; y: 3; width: 161; height: 590;	color: "#222222"; radius: 2
      Text { x: 22; y: 5; color: "#d1d10a"; font.pixelSize: 18; text: "Configurações" }
      Rectangle { id: tonalidade;
                  x: 3; y: 28; width: 155; height: 110;
                  color: "#101010"; radius: 2
         Button {
	       	id: btTonica
	         text: "Dó"
	         width: 60
	         menu: menuTonica
	         x: 3; y: 3
	         Text { x: 62; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: "Tônica/finalis" }
          }
	       Button {
	       	id: btAcid
	         text: ""
	         width: 50
	         menu: menuAcid
	         x: 3; y: 28
	         Text { x: 52; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: "Acidente" }
	       }
	       Button {
	       	id: btModo
	         text: "Maior"
	         width: 90
	         menu: menuModo
	         x: 3; y: 53
	         Text { x: 92; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: "Modo" }
	       }
	       Menu {
	       	id: menuTonica
	       	property int value: 1
	    		    MenuItem { text: "Dó"; onTriggered: { menuTonica.value = 1; btTonica.text = "Dó" } }
				    	MenuItem { text: "Ré"; onTriggered: { menuTonica.value = 2; btTonica.text = "Ré" } }
				    	MenuItem { text: "Mi"; onTriggered: { menuTonica.value = 3; btTonica.text = "Mi" } }
				    	MenuItem { text: "Fá"; onTriggered: { menuTonica.value = 4; btTonica.text = "Fá" } }
				    	MenuItem { text: "Sol"; onTriggered: { menuTonica.value = 5; btTonica.text = "Sol" } }
				    	MenuItem { text: "Lá"; onTriggered: { menuTonica.value = 6; btTonica.text = "Lá" } }
				    	MenuItem { text: "Si"; onTriggered: { menuTonica.value = 7; btTonica.text = "Si" } }
				 }
		     Menu {
	       	id: menuAcid
	       	property string value: ""
	    		    MenuItem { text: "Natural"; onTriggered: { menuAcid.value = 1; btAcid.text = "" } }
				    	MenuItem { text: "#"; onTriggered: { menuAcid.value = 2; btAcid.text = "#" } }
				    	MenuItem { text: "b"; onTriggered: { menuAcid.value = 3; btAcid.text = "b" } }
				 }
		     Menu {
	       	id: menuModo
          property int value: 1
	    		    MenuItem { text: "Maior"; onTriggered: { menuModo.value = 1; btModo.text = "Maior" } }
				    	MenuItem { text: "Menor"; onTriggered: { menuModo.value = 2; btModo.text = "Menor" } }
				    	MenuItem { text: "Jônico"; onTriggered: { menuModo.value = 3; btModo.text = "Jônico" } }
				    	MenuItem { text: "Dórico"; onTriggered: { menuModo.value = 4; btModo.text = "Dórico" } }
				    	MenuItem { text: "Frígio"; onTriggered: { menuModo.value = 5; btModo.text = "Frígio" } }
				    	MenuItem { text: "Lídio"; onTriggered: { menuModo.value = 6; btModo.text = "Lídio" } }
				    	MenuItem { text: "Mixolídio"; onTriggered: { menuModo.value = 7; btModo.text = "Mixolídio" } }
				    	MenuItem { text: "Eólio"; onTriggered: { menuModo.value = 8; btModo.text = "Eólio" } }
				    	MenuItem { text: "Lócrio"; onTriggered: { menuModo.value = 9; btModo.text = "Lócrio" } }
				 }

         Text { x: 6; y: 86; color: "#f9ff8c"; font.pixelSize: 14; text: "Voz do C.F. :"
	         Rectangle { anchors.left: parent.right; anchors.leftMargin: 8; anchors.verticalCenter: parent.verticalCenter;
	                     width: 25; height: 22; color: "#9c9c9c"; radius: 2
             Rectangle { x: 1; y: 1; width: 23; height: 20; color: "#050000"; radius: 2
	            TextInput { id: vozCantusFirmus; anchors.horizontalCenter: parent.horizontalCenter;
	                        anchors.verticalCenter: parent.verticalCenter; text: "1"; font.pixelSize: 15; color: "yellow";
	                        validator: IntValidator{bottom: 1; top: 8; } }
		         }
		       }
		     }
      }
      Rectangle { id: contraponto // botões para seleção de espécies
              x: 3; y: 142
              width: 155; height: 157; radius: 2
              color: "#101010"
              Text { x: 3; y: 5; color: "#f9ff8c"; font.pixelSize: 14; text: "Tipo de contraponto:" }

        // CF
        Rectangle {
                   id: botao27
                   x: 2; y: 25
                   property string text: "Cantus Firmus"
                   signal clicked
                   width: 149; height: bLabel27.height + 7
                   border { width: 1; color: "#555555" }
                   smooth: true
                   radius: 2
                   gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: {
                              if (mArea27.pressed)
                                  return "#888d96"
                                 else
                                 return "#a0a8af"
                           }
                    }
                    GradientStop { position: 1.0; color: "#334455" }
                  }
                  onClicked: {
                           salvarCfg();
                           if (melodia) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = "";
                                          melodias.visible = false; dissonâncias.visible = false; gerais.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; bLabel291.color = "#000000"; melodia = false;
                                          bLabel27.color = "#000000"; }
                            else  {
                           bLabel26.color = "#000000"; bLabel28.color = "#002e77";
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#000000"; bLabel23.color = "#000000";
                           bLabel2.color = "#000000"; bLabel1.color = "#000000";
                           bLabel27.color = "#002e77"; bLabel29.color = "#000000";
                           bLabel291.color = "#000000";
                           gerais.visible = false; dissonâncias.visible = false;
                           intervalosClasse.visible = false; melodias.visible = true;
                           priEsp = false; secEsp = false; terEsp = false; quaEsp = false;
                           quiEsp = false; melodia = true; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
                           }
                  MouseArea {
                        id: mArea27
                         anchors.fill: parent
                         onClicked: botao27.clicked();
                   }

                  Text {
                   id: bLabel27
                   anchors.centerIn: botao27
                   color: "#000000"
                   text: botao27.text
                        }
                  }
        // primeira espécie
        Rectangle {
                   id: botao1
                   x: 3; y: 51
                   property string text: "1ª esp."
                   signal clicked
                   width: 74; height: bLabel1.height + 7
                   border { width: 1; color: "#555555" }
                   smooth: true
                   radius: 2
                   gradient: Gradient {
                     GradientStop {
                        position: 0.0
                        color: {
                              if (mArea1.pressed)
                                  return "#888d96"
                                 else
                                 return "#a0a8af"
                           }
                         }
                     GradientStop { position: 1.0; color: "#334455" }
                   }
                   onClicked: {
                           salvarCfg();
                           if (priEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = "";
                                          melodias.visible = false; dissonâncias.visible = false; gerais.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; bLabel291.color = "#000000"; priEsp = false;
                                          bLabel1.color = "#000000"; }
                            else  {
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#000000"; bLabel23.color = "#000000";
                           bLabel2.color = "#000000"; bLabel1.color = "#002e77";
                           bLabel27.color = "#000000"
                           priEsp = true; secEsp = false; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
                           }
                   MouseArea {
                        id: mArea1
                         anchors.fill: parent
                         onClicked: botao1.clicked();
                   }

                   Text {
                   id: bLabel1
                   anchors.centerIn: botao1
                   color: "#000000"
                   text: botao1.text
                   }
                  }
        // segunda espécie
        Rectangle {
                   id: botao2
                   x: 78; y: 51
                   property string text: "2ª esp."
                   signal clicked
                   width: 74; height: bLabel2.height + 7
                   border { width: 1; color: "#555555" }
                   smooth: true
                   radius: 2
                   gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: {
                              if (mArea2.pressed)
                                  return "#888d96"
                                 else
                                 return "#a0a8af"
                           }
                    }
                    GradientStop { position: 1.0; color: "#334455" }
                  }
                   onClicked: {
                           salvarCfg();
                           if (secEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = "";
                                          melodias.visible = false; dissonâncias.visible = false; gerais.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; bLabel291.color = "#000000"; secEsp = false;
                                          bLabel2.color = "#000000"; }
                            else  {
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#000000"; bLabel23.color = "#000000";
                           bLabel2.color = "#002e77"; bLabel1.color = "#000000"; bLabel27.color = "#000000"
                           priEsp = false; secEsp = true; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
                           }
                  MouseArea {
                        id: mArea2
                         anchors.fill: parent
                         onClicked: botao2.clicked();
                   }

                  Text {
                   id: bLabel2
                   anchors.centerIn: botao2
                   color: "#000000"
                   text: botao2.text
                   }
                  }
        // terceira especie
        Rectangle {
                   id: botao23
                   x: 3; y: 77
                   property string text: "3ª esp."
                   signal clicked
                   width: 74; height: bLabel23.height + 7
                   border { width: 1; color: "#555555" }
                   smooth: true
                   radius: 2
                   gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: {
                              if (mArea23.pressed)
                                  return "#888d96"
                                 else
                                 return "#a0a8af"
                           }
                    }
                    GradientStop { position: 1.0; color: "#334455" }
                  }
                   onClicked: {
                           salvarCfg();
                           if (terEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = "";
                                          melodias.visible = false; dissonâncias.visible = false; gerais.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; bLabel291.color = "#000000"; terEsp = false;
                                          bLabel23.color = "#000000";}
                            else  {
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#000000"; bLabel23.color = "#002e77";
                           bLabel2.color = "#000000"; bLabel1.color = "#000000"; bLabel27.color = "#000000"
                           priEsp = false; secEsp = false; terEsp = true; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
                          }
                  MouseArea {
                        id: mArea23
                         anchors.fill: parent
                         onClicked: botao23.clicked();
                   }

                  Text {
                   id: bLabel23
                   anchors.centerIn: botao23
                   color: "#000000"
                   text: botao23.text
                        }
                  }
        // quarta espécie
        Rectangle {
                    id: botao24
                    x: 78; y: 77
                    property string text: "4ª esp."
                    signal clicked
                    width: 74; height: bLabel24.height + 7
                    border { width: 1; color: "#555555" }
                    smooth: true
                    radius: 2
                    gradient: Gradient {
                     GradientStop {
                         position: 0.0
                         color: {
                               if (mArea24.pressed)
                                   return "#888d96"
                                  else
                                  return "#a0a8af"
                            }
                     }
                     GradientStop { position: 1.0; color: "#334455" }
                   }
                    onClicked: {
                           salvarCfg();
                           if (quaEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = "";
                                          melodias.visible = false; dissonâncias.visible = false; gerais.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; bLabel291.color = "#000000"; quaEsp = false;
                                          bLabel24.color = "#000000"; }
                            else  {
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#002e77"; bLabel23.color = "#000000";
                           bLabel2.color = "#000000"; bLabel1.color = "#000000"; bLabel27.color = "#000000"
                           priEsp = false; secEsp = false; terEsp = false; quaEsp = true; quiEsp = false; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
                          }
                   MouseArea {
                         id: mArea24
                          anchors.fill: parent
                          onClicked: botao24.clicked();
                    }
                   Text {
                    id: bLabel24
                    anchors.centerIn: botao24
                    color: "#000000"
                    text: botao24.text
                         }
                    }
        // quinta espécie
        Rectangle {
                   id: botao25
                   x: 3; y: 103
                   property string text: "5ª esp."
                   signal clicked
                   width: 74; height: bLabel25.height + 7
                   border { width: 1; color: "#555555" }
                   smooth: true
                   radius: 2
                   gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: {
                              if (mArea25.pressed)
                                  return "#888d96"
                                 else
                                 return "#a0a8af"
                           }
                    }
                    GradientStop { position: 1.0; color: "#334455" }
                  }
                  onClicked: {
                           salvarCfg();
                           if (quiEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = "";
                                          melodias.visible = false; dissonâncias.visible = false; gerais.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; bLabel291.color = "#000000"; quiEsp = false;
                                          bLabel25.color = "#000000"; }
                            else  {
                           bLabLivre.color = "#000000";
                           bLabel25.color = "#002e77"; bLabel24.color = "#000000";
                           bLabel23.color = "#000000"; bLabel2.color = "#000000";
                           bLabel1.color = "#000000"; bLabel27.color = "#000000"
                           priEsp = false; secEsp = false; terEsp = false; quaEsp = false; quiEsp = true; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
                          }
                  MouseArea {
                        id: mArea25
                         anchors.fill: parent
                         onClicked: botao25.clicked();
                   }

                  Text {
                   id: bLabel25
                   anchors.centerIn: botao25
                   color: "#000000"
                   text: botao25.text
                        }
                  }
        // contraponto livre
        Rectangle {
                     id: livre
                     x: 3; y: 129
                     property string text: "Contraponto livre"
                     signal clicked
                     width: 149; height: bLabLivre.height + 7
                     border { width: 1; color: "#555555" }
                     smooth: true
                     radius: 2
                     gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: {
                              if (mArLiv.pressed)
                                  return "#888d96"
                                  else
                                  return "#a0a8af"
                                       }
                                }
                        GradientStop { position: 1.0; color: "#334455" }
                      }
                      onClicked: {
                                 salvarCfg();
                                 if (livreCP) { intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = "";
                                                melodias.visible = false; dissonâncias.visible = false; gerais.visible = false;
                                                bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                                bLabel29.color = "#000000"; bLabel291.color = "#000000"; livreCP = false; }
                                  else  {
                                 bLabLivre.color = "#002e77"; bLabel25.color = "#000000";
                                 bLabel24.color = "#000000"; bLabel23.color = "#000000";
                                 bLabel2.color = "#000000"; bLabel1.color = "#000000";
                                 bLabel27.color = "#000000";
                                 priEsp = false; secEsp = false; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = true; }
                                 atualizarTitulo();
                                 carregarCfg();
                                  }
                      MouseArea {
                        id: mArLiv
                        anchors.fill: parent
                        onClicked: livre.clicked();
                      }

                      Text {
                       id: bLabLivre
                       anchors.centerIn: livre
                       color: "#000000"
                       text: livre.text
                      }
                    }

      }
      Rectangle { id: menu2 // botões para seleção de páginas
              x: 3; y: 303
              width: 155; height: 130; radius: 2
              color: "#101010"
              Text { x: 3; y: 5; color: "#f9ff8c"; font.pixelSize: 14; text: "Aspectos:" }
              // gerais
              Rectangle {
               id: botao26
               x: 3; y: 25
               property string text: "Gerais"
               signal clicked
               width: 149; height: bLabel26.height + 7
               border { width: 1; color: "#555555" }
               smooth: true
               radius: 2
               gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: {
                          if (mArea26.pressed)
                              return "#888d96"
                             else
                             return "#a0a8af"
                       }
                }
                GradientStop { position: 1.0; color: "#343434" }
              }
              onClicked: {
             				  if (gerais.visible) { gerais.visible = false; titulo1.text = ""; }
                         else if (!melodia) {
                           gerais.visible = true; melodias.visible = false; dissonâncias.visible = false; intervalosClasse.visible = false;
                                bLabel26.color = "#002e77"; bLabel28.color = "#000000";
                                bLabel29.color = "#000000"; bLabel291.color = "#000000";
                               };
                         atualizarTitulo();
              				 }
              MouseArea {
                    id: mArea26
                     anchors.fill: parent
                     onClicked: botao26.clicked();
               }
              Text {
               id: bLabel26
               anchors.centerIn: botao26
               color: "#000000"
               text: botao26.text
                    }
              }
              // dissonâncias
              Rectangle {
               id: botao29
               x: 3; y: 51
               property string text: "Dissonâncias"
               signal clicked
               width: 149; height: bLabel29.height + 7
               border { width: 1; color: "#555555" }
               smooth: true
               radius: 2
               gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: {
                          if (mArea29.pressed)
                              return "#888d96"
                             else
                             return "#a0a8af"
                       }
                }
                GradientStop { position: 1.0; color: "#343434" }
              }
              onClicked: {
                       if (dissonâncias.visible) { dissonâncias.visible = false; titulo1.text = ""; }
              				   else if (!melodia) {
                            dissonâncias.visible = true; melodias.visible = false; gerais.visible = false; intervalosClasse.visible = false;
                         bLabel29.color = "#002e77"; bLabel28.color = "#000000";
                         bLabel26.color = "#000000"; bLabel291.color = "#000000";
                         }
                         atualizarTitulo();
                       }
              MouseArea {
                    id: mArea29
                     anchors.fill: parent
                     onClicked: botao29.clicked();
               }
              Text {
               id: bLabel29
               anchors.centerIn: botao29
               color: "#000000"
               text: botao29.text
                    }
              }
              // melodia
              Rectangle {
               id: botao28
               x: 3; y: 77
               property string text: "Melodia"
               signal clicked
               width: 149; height: bLabel28.height + 7
               border { width: 1; color: "#555555" }
               smooth: true
               radius: 2
               gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: {
                          if (mArea28.pressed)
                              return "#888d96"
                             else
                             return "#a0a8af"
                       }
                }
                GradientStop { position: 1.0; color: "#343434" }
              }
              onClicked: {
                    if (melodias.visible) { melodias.visible = false; titulo1.text = ""; }
                     else { melodias.visible = true; gerais.visible = false; dissonâncias.visible = false; intervalosClasse.visible = false;
                            bLabel28.color = "#002e77"; bLabel291.color = "#000000";
                            bLabel26.color = "#000000"; bLabel29.color = "#000000";
              				   }
                         atualizarTitulo();
              				}
              MouseArea {
                    id: mArea28
                     anchors.fill: parent
                     onClicked: botao28.clicked();
               }
              Text {
               id: bLabel28
               anchors.centerIn: botao28
               color: "#000000"
               text: botao28.text
                    }
              }
              // classificação de intervalos
              Rectangle {
               id: botao291
               x: 3; y: 103
               property string text: "Intervalos"
               signal clicked
               width: 149; height: bLabel291.height + 7
               border { width: 1; color: "#555555" }
               smooth: true
               radius: 2
               gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: {
                          if (mArea291.pressed)
                              return "#888d96"
                             else
                             return "#a0a8af"
                       }
                }
                GradientStop { position: 1.0; color: "#343434" }
              }
              onClicked: {
                if (intervalosClasse.visible) { intervalosClasse.visible = false; titulo1.text = ""; }
                // else if (!melodia) {
                //        intervalosClasse.visible = true; melodias.visible = false; gerais.visible = false; dissonâncias.visible = false;
                //        bLabel28.color = "#000000"; bLabel291.color = "#002e77";
                //        bLabel26.color = "#000000"; bLabel29.color = "#000000";
                //     }
                //     atualizarTitulo();
              		}
              MouseArea {
                    id: mArea291
                     anchors.fill: parent
                     onClicked: botao291.clicked();
               }
              Text {
               id: bLabel291
               anchors.centerIn: botao291
               color: "#000000"
               text: botao291.text
                    }
              }
      }
      Rectangle { id: preConfigurações;
                 x: 3; y: 437; width: 155; height: 106
                 color: "#101010"; radius: 2

        Text { x: 3; y: 5; color: "#f9ff8c"; font.pixelSize: 14; text: "Pré-configurações:" }

        Rectangle { x: 3; y: 25; width: 149; height: 22; color: "#9c9c9c"; radius: 2
        Rectangle { x: 1; y: 1; width: 147; height: 20; color: "#050000"; radius: 2
          Text { id: nomePre; x: 5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12; color: "#d1d10a"; text: "sem nome" }
         }
        }
            Rectangle {
             id: salvarCnfiguração
             property string text: "Salvar"
             signal clicked
             x: 3; y: 50; width: 149; height: 25
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea41.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#2b2b2b" }
            }

            MouseArea {
                  id: mArea41
                   anchors.fill: parent
                   onClicked: { saveFileDialog.open(); }
             }

            Text {
             id: bLabel41
             anchors.centerIn: salvarCnfiguração
             color: "#101010"
             font.pointSize: 10
             text: salvarCnfiguração.text
                  }
            }

            Rectangle {
             id: carregarCnfiguração
             property string text: "Carregar"
             signal clicked
             x: 3; y: 77; width: 149; height: 25
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea42.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#2b2b2b" }
            }

            MouseArea {
                  id: mArea42
                   anchors.fill: parent
                   onClicked: { openFileDialog.open(); }
             }

            Text {
             id: bLabel42
             anchors.centerIn: carregarCnfiguração
             color: "#101010"
             font.pointSize: 10
             text: carregarCnfiguração.text
                  }
            }
      }
    }
  }
// ------------------------------ verificações -----------------------------------
 Text { id: titulo2; x: 5; y: 6; color: "#e0dfc3"; font.pixelSize: 20; text: ""
 Text { id: titulo1; anchors.left: parent.right; anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter;
        color: "#e0dfc3"; font.pixelSize: 18; text: ""  }}
 Item { id: gerais; visible: false;
   Rectangle { x: 2; y: 35; width: 532; height: 563;	color: "#3a3a3a"; radius: 2
     // paralelas
	  Rectangle { x: 3; y: 3; width: 526; height: 83; color: "#1c1c1c"; radius: 2

	     CheckBox { id: paralela8; checked: true; x: 5; y: 3;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
           color: "#e0dfc3"; font.pixelSize: 14; text: "U/8ª paralela" }
	       Text { id: par8RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se ocorrer" }
		     TextInput { id: par8Rep; anchors.left: par8RepTxt.right; anchors.leftMargin: 5; y: par8RepTxt.y;
           font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
		      Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
            color: "#e0dfc3"; font.pixelSize: 12; text: "ou mais paralela(s)" }
		     }
		   }

	     CheckBox { id: paralela5; checked: true; x: 5; y: 44;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
           color: "#e0dfc3"; font.pixelSize: 14; text: "5ª paralela" }
	       Text { id: par5RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se ocorrer" }
		     TextInput { id: par5Rep; anchors.left: par5RepTxt.right; anchors.leftMargin: 5; y: par5RepTxt.y;
           font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
	         Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
             color: "#e0dfc3"; font.pixelSize: 12; text: "ou mais paralela(s)" }
	        }
	       }

	     CheckBox { id: paralela4; checked: false; x: 245; y: 3;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
          color: "#e0dfc3"; font.pixelSize: 14; text: "4ªJ paralela" }
	      Text { id: par4RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se ocorrer" }
	       TextInput { id: par4Rep; anchors.left: par4RepTxt.right; anchors.leftMargin: 5; y: par4RepTxt.y;
           font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
           Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
             color: "#e0dfc3"; font.pixelSize: 12; text: "ou mais paralela(s)" }
	       }
	      }

	     CheckBox { id: paralela36; checked: true; x: 245; y: 44;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
          color: "#e0dfc3"; font.pixelSize: 14; text: "3ª e 6ª paralela" }
	      Text { id: par36RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se ocorrer" }
	       TextInput { id: par36Rep; anchors.left: par36RepTxt.right; anchors.leftMargin: 5; y: par36RepTxt.y;
           font.underline: true; text: "4"; font.pixelSize: 12;  color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
	        Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
            color: "#e0dfc3"; font.pixelSize: 12; text: "ou mais paralela(s)" }
	       }
	      }
	  }
	   // ocultas
	   Rectangle { x: 3; y: 89; width: 526; height: 46; color: "#1c1c1c"; radius: 2

	     CheckBox { id: oculta8; checked: true; x: 5; y: 3;
	       onClicked: {if (!oculta8.checked && !oculta5.checked) { ocultEx.checked = false; ocultSalto.checked = false;}}
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "8ª oculta/direta" }
	      }

	     CheckBox { id: oculta5; checked: true; x: 5; y: 23;
	       onClicked: {if (!oculta8.checked && !oculta5.checked) { ocultEx.checked = false; ocultSalto.checked = false;}}
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª oculta/direta" }
	      }
		 	  CheckBox { id: ocultEx; checked: true; x: 190; y: 5;
		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Exceto no final" }
		 		}

		 	  CheckBox { id: ocultSalto; checked: true; x: 190; y: 23;
		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Somente se salto na voz superior" }
		 		}
		  }
      // 5ªs e 8ªs intermitentes
     Rectangle { x: 3; y: 138; width: 526; height: 80; color: "#1c1c1c"; radius: 2

       CheckBox { id: inter8; checked: true; x: 5; y: 15;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "8ª intermitente" }
       }
       CheckBox { id: inter5; checked: true; x: 5; y: 40;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª intermitente" }
       }
       CheckBox { id: interExTf; checked: true; x: 150; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Exceto em tempo fraco e :" }
        CheckBox { id: interExTf1; checked: false; x: 60; y: 18;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 11; text: "sincopada e"
         CheckBox { id: interExTf2; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 11; text: "alcançada por grau conj." }}
         }
        }
       }
       CheckBox { id: interExTF; checked: true; x: 150; y: 39;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Exceto em tempo forte com ambas notas ligadas às anteriores" }
       }
       CheckBox { id: interExFim; checked: true; x: 330; y: 58;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Exceto na cadência final" }
       }
       CheckBox { id: interExCF; checked: true; x: 150; y: 58;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Exceto se CF não move" }
       }
      }
	     // consecutivas por movimento contrário e oblíquo
	   Rectangle { x: 3; y: 222; width: 276; height: 50;	color: "#1c1c1c"; radius: 2

	     CheckBox { id: consecObli; checked: false; x: 5; y: 3;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª e 8ª consecutivas mov. oblíquo" }
	      }

			CheckBox { id: consecCont; checked: false; x: 5; y: 26;
		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª e 8ª consecutivas mov. contrário" }
		 		}
		 }
     // cruzamento de vozes
     Rectangle { x: 283; y: 222; width: 246; height: 50; color: "#1c1c1c"; radius: 2
      CheckBox { id: cruzaVozes; checked: true; x: 5; y: 3
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "Cruzamento de vozes" }
       }
       CheckBox { id: falsaR; checked: true; x: 5; y: 26
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "Falsa relação" }
       }
     }
      // uníssono
		 Rectangle { x: 3; y: 275; width: 526; height: 45; color: "#1c1c1c"; radius: 2
	     CheckBox { id: uniss; checked: true; x: 3; y: 5;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "Uníssono" }
	       CheckBox { id: unissIF; checked: true; x: 250; y: -2
		       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 12; text: "Exceto Início/Final" }}
         CheckBox { id: unissTF; checked: true; x: 250; y: 18
  		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 12; text: "Exceto tempo fraco" }}
         Text { id: unissTxt; x: 5; y: 22; color: "#e0dfc3"; font.pixelSize: 12; text: "se quantidade for maior do que" }
		      TextInput { id: unissQt; anchors.left: unissTxt.right; anchors.leftMargin: 5; y: unissTxt.y; font.underline: true; text: "0";
                      font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}}
		   }
		  }
     // primeiro intervalo
     Rectangle { x: 3; y: 323; width: 526; height: 57;	color: "#282828"; radius: 2
       CheckBox { id: primInt; checked: true; x: 3; y: 2;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
          color: "#e0dfc3"; font.pixelSize: 14; text: "início diferente de unís./8ªJ" }
        CheckBox { id: ex5Ji; checked: true; x: 20; y: 18;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
            color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 5ªJ, com a Tônica na voz inf." } }
        CheckBox { id: ex3i; checked: true; x: 20; y: 35;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
            color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 3ª, com a Tônica na voz inf." } }
      } // ultimo intervalo
      CheckBox { id: ultInt; checked: true; x: 260; y: 2;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
          color: "#e0dfc3"; font.pixelSize: 14; text: "final diferente de unís./8ªJ" }
        CheckBox { id: ex5Jf; checked: true; x: 20; y: 18;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
            color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 5ªJ, com a Tônica na voz inf." } }
        CheckBox { id: ex3f; checked: true; x: 20; y: 35;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
            color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 3ª, com a Tônica na voz inf." } }
      }
    }
    // últimas notas de cada voz alcançadas por grau conjunto descendente e ascendente
    Rectangle { x: 3; y: 383; width: 526; height: 47;	color: "#282828"; radius: 2
       CheckBox { id: ultNotas; checked: true; x: 5; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter ; color: "#e0dfc3"; font.pixelSize: 14; text: "Se não alcançar último intervalo por grau conj. e mov. contrário" }
        CheckBox { id: quartaJi; checked: true; x: -3; y: 22;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 4ªJ asc / 5ªJ desc, voz inf." } }
         CheckBox { id: quartaJs; checked: true; x: 240; y: 22;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 4ªJ asc / 5ªJ desc, voz sup." } }
      }
    }
      // distância
		 Rectangle { x: 3; y: 433; width: 526; height: 45; color: "#282828"; radius: 2

	     CheckBox { id: distancia; checked: true; x: 5; y: 3;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "Distância entre as vozes" }
	       Text { id: distTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se uma sequencia maior do que" }
		     TextInput { id: distQt; anchors.left: distTxt.right; anchors.leftMargin: 5; y: distTxt.y; font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 20;}
		      Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "intervalo(s) maior(es) do que a"
           TextInput { id: distInt;
             anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; font.underline: true; text: "10"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 8; top: 15;}
            Text { anchors.left: parent.right; anchors.leftMargin: 3; anchors.verticalCenter: parent.verticalCenter; color: "yellow"; font.pixelSize: 12; text: "ª" }}
          }
		     }
		    }
		   }
      // consonâncias imperfeitas
     Rectangle { x: 3; y: 481; width: 526; height: 27; color: "#282828"; radius: 2
      CheckBox { id: consImp; checked: true; x: 5; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
          color: "#e0dfc3"; font.pixelSize: 14; text: "Prioridade para Consonâncias Imperfeitas" }
        }
      }
      // coerência harmônica
     Rectangle { x: 3; y: 511; width: 526; height: 51; color: "#282828"; radius: 2
      Text { x: 5; y: 0; color: "#e0dfc3"; font.pixelSize: 14; text: "Coerência harmônica"}
      CheckBox { id: cHarmonia; checked: true; x: 5; y: 32;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
               color: "#e0dfc3"; font.pixelSize: 12; text: "notas que não pertencem ao acorde"
          CheckBox { id: cHarmoniaEx; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
                   color: "#e0dfc3"; font.pixelSize: 12; text: "Exceto em tempo fraco" }}
        }
      }
      CheckBox { id: cHarmoniaF; checked: true; x: 5; y: 15;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter;
               color: "#e0dfc3"; font.pixelSize: 12; text: "ausência da fundamental"}}
      Text { x: 415; y: 4; color: "#e0dfc3"; font.pixelSize: 12; text: "Cifra:"
       ComboBox { id: cifraHar; anchors.left: parent.left; anchors.topMargin: 0; anchors.top: parent.bottom;
                   width: 101; model: ["Gradual", "Funcional", "Popular"]; currentIndex: 0 }}
    }
   }
  }
 Item { id: dissonâncias; visible: false;
   Rectangle { x: 2; y: 35; width: 532; height: 564;	color: "#353535"; radius: 2
     Rectangle { x: 3; y: 3; width: 526; height: 45; color: "#292929"; radius: 2
      Rectangle { x: 3; y: 3; width: 520; height: 40; color: "#131313"; radius: 2 // Dissonâncias
       CheckBox { id: dissonanciasG; checked: true; x: 3; y: 3;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
             font.pixelSize: 14; text: "Verificar dissonâncias" }}
     }
     }
     Rectangle { x: 3; y: 36; width: 526; height: 525; color: "#292929"; radius: 2
      Rectangle { x: 3; y: 3; width: 520; height: 45; color: "#131313"; radius: 2 // nota de passagem
       CheckBox { id: passagemL; checked: true; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 14; text: "Nota de passagem" }
        CheckBox { id: passaLEx; checked: false; x: 25; y: 20
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 11; text: "somente em tempo fraco" }}
       }
      }
      Rectangle { x: 3; y: 51; width: 520; height: 45; color: "#131313"; radius: 2 // bordadura
      Text {  x: 3; y: 3; color: "#e0dfc3"; font.pixelSize: 14; text: "Bordadura"
       CheckBox { id: bordaduraLI; checked: true; x: 80; anchors.verticalCenter: parent.verticalCenter;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
             font.pixelSize: 11; text: "inferior," }}
       CheckBox { id: bordaduraLS; checked: true; x: 155; anchors.verticalCenter: parent.verticalCenter;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "superior," }}
       CheckBox { id: bordaLEx; checked: false; x: 230; anchors.verticalCenter: parent.verticalCenter;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 11; text: "somente em tempo fraco" }}
      }
      Text { x: 3; y:25; color: "#e0dfc3"; font.pixelSize: 14; text: "Bordadura dupla"
        CheckBox { id: bordaduraD; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 11; text: ", somente"
        CheckBox { id: bordaLEx1; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: "em tempo fraco"
          CheckBox { id: bordaLEx2; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: "e notas principais em tempo forte" }}}}}}
      }


      }
      Rectangle { x: 3; y: 98; width: 520; height: 128; color: "#131313"; radius: 2 // cambiata
       CheckBox { id: cambiataL; checked: true; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
             font.pixelSize: 14; text: "Cambiata";
         CheckBox { id: cambiLEx1; checked: true; x: 0; y: 20
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                 font.pixelSize: 11; text: "1ª e última nota em tempo forte" }
         }
         CheckBox { id: cambiLEx2; checked: false; x: 0; y: 40
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                  font.pixelSize: 11; text: "cambiata na mesma direção do CF" }
         }
         CheckBox { id: cambiLEx3; checked: false; x: 0; y: 60
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                   font.pixelSize: 11; text: "dissonâncias somente em tempo fraco" }
         }
         CheckBox { id: cambiLEx4; checked: false; x: 0; y: 80
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                    font.pixelSize: 11; text: "2ª nota deve ser dissonânte" }
         }
         CheckBox { id: cambiLEx5; checked: false; x: 0; y: 100
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                    font.pixelSize: 11; text: "2ª nota com duração mais curta do que a 1ª e a última" }
         }
        }
       }
      }
      Rectangle { x: 3; y: 229; width: 520; height: 87; color: "#131313"; radius: 2 // suspensão
       CheckBox { id: suspensãoL; checked: false; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
             font.pixelSize: 14; text: "Suspensão";
         CheckBox { id: suspeLEx1; checked: true; x: 0; y: 20
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                 font.pixelSize: 11; text: "resolução interrompida"
              CheckBox { id: suspeLEx1a; checked: true; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 5;
                  Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                         font.pixelSize: 11; text: "somente por consonâncias" }}
          }
         }
         CheckBox { id: suspeLEx2; checked: true; x: 0; y: 40
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                 font.pixelSize: 11; text: "também a resolução ascendente (retardo)" }
         }
         CheckBox { id: suspeLEx3; checked: false; x: 0; y: 60
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                 font.pixelSize: 11; text: "resolução somente em consonância imperfeita" }
         }
        }
       }
      }
      Rectangle { x: 3; y: 318; width: 520; height: 67; color: "#131313"; radius: 2 // antecipação
       CheckBox { id: antecipaL; checked: false; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Antecipação";
           Text { x: 3; y: 20; color: "#e0dfc3";
                 font.pixelSize: 11; text: "introduzida por grau conjunto ("
           CheckBox { id: antecipaEx2; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0;
            Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                   font.pixelSize: 11; text: "descendente,"
             CheckBox { id: antecipaEx3; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 5;
              Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                     font.pixelSize: 11; text: "ascendente )" }}}
           }
         }
         CheckBox { id: antecipaEx4; checked: false; x: 0; y: 37
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: -5; color: "#e0dfc3";
                font.pixelSize: 11; text: "somente na cadência final" }
         }
        }
       }
      }
      Rectangle { x: 3; y: 387; width: 520; height: 86; color: "#131313"; radius: 2 // apojatura
       CheckBox { id: apojaturaL; checked: false; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Apojatura";
          CheckBox { id: apojaEx1; checked: false; x: 0; y: 20
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em tempo forte" }}
          CheckBox { id: apojaEx2; checked: false; x: 0; y: 40
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente se alcançada por movimento ascendente" }}
          CheckBox { id: apojaEx3; checked: false; x: 0; y: 60
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente resolução descendente" }}

        }
       }
      }
      Rectangle { x: 3; y: 475; width: 520; height: 47; color: "#131313"; radius: 2 // escapada
       CheckBox { id: escapadaL; checked: false; x: 3; y: 3;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "Escapada";
          CheckBox { id: escapaEx1; checked: false; x: 0; y: 20
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em tempo fraco" }}
         }
       }
      }
     }
   }
 }
 Item { id: melodias; visible: false;
   Rectangle { x: 2; y: 35; width: 532; height: 562;	color: "#5b5b5b"; radius: 2
    Rectangle { x: 3; y: 3; width: 526; height: 80; color: "#303030"; radius: 2
		 CheckBox { id: peNota; checked: true; x: 5; y: 5;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Penúltima nota deve pertencer ao V ou vii grau (quando tonal), \nou conduzir por grau conjunto para a finalis (quando modal)" }
		 }

		 CheckBox { id: ambito; checked: true; x: 5; y: 32;
		   Text { id: ambTxt1; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Âmbito melódico não deve ser maior do que" }
		   TextInput { id: ambInp; anchors.left: ambTxt1.right; anchors.leftMargin: 5; y: ambTxt1.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "12"; validator: IntValidator{bottom: 0; top: 99;}}
		   Text { anchors.left: ambInp.right; anchors.leftMargin: 5; y: ambInp.y; font.pixelSize: 12; color: "#e0dfc3"; text: "semitons" }
		 }

		 CheckBox { id: priviGC; checked: true; x: 5; y: 55;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Privilegiar graus conjuntos" }
		   CheckBox { id: priviGCEx; checked: true; x: 195; y: 0;
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
	          color: "#e0dfc3"; text: "e terças" } }
		 }
	  }

	  Rectangle { x: 3; y: 86; width: 526; height: 83; color: "#303030"; radius: 2
		 //Text { x: 5; y: 3;  font.pixelSize: 13; color: "#e0dfc3"; text: "Não usar os seguintes intervalos:"
			 CheckBox { id: salt7; checked: true; x: 5; y: 3;
			   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: "Sétimas maiores e menores" }
			 }
			 CheckBox { id: salt6; checked: true; x: 5; y: 22;
		      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		      color: "#e0dfc3"; text: "Sextas maiores e menores" }
		      CheckBox { id: salt6Ex; checked: true; x: 195; y: 0;
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
	          color: "#e0dfc3"; text: "Exceto se ascendente" } }
		    }
		    CheckBox { id: saltAum; checked: true; x: 5; y: 41;
			   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: "Aumentados e diminutos" }
			 }
			 CheckBox { id: saltM8; checked: true; x: 5; y: 60;
			   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: "Maiores do que a oitava" }
			 }
	    //}
	  }

	  Rectangle { x: 3; y: 172; width: 526; height: 162; color: "#303030"; radius: 2
	    CheckBox { id: tritono2; checked: true; x: 5; y: 3;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Trítono nas duas extremidades de movimentos melódicos" }
		 }

		 CheckBox { id: tritono1; checked: false; x: 5; y: 22;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Trítono em uma extremidade de movimentos melódicos" }
		 }

		 CheckBox { id: dissoC; checked: true; x: 5; y: 41;
		  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Dissonância composta" }
	    }

      CheckBox { id: doisSaltC; checked: true; x: 5; y: 60;
       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
        color: "#e0dfc3"; text: "Dois saltos em mov. contrário" }
       CheckBox { id: doisSaltCEx1; checked: true; x: 195; y: -7;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
          color: "#e0dfc3"; text: "Exceto se precedidos e seguidos por mov. contrário" } }
       CheckBox { id: doisSaltCEx2; checked: false; x: 195; y: 9
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
             color: "#e0dfc3"; text: "(e) Exceto se precedidos e seguidos grau conjunto" } }
      }

      CheckBox { id: doisSaltM; checked: true; x: 5; y: 97;
       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
        color: "#e0dfc3"; text: "Dois saltos na mesma direção"
       CheckBox { id: doisSaltMEx; checked: true; anchors.left: parent.right; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
          color: "#e0dfc3"; text: "Exceto se formar tríade" }}
        }
       }

	    CheckBox { id: saltM5; checked: true; x: 5; y: 130;
		  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Salto maior do que 5ªJ não compensado \ncom direcionamento contrário" }
		   CheckBox { id: saltM5Ex1; checked: true; x: 300; y: -7;
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
	          color: "#e0dfc3"; text: "por grau conjunto" } }
	      CheckBox { id: saltM5Ex2; checked: true; x: 300; y: 9;
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
	          color: "#e0dfc3"; text: "por salto < 5ª" } }
	    }
    }

    Rectangle { x: 3; y: 337; width: 526; height: 110; color: "#303030"; radius: 2
    CheckBox { id: varDir; checked: true; x: 5; y: 5;
		Text { id: varDirTxt; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		color: "#e0dfc3"; text: "Monotonia no contorno: mais do que" }
		TextInput { id: varDirQt; anchors.left: varDirTxt.right; anchors.leftMargin: 5; y: varDirTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "4"; validator: IntValidator{bottom: 0; top: 99;} }
		Text { anchors.left: varDirQt.right; anchors.leftMargin: 5; y: varDirQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: "movimento(s) na mesma direção" }
	  }

	  CheckBox { id: repNota; checked: true; x: 5; y: 25;
		 Text { id: repNotaTxt; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3";text: "Repetição de notas: mais do que" }
		 TextInput { id: repNotaQt; anchors.left: repNotaTxt.right; anchors.leftMargin: 5; y: repNotaTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "1"; validator: IntValidator{bottom: 0; top: 99;} }
		 Text { anchors.left: repNotaQt.right; anchors.leftMargin: 5; y: repNotaQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: "repetição(ões)"
      CheckBox { id: repeteNoutra; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
       color: "#e0dfc3";text: "sem mudar nota em outra voz" }
      }
     }

    }

	  CheckBox { id: repPad; checked: true; x: 5; y: 45;
		Text { id: repPadTxt; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		color: "#e0dfc3"; text: "Repetição de padrões: mais do que" }
		TextInput { id: repPadQt; anchors.left: repPadTxt.right; anchors.leftMargin: 5; y: repPadTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "0"; validator: IntValidator{bottom: 0; top: 99;} }
		Text { anchors.left: repPadQt.right; anchors.leftMargin: 5; y: repPadQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: "repetição(ões)" }
	  }

	  CheckBox { id: arpMel; checked: true; x: 5; y: 65;
		  Text { id: arpMelTxt; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Arpejo de acordes na linha melódica: mais do que" }
      TextInput { id: arpMelQt; anchors.left: arpMelTxt.right; anchors.leftMargin: 5; y: arpMelTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "1"; validator: IntValidator{bottom: 0; top: 99;} }
	    Text { anchors.left: arpMelQt.right; anchors.leftMargin: 5; y: arpMelQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: "arpejo(s)" }
	  }

    Text { x: 28; y: 90; font.pixelSize: 12; color: "#e0dfc3"; text: "Repetição de Ponto Focal";
      CheckBox { id: melPFs; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
	    	color: "#e0dfc3"; text: "Agudo"
        CheckBox { id: melPFi; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
  		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
  		   color: "#e0dfc3"; text: "Grave" }
  	     }
       }
	    }
    }
   }

	  Rectangle { x: 3; y: 451; width: 526; height: 50; color: "#303030"; radius: 2
      CheckBox { id: neutA; checked: true; x: 5; y: 5;
				Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
				       color: "#e0dfc3"; text: "Se não conduzir 6° e 7° alterados" }
				CheckBox { id: neutAim; checked: false; x: 220; y: 0;
				  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
				         color: "#e0dfc3"; text: "imediatamente" }}
	  	}
	  	CheckBox { id: neutN; checked: true; x: 5; y: 25;
				Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
				       color: "#e0dfc3"; text: "Se 6°/7° naturais sem neutralizar" }
				CheckBox { id: neutNim; checked: true; x: 220; y: 0;
				  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
				         color: "#e0dfc3"; text: "a menos de"
            TextInput { id: neutNqt; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;  font.underline: true;
              font.pixelSize: 12; color: "yellow"; text: "4"; validator: IntValidator{bottom: 2; top: 99;}
              Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
    				         color: "#e0dfc3"; text: "tempos da nota alterada" }
            }
          }
        }
	  	}
	 }

    Rectangle { x: 3; y: 505; width: 526; height: 50; color: "#303030"; radius: 2
     CheckBox { id: tonic; checked: true; x: 5; y:5;
		  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "Nota inicial do CF diferente de tônica/finalis," }

	   CheckBox { id: terça; checked: false; x: 275;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "terça," }
	   }
	   CheckBox { id: quinta; checked: false; x: 355;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "ou quinta" }
	   }
	  }
	   CheckBox { id: tonicF; checked: true; x: 5; y:25;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "Nota final do CF diferente de tônica/finalis," }
	   CheckBox { id: terçaF; checked: false; x: 270;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "terça," }
	   }
	   CheckBox { id: quintaF; checked: false; x: 350;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "ou quinta" }
	   }
	  }
   }
  }
 }
 Item { id: intervalosClasse; visible: false;
   Rectangle { x: 2; y: 35; width: 532; height: 551;	color: "#5a5a5a"; radius: 2
    Rectangle { x: 3; y: 3; width: 526; height: 545; color: "#333333"; radius: 2
     Rectangle { x: 3; y: 3; width: 520; height: 144; color: "#111111"; radius: 2
      CheckBox { id: intDissT1; checked: false; x: 3; y: 3;
       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 14; text: "Uníssono, 8ªJ, etc"
         CheckBox { id: intDissT1Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissT2; checked: true; x: 3; y: 23;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "2ªs, 9ªs, etc"
          CheckBox { id: intDissT2Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissT3; checked: false; x: 3; y: 43;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "3ªs, 10ªs, etc"
           CheckBox { id: intDissT3Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissT4; checked: true; x: 3; y: 63;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 14; text: "4ªJ, 11ªJ, etc"
            CheckBox { id: intDissT4Ex; checked: true; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                    font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissT5; checked: false; x: 3; y: 83;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 14; text: "5ªJ, 12ªJ, etc"
             CheckBox { id: intDissT5Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
              Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                     font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissT6; checked: false; x: 3; y: 103;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 14; text: "6ªs, 13ªs, etc"
              CheckBox { id: intDissT6Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
               Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                      font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissT7; checked: true; x: 3; y: 123;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "7ªs, 14ªs, etc"
           CheckBox { id: intDissT7Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
     }
     Rectangle { x: 3; y: 150; width: 520; height: 144; color: "#111111"; radius: 2
      CheckBox { id: intDissTad1; checked: true; x: 3; y: 3;
       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 14; text: "Uníssono aumentado ou diminuto"
         CheckBox { id: intDissTad1Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad2; checked: true; x: 3; y: 23;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "2ª aumentada ou diminuta"
          CheckBox { id: intDissTad2Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad3; checked: true; x: 3; y: 43;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "3ª aumentada ou diminuta"
           CheckBox { id: intDissTad3Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad4; checked: true; x: 3; y: 63;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 14; text: "4ª aumentada ou diminuta"
            CheckBox { id: intDissTad4Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                    font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad5; checked: true; x: 3; y: 83;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 14; text: "5ª aumentada ou diminuta"
             CheckBox { id: intDissTad5Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
              Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                     font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad6; checked: true; x: 3; y: 103;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 14; text: "6ª aumentada ou diminuta"
              CheckBox { id: intDissTad6Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
               Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                      font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad7; checked: true; x: 3; y: 123;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "7ª aumentada ou diminuta"
           CheckBox { id: intDissTad7Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
     }
     Rectangle { x: 3; y: 297; width: 520; height: 245; color: "#151515"; radius: 2
      CheckBox { id: intDissA0; checked: false; x: 3; y: 3;
       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 14; text: "Intervalo 0"
         CheckBox { id: intDissA0Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA1; checked: false; x: 3; y: 23;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 1"
          CheckBox { id: intDissA1Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA2; checked: false; x: 3; y: 43;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "Intervalo 2"
           CheckBox { id: intDissA2Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA3; checked: false; x: 3; y: 63;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 14; text: "Intervalo 3"
            CheckBox { id: intDissA3Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                    font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA4; checked: false; x: 3; y: 83;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 14; text: "Intervalo 4"
             CheckBox { id: intDissA4Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
              Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                     font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA5; checked: false; x: 3; y: 103;
          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 14; text: "Intervalo 5"
              CheckBox { id: intDissA5Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
               Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                      font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA6; checked: false; x: 3; y: 123;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "Intervalo 6"
           CheckBox { id: intDissA6Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA7; checked: false; x: 3; y: 143;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 7"
          CheckBox { id: intDissA7Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA8; checked: false; x: 3; y: 163;
         Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "Intervalo 8"
           CheckBox { id: intDissA8Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA9; checked: false; x: 3; y: 183;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 9"
          CheckBox { id: intDissA9Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA10; checked: false; x: 3; y: 203;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 10"
          CheckBox { id: intDissA10Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA11; checked: false; x: 3; y: 223;
        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 11"
          CheckBox { id: intDissA11Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
     }
    }
   }
 }
} // window

//--------------------------------------------------------------------------------
 // janela com as mensagens de resultado
	ApplicationWindow {
      id: msgResult
	    visible: false;
	    title: "Resultado"
	    width: 450; height: 40
	    color: "#343530"

	    Rectangle {
          id: btResult
          property alias text: lresult.text
          signal clicked
          visible: true
          width: 100; height: 25
          x: 110
          border { width: 1; color: "#555555" }
          smooth: true
          radius: 3
          gradient: Gradient {
              GradientStop { position: 0.0
                  color: {
                        if (mArea6.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#035b25" }
            }

         Text {
           id: lresult
           anchors.centerIn: parent
           text: "Fechar"
           color: "#aaf0e1"
         }

         MouseArea {
          id: mArea6
          anchors.fill: parent
          onClicked: { window.raise(); msgResult.close(); apagaCor(); return }
         } // mouseArea
       } // Rectangle btResult

      Rectangle {
          id: btAtualiza
          property alias text: latual.text
          signal clicked
          visible: true
          width: 100; height: 25
          x: 240
          border { width: 1; color: "#555555" }
          smooth: true
          radius: 3
          gradient: Gradient {
              GradientStop { position: 0.0
                  color: {
                        if (mArea61.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#035b25" }
            }

         Text {
           id: latual
           anchors.centerIn: parent
           text: "Atualizar"
           color: "#aaf0e1"
         }

         MouseArea {
          id: mArea61
          anchors.fill: parent
          onClicked: { msgResult.close(); apagaCor(); verificar(); }
         } // mouseArea
       } // Rectangle btAtualiza

	  Component {
	    id: component
	    Rectangle {
          id: msg
          property alias text: lResul.text
          property int value: 0
          signal clicked
          visible: true
          width: 450; height: 21
          border { width: 1; color: "#000000" }
          smooth: true
          radius: 3
          color: "#6c6d6d"

         Text {
           id: lResul
           anchors.left: parent.left; anchors.leftMargin: 3
           anchors.verticalCenter: parent.verticalCenter
           text: "-"
           color: "#aaf0e1"
         }

         MouseArea {
          id: msgClick
          anchors.fill: parent
          onClicked: { colorir(parent.value); }
          }
       } // retângulo msg
	  } // componente
 } // msgResult
// ----------------------------------------------------------------------------------------------------------------
   MessageDialog {
      id: msgErros
      title: "Erros!"
      text: "-"
      property bool estado: false
      onAccepted: {
            msgErros.visible=false;
      }

      visible: false;
} // msgErros
// -----------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------
  // ---- variáveis globais ----

      property bool processaTudo: false;
      property var vozes: [];
      property var resultado: [];
      property var mensagem: [];
      property var verificados: 0;
      property var acordeGrau: [];
      property var vozCF: null;
      property bool priEsp: false;
      property bool secEsp: false;
      property bool terEsp: false;
      property bool quaEsp: false;
      property bool quiEsp: false;
      property bool melodia: false;
      property bool livreCP: false;
      property bool finaliza: false;
      property var config: [];
      property var tipoCP: null;

// ----------- funções ---------
function atualizarTitulo() {
  if (melodia) { titulo2.text = "Cantus Firmus:"; tipoCP = 0; };
  if (priEsp) { titulo2.text = "1ª espécie:"; tipoCP = 1;};
  if (secEsp) { titulo2.text = "2ª espécie:"; tipoCP = 2;};
  if (terEsp) { titulo2.text = "3ª espécie:"; tipoCP = 3;};
  if (quaEsp) { titulo2.text = "4ª espécie:"; tipoCP = 4;};
  if (quiEsp) { titulo2.text = "5ª espécie:"; tipoCP = 5;};
  if (livreCP) { titulo2.text = "Contraponto livre:"; tipoCP = 6;};
  if (melodias.visible) { titulo1.text = "construção melódica" };
  if (dissonâncias.visible) { titulo1.text = "tratamento de dissonâncias" };
  if (gerais.visible) { titulo1.text = "condução de vozes e outros aspectos" };
  if (intervalosClasse.visible) { titulo1.text = "Seleção de intervalos dissonântes" };
}

function salvarCfg() {

   var j = 168 * tipoCP;
//console.log("salvarCfg ", tipoCP," j = ", j);
 // ---------------- gerais -----------
   if(primInt.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ex5Ji.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ex3i.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ultInt.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ex5Jf.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ex3f.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ultNotas.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(quartaJi.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(quartaJs.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(paralela8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = par8Rep.text; j++;
   if(paralela5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = par5Rep.text; j++;
   if(paralela4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = par4Rep.text; j++;
   if(paralela36.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = par36Rep.text; j++;
   if(oculta8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(oculta5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ocultEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ocultSalto.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(inter8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(inter5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExFim.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExCF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(consecObli.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(consecCont.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(uniss.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = unissQt.text; j++;
   if(unissIF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(unissTF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cruzaVozes.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(falsaR.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(distancia.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = distQt.text; j++;
   config[j] = distInt.text; j++;
   if(consImp.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmonia.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmoniaEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
 // -------------- Dissonancias -----------
   if(dissonanciasG.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passagemL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passaLEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraLI.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraLS.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraD.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiataL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspensãoL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspeLEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspeLEx1a.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspeLEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspeLEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(antecipaL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(antecipaEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(antecipaEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(antecipaEx4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaturaL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(escapadaL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(escapaEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
 // -------------- melodia -------------
   if(peNota.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ambito.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = ambInp.text; j++;
   if(priviGC.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(priviGCEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(salt7.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(salt6.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(salt6Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltAum.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(tritono2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(tritono1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(dissoC.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltC.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltM.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltMEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltCEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltCEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM5Ex1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM5Ex2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(varDir.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = varDirQt.text; j++;
   if(repNota.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = repNotaQt.text; j++;
   if(repeteNoutra.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(repPad.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = repPadQt.text; j++;
   if(arpMel.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = arpMelQt.text; j++;
   if(melPFs.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(melPFi.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(neutA.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(neutAim.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(neutN.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(neutNim.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = neutNqt.text; j++;
   if(tonic.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(terça.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(quinta.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(tonicF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(terçaF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(quintaF.checked){ config[j] = true; } else { config[j] = false; }; j++;
  // ----------------------- Intervalos ------------------------------
   if(intDissT1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT1Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT2Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT3Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT4Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT5Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT6.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT6Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT7.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT7Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad1Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad2Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad3Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad4Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad5Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad6.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad6Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad7.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad7Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA0.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA0Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA1Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA2Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA3Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA4Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA5Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA6.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA6Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA7.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA7Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA8Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA9.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA9Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA10.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA10Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA11.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA11Ex.checked){ config[j] = true; } else { config[j] = false; }; //console.log("salvarCfg j = ", j, "config[0]", config[0]);
}

function carregarCfg() {

   var j = 168 * tipoCP;

   // ---------------- gerais -----------
     primInt.checked = config[j]; j++;
     ex5Ji.checked = config[j]; j++;
     ex3i.checked = config[j]; j++;
     ultInt.checked = config[j]; j++;
     ex5Jf.checked  = config[j]; j++;
     ex3f.checked = config[j]; j++;
     ultNotas.checked = config[j]; j++;
     quartaJi.checked = config[j]; j++;
     quartaJs.checked = config[j]; j++;
     paralela8.checked = config[j]; j++;
     par8Rep.text = config[j]; j++;
     paralela5.checked = config[j]; j++;
     par5Rep.text = config[j]; j++;
     paralela4.checked = config[j]; j++;
     par4Rep.text = config[j]; j++;
     paralela36.checked = config[j]; j++;
     par36Rep.text = config[j]; j++;
     oculta8.checked = config[j]; j++;
     oculta5.checked = config[j]; j++;
     ocultEx.checked = config[j]; j++;
     ocultSalto.checked = config[j]; j++;
     inter8.checked = config[j]; j++;
     inter5.checked = config[j]; j++;
     interExTf.checked = config[j]; j++;
     interExTf1.checked = config[j]; j++;
     interExTf2.checked = config[j]; j++;
     interExTF.checked = config[j]; j++;
     interExFim.checked = config[j]; j++;
     interExCF.checked = config[j]; j++;
     consecObli.checked = config[j]; j++;
     consecCont.checked = config[j]; j++;
     uniss.checked = config[j]; j++;
     unissQt.text = config[j]; j++;
     unissIF.checked = config[j]; j++;
     unissTF.checked = config[j]; j++;
     cruzaVozes.checked = config[j]; j++;
     falsaR.checked = config[j]; j++;
     distancia.checked = config[j]; j++;
     distQt.text = config[j]; j++;
     distInt.text = config[j]; j++;
     consImp.checked = config[j]; j++;
     cHarmonia.checked = config[j]; j++;
     cHarmoniaEx.checked = config[j]; j++;
   // -------------- Dissonancias -----------
     dissonanciasG.checked = config[j]; j++;
     passagemL.checked = config[j]; j++;
     passaLEx.checked = config[j]; j++;
     bordaduraLI.checked = config[j]; j++;
     bordaduraLS.checked = config[j]; j++;
     bordaduraD.checked = config[j]; j++;
     bordaLEx.checked = config[j]; j++;
     bordaLEx1.checked = config[j]; j++;
     bordaLEx2.checked = config[j]; j++;
     cambiataL.checked = config[j]; j++;
     cambiLEx1.checked = config[j]; j++; //
     cambiLEx2.checked = config[j]; j++;
     cambiLEx3.checked = config[j]; j++;
     cambiLEx4.checked = config[j]; j++;
     cambiLEx5.checked = config[j]; j++;
     suspensãoL.checked = config[j]; j++;
     suspeLEx1.checked = config[j]; j++; //
     suspeLEx1a.checked = config[j]; j++; //
     suspeLEx2.checked = config[j]; j++;
     suspeLEx3.checked = config[j]; j++;
     antecipaL.checked = config[j]; j++;
     antecipaEx2.checked = config[j]; j++;
     antecipaEx3.checked = config[j]; j++;
     antecipaEx4.checked = config[j]; j++;
     apojaturaL.checked = config[j]; j++;
     apojaEx1.checked = config[j]; j++;
     apojaEx2.checked = config[j]; j++;
     apojaEx3.checked = config[j]; j++;
     escapadaL.checked = config[j]; j++;
     escapaEx1.checked = config[j]; j++;
   // -------------- melodia -------------
     peNota.checked = config[j]; j++;
     ambito.checked = config[j]; j++;
     ambInp.text = config[j]; j++;
     priviGC.checked = config[j]; j++;
     priviGCEx.checked = config[j]; j++;
     salt7.checked = config[j]; j++;
     salt6.checked = config[j]; j++;
     salt6Ex.checked = config[j]; j++;
     saltAum.checked = config[j]; j++;
     saltM8.checked = config[j]; j++;
     tritono2.checked = config[j]; j++;
     tritono1.checked = config[j]; j++;
     dissoC.checked = config[j]; j++;
     doisSaltC.checked = config[j]; j++;
     doisSaltM.checked = config[j]; j++;
     doisSaltMEx.checked = config[j]; j++;
     doisSaltCEx1.checked = config[j]; j++;
     doisSaltCEx2.checked = config[j]; j++;
     saltM5.checked = config[j]; j++;
     saltM5Ex1.checked = config[j]; j++;
     saltM5Ex2.checked = config[j]; j++;
     varDir.checked = config[j]; j++;
     varDirQt.text = config[j]; j++;
     repNota.checked = config[j]; j++;
     repNotaQt.text = config[j]; j++;
     repeteNoutra.checked = config[j]; j++;
     repPad.checked = config[j]; j++;
     repPadQt.text = config[j]; j++;
     arpMel.checked = config[j]; j++;
     arpMelQt.text = config[j]; j++;
     melPFs.checked = config[j]; j++;
     melPFi.checked = config[j]; j++;
     neutA.checked = config[j]; j++;
     neutAim.checked = config[j]; j++;
     neutN.checked = config[j]; j++;
     neutNim.checked = config[j]; j++;
     neutNqt.text = config[j]; j++;
     tonic.checked = config[j]; j++;
     terça.checked = config[j]; j++;
     quinta.checked = config[j]; j++;
     tonicF.checked = config[j]; j++;
     terçaF.checked = config[j]; j++;
     quintaF.checked = config[j]; j++;
    // ----------------------- Intervalos ------------------------------
     intDissT1.checked = config[j]; j++;
     intDissT1Ex.checked = config[j]; j++;
     intDissT2.checked = config[j]; j++;
     intDissT2Ex.checked = config[j]; j++;
     intDissT3.checked = config[j]; j++;
     intDissT3Ex.checked = config[j]; j++;
     intDissT4.checked = config[j]; j++;
     intDissT4Ex.checked = config[j]; j++;
     intDissT5.checked = config[j]; j++;
     intDissT5Ex.checked = config[j]; j++;
     intDissT6.checked = config[j]; j++;
     intDissT6Ex.checked = config[j]; j++;
     intDissT7.checked = config[j]; j++;
     intDissT7Ex.checked = config[j]; j++;
     intDissTad1.checked = config[j]; j++;
     intDissTad1Ex.checked = config[j]; j++;
     intDissTad2.checked = config[j]; j++;
     intDissTad2Ex.checked = config[j]; j++;
     intDissTad3.checked = config[j]; j++;
     intDissTad3Ex.checked = config[j]; j++;
     intDissTad4.checked = config[j]; j++;
     intDissTad4Ex.checked = config[j]; j++;
     intDissTad5.checked = config[j]; j++;
     intDissTad5Ex.checked = config[j]; j++;
     intDissTad6.checked = config[j]; j++;
     intDissTad6Ex.checked = config[j]; j++;
     intDissTad7.checked = config[j]; j++;
     intDissTad7Ex.checked = config[j]; j++;
     intDissA0.checked = config[j]; j++;
     intDissA0Ex.checked = config[j]; j++;
     intDissA1.checked = config[j]; j++;
     intDissA1Ex.checked = config[j]; j++;
     intDissA2.checked = config[j]; j++;
     intDissA2Ex.checked = config[j]; j++;
     intDissA3.checked = config[j]; j++;
     intDissA3Ex.checked = config[j]; j++;
     intDissA4.checked = config[j]; j++;
     intDissA4Ex.checked = config[j]; j++;
     intDissA5.checked = config[j]; j++;
     intDissA5Ex.checked = config[j]; j++;
     intDissA6.checked = config[j]; j++;
     intDissA6Ex.checked = config[j]; j++;
     intDissA7.checked = config[j]; j++;
     intDissA7Ex.checked = config[j]; j++;
     intDissA8.checked = config[j]; j++;
     intDissA8Ex.checked = config[j]; j++;
     intDissA9.checked = config[j]; j++;
     intDissA9Ex.checked = config[j]; j++;
     intDissA10.checked = config[j]; j++;
     intDissA10Ex.checked = config[j]; j++;
     intDissA11.checked = config[j]; j++;
     intDissA11Ex.checked = config[j];
}

function openFile(fileUrl) {
  console.log(fileUrl)
    var request = new XMLHttpRequest();
    request.open("GET", fileUrl, false);
    request.send(null);
    var preSet = request.responseText.split("\n");

    nomePre.text = fileUrl;
    var nomeSplit = nomePre.text.split('/');
    nomePre.text = nomeSplit[nomeSplit.length-1];
console.log("Carregou presets:", preSet.length-1)
    for (var i=0;i<preSet.length-1;i++) {
      if (preSet[i] == "true") { preSet[i] = true; } else
      if (preSet[i] == "false") { preSet[i] = false; };
      config[i] = preSet[i];
      //console.log(i, config[i]);
    };

  carregarCfg();
    //return request.responseText;
}

function saveFile(fileUrl, text) {
    var request = new XMLHttpRequest();
    request.open("PUT", fileUrl, false);
    var conteudoArquivo = "";
console.log("Salvou presets:", config.length);
  for (var j = 0; j < config.length; j++) {
    conteudoArquivo+=config[j]+"\n";
  };

    request.send(conteudoArquivo);
    return request.status;
}

FileDialog {
    id: openFileDialog
    nameFilters: ["All files (*)"]
    onAccepted: openFile(openFileDialog.fileUrl)
}

FileDialog {
    id: saveFileDialog
    selectExisting: false
    nameFilters: ["Text files (*.txt)", "All files (*)"]
    onAccepted: saveFile(saveFileDialog.fileUrl, "")
}

function colorir(valor) {

     curScore.startCmd();

      apagaCor();

      mensagem[valor-1].color = "#6b6746";

      for (var z=1;z<resultado[valor].length;z++) {
            if (resultado[valor][z]) { resultado[valor][z].color = "red"; };
         };

      curScore.endCmd();

      msgResult.raise();
   }

function apagaCor() {

      for (var x=1;x<=verificados;x++) { // apaga seleções anteriores e botões

	         mensagem[x-1].color = "#6c6d6d";

	      for (var z=1;z<resultado[x].length;z++) {
            if (resultado[x][z]) { resultado[x][z].color = "black"; };
         };

	    };

   }

function destroirMsg() {
    for (var i=0;i<verificados;i++) {
     if (mensagem[i]) {
     	mensagem[i].destroy();
     };
	 };
}

function removeRepetição(tpc) {  //
  var acordeX = [];
  for (var i = 0;i < tpc.length; i++){
        if(acordeX.indexOf(tpc[i]) == -1){
            acordeX.push(tpc[i]);
        };
  };
  return acordeX;
}

function verificaGrauMelodico(nota,x) {
  texto2tonica(vozes[x].tom);
  var tom = tonicaTPC(btTonica.text, btAcid.text);
  var x = nota - tom;
 	var modo = btModo.text;

  switch(modo) {
  	case "Maior":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case 4: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case 3: return 6;
  	 	case 5: return 7;
    };
      msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      msgErros.estado=true; return "NA";
  	case "Menor":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case -4: return 6;
  	 	case 3: return "6+";
  	 	case -2: return 7;
  	 	case 5: return "7+";
  	 };
       msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
       msgErros.estado=true; return "NA";
  	case "Jônico":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case 4: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case 3: return 6;
  	 	case 5: return 7;
      case -2: return "7-";
    };
      msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      msgErros.estado=true; return "NA";
  	case "Dórico":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case 3: return 6;
      case -4: return "6-";
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
      msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      msgErros.estado=true; return "NA";
  	case "Frígio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case -5: return 2;
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
      case -6: return "5-";
  	 	case -4: return 6;
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
      msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      msgErros.estado=true; return "NA";
  	case "Lídio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case 4: return 3;
  	 	case 6: return 4;
      case -1: return "4-";
  	 	case 1: return 5;
  	 	case 3: return 6;
  	 	case 5: return 7;
  	 };
     msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     msgErros.estado=true; return "NA";
  	case "Mixolídio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case 4: return 3;
      case -3: return "3-";
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case 3: return 6;
  	 	case -2: return 7;
  	 };
     msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     msgErros.estado=true; return "NA";
  	case "Eólio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
      case -5: return "2-";
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case -4: return 6;
      case 3: return "6+";
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
     msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     msgErros.estado=true; return "NA";
  	case "Lócrio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case -5: return 2;
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case -6: return 5;
  	 	case -4: return 6;
      case 3: return "6+";
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
     msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     msgErros.estado=true; return "NA";
  }
 }

function verificaTempoForte(tempo,metrica) {
  if (tempo%1 > 0) { return "c" };
   switch(metrica) {
    case 1:
    case 2:
    case 3: if (tempo == 1) { return "F"; } else { return "f"; };
      break;
    case 4: if (tempo == 1 || tempo == 3) { return "F"; } else { return "f"; };
      break;
    case 6: if (tempo == 1 || tempo == 4) { return "F"; } else { return "f"; };
      break;
    case 8: if (tempo == 1 || tempo == 3 || tempo == 5 || tempo == 7) { return "F"; } else { return "f"; };
      break;
    case 9: if (tempo == 1 || tempo == 4 || tempo == 7) { return "F"; } else { return "f"; };
      break;
    case 12: if (tempo == 1 || tempo == 4 || tempo == 7 || tempo == 10) { return "F"; } else { return "f"; };
      break;
   };

}

function verificaConsonancia(x) {
  var int1 = x % 12;
  if (int1 == 0 || int1 == 7) { return "CP"; } else
  if (int1 == 3 || int1 == 4 || int1 == 8 || int1 == 9) { return "CI"; } else { return "D" };
}

function direção(x) {
            if (x > 0) return(1); //  ascendente
            else if (x == 0) return(0); // sem direção
            else return(-1); // descendente
      }

function tonicaTPC(nome,acidente) {

   var tonica = nome+acidente
   switch (tonica) {
     case "Dó": return 14; break;
     case "Dó#": return 21; break;
     case "Dób": return 7; break;
     case "Ré": return 16; break;
     case "Ré#": return 23; break;
     case "Réb": return 9; break;
     case "Mi": return 18; break;
     case "Mi#": return 25; break;
     case "Mib": return 11; break;
     case "Fá": return 13; break;
     case "Fá#": return 20; break;
     case "Fáb": return 6; break;
     case "Sol": return 15; break;
     case "Sol#": return 22; break;
     case "Solb": return 8; break;
     case "Lá": return 17; break;
     case "Lá#": return 24; break;
     case "Láb": return 10; break;
     case "Si": return 19; break;
     case "Si#": return 26; break;
     case "Sib": return 12; break;
   }
}

function tonicaPC(nome,acidente) {
  var a, b;
   switch (nome) {
     case "Dó": a = 0; break;
     case "Ré": a = 2; break;
     case "Mi": a = 3; break;
     case "Fá": a = 5; break;
     case "Sol": a = 7; break;
     case "Lá": a = 9; break;
     case "Si": a = 11;
   };
   if (acidente == "#") { b = 1; } else
     if (acidente == "b") { b = -1; } else { b = 0; };

   return a + b;
}

function n2m(texto) { // converte nota (formato nome + oitava: C4) para nota midi (int)
  if (texto.length > 3 || texto.length < 2) { msgErros.text += "Índice inválido para o cálculo da extensão das vozes!\n";
                                              msgErros.estado = true; return null; } else
  if (texto.length == 2) {var nota = texto.substr(0,1);} else { var nota = texto.substr(0,2); };

  nota = nota.toUpperCase();

  switch(nota.substr(0,1)) {
   case "C": var midi = 0; break;
   case "D": var midi = 2; break;
   case "E": var midi = 4; break;
   case "F": var midi = 5; break;
   case "G": var midi = 7; break;
   case "A": var midi = 9; break;
   case "B": var midi = 11; break;
  };

  if (nota.length == 2) {
   switch(nota.substr(1,1)) {
    case "#": midi = midi + 1; break;
    case "B": midi = midi - 1; break;
   };
  };

  var oitava = parseInt(texto.substr(-1,1));
  if (oitava > 5 || oitava < 1) { msgErros.text += "Índice inválido para o cálculo da extensão das vozes!\n";
                                  msgErros.estado = true; return null; };

  switch(oitava) {
  	case 1: midi = midi + 36; break;
  	case 2: midi = midi + 48; break;
  	case 3: midi = midi + 60; break;
  	case 4: midi = midi + 72; break;
  	case 5: midi = midi + 84; break;
  };

  return midi;

}

function semi2Int(st) { // converte qt de semitons para intervalos
  switch(st){
   case 0: return "U";
   case 1:
   case 2: return 2;
   case 3:
   case 4: return 3;
   case 5: return 4;
   case 6: return "trit";
   case 7: return 5;
   case 8:
   case 9: return 6;
   case 10:
   case 11: return 7;
   case 12: return 8;
   case 13:
   case 14: return 9;
   case 15:
   case 16: return 10;
   case 17: return 11;
   case 18: return "trit+";
   case 19: return 12
   case 20:
   case 21: return 13;
   case 22:
   case 23: return 14;
   case 24: return 15;
  };
}

function tpc2Int(st) { // converte intervalo tpc para intervalos
  switch(st){
   case -7: return "Ud"
   case 0: return "UJ";
   case 7: return "Ua";
   case -12: return "2d";
   case -5: return "2m";
   case 2: return "2M";
   case 9: return "2a";
   case -10: return "3d";
   case -3: return "3m";
   case 4: return "3M";
   case 11: return "3a";
   case -8: return "4d";
   case -1: return "4J";
   case 6: return "4a";
   case -6: return "5d";
   case 1: return "5J";
   case 8: return "5a";
   case -11: return "6d";
   case -4: return "6m";
   case 3: return "6M";
   case 10: return "6a";
   case -9: return "7d";
   case -2: return "7m";
   case 5: return "7M";
   case 12: return "7a";
  };
}

function sePertence(acorde, nota) { // verifica se 'nota' pertence ao 'acorde'
  for (var k = 0; k < acorde.length; k++) {
    if (acorde[k] == nota) { return true };
  };
  return false;
}

function texto2tonica(texto){
  if (!texto) { return; };
  texto = texto.split(" ");
  if (texto[0].substr(-1, 1) == "#") {
    texto[0] = texto[0].substr(0, texto[0].length-1); menuAcid.value = 2; btAcid.text = "#"; } else
    if (texto[0].substr(-1, 1) == "b") {
      texto[0] = texto[0].substr(0, texto[0].length-1); menuAcid.value = 3; btAcid.text = "b"; }
      else { menuAcid.value = 1; btAcid.text = ""; };
  var texto0 = texto[0].toUpperCase();
  switch (texto0) {
    case "DÓ": menuTonica.value = 1; btTonica.text = "Dó"; break;
    case "RÉ": menuTonica.value = 2; btTonica.text = "Ré"; break;
    case "MI": menuTonica.value = 3; btTonica.text = "Mi"; break;
    case "FÁ": menuTonica.value = 4; btTonica.text = "Fá"; break;
    case "SOL": menuTonica.value = 5; btTonica.text = "Sol"; break;
    case "LÁ": menuTonica.value = 6; btTonica.text = "Lá"; break;
    case "SI": menuTonica.value = 7; btTonica.text = "Si"; break;
  };
  var texto1 = texto[1].toUpperCase(); //console.log("texto1", texto1);
  switch (texto1) {
    case "MAIOR": menuModo.value = 1; btModo.text = "Maior"; break;
    case "MENOR": menuModo.value = 2; btModo.text = "Menor"; break;
    case "JÔNICO": menuModo.value = 3; btModo.text = "Jônico"; break;
    case "DÓRICO": menuModo.value = 4; btModo.text = "Dórico"; break;
    case "FRÍGIO": menuModo.value = 5; btModo.text = "Frígio"; break;
    case "LÍDIO": menuModo.value = 6; btModo.text = "Lídio"; break;
    case "MIXOLÍDIO": menuModo.value = 7; btModo.text = "Mixolídio"; break;
    case "EÓLIO": menuModo.value = 8; btModo.text = "Eólio"; break;
    case "LÓCRIO": menuModo.value = 9; btModo.text = "Lócrio"; break;
  };
}

function cifra2notas(cifra,x) { // analisa uma 'cifra' e retorna a estrutura intervalar do acorde (em intervalos tonais)
  if (!cifra) { console.log("Erro(cifra2notas)! não contém cifra!!"); return; };
  var notas = [];
  texto2tonica(vozes[x].tom);
  var modo = btModo.text;
  var f; // fundamental
  var m; // variável para designar aumentado ou diminuto
  var d; // variavel para dissonancia
  var cifraM = cifra.toUpperCase();
  var idx1 = cifraM.lastIndexOf("I") + 1;
  var idx2 = cifraM.lastIndexOf("V") + 1;
  if (idx1 > idx2) { var i = idx1;  } else { var i = idx2; }; // i = posição do ultimo caracter que indica o grau

  switch (cifra.substr(i, 1)) { // define se aumentado ou diminuto
    case "°":
    case "º":
    case "dim":
    case "d":
    case "-": m = 0; break;
    case "+":
    case "a":
    case "aum": m = 1; break;
    default: m = null;
  };

  if (m != null) { d = cifra.substr(i+1); } else { d = cifra.substr(i);};
  var grau = cifra.slice(0, i);
  var grauM = grau.toUpperCase();
  if (modo == "Menor" && grauM == "VI" && m == 0) { var grauF = "VI+" } else
    if (modo == "Menor" && grauM == "VII" && m == 0) { var grauF = "VII+" }
      else { var grauF = grauM; };
    //  console.log("modo e grauF:", modo, grauF);
  switch (grauF) { // define fundamental
    case "I": f = 0; break;
    case "II":
       switch (modo){
        case "Maior":
        case "Menor":
        case "Jônico":
        case "Dórico":
        case "Lídio":
        case "Mixolídio":
        case "Eólio": f = 2; break;
        case "Frígio":
        case "Lócrio": f = -5; break;
      }; break;
    case "III":
        switch (modo){
         case "Maior":
         case "Jônico":
         case "Lídio":
         case "Mixolídio": f = 4; break;
         case "Menor":
         case "Dórico":
         case "Frígio":
         case "Eólio":
         case "Lócrio": f = -3; break;
       }; break;
    case "IV":
       switch (modo){
        case "Maior":
        case "Menor":
        case "Jônico":
        case "Dórico":
        case "Frígio":
        case "Mixolídio":
        case "Eólio":
        case "Lócrio": f = -1; break;
        case "Lídio": f = 6; break;
      }; break;
    case "V":
       switch (modo){
        case "Maior":
        case "Menor":
        case "Jônico":
        case "Dórico":
        case "Frígio":
        case "Lídio":
        case "Mixolídio":
        case "Eólio": f = 1; break;
        case "Lócrio": f = -6; break;
      }; break;
    case "VI":
       switch (modo){
        case "Maior":
        case "Jônico":
        case "Dórico":
        case "Lídio":
        case "Mixolídio": f = 3; break;
        case "Menor":
        case "Frígio":
        case "Eólio":
        case "Lócrio": f = -4; break;
      }; break;
    case "VI+": f = 3; break;
    case "VII":
       switch (modo){
        case "Maior":
        case "Jônico":
        case "Lídio": f = 5; break;
        case "Menor":
        case "Dórico":
        case "Frígio":
        case "Mixolídio":
        case "Eólio":
        case "Lócrio": f = -2; break;
      }; break;
    case "VII+": f = 5; break;
    default: msgErros.text += "Não foi encontrado o grau do acorde na cifra, para a verificação de Coerência Harmônica!\n";
             msgErros.estado=true; return;
   };

   if (grau == grauM && !m) { notas = [0+f, 4+f, 1+f]; } else
   if (grau != grauM && !m) { notas = [0+f, -3+f, 1+f]; } else
   if (grau != grauM && m == 0) { notas = [0+f, -3+f, -6+f]; } else
   if (grau == grauM && m == 1) { notas = [0+f, 4+f, 8+f]; };
  //console.log(grau, grauM, m, "notas:", notas);
   switch (d) {
     case "7": notas.push(-2+f); break;
     case "7+":
     case "7M": notas.push(5+f); break;
     case "7-":
     case "7d": notas.push(-9+f); break;
   };
   return notas;
}

function vCantusFirmus() {

	vozCF = parseInt(vozCantusFirmus.text) - 1;

  if (vozCF >= vozes[vozes.length-1].nota.length || vozCF < 0) {
          msgErros.text = "Erro! \n voz do Cantus Firmus não detectado! \n Por favor, insira um valor válido.";
                       msgErros.visible=true; finaliza = true; return; };
}
//-----------------------------------------------
function verificar() {
 vozCF = null;
 finaliza = false;
 msgErros.text = "";
 msgErros.estado = false;
 msgResult.height = 40;

 if (!priEsp && !secEsp && !terEsp && !quaEsp && !quiEsp && !melodia && !livreCP) {
          msgErros.text += "Erro! \n Nenhuma tipo de contraponto selecionado!\n Utilize a barra laterial para selecionar.";
                       msgErros.visible=true; return; };

 destroirMsg();
 resultado = [];

 carregarNotas();
 vCantusFirmus();

 if (finaliza) { return; };
 //mostraIntervalos();
 // --------------- melodia --------------------
 if (peNota.checked) { penultimaNota(); };
 if (ambito.checked) { ambitoMelodico(); };
 if (priviGC.checked) { privilegiaConj(); };
 if (salt7.checked) { melodia7(); };
 if (salt6.checked) { melodia6(); };
 if (saltAum.checked) { melodiaAum(); };
 if (saltM8.checked) { melodia8(); };
 if (tritono2.checked) { tritono2Ext(); };
 if (tritono1.checked) { tritono1Ext(); };
 if (dissoC.checked) { melodiaDC(); };
 if (saltM5.checked) { melodia5(); };
 if (varDir.checked) { variedadeDirecionamento(); };
 if (repNota.checked) { repetiçãoNotas(); };
 if (repPad.checked) { repetePadrão(); };
 if (arpMel.checked) { melodiaArpejo(); };
 if (melPFs.checked || melPFi.checked) { melodiaPF(); };
 if (btModo.text != "Maior" && (neutA.checked || neutN.checked)) { neutralterações(); };
 if (melodia && (tonic.checked || tonicF.checked)) { notaIniFin(); };
 if (doisSaltM.checked) { doisSaltosMdireção(); };
 if (doisSaltC.checked) { doisSaltosMContra(); };
 // --------------- gerais ------------
 if (!melodia && (paralela5.checked || paralela8.checked)) { quintasOitavas(); };
 if (!melodia && paralela4.checked) { quartas(); };
 if (!melodia && paralela36.checked) { terçasSextas(); };
 if (!melodia && (oculta5.checked || oculta8.checked)) { ocultas(); };
 if (!melodia && (consecObli.checked || consecCont.checked)) { consecutivas(); };
 if (!melodia && (inter5.checked || inter8.checked)) { intermitentes(); };
 if (!melodia && uniss.checked) { unissono(); };
 if (!melodia && cruzaVozes.checked) { cruzamento(); };
 if (!melodia && falsaR.checked) { falsaRelação(); };
 if (!melodia && distancia.checked) { espaçamento(); };
 if (!melodia && (primInt.checked || ultInt.checked)) { primUltIntervalo(); };
 if (!melodia && ultNotas.checked) { alcançarMovContra(); };
 if (!melodia && consImp.checked) { consonancias(); };
 if (melodia || !dissonanciasG.checked) { coerenciaHarmonica(); };
 if (cHarmoniaF.checked) { coerHarmFund(); };
 // --------------- dissonâncias --------------
 if (!melodia && dissonanciasG.checked) { dissonanciasL(); };
 // ----------------------------------------------

  resultado = removeRepetição(resultado);
  for (var i=0;i<verificados;i++) {
  	mensagem[i] = component.createObject(msgResult);
  	mensagem[i].y = i*25 + 40;
  	mensagem[i].text = resultado[i+1][0];
  	mensagem[i].value = i+1;
  	msgResult.height = i*25 + 70;
  };

  msgResult.visible = true;

  if (msgErros.estado) { msgErros.visible = true; };
}
//---------------------------------------
function carregarNotas() {

  console.log("Contraponto .............................................. Rogério Tavares Constante - 2019(c)")

  if (typeof curScore == 'undefined' || curScore == null) { // verifica se há partitura
     console.log("nenhuma partitura encontrada");
     msgErros.text = "Erro! \n Nenhuma partitura encontrada!";
                       msgErros.visible=true; finaliza = true; return; };

  curScore.startCmd(); // atualizar a leitura dos texto de harmonia ------------
  cmd("transpose-up"); cmd("transpose-down"); cmd("undo"); cmd("undo");
  curScore.endCmd(); //  (don't know if it's necessary to restart cmd)
  //----------------------------------------------------------------------------

  //procura por uma seleção
  var pautaInicial;
  var pautaFinal;
  var posFinal;
  var posInicial;
  processaTudo = false;
  vozes = [];
  var cursor = curScore.newCursor();

  cursor.rewind(1);

    if (!cursor.segment) {
       // no selection
       console.log("nenhuma seleção: processando toda partitura");
       processaTudo = true;
       pautaInicial = 0;
       pautaFinal = curScore.nstaves;

     } else {
       pautaInicial = cursor.staffIdx;
       posInicial = cursor.tick;
       cursor.rewind(2);
       pautaFinal = cursor.staffIdx + 1;
       posFinal = cursor.tick;
          if(posFinal == 0) {  // se seleção vai até o final da partitura, a posição do fim da seleção (rewind(2)) é 0.
          							// para poder calcular o tamanho do segmento, pega a última posição da partitura (lastSegment.tick) e adiciona 1.
          posFinal = curScore.lastSegment.tick + 1;
          }
       cursor.rewind(1);
    };

  // ------------------ inicializa variáveis de dados

            var seg = 0;
            var carregou;
            verificados = 0;
            var trilha;
            var trilhaInicial = pautaInicial * 4;
            var trilhaFinal = pautaFinal * 4;
            var compasso = 0;
            var compassoAtual = null;
            var tiqueComp = 0;

          if (!processaTudo) {
            cursor.rewind(0);
            while (cursor.segment && cursor.segment.tick < posInicial) {
     	       if (cursor.measure != compassoAtual) {
           	   compasso++;
           	   compassoAtual = cursor.measure;
           	 };
           	 cursor.next();
            };
          };

            // lê as informações da seleção (ou do documento inteiro, caso não haja seleção)

            if(processaTudo) { // posiciona o cursor no início
                  cursor.rewind(0); } else { cursor.rewind(1); };

            var segmento = cursor.segment;

            var pausa = false;

           while (segmento && (processaTudo || segmento.tick < posFinal)) {

           	var denominador = cursor.timeSignature.denominator;
            var numerador = cursor.timeSignature.numerator;

           	carregou = false;

           	 if (cursor.measure != compassoAtual) {
           	   compasso++;
           	   compassoAtual = cursor.measure;
           	   tiqueComp = segmento.tick;
           	 };

             var tempo = ((segmento.tick - tiqueComp) / (1920 / denominador)) + 1;
             var voz = 0;
             var cifras, tom;
             for (var cif = 0; cif < segmento.annotations.length; cif++) { //console.log(segmento.annotations[cif].type, segmento.annotations[cif].text);
                 if (segmento.annotations[cif].type == Element.HARMONY) {
                   //console.log("compasso", compasso, ":", segmento.annotations[cif].baseTpc, segmento.annotations[cif].id, segmento.annotations[cif].rootTpc, segmento.annotations[cif].text);
                  cifras = segmento.annotations[cif].text;
                  //console.log("cif", cif, cifras);
               } else if (segmento.annotations[cif].type == 34 && segmento.annotations[cif].text.length > 4) {
                  var textoTom = segmento.annotations[cif].text;
                  textoTom = textoTom.toUpperCase();
                  textoTom = textoTom.replace(/DO/g, "DÓ");
                  textoTom = textoTom.replace("RE", "RÉ");
                  textoTom = textoTom.replace("MÍ", "MI");
                  textoTom = textoTom.replace("FA", "FÁ");
                  textoTom = textoTom.replace("SÓL", "SOL");
                  textoTom = textoTom.replace("LA", "LÁ");
                  textoTom = textoTom.replace("SÍ", "SI");
                  textoTom = textoTom.replace("JO", "JÔ");
                  textoTom = textoTom.replace("FRI", "FRÍ");
                  textoTom = textoTom.replace("LID", "LÍD");
                  textoTom = textoTom.replace("EO", "EÓ");
                  textoTom = textoTom.replace("LO", "LÓ");
                  if ( textoTom.substr(0, 2) == "DÓ" || textoTom.substr(0, 2) == "RÉ" ||
                       textoTom.substr(0, 2) == "MI" || textoTom.substr(0, 2) == "FÁ" ||
                       textoTom.substr(0, 2) == "SO" || textoTom.substr(0, 2) == "LÁ" ||
                       textoTom.substr(0, 2) == "SI") { tom = textoTom; };
               };
             };

	          vozes[seg] = { nota: [], tonal: [], posição: [], duração: [], trilha: [], objeto: [], ligadura: [], tempo: [], cifras: [], tom: [] };

             // Passo 1: ler as notas e guardar em "vozes"
               for (trilha = trilhaInicial; trilha < trilhaFinal; trilha++) {
               	cursor.track = trilha;

            	  if (segmento.elementAt(trilha)) {
            	  	 if (segmento.elementAt(trilha).type == Element.REST) { //console.log(seg, "tipo pausa", trilha, segmento.tick);
            	  	 	 if (seg == 0) { pausa = true; //console.log("seg 0, voz", voz, "ligadura true");
                       vozes[seg].nota[voz] = 0;
                       vozes[seg].tonal[voz] = 12;
                       vozes[seg].trilha[voz] = trilha;
                       vozes[seg].posição[voz] = segmento.tick;
                       vozes[seg].duração[voz] = segmento.elementAt(trilha).duration.ticks;
                       vozes[seg].compasso = compasso;
                       vozes[seg].formula = [numerador, denominador];
                       vozes[seg].objeto[voz] = segmento.elementAt(trilha).rest;
                       vozes[seg].ligadura[voz] = true;
                       vozes[seg].tempo[voz] = tempo;
                       vozes[seg].cifras = cifras;
                       vozes[seg].tom = tom;

                       voz++;
                       carregou = true;
                       continue;
                     } else { //console.log("seg != 0, voz", voz, "ligadura true");
                        vozes[seg].nota[voz] = vozes[seg-1].nota[voz];
                        vozes[seg].tonal[voz] = vozes[seg-1].tonal[voz];
                        vozes[seg].trilha[voz] = vozes[seg-1].trilha[voz];
                        vozes[seg].posição[voz] = segmento.tick;
                        vozes[seg].duração[voz] = segmento.elementAt(trilha).duration.ticks;
                        vozes[seg].compasso = compasso;
                        vozes[seg].formula = [numerador, denominador];
                        vozes[seg].objeto[voz] = segmento.elementAt(trilha).rest;
                        vozes[seg].ligadura[voz] = true;
                        vozes[seg].tempo[voz] = tempo;
                        vozes[seg].cifras = cifras;
                        vozes[seg].tom = tom;

                        voz++;
                        carregou = true;
            	  	      continue; };

            	  	 } else if (segmento.elementAt(trilha).type == Element.CHORD) { //console.log(seg, "tipo CHORD", trilha, segmento.tick);
                     var duração = segmento.elementAt(trilha).duration.ticks;
                     var notas = segmento.elementAt(trilha).notes;
                     for (var j=notas.length-1; j>=0;j--) {
                       vozes[seg].nota[voz] = notas[j].pitch;
                       vozes[seg].tonal[voz] = notas[j].tpc
                       vozes[seg].trilha[voz] = trilha;
                       vozes[seg].posição[voz] = segmento.tick;
                       vozes[seg].duração[voz] = duração;
                       vozes[seg].compasso = compasso;
                       vozes[seg].formula = [numerador, denominador];
                       vozes[seg].objeto[voz] = notas[j];
                       if (notas[j].tieBack) { vozes[seg].ligadura[voz] = true; } else { vozes[seg].ligadura[voz] = false; }
                       vozes[seg].tempo[voz] = tempo;
                       vozes[seg].cifras = cifras;
                       vozes[seg].tom = tom;
//console.log("voz", voz, "ligadura",vozes[seg].ligadura[voz]);
                       voz++;
                       carregou = true;

                     };
                   };
                 } else { //console.log(seg, "tipo: nem pausa, nem chord", trilha, segmento.tick);

              if (vozes[seg-1]) { //console.log("existe vozes anterior.");
					     for (var y=0; y<vozes[seg-1].nota.length;y++) {
						    if (trilha == vozes[seg-1].trilha[y]) { //console.log("trilha atual é a mesma da vozes anterior.");
						    	if ((vozes[seg-1].duração[y] + vozes[seg-1].posição[y]) > segmento.tick) { var prolonga = true; } else { var prolonga = false; };
                //  console.log("Duração da vozes anterior ultrapassa posição do segmento:", prolonga);
						    if (prolonga){
						        vozes[seg].nota[voz] = vozes[seg-1].nota[y];
	                  vozes[seg].tonal[voz] = vozes[seg-1].tonal[y];
	                  vozes[seg].trilha[voz] = vozes[seg-1].trilha[y];
	                  vozes[seg].posição[voz] = segmento.tick;
	                  vozes[seg].duração[voz] = vozes[seg-1].duração[y] - (segmento.tick - vozes[seg-1].posição[y]);
	                  vozes[seg].compasso = compasso;
	                  vozes[seg].formula = [numerador, denominador];
	                  vozes[seg].objeto[voz] = vozes[seg-1].objeto[y];
								    vozes[seg].ligadura[voz] = true;
								    vozes[seg].tempo[voz] = tempo;
                    vozes[seg].cifras = cifras;
                    vozes[seg].tom = tom;

						        voz++;
						        carregou = true;
							   };
							   break;
						    };
					     };
					    };
             };
            };

              if (carregou) { //console.log("vozes", seg, ":", vozes[seg].nota[0], vozes[seg].nota[1]);
                 cursor.track = trilhaInicial;
                 for (var i=1;i<vozes[seg].nota.length;i++) {
                 	 if (vozes[seg].duração[1] < vozes[seg].duração[0]) { cursor.track = vozes[seg].trilha[1]; };
                 };

                 // if (seg > 0) {
                 //      if (vozes[seg].nota[0] != vozes[seg-1].nota[0] || vozes[seg].nota[1] != vozes[seg-1].nota[1]) { seg++; };
                 // } else { seg++; };
                 seg++;
              };
//console.log("antes:",cursor.segment.tick);
        		  cursor.next(); segmento = cursor.segment;
//console.log("depois:",cursor.segment.tick);
           };

//console.log("vozes", 0, ":", vozes[0].nota);
   if (seg == 0) { msgErros.text += "Nenhum acorde carregado!!\n";
                        msgErros.estado=true; Qt.quit(); };
 for (var x=0;x<vozes.length;x++){
  //console.log(x, vozes[x].cifras);
   //console.log(x, vozes[x].nota);
   if (vozes[x].nota[0] == 0 || vozes[x].nota[1] == 0) { vozes.splice(0, 1); x--; };
 };


}
//------------------- melodia -----------
function penultimaNota() {
 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de notas para a verificação da penúltima nota!\n";
                        msgErros.estado = true; return; };

 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
   for (var voz = vozInicial; voz <= vozFinal; voz++) {
    if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
    var x = vozes.length - 1;
    var g1 = parseInt(verificaGrauMelodico(vozes[x-1].tonal[voz], x-1));
    if (parseInt(menuModo.value) < 3) {
	   if (g1 != 5 && g1 != 7 && g1 != 2 && g1 != 4) {
	      verificados++;
	      criaResultado(verificados, x-1, voz, voz, "penúltima nota não pertence ao V ou viiº", 1, 1);
	    }; } else {
      if (g1 != 2 && g1 != 7) {
	      verificados++;
	      criaResultado(verificados, x-1, voz, voz, "não conduz para finalis por grau conj.", 1, 1);
       };
    };
  };
}

function ambitoMelodico() {
  var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
  for (var voz = vozInicial; voz <= vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
   var agudo = 0, grave = 128;
   var pos1, pos2, posI, posF;

   for (var i=0;i<vozes.length;i++) { // detecta as extremidades da melodia
     var nota = vozes[i].nota[voz];
     if (nota > agudo) { agudo = nota; pos1 = i; };
     if (nota < grave) { grave = nota; pos2 = i; };

   };

   if (pos1 > pos2) { posI = pos2; posF = pos1; } else { posI = pos1; posF = pos2; };

   var extensao = agudo - grave;
   var numAcordes = (posF - posI)+1;
   var extQt = parseInt(ambInp.text);

   if (extensao > extQt) {
     verificados++;
     criaResultado(verificados, posF, voz, voz, "Âmbito melódico", numAcordes, 1);
   };
  }
}

function privilegiaConj() {
  if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de privilegiar grau conjunto!\n";
                        msgErros.estado = true; return; };

 var tom = tonicaTPC(btTonica.text, btAcid.text);
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var numAcordes = vozes.length;
  var conj = 0, disj = 0;

  for (var x=1;x<vozes.length;x++) { // percorre acorde
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};
   if (!vozes[x].ligadura[voz]) { var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
    if (priviGCEx.checked) { if (intervalo > 4) { disj++; } else { conj++ };
    } else if (intervalo > 2) { disj++; } else { conj++ };
   };
  };
   if (priviGCEx.checked) { var nome = "Não privilegia graus conj. e 3ªs"; } else { var nome = "Não privilegia grau conjunto"; }
   if (conj <= disj) {
      verificados++;
      criaResultado(verificados, numAcordes-1, voz, voz, nome, numAcordes, 1);
    };
 }
}

function melodia7() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Salto de sétima!\n";
                        msgErros.estado=true; return; };

 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

   if (intervalo == 10 || intervalo == 11) {
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico de 7ª", 2, 1);
    };
  };
 };
}

function melodia6() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Salto de sexta!\n";
                        msgErros.estado=true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {return;};

   var intervalo = vozes[x].nota[voz] - vozes[x-1].nota[voz];

   if (intervalo == 8 || intervalo == 9 || intervalo == -8 || intervalo == -9) {
     if (salt6Ex.checked && intervalo > 0) { continue; };
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico de 6ª", 2, 1);
    };
  };
 };
}

function melodiaAum() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de intervalo melódico aumentado!\n";
                        msgErros.estado = true; return; };

 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var g1 = parseInt(verificaGrauMelodico(vozes[x-1].tonal[voz], x-1));
   var g2 = parseInt(verificaGrauMelodico(vozes[x].tonal[voz], x));

   if (intervalo == 6 || (intervalo == 3 && (g1 == 6 || g1 == 7) && (g2 == 6 || g2 == 7))) {
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico aumentado", 2, 1);
    };
  };
 };
}

function melodia8() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos maiores do que a oitava!\n ";
                        msgErros.estado=true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  for (var x=1;x<vozes.length;x++) { // percorre acorde
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

   if (intervalo > 12) {
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico > 8ª", 2, 1);
    };
  };
 };
}

function tritono2Ext() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de notas para a verificação de trítono!\n";
                        msgErros.estado = true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var novaVoz = [], mov = [], qtM = 0, posI = 0;

  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=1;x<novaVoz.length;x++) { // percorre acordes extremidade 1

   qtM++;

   var dir1 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

   mov[x-1] = dir1;

   if (x>=2 && mov[x-1] != mov[x-2] && dir1 != 0) {

    if (qtM >= 2) { var intervalo = Math.abs(novaVoz[posI].nota - novaVoz[x-1].nota);
      var pIni = (novaVoz[x-1].pos - novaVoz[posI].pos); var pFinal = novaVoz[x-1].pos;
      listaVerifica(intervalo);
    };
   posI = x-1; qtM = 0; };

    if (qtM > 0 && x == novaVoz.length-1) {
      var intervalo = Math.abs(novaVoz[posI].nota - novaVoz[x].nota);
      var pIni = novaVoz[x].pos - novaVoz[posI].pos; var pFinal = novaVoz[x].pos;
       listaVerifica(intervalo);
      };
   };
 };
 function listaVerifica(intervalo) {
  if ((intervalo == 6 || intervalo == 18) && pIni > 1) {
   verificados++;
   criaResultado(verificados, pFinal , voz, voz, "trítono nas 2 extremidades", pIni + 1, 1); };

 };

}

function tritono1Ext() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de notas para a verificação de trítono!\n";
                        msgErros.estado = true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var novaVoz = [], mov = [], qtM = 0, posI = 0;

  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=1;x<novaVoz.length;x++) { // percorre acordes extremidade 1

   qtM++;

   var dir1 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
  // console.log("x:", x, "mov:", dir1)

   if (dir1 == 0) { mov[x-1] = mov[x-2]} else { mov[x-1] = dir1; };

   if (x>=2 && mov[x-1] != mov[x-2]) {
    for (var i = posI+1; i < x-2; i++) { //   console.log("voz:", voz, " | ", novaVoz[i].nota, novaVoz[x-1].nota);
	    if (qtM >= 2) { var intervalo = Math.abs(novaVoz[i].nota - novaVoz[x-1].nota);
	      var pIni = (novaVoz[x-1].pos - novaVoz[i].pos); var pFinal = novaVoz[x-1].pos;
	      listaVerifica(intervalo);
	    };
	  };
	 for (var i = posI+1; i < x-1; i++) { //console.log("voz:", voz, " x: ", " | ", novaVoz[posI].nota, novaVoz[i].nota)
	    if (qtM >= 2) { var intervalo = Math.abs(novaVoz[posI].nota - novaVoz[i].nota);
	      var pIni = (novaVoz[i].pos - novaVoz[posI].pos); var pFinal = novaVoz[i].pos;
	      listaVerifica(intervalo);
	    };
	  };

   posI = x-1; qtM = 0; };

   if (qtM > 0 && x == novaVoz.length-1) {
     for (var i = posI+1; i < x-2; i++) {  //console.log("voz:", voz, " | ", novaVoz[i].nota, novaVoz[x].nota);
      var intervalo = Math.abs(novaVoz[i].nota - novaVoz[x].nota);
      var pIni = novaVoz[x].pos - novaVoz[i].pos; var pFinal = novaVoz[x].pos;
       listaVerifica(intervalo);
      };
     for (var i = posI+1; i < x; i++) { //console.log("voz:", voz, " | ", novaVoz[posI].nota, novaVoz[i].nota)
      var intervalo = Math.abs(novaVoz[posI].nota - novaVoz[i].nota);
      var pIni = novaVoz[i].pos - novaVoz[posI].pos; var pFinal = novaVoz[i].pos;
       listaVerifica(intervalo);
      };
    };
   };
 };
 function listaVerifica(intervalo) {
  if ((intervalo == 6 || intervalo == 18) && pIni > 1) {
   verificados++;
   criaResultado(verificados, pFinal , voz, voz, "trítono em 1 extremidade", pIni + 1, 1); };

 };
}

function melodiaDC() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Dissonância composta!\n";
                       msgErros.estado=true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var novaVoz = [];

  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=2;x<novaVoz.length;x++) { // percorre acordes

   var int1 = Math.abs(novaVoz[x].nota - novaVoz[x-2].nota);
   var dir1 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var dir2 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

   if ((int1 == 10 || int1 == 11 || int1 == 13 || int1 == 14 || int1 == 18)  && dir1 == dir2 && dir1 != 0) {
     var numNotas = (novaVoz[x].pos - novaVoz[x-2].pos) + 1;
      verificados++;
      criaResultado(verificados,  novaVoz[x].pos, voz, voz, "dissonância composta", numNotas, 1);
   };
  };
 };
}

function melodia5() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos maiores do que a quarta justa!\n";
                       msgErros.estado=true; return; };

 var cond1 = false, cond2 = false, cond3 = false;
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var novaVoz = [];
  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };
  for (var x=2;x<novaVoz.length;x++) { // percorre acordes
   if (!novaVoz[x].nota || !novaVoz[x-1].nota) {continue;};

   var int1 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var int2 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);

   var dir2 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var dir3 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

   var compensa = 13;
   if (saltM5Ex1.checked) { compensa = 3; };
   if (saltM5Ex2.checked) { compensa = 6; };

   if (int1 > 7) {
     if (dir3 != dir2 && dir3 != 0 && int2 < compensa) { continue; } else {
      verificados++;
      criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "intervalo melódico > 5ªJ", 2, 1);
     };
   };
  };
 };
}

function variedadeDirecionamento() {

 var qtMov = parseInt(varDirQt.text);
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var asc = [], desc = [], mov = [], novaVoz = [];
  var qtA = 0, qtD = 0, qtN = 0, pos1 = 0;

   for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=1;x<novaVoz.length;x++) { // percorre acordes

   var dir1 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
   if (x < novaVoz.length-1) { var posIni = (novaVoz[x-1].pos - novaVoz[pos1].pos) + 1; }
     else { var posIni = (novaVoz[x].pos - novaVoz[pos1].pos) + 1; };

   mov[x-1] = dir1;

   switch(mov[x-2]) {
    case 0:
      if (x>=3 && mov[x-1] != mov[x-3]) { testaQt(qtN); pos1 = x-1; asc = []; qtA = 0; desc = []; qtD = 0; };
      break;
    case -1:
    case 1:
      if (x>=2 && mov[x-1] != mov[x-2] && mov[x-1] != 0) { testaQt(qtN); pos1 = x-1; asc = []; qtA = 0; desc = []; qtD = 0; };
      break;
   };

   if (dir1 == 1) { asc[qtA] = dir1; qtA++; qtN = asc.length; } else
   if (dir1 == -1) { desc[qtD] = dir1; qtD++; qtN = desc.length; };

  };
  testaQt(qtN);
 };
 function testaQt(qt) {

   if (qt > qtMov) {
           verificados++;
           criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "movimentos na mesma direção", posIni, 1); };
 };

}

function repetiçãoNotas() {

	var qtRep = parseInt(repNotaQt.text);
  var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
  for (var voz = vozInicial; voz < vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
   var novaVoz = []; var qt = 0, pos1 = 0;

   for (var x=0;x<vozes.length;x++) {
     //console.log(x,")",vozes[x].nota[voz], vozes[x].ligadura[voz])
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
    } else if (novaVoz.length > 1) { novaVoz[novaVoz.length-1].pos = x; };
   };

   for (var x=1;x<novaVoz.length;x++) { // percorre acordes

   if (x < novaVoz.length) { var posIni = novaVoz[x-1].pos - novaVoz[pos1].pos; };

   if (novaVoz[x].nota == novaVoz[x-1].nota) {
    if (repeteNoutra.checked) {
     for (var i=0;i<vozes[1].nota.length; i++) {
       if (i == voz) { continue; };
       if (vozes[novaVoz[x].pos].nota[i] == vozes[novaVoz[x-1].pos].nota[i]) {
         qt++;
         break;
       };
      };
     } else { qt++; };
   } else { pos1 = x-1; testaRep(); qt = 0; };

  };
  //console.log(">=<=><=>=<=>", voz, novaVoz.length, pos1);
   var posIni = novaVoz[novaVoz.length-1].pos - novaVoz[pos1].pos;
   testaRep();
  };
 function testaRep() {
	if (qt > qtRep) {
		 verificados++;
       criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "repetição de notas", posIni, 1); };
 };
}

function repetePadrão() {

 if (vozes.length<4) {msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de repetição de padrão melódico!\n";
                       msgErros.estado=true; return; }
 var qtRep = parseInt(repPadQt.text);
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
   var novaVoz = [];

   for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=3;x<novaVoz.length;x++) { // percorre acordes

   if (novaVoz[x].nota == novaVoz[x-2].nota && novaVoz[x-1].nota == novaVoz[x-3].nota
       && novaVoz[x].nota != novaVoz[x-1].nota) { verRepPad(4,2); };
   if (x >=5 && novaVoz[x].nota == novaVoz[x-2].nota && novaVoz[x-1].nota == novaVoz[x-3].nota &&
       novaVoz[x].nota == novaVoz[x-4].nota && novaVoz[x-1].nota == novaVoz[x-5].nota &&
       novaVoz[x].nota != novaVoz[x-1].nota) { verRepPad(6,2); };

   if (x >= 6 && novaVoz[x].nota == novaVoz[x-3].nota && novaVoz[x-1].nota == novaVoz[x-4].nota
       && novaVoz[x-2].nota == novaVoz[x-5].nota && (novaVoz[x].nota != novaVoz[x-1].nota ||
       novaVoz[x].nota != novaVoz[x-2].nota)) { verRepPad(6,3); };
   if (x >= 9 && novaVoz[x].nota == novaVoz[x-3].nota && novaVoz[x-1].nota == novaVoz[x-4].nota
       && novaVoz[x-2].nota == novaVoz[x-5].nota && novaVoz[x].nota == novaVoz[x-6].nota &&
       novaVoz[x-1].nota == novaVoz[x-7].nota && novaVoz[x-2].nota == novaVoz[x-8].nota
       && (novaVoz[x].nota != novaVoz[x-1].nota || novaVoz[x].nota != novaVoz[x-2].nota)) { verRepPad(9,3); };
  };
 };
 function verRepPad(a,b) {

 	var numAcordes = (novaVoz[x].pos - novaVoz[x-(a-1)].pos) + 1;

 	var rep = (a/b) - 1;

 	if (rep > qtRep) {
	 verificados++;
    criaResultado(verificados, novaVoz[x].pos, voz, voz, "repetição de padrão mel.", numAcordes, 1); };
 };
}

function melodiaArpejo() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos consecutivos na mesma direção!\n";
                       msgErros.estado=true; return; };

 var qtArp = parseInt(arpMelQt.text);
 var arp = 0;
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var novaVoz = [];
  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=2;x<novaVoz.length;x++) { // percorre acordes
   if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

   var int1 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var int2 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
   var dir1 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var dir2 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

   if (int1 > 2 && int2 > 2 && dir1 == dir2 && dir1 != 0 && ((int1 == 3 && int2 == 3) ||
     	(int1 == 3 && int2 == 4) || (int1 == 4 && int2 == 3) || (int1 == 4 && int2 == 4) ||
     	(int1 == 3 && int2 == 6) || (int1 == 4 && int2 == 5) || (int1 == 3 && int2 == 5) ||
     	(int1 == 6 && int2 == 3) || (int1 == 5 && int2 == 3) || (int1 == 5 && int2 == 4))) {
     arp++;
     if (arp > qtArp) {
      var posIni = (novaVoz[x].pos - novaVoz[x-2].pos) + 1
      verificados++;
      criaResultado(verificados, novaVoz[x].pos, voz, voz, "arpejo de acorde", posIni, 1); };
   };
  };
 };
}

function melodiaPF() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Ponto focal!\n";
                       msgErros.estado=true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var vozSup = [];
  var pfSs = 0, pfSi = 127;  // ponto focal da voz Superior/Inferior, inferior/superior
  var pfSsc = 0, pfSic = 0; // var para contagem dos pontos focais;

  for (var x=0;x<vozes.length;x++) { // percorre acordes para encontrar pontos focais

   vozSup[x] = vozes[x].nota[voz];

   if (vozSup[x] > pfSs) { pfSs = vozSup[x]; };
   if (vozSup[x] < pfSi) { pfSi = vozSup[x]; };

 };

  for (var x=1;x<vozes.length-1;x++) { // percorre acordes

   if (vozSup[x] == pfSs) { pfSsc++; // contagem dos pontos focais voz superior;
     if ((vozSup[x-1] == pfSs) || (x == vozes.length-1 && vozSup[0] == pfSs)) { pfSsc--; } else
     if (melPFs.checked && pfSsc > 1) { verificados++; criaResultado(verificados, x, voz, voz, "repete ponto focal superior", 1, 1); }; };
   if (vozSup[x] == pfSi) { pfSic++;
     if ((vozSup[x-1] == pfSi) || (x == vozes.length-1 && vozSup[0] == pfSi)) { pfSic--; } else
     if (melPFi.checked && pfSic > 1) { verificados++; criaResultado(verificados, x, voz, voz, "repete ponto focal inferior", 1, 1); }; };
 };
 };
}

function neutralterações() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de neutralização de alterações!\n";
                       msgErros.estado=true; return; };
var temposNeutra = parseInt(neutNqt.text);

var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var novaVoz = []; var int1, int2, int3, int4;
  for (var x=0;x<vozes.length;x++) { // cria novaVoz excluindo repetições e ligaduras
   if (x > 0) {
    if (vozes[x].nota[voz] != vozes[x-1].nota[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], tonal: vozes[x].tonal[voz], pos: x}) ;
    }; } else { novaVoz.push({ nota: vozes[x].nota[voz], tonal: vozes[x].tonal[voz], pos: x}); };
   };

  for (var x=0;x<novaVoz.length-1;x++) { // verifica o grau e se possuem alterações
    var alt1 = verificaGrauMelodico(novaVoz[x].tonal, novaVoz[x].pos);
    var tom = tonicaTPC(btTonica.text, btAcid.text);
    var nota1 = novaVoz[x].tonal-tom;
    alt1 = alt1.toString();
    var alt2 = verificaGrauMelodico(novaVoz[x+1].tonal, novaVoz[x+1].pos);
    tom = tonicaTPC(btTonica.text, btAcid.text);
    var nota2 = novaVoz[x+1].tonal-tom;
    alt2 = alt2.toString();
    if (x < novaVoz.length-2) {
      var alt3 = verificaGrauMelodico(novaVoz[x+2].tonal, novaVoz[x+2].pos);
      tom = tonicaTPC(btTonica.text, btAcid.text);
      var nota3 = novaVoz[x+2].tonal-tom;
      alt3 = alt3.toString();
    };
    // verifica tratamento das alterações --------
    if (alt1.slice(-1) == "+") { // se alteração elevando

     if (neutAim.checked) { // conduz alteração imediatamente?
       if (alt1.slice(0, 1) == "6") { // 6º conduz imediatamente para 7º e 1º?
         if (x < novaVoz.length-2 && (nota2 != 5 || alt3 != "1")) { var a = x + 1; verificaAlter(); }; // se não, manda pra lista de verificações
       } else
       if (alt1.slice(0, 1) == "7") { // 7º conduz imediatamente para o 1º
         if (alt2 != "1") { var a = x + 1; verificaAlter(); }; // se não, manda pra lista de verificações
       };
     } else { // conduz alteração não imediatamente
       for (var a=x+1;a<novaVoz.length;a++) {
         var tam = a - x;
         if (x < novaVoz.length-2 && tam > 3) { verificaAlter(); x += 4; break; }; // se ultrapassar distância de 3 notas, manda pra lista de verificações
         var procuraT = verificaGrauMelodico(novaVoz[a].tonal, novaVoz[a].pos);
         procuraT = procuraT.toString();
         if (procuraT == "1") {  //procura resolução no 1º
           if (x < novaVoz.length-2 && tam == 3) { // testa solução com distância de 3 notas
             if (alt1 == "6+" && (((alt2 == "2" || alt2 == "5" || alt2 == "1") && nota == 5) ||
                                  (nota2 == 5 && (alt3 == "5" || alt3 == "2")))) { x += 3; break;} else
             if (alt1 == "7+" && ((alt2 == "2" && alt3 == "5") || (nota2 == 3 && nota3 == 5))) { x += 3; break;}
                 else { verificaAlter(); x += 3; break; };
           } else if (tam == 2) { // testa solução com distância de 2 notas
             if (alt1 == "7+" && (alt2 == "2" || alt2 == "5")) { x += 2; break; } else
             if (alt1 == "6+" && nota2 == 5) { x += 2; break; }
                  else { verificaAlter(); x += 2; break; };
           } else if (tam == 1) { // testa solução com distância de 1 nota
             if (alt1 == "7+") { x += 1; break; } else { verificaAlter(); x += 1; break; };
           };
         };
       };
     };
   };

 };

  for (var x=0;x<novaVoz.length;x++) { // verifica neutralizações do 6 e 7
    var alt1 = verificaGrauMelodico(novaVoz[x].tonal, novaVoz[x].pos); // nota com alteração
    alt1 = alt1.toString();

    if (alt1.slice(-1) == "+") {
      for (var a=x-1;a>=0;a--) { // procura neutralização regressivamente
        if (neutNim.checked && (x-a) > temposNeutra) { break; }; // se ultrapassar a qt de tempos da condição neutNim
        var alt2 = verificaGrauMelodico(novaVoz[a].tonal, novaVoz[a].pos); // nota anterior, de mesmo grau, sem alteração
        alt2 = alt2.toString();
        if (alt2 == alt1) { break; };
        var alt3 = verificaGrauMelodico(novaVoz[a+1].tonal, novaVoz[a+1].pos); // nota que neutraliza
        alt3 = alt3.toString();
        if (alt1.slice(0, 1) == alt2 ) { //se encontrou nota natural (alt2 mesmo grau de alt1)
         switch (alt2) { // se alt3 neutraliza, encerra busca. Se não manda pra lista
           case "6": if (alt3 == "5") { a = -1; } else { verificaNeutr(); a = -1; }; break;
           case "7": if (alt3.slice(0, 1) == "6") { a = -1; } else { verificaNeutr(); a = -1; }; break;
         };
       };
      };
    };
  };
 };
 function verificaAlter() {
   var posIni = (novaVoz[a].pos - novaVoz[x].pos) + 1;
   verificados++;
   criaResultado(verificados, novaVoz[a].pos, voz, voz, "alteração 6º e/ou 7º", posIni, "ne");
 };
 function verificaNeutr() {
   var posIni = (novaVoz[x].pos - novaVoz[a].pos) + 1;
   verificados++;
   criaResultado(verificados, novaVoz[x].pos, voz, voz, "neutralização 6º e/ou 7º", posIni, "ne");
 };
}

function notaIniFin() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de nota inicial e final!\n";
                       msgErros.estado=true; return; };

 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
   var test1 = false, test2 = false, test3 = false, test4 = false, test5 = false, test6 = false;
   var nI = parseInt(verificaGrauMelodico(vozes[0].tonal[voz], 0));
   var nF = parseInt(verificaGrauMelodico(vozes[vozes.length-1].tonal[voz], vozes.length-1));

   if (tonic.checked && nI == 1) { test1 = true; };
   if (terça.checked && nI == 3) { test2 = true; };
   if (quinta.checked && nI == 5) { test3 = true; };
   if (tonicF.checked && nF == 1) { test4 = true; };
   if (terçaF.checked && nF == 3) { test5 = true; };
   if (quintaF.checked && nF == 5) { test6 = true; };

   var nomeI = "Nota inicial não é ";
   if (tonic.checked) { nomeI += "1º"; };
   if (terça.checked) { nomeI += "/3º"; };
   if (quinta.checked) { nomeI += "/5º"; };
   nomeI += " grau";

   var nomeF = "Nota final não é ";
   if (tonicF.checked) { nomeF += "1º"; };
   if (terçaF.checked) { nomeF += "/3º"; };
   if (quintaF.checked) { nomeF += "/5º"; };
   nomeF += " grau";

   if (!test1 && !test2 && !test3) {
	      verificados++;
	      criaResultado(verificados, 0, voz, voz, nomeI, 1, 1);
       };
   if (!test4 && !test5 && !test6) {
	      verificados++;
	      criaResultado(verificados, vozes.length-1, voz, voz, nomeF, 1, 1);
       };
  };
}

function doisSaltosMdireção() {

   if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos consecutivos na mesma direção!\n";
                         msgErros.estado=true; return; };
   var vozInicial = 0, vozFinal = vozes[1].tonal.length-1, triade = false;
   for (var voz = vozInicial; voz <= vozFinal; voz++) {
     if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
     var novaVoz = [];
    for (var x=0;x<vozes.length;x++) {
      if (!vozes[x].ligadura[voz]) {
        novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
       };
     };

    for (var x=2;x<novaVoz.length;x++) { // percorre acordes
     if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

     var int1 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var int2 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
     var dir1 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var dir2 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
     if (((int1 == 3 || int1 == 4) && (int2 == 3 || int2 == 4)) ||
         ((int1 == 3 || int1 == 4) && (int2 == 5 || int2 == 6)) ||
         ((int1 == 5 || int1 == 6) && (int2 == 3 || int2 == 4))) { triade = true; } else { triade = false; };
     if (int1 > 2 && int2 > 2 && dir1 == dir2 && dir1 != 0) {
        if (doisSaltMEx.checked && triade) { continue; };
        var posIni = (novaVoz[x].pos - novaVoz[x-2].pos) + 1
        verificados++;
        criaResultado(verificados, novaVoz[x].pos, voz, voz, "2 saltos na mesma direção", posIni, 1);
     };
    };
   };
}

function doisSaltosMContra() {

   if (vozes.length<5) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos consecutivos em movimento contrário!\n";
                         msgErros.estado=true; return; };
   var exceção1 = false, exceção2 = false;
   var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
   for (var voz = vozInicial; voz <= vozFinal; voz++) {
     if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
    var novaVoz = [];
    for (var x=0;x<vozes.length;x++) {
      if (!vozes[x].ligadura[voz]) {
        novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
       };
     };
    for (var x=4;x<novaVoz.length;x++) { // percorre acordes
     if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

     var int1 = Math.abs(novaVoz[x-3].nota - novaVoz[x-4].nota);
     var int2 = Math.abs(novaVoz[x-2].nota - novaVoz[x-3].nota);
     var int3 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var int4 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
     var dir1 = direção(novaVoz[x-3].nota - novaVoz[x-4].nota);
     var dir2 = direção(novaVoz[x-2].nota - novaVoz[x-3].nota);
     var dir3 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var dir4 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

     if (int2 > 2 && int3 > 2 && dir2 != dir3 && dir2 != 0 && dir3 != 0) {// 2 saltos em mov contrário

        if ((dir1 != dir2 && dir1 != 0 && dir2 != 0) && // seguido e precedido por mov contra.
            (dir3 != dir4 && dir3 != 0 && dir4 != 0)) {
                 exceção1 = true; } else { exceção1 = false; };
        if (int1 < 3 && int4 < 3) {// por grau conjunto
                 exceção2 = true; } else { exceção2 = false; };

        if ((doisSaltCEx1.checked && doisSaltCEx2.checked) && exceção1 && exceção2) { continue; } else
        if ((doisSaltCEx1.checked && !doisSaltCEx2.checked) && exceção1) { continue; } else
        if ((!doisSaltCEx1.checked && doisSaltCEx2.checked) && exceção2) { continue; };

        var posIni = (novaVoz[x-1].pos - novaVoz[x-3].pos) + 1
        verificados++;
        criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "2 saltos em mov. contrário", posIni, 1);
     };
    };
   };
}

// --------------------- Gerais: condução de vozes e outros aspectos ------------
function primUltIntervalo() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de intervalo inicial e final!\n";
                       msgErros.estado=true; return; };
 var tonica = tonicaPC(btTonica.text, btAcid.text);
 var notaInferior1 = vozes[0].nota[1];
 var notaInferior2 =  vozes[vozes.length-1].nota[1];
 var intI = (Math.abs(vozes[0].nota[0] - notaInferior1)) % 12;
 var intF = (Math.abs(vozes[vozes.length-1].nota[0] - notaInferior2)) % 12;
 var inicio = false, finale = false;

 if (intI != 0) { // se inicio não for U ou 8ª
   if (ex5Ji.checked && (intI == 7 && tonica == notaInferior1%12)) { inicio = true; } else // se for 5ª com tonica na voz inferior
   if (ex3i.checked && ((intI == 3 || intI == 4) && tonica == notaInferior1%12)) { inicio = true; }; // se for 3ª com tonica na voz inferior
   if (!inicio) {
   	verificados++;
	  criaResultado(verificados, 0, 0, 1, "intervalo inicial", 1, 2); };
 };

 if (intF != 0) { // se final não for U ou 8ª
   if (ex5Jf.checked && (intF == 7 && tonica == notaInferior2%12)) { finale = true; } else // se for 5ª com tonica na voz inferior
   if (ex3f.checked && ((intF == 3 || intF == 4) && tonica == notaInferior2%12)) { finale = true; }; // se for 3ª com tonica na voz inferior
   if (!finale) {
    verificados++;
    criaResultado(verificados, vozes.length-1, 0, 1, "intervalo final", 1, 2); };
 };
}

function alcançarMovContra() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de alcançar intervalo final!\n";
                       msgErros.estado=true; return; };

 var intS = vozes[vozes.length-1].nota[0] - vozes[vozes.length-2].nota[0]
 var intI = vozes[vozes.length-1].nota[1] - vozes[vozes.length-2].nota[1];

 var dir1 = direção(vozes[vozes.length-1].nota[0] - vozes[vozes.length-2].nota[0]);
 var dir2 = direção(vozes[vozes.length-1].nota[1] - vozes[vozes.length-2].nota[1]);

 if (intS > 2 || intI > 2 || intS < -2 || intI < -2 || dir1 == dir2 || dir1 == 0 || dir2 == 0) {

   if ((quartaJi.checked && (intI == 5 || intI == -7)) || (quartaJs.checked && (intS == 5 || intS == -7))) { return; };
	      verificados++;
	      criaResultado(verificados, vozes.length-2, 0, 1, "alcança intervalo final", 1, 2);
       };
}

function consonancias() {

  var cP = 0, cI = 0;
  for (var x=0;x<vozes.length;x++) { // percorre acordes
   var int1 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));
   if (int1 == "CP") { cP++; } else if (int1 == "CI") { cI++; }
  };
//  console.log("consonancias:", cP, cI);
  if (cP > cI) {
  	 verificados++;
     var resultado = "cons. imperfeita não é maioria (p=" + cP + ", i=" + cI + ")";
	 criaResultado(verificados, vozes.length-1, 0, 1, resultado, vozes.length, "null");
  };
}

function quintasOitavas() {
   var par5Status = true, par8Status = true;
   var acorAnt = 1;
   var qtdpar8Rep = parseInt(par8Rep.text), qtdpar5Rep = parseInt(par5Rep.text);

     for (var voz=0; voz < 10; voz++) { // percorre vozes
       var vozAnt = voz;

       for (var i=voz+1; i < 10; i++) { //  percorre outras vozes
   		 var vozAtual = i;
   		 var par5 = 0, par8 = 0;

	       for (var x=1;x<=vozes.length;x++) { // percorre acordes
	         if (x==vozes.length) { verificou58(); continue ; };
	         if (voz >= vozes[x].nota.length-1 || i >= vozes[x].nota.length) { continue ; };

         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
         var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

         var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
         var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

         if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

              if (Math.abs(intAtual%12) == 7 && intAtual == intAnt && paralela5.checked) { //testa 5ª paralela

                 if (vozAnt == voz) { var qtdPar5 = par5 + 1; }

                  if (par5 == 0) { par5 = 2; } else { par5++; };
                  par5Status = true;
                  vozAnt = voz, vozAtual = i;
                  acorAnt = x;
                  par8 = 0, par8Status = false;

              } else if (par5Status) { verificou58(); };

               if (Math.abs(intAtual%12) == 0 && intAtual == intAnt && paralela8.checked) {  // testa 8ª paralela

                 if (vozAnt == voz) { var qtdPar8 = par8 + 1;}

                  if (par8 == 0) { par8 = 2; } else { par8++; };
                  par8Status = true;
                  vozAnt = voz, vozAtual = i;
                  acorAnt = x;
                  par5 = 0, par5Status = false;

              } else if (par8Status) { verificou58(); };

           } else { verificou58(); };
         };
       };
     };

     function verificou58() {

       if (par8Status && par8 > qtdpar8Rep && paralela8.checked) {
         verificados++;
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "8ª paralela", qtdPar8+1 , 2);};

       if (par5Status && par5 > qtdpar5Rep && paralela5.checked) {
         verificados++;
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "5ª paralela", qtdPar5+1 , 2);};

      par8Status = false; par8 = 0;
      par5Status = false; par5 = 0;
    };
 }

function quartas() {

   var par4Status = true;
   var acorAnt = 1;
   var qtdpar4Rep = parseInt(par4Rep.text);

  // console.log("par4Rep : "+ qtdpar4Rep)

     for (var voz=0; voz < 10; voz++) { // percorre vozes
       var vozAnt = voz;
       for (var i=voz+1; i < 10; i++) { // percorre outras vozes
         var vozAtual = i;
         var par4 = 0;
	       for (var x=1;x<vozes.length;x++) { // percorre acordes

	         if (voz >= vozes[x].nota.length-1 || i >= vozes[x].nota.length) { verificou4(); continue; };

	         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
            var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

            var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
            var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

            if (Math.abs(intAtual%12) == 5 && intAtual == intAnt && dir1 == dir2 && dir1 != 0) { //testa por 4ª paralela

                 if (vozAnt == voz) { var qtdPar4 = par4 + 1;}

                  if (par4 == 0) { par4 = 2; } else { par4++; };
                  par4Status = true;
                  acorAnt = x;
                  vozAnt = voz, vozAtual = i;;

              } else { verificou4(); };
         };
       };
    };

    function verificou4() {

      if (par4Status && par4 > qtdpar4Rep) {
            verificados++;
            criaResultado(verificados, acorAnt, vozAnt, vozAtual, "4ª paralela", qtdPar4 , 2);
      };

      par4Status = false; par4 = 0;

    };
}

function terçasSextas() {

   var par3Status = true, par6Status = true;
   var acorAnt = 1;
   var qtdpar36Rep = parseInt(par36Rep.text);

     for (var voz=0; voz < 10; voz++) { // percorre vozes
       var vozAnt = voz;

       for (var i=voz+1; i < 10; i++) { // percorre outras vozes
   		 var vozAtual = i;
   		 var par3 = 0, par6 = 0;

	       for (var x=1;x<vozes.length;x++) { // percorre acordes

	         if (voz >= vozes[x].nota.length-1 || i >= vozes[x].nota.length) {

	            if (x==vozes.length-1) {verificou36();};

	         continue;

	         };

	         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
            var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

            var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
            var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

            if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

              if ((Math.abs(intAtual%12) == 3 || Math.abs(intAtual%12) == 4) &&   //testa por 3ª paralela --
                  (Math.abs(intAnt%12) == 3 || Math.abs(intAnt%12) == 4)) {

                 if (vozAnt == voz) { var qtdPar3 = par3 + 1; }

                  if (par3 == 0) { par3 = 2; } else { par3++; };
                  par3Status = true;
                  vozAnt = voz, vozAtual = i;
                  acorAnt = x;
                  par6 = 0, par6Status = false;

              } else if (par3Status) { verificou36(); };

               if ((Math.abs(intAtual%12) == 8 || Math.abs(intAtual%12) == 9) &&   //testa por 6ª paralela --
                  (Math.abs(intAnt%12) == 8 || Math.abs(intAnt%12) == 9)) {

                 if (vozAnt == voz) { var qtdPar6 = par6 + 1;}

                  if (par6 == 0) { par6 = 2; } else { par6++; };
                  par6Status = true;
                  vozAnt = voz, vozAtual = i;
                  acorAnt = x;
                  par3 = 0, par3Status = false;

              } else if (par6Status) { verificou36(); };

           } else { verificou36(); };

         };
      };
    };

    function verificou36() {

     if (par3Status && par3 > qtdpar36Rep) { //console.log("Else da NÃO 3ª. acorAnt = " + acorAnt)
         verificados++;
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "3ª paralela", qtdPar3 , 2);};
     if (par6Status && par6 > qtdpar36Rep) { //console.log("Else da NÃO 6ª. acorAnt = " + acorAnt)
         verificados++;
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "6ª paralela", qtdPar6 , 2);};

      par6Status = false; par6 = 0;
      par3Status = false; par3 = 0;
    };

}

function ocultas() {

	for (var x=1;x<vozes.length;x++) { // percorre acordes

    for (var voz=0; voz < vozes[x].nota.length; voz++) { // percorre vozes

      var i;
      var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

      for (i=voz+1; i < vozes[x].nota.length; i++) { // percorre outras vozes

         var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

         var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
         var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

         if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

           if (Math.abs(intAtual%12) == 7 && intAtual != intAnt && oculta5.checked) {             // testa ocultas
             // testa condições
             if (!ocultEx.checked || (ocultEx.checked && x != vozes.length-1)) {
               if (!ocultSalto.checked || (ocultSalto.checked && Math.abs(vozes[x-1].nota[0] - vozes[x].nota[0]) > 2)) {
                verificados++;
                criaResultado(verificados, x, voz, i, "5ª oculta", 2, 2);
               };
             };
           };

           if (Math.abs(intAtual%12) == 0 && intAtual != intAnt && oculta8.checked) { // testa ocultas
             // testa consições
             if (!ocultEx.checked || (ocultEx.checked && x != vozes.length-1)) {
               if (!ocultSalto.checked || (ocultSalto.checked && Math.abs(vozes[x-1].nota[0] - vozes[x].nota[0]) > 2)) {
                verificados++;
                criaResultado(verificados, x, voz, i, "8ª oculta", 2, 2);
               };
             };
           };
         };
      };
    };
  };
}

function consecutivas() {

     for (var x=1;x<vozes.length;x++) { // percorre acordes

       for (var voz=0; voz < vozes[x].nota.length; voz++) { // percorre vozes

         var i;
         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

         for (i=voz+1; i < vozes[x].nota.length; i++) { // percorre outras vozes

            var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

            var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
            var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

            // consecutivas

             if ((Math.abs(intAtual%12) == 7 || Math.abs(intAtual%12) == 0) &&
                 (Math.abs(intAnt%12) == 7 || Math.abs(intAnt%12) == 0))  {

               if ((consecObli.checked && (dir1 == 0 || dir2 == 0)) || (consecCont.checked && (dir1 != 0 && dir2 != 0 && dir1 != dir2))) {
                   verificados++;
                   criaResultado(verificados, x, voz, i, "5ª ou 8ª consecutivas", 2, 2);
               };
             };
         };
       };
     };
 }

function intermitentes() {
  var voz = 1 - vozCF;
   for (var x=0;x<vozes.length-2;x++) { // percorre acordes
    for (var y=x+2;y<vozes.length;y++) { // percorre acordes
      var tF = verificaTempoForte(vozes[x].tempo[0], vozes[x].formula[0]); // verifica posição métrica
      var alc = Math.abs(vozes[y].nota[voz] - vozes[y-1].nota[voz]); // calcula intervalo melódico que alcança a intermitente
      if (interExTf.checked && tF != "F" && // verifica exceção de tempo fraco
           (!interExTf2.checked || (alc < 3 && alc != 0)) && // alcançada por grau conjunto
           (!interExTf1.checked || vozes[x+1].ligadura[voz])) { continue; }; // verifica sincopada
      if (interExTF.checked && tF == "F" && vozes[x].ligadura[voz] && vozes[y].ligadura[voz]) { continue; }; // verifica exceção de tempo forte
      if (interExFim.checked && y == vozes.length-1) { continue; }; // verifica a exceção de cadência final
      var notasIguais = true; // verifica a exceção de CF parado
      for (var j=x+1;j<=y;j++){ if (vozes[x].nota[vozCF] != vozes[j].nota[vozCF]) { notasIguais = false; }; };
      if (interExCF.checked && notasIguais) { continue; }
      var int1 = Math.abs(vozes[x].nota[0] - vozes[x].nota[1]); // calcula intervalo x
      var int2 = Math.abs(vozes[y].nota[0] - vozes[y].nota[1]); // calcula intervalo y
      var ac = y - x + 1; // calcula qtd de acordes entre x e y
      if (vozes[x].compasso+1 == vozes[y].compasso && vozes[x].tempo[0] == vozes[y].tempo[0]) { //mesma posição métrica
          if (int1%12 == 7 && int1 == int2 && inter5.checked) {
	         verificados++;
		       criaResultado(verificados, y, 0, 1, "5ª intermitente", ac, "in"); } else
	        if (int1%12 == 0 && int1 == int2 && inter8.checked) {
	         verificados++;
		       criaResultado(verificados, y, 0, 1, "8ª intermitente", ac, "in");
          };
        } else if (y-x == 2) { // separadas por uma nota
          if (int1%12 == 7 && int1 == int2 && inter5.checked) {
	         verificados++;
		       criaResultado(verificados, y, 0, 1, "5ª intermitente", ac, "in"); } else
	        if (int1%12 == 0 && int1 == int2 && inter8.checked) {
	         verificados++;
		       criaResultado(verificados, y, 0, 1, "8ª intermitente", ac, "in");
          };
        };
     };
    };
}

function unissono() {

  var unissono = parseInt(unissQt.text)
  var uni = 0;

  if (unissIF.checked) { var a1 = 1, a2 = vozes.length-1; }
    else { var a1 = 0, a2 = vozes.length; } ;

  for (var x=a1;x<a2;x++) { // percorre acordes
   var pMetric = verificaTempoForte(vozes[x].tempo[0],vozes[x].formula[0]);
   if (!unissTF.checked || pMetric != "f") {
    for (var voz=1;voz<vozes[x].nota.length;voz++) {
      var int1 = vozes[x].nota[voz-1] - vozes[x].nota[voz];
      if (int1 == 0) { uni++; };
      if (int1 == 0 && uni > unissono) {
        verificados++;
    	  criaResultado(verificados, x, voz-1, voz, "uníssono", 1, 2); };
    };
   };
  };
}

function cruzamento() {

  for (var x=1;x<vozes.length;x++) { // percorre acordes

	 for (var voz=0; voz < vozes[x].nota.length - 1; voz++) { // percorre vozes

       if (vozes[x].nota[voz] < vozes[x].nota[voz+1]) {
	          verificados++;
	          criaResultado(verificados, x, voz, voz+1, "cruzamento", 1, 2);
       };
    };
  }; // acordes
}

function falsaRelação() {
  for (var x=1;x<vozes.length;x++) { // percorre acordes

    for (var voz=0; voz < vozes[x].nota.length; voz++) { // percorre vozes

      var int1 = Math.abs(vozes[x].tonal[voz] - vozes[x-1].tonal[voz]);
      if (int1 == 7) { continue; };

      for (var i=0; i < vozes[x].nota.length; i++) { // percorre outras vozes
         if (i == voz) { continue; };

         var int2 = Math.abs(vozes[x-1].tonal[voz] - vozes[x].tonal[i]);

         if (int2 == 7)  {  // testa falsa relação
               	verificados++;
               	criaResultado(verificados, x, voz, i, "falsa relação", 2, "fr"); };

      };
    };
  };
}

function espaçamento() {

  var qt = parseInt(distQt.text);
  var intT= parseInt(distInt.text);
  switch (intT) {
   case 8: intT= 12; break;
   case 9: intT= 14; break;
   case 10: intT= 16; break;
   case 11: intT= 17; break;
   case 12: intT= 19; break;
   case 13: intT= 21; break;
   case 14: intT= 23; break;
   case 15: intT= 24;
  };
  var int1, conta = 0, conta2 = 0;
  for (var x=0;x<vozes.length;x++) { // percorre acordes
    for (var voz=1;voz<vozes[x].nota.length;voz++) {
      int1 = Math.abs(vozes[x].nota[voz-1] - vozes[x].nota[voz]);
      if (int1 > intT) {
       conta++;
     } else {
        testaResultado(x-1,voz);
        conta = 0;
      };
    };
  };
  testaResultado(vozes.length-1,vozes[1].nota.length-1);
 function testaResultado(x,voz){
  if (conta > qt) {
    var msg = "distância vozes (" + conta + ")";
    verificados++;
    criaResultado(verificados, x, voz-1, voz, msg , conta, 2);
  };
 };
}

function coerenciaHarmonica(x) {
  if (!vozes[x].cifras) { return; };
  // if (!x && x !== 0) { var i = 0, f = vozes.length-1; }
  //               else { var i = x, f = x; };
  var tom = tonicaTPC(btTonica.text, btAcid.text);
  for (var voz = 0; voz < vozes[1].tonal.length; voz++) {
    //for (var j=i; j<=f;j++) {
      var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
      var nota = vozes[x].tonal[voz] - tom;
      var acorde = cifra2notas(vozes[x].cifras, x);
      var pertence = sePertence(acorde, nota);
    //  console.log("nota não pertence ao acorde?", pertence, cHarmoniaEx.checked, notaAcento);
      if (!pertence && (!cHarmoniaEx.checked || notaAcento == "F")) {
        verificados++;
        criaResultado(verificados, x, voz, voz, "nota não pertence ao acorde", 1, 1);
      };
    //};
 };
}

function coerHarmFund() {

  var conjNotas = [];
  var tom;
  var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
  var cifraAtual, cifraAnterior, jAnterior;

  for (var j=0; j<vozes.length;j++) {
    cifraAtual = vozes[j].cifras;
    if (j == 0) { cifraAnterior = cifraAtual; jAnterior = j; };
    for (var voz = vozInicial; voz <= vozFinal; voz++) {
      if (cifraAtual == cifraAnterior) {
        conjNotas.push(vozes[j].tonal[voz]);
      } else {
        if (!cifraAnterior) { return; };
        var acorde = cifra2notas(cifraAnterior, jAnterior);
        tom = tonicaTPC(btTonica.text, btAcid.text);
        // console.log("acorde:", acorde);
        var fund = acorde[0] + tom;
        //console.log(j,") conjunto de notas", conjNotas, " == Fund:", fund);
        var pertence = sePertence(conjNotas, fund, tom);
        //console.log("fundamental?", pertence);
        if (!pertence && cHarmoniaF.checked) {
          var msg = cifraAnterior + " sem a fundamental";
          var ac = j - jAnterior;
          verificados++;
          criaResultado(verificados, j-1, 0, 1, msg, ac, 2);
        };
        jAnterior = j; cifraAnterior = cifraAtual;
        conjNotas = []; conjNotas.push(vozes[j].tonal[voz]);
      };

    };

 };


}
// ------------------------Dissonâncias ------------
function dissonanciasL() { console.log("=============== função dissonanciasL =============");
  // procura dissonâncias

  for (var x = 0; x < vozes.length; x++) {  // percorre acordes
    if (livreCP) { var tamanhoMov = ComparaMovimento(x);}
    var acusaDissonancia = true;
    if (cambiataL.checked && cambiata(x) != x) { x = cambiata(x); continue; };
    if (bordaduraD.checked && bordadura4(x) != x) { x = bordadura4(x); continue; };
    var intHarm = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));
    if (intHarm == "D") { //console.log("Dissonância em", x);
       //procura padrão melódico de tratamento, do maior para o menor, até 3 notas. Primeiro na voz superior, depois na inferior.
       if (suspensãoL.checked && suspensão5(x) != x) { x = suspensão5(x); continue; };
       if (suspensãoL.checked && suspensão4(x) != x) { x = suspensão4(x); continue; };
       if (suspensãoL.checked && suspensão3(x) != x) { x = suspensão3(x); continue; };
       if ((bordaduraLI.checked || bordaduraLS.checked) && bordadura(x) != x) { x = bordadura(x); continue; };
       if (passagemL.checked && notaPassagem(x) != x) { x = notaPassagem(x); continue; };
       if (apojaturaL.checked && apojatura(x) != x) { x = apojatura(x); continue; };
       if (antecipaL.checked && antecipação(x) != x) { x = antecipação(x); continue; };
       if (escapadaL.checked && escapada(x) != x) { x = escapada(x); continue; };
       if (acusaDissonancia) { coerenciaHarmonica(x);
        verificados++;
        criaResultado(verificados, x, 0, 1, "dissonância não tratada", 1, 2);
       };
    } else { acusaDissonancia = false; coerenciaHarmonica(x); };
  };
  function ComparaMovimento(x){

  };
  function suspensão3(x) { //console.log("=============== função suspensão3 =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x-1, r = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]));
      if (notaPrepara.substr(0, 1) == "C") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[r].nota[voz]) { r++; if (r >= vozes.length-1) { break; }; }; // procura nota posterior
    if (!notaPrepara) { var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1])); };
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    if (mov1 == 0 && mov2 != 0 && intM < 3 && notaPrepara != "D" && notaResolve != "D"  // desenho melódico, intervalos e consonâncias em t.f.
        && p < x && r > x && (notaAcento == "F" || (notaAcento == "f" && notaAcentoR == "c")) && // dissonância métrica forte
        (!suspeLEx3.checked || notaResolve == "CI") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1)) { // permitir também resolução ascendente
      var testaVozMove = true;
      for (var d = x+1; d < r; d++) {
        //console.log(d,") vozmove1", vozes[d].nota[0], vozes[d].nota[1]);
        var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]));
        if (vozmove1 == "D") {
          var voz2 = 1 - voz;
        //  console.log(voz2,voz,") vozmove", vozes[d].nota[voz2], vozes[r].nota[voz]);
          var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]));
          if (vozmove2 == "D") { testaVozMove = false; };
        };
      };
      if (testaVozMove) {
          console.log("Compasso", vozes[x].compasso, ",voz", voz, ",nota", x, " - Tratamento de dissonância: suspensão 3 notas"); acusaDissonancia = false; return r-1;
        } else { return x; };
      } else if (voz == qtVozes) { return x; };
   };
  };
  function suspensão4(x) { //console.log("=============== função suspensão4 =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes

    var p = x-1, i = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]));
      if (notaPrepara.substr(0, 1) == "C") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[i].nota[voz]) { // procura nota interrompe
      i++; if (i >= vozes.length) { i = vozes.length-1; break; }; };
     var r = i;
    while (vozes[i].nota[voz] == vozes[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozes.length-1) { r = vozes.length-1; break; }; };

    if (!notaPrepara) { var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1])); };
    var notaInterrompe = verificaConsonancia(Math.abs(vozes[i].nota[0] - vozes[i].nota[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var mov3 = direção(vozes[i].nota[voz] - vozes[x].nota[voz]);
    var mov4 = direção(vozes[r].nota[voz] - vozes[i].nota[voz]);
    var intM = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[i].nota[voz] - vozes[x].nota[voz]);
    var intM3 = Math.abs(vozes[r].nota[voz] - vozes[i].nota[voz]);

    if (mov1 == 0 && mov2 != 0 && intM < 3 && notaPrepara != "D" && notaResolve != "D" // desenho melódico, intervalos e consonâncias em t.f.
        && p < x && r > i && i > x && (notaAcento == "F" || (notaAcento == "f" && notaAcentoR == "c")) && // dissonância métrica forte
        mov3 != mov4 && mov3 != 0 && mov4 != 0 && intM2 < 8 && intM3 < 8 && (!suspeLEx1a.checked || notaInterrompe != "D") && suspeLEx1.checked && // resolução interrompida
        (!suspeLEx3.checked || notaResolve == "CI") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1)) { // permitir também resolução ascendente
          console.log("Compasso", vozes[x].compasso, ",voz", voz, ",nota", x, " - Tratamento de dissonância: suspensão RI 4 notas"); acusaDissonancia = false; return r-1;
      } else if (voz == qtVozes) { return x; };
   };
  };
  function suspensão5(x) { //console.log("=============== função suspensão5 =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes

    var p = x-1, i = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]));
      if (notaPrepara.substr(0, 1) == "C") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[i].nota[voz]) { // procura 1ª nota interrompe
      i++; if (i >= vozes.length) { i = vozes.length-1; break; }; };
     var i2 = i;
    while (vozes[i].nota[voz] == vozes[i2].nota[voz]) { // procura 2ª nota interrompe
       i2++; if (i2 >= vozes.length) { i2 = vozes.length-1; break; }; };
      var r = i2;
    while (vozes[i2].nota[voz] == vozes[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozes.length-1) { r = vozes.length-1; break; }; };

    if (!notaPrepara) { var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1])); };
    var notaInterrompe = verificaConsonancia(Math.abs(vozes[i].nota[0] - vozes[i].nota[1]));
    var notaInterrompe2 = verificaConsonancia(Math.abs(vozes[i].nota[0] - vozes[i].nota[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var mov3 = direção(vozes[i].nota[voz] - vozes[x].nota[voz]);
    var mov4 = direção(vozes[r].nota[voz] - vozes[i].nota[voz]);
    var intM = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[i].nota[voz] - vozes[x].nota[voz]);
    var intM3 = Math.abs(vozes[r].nota[voz] - vozes[i].nota[voz]);
    var intM4 = Math.abs(vozes[i2].nota[voz] - vozes[i].nota[voz]);
    var intM5 = Math.abs(vozes[r].nota[voz] - vozes[i2].nota[voz]);

    if (mov1 == 0 && mov2 != 0 && intM < 3 && notaPrepara != "D" && notaResolve != "D" // desenho melódico, intervalos e consonâncias em t.f.
        && p < x && r > i2 && i2 > i && i > x && (notaAcento == "F" || (notaAcento == "f" && notaAcentoR == "c")) && // dissonância métrica forte
        mov3 != mov4 && mov3 != 0 && mov4 != 0 && intM2 < 8 && intM3 < 8 && intM4 < 3 &&
        intM5 < 3 && (!suspeLEx1a.checked || notaInterrompe != "D") && suspeLEx1.checked && // resolução interrompida
        (!suspeLEx3.checked || notaResolve == "CI") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1)) { // permitir também resolução ascendente
          console.log("Compasso", vozes[x].compasso, ",voz", voz, ",nota", x, " - Tratamento de dissonância: suspensão RI 5 notas"); acusaDissonancia = false; return r-1;
      } else if (voz == qtVozes) { return x; };
   };
  };
  function cambiata(x) { //console.log(x,"=============== função cambiata =============");
   var diss1 = false, diss2 = false, diss3 = false;
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var np1 = x;
    while (vozes[x].nota[voz] == vozes[np1].nota[voz]) { // procura nota passagem 1
      np1++; if (np1 >= vozes.length) { np1 = vozes.length-1; break; }; };
     var np2 = np1;
    while (vozes[np1].nota[voz] == vozes[np2].nota[voz]) { // procura nota passagem 2
      np2++; if (np2 >= vozes.length) { np2 = vozes.length-1; break; }; };
     var np3 = np2;
    while (vozes[np2].nota[voz] == vozes[np3].nota[voz]) { // procura nota passagem 3
       np3++; if (np3 >= vozes.length) { np3 = vozes.length-1; break; }; };
      var r = np3;bbbvb
    while (vozes[np3].nota[voz] == vozes[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozes.length-1) { r = vozes.length-1; break; }; };
    var notaInicial = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var dCounter = 0; // contagem de dissonâncias
    if (verificaConsonancia(Math.abs(vozes[np1].nota[0] - vozes[np1].nota[1])) == "D") { dCounter++; diss1 = true; };
    if (verificaConsonancia(Math.abs(vozes[np2].nota[0] - vozes[np2].nota[1])) == "D") { dCounter++; diss2 = true; };
    if (verificaConsonancia(Math.abs(vozes[np3].nota[0] - vozes[np3].nota[1])) == "D") { dCounter++; diss3 = true; };
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]); // posição métrica das notasIguais
    var notaAcento1 = verificaTempoForte(vozes[np1].tempo[voz],vozes[np1].formula[0]);
    var notaAcento2 = verificaTempoForte(vozes[np2].tempo[voz],vozes[np2].formula[0]);
    var notaAcento3 = verificaTempoForte(vozes[np3].tempo[voz],vozes[np3].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov0 = direção(vozes[np1].nota[voz] - vozes[x].nota[voz]);
    var mov1 = direção(vozes[np2].nota[voz] - vozes[np1].nota[voz]);
    var mov2 = direção(vozes[np3].nota[voz] - vozes[np2].nota[voz]);
    var mov3 = direção(vozes[r].nota[voz] - vozes[np3].nota[voz]);
    var mov4 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var dirCF = direção(vozes[r].nota[vozCF] - vozes[x].nota[vozCF]);
    var intM0 = Math.abs(vozes[x].nota[voz] - vozes[np1].nota[voz]);
    var intM1 = Math.abs(vozes[np1].nota[voz] - vozes[np2].nota[voz]);
    var intM2 = Math.abs(vozes[np2].nota[voz] - vozes[np3].nota[voz]);
    var intM3 = Math.abs(vozes[np3].nota[voz] - vozes[r].nota[voz]);
    var intM4 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);

    if (mov0 == mov1 && mov1 != 0 && mov2 == mov1*-1 && mov3 == mov2 && // contorno melódico
        intM0 < 3 && (intM1 == 3 || intM1 == 4) && intM2 < 3 && intM3 < 3 && // intervalos melódicos
        (notaAcento == "F" && notaAcentoR == "F" || !cambiLEx1.checked) && // posição métrica 1ª e última nota
        (((!diss1 || notaAcento1 != "F") && (!diss2 || notaAcento2 != "F" ) && // dissonancia em tempo fraco
         (!diss3 || notaAcento3 != "F")) || !cambiLEx3.checked) &&
        (diss1 || !cambiLEx4.checked) && // 2ª nota deve ser dissonante
        ((vozes[np1].duração[voz] < vozes[x].duração[voz] && vozes[np1].duração[voz] < vozes[r].duração[voz]) || !cambiLEx5.checked) && // duração 2ª nota < 1ª e última
        (dirCF == mov4 || !cambiLEx2.checked) && // cambiata na mesma direção do CF
        dCounter < 3 && // quantidade de dissonâncias
        notaInicial != "D" && notaResolve != "D" // consonâncias
      ) {
          console.log("Compasso", vozes[x].compasso, ",voz", voz, ",nota", x, " - Tratamento de dissonância: cambiata"); acusaDissonancia = false; return r-1;
      } else if (voz == qtVozes) { return x; };
   };
  };
  function bordadura(x) { //console.log("=============== função borddadura =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes

    var p = x-1, r = x; // preparação, resolução
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]));
      if (notaPrepara.substr(0, 1) == "C") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[r].nota[voz]) { r++; if (r >= vozes.length-1) { break; }; }; // procura nota posterior
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);

    if (mov1 != 0 && mov1 == mov2*-1 && intM1 < 3 && intM2 < 3 && notaPrepara != "D" &&
        notaResolve.substr(0, 1) == "C" && p < x && r > x && (notaAcento != "F" || !bordaLEx.checked) &&
        ((mov1 > 0 && bordaduraLS.checked) || (mov1 < 0 && bordaduraLI.checked))) {
      var testaVozMove = true;
      for (var d = x+1; d < r; d++) {
        var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]));
        if (vozmove1 == "D") {
          var voz2 = 1 - voz;
          var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]));
          if (vozmove2.substr(0, 1) != "C") { testaVozMove = false; };
        };
      };
      if (testaVozMove) {
          console.log("Compasso", vozes[x].compasso, "voz", voz, ",nota", x, " - Tratamento de dissonância: Bordadura"); acusaDissonancia = false; return r-1;
        } else { return x; };
      } else if (voz == qtVozes) { return x; };
   };
  };
  function bordadura4(x) { //console.log(x,"=============== função bordadura4 =============");
   if (x == 0 || x+2 >= vozes.length) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x-1, r = x+2; // preparação, resolução
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]));
    var notaBorda1 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));
    var notaBorda2 = verificaConsonancia(Math.abs(vozes[x+1].nota[0] - vozes[x+1].nota[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaAcento0 = verificaTempoForte(vozes[p].tempo[voz],vozes[p].formula[0]);
    var notaAcento1 = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcento2 = verificaTempoForte(vozes[x+1].tempo[voz],vozes[x+1].formula[0]);
    var notaAcento3 = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[x+1].nota[voz] - vozes[x].nota[voz]);
    var mov3 = direção(vozes[r].nota[voz] - vozes[x+1].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[x+1].nota[voz] - vozes[x].nota[voz]);
    var intM3 = Math.abs(vozes[r].nota[voz] - vozes[x+1].nota[voz]);
//console.log(x,")", vozes[p].nota[voz], vozes[x].nota[voz], vozes[x+1].nota[voz],vozes[r].nota[voz], "|",
             //notaPrepara, notaBorda1, notaBorda2, notaResolve, "|", notaAcento1, notaAcento2, "|", mov1, mov2, mov3, "|", intM1, intM2, intM3);
    if (mov1 != 0 && mov1 == mov2*-1 && mov3 == mov1 &&
        intM1 < 3 && intM3 < 3 && (intM2 == 3 || intM2 == 4) &&
        (notaBorda1 == "D" || notaBorda2 == "D") &&
        notaPrepara != "D" && notaResolve != "D" && p < x && r > x+1 &&
        ((notaAcento0 == "F" && notaAcento3 == "F") || !bordaLEx2.checked) &&
        ((notaAcento1 != "F" && notaAcento2 != "F") || !bordaLEx1.checked)) {
      var testaVozMove = true;
      for (var d = x+1; d < r; d++) {
        var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]));
        if (vozmove1 == "D") {
          var voz2 = 1 - voz;
          var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]));
          if (vozmove2 == "D") { testaVozMove = false; };
        };
      };
      if (testaVozMove) {
          console.log("Compasso", vozes[x].compasso, "voz", voz, ",nota", x, " - Tratamento de dissonância: Bordadura dupla"); acusaDissonancia = false; return r-1;
        } else { return x-1; };
      } else if (voz == qtVozes) { return x; };
   };
  };
  function notaPassagem(x) { //console.log("=============== função NP =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes

    var p = x-1, r = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]));
      if (notaPrepara.substr(0, 1) == "C") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[r].nota[voz]) { r++; if (r >= vozes.length-1) { break; }; }; // procura nota posterior
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);

    if (mov1 == mov2 && mov1 != 0 && intM1 < 3 && intM2 < 3 && notaPrepara != "D" && notaResolve != "D"
        && p < x && r > x && (notaAcento != "F" || !passaLEx.checked)) {
      var testaVozMove = true;
      for (var d = x+1; d < r; d++) {
        var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]));
        if (vozmove1 == "D") {
          var voz2 = 1 - voz;
          var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]));
          if (vozmove2.substr(0, 1) != "C") { testaVozMove = false; };
        };
      };
      if (testaVozMove) {
          console.log("Compasso", vozes[x].compasso, ",voz", voz, ",nota", x, " - Tratamento de dissonância: Nota de passagem");
          acusaDissonancia = false; return r-1;
        } else { return x; };
      } else if (voz == qtVozes) { return x; };
   };
  };
  function apojatura(x) { //console.log("=============== função apojatura =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes

    var p = x-1, r = x+1;
    if (!notaPrepara) { var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1])); };
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
//console.log(x,")");
    if ( notaResolve != "D" && p < x && r > x && intM1 > 2 && intM2 < 3 && notaPrepara != "D" &&
        (mov1 != 0 && (!apojaEx2.checked || mov1 == 1)) &&  // introduzida por movimento ascendente
        (mov2 != 0 && (!apojaEx3.checked || mov2 == -1)) && // resolução descendente
        (!apojaEx1.checked || (notaAcento == "F" || (notaAcento == "f" && notaAcentoR == "c")))) {
      var testaVozMove = true;
      for (var d = x+1; d < r; d++) {
        var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]));
        if (vozmove1 == "D") {
          var voz2 = 1 - voz;
          var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]));
          if (vozmove2.substr(0, 1) != "C") { testaVozMove = false; };
        };
      };
      if (testaVozMove) {
          console.log("Compasso", vozes[x].compasso, ",voz", voz, ",nota", x, " - Tratamento de dissonância: Apojatura");
          acusaDissonancia = false; return r;
        } else { return x; };
      } else if (voz == qtVozes) { return x; };
   };
  };
  function antecipação(x) { //console.log("=============== função antecipação =============");
   if (x == 0) { acusaDissonancia = false; return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes

    var r = x+1;
    // while (vozes[x].nota[voz] == vozes[r].nota[voz] && vozes[r].ligadura[voz]) {
    //   r++; if (r >= vozes.length-1) { break; }; }; // procura nota posterior
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var int1 = vozes[x].nota[voz] - vozes[x-1].nota[voz];
    if (mov1 == 0 && notaResolve != "D" && r > x &&
            (notaAcentoR == "F" || (notaAcentoR == "f" && notaAcento == "c")) &&
            ((antecipaEx2.checked && antecipaEx3.checked && ((int1 > -3 && int1 < 0) || (int1 < 3 && int1 > 0))) ||
            (antecipaEx2.checked && !antecipaEx3.checked && (int1 > -3 && int1 < 0)) ||
            (!antecipaEx2.checked && antecipaEx3.checked && (int1 < 3 && int1 > 0)) ||
            (!antecipaEx2.checked && !antecipaEx3.checked)) &&
            (!antecipaEx4.checked || r == vozes.length-1)) {
      var testaVozMove = true;
      for (var d = x+1; d < r; d++) {
        var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]));
        if (vozmove1 == "D") {
          var voz2 = 1 - voz;
          var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]));
          if (vozmove2.substr(0, 1) != "C") { testaVozMove = false; };
        };
      };
      if (testaVozMove) {
          console.log("Compasso", vozes[x].compasso, ",voz", voz, ",nota", x, " - Tratamento de dissonância: Antecipação");
          acusaDissonancia = false; return r;
        } else { return x; };
      } else if (voz == qtVozes) { return x; };
   };
  };
  function escapada(x){ //console.log("=============== função escapada =============");
    if (x == 0) { return x; };
    var qtVozes, vozIni;
    if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
             else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
    for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
     var p = x-1, r = x+1;
     if (!notaPrepara) { var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1])); };
     var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
     var notaAcentoP = verificaTempoForte(vozes[p].tempo[voz],vozes[p].formula[0]);
     var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
     var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
     var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
     var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
     var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
     var intM2 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
 //console.log(x,")");
     if (notaResolve != "D" && p < x && r > x && intM1 < 3 && intM2 > 2 && notaPrepara != "D" &&
         mov1 != 0 &&  (mov2 != 0 && mov2 != mov1) && notaAcentoR != "c" && notaAcentoP != "c" &&
         (!escapaEx1.checked || (notaAcento == "f" || (notaAcento == "c")))) {
       var testaVozMove = true;
       for (var d = x+1; d < r; d++) {
         var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]));
         if (vozmove1 == "D") {
           var voz2 = 1 - voz;
           var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]));
           if (vozmove2.substr(0, 1) != "C") { testaVozMove = false; };
         };
       };
       if (testaVozMove) {
           console.log("Compasso", vozes[x].compasso, ",voz", voz, ",nota", x, " - Tratamento de dissonância: Escapada");
           acusaDissonancia = false; return r;
         } else { return x; };
       } else if (voz == qtVozes) { return x; };
    };
  };
}
//------------------------------------------------------------------------------
function criaResultado(verificados, x, voz, i, tipo, numAcordes, numVozes) {
//console.log(x, voz, i, tipo, numAcordes, numVozes);
 	var primAcorde = x - (numAcordes-1);
 	var compAnt = Math.floor(vozes[primAcorde].compasso);
 	var compAtual = Math.floor(vozes[x].compasso);
 	var qtdVozes = vozes[x].nota.length;

 	if (compAnt != compAtual && numAcordes > 1) { var compasso = compAnt+" ao "+compAtual;}
 														  else { var compasso = compAtual; };

 	switch (numVozes) {   // cria mensagem de texto
     case "ne":
 	   case 1: var qualVoz = ", na voz "+ (voz+1); break;
 	   case "fr": //falsa relação
     case "in": //intermitente
 	   case 2: var qualVoz = ", vozes "+(voz+1)+" e "+(i+1); break;
 	   case "null":
 	   case qtdVozes: var qualVoz = ""; break;
 	};

   var texto = verificados+") "+tipo+": compasso "+ compasso + qualVoz;

   resultado[verificados] = [texto];

   for (var y=primAcorde;y<=x;y++) {  // cria array de objetos para colorir

   	switch (numVozes) {
   		case 1: resultado[verificados].push(vozes[y].objeto[voz]); break;
   		case 2: resultado[verificados].push(vozes[y].objeto[voz], vozes[y].objeto[i]); break;
   		case "null":
   		case qtdVozes: for (var k=0;k<qtdVozes;k++) {
   							  resultado[verificados].push(vozes[y].objeto[k]);
   		               }; break;
   		case "fr": if (y == primAcorde) { resultado[verificados].push(vozes[y].objeto[voz]); }
   						else { resultado[verificados].push(vozes[y].objeto[i]); }; break;
      case "ne":
        if (y == primAcorde || y == x) { resultado[verificados].push(vozes[y].objeto[voz]); }; break;
      case "in":
        if (y == primAcorde || y == x) { resultado[verificados].push(vozes[y].objeto[voz], vozes[y].objeto[i]); }; break;
    };
   };
 }
//---------------------------------------------------------

  onRun: {

  openFile('file:///home/rogerio/Documentos/UFPel/Projeto Harmonia e Contraponto/Plugins/Contraponto/config.txt');

  //   inicializaVariáveis();
  //   carregarCfg();
  //  function inicializaVariáveis() {
  //   var preSet = "true-true-true-true-true-true-true-true-true-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-false-false-true-true-true-false-false-true-0-true-true-true-true-true-1-10-true-true-true-false-true-true-false-true-true-false-false-false-false-false-true-true-true-false-false-false-false-false-false-false-false-false-false-false-true-true-12-true-true-true-true-true-true-true-true-false-true-true-true-true-true-false-true-true-true-true-4-true-1-false-true-0-true-1-true-true-true-false-true-true-2-true-false-false-true-false-false-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-true-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-false-false-true-true-true-false-false-true-0-true-true-true-true-true-1-10-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-16-true-true-true-false-false-true-true-false-false-false-true-true-true-true-false-true-true-true-true-4-true-1-false-true-0-true-1-true-false-true-false-true-true-2-true-false-false-true-false-false-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-true-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-false-false-true-true-true-false-false-true-0-true-true-true-true-true-3-10-true-true-true-true-true-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-19-true-true-true-false-false-true-true-false-false-false-true-true-true-true-false-true-true-true-true-4-true-1-true-true-1-true-2-true-false-true-false-true-true-4-true-false-false-true-false-false-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-true-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-false-false-true-true-true-false-false-true-1-true-true-true-true-true-5-10-true-true-true-false-true-true-false-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-19-true-true-true-false-false-true-true-false-false-false-true-true-true-true-false-true-true-true-true-4-true-1-true-true-2-true-4-true-false-true-false-true-true-8-true-false-false-true-false-false-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-true-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-false-false-true-true-true-false-false-true-0-true-true-true-true-true-3-10-true-true-true-true-true-true-true-false-false-false-false-false-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-19-true-true-true-false-false-true-true-false-false-false-true-true-true-true-false-true-true-true-true-4-true-1-false-true-2-true-2-true-false-true-false-true-true-4-true-false-false-true-false-false-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-true-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-false-false-true-true-true-false-false-true-2-true-true-true-true-true-6-10-true-true-true-false-true-true-false-true-true-false-false-false-false-true-true-true-true-false-false-false-false-false-false-false-false-false-false-false-true-true-21-true-true-true-false-false-true-true-false-false-false-true-true-true-true-false-true-true-true-true-4-true-2-true-true-3-true-4-true-false-true-false-true-true-8-true-false-false-true-false-false-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-true-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-false-false-true-true-true-false-false-true-0-true-true-true-true-true-6-10-true-true-true-false-true-true-false-true-true-false-false-false-false-true-true-true-true-false-true-true-true-false-true-false-false-false-true-true-true-true-21-true-true-true-false-false-true-true-false-false-false-true-true-true-true-false-true-true-true-true-4-true-3-true-true-3-true-5-true-false-true-false-true-true-8-true-false-false-true-false-false-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false"
  //       preSet = preSet.split("-");
  //
  //       for (var i=0;i<preSet.length;i++) {
  //         if (preSet[i] == "true") { preSet[i] = true; } else
  //         if (preSet[i] == "false") { preSet[i] = false; };
  //         config[i] = preSet[i];
  //       };
  //
  //     console.log(config.length, config[config.length-1]);
  //
  // }

  } // fecha onRun

} // fecha função Musescore
