//=========================================================================================\\
//  Analisador de Contrapontos v0.5.2                                                      \\
//                                                                                         \\
//  Copyright (C)2026 Rogério Tavares Constante                                            \\
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

import QtQuick 2.15
import QtQuick.Controls 2.15
import MuseScore 3.0
import Muse.UiComponents

MuseScore {
      version: "0.5.2"
      title: "Analisador de Contrapontos"
      pluginType: "dialog"
      categoryCode: "Contraponto"
      thumbnailName: "Logo.png"
      menuPath: "Plugins.Contraponto.Analisador"
      description: "Analisador de Contrapontos.\nPlugin de auxílio na correção de exercícios de contraponto."

      width: 900
      height: 600

      // Variáveis de cor globais
      property color corFundoPrincipal: "#1e1e1e"
      property color corPainel: "#252525"
      property color corPainelInterno: "#2d2d2d"
      property color corPainelDestaque: "#333333"

      property color corTextoPrimario: "#e0e0e0"
      property color corTextoSecundario: "#a0a0a0"
      property color corTextoDestaque: "#4a9eff"
      property color corTextoAlerta: "#9a7fcc"
      property color corTextoSucesso: "#4caf50"

      property color corBorda: "#404040"
      property color corBordaDestaque: "#505050"

      property color corBotaoNormal: "#8a7fba"//"#614963" "#3a3a3a"
      property color corBotaoHover: "#444444"
      property color corBotaoSelecionado: "#2a5caa"
      property color corBotaoAcaoPrimario: "#2a5caa"
      property color corBotaoAcaoSecundario: "#7287a6" //"#5d5e80" "#424242"

      property color corCheckBox: "#4a9eff"
      property color corInput: "yellow"
      property color corInputFundo: "#2a2a2a"

      property int currentView: 0
      property int tipoBotoes: 0

      Rectangle { // fundo
        x: 0; y: 0
        width: parent.width
        height: parent.height
        color: corFundoPrincipal
        border.width: 2
        border.color: corBorda
      }
      // Painel superior esquerdo
      Rectangle {
        id: painelEsquerdo
        x: 2; y: 2
        width: 700
        height: 550
        border.color: corBorda
        border.width: 1
        color: corPainel

        Rectangle { // página inicial
          x: 5; y: 5
          width: painelEsquerdo.width-10
          height: painelEsquerdo.height-10
          color: corPainelInterno
          border.color: corBordaDestaque
          visible: currentView === 0

          StyledTextLabel {
            width: parent.width
            y: painelEsquerdo.height/2-40
            text: "Analisador de Contrapontos v0.52"
            color: corTextoDestaque
            font.pixelSize: 30
          }
          StyledTextLabel {
            width: parent.width
            y: painelEsquerdo.height/2-5
            text: "extensão para MuseScore 4.6.5"
            color: corTextoSecundario
            font.pixelSize: 16
          }
        }
        Rectangle { // Condução de Vozes
          x: 5; y: 5
          width: painelEsquerdo.width-10
          height: painelEsquerdo.height-10
          color: corPainelInterno
          border.color: corBordaDestaque
          visible: currentView === 1

          StyledTextLabel {
            x: 5; y: 5
            text: "Condução de Vozes"
            color: corTextoDestaque
            font.pixelSize: 18
          }
          Rectangle { // paralelas
            x: 5; y: 5
            width: 680
            height: 42
            color: corPainelDestaque

            CheckBox { // 8ª
              id: paralela8
              x: 5; y: 3
              text: qsTranslate("PrefsDialogBase","U/8ª paralela")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: par8RepTxt
              x: 5; y: 25
              text: qsTranslate("PrefsDialogBase", "- se ocorrer")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: par8RepTxt.right; anchors.leftMargin: 5; y: par8RepTxt.y;
              color: "transparent"
              TextInput {
                id: par8Rep;
                anchors.fill: parent
                text: "1"
                font.pixelSize: 10
                color: corInput
                validator: IntValidator { bottom: 0; top: 9 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: par8RepTxt.right; anchors.leftMargin: 15; y: par8RepTxt.y;
              text: "ou mais paralela(s)"
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox { // 5ª
              id: paralela5
              x: 170; y: 3
              text: qsTranslate("PrefsDialogBase","5ª paralela")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: par5RepTxt
              x: paralela5.x; y: 25
              text: qsTranslate("PrefsDialogBase", "- se ocorrer")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: par5RepTxt.right; anchors.leftMargin: 5; y: par5RepTxt.y;
              color: "transparent"
              TextInput {
                id: par5Rep;
                anchors.fill: parent
                text: "1"
                font.pixelSize: 10
                color: corInput
                validator: IntValidator { bottom: 0; top: 9 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: par5RepTxt.right; anchors.leftMargin: 15; y: par5RepTxt.y;
              text: "ou mais paralela(s)"
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox { // 4ª
              id: paralela4
              x: 345; y: 3
              text: qsTranslate("PrefsDialogBase", "4ªJ paralela")
              checked: false
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: par4RepTxt
              x: paralela4.x;
              y: 25
              text: qsTranslate("PrefsDialogBase", "- se ocorrer")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: par4RepTxt.right; anchors.leftMargin: 5; y: par4RepTxt.y;
              color: "transparent"
              TextInput {
                id: par4Rep
                anchors.fill: parent
                text: "1"
                font.pixelSize: 10
                color: corInput
                validator: IntValidator { bottom: 0; top: 9 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: par4RepTxt.right; anchors.leftMargin: 15; y: par4RepTxt.y;
              text: qsTranslate("PrefsDialogBase", "ou mais paralela(s)")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox { // 3ª e 6ª
              id: paralela36
              x: 520; y: 3
              text: qsTranslate("PrefsDialogBase", "3ª e 6ª paralela")
              checked: false
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: par36RepTxt
              x: paralela36.x;
              y: 25
              text: qsTranslate("PrefsDialogBase", "- se ocorrer")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: par36RepTxt.right; anchors.leftMargin: 5; y: par36RepTxt.y;
              color: "transparent"
              TextInput {
                id: par36Rep
                anchors.fill: parent
                text: "1"
                font.pixelSize: 10
                color: corInput
                validator: IntValidator { bottom: 0; top: 9 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: par36RepTxt.right; anchors.leftMargin: 15; y: par36RepTxt.y;
              text: qsTranslate("PrefsDialogBase", "ou mais paralela(s)")
              font.pixelSize: 10
              color: corTextoPrimario
            }
          }
          Rectangle { // ocultas
            x: 5; y: 50
            width: 680
            height: 50
            color: corPainelDestaque

            CheckBox {
              id: oculta8
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "8ª oculta/direta")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: oculta5
              x: 170; y: 5
              text: qsTranslate("PrefsDialogBase", "5ª oculta/direta")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: ocultEx
              x: 50; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "Exceto no final")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: ocultExt
              x: 215; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "Somente entre as vozes externas")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: ocultSalto
              x: 470; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "Somente com salto na voz superior")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
          }
          Rectangle { // intermitentes
            id: intermitentes
            x: 5; y: 103
            width: 680
            height: 190
            color: corPainelDestaque
            property int colX: 25
            function row(a,b) {
              return a + 18 * b
            }

            CheckBox { // Linha 1
              id: inter8
              x: 5; y: 3
              text: qsTranslate("PrefsDialogBase", "U/8ª intermitente")
              checked: true
            }
            CheckBox {
              id: inter5
              x: 170; y: 3
              text: qsTranslate("PrefsDialogBase", "5ª intermitente")
              checked: true
            }
            CheckBox { // Coluna esquerda
              id: interPM
              x: intermitentes.colX; y: intermitentes.row(8,1)
              scale: 0.8
              checked: true
            }
            StyledTextLabel {
              anchors.left: interPM.right; anchors.leftMargin: 5; y: interPM.y+5;
              text: qsTranslate("PrefsDialogBase", "Na mesma posição métrica")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: interSI
              x: intermitentes.colX; y: intermitentes.row(8,2)
              scale: 0.8
              checked: true
            }
            StyledTextLabel {
              anchors.left: interSI.right; anchors.leftMargin: 5; y: interSI.y+5;
              text: qsTranslate("PrefsDialogBase", "Separadas por um único intervalo")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: interExS
              x: intermitentes.colX; y: intermitentes.row(8,3)
              scale: 0.8
              checked: true
            }
            StyledTextLabel {
              anchors.left: interExS.right; anchors.leftMargin: 5; y: interExS.y+5;
              text: qsTranslate("PrefsDialogBase", "Exceto se separadas por")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 10
              anchors.left: interExS.right; anchors.leftMargin: 107; y: interExS.y+5;
              color: "transparent"
              TextInput {
                id: interExSn
                anchors.fill: parent
                text: "0"
                font.pixelSize: 9
                color: corInput
                validator: IntValidator { bottom: 0; top: 9 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: interExS.right; anchors.leftMargin: 117; y: interExS.y+5;
              text: qsTranslate("PrefsDialogBase", "intervalo(s)")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: interExTf
              x: intermitentes.colX; y: intermitentes.row(8,4)
              scale: 0.8
              checked: true
            }
            StyledTextLabel {
              anchors.left: interExTf.right; anchors.leftMargin: 5; y: interExTf.y+5;
              text: qsTranslate("PrefsDialogBase", "Exceto em tempo fraco e")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: interExTf3
              anchors.left: interExTf.right; anchors.leftMargin: 100; y: interExTf.y;
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "em tempo meio-forte:")
              font.pixelSize: 11
              checked: true
            }
            CheckBox {
              id: interExTf1
              x: intermitentes.colX+20; y: intermitentes.row(7,5)
              scale: 0.7
              text: qsTranslate("PrefsDialogBase", "Sincopada e")
              checked: true
            }
            CheckBox {
              id: interExTf2
              x: intermitentes.colX+75; y: intermitentes.row(7,5)
              scale: 0.7
              text: qsTranslate("PrefsDialogBase", "alcançada por grau conjunto")
              checked: true
            }
            CheckBox {
              id: interExTF
              x: intermitentes.colX; y: intermitentes.row(5,6)
              scale: 0.8
              checked: true
            }
            StyledTextLabel {
              anchors.left: interExTF.right; anchors.leftMargin: 5; y: interExTF.y+5;
              text: qsTranslate("PrefsDialogBase", "Exceto em tempo forte com ambas notas ligadas às anteriores")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: interExFim
              x: intermitentes.colX; y: intermitentes.row(5,7)
              scale: 0.8
              checked: true
            }
            StyledTextLabel {
              anchors.left: interExFim.right; anchors.leftMargin: 5; y: interExFim.y+5;
              text: qsTranslate("PrefsDialogBase", "Exceto na cadência final")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: interExCF
              x: intermitentes.colX; y: intermitentes.row(5,8)
              scale: 0.8
              checked: true
            }
            StyledTextLabel {
              anchors.left: interExCF.right; anchors.leftMargin: 5; y: interExCF.y+5;
              text: qsTranslate("PrefsDialogBase", "Exceto se CF não se move")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: interExt
              x: intermitentes.colX; y: intermitentes.row(5,9)
              scale: 0.8
              checked: true
            }
            StyledTextLabel {
              anchors.left: interExt.right; anchors.leftMargin: 5; y: interExt.y+5;
              text: qsTranslate("PrefsDialogBase", "Somente nas vozes externas")
              font.pixelSize: 9
              color: corTextoPrimario
            }
          }
          Rectangle { // movimentos similares
            x: 5; y: 296
            width: 680
            height: 55
            color: corPainelDestaque

            CheckBox {
              id: movContObli
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "priorizar movimento contrário e oblíquo")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: movSim
              x: 5; y: 30
              text: qsTranslate("PrefsDialogBase", "Qtd Máxima de")
              font.pixelSize: 11
              checked: true
            }
            Rectangle {
              anchors.left: movSim.left
              anchors.leftMargin: 108
              y: movSim.y+4
              width: 5
              height: 11
              color: "transparent"
              TextInput {
                id: qtdMovSim
                anchors.fill: parent
                text: "0"
                font.pixelSize: 10
                color: corInput
                validator: IntValidator { bottom: 0; top: 9 }
              }
            }
            StyledTextLabel {
              anchors.left: parent.left
              anchors.leftMargin: 123
              y: movSim.y+4
              text: qsTranslate("PrefsDialogBase", "movimentos similares, em sequência, em todas as vozes")
              font.pixelSize: 11
              color: corTextoPrimario
            }
          }
          Rectangle { // consecutivas por movimento contrário e oblíquo
            x: 5; y: 354
            width: 338
            height: 55
            color: corPainelDestaque

            CheckBox {
              id: consecObli
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "5ª e 8ª consecutivas por mov. oblíquo")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: consecCont
              x: 5; y: 30
              text: qsTranslate("PrefsDialogBase", "5ª e 8ª consecutivas por mov. contrário")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
          }
          Rectangle { // cruzamento de vozes
            x: 347; y: 354
            width: 338
            height: 55
            color: corPainelDestaque

            CheckBox {
              id: cruzaVozes
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Cruzamento de vozes")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: falsaR
              x: 5; y: 30
              text: qsTranslate("PrefsDialogBase", "Falsa relação")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
          }
          Rectangle { // uníssono
            x: 5; y: 412
            width: 680
            height: 41
            color: corPainelDestaque

            CheckBox {
              id: uniss
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Uníssono")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: unissTxt
              x: 5; y: 25
              text: qsTranslate("PrefsDialogBase", "- se quantidade for maior do que")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: unissTxt.right; anchors.leftMargin: 5; y: unissTxt.y;
              color: "transparent"
              TextInput {
                id: unissQt;
                anchors.fill: parent
                text: "1"
                font.pixelSize: 10
                color: corInput
                validator: IntValidator { bottom: 0; top: 9 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            CheckBox {
              id: unissIF
              x: 170; y: 5
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "Exceto Início/Final")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: unissTF
              x: 320; y: 5
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "Exceto tempo fraco")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: unissTmF
              x: 440; y: 5
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "e meio forte")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
          }
        }
        Rectangle { // Dissonâncias
          id: dissonancias
          x: 5; y: 5
          width: painelEsquerdo.width-10
          height: painelEsquerdo.height-10
          color: corPainelInterno
          border.color: corBordaDestaque
          visible: currentView === 2

          property int colX: 25
          function row(a,b) {
            return a + 18 * b
          }
          Rectangle { // verificar dissonâncias
            x: 5; y: 5
            width: 680
            height: 30
            color: corPainelDestaque

            CheckBox {
              id: dissonanciasG
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Verificar dissonâncias")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            Button { // Botão de intervalos
              id: btIntervalos
              x: 505; y: 5
              width: 170
              height: 20
              background: Rectangle {
                color: btIntervalos.pressed ? corBotaoSelecionado : corBotaoNormal
                radius: 4
              }
              text: qsTranslate("PrefsDialogBase", "Configurar intervalos")
              onClicked: {
                configInt.open()
              }
            }
          }
          Rectangle { // Nota de passagem
            x: 5; y: 38
            width: 680
            height: 50
            color: corPainelDestaque

            CheckBox {
              id: passagemL
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Nota de passagem")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: passaLEx2
              x: 150; y: 5
              text: qsTranslate("PrefsDialogBase", "e Grupo de NP")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: passaLEx
              x: 15; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "somente em tempo fraco")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: passaLExMF
              x: 160; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "ou meio forte")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
          }
          Rectangle { // Bordaduras
            x: 5; y: 91
            width: 680
            height: 48
            color: corPainelDestaque

            StyledTextLabel {
              x: 5; y: 3
              text: qsTranslate("PrefsDialogBase", "Bordadura")
              font.pixelSize: 13
              color: corTextoPrimario
            }
            CheckBox {
              id: bordaduraLI
              x: 75; y: 1
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "inferior")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: bordaduraLS
              x: 150; y: 1
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "superior")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: bordaLEx
              x: 290; y: 1
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "somente em tempo fraco")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: bordaLExMF
              x: 440; y: 1
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "ou meio forte")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: bordaduraD
              x: 5; y: 25
              text: qsTranslate("PrefsDialogBase", "Bordadura dupla")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: bordaLEx1
              x: 110; y: 25
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "somente em tempo fraco ou meio forte")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
          }
          Rectangle { // Cambiata
            x: 5; y: 142
            width: 343
            height: 120
            color: corPainelDestaque

            CheckBox {
              id: cambiataL
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Cambiata")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: cambiLEx1
              x: dissonancias.colX; y: dissonancias.row(8, 1)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cambiLEx1.right; anchors.leftMargin: 5; y: cambiLEx1.y+5;
              text: qsTranslate("PrefsDialogBase", "1ª e última nota em tempo forte")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: cambiLEx1MF
              x: dissonancias.colX+165; y: dissonancias.row(8, 1)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cambiLEx1MF.right; anchors.leftMargin: 5; y: cambiLEx1MF.y+5;
              text: qsTranslate("PrefsDialogBase", "ou meio forte")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: cambiLEx2
              x: dissonancias.colX; y: dissonancias.row(8, 2)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cambiLEx2.right; anchors.leftMargin: 5; y: cambiLEx2.y+5;
              text: qsTranslate("PrefsDialogBase", "cambiata na mesma direção do CF")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: cambiLEx3
              x: dissonancias.colX; y: dissonancias.row(8, 3)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cambiLEx3.right; anchors.leftMargin: 5; y: cambiLEx3.y+5;
              text: qsTranslate("PrefsDialogBase", "dissonâncias somente em tempo fraco")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: cambiLEx3MF
              x: dissonancias.colX+187; y: dissonancias.row(8, 3)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cambiLEx3MF.right; anchors.leftMargin: 5; y: cambiLEx3MF.y+5;
              text: qsTranslate("PrefsDialogBase", "ou meio forte")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: cambiLEx4
              x: dissonancias.colX; y: dissonancias.row(8, 4)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cambiLEx4.right; anchors.leftMargin: 5; y: cambiLEx4.y+5;
              text: qsTranslate("PrefsDialogBase", "2ª nota deve ser dissonânte")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: cambiLEx5
              x: dissonancias.colX; y: dissonancias.row(8, 5)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cambiLEx5.right; anchors.leftMargin: 5; y: cambiLEx5.y+5;
              text: qsTranslate("PrefsDialogBase", "2ª nota com duração igual ou mais curta do que a 1ª e a última")
              font.pixelSize: 9
              color: corTextoPrimario
            }
          }
          Rectangle { // Suspensão
            x: 351; y: 142
            width: 334
            height: 90
            color: corPainelDestaque

            CheckBox {
              id: suspensãoL
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Suspensão")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: suspeLEx1
              x: dissonancias.colX; y: dissonancias.row(8, 1)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: suspeLEx1.right; anchors.leftMargin: 5; y: suspeLEx1.y+5;
              text: qsTranslate("PrefsDialogBase", "resolução interrompida")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: suspeLEx1a
              x: dissonancias.colX+135; y: dissonancias.row(8, 1)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: suspeLEx1a.right; anchors.leftMargin: 5; y: suspeLEx1a.y+5;
              text: qsTranslate("PrefsDialogBase", "somente por consonâncias")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: suspeLEx2
              x: dissonancias.colX; y: dissonancias.row(8, 2)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: suspeLEx2.right; anchors.leftMargin: 5; y: suspeLEx2.y+5;
              text: qsTranslate("PrefsDialogBase", "também a resolução ascendente (retardo)")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: suspeLEx3
              x: dissonancias.colX; y: dissonancias.row(8, 3)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: suspeLEx3.right; anchors.leftMargin: 5; y: suspeLEx3.y+5;
              text: qsTranslate("PrefsDialogBase", "resolução somente em consonância imperfeita")
              font.pixelSize: 9
              color: corTextoPrimario
            }
          }
          Rectangle { // Antecipação
            x: 5; y: 265
            width: 343
            height: 61
            color: corPainelDestaque

            CheckBox {
              id: antecipaL
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Antecipação")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              x: dissonancias.colX+3; y: dissonancias.row(10, 1)
              text: qsTranslate("PrefsDialogBase", "introduzida por grau conjunto (")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: antecipaEx2
              x: dissonancias.colX+125; y: dissonancias.row(5, 1)
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "descendente,")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: antecipaEx3
              x: dissonancias.colX+210; y: dissonancias.row(5, 1)
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "ascendente)")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: antecipaEx4
              x: dissonancias.colX; y: dissonancias.row(3, 2)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: antecipaEx4.right; anchors.leftMargin: 5; y: antecipaEx4.y+5;
              text: qsTranslate("PrefsDialogBase", "somente na cadência final")
              font.pixelSize: 9
              color: corTextoPrimario
            }
          }
          Rectangle { // Apojatura
            x: 351; y: 235
            width: 334
            height: 120
            color: corPainelDestaque

            CheckBox {
              id: apojaturaL
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Apojatura")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: apojaEx1
              x: dissonancias.colX; y: dissonancias.row(8, 1)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: apojaEx1.right; anchors.leftMargin: 5; y: apojaEx1.y+5;
              text: qsTranslate("PrefsDialogBase", "somente em tempo forte")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: apojaEx1MF
              x: dissonancias.colX+140; y: dissonancias.row(8, 1)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: apojaEx1MF.right; anchors.leftMargin: 5; y: apojaEx1MF.y+5;
              text: qsTranslate("PrefsDialogBase", "ou meio forte")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: apojaEx2
              x: dissonancias.colX; y: dissonancias.row(8, 2)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: apojaEx2.right; anchors.leftMargin: 5; y: apojaEx2.y+5;
              text: qsTranslate("PrefsDialogBase", "somente preparação ascendente")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: apojaEx3
              x: dissonancias.colX; y: dissonancias.row(8, 3)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: apojaEx3.right; anchors.leftMargin: 5; y: apojaEx3.y+5;
              text: qsTranslate("PrefsDialogBase", "somente resolução descendente")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: apojaEx4
              x: dissonancias.colX; y: dissonancias.row(8, 4)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: apojaEx4.right; anchors.leftMargin: 5; y: apojaEx4.y+5;
              text: qsTranslate("PrefsDialogBase", "somente resolução na direção contrária")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: apojaEx5
              x: dissonancias.colX; y: dissonancias.row(8, 5)
              scale: 0.8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: apojaEx5.right; anchors.leftMargin: 5; y: apojaEx5.y+5;
              text: qsTranslate("PrefsDialogBase", "preparação é obrigatória")
              font.pixelSize: 9
              color: corTextoPrimario
            }
          }
          Rectangle { // Escapada
            x: 5; y: 329
            width: 343
            height: 50
            color: corPainelDestaque

            CheckBox {
              id: escapadaL
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Escapada")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: escapaEx1
              x: 15; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "somente em tempo fraco")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: escapaEx1MF
              x: 160; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "ou meio forte")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
          }
          Rectangle { // Pedal
            x: 5; y: 382
            width: 343
            height: 50
            color: corPainelDestaque

            CheckBox {
              id: pedal
              x: 5; y: 5
              text: qsTranslate("PrefsDialogBase", "Nota pedal")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: pedalEx1
              x: 13; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "início e final em tempo forte")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: pedalEx1MF
              x: 170; y: 28
              scale: 0.8
              text: qsTranslate("PrefsDialogBase", "ou meio forte")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
          }
        }
        Rectangle { // Melodia
          id: melodias
          x: 5; y: 5
          width: painelEsquerdo.width-10
          height: painelEsquerdo.height-10
          color: corPainelInterno
          border.color: corBordaDestaque
          visible: currentView === 3

          property int colX: 25
          function row(a,b) {
            return a + 8 + 19 * b
          }

          Rectangle { // Penúltima -> última nota
            x: 5; y: 5
            width: 339
            height: 80
            color: corPainelDestaque

            CheckBox {
              id: peNota
              scale: 0.8
              x: 5; y: melodias.row(-5, 0)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: peNota.right; anchors.leftMargin: 5; y: peNota.y;
              text: qsTranslate("PrefsDialogBase", "Penúltima nota deve pertencer ao V ou vii grau (quando tonal), \nou conduzir por grau conjunto para a finalis (quando modal)")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: ambito
              scale: 0.8
              x: 5; y: melodias.row(0, 1)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: ambitoTxt
              anchors.left: ambito.right; anchors.leftMargin: 5; y: ambito.y+5;
              text: qsTranslate("PrefsDialogBase", "Âmbito melódico não deve ser maior do que")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: ambitoTxt.right; anchors.leftMargin: 3; y: ambitoTxt.y
              color: "transparent"
              TextInput {
                id: ambInp;
                font.pixelSize: 10
                color: corInput
                text: "12"
                validator: IntValidator { bottom: 2; top: 99 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: ambitoTxt.right; anchors.leftMargin: 18; y: ambitoTxt.y;
              text: qsTranslate("PrefsDialogBase", "semitons")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: priviGC
              scale: 0.8
              x: 5; y: melodias.row(0, 2)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: priviGC.right; anchors.leftMargin: 5; y: priviGC.y+5;
              text: qsTranslate("PrefsDialogBase", "Privilegiar graus conjuntos")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: priviGCEx
              scale: 0.8
              x: 153; y: priviGC.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: priviGCEx.right; anchors.leftMargin: 5; y: priviGCEx.y+5;
              text: qsTranslate("PrefsDialogBase", "e terças")
              font.pixelSize: 10
              color: corTextoPrimario
            }
          }
          Rectangle { // Intervalos
            x: 347; y: 5
            width: 338
            height: 140
            color: corPainelDestaque

            CheckBox {
              id: salt7
              scale: 0.8
              x: 5; y: melodias.row(-5, 0)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: salt7.right; anchors.leftMargin: 5; y: salt7.y+5;
              text: qsTranslate("PrefsDialogBase", "Sétimas maiores e menores")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: salt6
              scale: 0.8
              x: 5; y: melodias.row(-5, 1)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: salt6.right; anchors.leftMargin: 5; y: salt6.y+5
              text: qsTranslate("PrefsDialogBase", "Sextas maiores e menores")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: salt6Ex
              scale: 0.8
              anchors.left: salt6.right; anchors.leftMargin: 110; y: salt6.y+1
              text: qsTranslate("PrefsDialogBase", "Exceto se menor ascendente")
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            CheckBox {
              id: tritono
              scale: 0.8
              x: 5; y: melodias.row(-5, 3)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: tritono.right; anchors.leftMargin: 5; y: tritono.y+5
              text: qsTranslate("PrefsDialogBase", "Trítono")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            StyledTextLabel {
              anchors.left: tritono.right; anchors.leftMargin: 50; y: tritono.y+5
              text: qsTranslate("PrefsDialogBase", " - Exceto se:")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: tritonoPrep
              scale: 0.7
              anchors.left: tritono.right; anchors.leftMargin: 105; y: tritono.y-16
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: tritonoPrep.right; anchors.leftMargin: 5; y: tritonoPrep.y+5
              text: qsTranslate("PrefsDialogBase", "preparado por semitom")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: tritonoRes
              scale: 0.7
              anchors.left: tritono.right; anchors.leftMargin: 105; y: tritono.y+1
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: tritonoRes.right; anchors.leftMargin: 5; y: tritonoRes.y+5
              text: qsTranslate("PrefsDialogBase", "resolvido por semitom")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: tritonoDirCon
              scale: 0.7
              anchors.left: tritono.right; anchors.leftMargin: 105; y: tritono.y+18
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: tritonoDirCon.right; anchors.leftMargin: 5; y: tritonoDirCon.y+5
              text: qsTranslate("PrefsDialogBase", "preparado/resolvido na direção contrária")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: saltAum
              scale: 0.8
              x: 5; y: melodias.row(-5, 5)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: saltAum.right; anchors.leftMargin: 5; y: saltAum.y+5
              text: qsTranslate("PrefsDialogBase", "Outros intervalos aumentados e diminutos")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: saltM8
              scale: 0.8
              x: 5; y: melodias.row(-5, 6)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: saltM8.right; anchors.leftMargin: 5; y: saltM8.y+5
              text: qsTranslate("PrefsDialogBase", "Maiores do que a oitava")
              font.pixelSize: 10
              color: corTextoPrimario
            }
          }
          Rectangle { // Nota inicial e final
            x: 5; y: 88
            width: 339
            height: 57
            color: corPainelDestaque

            CheckBox {
              id: tonic
              scale: 0.8
              x: 5; y: melodias.row(-5, 0)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: tonic.right; anchors.leftMargin: 5; y: tonic.y+5;
              text: qsTranslate("PrefsDialogBase", "Nota inicial diferente de tônica/finalis,")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: terça
              scale: 0.8
              x: 204; y: tonic.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: terça.right; anchors.leftMargin: 5; y: terça.y+5;
              text: qsTranslate("PrefsDialogBase", "terça,")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: quinta
              scale: 0.8
              x: 259; y: tonic.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: quinta.right; anchors.leftMargin: 5; y: quinta.y+5;
              text: qsTranslate("PrefsDialogBase", "quinta")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: tonicF
              scale: 0.8
              x: 5; y: melodias.row(-5, 1)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: tonicF.right; anchors.leftMargin: 5; y: tonicF.y+5;
              text: qsTranslate("PrefsDialogBase", "Nota final diferente de tônica/finalis,")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: terçaF
              scale: 0.8
              x: 204; y: tonicF.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: terçaF.right; anchors.leftMargin: 5; y: terçaF.y+5;
              text: qsTranslate("PrefsDialogBase", "terça,")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: quintaF
              scale: 0.8
              x: 259; y: tonicF.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: quintaF.right; anchors.leftMargin: 5; y: quintaF.y+5;
              text: qsTranslate("PrefsDialogBase", "quinta")
              font.pixelSize: 10
              color: corTextoPrimario
            }
          }
          Rectangle { // Alterações do modo menor
            x: 5; y: 148
            width: 680
            height: 45
            color: corPainelDestaque

            CheckBox {
              id: neutA
              scale: 0.8
              x: 5; y: melodias.row(-5, 0)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: neutA.right; anchors.leftMargin: 5; y: neutA.y+5;
              text: qsTranslate("PrefsDialogBase", "Se não conduzir 6° e 7° alterados")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: neutAim
              scale: 0.8
              x: 199; y: neutA.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: neutAim.right; anchors.leftMargin: 5; y: neutAim.y+5;
              text: qsTranslate("PrefsDialogBase", "imediatamente")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: neutN
              scale: 0.8
              x: 5; y: melodias.row(-5, 1)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: neutN.right; anchors.leftMargin: 5; y: neutN.y+5;
              text: qsTranslate("PrefsDialogBase", "Se usar 6°/7° naturais sem neutralizar")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: neutNim
              scale: 0.8
              x: 204; y: neutN.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: neutNimTxt
              anchors.left: neutNim.right; anchors.leftMargin: 5; y: neutNim.y+5;
              text: qsTranslate("PrefsDialogBase", "a menos de")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: neutNimTxt.right; anchors.leftMargin: 3; y: neutNimTxt.y
              color: "transparent"
              TextInput {
                id: neutNqt;
                font.pixelSize: 10
                color: corInput
                text: "4"
                validator: IntValidator { bottom: 0; top: 99 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: neutNimTxt.right; anchors.leftMargin: 15; y: neutNimTxt.y;
              text: qsTranslate("PrefsDialogBase", "tempos da nota alterada")
              font.pixelSize: 10
              color: corTextoPrimario
            }

          }
          Rectangle { // Intervalos compostos
            x: 5; y: 196
            width: 680
            height: 198
            color: corPainelDestaque

            CheckBox {
              id: tritono2
              scale: 0.8
              x: 5; y: melodias.row(-5, 0)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: tritono2.right; anchors.leftMargin: 5; y: tritono2.y+5;
              text: qsTranslate("PrefsDialogBase", "Trítono nas duas extremidades de movimentos melódicos")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: tritono1
              scale: 0.8
              x: 5; y: melodias.row(-5, 1)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: tritono1.right; anchors.leftMargin: 5; y: tritono1.y+5
              text: qsTranslate("PrefsDialogBase", "Trítono em uma extremidade de movimentos melódicos")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: dissoC
              scale: 0.8
              x: 5; y: melodias.row(-5, 2)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: dissoC.right; anchors.leftMargin: 5; y: dissoC.y+5
              text: qsTranslate("PrefsDialogBase", "Dissonância composta")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: doisSaltC
              scale: 0.8
              x: 5; y: melodias.row(-5, 3.5)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: doisSaltC.right; anchors.leftMargin: 5; y: doisSaltC.y+5
              text: qsTranslate("PrefsDialogBase", "Dois saltos em mov. contrário")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: doisSaltCEx1
              scale: 0.7
              anchors.left: doisSaltC.right; anchors.leftMargin: 200; y: doisSaltC.y-9
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: doisSaltCEx1.right; anchors.leftMargin: 5; y: doisSaltCEx1.y+5
              text: qsTranslate("PrefsDialogBase", "Exceto se precedidos e seguidos por mov. contrário")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: doisSaltCEx2
              scale: 0.7
              anchors.left: doisSaltC.right; anchors.leftMargin: 200; y: doisSaltC.y+8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: doisSaltCEx2.right; anchors.leftMargin: 5; y: doisSaltCEx2.y+5
              text: qsTranslate("PrefsDialogBase", "Exceto se precedidos e seguidos grau conjunto")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: doisSaltM
              scale: 0.8
              x: 5; y: melodias.row(-5, 5.5)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: doisSaltM.right; anchors.leftMargin: 5; y: doisSaltM.y+5
              text: qsTranslate("PrefsDialogBase", "Dois saltos na mesma direção")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: doisSaltMEx
              scale: 0.7
              anchors.left: doisSaltM.right; anchors.leftMargin: 200; y: doisSaltM.y-9
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: doisSaltMEx.right; anchors.leftMargin: 5; y: doisSaltMEx.y+5
              text: qsTranslate("PrefsDialogBase", "Exceto se formar tríade")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: doisSaltMEx1
              scale: 0.7
              anchors.left: doisSaltM.right; anchors.leftMargin: 200; y: doisSaltM.y+8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: doisSaltMEx1.right; anchors.leftMargin: 5; y: doisSaltMEx1.y+5
              text: qsTranslate("PrefsDialogBase", "ou 5J + 4J ou 4J + 5J")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: saltM5
              scale: 0.8
              x: 5; y: melodias.row(-5, 7.5)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: saltM5.right; anchors.leftMargin: 5; y: saltM5.y
              text: qsTranslate("PrefsDialogBase", "Salto maior do que 5ªJ não compensado \ncom direcionamento contrário")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: saltM5Ex1
              scale: 0.7
              anchors.left: saltM5.right; anchors.leftMargin: 200; y: saltM5.y-9
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: saltM5Ex1.right; anchors.leftMargin: 5; y: saltM5Ex1.y+5
              text: qsTranslate("PrefsDialogBase", "por grau conjunto")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: saltM5Ex2
              scale: 0.7
              anchors.left: saltM5.right; anchors.leftMargin: 200; y: saltM5.y+8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: saltM5Ex2.right; anchors.leftMargin: 5; y: saltM5Ex2.y+5
              text: qsTranslate("PrefsDialogBase", "por salto menor do que 5ª")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: saltoTF
              scale: 0.8
              x: 5; y: melodias.row(-5, 9)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: saltoTF.right; anchors.leftMargin: 5; y: saltoTF.y+5
              text: qsTranslate("PrefsDialogBase", "Salto de tempo forte (")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: saltoTmF
              scale: 0.8
              anchors.left: saltoTF.right; anchors.leftMargin: 106; y: saltoTF.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: saltoTmF.right; anchors.leftMargin: 5; y: saltoTmF.y+5
              text: qsTranslate("PrefsDialogBase", "e de tempo meio forte) para o tempo fraco.")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: saltoTFEx
              scale: 0.7
              anchors.left: saltoTF.right; anchors.leftMargin: 330; y: saltoTF.y
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: saltoTFEx.right; anchors.leftMargin: 5; y: saltoTFEx.y+6
              text: qsTranslate("PrefsDialogBase", "Somente se ascendente")
              font.pixelSize: 9
              color: corTextoPrimario
            }
          }
          Rectangle { // Monotonia
            x: 5; y: 397
            width: 680
            height: 103
            color: corPainelDestaque

            CheckBox {
              id: varDir
              scale: 0.8
              x: 5; y: melodias.row(-5, 0)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: varDirTxt
              anchors.left: varDir.right; anchors.leftMargin: 5; y: varDir.y+5;
              text: qsTranslate("PrefsDialogBase", "Monotonia no contorno: mais do que")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: varDirTxt.right; anchors.leftMargin: 3; y: varDirTxt.y
              color: "transparent"
              TextInput {
                id: varDirQt;
                font.pixelSize: 10
                color: corInput
                text: "4"
                validator: IntValidator { bottom: 0; top: 99 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: varDirTxt.right; anchors.leftMargin: 15; y: varDirTxt.y;
              text: qsTranslate("PrefsDialogBase", "movimento(s) na mesma direção")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: repNota
              scale: 0.8
              x: 5; y: melodias.row(-5, 1)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: repNotaTxt
              anchors.left: repNota.right; anchors.leftMargin: 5; y: repNota.y+5;
              text: qsTranslate("PrefsDialogBase", "Repetição de notas: mais do que")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: repNotaTxt.right; anchors.leftMargin: 3; y: repNotaTxt.y
              color: "transparent"
              TextInput {
                id: repNotaQt;
                font.pixelSize: 10
                color: corInput
                text: "1"
                validator: IntValidator { bottom: 0; top: 99 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: repNotaTxt.right; anchors.leftMargin: 15; y: repNotaTxt.y;
              text: qsTranslate("PrefsDialogBase", "repetição(ões)")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: repeteNoutra
              scale: 0.8
              x: 275; y: melodias.row(-5, 1)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: repeteNoutra.right; anchors.leftMargin: 5; y: repeteNoutra.y+5;
              text: qsTranslate("PrefsDialogBase", "sem mudar nota em outra voz")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: repPad
              scale: 0.8
              x: 5; y: melodias.row(-5, 2)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: repPadTxt
              anchors.left: repPad.right; anchors.leftMargin: 5; y: repPad.y+5;
              text: qsTranslate("PrefsDialogBase", "Repetição de padrões: mais do que")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: repPadTxt.right; anchors.leftMargin: 3; y: repPadTxt.y
              color: "transparent"
              TextInput {
                id: repPadQt;
                font.pixelSize: 10
                color: corInput
                text: "0"
                validator: IntValidator { bottom: 0; top: 99 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: repPadTxt.right; anchors.leftMargin: 15; y: repPadTxt.y;
              text: qsTranslate("PrefsDialogBase", "repetição(ões)")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: arpMel
              scale: 0.8
              x: 5; y: melodias.row(-5, 3)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              id: arpMelTxt
              anchors.left: arpMel.right; anchors.leftMargin: 5; y: arpMel.y+5;
              text: qsTranslate("PrefsDialogBase", "Arpejo de acordes na linha melódica: mais do que")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: arpMelTxt.right; anchors.leftMargin: 3; y: arpMelTxt.y
              color: "transparent"
              TextInput {
                id: arpMelQt;
                font.pixelSize: 10
                color: corInput
                text: "0"
                validator: IntValidator { bottom: 0; top: 99 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: arpMelTxt.right; anchors.leftMargin: 15; y: arpMelTxt.y;
              text: qsTranslate("PrefsDialogBase", "arpejo(s)")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            StyledTextLabel {
              x: 7; y: melodias.row(0, 4)
              text: qsTranslate("PrefsDialogBase", "Repetição de Ponto Focal")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: melPFs
              scale: 0.8
              x: 135; y: melodias.row(-5, 4)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: melPFs.right; anchors.leftMargin: 5; y: melPFs.y+5;
              text: qsTranslate("PrefsDialogBase", "Agudo")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: melPFi
              scale: 0.8
              x: 210; y: melodias.row(-5, 4)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: melPFi.right; anchors.leftMargin: 5; y: melPFi.y+5;
              text: qsTranslate("PrefsDialogBase", "Grave")
              font.pixelSize: 10
              color: corTextoPrimario
            }
          }
        }
        Rectangle { // Outros aspectos
          id: outros
          x: 5; y: 5
          width: painelEsquerdo.width-10
          height: painelEsquerdo.height-10
          color: corPainelInterno
          border.color: corBordaDestaque
          visible: currentView === 4

          property int colX: 25
          function row(a,b) {
            return a + 8 + 19 * b
          }

          Rectangle { // primeiro intervalo
            x: 5; y: 5
            width: 680
            height: 118
            color: corPainelDestaque

            CheckBox {
              id: primInt
              scale: 0.8
              x: 5; y: outros.row(-5, 0.4)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: primInt.right; anchors.leftMargin: 5; y: primInt.y+5
              text: qsTranslate("PrefsDialogBase", "início diferente de uníssono ou 8ªJ")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: ex5Ji
              scale: 0.7
              anchors.left: primInt.right; anchors.leftMargin: 170; y: primInt.y-9
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: ex5Ji.right; anchors.leftMargin: 5; y: ex5Ji.y+5
              text: qsTranslate("PrefsDialogBase", "exceto 5ªJ, com a Tônica na voz inferior")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: ex3i
              scale: 0.7
              anchors.left: primInt.right; anchors.leftMargin: 170; y: primInt.y+8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: ex3i.right; anchors.leftMargin: 5; y: ex3i.y+5
              text: qsTranslate("PrefsDialogBase", "exceto 3ª, com a Tônica na voz inferior")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: ultInt
              scale: 0.8
              x: 5; y: outros.row(-5, 2.5)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: ultInt.right; anchors.leftMargin: 5; y: ultInt.y+5
              text: qsTranslate("PrefsDialogBase", "final diferente de uníssono ou 8ªJ")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: ex5Jf
              scale: 0.7
              anchors.left: ultInt.right; anchors.leftMargin: 170; y: ultInt.y-9
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: ex5Jf.right; anchors.leftMargin: 5; y: ex5Jf.y+5
              text: qsTranslate("PrefsDialogBase", "exceto 5ªJ, com a Tônica na voz inferior")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: ex3f
              scale: 0.7
              anchors.left: ultInt.right; anchors.leftMargin: 170; y: ultInt.y+8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: ex3f.right; anchors.leftMargin: 5; y: ex3f.y+5
              text: qsTranslate("PrefsDialogBase", "exceto 3ª, com a Tônica na voz inferior")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: ultNotas
              scale: 0.8
              x: 5; y: outros.row(-5, 4.5)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: ultNotas.right; anchors.leftMargin: 5; y: ultNotas.y
              text: qsTranslate("PrefsDialogBase", "Se não alcançar último intervalo\npor grau conj. e mov. contrário")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: quartaJi
              scale: 0.7
              anchors.left: ultNotas.right; anchors.leftMargin: 170; y: ultNotas.y-9
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: quartaJi.right; anchors.leftMargin: 5; y: quartaJi.y+5
              text: qsTranslate("PrefsDialogBase", "exceto 4ªJ ascendente ou 5ªJ descendente, na voz inferior")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: quartaJs
              scale: 0.7
              anchors.left: ultNotas.right; anchors.leftMargin: 170; y: ultNotas.y+8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: quartaJs.right; anchors.leftMargin: 5; y: quartaJs.y+5
              text: qsTranslate("PrefsDialogBase", "exceto 4ªJ ascendente ou 5ªJ descendente, na voz superior")
              font.pixelSize: 9
              color: corTextoPrimario
            }
          }
          Rectangle { // cadência final
            x: 5; y: 126
            width: 680
            height: 41
            color: corPainelDestaque

            CheckBox {
              id: sensCad
              scale: 0.8
              x: 5; y: outros.row(-5, 0.4)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: sensCad.right; anchors.leftMargin: 5; y: sensCad.y+5
              text: qsTranslate("PrefsDialogBase", "Se não usar a sensível na cadência final")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: sensCadR
              scale: 0.7
              anchors.left: sensCad.right; anchors.leftMargin: 190; y: sensCad.y-9
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: sensCadR.right; anchors.leftMargin: 5; y: sensCadR.y+5
              text: qsTranslate("PrefsDialogBase", "ou se a sensível não resolver")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: sensCadEx
              scale: 0.7
              anchors.left: sensCad.right; anchors.leftMargin: 190; y: sensCad.y+8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: sensCadEx.right; anchors.leftMargin: 5; y: sensCadEx.y+5
              text: qsTranslate("PrefsDialogBase", "Exceto no modo Frígio")
              font.pixelSize: 9
              color: corTextoPrimario
            }

          }
          Rectangle { // distância
            x: 5; y: 170
            width: 680
            height: 44
            color: corPainelDestaque

            CheckBox {
              id: distancia
              scale: 0.8
              x: 5; y: outros.row(-5, 0)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: distancia.right; anchors.leftMargin: 5; y: distancia.y+5
              text: qsTranslate("PrefsDialogBase", "Distância entre as vozes")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            StyledTextLabel {
              id: distTxt
              x: 7; y: outros.row(-5, 1.2)
              text: qsTranslate("PrefsDialogBase", "- se uma sequência maior do que")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: distTxt.right; anchors.leftMargin: 5; y: distTxt.y
              color: "transparent"
              TextInput {
                id: distQt;
                font.pixelSize: 10
                color: corInput
                text: "4"
                validator: IntValidator { bottom: 0; top: 99 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: distTxt.right; anchors.leftMargin: 15; y: distTxt.y;
              text: qsTranslate("PrefsDialogBase", "intervalo(s) maior(es) do que a")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            Rectangle {
              width: 5
              height: 11
              anchors.left: distTxt.right; anchors.leftMargin: 150; y: distTxt.y
              color: "transparent"
              TextInput {
                id: distInt;
                font.pixelSize: 10
                color: corInput
                text: "10"
                validator: IntValidator { bottom: 0; top: 99 }
                inputMethodHints: Qt.ImhDigitsOnly
              }
            }
            StyledTextLabel {
              anchors.left: distTxt.right; anchors.leftMargin: 154; y: distTxt.y;
              text: qsTranslate("PrefsDialogBase", "ª")
              font.pixelSize: 10
              color: corTextoPrimario
            }
          }
          Rectangle { // consonâncias imperfeitas
            x: 5; y: 217
            width: 680
            height: 30
            color: corPainelDestaque

            CheckBox {
              id: consImp
              scale: 0.8
              x: 5; y: outros.row(-5, 0)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: consImp.right; anchors.leftMargin: 5; y: consImp.y+5
              text: qsTranslate("PrefsDialogBase", "Prioridade para Consonâncias Imperfeitas")
              font.pixelSize: 10
              color: corTextoPrimario
            }
          }
          Rectangle { // coerência harmônica
            x: 5; y: 250
            width: 680
            height: 80
            color: corPainelDestaque

            StyledTextLabel {
              x: 7; y: outros.row(-5, 0)
              text: qsTranslate("PrefsDialogBase", "Coerência harmônica")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: cHarmoniaF
              scale: 0.8
              x: 5; y: outros.row(-5, 1)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cHarmoniaF.right; anchors.leftMargin: 5; y: cHarmoniaF.y+5
              text: qsTranslate("PrefsDialogBase", "ausência da fundamental")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: cHarmonia
              scale: 0.8
              x: 5; y: outros.row(-5, 2.5)
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cHarmonia.right; anchors.leftMargin: 5; y: cHarmonia.y+5
              text: qsTranslate("PrefsDialogBase", "notas que não pertencem ao acorde")
              font.pixelSize: 10
              color: corTextoPrimario
            }
            CheckBox {
              id: cHarmoniaEx
              scale: 0.7
              anchors.left: cHarmonia.right; anchors.leftMargin: 175; y: cHarmonia.y-9
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cHarmoniaEx.right; anchors.leftMargin: 5; y: cHarmoniaEx.y+5
              text: qsTranslate("PrefsDialogBase", "Exceto em tempo fraco")
              font.pixelSize: 9
              color: corTextoPrimario
            }
            CheckBox {
              id: cHarmoniaEx2
              scale: 0.7
              anchors.left: cHarmonia.right; anchors.leftMargin: 175; y: cHarmonia.y+8
              checked: true
              onClicked: {
                checked = !checked
              }
            }
            StyledTextLabel {
              anchors.left: cHarmoniaEx2.right; anchors.leftMargin: 5; y: cHarmoniaEx2.y+5
              text: qsTranslate("PrefsDialogBase", "e meio forte")
              font.pixelSize: 9
              color: corTextoPrimario
            }
          }
        }
      }

      // Painel Configurações -----------------------------
      Rectangle {
        id: painelDireita
        x: 705; y: 2
        width: 190
        height: 550
        border.color: corBorda
        border.width: 1
        color: corPainel

        StyledTextLabel {
          width: parent.width
          x: 0; y: 3
          text: qsTranslate("PrefsDialogBase", "Configurações")
          font.pixelSize: 18
          font.bold: true
          color: corTextoDestaque
        }
        Rectangle { // tom, modo, voz cf
          id: tonalidade
          x: 5; y: 25
          width: 180
          height: 97
          color: corPainelDestaque

          StyledTextLabel {
            x: 5; y: 6
            text: qsTranslate("PrefsDialogBase", "Tônica/finalis")
            color: corTextoPrimario
          }
          StyledDropdown { //Tônica/Finalis
            id: btTonica
            x: 80; y: 3
            width: 50
            height: 20
            model: [
              { 'text': "Dó",  'value': 1 },
              { 'text': "Ré", 'value': 2 },
              { 'text': "Mi",  'value': 3 },
              { 'text': "Fá", 'value': 4 },
              { 'text': "Sol",  'value': 5 },
              { 'text': "Lá",  'value': 6 },
              { 'text': "Si", 'value': 7 }
            ]
            currentIndex: 1
            onActivated: function(index, value) {
              currentIndex = index
            }
          }
          StyledTextLabel {
            x: 5; y: 29
            text: "Acidente"
            color: corTextoPrimario
          }
          StyledDropdown {
            id: btAcid
            x: 63; y: 26
            width: 50
            height: 20
            model: [ {'text': " ",  'value': 1  },
            { 'text': "♯", 'value': 2  },
            { 'text': "♭",  'value': 3  }
            ]
            currentIndex: 0
            onActivated: function(index, value) {
              currentIndex = index
            }
          }
          StyledTextLabel {
            text: "Modo"
            x: 5; y: 52
            color: corTextoPrimario
          }
          StyledDropdown { //Tônica/Finalis
            id: btModo
            x: 47; y: 50
            width: 100
            height: 20
            model: [
              { 'text': "Maior",  'value': 1 },
              { 'text': "Menor", 'value': 2 },
              { 'text': "Jônico",  'value': 3 },
              { 'text': "Dórico", 'value': 4 },
              { 'text': "Frígio",  'value': 5 },
              { 'text': "Lídio",  'value': 6 },
              { 'text': "Mixolídio", 'value': 7 },
              { 'text': "Eólio",  'value': 8 },
              { 'text': "Lócrio", 'value': 9 }
            ]
            currentIndex: 0
            onActivated: function(index, value) {
              currentIndex = index
            }
          }
          StyledTextLabel {
            text: "Voz do CF"
            x: 5; y: 77
            color: corTextoDestaque
          }
          StyledDropdown { //Voz do CF
            id: vozCantusFirmus
            x: 64; y: 74
            width: 50
            height: 20
            model: [
              { 'text': "1",  'value': 1 },
              { 'text': "2", 'value': 2 },
              { 'text': "3",  'value': 3 },
              { 'text': "4", 'value': 4 },
              { 'text': "5",  'value': 5 },
              { 'text': "6",  'value': 6 },
              { 'text': "7", 'value': 7 },
              { 'text': "8",  'value': 8 }
            ]
            currentIndex: 0
            onActivated: function(index, value) {
              currentIndex = index
            }
          }
        }
        Rectangle { // tipo de contraponto
          x: 5; y: 127
          width: 180
          height: 137
          color: corPainelDestaque

          StyledTextLabel {
            width: parent.width
            x: 0; y: 2
            text: "Tipo de contraponto:"
            color: corTextoDestaque
          }
          Button { // Cantus Firmus
            id: botao27
            x: 5; y: 19
            width: 170
            height: 20
            background: Rectangle {
              color: tipoBotoes === 0 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "Cantus Firmus")
            onClicked: {
              tipoBotoes = 0
              salvarCfg();
              if (melodia) {
                intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                melodias.visible = false; dissonancias.visible = false; conduz.visible = false;
              }
              else  {
                conduz.visible = false; dissonancias.visible = false; outros.visible = false;
                intervalosClasse.visible = false; melodias.visible = true;
                priEsp = false; secEsp = false; terEsp = false; quaEsp = false;
                quiEsp = false; melodia = true; livreCP = false; }
                atualizarTitulo();
                carregarCfg();
            }
          }
          Button { // botão primeira espécie
            id: botao1
            x: 5; y: 42
            width: 83
            height: 20
            background: Rectangle {
              color: tipoBotoes === 1 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "1ª esp.")
            onClicked: {
              tipoBotoes = 1
              salvarCfg();
              if (priEsp) {
                intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                melodias.visible = false; dissonancias.visible = false; conduz.visible = false;
              }
              else  {
                priEsp = true; secEsp = false; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                atualizarTitulo();
                carregarCfg();
            }
          }
          Button { // botão segunda espécie
            id: botao2
            x: 92; y: 42
            width: 83
            height: 20
            background: Rectangle {
              color: tipoBotoes === 2 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "2ª esp.")
            onClicked: {
              tipoBotoes = 2
              salvarCfg();
              if (secEsp) {
                intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                melodias.visible = false; dissonancias.visible = false; conduz.visible = false;
              }
              else  {
                priEsp = false; secEsp = true; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                atualizarTitulo();
                carregarCfg();
            }
          }
          Button { // botão terceira espécie
            id: botao23
            x: 5; y: 65
            width: 83
            height: 20
            background: Rectangle {
              color: tipoBotoes === 3 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "3ª esp.")
            onClicked: {
              tipoBotoes = 3
              salvarCfg();
              if (terEsp) {
                intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                melodias.visible = false; dissonancias.visible = false; conduz.visible = false;
              } else  {
                priEsp = false; secEsp = false; terEsp = true; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                atualizarTitulo();
                carregarCfg();
            }
          }
          Button { // botão quarta espécie
            id: botao24
            x: 92; y: 65
            width: 83
            height: 20
            background: Rectangle {
              color: tipoBotoes === 4 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "4ª esp.")
            onClicked: {
              tipoBotoes = 4
              salvarCfg();
              if (quaEsp) {
                intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                melodias.visible = false; dissonancias.visible = false; conduz.visible = false;
              } else  {
                priEsp = false; secEsp = false; terEsp = false; quaEsp = true; quiEsp = false; melodia = false; livreCP = false; }
                atualizarTitulo();
                carregarCfg();
            }
          }
          Button { // botão quinta espécie
            id: botao25
            x: 5; y: 88
            width: 170
            height: 20
            background: Rectangle {
              color: tipoBotoes === 5 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "5ª espécie")
            onClicked: {
              tipoBotoes = 5
              salvarCfg();
              if (quiEsp) {
                intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                melodias.visible = false; dissonancias.visible = false; conduz.visible = false;
              } else  {
                priEsp = false; secEsp = false; terEsp = false; quaEsp = false; quiEsp = true; melodia = false; livreCP = false; }
                atualizarTitulo();
                carregarCfg();
            }
          }
          Button { // Contraponto livre
            id: livre
            x: 5; y: 111
            width: 170
            height: 20
            background: Rectangle {
              color: tipoBotoes === 6 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "Contraponto Livre")
            onClicked: {
              tipoBotoes = 6
              salvarCfg();
              if (livreCP) { intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                melodias.visible = false; dissonancias.visible = false; conduz.visible = false;
              } else  {
                priEsp = false; secEsp = false; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = true; }
                atualizarTitulo();
                carregarCfg();
            }
          }
        }
        Rectangle { // Aspectos
          x: 5; y: 269
          width: 180
          height: 114
          color: corPainelDestaque

          StyledTextLabel {
            width: parent.width
            x: 0; y: 3;
            text: "Aspectos:"
            color: corTextoDestaque
          }
          Button { // Condução de Vozes
            id: botao26
            x: 5; y: 20
            width: 170
            height: 20
            background: Rectangle {
              color: currentView === 1 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "Condução de Vozes")
            onClicked: {
              currentView === 1 ? currentView = 0 : currentView = 1
            }
          }
          Button { // Dissonâncias
            id: botao29
            x: 5; y: 43
            width: 170
            height: 20
            background: Rectangle {
              color: currentView === 2 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "Dissonâncias")
            onClicked: {
              currentView === 2 ? currentView = 0 : currentView = 2
            }
          }
          Button { // Melodia
            id: botao28
            x: 5; y: 66
            width: 170
            height: 20
            background: Rectangle {
              color: currentView === 3 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "Melodia")
            onClicked: {
              currentView === 3 ? currentView = 0 : currentView = 3
            }
          }
          Button { // Outros aspectos
            id: botao26o
            x: 5; y: 89
            width: 170
            height: 20
            background: Rectangle {
              color: currentView === 4 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "Outros Aspectos")
            onClicked: {
              currentView === 4 ? currentView = 0 : currentView = 4
            }
          }
        }
        Rectangle { // Pre-configurações
          x: 5; y: 388;
          width: 180
          height: 70
          color: corPainelDestaque

          StyledTextLabel {
            width: parent.width
            x: 0; y: 3
            color: corTextoDestaque
            text: qsTranslate("PrefsDialogBase","Pré-configurações:")
          }
          Rectangle { // mostra nome do preset
            x: 5; y: 22;
            width: 170
            height: 20
            border.color: corBordaDestaque
            border.width: 1
            color: corInputFundo

            StyledTextLabel {
              id: nomePre
              width: parent.width
              x: 0; y: 3
              color: corTextoPrimario
              text: qsTranslate("PrefsDialogBase","Nome da configuração")
            }
          }
          Button { // Salvar
            id: salvarCnfiguração
            x: 5; y: 45
            width: 83
            height: 20
            background: Rectangle {
              color: corBotaoAcaoPrimario
            }
            text: qsTranslate("PrefsDialogBase", "Salvar")
            onClicked: {
              salvarCfg(); saveFileDialog.open();
            }
          }
          Button { // Carregar
            id: carregarCnfiguração
            x: 92; y: 45
            width: 83
            height: 20
            background: Rectangle {
              color: corBotaoAcaoSecundario
            }
            text: qsTranslate("PrefsDialogBase", "Carregar")
            onClicked: {
              openFileDialog.open();
            }
          }
        }
        Rectangle { // Relatório
          x: 5; y: 504;
          width: 180
          height: 40
          color: corPainelDestaque

          StyledTextLabel {
            width: parent.width
            y: 2
            text: qsTranslate("PrefsDialogBase", "Relatório")
            color: corTextoDestaque
          }
          Button {
            id: geraRel
            x: 5; y: 16
            width: 170
            height: 20
            background: Rectangle {
              color: corBotaoAcaoPrimario
            }
            text: qsTranslate("PrefsDialogBase", "Gerar Relatório")
            onClicked: { gerarRelatorio() }
          }
        }
      }

      // Painel inferior
      Rectangle {
        id: painelInferior
        x: 5; y: 555
        width: 890
        height: 40
        border.color: corBorda
        border.width: 1
        color: corPainel

        StyledTextLabel {
          x: 5; y: 13
          text: qsTranslate("PrefsDialogBase", "Criado por")
          font.pixelSize: 7
          font.bold: true
          color: corTextoSecundario
        }
        StyledTextLabel {
          x: 5; y: 25
          text: "Rogério Tavares Constante"
          font.pixelSize: 10
          font.bold: true
          color: corTextoPrimario
        }
        Button {
          id: btVerifica
          width: 100
          x: painelInferior.width/2-90; y: painelInferior.height/2-12
          background: Rectangle {
            radius: 2
            color: corBotaoAcaoPrimario
          }
          text: qsTranslate("PrefsDialogBase", "Verificar")
          onClicked: { msgResult.close(); verificar(); }
          padding: 5
        }
        Button {
          id: btFechar
          width: 100
          x: painelInferior.width/2+15; y: painelInferior.height/2-12
          background: Rectangle {
            radius: 2
            color: corBotaoAcaoSecundario
          }
          text: qsTranslate("PrefsDialogBase", "Fechar")
          onClicked: {
            (typeof(quit) === 'undefined' ? Qt.quit : quit()); window.close(); msgResult.close(); msgRelatorio.close();
          }
          padding: 5
        }
        StyledTextLabel {
          x: painelInferior.width-42; y: painelInferior.height/2-5
          text: "(c)2026"
          font.pixelSize: 10
          font.bold: true
          color: corTextoSecundario
        }
      }

      MessageDialog { // error
        id: errorDialog
        title: "Error"
        text: ""
        onAccepted: {
          errorDialog.close()
        }
        visible: false
      }

      Popup {
        id: configInt
        //title: qsTranslate("PrefsDialogBase", "Configuração de Intervalos")
        width: 420
        height: 200
        modal: true
        focus: true

        property int painelAtual: 0
        function row(b) {
          return 25 + 16 * b
        }

        Rectangle { // configurar dissonâncias
          anchors.fill: parent
          color: corFundoPrincipal
          radius: 3

          StyledTextLabel {
            x: 5; y: 4
            text: qsTranslate("PrefsDialogBase", "Configuração de Intervalos:")
            font.pixelSize: 14
            font.bold: true
            color: corTextoAlerta
          }
          Button { // Tonal
            id: btTonal
            x: 230; y: 3
            width: 100
            height: 20
            background: Rectangle {
              radius: 3
              color: configInt.painelAtual === 0 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "Tonal/Modal")
            onClicked: {
              configInt.painelAtual = 0
            }
          }
          Button { // Atonal
            id: btAtonal
            x: 333; y: 3
            width: 70
            height: 20
            background: Rectangle {
              radius: 3
              color: configInt.painelAtual === 1 ? corBotaoSelecionado : corBotaoNormal
            }
            text: qsTranslate("PrefsDialogBase", "Atonal")
            onClicked: {
              configInt.painelAtual = 1
            }
          }

          Rectangle { // Tonal
            id: cfgTonal
            y: 25
            width: parent.width
            height: 160
            color: corPainelDestaque
            visible: configInt.painelAtual === 0

            StyledTextLabel {
              x: 180; y: 5
              text: qsTranslate("PrefsDialogBase", "Consonância")
              font.pixelSize: 10
              font.bold: true
              color: corTextoAlerta
            }
            StyledTextLabel {
              x: 250; y: 2
              text: qsTranslate("PrefsDialogBase", "Dissonância\ncom o baixo")
              font.pixelSize: 10
              font.bold: true
              color: corTextoAlerta
            }
            StyledTextLabel {
              x: 320; y: 5
              text: qsTranslate("PrefsDialogBase", "Dissonância")
              font.pixelSize: 10
              font.bold: true
              color: corTextoAlerta
            }
            StyledTextLabel { // U e 6ª
              x: 5; y: configInt.row(0)+3
              text: qsTranslate("PrefsDialogBase", "Uníssono e 8ª justa")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckConsU
              x: 200; y: configInt.row(0)
              scale: 0.6
              checked: true
              onClicked: {
                ckConsU.checked = true
                ckDissBaixU.checked = false
                ckDissU.checked = false
              }
            }
            CheckBox {
              id: ckDissBaixU
              x: 270; y: configInt.row(0)
              scale: 0.6
              checked: false
              onClicked: {
                ckConsU.checked = false
                ckDissBaixU.checked = true
                ckDissU.checked = false
              }
            }
            CheckBox {
              id: ckDissU
              x: 340; y: configInt.row(0)
              scale: 0.6
              checked: false
              onClicked: {
                ckConsU.checked = false
                ckDissBaixU.checked = false
                ckDissU.checked = true
              }
            }
            StyledTextLabel { // 2ª e 7ª
              x: 5; y: configInt.row(1)+2
              text: qsTranslate("PrefsDialogBase", "2ª e 7ª (maiores e menores)")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons2a
              x: 200; y: configInt.row(1)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons2a.checked = true
                ckDissBaix2a.checked = false
                ckDiss2a.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix2a
              x: 270; y: configInt.row(1)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons2a.checked = false
                ckDissBaix2a.checked = true
                ckDiss2a.checked = false
              }
            }
            CheckBox {
              id: ckDiss2a
              x: 340; y: configInt.row(1)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons2a.checked = false
                ckDissBaix2a.checked = false
                ckDiss2a.checked = true
              }
            }
            StyledTextLabel { // 3ª e 6ª
              x: 5; y: configInt.row(2)+3
              text: qsTranslate("PrefsDialogBase", "3ª e 6ª (maiores e menores)")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons3a
              x: 200; y: configInt.row(2)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons3a.checked = true
                ckDissBaix3a.checked = false
                ckDiss3a.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix3a
              x: 270; y: configInt.row(2)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons3a.checked = false
                ckDissBaix3a.checked = true
                ckDiss3a.checked = false
              }
            }
            CheckBox {
              id: ckDiss3a
              x: 340; y: configInt.row(2)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons3a.checked = false
                ckDissBaix3a.checked = false
                ckDiss3a.checked = true
              }
            }
            StyledTextLabel { // 4ªJ
              x: 5; y: configInt.row(3)+3
              text: qsTranslate("PrefsDialogBase", "4ª justa")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons4a
              x: 200; y: configInt.row(3)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons4a.checked = true
                ckDissBaix4a.checked = false
                ckDiss4a.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix4a
              x: 270; y: configInt.row(3)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons4a.checked = false
                ckDissBaix4a.checked = true
                ckDiss4a.checked = false
              }
            }
            CheckBox {
              id: ckDiss4a
              x: 340; y: configInt.row(3)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons4a.checked = false
                ckDissBaix4a.checked = false
                ckDiss4a.checked = true
              }
            }
            StyledTextLabel { // trítono
              x: 5; y: configInt.row(4)+3
              text: qsTranslate("PrefsDialogBase", "Trítono")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckConsTT
              x: 200; y: configInt.row(4)
              scale: 0.6
              checked: false
              onClicked: {
                ckConsTT.checked = true
                ckDissBaixTT.checked = false
                ckDissTT.checked = false
              }
            }
            CheckBox {
              id: ckDissBaixTT
              x: 270; y: configInt.row(4)
              scale: 0.6
              checked: true
              onClicked: {
                ckConsTT.checked = false
                ckDissBaixTT.checked = true
                ckDissTT.checked = false
              }
            }
            CheckBox {
              id: ckDissTT
              x: 340; y: configInt.row(4)
              scale: 0.6
              checked: false
              onClicked: {
                ckConsTT.checked = false
                ckDissBaixTT.checked = false
                ckDissTT.checked = true
              }
            }
            StyledTextLabel { // 5J
              x: 5; y: configInt.row(5)+3
              text: qsTranslate("PrefsDialogBase", "5ª justa")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons5a
              x: 200; y: configInt.row(5)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons5a.checked = true
                ckDissBaix5a.checked = false
                ckDiss5a.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix5a
              x: 270; y: configInt.row(5)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons5a.checked = false
                ckDissBaix5a.checked = true
                ckDiss5a.checked = false
              }
            }
            CheckBox {
              id: ckDiss5a
              x: 340; y: configInt.row(5)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons5a.checked = false
                ckDissBaix5a.checked = false
                ckDiss5a.checked = true
              }
            }
            StyledTextLabel { // outros
              x: 5; y: configInt.row(6)+3
              text: qsTranslate("PrefsDialogBase", "Outros (aumentados e diminutos)")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckConsOu
              x: 200; y: configInt.row(6)
              scale: 0.6
              checked: false
              onClicked: {
                ckConsOu.checked = true
                ckDissBaixOu.checked = false
                ckDissOu.checked = false
              }
            }
            CheckBox {
              id: ckDissBaixOu
              x: 270; y: configInt.row(6)
              scale: 0.6
              checked: false
              onClicked: {
                ckConsOu.checked = false
                ckDissBaixOu.checked = true
                ckDissOu.checked = false
              }
            }
            CheckBox {
              id: ckDissOu
              x: 340; y: configInt.row(6)
              scale: 0.6
              checked: true
              onClicked: {
                ckConsOu.checked = false
                ckDissBaixOu.checked = false
                ckDissOu.checked = true
              }
            }
          }
          Rectangle { // Atonal
            id: cfgAtonal
            y: 25
            width: parent.width
            height: 160
            color: corPainelDestaque
            visible: configInt.painelAtual === 1

            StyledTextLabel {
              x: 180; y: 5
              text: qsTranslate("PrefsDialogBase", "Consonância")
              font.pixelSize: 10
              font.bold: true
              color: corTextoAlerta
            }
            StyledTextLabel {
              x: 250; y: 2
              text: qsTranslate("PrefsDialogBase", "Dissonância\ncom o baixo")
              font.pixelSize: 10
              font.bold: true
              color: corTextoAlerta
            }
            StyledTextLabel {
              x: 320; y: 5
              text: qsTranslate("PrefsDialogBase", "Dissonância")
              font.pixelSize: 10
              font.bold: true
              color: corTextoAlerta
            }
            StyledTextLabel { // Classe 0
              x: 5; y: configInt.row(0)+3
              text: qsTranslate("PrefsDialogBase", "Classe 0: Uníssono/8ª")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons0
              x: 200; y: configInt.row(0)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons0.checked = true
                ckDissBaix0.checked = false
                ckDiss0.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix0
              x: 270; y: configInt.row(0)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons0.checked = false
                ckDissBaix0.checked = true
                ckDiss0.checked = false
              }
            }
            CheckBox {
              id: ckDiss0
              x: 340; y: configInt.row(0)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons0.checked = false
                ckDissBaix0.checked = false
                ckDiss0.checked = true
              }
            }
            StyledTextLabel { // Classe 1
              x: 5; y: configInt.row(1)+2
              text: qsTranslate("PrefsDialogBase", "Classe 1: 2ª menor/7ª maior")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons1
              x: 200; y: configInt.row(1)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons1.checked = true
                ckDissBaix1.checked = false
                ckDiss1.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix1
              x: 270; y: configInt.row(1)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons1.checked = false
                ckDissBaix1.checked = true
                ckDiss1.checked = false
              }
            }
            CheckBox {
              id: ckDiss1
              x: 340; y: configInt.row(1)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons1.checked = false
                ckDissBaix1.checked = false
                ckDiss1.checked = true
              }
            }
            StyledTextLabel { // Classe 2
              x: 5; y: configInt.row(2)+3
              text: qsTranslate("PrefsDialogBase", "Classe 2: 2ª maior/7ª menor")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons2
              x: 200; y: configInt.row(2)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons2.checked = true
                ckDissBaix2.checked = false
                ckDiss2.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix2
              x: 270; y: configInt.row(2)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons2.checked = false
                ckDissBaix2.checked = true
                ckDiss2.checked = false
              }
            }
            CheckBox {
              id: ckDiss2
              x: 340; y: configInt.row(2)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons2.checked = false
                ckDissBaix2.checked = false
                ckDiss2.checked = true
              }
            }
            StyledTextLabel { // Classe 3
              x: 5; y: configInt.row(3)+3
              text: qsTranslate("PrefsDialogBase", "Classe 3: 3ª menor/6ª maior")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons3
              x: 200; y: configInt.row(3)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons3.checked = true
                ckDissBaix3.checked = false
                ckDiss3.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix3
              x: 270; y: configInt.row(3)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons3.checked = false
                ckDissBaix3.checked = true
                ckDiss3.checked = false
              }
            }
            CheckBox {
              id: ckDiss3
              x: 340; y: configInt.row(3)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons3.checked = false
                ckDissBaix3.checked = false
                ckDiss3.checked = true
              }
            }
            StyledTextLabel { // Classe 4
              x: 5; y: configInt.row(4)+3
              text: qsTranslate("PrefsDialogBase", "Classe 4: 3ª maior/6ª menor")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons4
              x: 200; y: configInt.row(4)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons4.checked = true
                ckDissBaix4.checked = false
                ckDiss4.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix4
              x: 270; y: configInt.row(4)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons4.checked = false
                ckDissBaix4.checked = true
                ckDiss4.checked = false
              }
            }
            CheckBox {
              id: ckDiss4
              x: 340; y: configInt.row(4)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons4.checked = false
                ckDissBaix4.checked = false
                ckDiss4.checked = true
              }
            }
            StyledTextLabel { // Classe 5
              x: 5; y: configInt.row(5)+3
              text: qsTranslate("PrefsDialogBase", "Classe 5: 4ª justa/5ª justa")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons5
              x: 200; y: configInt.row(5)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons5.checked = true
                ckDissBaix5.checked = false
                ckDiss5.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix5
              x: 270; y: configInt.row(5)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons5.checked = false
                ckDissBaix5.checked = true
                ckDiss5.checked = false
              }
            }
            CheckBox {
              id: ckDiss5
              x: 340; y: configInt.row(5)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons5.checked = false
                ckDissBaix5.checked = false
                ckDiss5.checked = true
              }
            }
            StyledTextLabel { // Classe 6
              x: 5; y: configInt.row(6)+3
              text: qsTranslate("PrefsDialogBase", "Classe 6: 4ª aumentada/5ª diminuta")
              font.pixelSize: 12
              color: corTextoPrimario
            }
            CheckBox {
              id: ckCons6
              x: 200; y: configInt.row(6)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons6.checked = true
                ckDissBaix6.checked = false
                ckDiss6.checked = false
              }
            }
            CheckBox {
              id: ckDissBaix6
              x: 270; y: configInt.row(6)
              scale: 0.6
              checked: true
              onClicked: {
                ckCons6.checked = false
                ckDissBaix6.checked = true
                ckDiss6.checked = false
              }
            }
            CheckBox {
              id: ckDiss6
              x: 340; y: configInt.row(6)
              scale: 0.6
              checked: false
              onClicked: {
                ckCons6.checked = false
                ckDissBaix6.checked = false
                ckDiss6.checked = true
              }
            }
          }
          Button {
            width: parent.width
            y: parent.height - 20
            text: "OK"
            background: Rectangle {
              radius: 2
              color: corBotaoAcaoPrimario
            }
            onClicked: configInt.close()
          }
        }
      }


//------------------------------------------------------------------/*--------------
 // janela com as mensagens de resultado
	// ApplicationWindow {
 //      id: msgResult
	//     visible: false;
	//     title: "Resultado"
	//     width: 550; height: 70
	//     color: "#343530"
 //        flags: Qt.WindowStaysOnTopHint
 //
 //        // Tooltip customizado
 //        Rectangle {
 //          id: tooltip
 //          visible: false
 //          width: tooltipText.width + 10
 //          height: tooltipText.height + 6
 //          color: "#2c3e50"
 //          border.color: "#3498db"
 //          border.width: 1
 //          radius: 3
 //          z: 1000  // Garante que fique acima de outros elementos
 //
 //          Text {
 //            id: tooltipText
 //            anchors.centerIn: parent
 //            color: "#ecf0f1"
 //            font.pixelSize: 12
 //          }
 //        }
 //
	//     Rectangle {
 //          id: btResult
 //          property alias text: lresult.text
 //          signal clicked
 //          visible: true
 //          width: 100; height: 25
 //          x: 140
 //          border { width: 1; color: "#555555" }
 //          smooth: true
 //          radius: 3
 //          gradient: Gradient {
 //              GradientStop { position: 0.0
 //                  color: {
 //                        if (mArea6.pressed)
 //                            return "#888d96"
 //                           else
 //                           return "#a0a8af"
 //                     }
 //              }
 //              GradientStop { position: 1.0; color: "#035b25" }
 //            }
 //
 //         Text {
 //           id: lresult
 //           anchors.centerIn: parent
 //           text: "Fechar"
 //           color: "#aaf0e1"
 //         }
 //
 //         MouseArea {
 //          id: mArea6
 //          anchors.fill: parent
 //          hoverEnabled: true
 //          onEntered: showTooltip("Fecha a janela de resultados", mouseX, mouseY)
 //          onExited: tooltip.visible = false
 //          onClicked: { window.raise(); msgResult.close(); apagaCor(); }
 //         } // mouseArea
 //       } // Rectangle btResult
 //
 //      Rectangle {
 //          id: btAtualiza
 //          property alias text: latual.text
 //          signal clicked
 //          visible: true
 //          width: 100; height: 25
 //          x: 300
 //          border { width: 1; color: "#555555" }
 //          smooth: true
 //          radius: 3
 //          gradient: Gradient {
 //              GradientStop { position: 0.0
 //                  color: {
 //                        if (mArea61.pressed)
 //                            return "#888d96"
 //                           else
 //                           return "#a0a8af"
 //                     }
 //              }
 //              GradientStop { position: 1.0; color: "#035b25" }
 //            }
 //
 //         Text {
 //           id: latual
 //           anchors.centerIn: parent
 //           text: "Atualizar"
 //           color: "#aaf0e1"
 //         }
 //
 //         MouseArea {
 //          id: mArea61
 //          anchors.fill: parent
 //          hoverEnabled: true
 //          onEntered: showTooltip("Atualiza a verificação da partitura", mouseX, mouseY)
 //          onExited: tooltip.visible = false
 //          onClicked: { msgResult.close(); apagaCor(); verificar() }
 //         } // mouseArea
 //       } // Rectangle btAtualiza
 //
 //       Rectangle {
 //            id: btAvança
 //            property alias text: avanText.text
 //            signal clicked
 //            visible: true
 //            width: 50; height: 20
 //            x: 500
 //            border { width: 1; color: "#555444" }
 //            smooth: true
 //            radius: 3
 //            gradient: Gradient {
 //                GradientStop { position: 0.0
 //                    color: {
 //                          if (mAreaAvan.pressed)
 //                              return "#888d96"
 //                             else
 //                             return "#a0a7ae"
 //                       }
 //                }
 //                GradientStop { position: 1.0; color: "#035b25" }
 //              }
 //
 //           Text {
 //             id: avanText
 //             anchors.centerIn: parent
 //             text: ">>"
 //             color: "#aaf0e1"
 //           }
 //
 //           MouseArea {
 //            id: mAreaAvan
 //            anchors.fill: parent
 //            hoverEnabled: true
 //            onEntered: showTooltip("Próximo resultado", mouseX, mouseY)
 //            onExited: tooltip.visible = false
 //            onClicked: { apresentaResultado(1); return }
 //           } // mouseArea
 //         } // Rectangle btResult
 //
 //         Rectangle {
 //              id: btVolta
 //              property alias text: voltaText.text
 //              signal clicked
 //              visible: true
 //              width: 50; height: 20
 //              x: 0
 //              border { width: 1; color: "#555444" }
 //              smooth: true
 //              radius: 3
 //              gradient: Gradient {
 //                  GradientStop { position: 0.0
 //                      color: {
 //                            if (mAreaVolta.pressed)
 //                                return "#888d96"
 //                               else
 //                               return "#a0a7ae"
 //                         }
 //                  }
 //                  GradientStop { position: 1.0; color: "#035b25" }
 //                }
 //
 //             Text {
 //               id: voltaText
 //               anchors.centerIn: parent
 //               text: "<<"
 //               color: "#aaf0e1"
 //             }
 //
 //             MouseArea {
 //              id: mAreaVolta
 //              anchors.fill: parent
 //              hoverEnabled: true
 //              onEntered: showTooltip("Resultado anterior", mouseX, mouseY)
 //              onExited: tooltip.visible = false
 //              onClicked: { apresentaResultado(-1); return }
 //             } // mouseArea
 //           } // Rectangle btVolta
 //
 //           Rectangle { x: 0; y: 25; width: 550; height: 30; color: "#131313"; radius: 2 // Resultado Filtro
 //             CheckBox { id: cxCond; checked: true; x: 5; y: 3;
 //                Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
 //                     font.pixelSize: 12; text: qsTr("Condução Vozes")}
 //                MouseArea {
 //                  anchors.fill: parent
 //                  hoverEnabled: true
 //                  onEntered: showTooltip("Mostra/oculta erros de condução de vozes", mouseX, mouseY)
 //                  onExited: tooltip.visible = false
 //                }
 //             }
 //             CheckBox { id: cxDiss; checked: true; x: 150; y: 3
 //                Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
 //                      font.pixelSize: 12; text: qsTr("Dissonância") }
 //                MouseArea {
 //                  anchors.fill: parent
 //                  hoverEnabled: true
 //                  onEntered: showTooltip("Mostra/oculta erros de tratamento de dissonâncias", mouseX, mouseY)
 //                  onExited: tooltip.visible = false
 //                }
 //             }
 //             CheckBox { id: cxMelo; checked: true; x: 270; y: 3
 //                Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
 //                     font.pixelSize: 12; text: qsTr("Melodia")}
 //                MouseArea {
 //                  anchors.fill: parent
 //                  hoverEnabled: true
 //                  onEntered: showTooltip("Mostra/oculta erros de construção melódica", mouseX, mouseY)
 //                  onExited: tooltip.visible = false
 //                }
 //             }
 //             CheckBox { id: cxOutr; checked: true; x: 390; y: 3
 //                Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
 //                      font.pixelSize: 11; text: qsTr("Outros") }
 //                MouseArea {
 //                  anchors.fill: parent
 //                  hoverEnabled: true
 //                  onEntered: showTooltip("Mostra/oculta outros erros", mouseX, mouseY)
 //                  onExited: tooltip.visible = false
 //                }
 //             }
 //           } // Rectangle Filtro
 //
	//   Component {
	//     id: component
	//     Rectangle {
 //          id: msg
 //          property alias text: lResul.text
 //          property int value: 0
 //          signal clicked
 //          visible: true
 //          width: 550; height: 21
 //          border { width: 1; color: "#000000" }
 //          smooth: true
 //          radius: 3
 //          color: "#6c6d6d"
 //
 //         Text {
 //           id: lResul
 //           anchors.left: parent.left; anchors.leftMargin: 3
 //           anchors.verticalCenter: parent.verticalCenter
 //           text: "-"
 //           color: "#aaf0e1"
 //         }
 //
 //         MouseArea {
 //          id: msgClick
 //          anchors.fill: parent
 //          onClicked: { colorir(parent.value); }
 //          onDoubleClicked: { explicarMsg(parent.value); }
 //          }
 //       } // retângulo msg
	//   } // componente
 // } // msgResult
 //--------------------------------------------------------------------------------
  // janela com o relatório
    Popup {
      id: msgRelatorio
      title: "Relatório"
      width: 650; height: 40
      color: corFundoPrincipal
      visible: false
        StyledTextLabel {
          id: lRelatorio
          anchors.left: parent.left; anchors.leftMargin: 3
          anchors.verticalCenter: parent.verticalCenter
          text: "-"
          color: corTextoPrimario
        }
  }
 // msgRelatorio

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
//------------------------------------------------------------------------------
  MessageDialog {
     id: msgExplica
     title: "Dica!"
     text: "-"
     property bool estado: false
     onAccepted: {
           msgExplica.visible=false;
     }
     visible: false;
  } // msg de Explicação
//*/ -----------------------------------------------------------------------------------------------------------------
// caixas de dialogo para salvar e abrir presets
// FileDialog {
//     id: openFileDialog
//     filters: ["Configuração do Analisador (*.cfA)"]
//     onAccepted: openFile(openFileDialog.fileUrl)
//
// }
// FileDialog {
//     id: saveFileDialog
//     // selectExisting (removido: Qt6/MuseScore 4): false
//     filters: ["Configuração do Analisador (*.cfA)", "All files (*)"]
//     onAccepted: saveFile(saveFileDialog.fileUrl, "")
// }
// -----------------------------------------------------------------------------------------------------------------
  // ---- variáveis globais ----

      property bool processaTudo: false;
      property var vozes: [];
      property var vozesT: [];
      property var vS: 0;
      property var vI: 1;
      property var relator: "";
      property var avalia: 0;
      property var resultado: [];
      property var resultadoFiltro: [];
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
      property var pag: 0;

// ----------- funções ---------
// function atualizarTitulo() {
//   if (melodia) { titulo2.text = "Cantus Firmus:"; tipoCP = 0; };
//   if (priEsp) { titulo2.text = "1ª espécie:"; tipoCP = 1;};
//   if (secEsp) { titulo2.text = "2ª espécie:"; tipoCP = 2;};
//   if (terEsp) { titulo2.text = "3ª espécie:"; tipoCP = 3;};
//   if (quaEsp) { titulo2.text = "4ª espécie:"; tipoCP = 4;};
//   if (quiEsp) { titulo2.text = "5ª espécie:"; tipoCP = 5;};
//   if (livreCP) { titulo2.text = "Contraponto livre:"; tipoCP = 6;};
//   if (melodias.visible) { titulo1.text = "construção melódica" };
//   if (dissonâncias.visible) { titulo1.text = "tratamento de dissonâncias" };
//   if (conduz.visible) { titulo1.text = "condução de vozes" };
//   if (outros.visible) { titulo1.text = "outros aspectos" };
//   if (intervalosClasse.visible) { titulo1.text = "Seleção de intervalos dissonântes" };
// }

function salvarCfg() {

   var j = 189 * tipoCP;
//console.log("salvarCfg ", tipoCP," j = ", j);
 // ---------------- conduz -----------
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
   if(ocultExt.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(inter8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(inter5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interPM.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interSI.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExFim.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExCF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExt.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExS.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = interExSn.text; j++;
   if(movContObli.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(movSim.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = qtdMovSim.text; j++;
   if(consecObli.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(consecCont.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(uniss.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = unissQt.text; j++;
   if(unissIF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(unissTF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(unissTmF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cruzaVozes.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(falsaR.checked){ config[j] = true; } else { config[j] = false; }; j++;
// ---------------- Outros ---------------
   if(sensCad.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(sensCadR.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(sensCadEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(distancia.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = distQt.text; j++;
   config[j] = distInt.text; j++;
   if(consImp.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmonia.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmoniaEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmoniaEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmoniaF.checked){ config[j] = true; } else { config[j] = false; }; j++;
 // -------------- Dissonancias -----------
   if(dissonanciasG.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passagemL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passaLEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passaLEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passaLExMF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraLI.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraLS.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraD.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLExMF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiataL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx1MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx3MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
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
   if(apojaEx1MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(escapadaL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(escapaEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(escapaEx1MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(pedal.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(pedalEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(pedalEx1MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
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
   if(saltTrit.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(tritono2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(tritono1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(dissoC.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltC.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltM.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltMEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltMEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
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

   var j = 189 * tipoCP;

   // ---------------- conduz -----------
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
     ocultExt.checked = config[j]; j++;
     inter8.checked = config[j]; j++;
     inter5.checked = config[j]; j++;
     interPM.checked = config[j]; j++;
     interSI.checked = config[j]; j++;
     interExTf.checked = config[j]; j++;
     interExTf1.checked = config[j]; j++;
     interExTf2.checked = config[j]; j++;
     interExTf3.checked = config[j]; j++;
     interExTF.checked = config[j]; j++;
     interExFim.checked = config[j]; j++;
     interExCF.checked = config[j]; j++;
     interExt.checked = config[j]; j++;
     interExS.checked = config[j]; j++;
     interExSn.text = config[j]; j++;
     movContObli.checked = config[j]; j++;
     movSim.checked = config[j]; j++;
     qtdMovSim.text = config[j]; j++;
     consecObli.checked = config[j]; j++;
     consecCont.checked = config[j]; j++;
     uniss.checked = config[j]; j++;
     unissQt.text = config[j]; j++;
     unissIF.checked = config[j]; j++;
     unissTF.checked = config[j]; j++;
     unissTmF.checked = config[j]; j++;
     cruzaVozes.checked = config[j]; j++;
     falsaR.checked = config[j]; j++;
  // --------------- outros -----------------
     sensCad.checked = config[j]; j++;
     sensCadR.checked = config[j]; j++;
     sensCadEx.checked = config[j]; j++;
     distancia.checked = config[j]; j++;
     distQt.text = config[j]; j++;
     distInt.text = config[j]; j++;
     consImp.checked = config[j]; j++;
     cHarmonia.checked = config[j]; j++;
     cHarmoniaEx.checked = config[j]; j++;
     cHarmoniaEx2.checked = config[j]; j++;
     cHarmoniaF.checked = config[j]; j++;
   // -------------- Dissonancias -----------
     dissonanciasG.checked = config[j]; j++;
     passagemL.checked = config[j]; j++;
     passaLEx.checked = config[j]; j++;
     passaLEx2.checked = config[j]; j++;
     passaLExMF.checked = config[j]; j++;
     bordaduraLI.checked = config[j]; j++;
     bordaduraLS.checked = config[j]; j++;
     bordaduraD.checked = config[j]; j++;
     bordaLEx.checked = config[j]; j++;
     bordaLExMF.checked = config[j]; j++;
     bordaLEx1.checked = config[j]; j++;
     cambiataL.checked = config[j]; j++;
     cambiLEx1.checked = config[j]; j++; //
     cambiLEx1MF.checked = config[j]; j++; //
     cambiLEx2.checked = config[j]; j++;
     cambiLEx3.checked = config[j]; j++;
     cambiLEx3MF.checked = config[j]; j++;
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
     apojaEx1MF.checked = config[j]; j++;
     apojaEx2.checked = config[j]; j++;
     apojaEx3.checked = config[j]; j++;
     apojaEx4.checked = config[j]; j++;
     apojaEx5.checked = config[j]; j++;
     escapadaL.checked = config[j]; j++;
     escapaEx1.checked = config[j]; j++;
     escapaEx1MF.checked = config[j]; j++;
     pedal.checked = config[j]; j++;
     pedalEx1.checked = config[j]; j++;
     pedalEx1MF.checked = config[j]; j++;
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
     saltTrit.checked = config[j]; j++;
     saltM8.checked = config[j]; j++;
     tritono2.checked = config[j]; j++;
     tritono1.checked = config[j]; j++;
     dissoC.checked = config[j]; j++;
     doisSaltC.checked = config[j]; j++;
     doisSaltM.checked = config[j]; j++;
     doisSaltMEx.checked = config[j]; j++;
     doisSaltMEx1.checked = config[j]; j++;
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

function gerarRelatorio() {
  var ajuste = 0;
  if (secEsp) { ajuste =  0.6; } else
  if (terEsp) { ajuste =  1.1; } else
  if (quaEsp) { ajuste =  1.2; } else
  if (quiEsp) { ajuste =  1.5; } else
  if (livreCP) { ajuste =  1.1; };

  msgRelatorio.visible = false;
  // if (avalia == 0) { msgErros.text = "Não foi encontrada nenhuma informação para relatar!\n" +
  //                                   "Antes de pedir um relatório, escolha a opção Verificar.";
  //                        msgErros.visible = true; return; };
  var avalFinal = Math.round((10 + ((avalia-ajuste)/(vozes.length/5)))*10)/10;
  if (avalFinal > 10) { avalFinal = 10; } else if (avalFinal < 0) { avalFinal = 0; };
  relator += "===========================\n";
  relator += "===    sugestão de nota: " + avalFinal + "    ===\n";
  relator += "===========================\n";
  msgRelatorio.height = Math.round(relator.length/30)*15+25;
  lRelatorio.text = relator;
  msgRelatorio.visible = true;
}

function explicarMsg(valor) {
  //console.log("explicaMsg:", valor);
  if (valor >= 10) { var n = 4; } else { var n = 3; };
  let explica = "----";
  if (resultado[valor][0].slice(0+n, 10+n) == "não conduz") { explica = "Para criar um sentido de conclusão mais acentuado, a melodia deve finalizar conduzindo para a finalis por grau conjunto." } else // melodia
  if (resultado[valor][0].slice(0+n, 9+n) == "penúltima") { explica = "Para criar uma expectativa de resolução e conclusão na nota final, a penúltima nota da melodia deve pertencer ao acorde do V ou do vii° grau." } else
  if (resultado[valor][0].slice(0+n, 6+n) == "Âmbito") { explica = "O âmbito melódico (intervalo entre a nota mais grave e a mais aguda da melodia), ultrapassou o limite estabelecido." } else
  if (resultado[valor][0].slice(0+n, 19+n) == "Não privilegia grau") { explica = "O uso de graus conjuntos beneficia a fluência melódica. Saltos maiores do que a 3ª devem ser usados somente em pontos estratégicos, para deixar a melodia mais expressiva." } else
  if (resultado[valor][0].slice(0+n, 24+n) == "intervalo melódico de 7ª") { explica = "Intervalo melódico de 7ª prejudica a fluência melódica e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 24+n) == "intervalo melódico de 6ª") { explica = "Intervalo melódico de 6ª, por ser amplo, prejudica a fluência melódica e deveria ser compensado por um movimento suave na direção contrária." } else
  if (resultado[valor][0].slice(0+n, 28+n) == "intervalo melódico aumentado") { explica = "Intervalo melódico aumentado ou diminuto prejudica a fluência melódica e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 23+n) == "intervalo melódico > 8ª") { explica = "Intervalo melódico maior do que a 8ª, por ser amplo, prejudica a fluência melódica e deveria ser compensado por um movimento suave na direção contrária." } else
  if (resultado[valor][0].slice(0+n, 13+n) == "trítono nas 2") { explica = "O intervalo de trítono entre as notas das duas extremidades de um segmento melódico de intervalos na mesma direção coloca em evidência este trítono. Embora mais sutil do que a realização melódica direta do trítono, em alguns contextos, o trítono nas duas extremidades também prejudica a fluência e o direcionamento melódico e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 13+n) == "trítono em 1") { explica = "O intervalo de trítono entre uma nota da extremidade de um segmento melódico de intervalos na mesma direção e outra nota deste mesmo segmento coloca em evidência este trítono. Embora mais sutil do que a realização melódica direta do trítono e do que o trítono nas duas extremidades, em alguns contextos, o trítono em uma extremidade também prejudica a fluência e o direcionamento melódico e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 20+n) == "dissonância composta") { explica = "A dissonância composta (dois saltos que, somados, geram um intervalo melódico de 7ª ou 9ª) prejudica a fluência melódica e dificulta a execução vocal." } else
  if (resultado[valor][0].slice(0+n, 23+n) == "intervalo melódico > 5ª") { explica = "O intervalo melódico maior do que a quinta deve ser compensado por movimento em direção contrária e movimento menor do que o do salto de quinta (preferencialmente por grau conjunto). Isso beneficia a fluência e direcionamento melódico." } else
  if (resultado[valor][0].slice(0+n, 19+n) == "movimentos na mesma") { explica = "O excesso de movimentos na mesma direção e em sequência pode gerar monotonia na melodia, por ser muito previsível." } else
  if (resultado[valor][0].slice(0+n, 18+n) == "repetição de notas") { explica = "A repetição de notas (sem a mudança de nota na outra voz) tende a gerar monotonia." } else
  if (resultado[valor][0].slice(0+n, 19+n) == "repetição de padrão") { explica = "A repetição seguida de padrões melódicos curtos deixa a melodia previsível e pode gerar monotonia." } else
  if (resultado[valor][0].slice(0+n, 6+n) == "arpejo") { explica = "O excesso de arpejos na melodia prejudica a fluência e o direcionamento." } else
  if (resultado[valor][0].slice(0+n, 20+n) == "repete ponto focal s") { explica = "A repetição de Ponto Focal superior (a nota mais aguda da melodia), em trechos diferentes, enfraquece a definição do clímax da melodia e o direcionamento melódico." } else
  if (resultado[valor][0].slice(0+n, 20+n) == "repete ponto focal i") { explica = "A repetição de Ponto Focal inferior (a nota mais grave da melodia), em trechos diferentes, enfraquece a definição do clímax da melodia e o direcionamento melódico." } else
  if (resultado[valor][0].slice(0+n, 9+n) == "alteração") { explica = "O uso frequente da sensível é indispensável para a definição de tonalidades, no modo menor. A alteração do 7º grau melódico (sensível) pode exigir também a alteração ascendente do 6º grau, para evitar o intervalo melódico aumentado de 2ª." } else
  if (resultado[valor][0].slice(0+n, 9+n) == "neutraliz") { explica = "Em tonalidades menores, as tendências melódicas do 6º e 7º graus devem ser neutralizadas através da sua resolução nas notas subsequentes. O 6º grau melódico, quando alterado, deve seguir para o 7º grau também alterado. O 7º grau alterado (sensível), deve resolver na tônica. Os 6º e 7º graus naturais resolvem por grau conjunto descendente, no 5º e 6º graus, respectivamente." } else
  if (resultado[valor][0].slice(0+n, 12+n) == "Nota inicial") { explica = "A nota inicial da melodia é, frequentemente, importante para a definição tonal/modal (especialmente quando a melodia está na voz mais grave). O uso da tônica/finalis como primeira nota, em uma posição métrica forte, é a forma mais eficiente para determinar o tom/modo já no início da melodia." } else
  if (resultado[valor][0].slice(0+n, 11+n) == "2 saltos na") { explica = "2 ou mais saltos seguidos, na mesma direção, prejudicam a fluência melódica. É aceitável o padrão 5J + 4J, ou 4J + 5J." } else
  if (resultado[valor][0].slice(0+n, 11+n) == "2 saltos em") { explica = "2 ou mais saltos seguidos, em direção contrária, podem criar ruptura e prejudicar a fluência melódica." } else
  if (resultado[valor][0].slice(0+n, 8+n) == "salto de") { explica = "A ênfase melódica na nota alcançada por salto pode gerar um deslocamento do acento métrico." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "8ª pa") { explica = "As 8ªs paralelas (ou uníssonos paralelos) prejudicam o fundamental princípio da polifonia, que é a independência das vozes, e não devem ser realizadas." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "5ª pa") { explica = "As 5ªs paralelas prejudicam o fundamental princípio da polifonia, que é a independência das vozes, e não devem ser realizadas." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "4ª pa") { explica = "O excesso de movimentos paralelos de 4ª prejudica o fundamental princípio da polifonia, que é a independência das vozes, e não devem ser realizadas." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "3ª pa") { explica = "O excesso de movimentos paralelos de 3ª prejudica o fundamental princípio da polifonia, que é a independência das vozes, e não devem ser realizadas." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "6ª pa") { explica = "O excesso de movimentos paralelos de 6ª prejudica o fundamental princípio da polifonia, que é a independência das vozes, e não devem ser realizadas." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "8ª oc") { explica = "As 8ªs ocultas (ou diretas) ocorrem quando um intervalo de 8ªJ é alcançado por movimento direto, prejudicando o fundamental princípio da polifonia, que é a independência das vozes." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "5ª oc") { explica = "As 5ªs ocultas (ou diretas) ocorrem quando um intervalo de 5ªJ é alcançada por movimento direto, prejudicando o fundamental princípio da polifonia, que é a independência das vozes." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "5ª ou") { explica = "A ocorrência de dois ou mais intervalos justos consecutivos deixa a sonoridade muito vazia e, portanto, deve ser evitada." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "8ª in") { explica = "As 8ªs intermitentes são a ocorrência de dois intervalos de 8ªJ intercalados por outro(s) intervalo(s). Elas prejudicam o fundamental princípio da polifonia, que é a independência das vozes." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "5ª in") { explica = "As 5ªs intermitentes são a ocorrência de dois intervalos de 5ªJ  intercalados por outro(s) intervalo(s). Elas prejudicam o fundamental princípio da polifonia, que é a independência das vozes. " }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "uníss") { explica = "A ocorrência de uníssonos deixa a sonoridade muito vazia e, portanto, deve ser evitada." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "cruza") { explica = "Uma voz não deve cruzar o caminho de outra, ficando mais aguda do que aquela que está acima ou mais grave do que a que está logo abaixo. O cruzamento prejudica a independência e modifica o desenho melódico das vozes." }  else
  if (resultado[valor][0].slice(0+n, 5+n) == "falsa") { explica = "A falsa relação de cromatismo prejudica a clareza das linhas melódicas, ao dar a impressão de cruzamento de vozes atráves do movimento melódico cromático." }  else
  if (resultado[valor][0].slice(4+n, 23+n) == "prioriza movimentos") { explica = "O uso de movimentos contrários e oblíquos, em detrimento dos movimentos similares, beneficia a independência das vozes." }  else
  if (resultado[valor][0] == "Excesso de movimentos similares") { explica = "O excesso de movimentos similares prejudica a independência das vozes. " }  else
  if (resultado[valor][0] == "intervalo inicial") { explica = "Intervalo Inicial não expressa claramente a tônica e isso pode enfraquecer a definição tonal/modal. Para maior clareza, todas as vozes devem iniciar com uma nota do acorde da tônica, e a sua fundamental deveria ser apresentada, pelo menos, na voz mais grave." }  else
  if (resultado[valor][0] == "intervalo final") { explica = "Intervalo final não expressa claramente a tônica e isso pode enfraquecer a definição tonal/modal e o sentido de resolução. Para maior clareza, todas as vozes devem finalizar com uma nota do acorde da tônica, e a sua fundamental deveria ser apresentada, pelo menos, na voz mais grave." }  else
  if (resultado[valor][0] == "alcança intervalo final") { explica = "O movimento contrário na cadência final, beneficia o sentido de conclusão." }  else
  if (resultado[valor][0] == "cadência final sem a sensível") { explica = "O uso da sensível conduzindo para a tônica, na cadência final, fortalece o sentido de conclusão." }  else
  if (resultado[valor][0].slice(0+n, 16+n) == "cons. imperfeita") { explica = "As consonâncias imperfeitas tem uma sonoridade mais cheia de harmônicos e devem ser priorizadas, em detrimento das consonâncias imperfeitas." }  else
  if (resultado[valor][0].slice(0+n, 9+n) == "distância") { explica = "Os intervalos harmônicos entre as vozes não deve ultrapassar o limite estipulado. Intervalos excessivamente amplos não são percebidos com a mesma clareza do que os mais próximos. A distância muito ampla também gera uma separação demasiada que enfraquece a relação entre as vozes." }  else
  if (resultado[valor][0].slice(0+n, 10+n) == "nota não p") { explica = "Nota não pertencente ao acorde, sem o devido tratamento." }  else
  if (resultado[valor][0].slice(11) == "fundamental") { explica = "A fundamental do acorde precisa ser apresentada para que ele soe como tal." }  else
  if (resultado[valor][0] == "dissonância") { explica = "O uso de dissonância(s) não é permitido em exercícios de contraponto de 1ª espécie." }  else
  if (resultado[valor][0] == "dissonância não tratada") { explica = "Dissonância(s) sem o tratamento adequado. Em um contexto consonante, as dissonâncias devem ser suavizadas através de tratamentos melódicos e intervalares específicos, tais como 'nota de passagem', 'bordadura', 'suspensão', entre outros, e de acordo com as diretrizes do exercício. Os tratamentos de dissonâncias são uma forma de potencializar a tensão dos intervalos dissonantes dando um sentido de movimento ao contraponto, ao direcionar para a resolução em um intervalo consonante." } // else

  msgExplica.text = explica;
  msgExplica.estado = true;
  msgExplica.visible = true; return;
}

// Função para mostrar tooltips
function showTooltip(text, x, y) {
  tooltipText.text = text
  tooltip.x = x
  tooltip.y = y + 20  // Posiciona abaixo do cursor
  tooltip.visible = true
}

function destroirMsg() {
  //console.log("destrói", mensagem.length)
    for (var i=0;i<mensagem.length;i++) {
     if (mensagem[i]) {
     	mensagem[i].destroy();
     };
	 };
}

function colorir(valor) {
  //console.log("colorir = ", valor, mensagem[valor-1].text);
  curScore.startCmd();
  apagaCor();
  if (mensagem[valor-1]) { // Verifica se mensagem[x] existe
    mensagem[valor-1].color = "#6b6746";
  };
  if (Array.isArray(resultado[valor])) { // Garante que resultado[x] é um array
    for (var z=1;z<resultado[valor].length;z++) {
      if (resultado[valor][z]) { resultado[valor][z].color = "red"; };
    };
  };
  curScore.endCmd();
  //msgResult.raise();
}

function apagaCor() {

  for (var x=0;x<=resultado.length;x++) { // apaga seleções anteriores e botões
    if (mensagem[x]) { // Verifica se mensagem[x] existe
      mensagem[x].color = "#6c6d6d"; // Ajusta a cor para "#6c6d6d"
    };
    if (Array.isArray(resultado[x])) { // Garante que resultado[x] é um array
      for (var z = 0; z < resultado[x].length; z++) { // Corrige índices baseados em 0
        if (resultado[x][z]) { // Verifica se resultado[x][z] existe
            resultado[x][z].color = "black"; // Ajusta a cor para "black"
        };
      };
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

function verificaGrauMelodico(tonal,i) {
  if (vozesT[i]) { texto2tonica(vozesT[i].tom); } else { texto2tonica(vozes[i].tom); }
  var tom = tonicaTPC(btTonica.text, btAcid.text);
  var x = tonal - tom;
 	var modo = btModo.text;
//console.log("grau melódico:", tonal, i, tom, x, modo);
  switch(modo) {
  	case "Maior":
  	 switch (x) {
  	 	case 0: return 1;
      case 7: return "1+";
      case -5: return "2-";
  	 	case 2: return 2;
      case 9: return "2+";
      case -3: return "3-";
  	 	case 4: return 3;
  	 	case -1: return 4;
      case 6: return "4+";
      case -6: return "5-";
  	 	case 1: return 5;
      case 8: return "5+";
      case -4: return "6-"
  	 	case 3: return 6;
      case 10: return "6+";
      case -2: return "7-";
  	 	case 5: return 7;
    };
      // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n" ;
      // msgErros.estado=true; return "NA";
  	case "Menor":
  	 switch (x) {
  	 	case 0: return 1;
      case 7: return "1+";
      case -5: return "2-";
  	 	case 2: return 2;
      case 9: return "2+";
  	 	case -3: return 3;
      case 4: return "3+";
  	 	case -1: return 4;
      case 6: return "4+";
      case -6: return "5-";
  	 	case 1: return 5;
      case 8: return "5+";
  	 	case -4: return 6;
  	 	case 3: return "6+";
  	 	case -2: return 7;
  	 	case 5: return "7+";
  	 };
       // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
       // msgErros.estado=true; return "NA";
  	case "Jônico":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case 4: return 3;
  	 	case -1: return 4;
      case 6: return "4+";
  	 	case 1: return 5;
  	 	case 3: return 6;
  	 	case 5: return 7;
      case -2: return "7-";
    };
      // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      // msgErros.estado=true; return "NA";
  	case "Dórico":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case -3: return 3;
      case 4: return "3+";
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case 3: return 6;
      case -4: return "6-";
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
      // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      // msgErros.estado=true; return "NA";
  	case "Frígio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case -5: return 2;
      case 2: return "2+";
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
      case -6: return "5-";
  	 	case -4: return 6;
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
      // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      // msgErros.estado=true; return "NA";
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
     // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     // msgErros.estado=true; return "NA";
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
      case 5: return "7+";
  	 };
     // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     // msgErros.estado=true; return "NA";
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
     // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     // msgErros.estado=true; return "NA";
  	case "Lócrio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case -5: return 2;
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case -6: return 5;
      case 1: return "5+";
  	 	case -4: return 6;
      case 3: return "6+";
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
     // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     // msgErros.estado=true; return "NA";
  }
 }

function verificaTempoForte(tempo,metrica) {
  if (tempo%1 > 0) { return "c" };
   switch(metrica) {
    case 1:
    case 2:
    case 3: if (tempo == 1) { return "F"; } else { return "f"; };
      break;
    case 4: if (tempo == 1) { return "F"; } else if (tempo == 3) { return "mF"; } else { return "f"; };
      break;
    case 6: if (tempo == 1) { return "F"; } else if (tempo == 4) { return "mF"; } else { return "f"; };
      break;
    case 8: if (tempo == 1) { return "F"; } else if (tempo == 3 || tempo == 5 || tempo == 7) { return "mF"; } else { return "f"; };
      break;
    case 9: if (tempo == 1) { return "F"; } else if (tempo == 4 || tempo == 7) { return "mF"; } else { return "f"; };
      break;
    case 12: if (tempo == 1) { return "F"; } else if (tempo == 4 || tempo == 7 || tempo == 10) { return "mF"; } else { return "f"; };
      break;
   };

}

function verificaConsonancia(vIN, vIT) { //console.log("== verificaConsonancia ==");
  vIN = vIN % 12;
  //console.log(vIN, vIT); console.log("vI:", vI, "baixo:", vozes[0].nota.length-1);
  if ((vIN == 0 && vIT == 0) || (vIN == 7 && vIT == 1)) { return "CP"; }
    else if ((vIN == 3 && vIT == -3) || (vIN == 4 && vIT == 4) ||
             (vIN == 8 && vIT == -4) || (vIN == 9 && vIT == 3) ||
             (vIN == 5 && vIT == -1 && vI != vozes[0].nota.length-1) ||
             (vIN == 6 && (vIT == 6 || vIT == -6) && vI != vozes[0].nota.length-1)) { return "CI"; }
    else { return "D" };
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
     case "Mi": a = 4; break;
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
  if (!acorde) { console.log("Erro: sePertence(), 'acorde' indefinido!!"); return};
  if (!nota && nota != 0) { console.log("Erro: sePertence(), 'nota' indefinido!!"); return};
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
    if (texto[0].substr(-1, 1) == "B") {
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
  if (!cifra) { //console.log("Erro(cifra2notas)! não contém cifra!!");
                return; };
  var notas = [];
  texto2tonica(vozes[x].tom);
  var modo = btModo.text;
  var f; // fundamental
  var m; // variável para designar aumentado ou diminuto
  var d; // variavel para dissonancia
  var cifraM = cifra.toUpperCase();
  var idx1 = cifraM.lastIndexOf("I") + 1;
  var idx2 = cifraM.lastIndexOf("V") + 1;
  var idx3 = cifraM.lastIndexOf("/") + 1;
  if (idx1 == 0 && idx2 == 0) { console.log("Erro(cifra2notas)! cifra fora do padrão!!");
                                return; };
  if (idx1 > idx2) { var i = idx1;  } else { var i = idx2; }; // i = posição do ultimo caracter que indica o grau

  switch (cifra.substr(i, 1)) { // define se aumentado ou diminuto
    case "°":
    case "o":
    case "0":
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
//console.log(m,x,d, grau);
  if (modo == "Menor" && grauM == "VI" && m == 0) { var grauF = "VI+" } else
    if (modo == "Menor" && grauM == "VII" && m == 0) { var grauF = "VII+" }
      else { var grauF = grauM; };
    //console.log("modo e grauF:", x, modo, grauF);
  switch (grauF) { // define fundamental
    case "V/IV":
    case "I": f = 0; break;
    case "V/V":
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
    case "V/VI":
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
    case "V/VII":
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
    case "V/II":
    case "VI+": f = 3; break;
    case "V/III":
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
//console.log(grau != grauM, m);
   if (idx3 && m == null) { notas = [0+f, 4+f, 1+f]; } else
   if (idx3 && m == 0) { notas = [0+f, -3+f, -6+f]; } else
   if (idx3 && m == 1) { notas = [0+f, 4+f, 8+f]; } else
   if (grau == grauM && m == null) { notas = [0+f, 4+f, 1+f]; } else
   if (grau != grauM && m == null) { notas = [0+f, -3+f, 1+f]; } else
   if (grau != grauM && m == 0) { notas = [0+f, -3+f, -6+f]; } else
   if (grau == grauM && m == 1) { notas = [0+f, 4+f, 8+f]; };
//console.log(x, idx3, grau, grauM, m, "notas:", notas);
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
  if (vozes[1].nota.length == 1) { vozCF = 0; }
   else { vozCF = parseInt(vozCantusFirmus.text) - 1; };

  if (vozCF >= vozes[vozes.length-1].nota.length || vozCF < 0) {
          msgErros.text = "Erro! \n voz do Cantus Firmus não detectado! \n Por favor, insira um valor válido.";
                       msgErros.visible=true; finaliza = true; return; };
}

function apresentaResultado(p) { //console.log(" ======== Apresenta Resultado () =============");
  mensagem = [];
  var total = resultado.length - 1;
  var linhas = 0;
  const totalPagVer = Math.floor(total/20);
  pag = pag + p;
  if (pag < 0) { pag = 0 } else
  if (pag > totalPagVer) { pag = totalPagVer; };
  const itemAtual = pag * 20;
  let itemFinal = itemAtual + 20;
  if (itemFinal > total) { itemFinal = total; };
  //console.log(resultado.length);
  if (!resultado) { return ; };
  for (var i=itemAtual;i<itemFinal;i++) {
    //console.log(">>" + resultado[i+1][0]);
    if ((cxCond.checked &&
        (resultado[i+1][0].indexOf("paralela") !== -1 ||
        resultado[i+1][0].indexOf("oculta") !== -1 ||
        resultado[i+1][0].indexOf("consecutivas") !== -1 ||
        resultado[i+1][0].indexOf("intermitente") !== -1 ||
        resultado[i+1][0].indexOf("movimentos cont.") !== -1 ||
        resultado[i+1][0].indexOf("movimentos similares") !== -1 ||
        resultado[i+1][0].indexOf("uníssono") !== -1 ||
        resultado[i+1][0].indexOf("cruzamento") !== -1 ||
        resultado[i+1][0].indexOf("falsa") !== -1)) ||
        (cxDiss.checked && resultado[i+1][0].indexOf("dissonância") !== -1) ||
        (cxMelo.checked &&
         (resultado[i+1][0].indexOf("penúltima nota") !== -1 ||
          resultado[i+1][0].indexOf("não conduz") !== -1 ||
          resultado[i+1][0].indexOf("Âmbito") !== -1 ||
          resultado[i+1][0].indexOf("privilegia graus conj.") !== -1 ||
          resultado[i+1][0].indexOf("intervalo melódico") !== -1 ||
          resultado[i+1][0].indexOf("trítono") !== -1 ||
          resultado[i+1][0].indexOf("dissonância composta") !== -1 ||
          resultado[i+1][0].indexOf("movimentos na mesma") !== -1 ||
          resultado[i+1][0].indexOf("repetição de notas") !== -1 ||
          resultado[i+1][0].indexOf("repetição de padrão") !== -1 ||
          resultado[i+1][0].indexOf("arpejo") !== -1 ||
          resultado[i+1][0].indexOf("ponto focal") !== -1 ||
          resultado[i+1][0].indexOf("alteração") !== -1 ||
          resultado[i+1][0].indexOf("neutralização") !== -1 ||
          resultado[i+1][0].indexOf("Nota final") !== -1 ||
          resultado[i+1][0].indexOf("Nota inicial") !== -1 ||
          resultado[i+1][0].indexOf("2 saltos") !== -1 ||
          resultado[i+1][0].indexOf("salto") !== -1)) ||
          (cxOutr.checked &&
          (resultado[i+1][0].indexOf("intervalo") !== -1 ||
          resultado[i+1][0].indexOf("alcança") !== -1 ||
          resultado[i+1][0].indexOf("cadência") !== -1 ||
          resultado[i+1][0].indexOf("cons. imperfeita") !== -1 ||
          resultado[i+1][0].indexOf("distância") !== -1 ||
          resultado[i+1][0].indexOf("não pertence") !== -1 ||
          resultado[i+1][0].indexOf("fundamental") !== -1))){
          	mensagem[i] = component.createObject(msgResult);
          	mensagem[i].y = (linhas-itemAtual) * 25 + 55;
          	mensagem[i].text = resultado[i+1][0];
          	mensagem[i].value = linhas+1;
            linhas++;
          };
  };
  if (linhas < 1) { msgResult.height = 56; } else { msgResult.height = mensagem[mensagem.length-1].y + 25; };
  msgResult.visible = true;
  //msgResult.raise();

  if (msgErros.estado) { msgErros.visible = true; };
}

function fechaMsgErros(){
  msgErros.text = "";
  msgErros.estado = false;
}

//-----------------------------------------------
function verificar() {
 vozCF = null;
 vozesT = [];
 finaliza = false;
 fechaMsgErros();
 msgResult.height = 40;
 relator = "";
 avalia = 0;
 //console.log(" - verificar ---------");
 if (!priEsp && !secEsp && !terEsp && !quaEsp && !quiEsp && !melodia && !livreCP) {
          msgErros.text += "Erro! \n Nenhum tipo de contraponto selecionado!\n Utilize a barra laterial para selecionar.";
                       msgErros.visible=true; return; };
 destroirMsg();
 resultado = [];
 carregarNotas();
 //console.log(" - carregou notas ---------");
 if (finaliza) { return; };
 vCantusFirmus();
 analisaMelodia(); // função para analisar uma só voz da textura
 analisaTodas(); // função para analisar todas as vozes da textura
 analisaPares(); // função para analisar a textura em pares de vozes
 //console.log(" resultado.length - antes:" + resultado.length);
 resultado = removeRepetição(resultado); // função para apresentar o resultado em uma nova janela
 //console.log( " - resultado.length - depois:" + resultado.length);
 apresentaResultado(0);

}

function analisaMelodia() {
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
 if (saltoTF.checked) { saltoTempoForte(); };
}

function analisaTodas() {
  if (!melodia && (primInt.checked || ultInt.checked)) { primUltIntervalo(); };
  if (!melodia && ultNotas.checked) { alcançarMovContra(); };
  if (!melodia && sensCad.checked) { sensivelCadencia(); };
  if (!melodia && distancia.checked) { espaçamento(); };
  if (!melodia && movSim.checked) { quantidadeMovSim(); };
  if (cHarmonia.checked) { coerenciaHarmonica(); };
  if (cHarmoniaF.checked) { coerHarmFund(); };
}

function analisaDuplas() {
 // --------------- conduz ------------
 if (!melodia && (paralela5.checked || paralela8.checked)) { quintasOitavas(); };
 if (!melodia && paralela4.checked) { quartas(); };
 if (!melodia && paralela36.checked) { terçasSextas(); };
 if (!melodia && (oculta5.checked || oculta8.checked) && ((ocultExt.checked && vS == 0 && vI == vozes[0].nota.length-1) || !ocultExt.checked)) { ocultas(); };
 if (!melodia && (consecObli.checked || consecCont.checked)) { consecutivas(); };
 if (!melodia && (inter5.checked || inter8.checked) && ((interExt.checked && vS == 0 && vI == vozes[0].nota.length-1) || !interExt.checked)) { intermitentes(); };
 if (!melodia && movSim.checked) { priorizaContObli(); };
 if (!melodia && uniss.checked) { unissono(); };
 if (!melodia && cruzaVozes.checked) { cruzamento(); };
 if (!melodia && falsaR.checked) { falsaRelação(); };
 if (!melodia && consImp.checked) { consonancias(); };
 // // --------------- dissonâncias --------------
 if (!melodia && dissonanciasG.checked) { dissonanciasL(); };
}
//---------------------------------------
function carregarNotas() {

  console.log("Analisador de Contrapontos v0.5 .............................................. Rogério Tavares Constante - 2025(c)")

  if (typeof curScore == 'undefined' || curScore == null) { // verifica se há partitura
     //console.log("nenhuma partitura encontrada");
     msgErros.text = "Erro! \n Nenhuma partitura encontrada!";
                       msgErros.visible=true; finaliza = true; return; };

  //----------------------------------------------------------------------------
  var cursor = curScore.newCursor();
  vozCF = parseInt(vozCantusFirmus.text) - 1;
  var pautaInicial;
  var pautaFinal;
  var posFinal;
  var posInicial;
  processaTudo = false;
  vozes = [];
  //console.log("- criou cursor e limpou vozes!");
  cursor.rewind(1);
  //console.log("- cursor.rewind(1) ---------");
  //procura por uma seleção
  if (!cursor.segment) {
     // no selection
     //console.log("nenhuma seleção: processando toda partitura");
     processaTudo = true;
     if (melodia) { pautaInicial = vozCF; pautaFinal = vozCF + 1}
             else { pautaInicial = 0; pautaFinal = curScore.nstaves; };
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
  // procura voz do cantus firmus
  if (cursor.segment) { cursor.rewind(1); } else { cursor.rewind(0); };
  var cantus;
  for (var cf = 0; cf < cursor.segment.annotations.length; cf++) {
    if (cursor.segment.annotations[cf].type == 49 ||
        cursor.segment.annotations[cf].type == 48) { //console.log("Anotações:", cursor.segment.annotations[cf].text);
        cantus = cursor.segment.annotations[cf].text.toUpperCase();
        if (cantus == "CF" || cantus == "C.F." ||
            cantus == "CANTUS FIRMUS" || cantus == "CANTUS") {
            if (cursor.segment.annotations[cf].track == 0) { //console.log("CF está no track 0");
              vozCantusFirmus.text = 1;
            } else { //console.log("CF não está no track 0");
              vozCantusFirmus.text = (cursor.segment.annotations[cf].track/4)+1;
            };
        }; //console.log("track:", cursor.segment.annotations[cf].track, vozCantusFirmus.text);
    };
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
        var tickComp = [];  // posição de início dos compassos

        cursor.rewind(0);

        while (cursor.segment && (processaTudo || cursor.segment.tick < posFinal)) { // cria array com as formulas de compasso
          compasso++;
          tickComp[compasso] = cursor.segment.tick;
          cursor.nextMeasure();
        };

      // lê as informações da seleção (ou do documento inteiro, caso não haja seleção)

        if(!cursor.segment) { cursor.rewind(0); } else { cursor.rewind(1); }; // posiciona o cursor no início
        var segmento = cursor.segment;
        var pausa = false;
        for (var c=1;c<tickComp.length;c++) { // atualiza 'compasso' para posição do segmento
          if (tickComp[c] >= segmento.tick) { compasso = c; break; };
        };
       while (segmento && (processaTudo || segmento.tick < posFinal)) {
        carregou = false;
        var denominador = cursor.measure.timesigActual.denominator;
        var numerador = cursor.measure.timesigActual.numerator;
        var tempo = ((segmento.tick - tickComp[compasso]) / (1920 / denominador)) + 1;
        var voz = 0;
        var cifras, tom;
        for (var cif = 0; cif < segmento.annotations.length; cif++) { //console.log(segmento.annotations[cif].type, segmento.annotations[cif].subStyle, segmento.annotations[cif].text);
             if (segmento.annotations[cif].subStyle == 30 &&
                 segmento.annotations[cif].type == 49) {
              //console.log("compasso", compasso, ":", segmento.annotations[cif]);
              cifras = segmento.annotations[cif].text;
              //console.log("cif", cif, cifras);
           } else if ((segmento.annotations[cif].type == 49 ||
                       segmento.annotations[cif].type == 48) &&
                       segmento.annotations[cif].text.length > 4) {
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
                   vozes[seg].tonal[voz] = 0;
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
            //console.log("Duração da vozes anterior ultrapassa posição do segmento:", prolonga);
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
             	 if (vozes[seg].duração[i] < vozes[seg].duração[i-1]) { cursor.track = vozes[seg].trilha[i]; };
             };
             seg++;
          };

    		  cursor.next(); segmento = cursor.segment;
          compasso++;
          if (tickComp[compasso] && segmento.tick < tickComp[compasso]) { compasso--; };
       };

   if (seg == 0) { msgErros.text += "Nenhum acorde carregado!!\n";
                        msgErros.estado=true; (typeof(quit) === 'undefined' ? Qt.quit : quit)(); };
 for (var x=0;x<vozes[0].nota.length;x++) {
   if (vozes[0].nota[x] == 0) { vozes.splice(0, 1); x--; break; };
 };
 //for (var x=0;x<vozes.length;x++) {
 //console.log("vozes:", 1, vozes[1].nota); fechaMsgErros();
 //};
 if (vozes.length < 2) { // verifica se há partitura
    //console.log("vozes.length < 2");
    msgErros.text = "Erro! \n Não foi detectada quantidade mínima de notas!";
                      msgErros.visible=true; finaliza = true; return; };
}

function analisaPares() { //console.log("função analisaPares --- ");
  if (vozes.length > 1) { // se tiver mais de um acorde
    //console.log("vozes.length > 1:", vozes.length);
    if (vozes[0].nota.length > 1) { //console.log("vozes[0].nota.length > 1:", vozes[0].nota.length);
      //loop para carregas a var vozesT com as combinações de pares de vozes
      for (var vs=0;vs<vozes[0].nota.length-1;vs++) { // percorre voz superior
        //console.log("voz da nota superior:", vs, vozes[0].nota[vs]);
        for (var vi=vs+1;vi<vozes[0].nota.length;vi++) { // percorre voz inferior
          //console.log("vozes:", vs, vi);
          vozesT = [];
          for (var ac=0;ac<vozes.length;ac++) { // percorre acordes
            //console.log("acordes:", ac, vozes[ac].nota[vs], vozes[ac].nota[vi] );
            vozesT.push({
              nota: [vozes[ac].nota[vs], vozes[ac].nota[vi]],
              tonal: [vozes[ac].tonal[vs], vozes[ac].tonal[vi]],
              trilha: [vozes[ac].trilha[vs], vozes[ac].trilha[vi]],
              posição: [vozes[ac].posição[vs], vozes[ac].posição[vi]],
              duração: [vozes[ac].duração[vs], vozes[ac].duração[vi]],
              compasso: vozes[ac].compasso,
              formula: vozes[ac].formula,
              objeto: [vozes[ac].objeto[vs], vozes[ac].objeto[vi]],
              ligadura: [vozes[ac].ligadura[vs], vozes[ac].ligadura[vi]],
              tempo: [vozes[ac].tempo[vs], vozes[ac].tempo[vi]],
              cifras: vozes[ac].cifras,
              tom: vozes[ac].tom
            });
            //console.log("vozesT:", ac, vs, vi, vozesT[ac].nota)
          };
          vS = vs; vI = vi;
          analisaDuplas(vS, vI);
        };
      }
    } else if (vozes[0].nota.length == 1) { //console.log("vozes[0].nota.length == 1:", vozes[0].nota.length);
          vozesT = [];
          for (var ac=0;ac<vozes.length;ac++) { // percorre acordes
            vozesT.push({
              nota: vozes[ac].nota[vi],
              tonal: vozes[ac].tonal[vi],
              trilha: vozes[ac].trilha[vi],
              posição: vozes[ac].posição[vi],
              duração: vozes[ac].duração[vi],
              compasso: vozes[ac].compasso,
              formula: vozes[ac].formula,
              objeto: vozes[ac].objeto[vi],
              ligadura: vozes[ac].ligadura[vi],
              tempo: vozes[ac].tempo[vi],
              cifras: vozes[ac].cifras,
              tom: vozes[ac].tom
            });
          };
          vS = 0;
          analisaDuplas();
    } else { msgErros.text += "Nenhuma voz detectada!\n";
                        msgErros.estado = true; return; };
  } else { msgErros.text += "Não possui a quantidade mínima de notas para a realização da análise!\n";
                        msgErros.estado = true; return; };
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
     if (vozes[i].nota[voz] == 0) { continue; };
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
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz] || vozes[x].nota[voz] == 0 || vozes[x-1].nota[voz] == 0) { continue;};
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
   var intN = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var intCT = Math.abs(vozes[x].tonal[voz] - vozes[x-1].tonal[voz]);

   if ((intN == 10 && intCT == 2) || // 7ªm
       (intN == 11 && intCT == 5) || // 7ªM
        (intN == 9 && intCT == 9)) { // 7ªd
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
   var intCT = vozes[x].tonal[voz] - vozes[x-1].tonal[voz];

   if ((intervalo == 8 || intervalo == 9 || intervalo == -8 || intervalo == -9) // 6ª M e m, desc e asc
        && intCT != 9 && intCT != 8 && intCT != -9 && intCT != -8) { // não 7ªd e não 5ªa
     if (salt6Ex.checked && intervalo > 0 && intCT == -4) { continue; };
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
   if (vozes[x-2] && vozes[x+1]) {
     var iPrep = vozes[x-1].nota[voz] - vozes[x-2].nota[voz];
     var iTrit = vozes[x].nota[voz] - vozes[x-1].nota[voz];
     var iRes = vozes[x+1].nota[voz] - vozes[x].nota[voz];
     if ((Math.abs(iPrep) < 3 && Math.abs(iRes) < 3 && Math.abs(iPrep) > 0 && Math.abs(iRes) > 0) && // prepara e resolve por grau conjunto
        ((iPrep > 0 && iTrit < 0 && iRes < 0) || (iPrep > 0 && iTrit < 0 && iRes < 0))) // prepara e resolve na direção contrária do trítono
        { var preparado = true } else { var preparado = false; };
   };
   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var intCT = Math.abs(vozes[x].tonal[voz] - vozes[x-1].tonal[voz]);
   if ((intervalo == 6 && (!saltTrit.checked || !preparado) )|| // 4ªa e 5ªd
       (intCT == 9) || // 2ªa
       (intCT == 8)) { // 5ªa
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico aumentado ou diminuto", 2, 1);
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
  //console.log("x:", x, "mov:", dir1)

   if (dir1 == 0) { mov[x-1] = mov[x-2]} else { mov[x-1] = dir1; };

   if (x>=2 && mov[x-1] != mov[x-2]) {
    for (var i = posI+1; i < x-2; i++) { //console.log("voz:", voz, " | ", novaVoz[i].nota, novaVoz[x-1].nota);
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
      criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "intervalo melódico > 5ª", 2, 1);
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
     //console.log(x,")",vozes[x].nota[voz], vozes[x].ligadura[voz]);
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
 var ultComp = vozes[vozes.length-1].compasso;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var vozSup = [];
  var pfSs = 0, pfSi = 127;  // ponto focal da voz Superior/Inferior, inferior/superior
  var pfSsc = 0, pfSic = 0; // var para contagem dos pontos focais;
  var pfAntS = 0, pfAntI = 0; // var para marcar a posição de PF anterior

  for (var x=0;x<vozes.length;x++) { // percorre acordes para encontrar pontos focais

   vozSup[x] = vozes[x].nota[voz];

   if (vozSup[x] > pfSs) { pfSs = vozSup[x]; };
   if (vozSup[x] < pfSi) { pfSi = vozSup[x]; };

 };

  for (var x=1;x<vozes.length-1;x++) { // percorre acordes
   var distMax = (1920/vozes[x].formula[1]) * 2; // define distância máxima para considerar como o mesmo PF. = 2 tempos
   if (vozSup[x] == pfSs) { pfSsc++; // contagem dos pontos focais superiores;
     var distS = vozes[x].posição[voz] - vozes[pfAntS].posição[voz]; //distância para o PF anterior
     if (vozSup[x-1] == pfSs || // não conta se nota anterior é ponto focal
         ((x >= vozes.length-3 && (vozes[x].compasso == ultComp-1 || vozes[x].compasso == ultComp)) || (x <= 3 && vozes[x].compasso == 1)) || // não conta se é a uma das 3 primeiras (no 1º comp.) ou 3 últimas notas (no último ou penúltimo comp.)
         distS <= distMax // não conte se distância entre os PFs for <= a dois tempos
        ) { pfSsc--; } else
     if (melPFs.checked && pfSsc > 1) { verificados++; criaResultado(verificados, x, voz, voz, "repete ponto focal superior", 1, 1); } else
      { pfAntS = x; };
   };
   if (vozSup[x] == pfSi) { pfSic++; // contagem dos pontos focais inferiores;
     var distI = vozes[x].posição[voz] - vozes[pfAntI].posição[voz]; //distância para o PF anterior
    //console.log(voz, x, distMax, distI, pfAntI);
     if (vozSup[x-1] == pfSi || // não conta se nota anterior é ponto focal
        ((x >= vozes.length-3 && (vozes[x].compasso == ultComp-1 || vozes[x].compasso == ultComp)) || (x <= 3 && vozes[x].compasso == 1)) || // não conta se é a uma das 3 primeiras (no 1º comp.) ou 3 últimas notas (no último ou penúltimo comp.)
         distI <= distMax // não conte se distância entre os PFs for <= a dois tempos
        ) { pfSic--; } else
     if (melPFi.checked && pfSic > 1) { verificados++; criaResultado(verificados, x, voz, voz, "repete ponto focal inferior", 1, 1); } else
      { pfAntI = x; };
   };
 };
 };
}

function neutralterações() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de neutralização de alterações!\n";
                       msgErros.estado=true; return; };
var temposNeutra = parseInt(neutNqt.text);

var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
for (var voz = vozInicial; voz <= vozFinal; voz++) {
  //console.log("=> voz", voz);
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
    var tom1 = tonicaTPC(btTonica.text, btAcid.text);
    var nota1 = novaVoz[x].tonal-tom1;
    alt1 = alt1.toString();
    var alt2 = verificaGrauMelodico(novaVoz[x+1].tonal, novaVoz[x+1].pos);
    var tom2 = tonicaTPC(btTonica.text, btAcid.text);
    var nota2 = novaVoz[x+1].tonal-tom2;
    alt2 = alt2.toString();
    if (x < novaVoz.length-2) {
      var alt3 = verificaGrauMelodico(novaVoz[x+2].tonal, novaVoz[x+2].pos);
      var tom3 = tonicaTPC(btTonica.text, btAcid.text);
      var nota3 = novaVoz[x+2].tonal-tom3;
      alt3 = alt3.toString();
    };
    if (x < novaVoz.length-3) {
      var alt4 = verificaGrauMelodico(novaVoz[x+3].tonal, novaVoz[x+3].pos);
      var tom4 = tonicaTPC(btTonica.text, btAcid.text);
      var nota4 = novaVoz[x+3].tonal-tom4;
      alt4 = alt4.toString();
    };
    if (x < novaVoz.length-4) {
      var alt5 = verificaGrauMelodico(novaVoz[x+4].tonal, novaVoz[x+4].pos);
      var tom5 = tonicaTPC(btTonica.text, btAcid.text);
      var nota5 = novaVoz[x+4].tonal-tom5;
      alt5 = alt5.toString();
    };
    // verifica tratamento das alterações --------
    if (alt1.slice(-1) == "+") { // se alteração elevando

     if (neutAim.checked) { // conduz alteração imediatamente?
       if (alt1.slice(0, 1) == "6") { // 6º conduz imediatamente para 7º e 1º?
         //console.log("6º conduz imediatamente para 7º e 1º?", x, tom1, tom2, tom3, nota2, alt3);
         if (x < novaVoz.length-2 && (nota2 != 5 || alt3 != "1") &&
              tom1 == tom2 && tom1 == tom3) { var a = x + 1; verificaAlter(); }; // se não, manda pra lista de verificações
       } else
       if (alt1.slice(0, 1) == "7") { // 7º conduz imediatamente para o 1º
         //console.log("7º conduz imediatamente para o 1º?", x, tom1, tom2, alt2);
         if (alt2 != "1" && tom1 == tom2) { var a = x + 1; verificaAlter(); }; // se não, manda pra lista de verificações
       };
     } else { // conduz alteração não imediatamente
       for (var a=x+1;a<novaVoz.length;a++) {
         var tam = a - x;
         //console.log("tam =", tam);
         if (x < novaVoz.length-2 && tam > 4) { // se ultrapassar distância de 3 notas, manda pra lista de verificações
           //console.log("ultrapassou distância de 3 notas, em", x, a);
           a = x; verificaAlter(); x += 4; break; };
         var procuraT = verificaGrauMelodico(novaVoz[a].tonal, novaVoz[a].pos);
         procuraT = procuraT.toString();
         if (procuraT == "1") {  //procura resolução no 1º
           //console.log("achou resolução no 1º: 5 toms", tom1, tom2, tom3, tom4, tom5);
           if (x < novaVoz.length-2 && tam == 4 && tom1 == tom2 && tom1 == tom3 && tom1 == tom4) { // testa solução com distância de 4 notas
          //console.log("testa solução com distância de 4 notas", x, a, "alts", alt1, alt2, alt3, alt4);
            if (alt1 == "7+" && alt2 == "6+" && alt3 == "7+" && alt4 == "5") { x += 4; break;}
                else { a = x; verificaAlter(); x += 3; break; };
          } else if (x < novaVoz.length-2 && tam == 3 && tom1 == tom2 && tom1 == tom3) { // testa solução com distância de 3 notas
          //console.log("testa solução com distância de 3 notas", x, a, "alts", alt1, alt2, alt3, "notas", nota1, nota2, nota3);
             if (alt1 == "6+" && (((alt2 == "2" || alt2 == "5" || alt2 == "1") && nota1 == 5) ||
                                  (nota2 == 5 && (alt3 == "5" || alt3 == "2")))) { x += 3; break;} else
             if (alt1 == "7+" && ((alt2 == "2" && alt3 == "5") || (nota2 == 3 && nota3 == 5))) { x += 3; break;}
                 else { a = x; verificaAlter(); x += 3; break; };
           } else if (tam == 2) { // testa solução com distância de 2 notas
            //console.log("testa solução com distância de 2 notas", x, a, "alts", alt1, alt2, "notas", nota2);
             if (alt1 == "7+" && (alt2 == "2" || alt2 == "5")) { x += 2; break; } else
             if (alt1 == "6+" && nota2 == 5) { x += 2; break; }
                  else { a = x; verificaAlter(); x += 2; break; };
           } else if (tam == 1) { // testa solução com distância de 1 nota (e alternativa de 4 notas, com T na 2ª nota)
             if (x < novaVoz.length-3 && tam == 1 && tom1 == tom2 && tom1 == tom3 && tom1 == tom4 && tom1 == tom5) { // testa solução com distância de 4 notas
            //console.log("testa solução com distância de 1 e 4 notas", x, a, "alts", alt1, alt2, alt3, alt4);
               if (alt1 == "6+" && alt2 == "1" && ((alt3 == "7+" && alt4 == 2) || (alt4 == "7+" && alt3 == 2))) { x += 4; break;}};
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
   //console.log(">>>>>> alteração 6º e/ou 7º", novaVoz[x].pos, novaVoz[a].pos );
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
   var vozInicial = 0, vozFinal = vozes[1].tonal.length-1, triade = false, justos = false;
   for (var voz = vozInicial; voz <= vozFinal; voz++) {
     if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
     var novaVoz = [];
    for (var x=0;x<vozes.length;x++) {
      if (!vozes[x].ligadura[voz]) {
        novaVoz.push({ nota: vozes[x].nota[voz], tonal: vozes[x].tonal[voz], pos: x}) ;
       };
     };

    for (var x=2;x<novaVoz.length;x++) { // percorre acordes
     if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

     var int1 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var int2 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
     var intT1 = Math.abs(novaVoz[x-1].tonal - novaVoz[x-2].tonal);
     var intT2 = Math.abs(novaVoz[x].tonal - novaVoz[x-1].tonal);
     var dir1 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var dir2 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
     if ((((int1 == 3 || int1 == 4) && (int2 == 3 || int2 == 4)) && ((intT1 == 3 || intT1 == 4) && (intT2 == 3 || intT2 == 4))) ||
         (((int1 == 3 || int1 == 4) && (int2 == 5 || int2 == 6)) && ((intT1 == 3 || intT1 == 4) && (intT2 == 1 || intT2 == 6))) ||
         (((int1 == 5 || int1 == 6) && (int2 == 3 || int2 == 4)) && ((intT1 == 1 || intT1 == 6) && (intT2 == 3 || intT2 == 4)))) { triade = true; } else { triade = false; };
     if (((int1 == 5 && intT1 == 1) && (int2 == 7 && intT2 == 1)) || ((int1 == 7 && intT1 == 1) && (int2 == 5 && intT2 == 1))) { justos = true; } else { justos = false; };
     if (int1 > 2 && int2 > 2 && dir1 == dir2 && dir1 != 0) {
        if ((doisSaltMEx.checked && triade) || (doisSaltMEx1.checked && justos)) { continue; };
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

function saltoTempoForte() {

  if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos de tempo forte para tempo fraco!\n";
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
    for (var x=1;x<novaVoz.length;x++) { // percorre acordes
      if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

      var int1 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
      var dir1 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
      var pos1 = novaVoz[x-1].pos;
      var pos2 = novaVoz[x].pos;
      var met1 = verificaTempoForte(vozes[pos1].tempo[voz], vozes[pos1].formula[voz]);
      var met2 = verificaTempoForte(vozes[pos2].tempo[voz], vozes[pos2].formula[voz]);
//console.log(x, int1, dir1, pos1, pos2, met1, met2, saltoTmF.checked);
      if (int1 > 2 && (met1 == "F" || (saltoTmF.checked && met1 == "mF")) &&
          (met2 == "f" || met2 == "c") && (!saltoTFEx.checked || dir1 == 1)) {
         var posIni = pos2 - pos1 + 1
         verificados++;
         criaResultado(verificados, pos2, voz, voz, "salto de tempo forte para tempo fraco", posIni, 1);
      };
    };
  };
}

// --------------------- condução de vozes ------------
function quintasOitavas() {
   var par5Status = true, par8Status = true;
   var acorAnt = 1;
   var qtdpar8Rep = parseInt(par8Rep.text), qtdpar5Rep = parseInt(par5Rep.text);

   var par5 = 0, par8 = 0;

   for (var x=1;x<=vozesT.length;x++) { // percorre acordes
      if (x==vozesT.length) { verificou58(); continue ; };
      // if (voz >= vozesT[x].nota.length-1 || i >= vozesT[x].nota.length) { continue ; };
      if (vozesT[x].nota && vozesT[x-1].nota) {
        var dir1 = direção(vozesT[x].nota[0] - vozesT[x-1].nota[0]);
        var dir2 = direção(vozesT[x].nota[1] - vozesT[x-1].nota[1]);
        var intAtual = vozesT[x].nota[0] - vozesT[x].nota[1];
        var intAnt = vozesT[x-1].nota[0] - vozesT[x-1].nota[1];
        if (vozesT[x].nota[0] >= vozesT[x].nota[0]) {
          var intT1 = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else {
            var intT1 = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
        if (vozesT[x-1].nota[0] >= vozesT[x-1].nota[0]) {
          var intT2 = vozesT[x-1].tonal[0] - vozesT[x-1].tonal[1]; } else {
            var intT2 = vozesT[x-1].tonal[1] - vozesT[x-1].tonal[0]; };
      } else { return };

      if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

          if (Math.abs(intAtual%12) == 7 && intT1 == 1 && intT2 == 1 && intAtual == intAnt && paralela5.checked) { //testa 5ª paralela

              var qtdPar5 = par5 + 1;
              if (par5 == 0) { par5 = 2; } else { par5++; };
              par5Status = true;
              acorAnt = x;
              par8 = 0, par8Status = false;

          } else if (par5Status) { verificou58(); };

            if (Math.abs(intAtual%12) == 0 && intT1 == 0 && intT2 == 0 && intAtual == intAnt && paralela8.checked) {  // testa 8ª paralela

              var qtdPar8 = par8 + 1;

              if (par8 == 0) { par8 = 2; } else { par8++; };
              par8Status = true;
              acorAnt = x;
              par5 = 0, par5Status = false;

          } else if (par8Status) { verificou58(); };

        } else { verificou58(); };
     };

     function verificou58() {

       if (par8Status && par8 > qtdpar8Rep && paralela8.checked) {
         verificados++;
         if (qtdPar8 >= vozesT.length) { qtdPar8 = vozesT.length; } else { qtdPar8++; };
         criaResultado(verificados, acorAnt, vS, vI, "8ª paralela", qtdPar8 , 2);};

       if (par5Status && par5 > qtdpar5Rep && paralela5.checked) {
         verificados++;
         if (qtdPar5 >= vozesT.length) { qtdPar5 = vozesT.length; } else { qtdPar5++; };
         criaResultado(verificados, acorAnt, vS, vI, "5ª paralela", qtdPar5 , 2);};

      par8Status = false; par8 = 0;
      par5Status = false; par5 = 0;
    };
 }

function quartas() {

   var par4Status = true;
   var acorAnt = 1;
   var qtdpar4Rep = parseInt(par4Rep.text);

  //console.log("par4Rep : "+ qtdpar4Rep)

     for (var voz=0; voz < vozesT[1].nota.length-1; voz++) { // percorre vozesT
       var vozAnt = voz;
       for (var i=voz+1; i < vozesT[1].nota.length; i++) { // percorre outras vozesT
         var vozAtual = i;
         var par4 = 0;
	       for (var x=1;x<vozesT.length;x++) { // percorre acordes

	        // if (voz >= vozesT[x].nota.length-1 || i >= vozesT[x].nota.length) { verificou4(); continue; };

	        var dir1 = direção(vozesT[x].nota[voz] - vozesT[x-1].nota[voz]);
            var dir2 = direção(vozesT[x].nota[i] - vozesT[x-1].nota[i]);
            var intAtual = vozesT[x].nota[voz] - vozesT[x].nota[i];
            var intAnt = vozesT[x-1].nota[voz] - vozesT[x-1].nota[i];
            if (vozesT[x].nota[0] >= vozesT[x].nota[0]) {
              var intT1 = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else {
                var intT1 = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
            if (vozesT[x-1].nota[0] >= vozesT[x-1].nota[0]) {
              var intT2 = vozesT[x-1].tonal[0] - vozesT[x-1].tonal[1]; } else {
                var intT2 = vozesT[x-1].tonal[1] - vozesT[x-1].tonal[0]; };

            if (Math.abs(intAtual%12) == 5 && intAtual == intAnt && intT1 == 1 && intT2 == 1 && dir1 == dir2 && dir1 != 0) { //testa por 4ª paralela

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

     for (var voz=0; voz < vozesT[1].nota.length-1; voz++) { // percorre vozesT
       var vozAnt = voz;
       for (var i=voz+1; i < vozesT[1].nota.length; i++) { // percorre outras vozesT
   		 var vozAtual = i;
   		 var par3 = 0, par6 = 0;
	       for (var x=1;x<vozesT.length;x++) { // percorre acordes
           if (!vozesT[x].nota) { continue; };
	         if (voz >= vozesT[x].nota.length-1 || i >= vozesT[x].nota.length) {
	           if (x==vozesT.length-1) {verificou36();};
	           continue;
	         };
	          var dir1 = direção(vozesT[x].nota[voz] - vozesT[x-1].nota[voz]);
            var dir2 = direção(vozesT[x].nota[i] - vozesT[x-1].nota[i]);
            var intAtual = vozesT[x].nota[voz] - vozesT[x].nota[i];
            var intAnt = vozesT[x-1].nota[voz] - vozesT[x-1].nota[i];
            if (vozesT[x].nota[0] >= vozesT[x].nota[0]) {
              var intT1 = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else {
                var intT1 = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
            if (vozesT[x-1].nota[0] >= vozesT[x-1].nota[0]) {
              var intT2 = vozesT[x-1].tonal[0] - vozesT[x-1].tonal[1]; } else {
                var intT2 = vozesT[x-1].tonal[1] - vozesT[x-1].tonal[0]; };

            if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

              if ((Math.abs(intAtual%12) == 3 || Math.abs(intAtual%12) == 4) &&   //testa por 3ª paralela --
                  (Math.abs(intAnt%12) == 3 || Math.abs(intAnt%12) == 4) &&
                  ((intT1 == 3 || intT1 == 4) && (intT2 == 3 || intT2 == 4))) {

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

	for (var x=1;x<vozesT.length;x++) { // percorre acordes

    for (var voz=0; voz < vozesT[x].nota.length; voz++) { // percorre vozesT

      var i;
      var dir1 = direção(vozesT[x].nota[voz] - vozesT[x-1].nota[voz]);

      for (i=voz+1; i < vozesT[x].nota.length; i++) { // percorre outras vozesT

         var dir2 = direção(vozesT[x].nota[i] - vozesT[x-1].nota[i]);
         var intAtual = vozesT[x].nota[voz] - vozesT[x].nota[i];
         var intAnt = vozesT[x-1].nota[voz] - vozesT[x-1].nota[i];
         if (vozesT[x].nota[0] >= vozesT[x].nota[0]) {
           var intT1 = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else {
             var intT1 = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };

         if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

           if (Math.abs(intAtual%12) == 7 && intAtual != intAnt && intT1 == 1 && oculta5.checked) {             // testa ocultas
             // testa condições
             if (!ocultEx.checked || (ocultEx.checked && x != vozesT.length-1)) {
               if (!ocultSalto.checked || (ocultSalto.checked && Math.abs(vozesT[x-1].nota[0] - vozesT[x].nota[0]) > 2)) {
                verificados++;
                criaResultado(verificados, x, voz, i, "5ª oculta", 2, 2);
               };
             };
           };

           if (Math.abs(intAtual%12) == 0 && intAtual != intAnt && intT1 == 0 && oculta8.checked) { // testa ocultas
             // testa consições
             if (!ocultEx.checked || (ocultEx.checked && x != vozesT.length-1)) {
               if (!ocultSalto.checked || (ocultSalto.checked && Math.abs(vozesT[x-1].nota[0] - vozesT[x].nota[0]) > 2)) {
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

     for (var x=1;x<vozesT.length;x++) { // percorre acordes

       for (var voz=0; voz < vozesT[x].nota.length; voz++) { // percorre vozesT

         var i;
         var dir1 = direção(vozesT[x].nota[voz] - vozesT[x-1].nota[voz]);

         for (i=voz+1; i < vozesT[x].nota.length; i++) { // percorre outras vozesT

            var dir2 = direção(vozesT[x].nota[i] - vozesT[x-1].nota[i]);
            var intAtual = vozesT[x].nota[voz] - vozesT[x].nota[i];
            var intAnt = vozesT[x-1].nota[voz] - vozesT[x-1].nota[i];
            if (vozesT[x].nota[0] >= vozesT[x].nota[0]) {
              var intT1 = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else {
                var intT1 = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
            if (vozesT[x-1].nota[0] >= vozesT[x-1].nota[0]) {
              var intT2 = vozesT[x-1].tonal[0] - vozesT[x-1].tonal[1]; } else {
                var intT2 = vozesT[x-1].tonal[1] - vozesT[x-1].tonal[0]; };

            // consecutivas

             if ((Math.abs(intAtual%12) == 7 || Math.abs(intAtual%12) == 0) &&
                 (Math.abs(intAnt%12) == 7 || Math.abs(intAnt%12) == 0) &&
                 (intT1 == 1 || intT1 == 0) && (intT2 == 1 || intT2 == 0))  {

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
   var separa = parseInt(interExSn.text);
   for (var x=0;x<vozesT.length-2;x++) { // percorre acordes
    var tF = verificaTempoForte(vozesT[x].tempo[0], vozesT[x].formula[0]); // verifica posição métrica
    for (var y=x+2;y<vozesT.length;y++) { // percorre acordes
      var ac = y - x + 1; // calcula qtd de acordes entre x e y
      var tF2 = verificaTempoForte(vozesT[y].tempo[0], vozesT[y].formula[0]); // verifica posição métrica
      var alc = Math.abs(vozesT[y].nota[0] - vozesT[y-1].nota[0]); // calcula intervalo melódico que alcança a intermitente
      var alc2 = Math.abs(vozesT[y].nota[1] - vozesT[y-1].nota[1]);
      if (interExTf.checked && ((interExTf3.checked && tF != "F" && tF2 != "F") || // verifica exceção de tempo fraco e meio fraco
           (!interExTf3.checked && tF != "F" && tF != "mF" && tF2 != "F" && tF2 != "mF")) && // verifica exceção de tempo fraco
           (!interExTf2.checked || (alc < 3 && alc != 0) || (alc2 < 3 && alc2 != 0)) && // alcançada por grau conjunto
           (!interExTf1.checked || (vozesT[x+1].ligadura[0] || vozesT[x+1].ligadura[1]))) { continue; }; // verifica sincopada
      if (interExTF.checked && tF == "F" && ((vozesT[x].ligadura[0] && vozesT[y].ligadura[0]) ||
                                             (vozesT[x].ligadura[1] && vozesT[y].ligadura[1]))) { continue; }; // verifica exceção de tempo forte
      if (interExFim.checked && y == vozesT.length-1) { continue; }; // verifica a exceção de cadência final
      if (interExS.checked && ac-2 > separa) { continue; }; // verifica qtd de notas que separam
      var notasIguais = true; // verifica a exceção de CF parado
      var notasIguais2 = true;
      var notasIguais3 = true;
      for (var j=x+1;j<=y;j++){
        if (vozesT[x].nota[0] != vozesT[j].nota[0]) { notasIguais = false; };
        if (vozesT[x].nota[1] != vozesT[j].nota[1]) { notasIguais2 = false; };
      };
      if (interExCF.checked && (notasIguais || notasIguais2)) { continue; };
      var int1 = Math.abs(vozesT[x].nota[0] - vozesT[x].nota[1]); // calcula intervalo x
      var int2 = Math.abs(vozesT[y].nota[0] - vozesT[y].nota[1]); // calcula intervalo y
      if (vozesT[x].nota[0] >= vozesT[x].nota[1]) { var intT1 = vozesT[x].tonal[0] - vozesT[x].tonal[1];  }
        else { var intT1 = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
      if (vozesT[y].nota[0] >= vozesT[y].nota[1]) { var intT2 = vozesT[y].tonal[0] - vozesT[y].tonal[1];  }
        else { var intT2 = vozesT[y].tonal[1] - vozesT[y].tonal[0]; };
      if (interPM.checked && vozesT[x].compasso+1 == vozesT[y].compasso && vozesT[x].tempo[0] == vozesT[y].tempo[0]) { //mesma posição métrica
          if (int1%12 == 7 && int1 == int2 && intT1 == 1 && intT2 == 1 && inter5.checked) {
	         verificados++;
		       criaResultado(verificados, y, 0, 1, "5ª intermitente", ac, "in"); };
	        if (int1%12 == 0 && int1 == int2 && intT1 == 0 && intT2 == 0 && inter8.checked) {
	         verificados++;
		       criaResultado(verificados, y, 0, 1, "8ª intermitente", ac, "in");
          };
        };
      if (interSI.checked && y-x == 2) { // separadas por uma nota
        if (int1%12 == 7 && int1 == int2 && intT1 == 1 && intT2 == 1 && inter5.checked) {
	        verificados++;
		      criaResultado(verificados, y, 0, 1, "5ª intermitente", ac, "in"); };
	      if (int1%12 == 0 && int1 == int2 && intT1 == 0 && intT2 == 0 && inter8.checked) {
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

  if (unissIF.checked) { var a1 = 1, a2 = vozesT.length-1; } // exceção início e final
    else { var a1 = 0, a2 = vozesT.length; } ;

  for (var x=a1;x<a2;x++) { // percorre acordes
   var pMetric = verificaTempoForte(vozesT[x].tempo[0],vozesT[x].formula[0]);
   if ((!unissTF.checked || pMetric != "f") && (!unissTmF.checked || pMetric != "mF"))  { // exceção tempo fraco e meio forte
    for (var voz=1;voz<vozesT[x].nota.length;voz++) {
      var int1 = vozesT[x].nota[voz-1] - vozesT[x].nota[voz];
      if (vozesT[x].nota[0] >= vozesT[x].nota[0]) {
        var intT1 = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else {
          var intT1 = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
      if (int1 == 0 && intT1 == 0) { uni++; };
      if (int1 == 0 && intT1 == 0 && uni > unissono) {
        verificados++;
    	  criaResultado(verificados, x, voz-1, voz, "uníssono", 1, 2); };
    };
   };
  };
}

function cruzamento() {
  var cruza = false;
  for (var x=1;x<vozesT.length;x++) { // percorre acordes

	 for (var voz=0; voz < vozesT[x].nota.length - 1; voz++) { // percorre vozesT

       if (vozesT[x].nota[voz] < vozesT[x].nota[voz+1]) {
         if (cruza == false) {
	        verificados++;
	        criaResultado(verificados, x, voz, voz+1, "cruzamento", 1, 2);
            cruza = true;
         };
       } else { cruza = false };
    };
  }; // acordes
}

function falsaRelação() {
  for (var x=1;x<vozesT.length;x++) { // percorre acordes
    for (var voz=0; voz < vozesT[x].nota.length; voz++) { // percorre vozesT
      var int1 = Math.abs(vozesT[x].tonal[voz] - vozesT[x-1].tonal[voz]);
      if (int1 == 7) { continue; };

      for (var i=0; i < vozesT[x].nota.length; i++) { // percorre outras vozesT
         if (i == voz) { continue; };
         var int2 = Math.abs(vozesT[x-1].tonal[voz] - vozesT[x].tonal[i]);
         if (int2 == 7)  {  // testa falsa relação
               	verificados++;
               	criaResultado(verificados, x, voz, i, "falsa relação", 2, "fr"); };

      };
    };
  };
}

function priorizaContObli() {
  var mC = 0, mO = 0, mS = 0;
  for (var x=1;x<vozesT.length;x++) { // percorre acordes
    var movS = vozesT[x].nota[0] - vozesT[x-1].nota[0];
    var movI = vozesT[x].nota[1] - vozesT[x-1].nota[1];
    if ((movS > 0 && movI > 0) || (movS < 0 && movI < 0)) { mS++; } else
    if ((movS != 0 && movI == 0) || (movS == 0 && movI != 0)) { mO++; } else
    if (movS != movI) { mC++; };
  };
  //console.log("movimentos:", mC, mO, mS);
  if ((mO + mC) <= mS) {
  	 verificados++;
     var resultado = "não prioriza movimentos cont. e oblíquos (mC=" + mC + ", mO=" + mO + ", mS=" + mS + ")";
	 criaResultado(verificados, vozesT.length-1, vS, vI, resultado, vozesT.length, "semComp");
  };
}

function quantidadeMovSim() {
  var mS = 0; var seq = false;
  var qtdMax = parseInt(qtdMovSim.text);
  for (var x=1;x<vozes.length;x++) { // percorre acordes
    for (var v2=1;v2<vozes[0].nota.length;v2++) { // percorre voz inferior
      var movS = vozes[x].nota[0] - vozes[x-1].nota[0];
      var movI = vozes[x].nota[v2] - vozes[x-1].nota[v2];
      if ((movS > 0 && movI > 0) || (movS < 0 && movI < 0)) { seq = true; }
        else { seq = false; break; };
    };
    //console.log("Qtd mov sim:", x, seq, mS, qtdMax)
    if ((!seq || x == vozes.length) && mS > qtdMax) {
      verificados++;
      criaResultado(verificados, x-1, 0, v2, "Excesso de movimentos similares", mS+1, vozes[0].nota.length);
      //console.log("verificados", verificados);
    };
    if (seq) { mS++; } else { mS = 0;};
  };
}

// ------------- outros aspectos -------------
function primUltIntervalo() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de intervalo inicial e final!\n";
                       msgErros.estado=true; return; };
 texto2tonica(vozes[0].tom);
 var tonica1 = tonicaPC(btTonica.text, btAcid.text);
 texto2tonica(vozes[vozes.length-1].tom);
 var tonica2 = tonicaPC(btTonica.text, btAcid.text);
 var qtdVozes = vozes[0].nota.length;
 var notaInferior1 = vozes[0].nota[qtdVozes-1];
 var notaInferior2 = vozes[vozes.length-1].nota[qtdVozes-1];
 for (var x=0;x<qtdVozes-1;x++) {
  var intI = (Math.abs(vozes[0].nota[x] - notaInferior1)) % 12;
  var intF = (Math.abs(vozes[vozes.length-1].nota[x] - notaInferior2)) % 12;
  var inicio = false, finale = false;
  //console.log("teste Intervalo inicial:", x, qtdVozes-1, intI);
  if (intI != 0) { // se inicio não for U ou 8ª
  //console.log(ex5Ji.checked, ex3i.checked, tonica1, notaInferior1%12);
    if (ex5Ji.checked && (intI == 7 && tonica1 == notaInferior1%12)) { inicio = true; } else // se for 5ª com tonica na voz inferior
    if (ex3i.checked && ((intI == 3 || intI == 4) && tonica1 == notaInferior1%12)) { inicio = true; }; // se for 3ª com tonica na voz inferior
    if (!inicio && notaInferior1 != 0 && vozes[0].nota[x] != 0) {
      verificados++;
      criaResultado(verificados, 0, x, qtdVozes-1, "intervalo inicial", 1, 2); };
  };
  //console.log("teste Intervalo final:", x, qtdVozes-1, intF);
  if (intF != 0) { // se final não for U ou 8ª
    if (ex5Jf.checked && (intF == 7 && tonica2 == notaInferior2%12)) { finale = true; } else // se for 5ª com tonica na voz inferior
    if (ex3f.checked && ((intF == 3 || intF == 4) && tonica2 == notaInferior2%12)) { finale = true; }; // se for 3ª com tonica na voz inferior
    if (!finale && notaInferior2 != 0 && vozes[vozes.length-1].nota[x] != 0) {
      verificados++;
      criaResultado(verificados, vozes.length-1, x, qtdVozes-1, "intervalo final", 1, 2); };
  };
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

function sensivelCadencia(){

   if (btModo.text == "Frígio") { return; };
   if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de sensível na cadência final!\n";
                         msgErros.estado=true; return; };
   var tom = tonicaTPC(btTonica.text, btAcid.text);
   var achou = false;
   var c = (vozes[vozes.length-1].compasso) - 1; // penúltimo compasso
   for (var voz=0;voz<vozes[1].nota.length;voz++) { // percorre vozes
     var x = vozes.length-2;
  //console.log(voz, vozes[x].compasso, c);
     while (vozes[x].compasso >= c && x >= 0) { // procura sensível no penúltimo compasso
       var intM = Math.abs(vozes[vozes.length-1].nota[voz] - vozes[x].nota[voz]); // intervalo melódico na nota final para a nota X
  //console.log(voz, sensCadR.checked, vozes[vozes.length-1].tonal[voz], tom, intM, vozes[x].tonal[voz]);
       if ((!sensCadR.checked || (vozes[vozes.length-1].tonal[voz] == tom && intM == 1)) && // resolve sensível?
            vozes[x].tonal[voz] == tom+5) { achou = true; break; }; // achou a sensível?
       x--;
     };
     if (achou) { break; };
   };
   if (!achou) {
  	 verificados++;
     var n = (vozes.length - x) - 1;
  	 criaResultado(verificados, vozes.length-1, 0, 1, "cadência final sem a sensível", n, "null");
   };
}

function consonancias() {

  var cP = 0, cI = 0;
  for (var x=0;x<vozesT.length;x++) { // percorre acordes
   var vIN = Math.abs(vozesT[x].nota[0] - vozesT[x].nota[1]);
   if (vozesT[x].nota[0] >= vozesT[x].nota[1]) {
   var vIT = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else { var vIT = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
   var int1 = verificaConsonancia(vIN, vIT);
   //console.log("tipo de intervalo:", int1)
   if (int1 == "CP") { cP++; } else if (int1 == "CI") { cI++; }
  };
  //console.log("consonancias:", cP, cI);
  if (cP > cI) {
  	 verificados++;
     var resultado = "cons. imperfeita não é maioria (p=" + cP + ", i=" + cI + ")";
	 criaResultado(verificados, vozesT.length-1, vS, vI, resultado, vozesT.length, 2);
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
  for (var voz=1;voz<vozes[1].nota.length;voz++) { // percorre vozes
    var int1, conta = 0;
    for (var x=0;x<vozes.length;x++) { //percorre acordes
      if (!vozes[x].nota[voz] || !vozes[x].nota[voz-1] || vozes[x].nota[voz] == 0 || vozes[x].nota[voz-1] == 0) { continue;};
      int1 = Math.abs(vozes[x].nota[voz-1] - vozes[x].nota[voz]);
      //console.log("espaçamento:", voz-1, voz, int1, intT)
      if (int1 > intT) {
       conta++;
     } else {
        testaResultado(x-1,voz);
        conta = 0;
      };
    };
    testaResultado(vozes.length-1, voz);
  };

 function testaResultado(x,voz){
  if (conta > qt) {
    var msg = "distância vozes (" + conta + ")";
    verificados++;
    criaResultado(verificados, x, voz-1, voz, msg , conta, 2);
  };
 };
}

function coerenciaHarmonica() {
//console.log( "================ Coerência Harmônica =================\n")
  var novoX, acordeAnterior;
  for (var x=0;x<vozes.length;x++) {
    //console.log(x, vozes[x].tom);
    texto2tonica(vozes[x].tom);
    var tom = tonicaTPC(btTonica.text, btAcid.text);
    //console.log("===========", tom);
    for (var voz = 0; voz < vozes[1].tonal.length; voz++) {
      //console.log("= = = = = = ", x, vozes.length);
      var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
      var nota = vozes[x].tonal[voz] - tom;
      //console.log("==========", x, vozes[x].cifras);
      var acorde = cifra2notas(vozes[x].cifras, x); //console.log(x, "Acorde:", acorde);
      if (!acorde) { //console.log(x,") var acorde = indefinido!!");
                    continue; };
      //console.log("===========----------------===========", x, acorde, nota);
      var pertence = sePertence(acorde, nota);
      var mudaAcorde = true;
      if (acordeAnterior && acorde.toString() == acordeAnterior.toString()) { mudaAcorde = false; };
      //console.log("nota pertence ao acorde?", pertence, acorde.toString(), acordeAnterior, mudaAcorde, notaAcento);
      if (!pertence &&
                 (notaAcento == "F" || mudaAcorde ||
                 (!cHarmoniaEx.checked && notaAcento == "f") ||
                 (!cHarmoniaEx2.checked && notaAcento == "mF")
              )) {
        if (!priEsp) {
          //console.log("compasso:", vozes[x].compasso, x);
          novoX = cambiata(x, "ch"); if (novoX != x) { continue; };
          novoX = bordadura4(x, "ch"); if (novoX != x) { continue; };
          novoX = suspensão5(x, "ch"); if (novoX != x) { continue; };
          novoX = notaPassagem5(x, "ch"); if (novoX != x) { continue; };
          novoX = suspensão4(x, "ch"); if (novoX != x) { continue; };
          novoX = notaPassagem4(x, "ch"); if (novoX != x) { continue; };
          novoX = suspensão3(x, "ch"); if (novoX != x) { continue; };
          novoX = bordadura(x, "ch"); if (novoX != x) { continue; };
          novoX = notaPassagem(x, "ch"); if (novoX != x) { continue; };
          novoX = apojatura(x, "ch"); if (novoX != x) { continue; };
          novoX = antecipação(x, "ch"); if (novoX != x) { continue; };
          novoX = escapada(x, "ch"); if (novoX != x) { continue; };
          novoX = notaPedal(x, "ch"); if (novoX != x) { continue; };
        };
        verificados++;
        criaResultado(verificados, x, voz, voz, "nota não pertence ao acorde", 1, 1);
     };
   };
   acordeAnterior = acorde;
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
      } else { //console.log(cifraAnterior);
        if (!cifraAnterior) { return; };
        var acorde = cifra2notas(cifraAnterior, jAnterior);
        if (!acorde) { //console.log(jAnterior,") var acorde = indefinido!!");
                       continue; };
        texto2tonica(vozes[jAnterior].tom);
        tom = tonicaTPC(btTonica.text, btAcid.text);
        //console.log("acorde:", acorde);
        var fund = acorde[0] + tom;
        //console.log(j,") conjunto de notas", conjNotas, " == Fund:", fund);
        var pertence = sePertence(conjNotas, fund, tom);
        //console.log("fundamental?", pertence);
        if (!pertence && cHarmoniaF.checked) {
          var msg = cifraAnterior + " sem a fundamental";
          var ac = j - jAnterior;
          verificados++;
          criaResultado(verificados, j-1, 0, 1, msg, ac, vozFinal+1);
        };
        jAnterior = j; cifraAnterior = cifraAtual;
        conjNotas = []; conjNotas.push(vozes[j].tonal[voz]);
      };
    };
 };
}

// ------------------------Dissonâncias ------------
function dissonanciasL() { //console.log("voz superior:", vS, "voz inferior:", vI)
  //relator += "================ função dissonanciasL ================\n";
  var novoX;
  // procura dissonâncias
  for (var x = 0; x < vozesT.length; x++) {  // percorre acordes
    //console.log("DissonânciasL: percorre acordes", novoX, x);
    if (vozesT[x].nota[0] == 0 || vozesT[x].nota[1] == 0) { continue; };
    var acusaDissonancia = true;
    //console.log("cambiataL",x);
    if (cambiataL.checked) { novoX = cambiata(x, "td"); if (novoX != x) { x = novoX-1; continue; }; };
      //console.log("bordadura4",x);
    if (bordaduraD.checked) { novoX = bordadura4(x, "td"); if (novoX != x) { x = novoX; continue; }; };
    var vIN = Math.abs(vozesT[x].nota[0] - vozesT[x].nota[1]);
    if (vozesT[x].nota[0] >= vozesT[x].nota[1]) {
    var vIT = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else { var vIT = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
    var intHarm = verificaConsonancia(vIN, vIT); //console.log("==> Intervalo Harmônico: ", intHarm)
    if (intHarm == "D") { //console.log("Dissonância em", x);
       //procura padrão melódico de tratamento, do maior para o menor, até 3 notas. Primeiro na voz superior, depois na inferior.
       if (passagemL.checked) { //console.log("passagemL");
         if (passaLEx2.checked) { //console.log("passaLEx");
           novoX = notaPassagem5(x, "td"); if (novoX != x) { x = novoX; acusaDissonancia = false; continue; };
           novoX = notaPassagem4(x, "td"); if (novoX != x) { x = novoX; acusaDissonancia = false; continue; };
         };
         novoX = notaPassagem(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; };
         //console.log("passagem");
       };

       if (suspensãoL.checked) { //console.log("suspensãoL"); console.log("----=====",novoX, x);
          novoX = suspensão3(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; };
          novoX = suspensão4(x, "td"); if (novoX != x) { x = novoX; acusaDissonancia = false; continue; };
          novoX = suspensão5(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; };
       };

      //console.log("bordaduras");
       if (bordaduraLI.checked || bordaduraLS.checked) { novoX = bordadura(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };

      //console.log("apojaturaL");
       if (apojaturaL.checked) { novoX = apojatura(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };
      //console.log("antecipaL");
       if (antecipaL.checked) { novoX = antecipação(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };
      //console.log("escapadaL");
       if (escapadaL.checked) { novoX = escapada(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };
      //console.log("pedal");
       if (pedal.checked) { novoX = notaPedal(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };
      //console.log("acusaDissonancia", acusaDissonancia);

       if (acusaDissonancia) {
        verificados++;
        if (priEsp) { criaResultado(verificados, x, vS, vI, "dissonância", 1, 2); } else
              { criaResultado(verificados, x, vS, vI, "dissonância não tratada", 1, 2); };
       };
    } else { acusaDissonancia = false; };
  };
}
function suspensão3(x, tipo) { //console.log(x,"=============== função suspensão3 =============", vS, vI);
   if (x == 0) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; }; //console.log("vozIni:", vozIni, "vozFin", vozFin)
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x-1, r = x;
    while (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { // procura nota preparação
      var vIN = Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]);
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) {
      var vIT = vozesT[p].tonal[0] - vozesT[p].tonal[1]; } else { var vIT = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
      var notaPrepara = verificaConsonancia(vIN, vIT); //console.log(x, p, "notaPrepara: ", notaPrepara);
      var pos1 = vozesT[x].posição[voz];
      if (notaPrepara != "D") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozesT[x].nota[voz] == vozesT[r].nota[voz]) { r++; if (r >= vozesT.length-1) { break; }; }; // procura nota posterior
    if (!vozesT[r]) { return x; };
    if (!notaPrepara) {
      var vIN = Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]);
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) {
      var vIT = vozesT[p].tonal[0] - vozesT[p].tonal[1]; } else { var vIT = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
      var notaPrepara = verificaConsonancia(vIN, vIT); };
    var vIN = Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) {
    var vIT = vozesT[r].tonal[0] - vozesT[r].tonal[1]; } else { var vIT = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };;
    var notaResolve = verificaConsonancia(vIN, vIT);
    //console.log(x, p, "notaPrepara: ", notaPrepara);
    //console.log(x, r, "resolução: ", notaResolve);
    var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var intM = Math.abs(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var dur1 = pos1 - vozesT[p].posição[voz];
    var dur2 = vozesT[r].posição[voz] - pos1;
    if (!vozesT[r+1]) { var dur3 = dur1; } else { var dur3 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
//console.log(p, x, r, "duração:", dur1, dur2, dur3);
    if (mov1 == 0 && mov2 != 0 && intM < 3 && // desenho melódico, intervalos
        //(dur2 <= dur1*2 && dur2 <= dur3*2) && // proporção entre as durações de dissonâncias e consonâncias
        (notaResolve != "D" || tipo == "ch") && (notaPrepara != "D" || tipo == "ch") // e consonâncias em t.f.
        && p < x && r > x && (notaAcento == "F" || ((notaAcento == "f" && notaAcentoR == "c") || (notaAcento == "mF" && notaAcentoR == "f"))) && // dissonância métrica forte
        (!suspeLEx3.checked || notaResolve == "CI" || tipo == "ch") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1 || tipo == "ch")) { // permitir também resolução ascendente

        if (tipo == "td") { var nome = "- Tratamento de dissonância: suspensão 3 notas -"; avalia += 0.4; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: suspensão 3 notas -"; };
        switch(voz) {
          case 0: var v = vS; break;
          case 1: var v = vI; break;
        };
        if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (v+1) + "\n"; };
        return r;
      } else if (voz == vozFin) { return x; };
   };
}
function suspensão4(x, tipo) { //console.log(x,"=============== função suspensão4 =============", vS, vI);
   if (x == 0) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; }; //console.log("vozIni:", vozIni, "vozFin:", vozFin);
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x-1, i = x;
    while (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { // procura nota preparação
      var vIN = Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]);
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) {
      var vIT = vozesT[p].tonal[0] - vozesT[p].tonal[1]; } else { var vIT = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
      var notaPrepara = verificaConsonancia(vIN, vIT);
      var pos1 = vozesT[x].posição[voz];
      if (notaPrepara != "D") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozesT[x].nota[voz] == vozesT[i].nota[voz]) { // procura nota interrompe
      i++; if (i >= vozesT.length) { i = vozesT.length-1; break; }; };
     var r = i;
    while (vozesT[i].nota[voz] == vozesT[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozesT.length-1) { r = vozesT.length-1; break; }; };
    if (!vozesT[r]) { return x; };
    if (!notaPrepara) {
      var vIN = Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]);
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) {
      var vIT = vozesT[p].tonal[0] - vozesT[p].tonal[1]; } else { var vIT = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
      var notaPrepara = verificaConsonancia(vIN, vIT); };
    var vIN = Math.abs(vozesT[i].nota[0] - vozesT[i].nota[1]);
    if (vozesT[i].nota[0] >= vozesT[i].nota[1]) {
    var vIT = vozesT[i].tonal[0] - vozesT[i].tonal[1]; } else { var vIT = vozesT[i].tonal[1] - vozesT[i].tonal[0]; };
    //console.log("notaInterrompe - vIN, vIT: ", vIN, vIT);
    var notaInterrompe = verificaConsonancia(vIN, vIT);
    var vIN = Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) {
    var vIT = vozesT[r].tonal[0] - vozesT[r].tonal[1]; } else { var vIT = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };;
    var notaResolve = verificaConsonancia(vIN, vIT);
    var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var mov3 = direção(vozesT[i].nota[voz] - vozesT[x].nota[voz]);
    var mov4 = direção(vozesT[r].nota[voz] - vozesT[i].nota[voz]);
    var intM = Math.abs(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var intM2 = Math.abs(vozesT[i].nota[voz] - vozesT[x].nota[voz]);
    var intM3 = Math.abs(vozesT[r].nota[voz] - vozesT[i].nota[voz]);
    var dur1 = pos1 - vozesT[p].posição[voz];
    var dur2 = vozesT[i].posição[voz] - pos1;
    var dur3 = vozesT[r].posição[voz] - vozesT[i].posição[voz];
    if (!vozesT[r+1]) { var dur4 = dur1; } else { var dur4 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
    //console.log(p,x,i,r,", mov:", mov1, mov2, mov3, mov4, ", ints:", intM, intM2, intM3, ", acentos:", notaAcento, notaAcentoR, ", cons:", notaPrepara, notaInterrompe, notaResolve);
    if (mov1 == 0 && mov2 != 0 && intM < 3 &&
       (dur2 <= dur1*2 && dur2 <= dur4*2 && dur3 <= dur4) && // proporção entre as durações de dissonâncias e consonâncias
        (notaPrepara != "D" || tipo == "ch") && (notaResolve != "D" || tipo == "ch") // desenho melódico, intervalos e consonâncias em t.f.
        && p < x && r > i && i > x && (notaAcento == "F" || ((notaAcento == "f" && notaAcentoR == "c") || (notaAcento == "mF" && notaAcentoR == "f"))) && // dissonância métrica forte
        mov3 != mov4 && mov3 != 0 && mov4 != 0 && intM2 < 8 && intM3 < 8 && (!suspeLEx1a.checked || notaInterrompe != "D") && suspeLEx1.checked && // resolução interrompida
        (!suspeLEx3.checked || notaResolve == "CI" || tipo == "ch") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1 || tipo == "ch")) { // permitir também resolução ascendente
          if (tipo == "td") { var nome = "- Tratamento de dissonância: suspensão RI 4 notas -"; avalia += 0.5; } else
          if (tipo == "ch") { var nome = "- Coerência Harmônica: suspensão RI 4 notas -"; };
          if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n"; };
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == vozFin) { return x; };
   };
}
function suspensão5(x, tipo) { //console.log(x,"=============== função suspensão5 =============");
   if (x == 0) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x-1, i = x;
    while (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { // procura nota preparação
      var vIN = Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]);
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) {
      var vIT = vozesT[p].tonal[0] - vozesT[p].tonal[1]; } else { var vIT = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
      var notaPrepara = verificaConsonancia(vIN, vIT);
      var pos1 = vozesT[x].posição[voz];
      if (notaPrepara != "D") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozesT[x].nota[voz] == vozesT[i].nota[voz]) { // procura 1ª nota interrompe
      i++; if (i >= vozesT.length) { i = vozesT.length-1; break; }; };
     var i2 = i;
    while (vozesT[i].nota[voz] == vozesT[i2].nota[voz]) { // procura 2ª nota interrompe
       i2++; if (i2 >= vozesT.length) { i2 = vozesT.length-1; break; }; };
      var r = i2;
    while (vozesT[i2].nota[voz] == vozesT[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozesT.length-1) { r = vozesT.length-1; break; }; };
    if (!vozesT[r]) { return x; };
    vIN = Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]);
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) {
    var vIT = vozesT[p].tonal[0] - vozesT[p].tonal[1]; } else { var vIT = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    if (!notaPrepara) { var notaPrepara = verificaConsonancia(vIN, vIT); };
    vIN = Math.abs(vozesT[i].nota[0] - vozesT[i].nota[1]);
    if (vozesT[i].nota[0] >= vozesT[i].nota[1]) {
    var vIT = vozesT[i].tonal[0] - vozesT[i].tonal[1]; } else { var vIT = vozesT[i].tonal[1] - vozesT[i].tonal[0]; };
    var notaInterrompe = verificaConsonancia(vIN, vIT);
    vIN = Math.abs(vozesT[i2].nota[0] - vozesT[i2].nota[1]);
    if (vozesT[i2].nota[0] >= vozesT[i2].nota[1]) {
    var vIT = vozesT[i2].tonal[0] - vozesT[i2].tonal[1]; } else { var vIT = vozesT[i2].tonal[1] - vozesT[i2].tonal[0]; };
    var notaInterrompe2 = verificaConsonancia(vIN, vIT);
    vIN = Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) {
    vIT = vozesT[r].tonal[0] - vozesT[r].tonal[1]; } else { vIT = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };;
    var notaResolve = verificaConsonancia(vIN, vIT);
    var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var mov3 = direção(vozesT[i].nota[voz] - vozesT[x].nota[voz]);
    var mov4 = direção(vozesT[r].nota[voz] - vozesT[i].nota[voz]);
    var intM = Math.abs(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var intM2 = Math.abs(vozesT[i].nota[voz] - vozesT[x].nota[voz]);
    var intM3 = Math.abs(vozesT[r].nota[voz] - vozesT[i].nota[voz]);
    var intM4 = Math.abs(vozesT[i2].nota[voz] - vozesT[i].nota[voz]);
    var intM5 = Math.abs(vozesT[r].nota[voz] - vozesT[i2].nota[voz]);
    var dur1 = pos1 - vozesT[p].posição[voz];
    var dur2 = vozesT[i].posição[voz] - pos1;
    var dur3 = vozesT[i2].posição[voz] - vozesT[i].posição[voz];
    var dur4 = vozesT[r].posição[voz] - vozesT[i2].posição[voz];
    if (!vozesT[r+1]) { var dur5 = dur1; } else { var dur5 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };

    if (mov1 == 0 && mov2 != 0 && intM < 3 &&
       (dur2 <= dur1*2 && dur2 <= dur5*2 && dur3 <= dur5 && dur4 <= dur5) && // proporção entre as durações de dissonâncias e consonâncias
        (notaPrepara != "D" || tipo == "ch") && (notaResolve != "D" || tipo == "ch") // desenho melódico, intervalos e consonâncias em t.f.
        && p < x && r > i2 && i2 > i && i > x && (notaAcento == "F" || ((notaAcento == "f" && notaAcentoR == "c") || (notaAcento == "mF" && notaAcentoR == "f"))) && // dissonância métrica forte
        mov3 != mov4 && mov3 != 0 && mov4 != 0 && intM2 < 8 && intM3 < 8 && intM4 < 3 && intM5 < 3 &&
        (!suspeLEx1a.checked || notaInterrompe != "D" || tipo == "ch") && suspeLEx1.checked && // resolução interrompida
        (!suspeLEx3.checked || notaResolve == "CI" || tipo == "ch") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1 || tipo == "ch")) { // permitir também resolução ascendente
  //console.log(p,x,i,i2,r);
          if (tipo == "td") { var nome = "- Tratamento de dissonância: suspensão RI 5 notas -"; avalia += 0.5; } else
          if (tipo == "ch") { var nome = "- Coerência Harmônica: suspensão RI 5 notas -"; };
          if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == vozFin) { return x; };
   };
}
function cambiata(x, tipo) { //console.log(x,"=============== função cambiata =============");
   var diss1 = false, diss2 = false, diss3 = false;
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var np1 = x;
    while (vozesT[x].nota[voz] == vozesT[np1].nota[voz]) { // procura nota passagem 1
      np1++; if (np1 >= vozesT.length) { np1 = vozesT.length-1; break; }; };
     var np2 = np1;
    while (vozesT[np1].nota[voz] == vozesT[np2].nota[voz]) { // procura nota passagem 2
      np2++; if (np2 >= vozesT.length) { np2 = vozesT.length-1; break; }; };
     var np3 = np2;
    while (vozesT[np2].nota[voz] == vozesT[np3].nota[voz]) { // procura nota passagem 3
       np3++; if (np3 >= vozesT.length) { np3 = vozesT.length-1; break; }; };
     var r = np3;
    while (vozesT[np3].nota[voz] == vozesT[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozesT.length-1) { r = vozesT.length-1; break; }; };
    if (!vozesT[r]) { return x; };
    var vIN = Math.abs(vozesT[x].nota[0] - vozesT[x].nota[1]);
    if (vozesT[x].nota[0] >= vozesT[x].nota[1]) {
    var vIT = vozesT[x].tonal[0] - vozesT[x].tonal[1]; } else { var vIT = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
    var notaInicial = verificaConsonancia(vIN, vIT);
    vIN = Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) {
    vIT = vozesT[r].tonal[0] - vozesT[r].tonal[1]; } else { vIT = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
    var notaResolve = verificaConsonancia(vIN, vIT);
    var dCounter = 0; // contagem de dissonâncias
    if (verificaConsonancia(Math.abs(vozesT[np1].nota[0] - vozesT[np1].nota[1]),
                            (vozesT[np1].tonal[0] - vozesT[np1].tonal[1])) == "D") { dCounter++; diss1 = true; };
    if (verificaConsonancia(Math.abs(vozesT[np2].nota[0] - vozesT[np2].nota[1]),
                            (vozesT[np2].tonal[0] - vozesT[np2].tonal[1])) == "D") { dCounter++; diss2 = true; };
    if (verificaConsonancia(Math.abs(vozesT[np3].nota[0] - vozesT[np3].nota[1]),
                            (vozesT[np3].tonal[0] - vozesT[np3].tonal[1])) == "D") { dCounter++; diss3 = true; };
    var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]); // posição métrica das notasIguais
    var notaAcento1 = verificaTempoForte(vozesT[np1].tempo[voz],vozesT[np1].formula[0]);
    var notaAcento2 = verificaTempoForte(vozesT[np2].tempo[voz],vozesT[np2].formula[0]);
    var notaAcento3 = verificaTempoForte(vozesT[np3].tempo[voz],vozesT[np3].formula[0]);
    var notaAcentoR = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov0 = direção(vozesT[np1].nota[voz] - vozesT[x].nota[voz]);
    var mov1 = direção(vozesT[np2].nota[voz] - vozesT[np1].nota[voz]);
    var mov2 = direção(vozesT[np3].nota[voz] - vozesT[np2].nota[voz]);
    var mov3 = direção(vozesT[r].nota[voz] - vozesT[np3].nota[voz]);
    var mov4 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var dirCF = direção(vozesT[r].nota[vozCF] - vozesT[x].nota[vozCF]);
    var intM0 = Math.abs(vozesT[x].nota[voz] - vozesT[np1].nota[voz]);
    var intM1 = Math.abs(vozesT[np1].nota[voz] - vozesT[np2].nota[voz]);
    var intM2 = Math.abs(vozesT[np2].nota[voz] - vozesT[np3].nota[voz]);
    var intM3 = Math.abs(vozesT[np3].nota[voz] - vozesT[r].nota[voz]);
    var intM4 = Math.abs(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var dur1 = vozesT[np1].posição[voz] - vozesT[x].posição[voz];
    var dur2 = vozesT[np2].posição[voz] - vozesT[np1].posição[voz];
    var dur3 = vozesT[np3].posição[voz] - vozesT[np2].posição[voz];
    var dur4 = vozesT[r].posição[voz] - vozesT[np3].posição[voz];
    if (!vozesT[r+1]) { var dur5 = dur1; } else { var dur5 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
//console.log(x,np1,np2,np3,r,", mov:", mov0, mov1, mov2, mov3, mov4, ", ints:", intM0, intM1, intM2, intM3, intM4,", acentos:", notaAcento, notaAcento1, notaAcento2, notaAcento3, notaAcentoR, ", cons:", notaInicial, diss1, diss2, diss3, notaResolve);
    if (mov0 == mov1 && mov1 != 0 && mov2 == mov1*-1 && mov3 == mov2 && // contorno melódico
        intM0 < 3 && (intM1 == 3 || intM1 == 4) && intM2 < 3 && intM3 < 3 && // intervalos melódicos
        ((notaAcento == "F" || (cambiLEx1MF.checked && notaAcento == "mF")) &&
         (notaAcentoR == "F" || (cambiLEx1MF.checked && notaAcentoR == "mF")) || !cambiLEx1.checked) && // posição métrica 1ª e última nota
        (((!diss1 || (notaAcento1 != "F" && (cambiLEx3MF.checked || notaAcento1 != "mF"))) &&
          (!diss2 || (notaAcento2 != "F" && (cambiLEx3MF.checked || notaAcento2 != "mF")) ) && // dissonancia em tempo fraco
          (!diss3 || (notaAcento3 != "F" && (cambiLEx3MF.checked || notaAcento3 != "mF")))) || !cambiLEx3.checked) &&
        (diss1 || !cambiLEx4.checked || tipo == "ch") && // 2ª nota deve ser dissonante
        ((vozesT[np1].duração[voz] <= vozesT[x].duração[voz] && vozesT[np1].duração[voz] <= vozesT[r].duração[voz]) || !cambiLEx5.checked) && // duração 2ª nota < 1ª e última
        (dirCF == mov4 || !cambiLEx2.checked) && // cambiata na mesma direção do CF
        dCounter < 3 && // quantidade de dissonâncias
        notaInicial != "D" && notaResolve != "D" && // consonâncias
        (dur2 <= dur1*2.1 && dur3 <= dur1*2.1 && dur4 <= dur1*2.1 && dur5 <= dur1*2.1) // proporção entre as durações de dissonâncias e consonâncias
      ) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: cambiata -"; avalia += 0.5; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: cambiata -"; };
          if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n"; };
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == vozFin) { return x; };
   };
}
function bordadura(x, tipo) { //console.log(x,"=============== função bordadura =============");
   if (x == 0) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x, r = x; // preparação, resolução
    while (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { // procura nota preparação
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
        else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
      var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
      if (notaPrepara != "D") { break; };
      var pos1 = vozesT[p].posição[voz];
      p--; if (p < 0) { p++; break; }; };
    while (vozesT[x].nota[voz] == vozesT[r].nota[voz]) { r++; if (r >= vozesT.length-1) { break; }; }; // procura nota posterior
    if (!vozesT[r]) { return x; };
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
      else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
      else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
    var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);
    var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var intM1 = Math.abs(vozesT[p].nota[voz] - vozesT[x].nota[voz]);
    var intM2 = Math.abs(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var dur1 = pos1 - vozesT[p].posição[voz];
    var dur2 = vozesT[r].posição[voz] - pos1;
    if (!vozesT[r+1]) { var dur3 = dur1; } else { var dur3 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
    if (mov1 != 0 && mov1 == mov2*-1 && intM1 < 3 && intM2 < 3 &&
       (dur2 < dur1*2.1 && dur2 < dur3*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (notaPrepara != "D" || tipo == "ch") && (notaResolve != "D" || tipo == "ch")
        && p < x && r > x && ((notaAcento != "F" && (bordaLExMF.checked || notaAcento != "mF")) || !bordaLEx.checked) &&
        ((mov1 > 0 && bordaduraLS.checked) || (mov1 < 0 && bordaduraLI.checked) || tipo == "ch")) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Bordadura -"; avalia += 0.3; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Bordadura -"; };
          if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };

      } else if (voz == vozFin) { return x; };
   };
}
function bordadura4(x, tipo) { //console.log(x,"=============== função bordadura4 =============");
   if (x == 0 || x+2 >= vozesT.length) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x-1, r = x+2; // preparação, resolução
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
      else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
    if (vozesT[x].nota[0] >= vozesT[x].nota[1]) { var ib1Tonal = vozesT[x].tonal[0] - vozesT[x].tonal[1]; }
      else { var ib1Tonal = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
    var notaBorda1 = verificaConsonancia(Math.abs(vozesT[x].nota[0] - vozesT[x].nota[1]), ib1Tonal);
    if (vozesT[x+1].nota[0] >= vozesT[x+1].nota[1]) { var ib2Tonal = vozesT[x+1].tonal[0] - vozesT[x+1].tonal[1]; }
      else { var ib2Tonal = vozesT[x+1].tonal[1] - vozesT[x+1].tonal[0]; };
    var notaBorda2 = verificaConsonancia(Math.abs(vozesT[x+1].nota[0] - vozesT[x+1].nota[1]), ib2Tonal);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
      else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
    var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);
    var notaAcento0 = verificaTempoForte(vozesT[p].tempo[voz],vozesT[p].formula[0]);
    var notaAcento1 = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var notaAcento2 = verificaTempoForte(vozesT[x+1].tempo[voz],vozesT[x+1].formula[0]);
    var notaAcento3 = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[x+1].nota[voz] - vozesT[x].nota[voz]);
    var mov3 = direção(vozesT[r].nota[voz] - vozesT[x+1].nota[voz]);
    var intM1 = Math.abs(vozesT[p].nota[voz] - vozesT[x].nota[voz]);
    var intM2 = Math.abs(vozesT[x+1].nota[voz] - vozesT[x].nota[voz]);
    var intM3 = Math.abs(vozesT[r].nota[voz] - vozesT[x+1].nota[voz]);
    var dur1 = vozesT[x].posição[voz] - vozesT[p].posição[voz];
    var dur2 = vozesT[x+1].posição[voz] - vozesT[x].posição[voz];
    var dur3 = vozesT[r].posição[voz] - vozesT[x+1].posição[voz];
    if (!vozesT[r+1]) { var dur4 = dur1; } else { var dur4 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
//console.log(x,")", vozesT[p].nota[voz], vozesT[x].nota[voz], vozesT[x+1].nota[voz],vozesT[r].nota[voz], "|",
            // notaPrepara, notaBorda1, notaBorda2, notaResolve, "|", notaAcento1, notaAcento2, "|", mov1, mov2, mov3, "|", intM1, intM2, intM3);
    if (mov1 != 0 && mov1 == mov2*-1 && mov3 == mov1 &&
        (dur2 < dur1*2.1 && dur2 < dur4*2.1 && dur3 < dur4*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        intM1 < 3 && intM3 < 3 && (intM2 == 3 || intM2 == 4) &&
        (notaBorda1 == "D" || notaBorda2 == "D" || tipo == "ch") &&
        notaPrepara != "D" && notaResolve != "D" && p < x && r > x+1 &&
        //(((notaAcento0 != "F" || notaAcento0 != "mF") && (notaAcento3 != "F" || notaAcento3 != "mF")) || !bordaLEx2.checked || tipo == "ch") && // notas principais em tempo forte
        ((notaAcento1 != "F" && notaAcento2 != "F") || !bordaLEx1.checked || tipo == "ch")) { // em tempo fraco e meio forte
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Bordadura dupla -"; avalia += 0.5; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Bordadura dupla -"; };
        if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";; };
          if (r-1 == x) { return r; } else { return r-1; };

      } else if (voz == vozFin) { return x; };
   };
}
function notaPassagem(x, tipo) { //console.log(x,"=============== função NP =============", tipo);
   if (x == 0) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x, r = x;
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
      else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    while (vozesT[x].nota[voz] == vozesT[p].nota[voz] || // procura nota preparação
           verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal) == "D")  {
      if (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { var pos1 = vozesT[p].posição[voz] };
      if (p <= 0) { break; }; p--;
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
        else { ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    };  //console.log("preparação:", p, vozesT[p].nota[voz]);
    while (vozesT[x].nota[voz] == vozesT[r].nota[voz]) { r++; if (r >= vozesT.length-1) { break; }; }; // procura nota posterior
    if (!vozesT[r]) { return x; };
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
      else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
      else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
    var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);
    //console.log("notaPrepara:", notaPrepara, " - notaResolve:", notaResolve)
    var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var intM1 = Math.abs(vozesT[p].nota[voz] - vozesT[x].nota[voz]);
    var intM2 = Math.abs(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var intMT1 = Math.abs(parseInt(verificaGrauMelodico(vozesT[x].tonal[voz], x)) - parseInt(verificaGrauMelodico(vozesT[p].tonal[voz], p)));
    var intMT2 = Math.abs(parseInt(verificaGrauMelodico(vozesT[x].tonal[voz], x)) - parseInt(verificaGrauMelodico(vozesT[r].tonal[voz], r)));
    if (intMT1 == 6) { intMT1 = 1; };
    if (intMT2 == 6) { intMT2 = 1; };
    //console.log(p, x, r, verificaGrauMelodico(vozesT[x].tonal[voz], x), verificaGrauMelodico(vozesT[r].tonal[voz], r), intMT1, intMT2);
    var dur1 = pos1 - vozesT[p].posição[voz];
    var dur2 = vozesT[r].posição[voz] - pos1;
    if (!vozesT[r+1]) { var dur3 = dur1; } else { var dur3 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
    //console.log(p,x,r,"NP:", notaPrepara, notaResolve, notaAcento, mov1, mov2, intM1, intM2, intMT1, intMT2, dur1, dur2, dur3, passaLExMF.checked);
    if (mov1 == mov2 && mov1 != 0 && ((intM1 < 4 && intMT1 == 1) || intM1 < 3) && ((intM2 < 4 && intMT2 == 1) || intM2 < 3) &&// contorno melódico e graus conjuntos
       (dur2 < dur1*2.1 && dur2 <= dur3*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (notaPrepara != "D" || tipo == "ch") && (notaResolve != "D" || tipo == "ch") // prepara e resolve em consonâncias
        && p < x && r > x && ((notaAcento != "F" && (passaLExMF.checked || notaAcento != "mF")) || !passaLEx.checked || tipo == "ch")) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Nota de passagem -";
                            if (terEsp || quiEsp || livreCP) { avalia += 0.2; } else { avalia += 0.3;}; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Nota de passagem -"; };
          if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == vozFin) { return x; };
   };
}
function notaPassagem4(x, tipo) { //console.log(x,"=============== função NP4 =============");
   if (!passaLEx2.checked) { return x; };
   if (x == 0 || x+2 >= vozesT.length) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x, np1 = x, r; // preparação, resolução
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
      else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    while (vozesT[x].nota[voz] == vozesT[p].nota[voz] ||
           verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal) == "D")  { // procura nota preparação
      if (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { var pos1 = vozesT[p].posição[voz] };
      if (p <= 0) { break; }; p--;
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
        else { ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    }; //console.log("a:", p, vozesT[p].nota[voz]);
    while (vozesT[x].nota[voz] == vozesT[np1].nota[voz]) { // procura nota posterior
        np1++; if (np1 >= vozesT.length-1) { break; }; }; if (!vozesT[np1]) { return x; }; r = np1;
    while (vozesT[np1].nota[voz] == vozesT[r].nota[voz]) { // procura nota posterior
        r++; if (r >= vozesT.length-1) { break; }; }; if (!vozesT[r]) { return x; };
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
      else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
    if (vozesT[x].nota[0] >= vozesT[x].nota[1]) { var ixTonal = vozesT[x].tonal[0] - vozesT[x].tonal[1]; }
      else { var ixTonal = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
    var notaPassa1 = verificaConsonancia(Math.abs(vozesT[x].nota[0] - vozesT[x].nota[1]), ixTonal);
    if (vozesT[np1].nota[0] >= vozesT[np1].nota[1]) { var inpTonal = vozesT[np1].tonal[0] - vozesT[np1].tonal[1]; }
      else { var inpTonal = vozesT[np1].tonal[1] - vozesT[np1].tonal[0]; };
    var notaPassa2 = verificaConsonancia(Math.abs(vozesT[np1].nota[0] - vozesT[np1].nota[1]), inpTonal);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
      else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
    var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);
    var notaAcento0 = verificaTempoForte(vozesT[p].tempo[voz],vozesT[p].formula[0]);
    var notaAcento1 = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var notaAcento2 = verificaTempoForte(vozesT[np1].tempo[voz],vozesT[np1].formula[0]);
    var notaAcento3 = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[np1].nota[voz] - vozesT[x].nota[voz]);
    var mov3 = direção(vozesT[r].nota[voz] - vozesT[np1].nota[voz]);
    var intM1 = Math.abs(vozesT[p].nota[voz] - vozesT[x].nota[voz]);
    var intM2 = Math.abs(vozesT[np1].nota[voz] - vozesT[x].nota[voz]);
    var intM3 = Math.abs(vozesT[r].nota[voz] - vozesT[np1].nota[voz]);
    var dur1 = pos1 - vozesT[p].posição[voz];
    var dur2 = vozesT[np1].posição[voz] - pos1;
    var dur3 = vozesT[r].posição[voz] - vozesT[np1].posição[voz];
    if (!vozesT[r+1]) { var dur4 = dur1; } else { var dur4 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
//console.log(x,")", vozesT[p].nota[voz], vozesT[x].nota[voz], vozesT[x+1].nota[voz],vozesT[r].nota[voz], "|",
          //   notaPrepara, notaPassa1, notaPassa2, notaResolve, "|", notaAcento1, notaAcento2, "|", mov1, mov2, mov3, "|", intM1, intM2, intM3);
    if (mov1 != 0 && mov1 == mov2 && mov3 == mov1 &&
        (dur2 <= dur1*2.1 && dur2 <= dur4*2.1 && dur3 <= dur4*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        intM1 < 3 && intM3 < 3 && intM2 < 3 &&
        ((notaPassa1 == "D" && notaPassa2 == "D") || tipo == "ch") &&
        notaPrepara != "D" && notaResolve != "D" && p < x && r > np1 &&
        (((notaAcento1 != "F" && (passaLExMF.checked || notaAcento1 != "mF")) && (notaAcento2 != "F" && (passaLExMF.checked || notaAcento2 != "mF"))) || !passaLEx.checked || tipo == "ch")) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: NP grupo 2 -"; avalia += 0.4; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: NP grupo 2 -"; };
        if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";; };
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == vozFin) { return x; };
   };
}
function notaPassagem5(x, tipo) { //console.log(x,"=============== função NP5 =============");
   if (!passaLEx2.checked) { return x; };
   if (x == 0 || x+3 >= vozesT.length) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
     var p = x, np1 = x, np2, r; // preparação, resolução
     while (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { // procura nota preparação
       if (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { var pos1 = vozesT[p].posição[voz] };
       p--; if (p < 0) { break; }; };
       p++; if (p == x) { p--; }; //console.log("a:", p, vozesT[p].nota[voz]);
     while (vozesT[x].nota[voz] == vozesT[np1].nota[voz]) { // procura nota posterior
       if (vozesT[np1].nota[0] >= vozesT[np1].nota[1]) { var ipTonal = vozesT[np1].tonal[0] - vozesT[np1].tonal[1]; }
         else { var ipTonal = vozesT[np1].tonal[1] - vozesT[np1].tonal[0]; };
         if (verificaConsonancia(Math.abs(vozesT[np1].nota[0] - vozesT[np1].nota[1]), ipTonal) != "D") { break; };
         np1++; if (np1 >= vozesT.length-1) { break; }; }; if (!vozesT[np1]) { return x; }; np2 = np1;
     while (vozesT[np1].nota[voz] == vozesT[np2].nota[voz]) { // procura nota posterior
       if (vozesT[np2].nota[0] >= vozesT[np2].nota[1]) { var ipTonal = vozesT[np2].tonal[0] - vozesT[np2].tonal[1]; }
         else { var ipTonal = vozesT[np2].tonal[1] - vozesT[np2].tonal[0]; };
         if (verificaConsonancia(Math.abs(vozesT[np2].nota[0] - vozesT[np2].nota[1]), ipTonal) != "D") { break; };
         np2++; if (np2 >= vozesT.length-1) { break; }; }; if (!vozesT[np2]) { return x; }; r = np2;
     while (vozesT[np2].nota[voz] == vozesT[r].nota[voz]) { // procura nota posterior
       if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
         else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
         if (verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal) != "D") { break; };
         r++; if (r >= vozesT.length-1) { break; }; }; if (!vozesT[r]) { return x; };
     if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
       else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
     var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
     if (vozesT[x].nota[0] >= vozesT[x].nota[1]) { var ixTonal = vozesT[x].tonal[0] - vozesT[x].tonal[1]; }
       else { var ixTonal = vozesT[x].tonal[1] - vozesT[x].tonal[0]; };
     var notaPassa1 = verificaConsonancia(Math.abs(vozesT[x].nota[0] - vozesT[x].nota[1]), ixTonal);
     if (vozesT[np1].nota[0] >= vozesT[np1].nota[1]) { var inpTonal = vozesT[np1].tonal[0] - vozesT[np1].tonal[1]; }
       else { var inpTonal = vozesT[np1].tonal[1] - vozesT[np1].tonal[0]; };
     var notaPassa2 = verificaConsonancia(Math.abs(vozesT[np1].nota[0] - vozesT[np1].nota[1]), inpTonal);
     if (vozesT[np2].nota[0] >= vozesT[np2].nota[1]) { var inp2Tonal = vozesT[np2].tonal[0] - vozesT[np2].tonal[1]; }
       else { var inp2Tonal = vozesT[np2].tonal[1] - vozesT[np2].tonal[0]; };
     var notaPassa3 = verificaConsonancia(Math.abs(vozesT[np2].nota[0] - vozesT[np2].nota[1]), inp2Tonal);
     if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
       else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
     var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);

    var notaAcento0 = verificaTempoForte(vozesT[p].tempo[voz],vozesT[p].formula[0]);
    var notaAcento1 = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var notaAcento2 = verificaTempoForte(vozesT[np1].tempo[voz],vozesT[np1].formula[0]);
    var notaAcento3 = verificaTempoForte(vozesT[np2].tempo[voz],vozesT[np2].formula[0]);
    var notaAcento4 = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[np1].nota[voz] - vozesT[x].nota[voz]);
    var mov3 = direção(vozesT[np2].nota[voz] - vozesT[np1].nota[voz]);
    var mov4 = direção(vozesT[r].nota[voz] - vozesT[np2].nota[voz]);
    var intM1 = Math.abs(vozesT[p].nota[voz] - vozesT[x].nota[voz]);
    var intM2 = Math.abs(vozesT[np1].nota[voz] - vozesT[x].nota[voz]);
    var intM3 = Math.abs(vozesT[np2].nota[voz] - vozesT[np1].nota[voz]);
    var intM4 = Math.abs(vozesT[r].nota[voz] - vozesT[np2].nota[voz]);
    var dur1 = pos1 - vozesT[p].posição[voz];
    var dur2 = vozesT[np1].posição[voz] - pos1;
    var dur3 = vozesT[np2].posição[voz] - vozesT[np1].posição[voz];
    var dur4 = vozesT[r].posição[voz] - vozesT[np2].posição[voz];
    if (!vozesT[r+1]) { var dur5 = dur1; } else { var dur5 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
//console.log(x,")", vozesT[p].nota[voz], vozesT[x].nota[voz], vozesT[np1].nota[voz],vozesT[r].nota[voz], "|",
             //notaPrepara, notaPassa1, notaPassa2, notaResolve, "|", notaAcento1, notaAcento2, "|", mov1, mov2, mov3, "|", intM1, intM2, intM3);
    if (mov1 != 0 && mov1 == mov2 && mov3 == mov1 && mov4 == mov1 &&
        (dur2 <= dur1*2.1 && dur2 <= dur5*2.1 && dur3 <= dur1*2.1 && dur3 <= dur5*2.1
         && dur4 <= dur1*2.1 && dur4 <= dur5*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        intM1 < 3 && intM3 < 3 && intM2 < 3 && intM3 < 3 &&
        ((notaPassa1 == "D" && notaPassa2 == "D" && notaPassa3 == "D") || tipo == "ch") &&
        notaPrepara != "D" && notaResolve != "D" && p < x && r > np1 &&
        (((notaAcento1 != "F" && (passaLExMF.checked || notaAcento1 != "mF")) &&
          (notaAcento2 != "F" && (passaLExMF.checked || notaAcento2 != "mF")) &&
          (notaAcento3 != "F" && (passaLExMF.checked || notaAcento3 != "mF"))) || !passaLEx.checked || tipo == "ch")) {
      // var testaVozMove = true;
      // if (testaVozMove) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: NP grupo 3 -"; avalia += 0.4; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: NP grupo 3 -"; };
        if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";; };
          if (r-1 == x) { return r; } else { return r-1; };
        //} else { return x-1; };
      } else if (voz == vozFin) { return x; };
   };
}
function apojatura(x, tipo) { //console.log(x,"=============== função apojatura =============");
   if (x == 0) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x-1, r = x+1;
    if (!vozesT[r]) { return x; };
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
      else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
      else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
    var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);
    var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var intM1 = Math.abs(vozesT[p].nota[voz] - vozesT[x].nota[voz]);
    var intM2 = Math.abs(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var dur1 = vozesT[x].posição[voz] - vozesT[p].posição[voz];
    var dur2 = vozesT[r].posição[voz] - vozesT[x].posição[voz];
    if (!vozesT[r+1]) { var dur3 = dur1; } else { var dur3 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
    if ((notaResolve != "D" || tipo == "ch") && (notaPrepara != "D" || tipo == "ch" || !apojaEx5.checked) && // verifica preparação e resolução
        p < x && r > x && intM1 > 2 && intM2 < 3 && // verifica intervalos melódicos
        (dur2 <= dur1*2.1 && dur2 <= dur3*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (mov1 != 0 && (!apojaEx2.checked || mov1 == 1)) &&  // preparação ascendente
        (mov2 != 0 && (!apojaEx3.checked || mov2 == -1)) && // resolução descendente
        ((mov1 != 0 && mov2 != 0) && (!apojaEx4.checked || mov1 != mov2)) &&  // resolução por direção contrária
        (!apojaEx1.checked || (notaAcento == "F" || (apojaEx1MF.checked && notaAcento == "mF") || // posição métrica
        (notaAcento == "f" && notaAcentoR == "c")) || tipo == "ch")) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Apojatura -"; avalia += 0.3; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Apojatura -"; };
          if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == vozFin) { return x; };
   };
}
function antecipação(x, tipo) { //console.log(x,"=============== função antecipação =============");
   if (x == 0) { return x; };
   var vozFin, vozIni;
   if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
   for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var r = x+1;
    if (!vozesT[r]) { return x; };
    // while (vozesT[x].nota[voz] == vozesT[r].nota[voz] && vozesT[r].ligadura[voz]) {
    //   r++; if (r >= vozesT.length-1) { break; }; }; // procura nota posterior
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
      else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
    var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);
    var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
    var int1 = vozesT[x].nota[voz] - vozesT[x-1].nota[voz];
    var dur1 = vozesT[r].posição[voz] - vozesT[x].posição[voz];
    if (!vozesT[r+1]) { var dur2 = dur1; } else { var dur2 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
    if (mov1 == 0 && (notaResolve != "D" || tipo == "ch") && r > x &&
        (dur1 <= dur2*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (notaAcentoR == "F" || ((notaAcentoR == "f" || notaAcentoR == "mF") && notaAcento == "c") || tipo == "ch") &&
        ((antecipaEx2.checked && antecipaEx3.checked && ((int1 > -3 && int1 < 0) || (int1 < 3 && int1 > 0))) ||
            (antecipaEx2.checked && !antecipaEx3.checked && (int1 > -3 && int1 < 0)) ||
            (!antecipaEx2.checked && antecipaEx3.checked && (int1 < 3 && int1 > 0)) ||
            (!antecipaEx2.checked && !antecipaEx3.checked)) &&
        (!antecipaEx4.checked || r == vozesT.length-1 || tipo == "ch")) {
      // var testaVozMove = true;
      // for (var d = x+1; d < r; d++) {
      //   var vozmove1 = verificaConsonancia(Math.abs(vozesT[d].nota[0] - vozesT[d].nota[1]),
      //                                      Math.abs(vozesT[d].tonal[0] - vozesT[d].tonal[1]));
      //   if (vozmove1 == "D") {
      //     var voz2 = 1 - voz;
      //     var vozmove2 = verificaConsonancia(Math.abs(vozesT[d].nota[voz2] - vozesT[r].nota[voz]),
      //                                        Math.abs(vozesT[d].tonal[voz2] - vozesT[r].tonal[voz]));
      //     if (vozmove2 == "D") { testaVozMove = false; };
      //   };
      // };
      // if (testaVozMove) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Antecipação -"; avalia += 0.2; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Antecipação -"; };
          if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };
      //  } else { return x; };
      } else if (voz == vozFin) { return x; };
   };
}
function escapada(x, tipo){ //console.log(x,"=============== função escapada =============");
    if (x == 0) { return x; };
    var vozFin, vozIni;
    if (!livreCP) {
     if (vozCF == vS) { vozIni = 1; vozFin = 1; } else
     if (vozCF == vI) { vozIni = 0; vozFin = 0; } else { vozIni = 0; vozFin = 1; };
   } else { vozIni = 0; vozFin = 1; };
    for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
     var p = x-1, r = x+1;
     if (!vozesT[r]) { return x; };
     if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
       else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
     var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
     if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
       else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
     var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);
     var notaAcentoP = verificaTempoForte(vozesT[p].tempo[voz],vozesT[p].formula[0]);
     var notaAcento = verificaTempoForte(vozesT[x].tempo[voz],vozesT[x].formula[0]);
     var notaAcentoR = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
     var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
     var mov2 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
     var intM1 = Math.abs(vozesT[p].nota[voz] - vozesT[x].nota[voz]);
     var intM2 = Math.abs(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
     var dur1 = vozesT[x].posição[voz] - vozesT[p].posição[voz];
     var dur2 = vozesT[r].posição[voz] - vozesT[x].posição[voz];
     if (!vozesT[r+1]) { var dur3 = dur1; } else { var dur3 = vozesT[r+1].posição[voz] - vozesT[r].posição[voz]; };
 //console.log(x,")");
     if (p < x && r > x && intM1 < 3 && intM2 > 2 &&
        (dur2 < dur1*2.1 && dur2 < dur3*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (notaResolve != "D" || tipo == "ch") &&  (notaPrepara != "D" || tipo == "ch") &&
         mov1 != 0 &&  (mov2 != 0 && mov2 != mov1) && notaAcentoR != "c" && notaAcentoP != "c" &&
         (!escapaEx1.checked || (escapaEx1MF.checked && notaAcento == "mF") || (notaAcento == "f" || notaAcento == "c"))) {
       // var testaVozMove = true;
       // for (var d = x+1; d < r; d++) {
       //   var vozmove1 = verificaConsonancia(Math.abs(vozesT[d].nota[0] - vozesT[d].nota[1]),
       //                                      Math.abs(vozesT[d].tonal[0] - vozesT[d].tonal[1]));
       //   if (vozmove1 == "D") {
       //     var voz2 = 1 - voz;
       //     var vozmove2 = verificaConsonancia(Math.abs(vozesT[d].nota[voz2] - vozesT[r].nota[voz]),
       //                                        Math.abs(vozesT[d].tonal[voz2] - vozesT[r].tonal[voz]));
       //     if (vozmove2 == "D") { testaVozMove = false; };
       //   };
       // };
       // if (testaVozMove) {
         if (tipo == "td") { var nome = "- Tratamento de dissonância: Escapada -"; avalia += 0.2; } else
         if (tipo == "ch") { var nome = "- Coerência Harmônica: Escapada -"; };
           if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";};
           if (r-1 == x) { return r; } else { return r-1; };
         //} else { return x; };
       } else if (voz == vozFin) { return x; };
    };
}
function notaPedal(x, tipo) { //console.log(x,"=============== função nota pedal =============");
  if (x == 0) { return x; };
  var vozFin, vozIni;
  //if (!livreCP) { vozIni = 1-vozCF; vozFin = 1-vozCF; }
           //else {
             vozIni = 0; vozFin = 1; //};
  for (var voz = vozIni; voz <= vozFin; voz++) { // percorre vozesT
    var p = x, r = x;
    while (vozesT[x].nota[voz] == vozesT[p].nota[voz]) { // procura nota preparação
      p--; if (p < 0) { break; }; };
      p++; if (p == x) { p--; }; //console.log("a:", p, vozesT[p].nota[voz]);
    while (vozesT[p].nota[voz] == vozesT[x].nota[voz] && p < x ) {
      if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
        else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
      if (verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal) == "D") { p++; } else { break; };
    }; //console.log("b:", p, vozesT[p].nota[voz]);
    while (vozesT[x].nota[voz] == vozesT[r].nota[voz]) { // procura nota posterior
      if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
        else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
      if (verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal) != "D") { break; };
      r++; if (r >= vozesT.length-1) { break; }; };
    if (!vozesT[r]) { return x; };
  //console.log("intervalos em p e r:", Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]));
    if (vozesT[p].nota[0] >= vozesT[p].nota[1]) { var ipTonal = vozesT[p].tonal[0] - vozesT[p].tonal[1]; }
      else { var ipTonal = vozesT[p].tonal[1] - vozesT[p].tonal[0]; };
    var notaPrepara = verificaConsonancia(Math.abs(vozesT[p].nota[0] - vozesT[p].nota[1]), ipTonal);
    if (vozesT[r].nota[0] >= vozesT[r].nota[1]) { var irTonal = vozesT[r].tonal[0] - vozesT[r].tonal[1]; }
      else { var irTonal = vozesT[r].tonal[1] - vozesT[r].tonal[0]; };
    var notaResolve = verificaConsonancia(Math.abs(vozesT[r].nota[0] - vozesT[r].nota[1]), irTonal);
    var metrPrepara = verificaTempoForte(vozesT[p].tempo[voz],vozesT[p].formula[0]);
    var metrResolve = verificaTempoForte(vozesT[r].tempo[voz],vozesT[r].formula[0]);
    var mov1 = direção(vozesT[x].nota[voz] - vozesT[p].nota[voz]);
    var mov2 = direção(vozesT[r].nota[voz] - vozesT[x].nota[voz]);
//console.log("voz",voz, "|", p, x, r,") notas:", vozesT[p].nota[voz], vozesT[x].nota[voz], vozesT[r].nota[voz],
      //        "| mov:", mov1, mov2, "| metro:", metrPrepara, metrResolve, pedalEx1MF.checked,
      //        "| cons:", notaPrepara, notaResolve);
    if (mov1 == 0 && mov2 == 0 &&  // desenho melódico
        (notaResolve != "D" || tipo == "ch") && (notaPrepara != "D" || tipo == "ch") // consonâncias
        && p < x && r > x &&
        (((metrPrepara == "F" || (pedalEx1MF.checked && metrPrepara == "mF")) &&
          (metrResolve == "F" || (pedalEx1MF.checked && metrResolve == "mF"))) || !pedalEx1.checked)) { // dissonância métrica forte
        if (tipo == "td") { var nome = "- Tratamento de dissonância: nota pedal -"; avalia += 0.2; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: nota pedal -"; }
          if (tipo) { relator += nome + " Comp. " + vozesT[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r; };
    } else if (voz == vozFin) { return x; };
  };
}

//------------------------------------------------------------------------------
function criaResultado(verificados, x, voz, i, tipo, numAcordes, numVozes) {
   var vozesR = [];
   if (vozesT.length >= 1) { //console.log("=== vozesT ===");
     vozesR = vozesT; voz = vS; i = vI; }
     else { //console.log("=== vozes ===");
       vozesR = vozes; };
       //console.log("x:", x, "voz1:", voz, "voz2:", i, "tipo:", tipo, "qtdAcordes:", numAcordes, "qtdVozes:", numVozes);
   var primAcorde = x - (numAcordes-1);
   var compAnt = Math.floor(vozesR[primAcorde].compasso);
   var compAtual = Math.floor(vozesR[x].compasso);
   var qtdVozes = vozesR[x].nota.length;
   var compInicial = Math.floor(vozesR[0].compasso);
   if (compAnt != compAtual && numAcordes > 1) { var compasso = (compAnt - compInicial + 1) + " ao " + (compAtual - compInicial + 1);}
                                                        else { var compasso = (compAtual - compInicial + 1); };
   switch (numVozes) {   // cria mensagem de texto
     case "ne":
     case 1: var qualVoz = ", na voz "+ (voz+1); break;
     case "fr": //falsa relação
     case "in": //intermitente
     case "semComp":
     case 2: var qualVoz = ", vozes "+(voz+1)+" e "+(i+1); break;
     case "null":
     case qtdVozes: var qualVoz = ""; break;
   };
   if (numVozes == "semComp") { var texto = verificados + ") " + tipo + qualVoz; } else {
                    var texto = verificados + ") " + tipo + ": compasso " + compasso + qualVoz; }
   resultado[verificados] = [texto];
   //console.log("resultado:", resultado[verificados])
   for (var y=primAcorde;y<=x;y++) {  // cria array de objetos para colorir
     //console.log("=== objetos:", vozesR[y].objeto[0], vozesR[y].objeto[1])
    switch (numVozes) {
        case 1: resultado[verificados].push(vozesR[y].objeto[voz]); break;
        case "semComp":
        case 2: resultado[verificados].push(vozesR[y].objeto[0], vozesR[y].objeto[1]); break;
        case "null":
        case qtdVozes: for (var k=0;k<qtdVozes;k++) {
                              resultado[verificados].push(vozesR[y].objeto[k]);
                        }; break;
        case "fr": if (y == primAcorde) { resultado[verificados].push(vozesR[y].objeto[0]); }
                        else { resultado[verificados].push(vozesR[y].objeto[1]); }; break;
        case "ne":
          if (y == primAcorde || y == x) { resultado[verificados].push(vozesR[y].objeto[0]); }; break;
        case "in":
          if (y == primAcorde || y == x) { resultado[verificados].push(vozesR[y].objeto[0], vozesR[y].objeto[1]); }; break;
      };
    };
    //console.log(">>> resultado:", resultado[verificados])

if (tipo == "não conduz para finalis por grau conj." || // melodia
    tipo == "penúltima nota não pertence ao V ou viiº" ||
    tipo == "Âmbito melódico" ||
    tipo.substring(0, 14) == "Não privilegia" ||
    tipo == "intervalo melódico de 7ª" ||
    tipo == "intervalo melódico de 6ª" ||
    tipo == "intervalo melódico aumentado" ||
    tipo == "intervalo melódico > 8ª" ||
    tipo == "trítono nas 2 extremidades" ||
    tipo == "trítono em 1 extremidade" ||
    tipo == "dissonância composta" ||
    tipo == "intervalo melódico > 5ªJ" ||
    tipo == "movimentos na mesma direção" ||
    tipo == "repetição de notas" ||
    tipo == "repetição de padrão mel." ||
    tipo == "arpejo de acorde" ||
    tipo == "repete ponto focal superior" ||
    //tipo == "repete ponto focal inferior" ||
    tipo == "alteração 6º e/ou 7º" ||
    tipo == "neutralização 6º e/ou 7º" ||
    tipo.substring(0, 12) == "Nota inicial" ||
    tipo.substring(0, 10) == "Nota final" ||
    tipo == "2 saltos na mesma direção" ||
    tipo == "2 saltos em mov. contrário" ||
    tipo.slice(0, 14) == "salto de tempo" ||
    tipo == "intervalo inicial" || // Gerais ----------
    tipo == "intervalo final" ||
    tipo == "alcança intervalo final" ||
    tipo.slice(0, 8) == "cadência" ||
    tipo.substring(0, 12) == "cons. imperf" ||
    tipo.slice(0, 9) == "distância" ||
    tipo == "5ª ou 8ª consecutivas" ||
    tipo == "uníssono" ||
  //  tipo == "cruzamento" ||
    tipo == "falsa relação") { avalia -= 1; } else
if (tipo.slice(-6) == "oculta" ||
    tipo.slice(-12) == "intermitente") { avalia -= 2; } else
if (tipo.slice(-8) == "paralela" ||
    tipo == "nota não pertence ao acorde" ||
    tipo.slice(-11) == "fundamental") { avalia -= 3; } else
if (tipo == "dissonância não tratada") { avalia -= 5; };
//console.log(x,"avalia = ", avalia);
 }
//---------------------------------------------------------

  onRun: {

  //openFile('config.cfA');

  //inicializaVariáveis();
  //carregarCfg();
  function inicializaVariáveis() {
   var preSet = "false-false-false-false-false-false-false-false-false-false-1-false-1-false-1-false-4-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-0-false-false-false-true-false-false-false-false-false-false-false-false-false-false-true-false-0-8-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-false-true-true-true-12-true-true-true-false-false-true-true-true-false-false-true-false-true-true-true-false-false-true-true-true-true-3-true-0-false-false-0-false-2-true-true-false-false-true-true-4-true-false-false-true-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-false-true-1-true-1-true-4-true-4-true-true-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-true-true-3-false-false-true-0-true-false-false-true-true-true-true-true-true-0-15-true-true-false-false-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-16-true-true-true-false-false-true-true-true-false-false-true-false-true-true-true-false-false-true-true-true-true-4-true-0-true-true-0-true-3-true-true-false-false-true-true-4-true-true-true-true-true-true-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-false-true-1-true-1-true-3-true-3-true-true-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-true-true-3-false-false-true-0-true-true-true-true-true-true-true-true-true-0-15-true-true-true-true-true-true-true-true-true-true-true-true-false-true-true-false-false-false-true-false-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-18-true-true-true-false-false-true-true-true-false-false-true-false-true-true-true-false-false-true-true-true-true-4-true-0-true-true-0-true-4-true-true-false-false-true-true-6-true-true-true-true-true-true-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-false-true-1-true-1-true-4-true-4-true-true-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-true-true-3-false-false-true-0-true-true-true-true-true-true-true-true-true-0-15-true-true-true-true-true-true-true-false-true-false-true-true-true-false-false-true-true-true-true-false-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-18-true-true-true-false-false-true-true-true-false-false-true-false-true-true-true-false-false-true-true-true-true-4-true-0-true-true-1-true-4-true-true-false-false-true-true-8-true-true-true-true-true-true-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-false-true-1-true-1-true-3-false-3-true-true-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-true-true-2-false-false-true-0-true-true-true-true-true-true-true-true-true-0-15-true-true-true-true-true-true-true-true-false-true-true-true-false-true-true-false-false-false-false-false-false-true-false-false-true-false-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-16-true-true-true-false-false-true-true-true-false-false-true-false-true-true-true-false-false-true-true-true-true-4-true-0-true-true-0-true-3-true-true-false-false-true-true-4-true-true-true-true-true-true-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-false-false-1-true-1-true-4-true-4-true-true-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-true-true-3-false-false-true-0-true-true-true-true-true-true-true-true-true-1-15-true-true-true-true-true-true-true-false-true-false-true-true-true-false-false-false-true-true-true-false-true-true-false-true-true-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-24-true-true-true-false-true-true-true-true-false-false-true-false-true-true-true-false-false-true-true-true-true-5-true-1-true-true-1-true-4-true-true-false-false-true-true-8-true-true-true-true-true-true-true-true-false-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-true-true-false-true-1-true-1-true-4-true-4-true-true-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-true-true-4-false-false-true-0-true-true-true-true-true-true-true-true-true-2-15-true-true-true-true-true-true-true-false-true-false-true-true-true-false-false-true-true-true-false-false-true-true-false-true-true-true-true-true-true-true-true-true-false-true-true-true-false-false-true-true-true-true-true-false-false-false-true-true-24-true-true-true-false-false-true-true-true-false-false-true-false-true-true-true-false-false-true-true-true-true-5-true-2-true-true-1-true-5-true-true-false-false-true-true-8-true-true-true-true-true-true-true-true-false-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true"

   preSet = preSet.split("-");
   for (var i=0;i<preSet.length;i++) {
    if (preSet[i] == "true") { preSet[i] = true; } else
    if (preSet[i] == "false") { preSet[i] = false; };
    config[i] = preSet[i];
   };

  }

 } // fecha onRun

} // fecha função Musescore
