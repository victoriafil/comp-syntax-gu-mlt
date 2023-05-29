concrete DrawFre of Draw =

  open SyntaxFre, ParadigmsFre, LexiconFre, IrregFre
  in {

lincat
  Command = Utt ;
  Object = CN ;
  ObjectRef = NP ;
  Shape = CN ;
  Colour = AP ;
  Size = AP ;
  Place = Adv ;

lin
  drawCommand object =
      mkUtt (mkImp (mkVP (mkV2 "dessiner") (mkNP a_Det object))) -- draw a circle
    | mkUtt (mkNP a_Det object)                              -- a circle
    | mkUtt object                                           -- circle
    ;
  removeCommand object =
      mkUtt (mkImp (mkVP (mkV2 "enlèver") object)) ; 
  moveCommand object place =
      mkUtt (mkImp (mkVP (mkVP (mkV2 "monter") object) place)) ;
      
  shapeObject size colour shape = mkCN size (mkCN colour shape) ;

  theObjectRef object = mkNP the_Det object ;
  itObjectRef = it_NP ;
  
  circle_Shape = mkCN (mkN "cercle") ;
  square_Shape = mkCN (mkN "carré") ;

  big_Size = mkAP big_A ;
  small_Size = mkAP small_A ;
  noSize = mkAP (mkA "") ; ---

  green_Colour = mkAP green_A ;
  red_Colour = mkAP red_A ;
  blue_Colour = mkAP blue_A ;
  yellow_Colour = mkAP yellow_A ;

  noColour = mkAP (mkA "") ; ---

  upPlace = pmkAdv "en haut" ;
  downPlace = pmkAdv "en bas" ;
  leftPlace = pmkAdv "à gauche" ;
  rightPlace = pmkAdv "à droite" ;
  midPlace = pmkAdv "au milieu" ;
  
  noPlace = pmkAdv "" ;

oper
  pmkAdv : Str -> Adv = ParadigmsEng.mkAdv ;
}