# hsos-report – LaTeX-Klasse für die Hochschule Osnabrück

Inoffizielle LaTeX-Klasse für Haus-, Projekt- und Abschlussarbeiten an der
Hochschule Osnabrück (Titelseite, Kopf-/Fußzeilen, Farben, Glossar,
Literaturverzeichnis). `example.tex` zeigt den kompletten Aufbau einer Arbeit.

> **Hinweis:** Wortlaut der eidesstattlichen Erklärung, eventuelle Angaben zur
> Nutzung von KI-Werkzeugen sowie die Einwilligung zur Plagiatsprüfung gibt die
> jeweils gültige Prüfungsordnung vor. Bitte `misc/affidavit.tex` vor der Abgabe
> prüfen und anpassen.

## Bauen

Benötigt wird eine aktuelle TeX-Distribution (TeX Live ≥ 2021 oder MiKTeX) mit
Biber und bib2gls (bib2gls braucht Java).

```sh
latexmk example.tex            # pdfLaTeX
latexmk -lualatex example.tex  # LuaLaTeX
latexmk -c                     # Hilfsdateien aufräumen
```

Die mitgelieferte `latexmkrc` ruft pdfLaTeX, bib2gls und Biber in der
richtigen Reihenfolge auf. Auf Overleaf wird sie automatisch verwendet.

Manuell: `pdflatex example` → `bib2gls example` → `biber example` →
`pdflatex example` (2×).

## Klassenoptionen

```latex
\documentclass[thesis,onehalfspacing]{hsos-report}
```

| Option           | Wirkung                                                         |
|------------------|-----------------------------------------------------------------|
| `thesis`         | Titelseite mit Erst- und Zweitprüfer:in                         |
| `print`          | Breiterer Innenrand für die Bindung                             |
| `twoside`        | Doppelseitig: Kapitel rechts, Kopf-/Fußzeile gespiegelt         |
| `black`          | Links und Zitate schwarz statt HSOS-Blau                        |
| `onehalfspacing` | Zeilenabstand 1,5 (Standard 1,2)                                |
| `english`        | Englisch als Dokumentsprache (Standard: Deutsch)                |
| `10pt`/`12pt`    | Schriftgröße (Standard 11pt); weitere Optionen gehen an `report` |

## Angaben zur Arbeit

```latex
\longtitle{Langer Titel der Arbeit}
\shorttitle{Kurztitel}          % Fußzeile
\author{Max Mustermann}
\studentnumber{000000}
\kindofdoc{Bachelorarbeit}
\major{Informatik}
\startdate{01.04.2026}
\releasedate{01.07.2026}
\firstexaminer{Prof. Dr. A}
\secondexaminer{Prof. Dr. B}    % nur mit Option thesis
% optional
\faculty{Fakultät\\[6pt]Ingenieurwissenschaften und Informatik}
\headerlogo{HS-OS-Logo-Kompakt-Schwarz}
\titlelogo{titlepage-logo}
```

Weitere Befehle: `\hsosplainstyle{<seitenstil>}` (Seitenstil von Kapitelseiten),
`\hsossignature` (Unterschriftszeile), `\fnurl{url}{text}` (Link mit URL in der
Fußnote). Seitenstile: `hsos-layout`, `hsos-only-logo`, `hsos-logo-and-foot`,
`hsos-logo-and-foot-with-page`, `only-foot-with-page`.

## Änderungen in Version 2.0

- Fehlendes Kopfzeilen-Logo `graphics/HS-OS-Logo-Kompakt-Schwarz.jpg` ergänzt
  (der Build auf `master` brach ohne die Datei ab); fehlende Logos erzeugen
  jetzt nur eine Warnung und einen Platzhalter.
- Deutsch mit neuer Rechtschreibung (`ngerman` statt `german`) –
  **im eigenen Dokument `\selectlanguage{german}` durch `ngerman` ersetzen.**
- `inputenc` entfernt (UTF-8 ist seit LaTeX 2018 Standard), `mathptmx` durch
  `newtxtext`/`newtxmath` ersetzt, LuaLaTeX-Unterstützung (TeX Gyre Termes),
  `microtype`.
- `\author` ist wieder der Standardbefehl (PDF-Metadaten werden gesetzt),
  fehlende Angaben führen nicht mehr zu Fehlern.
- `\secoundexaminer` heißt jetzt `\secondexaminer` (alter Name funktioniert
  weiter).
- Neue Optionen `twoside`, `english`, Schriftgröße; `\faculty`, Logo-Befehle.
- Absatzabstand über `parskip`, `\setstretch` statt des internen `\spacing`.
- Verzeichniseinträge im Inhaltsverzeichnis verlinken auf die richtige Seite.
- Veralteten Hinweis auf die Plagiatssoftware „Ephorus“ entfernt.
- `latexmkrc` und GitHub-Actions-Workflow zum automatischen Bauen.
- Auskommentierter Altcode und die ungenutzte `misc/glossary.tex` entfernt.
