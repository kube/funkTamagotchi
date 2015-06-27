let pet = new Pet.pet

let progress_timeout hebar enbar hybar habar () =
  pet#decr;
  hebar#set_fraction ((float_of_int pet#get_health) /. 100.);
  enbar#set_fraction ((float_of_int pet#get_energy) /. 100.);
  hybar#set_fraction ((float_of_int pet#get_hygiene) /. 100.);
  habar#set_fraction ((float_of_int pet#get_happy) /. 100.);
  print_endline ("\nhealth: (" ^ (string_of_int pet#get_health) ^ ") " ^ (string_of_float ((float_of_int pet#get_health) /. 100.)));
  print_endline ("energy: (" ^ (string_of_int pet#get_energy) ^ ") " ^ (string_of_float ((float_of_int pet#get_energy) /. 100.)));
  print_endline ("hygiene: (" ^ (string_of_int pet#get_hygiene) ^ ") " ^ (string_of_float ((float_of_int pet#get_hygiene) /. 100.)));
  print_endline ("happy: (" ^ (string_of_int pet#get_happy) ^ ") " ^ (string_of_float ((float_of_int pet#get_happy) /. 100.)));
  true

let callback_eat hebar enbar hybar habar () =
  print_endline "Clicked EAT!";
  pet#eat;
  hebar#set_fraction ((float_of_int pet#get_health) /. 100.);
  enbar#set_fraction ((float_of_int pet#get_energy) /. 100.);
  hybar#set_fraction ((float_of_int pet#get_hygiene) /. 100.);
  habar#set_fraction ((float_of_int pet#get_happy) /. 100.);
  print_endline pet#to_string

let callback_thunder hebar enbar hybar habar () =
  print_endline "Clicked THUNDER!";
  pet#thunder;
  hebar#set_fraction ((float_of_int pet#get_health) /. 100.);
  enbar#set_fraction ((float_of_int pet#get_energy) /. 100.);
  hybar#set_fraction ((float_of_int pet#get_hygiene) /. 100.);
  habar#set_fraction ((float_of_int pet#get_happy) /. 100.);
  print_endline pet#to_string

let callback_bath hebar enbar hybar habar () =
  print_endline "Clicked BATH!";
  pet#bath;
  hebar#set_fraction ((float_of_int pet#get_health) /. 100.);
  enbar#set_fraction ((float_of_int pet#get_energy) /. 100.);
  hybar#set_fraction ((float_of_int pet#get_hygiene) /. 100.);
  habar#set_fraction ((float_of_int pet#get_happy) /. 100.);
  print_endline pet#to_string

let callback_kill hebar enbar hybar habar () =
  print_endline "Clicked KILL!";
  pet#kill;
  hebar#set_fraction ((float_of_int pet#get_health) /. 100.);
  enbar#set_fraction ((float_of_int pet#get_energy) /. 100.);
  hybar#set_fraction ((float_of_int pet#get_hygiene) /. 100.);
  habar#set_fraction ((float_of_int pet#get_happy) /. 100.);
  print_endline pet#to_string

let destroy () =
  pet#save;
  GMain.Main.quit ()

let main () =
  ignore (GtkMain.Main.init ());
  let window = GWindow.window	~border_width:10
								~width:800
								~height:600
								~title:"Instant Tama" () in
	ignore (window#connect#destroy ~callback:destroy);
  let vbox = GPack.vbox ~packing:window#add () in
  let sbox = GPack.hbox ~packing:vbox#add () in
	let stat_health = GRange.progress_bar ~packing:sbox#add () in
	let stat_energy = GRange.progress_bar ~packing:sbox#add () in
	let stat_hygiene = GRange.progress_bar ~packing:sbox#add () in
	let stat_happy = GRange.progress_bar ~packing:sbox#add () in
	  stat_health#set_text "HEALTH";
	  stat_energy#set_text "ENERGY";
	  stat_hygiene#set_text "HYGIENE";
	  stat_happy#set_text "HAPPY";
	  stat_health#set_fraction ((float_of_int pet#get_health) /. 100.);
	  stat_energy#set_fraction ((float_of_int pet#get_energy) /. 100.);
	  stat_hygiene#set_fraction ((float_of_int pet#get_hygiene) /. 100.);
	  stat_happy#set_fraction ((float_of_int pet#get_happy) /. 100.);
	  let timer = GMain.Timeout.add ~ms:1000 ~callback:(progress_timeout stat_health stat_energy stat_hygiene stat_happy) in
  let pbox = GPack.hbox ~height:350 ~packing:vbox#add () in
  let bbox = GPack.hbox ~packing:vbox#add () in
	let button_eat = GButton.button	~label:"EAT" ~packing:bbox#add () in
	let button_thunder = GButton.button ~label:"THUNDER" ~packing:bbox#add () in
	let button_bath = GButton.button ~label:"BATH" ~packing:bbox#add () in
	let button_kill = GButton.button ~label: "KILL" ~packing:bbox#add () in
	  ignore (button_eat#connect#clicked ~callback:(callback_eat stat_health stat_energy stat_hygiene stat_happy));
	  ignore (button_thunder#connect#clicked ~callback:(callback_thunder stat_health stat_energy stat_hygiene stat_happy));
	  ignore (button_bath#connect#clicked ~callback:(callback_bath stat_health stat_energy stat_hygiene stat_happy));
	  ignore (button_kill#connect#clicked ~callback:(callback_kill stat_health stat_energy stat_hygiene stat_happy));
	  window#show ();
	  GMain.Main.main ()

(* ************************************************************************** *)
let () = main ()

(* ignore (button_eat#connect#clicked ~callback:window#destroy); *)
