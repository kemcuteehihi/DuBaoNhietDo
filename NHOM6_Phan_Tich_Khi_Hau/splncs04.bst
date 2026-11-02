%% BibTeX bibliography style `splncs04'
ENTRY
  { address author booktitle chapter doi edition editor eid howpublished institution journal key month number organization pages publisher school series title type url volume year }
  {}
  { label }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }
FUNCTION {init.state.consts}
{ #0 'before.all := #1 'mid.sentence := #2 'after.sentence := #3 'after.block := }
STRINGS { s t}
FUNCTION {output.nonnull}
{ 's := output.state mid.sentence = { ", " * write$ } { output.state after.block = { add.period$ write$ " " * write$ } { output.state before.all = 'write$ { add.period$ " " * write$ } if$ } if$ mid.sentence 'output.state := } if$ s }
FUNCTION {output} { duplicate$ empty$ 'pop$ 'output.nonnull if$ }
FUNCTION {output.check} { 't := duplicate$ empty$ { pop$ "empty " t * " in " * cite$ * warning$ } 'output.nonnull if$ }
FUNCTION {fin.entry} { duplicate$ empty$ 'pop$ 'write$ if$ newline$ }
FUNCTION {new.block} { output.state before.all = 'skip$ { after.block 'output.state := } if$ }
FUNCTION {new.sentence} { output.state after.block = 'skip$ { output.state before.all = 'skip$ { after.sentence 'output.state := } if$ } if$ }
FUNCTION {not} { { #0 } { #1 } if$ }
FUNCTION {and} { 'skip$ { pop$ #0 } if$ }
FUNCTION {or} { { pop$ #1 } 'skip$ if$ }
STRINGS {z}
FUNCTION {remove.dots} { 'z := "" { z empty$ not } { z #1 #1 substring$ z #2 global.max$ substring$ 'z := duplicate$ "." = 'pop$ { * } if$ } while$ }
FUNCTION {field.or.null} { duplicate$ empty$ { pop$ "" } 'skip$ if$ }
FUNCTION {emphasize} { skip$ }
FUNCTION {embolden} { duplicate$ empty$ { pop$ "" } { "\textbf{" swap$ * "}" * } if$ }
FUNCTION {tie.or.space.prefix} { duplicate$ text.length$ #5 < { "~" } { " " } if$ swap$ }
FUNCTION {titto.space.prefix} { " " swap$ * " " * }
FUNCTION {capitalize} { "u" change.case$ "t" change.case$ }
FUNCTION {bbl.and} { "and"}
FUNCTION {bbl.etal} { "et~al." }
FUNCTION {bbl.editors} { "eds." }
FUNCTION {bbl.editor} { "ed." }
FUNCTION {bbl.edition} { "edn." }
FUNCTION {bbl.volume} { "vol." }
FUNCTION {titto.bbl.volume} { "" }
FUNCTION {bbl.in} { "in" }
FUNCTION {bbl.pages} { "pp." }
FUNCTION {bbl.page} { "p." }
FUNCTION {titto.bbl.pages} { "" }
FUNCTION {titto.bbl.page} { "" }
FUNCTION {bbl.chapter} { "chap." }
FUNCTION {bbl.techrep} { "Tech. Rep." }
FUNCTION {bbl.mthesis} { "Master's thesis" }
FUNCTION {bbl.phdthesis} { "Ph.D. thesis" }
MACRO {jan} {"Jan."} MACRO {feb} {"Feb."} MACRO {mar} {"Mar."} MACRO {apr} {"Apr."}
MACRO {may} {"May"} MACRO {jun} {"Jun."} MACRO {jul} {"Jul."} MACRO {aug} {"Aug."}
MACRO {sep} {"Sep."} MACRO {oct} {"Oct."} MACRO {nov} {"Nov."} MACRO {dec} {"Dec."}
FUNCTION {format.url} { url empty$ { "" } { "\url{" url * "}" * } if$ }
FUNCTION {format.doi} { doi empty$ { "" } { after.block 'output.state := "\doi{" doi * "}" * } if$ }
INTEGERS { nameptr namesleft numnames }
STRINGS { bibinfo }
FUNCTION {format.names} { 'bibinfo := duplicate$ empty$ 'skip$ { 's := "" 't := #1 'nameptr := s num.names$ 'numnames := numnames 'namesleft := { namesleft #0 > } { s nameptr "{vv~}{ll}{, jj}{, f{.}.}" format.name$ bibinfo bibinfo.check 't := nameptr #1 > { namesleft #1 > { ", " * t * } { s nameptr "{ll}" format.name$ duplicate$ "others" = { 't := } { pop$ } if$ "," * t "others" = { " " * bbl.etal * } { " " * t * } if$ } if$ } 't if$ nameptr #1 + 'nameptr := namesleft #1 - 'namesleft := } while$ } if$ }
FUNCTION {format.authors} { author "author" format.names }
FUNCTION {get.bbl.editor} { editor num.names$ #1 > 'bbl.editors 'bbl.editor if$ }
FUNCTION {format.editors} { editor "editor" format.names duplicate$ empty$ 'skip$ { " " * get.bbl.editor "(" swap$ * ")" * * } if$ }
FUNCTION {format.title} { title duplicate$ empty$ 'skip$ { "t" change.case$ } if$ "title" bibinfo.check }
FUNCTION {output.bibitem} { newline$ "\bibitem{" write$ cite$ * "}" * write$ newline$ "" before.all 'output.state := }
FUNCTION {n.dashify} { 't := "" { t empty$ not } { t #1 #1 substring$ "-" = { t #1 #2 substring$ "--" = not { "--" * t #2 global.max$ substring$ 't := } { { t #1 #1 substring$ "-" = } { "-" * t #2 global.max$ substring$ 't := } while$ } if$ } { t #1 #1 substring$ * t #2 global.max$ substring$ 't := } if$ } while$ }
FUNCTION {word.in} { bbl.in capitalize ":" * " " * }
FUNCTION {format.date} { month "month" bibinfo.check duplicate$ empty$ year "year" bibinfo.check duplicate$ empty$ { swap$ 'skip$ { "there's a month but no year in " cite$ * warning$ } if$ * } { swap$ 'skip$ { swap$ " " * swap$ } if$ * remove.dots } if$ duplicate$ empty$ 'skip$ { before.all 'output.state := " (" swap$ * ")" * } if$ }
FUNCTION {format.btitle} { title "title" bibinfo.check }
FUNCTION {format.pages} { pages duplicate$ empty$ 'skip$ { duplicate$ multi.page.check { bbl.pages swap$ n.dashify } { bbl.page swap$ } if$ tie.or.space.prefix "pages" bibinfo.check * * } if$ }
FUNCTION {article} { output.bibitem format.authors "author" output.check add.colon new.block format.title "title" output.check new.block crossref missing$ { journal "journal" bibinfo.check "journal" output.check add.blank format.vol.num.pages output format.date "year" output.check } { format.article.crossref output.nonnull format.pages output } if$ format.doi output format.url output format.note output fin.entry }
FUNCTION {default.type} { misc }
READ
ITERATE {presort}
SORT
FUNCTION {begin.bib} { preamble$ empty$ 'skip$ { preamble$ write$ newline$ } if$ "\begin{thebibliography}{" longest.label * "}" * write$ newline$ }
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib} { newline$ "\end{thebibliography}" write$ newline$ }
EXECUTE {end.bib}