# latexmk-Konfiguration: `latexmk example.tex` baut das komplette Dokument
# (pdfLaTeX -> bib2gls -> Biber -> pdfLaTeX ...). Funktioniert auch auf Overleaf.
#
# Für LuaLaTeX: `latexmk -lualatex example.tex`

$pdf_mode = 1;            # pdfLaTeX (Standard)
$bibtex_use = 2;          # Biber automatisch ausführen
$postscript_mode = $dvi_mode = 0;

# bib2gls: erzeugt aus der .aux-Datei die .glstex-Dateien für glossaries-extra
add_cus_dep('aux', 'glstex', 0, 'run_bib2gls');
sub run_bib2gls {
    my $ret = system("bib2gls", $silent ? ("--silent") : (), $_[0]);
    my ($base, $path) = fileparse($_[0]);
    if ($path && -e $base . ".glstex") {
        rename $base . ".glstex", $path . $base . ".glstex";
    }
    # erzeugte Dateien bei latexmk bekannt machen
    local *LOG;
    my $logfile = "$_[0].glg";
    if (open(LOG, "<", $logfile)) {
        while (<LOG>) {
            if (/^Writing (.*\.glstex)/) { rdb_add_generated($1); }
        }
        close(LOG);
    }
    return $ret;
}

push @generated_exts, 'glstex', 'glg';
$clean_ext .= ' %R.ist %R.xdy %R.bbl %R.run.xml %R.lol';
