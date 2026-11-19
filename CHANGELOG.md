# Histórico de versões

Todas as versões estão disponíveis como *tags* no GitHub (aba **Tags**, ou em
`https://github.com/rogerioConstante/analisador-de-contrapontos/tree/<tag>`).
Tags com sufixo `-ms2` são da linha para MuseScore 2; `v0.3-ms3` é a primeira para MuseScore 3.

## v0.5.3 — 2026-11-19

*Correções de análise e da interface*

- **Trítono melódico** passa a ser verificado de forma independente, com as
  exceções "preparado por semitom", "resolvido por semitom" e
  "preparado/resolvido na direção contrária" (a exceção vale quando todas as
  condições marcadas são atendidas). Corrige o erro `saltTrit is not defined`,
  que interrompia a análise ao encontrar um trítono.
- **Outros intervalos aumentados e diminutos** deixam de incluir o trítono e
  passam a reconhecer todos os aumentados/diminutos (2ªA, 4ªd, 5ªA, 7ªd,
  uníssono aumentado etc.).
- **5ªs/8ªs consecutivas:** notas repetidas ou prolongadas nas duas vozes não
  são mais acusadas; a marcação inclui as notas do 1º intervalo.
- Vozes cruzadas: corrigida a comparação que identificava a voz superior em
  paralelas, ocultas, consecutivas e uníssonos.
- **Seleção de compassos:** quando a seleção ia até o fim da partitura, a
  análise começava no 1º compasso. As mensagens passam a usar a numeração de
  compassos da partitura.
- **Configuração por tipo de contraponto:** cinco opções que não podiam ser
  alteradas (exceções das intermitentes e quantidade máxima de movimentos
  similares) e três que não eram guardadas passam a funcionar; configurações e
  presets antigos são completados com as opções novas.
- **Configuração automática** é carregada ao abrir o plugin e gravada ao trocar
  de tipo e ao verificar, no arquivo `analisador_auto.cfA` da pasta do plugin
  (o MuseScore 4.6 bloqueia a gravação na pasta pessoal).
- **Marcação na partitura:** as notas voltam à cor original ao trocar de item,
  ao fechar a janela de resultados, ao verificar de novo e ao fechar o plugin.
- Novo botão **Ver análise**, que reabre a última lista de resultados.
- Log de depuração mais limpo (aviso único quando faltam cifras na coerência
  harmônica).

## v0.5.2 — 2026-02-26

*Revisão de fevereiro*

- Salvar e abrir configurações em arquivo (FileIO + diálogos do sistema).
- Configuração salva e carregada automaticamente.
- Caminho de presets configurável.
- Log de depuração.

## v0.5.1 — 2026-01-18

- Análise por pares de vozes (analisaPares).
- Janela de mensagens de erro.

## v0.5 — 2025-04-08

- Análise de contrapontos a 3 ou mais vozes.
- Reconhece a voz do CF pela indicação na partitura.
- Janela de resultado: filtros por categoria (Condução de Vozes, Melodia,
  Dissonâncias, Outros Aspectos) e paginação de 20 mensagens.
- Intermitentes e ocultas: opção "somente entre as vozes externas".
- Apojatura: resolução por movimento contrário; sem preparação.
- Novas verificações: resolução do trítono na melodia, priorizar
  movimentos contrários e oblíquos, quantidade máxima de movimentos
  similares.
- Dicas sobre os aspectos apontados na lista de verificações.

## v0.4.7 — 2024-09-18

*Portabilidade para MuseScore 4*

- Primeira versão compatível com o MuseScore 4.

## v0.4.6 — 2022-04-11

- Mensagem "intervalo melódico aumentado" passa a incluir "ou diminuto".

## v0.4.5.5 — 2022-03-15

- Ajustes e correções.

## v0.4.5.4 — 2021-08-10

- Leitura de cifras passa a usar o texto "Análise por números romanos".
- Coerência harmônica: opção "e tempo meio-forte"; mudança de acorde
  equiparada a tempo forte.

## v0.4.5.3 — 2021-04-20

- Ajustes e correções.

## v0.4.5.2 — 2020-10-28

- Ajustes e correções.

## v0.4.5.1 — 2020-10-15

- Ajustes e correções (versão publicada no GitHub).

## v0.4.5 — 2020-08-13

- Intermitentes: exceção "CF não move" no contraponto livre.
- Bordadura dupla: exceção de tempo F e mF.
- Suspensão em tempo mF-F ou F-c; suspensão com RI por dissonância.
- Relatório: nota não muda mais sem atualizar a verificação.
- Ponto focal: desconsidera 1º e 2 últimos compassos.
- Uníssono: exceção para tempo mF.
- Cifras para dominantes individuais; graus cromáticos nos modos maior
  e menor.

## v0.4.4.2 — 2020-08-06

- Ajustes e correções.

## v0.4.4.1 — 2020-08-06

- Ajustes e correções.

## v0.4.4 — 2020-08-06

- Análise métrica com diferenciação de tempos fortes e meio-fortes (F/mF)
  nos tratamentos de dissonância e nas intermitentes.
- Intermitentes: novos critérios (mesma posição métrica, separadas por N
  intervalos/tempos) e mais espaço na interface.
- Verificação de salto do tempo forte para o fraco.
- Correções na música ficta e na sugestão de nota.

## v0.4.3.1 — 2020-07-21

- Correção na detecção de cambiata seguida de outro tratamento.
- Reconhecimento da nota do acorde vii° no CF.

## v0.4.2 — 2020-07-17

- Exceção para repetição do ponto focal em bordaduras.

## v0.4.1 — 2020-07-03

- Verificações "priorizar movimentos contrários" e "quantidade máxima de
  movimentos similares".
- Alternativa "mais do que N saltos na mesma direção".
- Presets atualizados.

## v0.4.1-ms2 — 2020-06-10

- Ajustes e correções.

## v0.4.0-ms2 — 2020-05-26

- Ajustes e correções.

## v0.4.0 — 2020-05-21

- Verificação de coerência harmônica (leitura de cifras).
- Mudança automática de tonalidade.
- Novas opções para antecipação, apojatura, escapada e bordadura dupla.
- Nota pedal; padrões de alteração do 6º e 7º graus.
- Relatório para o professor com sugestão de nota.
- Leitura do arquivo de configuração na inicialização.

## v0.3.1 — 2019-10-25

Conversão da v0.3.1 para o MuseScore 3.2.3.

## v0.3.1-ms2 — 2019-10-23

- Presets de configuração (salvarCfg / carregarCfg).
- Contraponto livre: tratamento de dissonâncias (suspensão, suspensão com
  resolução interrompida, cambiata, bordadura, nota de passagem,
  apojatura, antecipação).
- Checkboxes separados para sextas maiores e menores.

## v0.3-ms3 — 2019-08-06

Unifica as versões 0.21-3 (adaptação ao MuseScore 3) e 0.3. A versão para
MuseScore 2 passa a ser mantida em musescore2/Contraponto.qml.

## v0.3 — 2019-06-17

- Botões de melodia e cantus firmus separados; configuração da voz do CF
  na aba "configurações gerais".
- Diferenciação de intervalos enarmônicos.
- Verificação de neutralização de alterações.
- Opção para detectar repetições de notas sem alteração da outra voz.

## v0.2.1 — 2019-04-02

- Correções de bugs e adaptação para Windows.

## v0.2 — 2019-03-22

*Interface remodelada*

- Espécies na parte superior da janela; verificações gerais fixas na parte
  inferior.
- Configuração de primeiro e último intervalos (3ª e 5ª individuais).
- Uníssono: opção "Exceto início/final".
- Distância entre as vozes: quantidade de intervalos > 10ª por espécie.

## v0.1.2.1 — 2019-03-20

- Correção de incompatibilidade com o MuseScore 2 no Windows (retorno ao
  QtQuick.Controls 1.3).

## v0.1.2 — 2019-03-18

- Correção: sem trecho selecionado e com uma só voz, a primeira nota do CF
  não era carregada.
- 5ª oculta: oculSalto = true passa a ser o padrão em todas as espécies.

## v0.1.1 — 2019-03-12

*Primeira versão do Analisador de Contrapontos*

Plugin para MuseScore 2 que verifica exercícios de contraponto por espécies
(cantus firmus, 1ª a 5ª espécies): condução de vozes, tratamento de
dissonâncias, construção melódica e textura.

