--# -path=.:../abstract
concrete MicroLangFre of MicroLang = open MicroResFre in {

-----------------------------------------------------
---------------- Grammar part -----------------------
-----------------------------------------------------

  lincat

    Utt = {s : Str} ;
    
    S  = {s : Str} ;
    VP = {verb : Verb ; compl : Gender => Number => Str} ; 
    Comp = {s : Gender => Number => Str} ;
    AP = Adjective ; -- s : Gender => Number => Str
    CN = Noun ; -- s: Number => Str ; g : Gender

    NP = {s : Case => Str ; a : NPAgreement ; g : Gender ; n : Number ; isPron : Bool} ;
    Pron = {s : Case => Str ; a : NPAgreement ; g : Gender ; n : Number} ;
    
    Prep = {s : Str} ;
    Det = {s : Gender => Str ; n : Number} ;
    V = Verb ; -- VForm => Str
    V2 = Verb2 ;
 
    A = Adjective ; -- Gender => Number => Str
    N = Noun ;
    Adv = {s : Str} ;

  lin
   
 
    UttS s = s ;
    UttNP np = {s = np.s ! Acc} ;

    PredVPS np vp = {
      s = np.s ! Nom ++ vp.verb.s ! agr2vform np.a ++ vp.compl ! np.g ! np.n
      } ;
      
    UseV v = {
      verb = v ;
      compl = table { g => table { n => []}} ;
      } ;    
      
    ComplV2 v2 np = {
      verb = case np.isPron of { 
      True => v2 ** { s = \\vf => v2.cp ++ np.s ! Acc ++ v2.s ! vf} ; 
      False => v2 } ;
      compl = case np.isPron of { 
      True => \\g,n => [] ; 
      False => table { g => table { n => v2.cp ++ np.s ! Acc }} 
      }
     } ;
    
    UseComp comp = {
      verb = be_Verb ;   
      compl = comp.s
      } ;

    CompAP ap = {s = table {
        g => table {
            n => ap.s ! g ! n}
      }} ;
      
    AdvVP vp adv = vp ** {comp = \\a => vp.comp ! a ++ adv.s} ;
    
    DetCN det cn = {
      s = table {c => det.s ! cn.g ++ cn.s ! det.n} ;
      a = NPAgr det.n Per3;
      g = cn.g ;
      n = det.n ;
      isPron = False ;
     } ;
   
    UsePron p = p ** { isPron = True} ;
   
    thePl_Det = {s = table { Masc => "les" ; Fem => "les" } ; n = Pl };
    the_Det = {s = table { Masc => pre { "a"|"e"|"i"|"o"|"u" => "l'"; _ => "le" } ;
                         Fem => pre { "a"|"e"|"o" => "l'"; _ => "la" } } ;
                         n = Sg };                     
    a_Det = {s = table { Masc => "un" ; Fem => "une" } ; n = Sg };
    aPl_Det = {s = table { Masc => "des" ; Fem => "des" } ; n = Pl };
    
    UseN n = n ;

    AdjCN ap cn = {
      s = table {n => cn.s ! n ++ ap.s ! cn.g ! n} ;
      g = cn.g
      } ;

    PositA a = a ;

    PrepNP prep np = {s = prep.s ++ np.s ! Dat} ;
    
    in_Prep = {s = "dans"} ;
    on_Prep = {s = "sur"} ;
    with_Prep = {s = "avec"} ;


    he_Pron = {
      s = table {Nom => "il" ; Acc => pre { "a"|"e"|"i"|"o"|"u" => "l'"; _ => "le" } ; Dat => "lui" } ;
      a = NPAgr Sg Per3 ;
      g = Masc ;
      n = Sg ;
      } ;
    she_Pron = {
      s = table {Nom => "elle" ; PronAcc => pre { "a"|"e"|"i"|"o"|"u" => "l'"; _ => "la"} ; Dat => "elle" } ;
      a = NPAgr Sg Per3 ;
      g = Fem ;
      n = Sg ;
      } ;
    they_Pron = {
      s = table {Nom => "ils" ; Acc => "les" ; Dat => "eux"} ;
      a = NPAgr Pl Per3 ;
      g = Masc ; -- could not figure out a way to include the feminine form in this one
      n = Pl ;
      } ;

-----------------------------------------------------
---------------- Lexicon part -----------------------
-----------------------------------------------------

lin already_Adv = mkAdv "déjà" ;
lin animal_N = mkN "animal" Masc ;
lin apple_N = mkN "pomme" Fem ;
lin baby_N = mkN "bébé" Masc ;
lin bad_A = mkA "mauvais" ;
lin beer_N = mkN "bière" Fem ;
lin big_A = mkA "grand" ;
lin bike_N = mkN "vélo" Masc ;
lin bird_N = mkN "oiseau" Masc ;
lin black_A = mkA "noir" ;
lin blood_N = mkN "sang" Masc ;
lin blue_A = mkA "bleu" ;
lin boat_N = mkN "bateau" Masc ;
lin book_N = mkN "livre" Masc ;
lin boy_N = mkN "garçon" Masc ;
lin bread_N = mkN "pain" Masc ;
lin break_V2 = mkV2 (mkV "casser") ;
lin buy_V2 = mkV2 (mkV "acheter") ;
lin car_N = mkN "voiture" Fem ;
lin cat_N = mkN "chat" Masc ;
lin child_N = mkN "enfant" Masc ;
lin city_N = mkN "ville" Fem ;
lin clean_A = mkA "propre" ;
lin clever_A = mkA "intelligent" ;
lin cloud_N = mkN "nuage" Masc ;
lin cold_A = mkA "froid" ;
lin come_V = mkV "venir" "viens" "viens" "vient" "venons" "venez" "viennent" ;
lin computer_N = mkN "ordinateur" Masc ;
lin cow_N = mkN "vache" Fem ;
lin dirty_A = mkA "sale" ;
lin dog_N = mkN "chien" Masc ;
lin drink_V2 = mkV2 (mkV "boire" "bois" "bois" "boit" "buvons" "buvez" "boivent") ;
lin eat_V2 = mkV2 (mkV "manger") ;
lin find_V2 = mkV2 (mkV "decouvrir") ;
lin fire_N = mkN "feu" Masc ;
lin fish_N = mkN "poisson" Masc ;
lin flower_N = mkN "fleur" Fem ;
lin friend_N = mkN "copin" Masc ;
lin girl_N = mkN "fille" Fem ;
lin good_A = mkA "bon" ;
lin go_V = mkV "aller" "vais" "vas" "va" "allons" "allez" "vont" ;
lin grammar_N = mkN "grammaire" Fem ;
lin green_A = mkA "vert" ;
lin heavy_A = mkA "lourd" ;
lin horse_N = mkN "cheval" Masc ;
lin hot_A = mkA "chaud" ;
lin house_N = mkN "maison" Fem ;
--lin john_PN = mkPN "John" ;
lin jump_V = mkV "sauter" ;
lin kill_V2 = mkV2 (mkV "tuer") ;
--lin know_VS = mkVS (mkV "know" "knew" "known") ;
lin language_N = mkN "langue" Fem ;
lin live_V = mkV "vivre" "vis" "vis" "vit" "vivons" "vivez" "vivent" ;
lin love_V2 = mkV2 (mkV "aimer") ;
lin man_N = mkN "homme" Masc ;
lin milk_N = mkN "lait" Masc ;
lin music_N = mkN "musique" Fem ;
lin new_A = mkA "nouveau" ;
lin now_Adv = mkAdv "maintenant" ;
lin old_A = mkA "vieux" ;
--lin paris_PN = mkPN "Paris" ;
lin play_V = mkV "jouer" ;
lin read_V2 = mkV2 (mkV "lire" "lis" "lis" "lit" "lisons" "lisez" "lisent") ;
lin ready_A = mkA "prêt" ;
lin red_A = mkA "rouge" ;
lin river_N = mkN "rivière" Masc ;
lin run_V = mkV "courir" ;
lin sea_N = mkN "mer" Fem ;
lin see_V2 = mkV2 (mkV "voir" "vois" "vois" "voit" "voyons" "voyez" "voient") ;
lin ship_N = mkN "navire" Masc ;
lin sleep_V = mkV "dormir" ;
lin small_A = mkA "petit" ;
lin star_N = mkN "étoile" Fem ;
lin swim_V = mkV "nager" ;
lin teach_V2 = mkV2 (mkV "enseigner") ;
lin train_N = mkN "train" Masc ;
lin travel_V = mkV "voyager" ;
lin tree_N = mkN "arbre" Masc ;
lin understand_V2 = mkV2 (mkV "comprendre" "comprends" "comprends" "comprend" "comprenons" "comprenez" "comprennent") ;
lin wait_V2 = mkV2 (mkV "attendre") "à" ; 
lin walk_V = mkV "marcher" ;
lin warm_A = mkA "chaud" ;
lin water_N = mkN "eau" Fem ;
lin white_A = mkA "blanc" ;
lin wine_N = mkN "vin" Masc ;
lin woman_N = mkN "femme" Fem ;
lin yellow_A = mkA "jaune" ;
lin young_A = mkA "jeune" ;

---------------------------
-- Paradigms part ---------
---------------------------

oper

 mkV2 = overload {
    mkV2 : V -> V2            -- any verb with direct object, e.g. "drink"
      = \v   -> lin V2 (v ** {cp = []}) ;
    mkV2 : V -> Str -> V2     -- any verb with preposition
      = \v,p -> lin V2 (v ** {cp = p}) ;
    } ;
    
 --
 
  mkAdv : Str -> Adv
    = \s -> lin Adv {s = s} ;
  
  mkPrep : Str -> Prep
    = \s -> lin Prep {s = s} ;

}