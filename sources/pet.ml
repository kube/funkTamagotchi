class pet =
  object (self : 'self)

  val savefile = "save.itama"

  val mutable _health:int  = 100
  val mutable _energy:int  = 100
  val mutable _hygiene:int = 100
  val mutable _happy:int   = 100

  method get_health = _health
  method get_energy = _energy
  method get_hygiene = _hygiene
  method get_happy = _happy

  method to_string = "Pet: health: " ^ (string_of_int _health)^ "/100,"
                    ^ " energy: " ^ (string_of_int _energy) ^ "/100,"
                    ^ " hygiene: " ^ (string_of_int _hygiene) ^ "/100,"
                    ^ " happy: " ^ (string_of_int _happy) ^ "/100"

  method eat () =
    _health <- (self#add _health 25);
    _energy <- (self#sub _energy 10);
    _hygiene <- (self#sub _hygiene 20);
    _happy <- (self#add _happy 5)


  method thunder () =
    _health <- (self#sub _health 20);
    _energy <- (self#add _energy 25);
    _happy <- (self#sub _happy 20)


  method bath () =
    _health <- (self#sub _health 20);
    _energy <- (self#sub _energy 10);
    _hygiene <- (self#add _hygiene 25);
    _happy <- (self#add _happy 5)


  method kill () =
    _health <- (self#sub _health 20);
    _energy <- (self#sub _energy 10);
    _happy <- (self#add _happy 20)


  method is_dead =
     (self#get_health = 0) || (self#get_energy = 0) ||  (self#get_hygiene = 0) || (self#get_happy = 0)


  method decr =
    _health <- (self#sub _health 1)


  method get_save =
    (* Check if save file exists *)
    try begin

      let ic = open_in savefile in
      try
        _health <- (int_of_string (input_line ic));
        _energy <- (int_of_string (input_line ic));
        _hygiene <- (int_of_string (input_line ic));
        _happy <- (int_of_string (input_line ic));
      with
        | End_of_file -> close_in ic;
        | _ -> failwith "Unknown"

    (* If cannot find save file, start new game *)
    end with
      | Sys_error msg -> self#regeneration


  method save =
    try begin

      let oc = open_out savefile in
      flush oc;
      output_string oc (string_of_int _health  ^ "\n");
      output_string oc (string_of_int _energy  ^ "\n");
      output_string oc (string_of_int _hygiene ^ "\n");
      output_string oc (string_of_int _happy   ^ "\n");
      close_out oc;

    end with
      | Sys_error msg -> print_endline ("Error while saving game data:\n" ^ msg)


  method regeneration =
    _health <- 100;
    _energy <- 100;
    _hygiene <- 100;
    _happy <- 100


  method get_sprite sprite = match sprite with
    | "eat"     -> "sprites/eat.gif"
    | "thunder" -> "sprites/thunder.gif"
    | "bath"    -> "sprites/bath.gif"
    | "kill"    -> "sprites/kill.gif"
    | _         -> "sprites/current.gif"


  method private add a b =

    if a + b > 100
    then 100
    else a + b


  method private sub a b =

    if a - b < 0 then 0
    else a - b

end
