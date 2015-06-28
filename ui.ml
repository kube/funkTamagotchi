class ui (pet: Pet.pet) =
  object (self)

    val mutable window          = GWindow.window ()
    val mutable vbox            = GPack.vbox ()
    val mutable sbox            = GPack.hbox ()
    val mutable pbox            = GPack.hbox ()
    val mutable stat_health     = GRange.progress_bar ()
    val mutable stat_energy     = GRange.progress_bar ()
    val mutable stat_hygiene    = GRange.progress_bar ()
    val mutable stat_happy      = GRange.progress_bar ()
    val mutable petImage        = GMisc.image ()
    val mutable _action         = false

    method init =

      ignore (GtkMain.Main.init ());
      window <- GWindow.window ~border_width:10
                    ~width:250
                    ~height:200
                    ~title:"Instant Tama" ();
      vbox <- GPack.vbox ~packing:window#add ();
      sbox <- GPack.hbox ~packing:vbox#add ();
      pbox <- GPack.hbox ~height:100 ~width:250 ~packing:vbox#add ();

      self#createStatBar ;
      self#createPetZone ;
      self#createActionButtons ;
      
      
      (* event loop *)
      ignore (GMain.Timeout.add ~ms:1000 ~callback:(self#loopHandler));
      

      ignore (window#connect#destroy ~callback:self#destroy);
      window#show();
      GMain.Main.main ()


    method createStatBar =

      stat_health  <- GRange.progress_bar ~packing:sbox#add ();
      stat_energy  <- GRange.progress_bar ~packing:sbox#add ();
      stat_hygiene <- GRange.progress_bar ~packing:sbox#add ();
      stat_happy   <- GRange.progress_bar ~packing:sbox#add ();

      stat_health#set_text  "HEALTH";
      stat_energy#set_text  "ENERGY";
      stat_hygiene#set_text "HYGIENE";
      stat_happy#set_text   "HAPPY";

      stat_health#set_fraction ((float_of_int pet#get_health) /. 100.);
      stat_energy#set_fraction ((float_of_int pet#get_energy) /. 100.);
      stat_hygiene#set_fraction ((float_of_int pet#get_hygiene) /. 100.);
      stat_happy#set_fraction ((float_of_int pet#get_happy) /. 100.);

    method createActionButtons =

      let bbox = GPack.hbox ~packing:vbox#add () in
      let button_eat = GButton.button ~label:"EAT" ~packing:bbox#add () in
      let button_thunder = GButton.button ~label:"THUNDER" ~packing:bbox#add () in
      let button_bath = GButton.button ~label:"BATH" ~packing:bbox#add () in
      let button_kill = GButton.button ~label: "KILL" ~packing:bbox#add () in
      ignore (button_eat#connect#clicked     ~callback: ((fun () -> if _action = false then begin _action <- true; self#anim; pet#eat;     self#drawImage ((pet#get_sprite "eat"));     self#refresh end)));
      ignore (button_thunder#connect#clicked ~callback: ((fun () -> if _action = false then begin _action <- true; self#anim; pet#thunder; self#drawImage ((pet#get_sprite "thunder")); self#refresh end)));
      ignore (button_bath#connect#clicked    ~callback: ((fun () -> if _action = false then begin _action <- true; self#anim; pet#bath;    self#drawImage ((pet#get_sprite "bath"));    self#refresh end)));
      ignore (button_kill#connect#clicked    ~callback: ((fun () -> if _action = false then begin _action <- true; self#anim; pet#kill;    self#drawImage ((pet#get_sprite "kill"));    self#refresh end)));




    method anim  =
      ignore (GMain.Timeout.add ~ms:3000 ~callback: self#end_anim); 

    method end_anim () =
      self#drawImage (pet#get_sprite "current");
      _action <- false;
      false


    method createPetZone =
      petImage <- GMisc.image ~file:"sprites/current.gif" ~packing:pbox#add  ~show:true ()

    method drawImage link = 
      petImage#clear ();
      petImage <- GMisc.image ~file:link ~packing:pbox#add  ~show:true ()

    method refresh=
      if pet#is_dead then self#destroy ()
      else
        begin
            stat_health#set_fraction  ((float_of_int pet#get_health)  /. 100.);
            stat_energy#set_fraction  ((float_of_int pet#get_energy)  /. 100.);
            stat_hygiene#set_fraction ((float_of_int pet#get_hygiene) /. 100.);
            stat_happy#set_fraction   ((float_of_int pet#get_happy)   /. 100.);
        end


    method loopHandler () =
      pet#decr;
      self#refresh;
      true

    method destroy () =
      pet#save;
      GMain.Main.quit ()

  end
