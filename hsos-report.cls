%% hsos-report.cls
%% LaTeX-Klasse für Haus-, Projekt- und Abschlussarbeiten an der
%% Hochschule Osnabrück (inoffiziell).
%%
%% Toolchain: pdfLaTeX oder LuaLaTeX, Biber, bib2gls (siehe latexmkrc)
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{hsos-report}[2026/10/14 v2.0 Hochschule Osnabrueck report class]

%----------------------------------------------------------------------------------------
%	 OPTIONEN
%----------------------------------------------------------------------------------------
% thesis          Titelseite mit Erst- und Zweitprüfer:in (sonst nur ein:e Prüfer:in)
% print           Ränder für Bindung (breiterer Innenrand)
% twoside         doppelseitiger Satz (Kapitel beginnen rechts, Fußzeile spiegelt sich)
% black           Links und Zitate schwarz statt in HSOS-Blau
% onehalfspacing  1,5-facher Zeilenabstand (Standard: 1,2)
% english         Dokumentsprache Englisch (Standard: Deutsch, neue Rechtschreibung)
% 10pt/11pt/12pt  Schriftgröße (Standard: 11pt)
% Alle übrigen Optionen werden an die Klasse report weitergereicht.

\newif\ifhsos@thesis
\newif\ifhsos@print
\newif\ifhsos@black
\newif\ifhsos@onehalfspacing
\newif\ifhsos@english

\DeclareOption{thesis}{\hsos@thesistrue}
\DeclareOption{print}{\hsos@printtrue}
\DeclareOption{black}{\hsos@blacktrue}
\DeclareOption{onehalfspacing}{\hsos@onehalfspacingtrue}
\DeclareOption{english}{\hsos@englishtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[a4paper,11pt]{report}
\raggedbottom

%----------------------------------------------------------------------------------------
%	 SPRACHE UND SCHRIFTEN
%----------------------------------------------------------------------------------------
% UTF-8 ist seit LaTeX 2018-04-01 Standard, inputenc wird nicht mehr benötigt.
\RequirePackage{iftex}
\ifhsos@english
  \RequirePackage[ngerman,main=english]{babel}
\else
  \RequirePackage[english,main=ngerman]{babel}
\fi

\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage{newtxtext}
  \RequirePackage{newtxmath}
\else
  % LuaLaTeX / XeLaTeX
  \RequirePackage{newtxmath}
  \RequirePackage{fontspec}
  \setmainfont{texgyretermes}[
    Extension=.otf,
    UprightFont=*-regular, BoldFont=*-bold,
    ItalicFont=*-italic,   BoldItalicFont=*-bolditalic]
\fi
\RequirePackage{microtype}

\RequirePackage{setspace}
\ifhsos@onehalfspacing
  \onehalfspacing
\else
  \setstretch{1.2}
\fi

%----------------------------------------------------------------------------------------
%	 PAKETE
%----------------------------------------------------------------------------------------
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{colortbl}
\RequirePackage{booktabs}
\RequirePackage{subcaption}
\RequirePackage{float}
\RequirePackage{tikz}
\RequirePackage{listings}
\RequirePackage[toc,page]{appendix}
\RequirePackage{csquotes}

\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\RequirePackage[
  backend=biber,
  style=ieee,
  backref=true
]{biblatex}

%----------------------------------------------------------------------------------------
%	 FARBEN
%----------------------------------------------------------------------------------------
\definecolor{HSOS-BLUE-100}{RGB}{0,100,180}
\definecolor{HSOS-BLUE-80}{RGB}{72,136,187}
\definecolor{HSOS-BLUE-40}{RGB}{108,148,180}
\definecolor{HSOS-BLUE-20}{RGB}{144,164,180}

\definecolor{HSOS-LIGHT-BLUE-100}{RGB}{45,175,230}
\definecolor{HSOS-LIGHT-BLUE-80}{RGB}{106,193,230}
\definecolor{HSOS-LIGHT-BLUE-40}{RGB}{156,208,230}
\definecolor{HSOS-LIGHT-BLUE-20}{RGB}{193,219,230}

\definecolor{HSOS-GREY-100}{RGB}{87,87,87}
\definecolor{HSOS-GREY-80}{RGB}{128,128,128}
\definecolor{HSOS-GREY-40}{RGB}{179,179,179}
\definecolor{HSOS-GREY-20}{RGB}{230,230,230}

%----------------------------------------------------------------------------------------
%	 METADATEN
%----------------------------------------------------------------------------------------
% \hsos@defmeta{name}{Standardwert} definiert \name{...} zum Setzen und
% \thename zum Ausgeben. Fehlende Angaben führen so nicht mehr zu Fehlern.
\newcommand\hsos@defmeta[2]{%
  \expandafter\def\csname hsos@#1\endcsname{#2}%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \expandafter\gdef\csname hsos@#1\endcsname{##1}}%
  \expandafter\newcommand\csname the#1\endcsname{\csname hsos@#1\endcsname}%
}

\hsos@defmeta{longtitle}{Titel der Arbeit}
\hsos@defmeta{shorttitle}{Kurztitel}
\hsos@defmeta{kindofdoc}{Bachelorarbeit}
\hsos@defmeta{faculty}{Fakultät\\[6pt]Ingenieurwissenschaften und Informatik}
\hsos@defmeta{major}{}
\hsos@defmeta{email}{}
\hsos@defmeta{studentnumber}{}
\hsos@defmeta{startdate}{}
\hsos@defmeta{releasedate}{\today}
\hsos@defmeta{firstexaminer}{}
\hsos@defmeta{secondexaminer}{}
\hsos@defmeta{headerlogo}{HS-OS-Logo-Kompakt-Schwarz}
\hsos@defmeta{titlelogo}{titlepage-logo}

% \author bleibt der Standard-Befehl von LaTeX, \theauthor gibt den Namen aus.
\newcommand\theauthor{\@author}
% Kompatibilität zu Version 1 (Tippfehler im Befehlsnamen)
\newcommand\secoundexaminer{\secondexaminer}

% Bezeichnungen auf der Titelseite (sprachabhängig)
\newcommand\hsos@lbl@about{über das Thema}
\newcommand\hsos@lbl@author{Bearbeiter:in}
\newcommand\hsos@lbl@studentnumber{Matrikelnummer}
\newcommand\hsos@lbl@examiner{Prüfer:in}
\newcommand\hsos@lbl@firstexaminer{Erstprüfer:in}
\newcommand\hsos@lbl@secondexaminer{Zweitprüfer:in}
\newcommand\hsos@lbl@startdate{Ausgabedatum}
\newcommand\hsos@lbl@releasedate{Abgabedatum}
\newcommand\hsos@lbl@page{Seite}
\newcommand\hsos@lbl@of{von}
\ifhsos@english
  \renewcommand\hsos@lbl@about{on the topic}
  \renewcommand\hsos@lbl@author{Author}
  \renewcommand\hsos@lbl@studentnumber{Student ID}
  \renewcommand\hsos@lbl@examiner{Examiner}
  \renewcommand\hsos@lbl@firstexaminer{First examiner}
  \renewcommand\hsos@lbl@secondexaminer{Second examiner}
  \renewcommand\hsos@lbl@startdate{Date of issue}
  \renewcommand\hsos@lbl@releasedate{Submission date}
  \renewcommand\hsos@lbl@page{Page}
  \renewcommand\hsos@lbl@of{of}
\fi

%----------------------------------------------------------------------------------------
%	 HILFSBEFEHLE
%----------------------------------------------------------------------------------------
% Logo einbinden (sucht auch in \graphicspath); fehlt die Datei, erscheint
% ein Platzhalter mit Warnung statt eines Abbruchs.
\newif\ifhsos@found
\newcommand\hsos@logo[2]{%
  \hsos@foundfalse
  \ifdefined\Ginput@path
    \edef\hsos@paths{\unexpanded{{}}\unexpanded\expandafter{\Ginput@path}}%
  \else
    \def\hsos@paths{{}}%
  \fi
  \expandafter\@tfor\expandafter\hsos@dir\expandafter:\expandafter=\hsos@paths\do{%
    \@for\hsos@ext:=,.pdf,.png,.jpg,.jpeg\do{%
      \IfFileExists{\hsos@dir#2\hsos@ext}{\global\hsos@foundtrue}{}}}%
  \ifhsos@found
    \includegraphics[#1]{#2}%
  \else
    \ClassWarning{hsos-report}{Logo '#2' nicht gefunden}%
    \fbox{\footnotesize Logo fehlt: \detokenize{#2}}%
  \fi
}

% Link mit URL in der Fußnote
\newcommand\fnurl[2]{\href{#1}{#2}\footnote{\url{#1}}}

% Unterschriftszeile für Erklärungen
\newcommand\hsossignature{%
  \par\vspace{2cm}\noindent
  \parbox[t]{6cm}{\rule{5cm}{0.5pt}\\Ort, Datum}\hspace{1cm}%
  \parbox[t]{8cm}{\rule{7cm}{0.5pt}\\Unterschrift}\par
}

% Seitenstil für \chapter-Seiten setzen: \hsosplainstyle{hsos-logo-and-foot}
\newcommand\hsosplainstyle[1]{%
  \expandafter\let\expandafter\ps@plain\csname ps@#1\endcsname}

%----------------------------------------------------------------------------------------
%	 ALLGEMEINES LAYOUT
%----------------------------------------------------------------------------------------
% Absätze durch Abstand statt Einzug trennen
\RequirePackage[parfill]{parskip}
\reversemarginpar
\setlength{\marginparwidth}{2.5cm}
\renewcommand{\footnoterule}{}

\titleformat{\chapter}{\normalfont\LARGE\bfseries}{\thechapter}{1em}{}
\titlespacing*{\chapter}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}

\lstset{
  numbers=left,
  breaklines=true,
  backgroundcolor=\color{HSOS-GREY-20},
  basicstyle=\ttfamily\small,
  columns=fullflexible,
  keepspaces=true,
  tabsize=2,
}

%----------------------------------------------------------------------------------------
%	 TITELSEITE
%----------------------------------------------------------------------------------------
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \centering
    \hsos@logo{width=7cm}{\hsos@titlelogo}\par
    \vspace*{60pt}
    {\fontsize{24}{28}\selectfont \hsos@faculty\par}
    \vspace*{10pt}
    {\fontsize{14}{16}\selectfont \hsos@major\par}
    \vspace*{60pt}
    {\fontsize{24}{28}\selectfont \hsos@kindofdoc\par}
    {\fontsize{14}{16}\selectfont \hsos@lbl@about\par}
    \vspace*{20pt}
    {\fontsize{18}{22}\selectfont\bfseries \hsos@longtitle\par}
    \vfill
    {\fontsize{14}{16}\selectfont
      \begin{tabular}{rl}
        \textbf{\hsos@lbl@author:}        & \@author \\
        \textbf{\hsos@lbl@studentnumber:} & \hsos@studentnumber \\[10pt]
        \ifhsos@thesis
        \textbf{\hsos@lbl@firstexaminer:}  & \hsos@firstexaminer \\
        \textbf{\hsos@lbl@secondexaminer:} & \hsos@secondexaminer \\[10pt]
        \else
        \textbf{\hsos@lbl@examiner:}       & \hsos@firstexaminer \\[10pt]
        \fi
        \textbf{\hsos@lbl@startdate:}      & \hsos@startdate \\
        \textbf{\hsos@lbl@releasedate:}    & \hsos@releasedate
      \end{tabular}\par}
    \vspace*{40pt}
  \end{titlepage}%
}

%----------------------------------------------------------------------------------------
%	 SEITENRÄNDER
%----------------------------------------------------------------------------------------
\ifhsos@print
  \RequirePackage[a4paper,top=1cm,bottom=1.5cm,inner=3cm,outer=1.5cm,
    includehead,includefoot]{geometry}
\else
  \RequirePackage[a4paper,top=1cm,bottom=1.5cm,inner=2.5cm,outer=2.5cm,
    includehead,includefoot]{geometry}
\fi
\setlength{\headheight}{28pt}
\setlength{\headsep}{12pt}
\setlength{\footskip}{24pt}

%----------------------------------------------------------------------------------------
%	 KOPF- UND FUSSZEILEN
%----------------------------------------------------------------------------------------
\newcommand\hsos@pageof{\hsos@lbl@page\ \thepage\ \hsos@lbl@of\ \pageref*{LastPage}}
\newcommand\hsos@headlogo{\hsos@logo{height=.8cm}{\hsos@headerlogo}}

% Seitenzahl und Logo stehen außen (bei twoside gespiegelt).
\if@twoside
  \def\hsos@out{RO,LE}\def\hsos@in{LO,RE}
\else
  \def\hsos@out{R}\def\hsos@in{L}
\fi
\newcommand\hsos@headout{\expandafter\fancyhead\expandafter[\hsos@out]}
\newcommand\hsos@headin {\expandafter\fancyhead\expandafter[\hsos@in]}
\newcommand\hsos@footout{\expandafter\fancyfoot\expandafter[\hsos@out]}
\newcommand\hsos@footin {\expandafter\fancyfoot\expandafter[\hsos@in]}

\newcommand\hsos@foot{%
  \hsos@footout{\hsos@pageof}%
  \hsos@footin{\hsos@shorttitle}%
}

\fancypagestyle{hsos-layout}{%
  \fancyhf{}%
  \hsos@headin{\leftmark\\\hsos@releasedate}%
  \fancyhead[C]{\@author}%
  \hsos@headout{\hsos@headlogo}%
  \hsos@foot
  \renewcommand{\headrulewidth}{1pt}%
  \renewcommand{\footrulewidth}{1pt}%
}

\fancypagestyle{hsos-only-logo}{%
  \fancyhf{}%
  \hsos@headout{\hsos@headlogo}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

\fancypagestyle{hsos-logo-and-foot}{%
  \fancyhf{}%
  \hsos@headout{\hsos@headlogo}%
  \hsos@foot
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{1pt}%
}

\fancypagestyle{hsos-logo-and-foot-with-page}{%
  \fancyhf{}%
  \hsos@headout{\hsos@headlogo}%
  \fancyfoot[C]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

\fancypagestyle{only-foot-with-page}{%
  \fancyhf{}%
  \fancyfoot[C]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

\hsosplainstyle{hsos-logo-and-foot}
\pagestyle{hsos-layout}

%----------------------------------------------------------------------------------------
%	 HYPERREF (möglichst spät laden)
%----------------------------------------------------------------------------------------
\RequirePackage[pdfencoding=auto,bookmarksdepth=3]{hyperref}
\ifhsos@black
  \hypersetup{colorlinks=true,allcolors=black}
\else
  \hypersetup{colorlinks=true,linkcolor=HSOS-BLUE-100,urlcolor=HSOS-BLUE-100,
    citecolor=HSOS-BLUE-100}
\fi
\RequirePackage[numbered]{bookmark}

\AtBeginDocument{%
  \hypersetup{
    pdftitle={\hsos@longtitle},
    pdfauthor={\@author},
    pdfsubject={\hsos@kindofdoc},
  }%
}

%----------------------------------------------------------------------------------------
%	 GLOSSAR UND ABKÜRZUNGEN (bib2gls)
%----------------------------------------------------------------------------------------
\RequirePackage[record,abbreviations,toc,nopostdot=false]{glossaries-extra}

\glssetcategoryattribute{general}{glossname}{firstuc}
\glssetcategoryattribute{general}{glossdesc}{firstuc}

\renewcommand*{\glsxtrpostdescacronym}{%
  \space(\textsc{Akronym:} \glsentrylong{\glscurrententrylabel})}
\glssetcategoryattribute{acronym}{glossname}{firstuc}
\glssetcategoryattribute{acronym}{glossdesc}{firstuc}

% \itag{X} markiert Anfangsbuchstaben im Abkürzungsverzeichnis
\GlsXtrEnableInitialTagging{acronym,abbreviation}{\itag}

\glssetcategoryattribute{abbreviation}{glossdesc}{title}
\glssetcategoryattribute{abbreviation}{glossname}{uc}
\setabbreviationstyle{long-short-sc}
\setabbreviationstyle[acronym]{long-short}

\endinput
