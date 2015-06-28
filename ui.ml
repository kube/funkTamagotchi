class ui =
  object (self)

    val mutable petImage = GMisc.image ()

    method init =

      GtkMain.Main.init ();
      let window = GWindow.window ~border_width:10
                    ~width:600
                    ~height:450
                    ~title:"Instant Tama" () in

      let vbox = GPack.vbox ~packing:window#add () in
      let sbox = GPack.hbox ~packing:vbox#add () in

      self#createStatBar sbox;
      self#createPetZone vbox;
      self#createActionButtons vbox;

      let timer = (GMain.Timeout.add ~ms:1000 ~callback:(self#loopHandler)) in

      window#connect#destroy ~callback:self#destroy;
      window#show();
      GMain.Main.main ()


    method createStatBar sbox =

      let stat_health = GRange.progress_bar ~packing:sbox#add () in
      let stat_energy = GRange.progress_bar ~packing:sbox#add () in
      let stat_hygiene = GRange.progress_bar ~packing:sbox#add () in
      let stat_happy = GRange.progress_bar ~packing:sbox#add () in
      stat_health#set_text "HEALTH";
      stat_energy#set_text "ENERGY";
      stat_hygiene#set_text "HYGIENE";
      stat_happy#set_text "HAPPY"


    method createActionButtons vbox =

      let bbox = GPack.hbox ~packing:vbox#add () in
      let button_eat = GButton.button ~label:"EAT" ~packing:bbox#add () in
      let button_thunder = GButton.button ~label:"THUNDER" ~packing:bbox#add () in
      let button_bath = GButton.button ~label:"BATH" ~packing:bbox#add () in
      let button_kill = GButton.button ~label: "KILL" ~packing:bbox#add () in

      button_eat#connect#clicked ~callback:((fun () -> print_endline "OK"));
      button_thunder#connect#clicked ~callback:((fun () -> print_endline "OK"));
      button_bath#connect#clicked ~callback:((fun () -> print_endline "OK"));
      button_kill#connect#clicked ~callback:((fun () -> print_endline "OK"))


    method createPetZone vbox =

      let pbox = GPack.hbox ~height:350 ~packing:vbox#add () in
      petImage <- GMisc.image ~file:"sprites/Kuchipatchi_ninja.png" ~packing:pbox#add ~show:true ()


    method loopHandler () =

      print_endline "Update";
      true


    method destroy () =

      GMain.Main.quit ()

  end
