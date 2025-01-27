%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% N-HiTec template for beautiful documents by Nicolas Mahiat (2020) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{nhitec_design}[2020/04/03 A class to easily design beautiful documents for N-HiTec, by Nicolas Mahiat]

\LoadClass[12pt,a4paper]{article} % This class is based on the standard class "article"

% ===================================
% Package used and why there are used
% ===================================
\RequirePackage[french]{babel}  % Language of the document (used in dates, table of contents...)
\RequirePackage[T1]{fontenc}    % Font encoding, need T1 for French characters
%\RequirePackage[utf8x]{inputenc}% Output file encoding, utf8x is better than utf8  /!\ NOT NEEDED ANYMORE
\RequirePackage{amsmath,amssymb}% For math symbols
\RequirePackage{lmodern}        % For better policies
\RequirePackage{graphicx}       % For image inclusion
\RequirePackage{float}          % For easier placement of figures and tables
\RequirePackage{geometry}       % For personalized margins
\RequirePackage{eso-pic}        % For the background image
\RequirePackage{fancyhdr}       % For the different page styles (footer, header)
\RequirePackage{xcolor}         % For the colors (xcolor is better than color)
\RequirePackage{eurosym}        % For the "€" symbol
\RequirePackage{textcomp}       % For the degree symbol [°]
\RequirePackage{ifthen}         % For the conditional statement \ifthenelse
\RequirePackage{multirow}       % For multirows in table
\RequirePackage{anyfontsize}    % For writing as big as you want
% {\fontsize{size}{baselineskip}\selectfont foo}
% => use baselineskip = 1.2 * size for proper result
\RequirePackage{parskip}        % Add spacing between paragraphs
\RequirePackage{array}          % For extra possibilities for array (see https://www.ctan.org/pkg/array)
\RequirePackage{caption}        % For personalization of caption
\RequirePackage{subcaption}     % For management of subcaption
\RequirePackage{ulem}           % For extra style for underlining, crossing out, etc
\RequirePackage{xspace}         % For smart management of spaces at the end of a command
\RequirePackage{tikz}           % The famous package for graphical drawing (used for big quotes
\RequirePackage{wrapfig}        % Package to embed figures in texts
\RequirePackage{fancyvrb}       % Package to allow \verb inside footnotes
\RequirePackage[export]{adjustbox}      % Package to put figures to the left and right instead of \centering
\RequirePackage[inline, shortlabels]{enumitem}      % Package to allow a list to follow a wrapfig and still align correctely.

\setlist{itemjoin ={,\enspace},itemjoin* = { and\enspace}}

\RequirePackage{letltxmacro}
\RequirePackage{xparse}
\RequirePackage{titlesec}
\RequirePackage{color}
\RequirePackage{listings,lstautogobble}
\RequirePackage[
  bookmarks=true,
  pdfusetitle
]{hyperref}
\hypersetup{
  pdffitwindow=true,
  pdfstartview={FitV},
  pdfnewwindow=true,
  colorlinks,
  linktocpage=false, % link is on the page number in the table of contents (false to put it on the title)
  linkcolor=red_nhitec,
  urlcolor=red_nhitec
}

\definecolor{darkWhite}{rgb}{0.94,0.94,0.94}

\lstset{
  backgroundcolor=\color{white},      % choose the background color
  basicstyle=\footnotesize\ttfamily,  % the size of the fonts and typewriter font
  breakatwhitespace=false,            % sets if automatic breaks should only happen at whitespace
  breaklines=true,                    % sets automatic line breaking
  captionpos=b,                       % sets the caption-position to bottom
  deletekeywords={...},               % if you want to delete keywords from the given language
escapeinside={\%*}{*)},             % if you want to add LaTeX within your code
frame=single,                       % adds a frame around the code
keepspaces=true,                    % keeps spaces in text, useful for keeping indentation of code
keywordstyle=\color{blue},          % keyword style
language=bash,                      % the language of the code
morekeywords={*,...},               % if you want to add more keywords to the set
numbersep=5pt,                      % how far the line-numbers are from the code
rulecolor=\color{black},            % frame color
showspaces=false,                   % show spaces everywhere adding particular underscores
showstringspaces=false,             % underline spaces within strings only
showtabs=false,                     % show tabs within strings adding particular underscores
stepnumber=1,                       % the step between two line-numbers
tabsize=2,                          % sets default tabsize to 2 spaces
autogobble=true,                    % remove common leading whitespace
columns=fullflexible,               % adjust column width to text width
commentstyle=\color{gray},          % comment style
stringstyle=\color{orange},         % string literal style
identifierstyle=\color{black},      % identifier style
rulecolor=\color{red_nhitec},
}

\RequirePackage{floatflt}
\RequirePackage{listings}

% ==============================
% Special options for this class
% ==============================
% For official document, add more information on the title page
\newboolean{isOfficial}
\setboolean{isOfficial}{false}
\DeclareOption{official}{
\setboolean{isOfficial}{true}
}

% For internal documents, add a small line on the top left
\newboolean{isInternal}
\setboolean{isInternal}{false}
\DeclareOption{internal}{
\setboolean{isInternal}{true}
}

% Pass the remaining arguments to the article class
\DeclareOption*{
\PassOptionsToClass{\CurrentOption}{article}
}

\ProcessOptions\relax


% ===========================
% Special command definitions
% ===========================
\makeatletter
\newboolean{subtitleDefined}
\setboolean{subtitleDefined}{false}
\newcommand{\subtitle}[1]{\newcommand{\@subtitle}{#1} \setboolean{subtitleDefined}{true}}

\newboolean{authorDefined}
\setboolean{authorDefined}{true}
\newcommand{\noAuthorInTitle}{\setboolean{authorDefined}{false}}

\newboolean{dateDefined}
\setboolean{dateDefined}{true}
\newcommand{\noDateInTitle}{\setboolean{dateDefined}{false}}

% ============================================================
% Useful commands (because optimization of time is the key :p)
% ============================================================

% Shorthand commands
% ******************
\newcommand{\bi}{
\begin{itemize}}
  \newcommand{\ei}{\vspace{.5em}
\end{itemize}}
\renewcommand{\b}{$\bullet$\xspace}
\newcommand{
\itemb}{
\item[\b]\vspace{.5em}}
\newcommand{\eur}{\,\euro\xspace}
\newcommand{\vsp}{\vspace{1em}}
\renewcommand{\u}[1]{\underline{#1}\xspace}
\renewcommand{\tt}[1]{\texttt{#1}\xspace}
\newcommand{\nhitec}{N-HiTec\xspace}
\newcommand{\nhitecfull}{A.S.B.L. Nova-High Technologies, Engineering \& Consulting\xspace}
\newcommand{\nhidays}{N-HiDays\xspace}
\newcommand{\mininhidays}{Mini N-HiDays\xspace}
\newcommand{\jeb}{JE Belgium\xspace}
\newcommand{\admin}{administrateur\xspace}
\newcommand{\admins}{administrateurs\xspace}
\newcommand{\Admin}{Administrateur\xspace}
\newcommand{\Admins}{Administrateurs\xspace}
\newcommand{\cda}{Conseil des Anciens\xspace}
\newcommand{\infra}{Infrastructure\xspace}
\newcommand{\rp}{Relations Publiques\xspace}
\newcommand{\flutter}{Flutter \includegraphics[height=0.8em]{figures-logos/flutter.pdf}}
\newcommand{\dart}{\texttt{Dart} \includegraphics[height=0.8em]{Images_formation/DartLogo.png}}
\newcommand{\linux}{Linux \includegraphics[height=0.8em]{figures-logos/linux.pdf}}
\newcommand{\java}{\texttt{Java} \includegraphics[height=0.8em]{figures-logos/java.jpg}}
\newcommand{\cplusplus}{\texttt{C++} \includegraphics[height=0.8em]{figures-logos/c++.png}}
\newcommand{\cat}{\includegraphics[height=0.8em]{figures-logos/cat.jpg}}
\newcommand\sbullet[1][.6]{\mathbin{\vcenter{\hbox{\scalebox{#1}{$\bullet$}}}}}
% More complex commands
% *********************
% For corrections. Usage: \corr{wrong text}{new text}
\newcommand{\corr}[2]{\textcolor{red}{\sout{#1}}\ifthenelse{{\not\equal{#1}{}}\and{\not\equal{#2}{}}}{ }{}\textcolor{green!80!black}{#2}}

% For general remark. Usage: \rem{pertinent remark}
\newcommand{\rem}[1]{\textcolor{orange!90!red}{[#1]}}

% For personal remark.
% Usage: 1. First, define the personal command with \newRem{name}{color}
%        2. Then, use it with \name{pertinent remark}
\newcommand{\newRem}[2]{\expandafter\newcommand\csname#1\endcsname[1]{\textcolor{#2}{[#1: ##1]}}}

% For beautiful big centered quotes. Usage: \enquote{text to quote}
% NB1: the only is useful command is \enquote, the others are there to simplify the writing of \enquote.
% NB2: if \enquote already exists (for example if you include the 'csquote' package), just change the
%      last \newcommand to \renewcommand
\newcommand*\quotefont{\fontfamily{LinuxLibertineT-LF}} % selects Libertine as the quote font
\newcommand*\quotesize{40} % if quote size changes, need to adapt the shifts
\newcommand*{\openquote}
{\tikz[remember picture,overlay,xshift=-1.5ex,yshift=0.7ex]
\node (OQ) {\quotefont\fontsize{\quotesize}{\quotesize}\selectfont\textcolor{red_nhitec}{``}};\kern0pt}
\newcommand*{\closequote}
{\tikz[remember picture,overlay,xshift=1ex,yshift=-2ex]
\node (CQ) {\quotefont\fontsize{\quotesize}{\quotesize}\selectfont\textcolor{red_nhitec}{''}};}
\newcommand{\enquote}[1]{
\begin{center} \Large \vspace{1mm} \openquote #1 \closequote \vspace{1mm}
\end{center}}

% =============
% N-HiTec color
% =============
\definecolor{red_nhitec}{RGB}{178, 27, 22} % #b21b16

% =========
% Main font
% =========
\renewcommand{\familydefault}{\sfdefault} % use sans-sherif font

% ===========
% Page layout
% ===========

% Margin definition
% *****************
\geometry{top=1.5cm,bottom=6cm,hmargin=2cm}

% Background
% **********
\setlength{\unitlength}{1mm}
\AddToShipoutPicture{%
\put(150,-100){
  \begin{minipage}[b]{\textwidth}
    \includegraphics[width=\textwidth]{N-Hitec_images/Logo_Filigrane.pdf}
  \end{minipage}
}
}

% Header and footer
% *****************
\pagestyle{fancy}
\setlength{\headheight}{2.5cm}
\setlength{\headsep}{1cm}
% \setlength{\voffset}{-.5cm}
\setlength{\footskip}{2.5cm}
\fancyfootoffset{1cm}
\fancyheadoffset{1cm}
\renewcommand{\headrulewidth}{0pt}
% \renewcommand{\footrulewidth}{2pt}
\lhead{
\ifthenelse{\boolean{isInternal}}{%
  \hspace{1cm}\footnotesize\textcolor{lightgray}{Ceci est un document interne. Ne pas diffuser.}\\
}{}
}
\chead{}
\rhead{
\includegraphics[height=2cm]{N-Hitec_images/Brand.pdf}
}
\lfoot{
\begin{minipage}{.1\textwidth}
  \includegraphics[height=0.8cm]{N-Hitec_images/Logo.pdf}
\end{minipage}%
\begin{minipage}{.4\textwidth}
  \textcolor{red_nhitec}{\textbf{\nhitec}}\\
  {\footnotesize Allée de la Découverte 10, 4000 Liège, Belgium}\\
  \href{https://www.nhitec.com}{\u{nhitec.com}} | \href{mailto:info@nhitec.com}{info@nhitec.com}
\end{minipage}
}
\cfoot{}
\rfoot{
\textcolor{white}{\\\textbf{\thepage}} \hspace{-0.55cm}
\AddToShipoutPicture{%
  \put(540, -60){
    \begin{minipage}[b]{\textwidth}
      \includegraphics[width=4cm]{N-Hitec_images/Circle.pdf}
    \end{minipage}
  }
}
}

% Title page
% **********
\fancypagestyle{plain}{
\fancyhf{} % clear all header and footer fields
\ifthenelse{\boolean{isInternal}}{%
  \lhead{
    \hspace{1cm}\footnotesize\textcolor{lightgray}{Ceci est un document interne. Ne pas diffuser.}\\
  }
}{}
\ifthenelse{\boolean{isOfficial}}{%
  \lfoot{
    \begin{minipage}{.1\textwidth}
      \includegraphics[height=1.5cm]{N-Hitec_images/Logo.pdf}
    \end{minipage}%
    \begin{minipage}{.7\textwidth}
      \setlength{\tabcolsep}{0pt}
      \begin{tabular}{l@{\hspace{.4cm}}l}
        \multicolumn{2}{l}{\textcolor{red_nhitec}{\textbf{\nhitecfull}}}\\
        {\footnotesize Siège social : Allée de la Découverte 10, 4000 Liège, Belgium} & {\footnotesize Numéro d'entreprise : 0872.005.155} \\
        \href{https://www.nhitec.com}{\u{nhitec.com}} | \href{mailto:info@nhitec.com}{info@nhitec.com} & {\footnotesize RPM : Tribunal de l'entreprise de Liège}
      \end{tabular}
    \end{minipage}
  }
}{%
  \lfoot{
    \begin{minipage}{.1\textwidth}
      \includegraphics[height=0.8cm]{N-Hitec_images/Logo.pdf}
    \end{minipage}%
    \begin{minipage}{.4\textwidth}
      \textcolor{red_nhitec}{\textbf{\nhitec}}\\
      {\footnotesize Allée de la Découverte 10, 4000 Liège, Belgium}\\
      \href{https://www.nhitec.com}{\u{nhitec.com}} | \href{mailto:info@nhitec.com}{info@nhitec.com}
    \end{minipage}
  }
}
}
\def\@maketitle{%
\hspace{-1cm}\includegraphics[width=.8\textwidth]{N-Hitec_images/Brand.pdf}
\vfill
\begin{flushright}
  {\Huge \textcolor{red_nhitec}{\textbf{\@title}}}\\
  \ifthenelse{\boolean{subtitleDefined}}
  {%
    \vsp\vsp
    {\LARGE \textbf{\@subtitle}}\\
  }{}
\end{flushright}
\vfill
\vfill
\begin{center}
  \ifthenelse{\boolean{authorDefined}}{\@author}{}
  \ifthenelse{\boolean{authorDefined}\and\boolean{dateDefined}}{-}{}
  \ifthenelse{\boolean{dateDefined}}{\@date}{}
\end{center}
\AddToShipoutPicture*{%  * means only for the current page
  \put(510,750){
    \begin{minipage}[b]{\textwidth}
      \includegraphics[width=6cm,height=8cm]{N-Hitec_images/Circle.pdf}
    \end{minipage}
  }
}
\pagestyle{plain}
\global\let\@author\@empty
\global\let\author\relax
\global\let\date\relax
}

% ========================================
% Redefinition of sections and subsections
% ========================================
\renewcommand{\thesection}{\@Roman\c@section}
\renewcommand{\thesubsection}{\@arabic\c@subsection}
\renewcommand{\thesubsubsection}{\@arabic\c@subsection.\@arabic\c@subsubsection}

% Numbered of not ?
\def\section{\@ifstar\unnumberedsection\numberedsection}

% Numbered section with 1 or 2 arguments
\def\numberedsection{\@ifnextchar[%
\numberedsectionwithtwoarguments\numberedsectionwithoneargument}

% Unnumbered section with 1 or 2 arguments
\def\unnumberedsection{\@ifnextchar[%]
  \unnumberedsectionwithtwoarguments\unnumberedsectionwithoneargument}

  % Numbered section with 1 argument => call with 2 arguments
  \def\numberedsectionwithoneargument#1{\numberedsectionwithtwoarguments[#1]{#1}}

  % Unnumbered section with 1 argument => call with 2 arguments
  \def\unnumberedsectionwithoneargument#1{\unnumberedsectionwithtwoarguments[#1]{#1}}

  % Unnumbered section with 2 arguments
  \def\unnumberedsectionwithtwoarguments[#1]#2{%
    \vskip 2mm\nobreak
    \begin{center}
      \fboxsep=5pt
      \fboxrule=1.5pt
      \begin{minipage}{0.9\textwidth}
        \centering%
        \vskip 0.8mm\nobreak
        \LARGE \textcolor{red_nhitec}{\textbf{#2}}%
        \vskip 1mm\nobreak
      \end{minipage}%
    \end{center}
    \vskip 2mm\nobreak

    \addcontentsline{toc}{section}{%
    #1}%
    \ignorespaces
  }

  % Numbered section with 2 arguments
  \def\numberedsectionwithtwoarguments[#1]#2{%
    \refstepcounter{section}%

    \vskip 2mm\nobreak
    \begin{center}
      \fboxsep=5pt
      \fboxrule=1.5pt
      \begin{minipage}{0.9\textwidth}
        \centering%
        \vskip 0.8mm\nobreak
        \LARGE \textcolor{red_nhitec}{\textbf{\thesection. #2}}%
        \vskip 1mm\nobreak
      \end{minipage}%
    \end{center}
    \vskip 2mm\nobreak

    \addcontentsline{toc}{section}{%
      \protect\numberline{\thesection}%
    #1}%
    \ignorespaces
  }

  \makeatother
