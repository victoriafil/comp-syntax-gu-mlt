resource MicroResFre = {

param
-- define types of morphological parameters
  Number = Sg | Pl ;
  Gender = Masc | Fem ;
  VForm = Inf | Pres Number Person;
  Person = Per1 | Per2 | Per3 ;
  Case = Nom | Acc | Dat ; 
  Bool = True | False ;
  NPAgreement = NPAgr Number Person ;
  
oper
-- define types for parts of speech
-- they are recourd types with tables and inherent features
  Noun : Type = {s : Number => Str ; g : Gender} ;
  Adjective : Type = {s : Gender => Number => Str} ;
  Verb : Type = {s : VForm => Str} ;

-- here is an example that is type-correct as a Noun
  fille_N : Noun = {
    s = table {Sg => "fille" ; Pl => "filles"} ;
    g = Fem
    } ;

-- define constructor function for Noun
   mkNoun : Str -> Str -> Gender -> Noun = \sg, pl, g -> {
     s = table {Sg => sg ; Pl => pl} ;
     g = g
     } ;

-- define a noun using this constructor
   homme_N : Noun = mkNoun "homme" "hommes" Masc ;

-- define a smart paradigm/pattern matching
    smartNoun : Str -> Gender -> Noun = \s,g -> case s of {
     x + "onne" => mkNoun s (x + "onnes") g ;
     x + "teur" => mkNoun s (x + "teurs") g ;
     x + ("al" | "au") => mkNoun s (x + "aux") g ;
     x + "ue" => mkNoun s (x + "ues") g ;
     _ => mkNoun s (s + "s") g
     } ;

-- the overloaded paradigm is what the lexicon will use
   mkN = overload {
     mkN : Str -> Gender -> Noun = smartNoun ;
     mkN : Str -> Str -> Gender -> Noun = mkNoun ;
     mkN : Gender -> Noun -> Noun = \g, n -> n ** {g = g} ;
     } ;

-- adjectives:
   mkAdjective : (msg,fsg,mpl,fpl : Str) -> Adjective = \msg,fsg,mpl,fpl -> {
     s = table {
       Masc => table {Sg => msg ; Pl => mpl} ;
       Fem => table {Sg => fsg ; Pl => fpl}
       }
     } ;
     
   smartAdjective : Str -> Adjective = \s -> case s of {
     x + "el" => mkAdjective s (x + "elle") (x + "els") (x + "elles") ; 
     x + "er" => mkAdjective s (x + "ère") (x + "ers") (x + "ères") ;
     x + "eur" => mkAdjective s (x + "euse") (x + "eurs") (x + "euses") ; 
     x + "en" => mkAdjective s (x + "enne") (x + "ens") (x + "ennes") ; 
     x + "g" => mkAdjective s (x + "gue") (x + "gs") (x + "gues") ;
     x + "ieux" => mkAdjective s (x + "ieille") s (x + "ieilles") ;
     x + "au" => mkAdjective s (x + "lle") (s + "x") (x + "lles") ;
     x + "on" => mkAdjective s (s + "ne") (s + "s") (s + "nes") ;
     x + "e" => mkAdjective s s (s + "s") (s + "s") ;
     x + "ais" => mkAdjective s (s + "e") s (s + "es") ;
     _ => mkAdjective s (s + "e") (s + "s") (s + "es")
     } ;

   mkA = overload {
     mkA : Str -> Adjective = smartAdjective ;
     mkA : (msg,fsg,mpl,fpl : Str) -> Adjective = mkAdjective ;
     } ;
  
-- verbs:
    
   mkPres : (inf,p1,p2,p3,p4,p5,p6 : Str) -> Verb = \inf,pres1,pres2,pres3,pres4,pres5,pres6 -> {
       s = table {
         Inf => inf ;
         Pres Sg Per1 => pres1 ;
         Pres Sg Per2 => pres2 ;
         Pres Sg Per3 => pres3 ;
         Pres Pl Per1 => pres4 ;
         Pres Pl Per2 => pres5 ;
         Pres Pl Per3 => pres6 
      }
   } ; 
   
   mkVerb : Str -> Verb = \inf -> case inf of {
      (man + "ger") => mkPres inf (man + "ge") (man + "ges") (man + "ge") (man + "geons") (man + "gez") (man + "gent") ;
      (achet + "er") => mkPres inf (achet + "e") (achet + "es") (achet + "e") (achet + "ons") (achet + "ez") (achet + "ent") ;
      (dorm + "ir") => mkPres inf (dorm + "is") (dorm + "is") (dorm + "it") (dorm + "issons") (dorm + "issez") (dorm + "issent") ;
      (attend + "re") => mkPres inf (attend + "s") (attend + "s") attend (attend + "ons") (attend + "ez") (attend + "ent") ;
      _ => mkPres inf inf inf inf inf inf inf
    } ;

   
   be_Verb : Verb = mkPres "avoir" "suis" "es" "est" "sommes" "êtes" "sont" ;
   
   mkV = overload {
     mkV : Str -> Verb = \n -> lin V (mkVerb n) ;
     mkV : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Verb = mkPres ;
     } ;
   
   -- two-place verb with "case" as preposition; for transitive verbs, c=[]
   Verb2 : Type = Verb ** {cp : Str} ;
   
   agr2vform : NPAgreement -> VForm = \a -> case a of {
      NPAgr n p => Pres n p 
    } ;
}