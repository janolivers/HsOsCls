\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hsos}[2019/03/19 Hochschule Osnabrueck Latex class]
\LoadClass[a4paper, 12pt]{report}
%\LoadClass[a4paper, 12pt]{scrreprt}

%----------------------------------------------------------------------------------------
%	 DECLARE OPTIONS
%----------------------------------------------------------------------------------------

% if clause for options
\newif\if@printLayout
\newif\if@useTwoExanimer
\newif\if@printable

% set default values
\@printLayoutfalse
\@useTwoExanimerfalse
\@printablefalse

%Declare Options
\DeclareOption{printLayout}{\@printLayouttrue}
\DeclareOption{twoExanimer}{\@useTwoExanimertrue}
\DeclareOption{print}{\@printabletrue}
\ProcessOptions\relax

%----------------------------------------------------------------------------------------
%	 REQUIRED PACKAGES
%----------------------------------------------------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[english,german]{babel}
% select as language german
\selectlanguage{german}

% Fonts
\usepackage{mathptmx}
\usepackage[T1]{fontenc}
\usepackage[onehalfspacing]{setspace}

% Misc
\RequirePackage{xcolor}
\RequirePackage{tabularx}
\RequirePackage{graphicx}
\RequirePackage{subcaption}
%\RequirePackage{vhistory}
\RequirePackage{colortbl}
\RequirePackage{array}
\RequirePackage{tikz}
\RequirePackage{listings}
%\RequirePackage{bytefield}
\RequirePackage{xparse}
\RequirePackage[toc,page]{appendix}
\RequirePackage{csquotes}

% Layout
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{float}
%\RequirePackage[bottom]{footmisc}
%\RequirePackage{etoolbox}

% Bibliography
\RequirePackage[
  backend=biber,
  %style=alphabetic,
  %citestyle=alphabetic,
  %style=lni,
  %citestyle=lni,
  style=ieee,
  citestyle=ieee,
  bibencoding=utf8,
  backref=true]{biblatex}

%----------------------------------------------------------------------------------------
%    Tikz Library
%----------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------
% Blue
\definecolor{HSOS-BLUE-100}{RGB}{0,100,180}
\definecolor{HSOS-BLUE-80}{RGB}{72,136,187}
\definecolor{HSOS-BLUE-40}{RGB}{108,148,180}
\definecolor{HSOS-BLUE-20}{RGB}{144,164,180}

% Light Blue
\definecolor{HSOS-LIGHT-BLUE-100}{RGB}{45,175,230}
\definecolor{HSOS-LIGHT-BLUE-80}{RGB}{106,193,230}
\definecolor{HSOS-LIGHT-BLUE-40}{RGB}{156,208,230}
\definecolor{HSOS-LIGHT-BLUE-20}{RGB}{193,219,230}

% Gray
\definecolor{HSOS-GREY-100}{RGB}{87,87,87}
\definecolor{HSOS-GREY-80}{RGB}{128,128,128}
\definecolor{HSOS-GREY-40}{RGB}{179,179,179}
\definecolor{HSOS-GREY-20}{RGB}{230,230,230}

%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------
\renewcommand{\title}[1]{\renewcommand{\title}{#1}}
\renewcommand{\author}[1]{\renewcommand{\author}{#1}}
%\renewcommand{\abstract}[1]{\renewcommand{\abstract}{#1}}

%% Symbole
\newcommand{\kindofdoc}[1]{\renewcommand{\kindofdoc}{#1}}
\newcommand{\shorttitle}[1]{\renewcommand{\shorttitle}{#1}}
\newcommand{\email}[1]{\renewcommand{\email}{#1}}
\newcommand{\studentnumber}[1]{\renewcommand{\studentnumber}{#1}}
\newcommand{\releasedate}[1]{\renewcommand{\releasedate}{#1}}
\newcommand{\firstexaminer}[1]{\renewcommand{\firstexaminer}{#1}}
\newcommand{\secoundexaminer}[1]{\renewcommand{\secoundexaminer}{#1}}

% Reverse margin par for the todos
\reversemarginpar
\setlength{\marginparwidth}{2.5cm}

% Disable intent
\setlength{\parindent}{0pt}

% Footnote configuration
\newcommand\fnurl[2]{% add new command to insert refernzes in the footnote
    \href{#1}{#2}\footnote{\url{#1}}%
}
\renewcommand{\footnoterule}{} %Deactivte line above footnotes

% Configure Headheight
\setlength{\headheight}{33pt}

% Table spaces
\renewcommand{\arraystretch}{1.2}

%% New Command to Print Memory Sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% facilitates the creation of memory maps. Start address at the bottom, end address at the top.
% syntax: \memsection{end address}{start address}{height in lines}{text in box}
%\newcommand{\memsection}[4]{
%	\bytefieldsetup{bitheight=#3\baselineskip}    % define the height of the memsection
%	\bitbox[]{10}{
%		\texttt{#1}     % print end address
%		\\ \vspace{#3\baselineskip} \vspace{-2\baselineskip} \vspace{-#3pt} % do some spacing
%		\texttt{#2} % print start address
%	}
%	\bitbox{16}{#4} % print box with caption
%}

%%%%%% Example
% \begin{bytefield}{24}
% 	\memsection{ffff ffff}{0040 0000}{15}{-- free --}\\
% 	\begin{rightwordgroup}{internal memory}
% 		\memsection{003f ffff}{002f c000}{4}{Special Function Registers}\\
% 		\memsection{002f bfff}{0007 0000}{3}{-- reseved --}\\
% 		\memsection{0006 ffff}{0000 0000}{8}{Internal Flash}
% 	\end{rightwordgroup}\\
% \end{bytefield}

% Glossary and Acronym entry
%\DeclareDocumentCommand{\newdualentry}{ O{} O{} m m m m } {
%  \newglossaryentry{gls-#3}{name={#5},text={#5\glsadd{#3}},
%    description={#6},#1
%  }
%  \makeglossaries
%  \newacronym[see={[Glossar:]{gls-#3}},#2]{#3}{#4}{#5\glsadd{gls-#3}}
%}
%Syntax: \newdualentry[glossary options][acronym options]{label}{abbrv}{long}{description}
%----------------------------------------------------------------------------------------
%	 TITLE PAGE
%----------------------------------------------------------------------------------------
\renewcommand{\maketitle}{
	\begin{titlepage}

		{
			\centering
			\includegraphics[width=7cm]{titlepage-logo} \\
			\vspace*{50pt}

			{\fontsize{22}{22}\selectfont
				Fakultät \\
                Ingenieurwissenschaften und Informatik}\\[0.2\baselineskip]
    		\vspace*{80pt}

			{\fontsize{24}{24}\selectfont
				\kindofdoc}\\[0.2\baselineskip]
            {\fontsize{14}{14}\selectfont
			    über das Thema}\\[0.2\baselineskip]
			\vspace*{20pt}

			{\fontsize{16}{16}\selectfont\bfseries
			 \title}\\[0.2\baselineskip]
            \vspace*{130pt}

            {\fontsize{14}{14}\selectfont
				\begin{tabular}{ r l }
					\textbf{Autor:} 		& \author \ (\studentnumber) 			\\
											& \email 				\vspace*{10pt} 	\\
			\if@useTwoExanimer
					\textbf{Erstprüfer:}  	& \firstexaminer 		\vspace*{10pt} 	\\
					\textbf{Zweitprüfer:} 	& \secoundexaminer 		\vspace*{10pt} 	\\
			\else
					\textbf{Prüfer}         & \firstexaminer 		\vspace*{10pt}  \\
			\fi
					\textbf{Abgabedatum:} 	& \releasedate
				\end{tabular} \\
            }
		}

		\vfill

	\end{titlepage}

}%



%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\if@printLayout
	\RequirePackage[
		layout=a4paper,
		top=2cm,
		bottom=2cm,
		left=3cm,
		right=1.5cm,
		includehead,
		includefoot
		%showframe % zum Anzeigen des Layouts
	]{geometry}
\else
	\RequirePackage[
		layout=a4paper,
		top=2cm,
		bottom=2cm,
		left=2.5cm,
		right=2.5cm,
		includehead,
		includefoot
		%showframe % zum Anzeigen des Layouts
	]{geometry}
\fi

%For Printing disable color on links and urls
\if@printable

	\RequirePackage[
		%ocgcolorlinks, % broke the url links
		colorlinks=true,
		linkcolor=black,
		urlcolor=black,
		citecolor=black,
		pdfencoding=auto,
		%bookmarksopen,
		bookmarksdepth=3
	]{hyperref}

\else

	\RequirePackage[
		%ocgcolorlinks, % broke the url links
		colorlinks=true,
		linkcolor=HSOS-BLUE-100,
		urlcolor=HSOS-BLUE-100,
		citecolor=HSOS-BLUE-100,
		pdfencoding=auto,
		%bookmarksopen,
		bookmarksdepth=3
	]{hyperref}

\fi

\RequirePackage[numbered]{bookmark}
%\RequirePackage[acronyms,toc]{glossaries}

%----------------------------------------------------------------------------------------
%     Glossary Packages
%----------------------------------------------------------------------------------------
\RequirePackage[record,abbreviations,toc,nopostdot=false]{glossaries-extra}

% regular terms:

% (Version 1.04+) The following will make regular terms appear
% in sans-serif when used with \gls etc but won't affect the
% abbreviations:

%\renewcommand*{\glsxtrregularfont}[1]{\textsf{#1}}

% or limit to just the "general" category:
%\renewcommand*{\glsxtrregularfont}[1]{%
% \glsifcategory{\glslabel}{general}{\textsf{#1}}{#1}}

% or limit to a particular attribute:

%\glssetcategoryattribute{general}{font}{sf}
%\glssetcategoryattribute{acronym}{font}{sf}

%\renewcommand*{\glsxtrregularfont}[1]{%
% \glsifattribute{\glslabel}{font}{sf}{\textsf{#1}}{#1}}

% or use the attribute to store the font control sequence name:

%\glssetcategoryattribute{general}{font}{textsf}
%\glssetcategoryattribute{acronym}{font}{emph}
%
%\renewcommand*{\glsxtrregularfont}[1]{%
%  \glshasattribute{\glslabel}{font}%
%  {\csuse{\glsgetattribute{\glslabel}{font}}{#1}}%
%  {#1}%
%}

% The following will make the first letter of the name upper case
% in the glossary for the general entries:
\glssetcategoryattribute{general}{glossname}{firstuc}

% The following will make the first letter of the description upper case
% in the glossary for the general entries:
\glssetcategoryattribute{general}{glossdesc}{firstuc}

% (version 1.04+) The following will make the description
% appear in italic in the glossary for general entries:

%\glssetcategoryattribute{general}{glossdescfont}{emph}

% (version 1.04+) The following will make the name
% appear in italic in the glossary for general entries:

%\glssetcategoryattribute{general}{glossnamefont}{emph}

% acronyms:

% The following redefinition will add the provided text to the end of the
% description in the glossary.

\renewcommand*{\glsxtrpostdescacronym}{%
 \space(\textsc{Akronym:} \glsentrylong{\glscurrententrylabel})%
}

% The following will make the first letter of the name upper case
% in the glossary for the acronym entries:
\glssetcategoryattribute{acronym}{glossname}{firstuc}

% The following will make the first letter of the description upper case
% in the glossary for the acronym entries:
\glssetcategoryattribute{acronym}{glossdesc}{firstuc}

% Enable tagging of initials. The second argument is the name of
% the command you want to use to tag initial letters. The
% command will be defined robustly and will only be activated
% in the glossary for the categories listed in the first
% argument.
% If the specified tagging command (\itag here) is used
% anywhere else it will just do its argument.
\GlsXtrEnableInitialTagging{acronym,abbreviation}{\itag}

% The following redefinition will add the provided text to the end of the
% description in the glossary.

%\renewcommand*{\glsxtrpostdescabbreviation}{%
% \space (abbreviation)%
%}

% The following will set the description in title case
% in the glossary for the abbreviations:
\glssetcategoryattribute{abbreviation}{glossdesc}{title}

% The following will convert the abbreviations to all capitals
% in the glossary:
\glssetcategoryattribute{abbreviation}{glossname}{uc}

% Use \textsc in the abbreviations:
\setabbreviationstyle{long-short-sc}
\setabbreviationstyle[acronym]{long-short}

% Some other attributes you might want to try:

% Use 's (apostrophe s) for the plural suffix
% (only affects the short plural not the long plural)
%\glssetcategoryattribute{abbreviation}{aposplural}{true}

% Suppress the default suffix for the short plural.
% (Don't use with the above for the same category.)
%\glssetcategoryattribute{abbreviation}{noshortplural}{true}

%----------------------------------------------------------------------------------------
%	 change Title behaviour
%----------------------------------------------------------------------------------------
\titleformat{\chapter}{\normalfont\LARGE\bfseries}{\thechapter}{1em}{}
\titlespacing*{\chapter}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}

%----------------------------------------------------------------------------------------
%	 HEAD and FOOT Lines
%----------------------------------------------------------------------------------------
%\newcommand{\rulecolour}{HSOS-LIGHT-BLUE-100}
\let\oldheadrule\headrule
\let\oldfootrule\footrule

% Layout
\fancypagestyle{hsos-layout}{%
	\fancyhf{}% Clear header and footer

	%\fancyhead[L]{\leftmark \vspace*{12pt}}
    \fancyhead[L]{\leftmark \\ \releasedate}
	\fancyhead[R]{\includegraphics[height=1cm]{logo}}
	\fancyhead[C]{\author}

	\fancyfoot[L]{\title}% Custom footer
    \fancyfoot[R]{Seite \thepage\ von \pageref{LastPage}}% Custom footer

  	%\renewcommand{\headrule}{{\color{\rulecolour}\oldheadrule}}
  	%\renewcommand{\footrule}{{\color{\rulecolour}\oldfootrule}}

	\renewcommand{\headrulewidth}{1pt}% Line at the header visible
	\renewcommand{\footrulewidth}{1pt}% Line at the footer visible
}

\fancypagestyle{hsos-only-logo}{%
	\fancyhf{}% Clear header and footer
    \fancyhead[R]{\includegraphics[height=1cm]{logo}}

    \renewcommand{\headrule}{} % delete headrule
    \renewcommand{\footrule}{} % delete footrule
}

\fancypagestyle{hsos-logo-and-foot}{%
    \fancyhf{}% Clear header and footer
    \fancyhead[R]{\includegraphics[height=1cm]{logo}}

    \fancyfoot[L]{\title}% Custom footer
    \fancyfoot[R]{Seite \thepage\ von \pageref{LastPage}}% Custom footer

    \renewcommand{\headrule}{} % delete headrule
    \renewcommand{\footrulewidth}{1pt}% Line at the footer visible
}

\fancypagestyle{hsos-logo-and-foot-with-page}{%
	\fancyhf{}% Clear header and footer
	\fancyhead[R]{\includegraphics[height=1cm]{logo}}

	\fancyfoot[C]{\thepage}% Custom footer

	\renewcommand{\headrule}{} % delete headrule
	\renewcommand{\footrule}{} % delete footrule
}

% Redefine the plain page style
\fancypagestyle{plain}{%
    \pagestyle{hsos-logo-and-foot}
}

\pagestyle{hsos-layout}

% Set Pagenumber to one
\setcounter{page}{0}

%----------------------------------------------------------------------------------------
%	 Diffrent setups
%----------------------------------------------------------------------------------------
% setup listings
\lstset{
	numbers=left,
	breaklines=true,
	backgroundcolor=\color{HSOS-GREY-20},
	tabsize=2,
	%basicstyle=\ttfamily,
}

%\newcommand[1]{\lstinlinebox}{\colorbox{HSOS-GREY-20}{\lstinline{#1}}}
