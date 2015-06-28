class ui =
  object (self)

    val mutable petImage = GMisc.image ()
    
    val mutable window   = GWindow.window ()
    val mutable vbox     = GPack.vbox ()
    val mutable sbox     = GPack.hbox ()
    val mutable pbox     = GPack.hbox ()


    method init =

      GtkMain.Main.init ();
      window <- GWindow.window ~border_width:10
                    ~width:600
                    ~height:450
                    ~title:"Instant Tama" ();
      vbox <- GPack.vbox ~packing:window#add ();
      sbox <- GPack.hbox ~packing:vbox#add ();
      pbox <- GPack.hbox ~height:350 ~packing:vbox#add ();

      self#createStatBar ;
      self#createPetZone ;
      self#createActionButtons ;
      
      
      (* event loop *)
      ignore (GMain.Timeout.add ~ms:1000 ~callback:(self#loopHandler));
      

      window#connect#destroy ~callback:self#destroy;
      window#show();
      GMain.Main.main ()


    method createStatBar =

      let stat_health = GRange.progress_bar ~packing:sbox#add () in
      let stat_energy = GRange.progress_bar ~packing:sbox#add () in
      let stat_hygiene = GRange.progress_bar ~packing:sbox#add () in
      let stat_happy = GRange.progress_bar ~packing:sbox#add () in
      stat_health#set_text "HEALTH";
      stat_energy#set_text "ENERGY";
      stat_hygiene#set_text "HYGIENE";
      stat_happy#set_text "HAPPY"


    method createActionButtons =

      let bbox = GPack.hbox ~packing:vbox#add () in
      let button_eat = GButton.button ~label:"EAT" ~packing:bbox#add () in
      let button_thunder = GButton.button ~label:"THUNDER" ~packing:bbox#add () in
      let button_bath = GButton.button ~label:"BATH" ~packing:bbox#add () in
      let button_kill = GButton.button ~label: "KILL" ~packing:bbox#add () in


      button_eat#connect#clicked ~callback:((fun () -> self#drawImage "sprites/Kuchipatchi_anime.png"));
      button_thunder#connect#clicked ~callback:((fun () -> print_endline "OK"));
      button_bath#connect#clicked ~callback:((fun () -> print_endline "OK"));
      button_kill#connect#clicked ~callback:((fun () -> print_endline "OK"))


    method createPetZone =
      petImage <- GMisc.image ~file:"sprites/Kuchipatchi_ninja.png" ~packing:pbox#add ~show:true ()

    method drawImage link = 
      petImage#clear ();
      petImage <- GMisc.image ~file:link ~packing:pbox#add ~show:true ()


    method loopHandler () =

      print_endline "Update";
      true


    method destroy () =

      GMain.Main.quit ()

  end
