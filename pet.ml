(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   pet.ml                                             :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: gchateau <gchateau@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/27 14:30:03 by gchateau          #+#    #+#             *)
(*   Updated: 2015/06/27 18:15:05 by gchateau         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

class pet =
  object (self : 'self)
	val mutable _health:int = 100
	val mutable _energy:int = 100
	val mutable _hygiene:int = 100
	val mutable _happy:int = 100

	method get_health = _health
	method get_energy = _energy
	method get_hygiene = _hygiene
	method get_happy = _happy

	method to_string = "Pet: health: " ^ (string_of_int _health) ^ "/100, energy: " ^ (string_of_int _energy) ^ "/100, hygiene: " ^ (string_of_int _hygiene) ^ "/100, happy: " ^ (string_of_int _happy) ^ "/100"

	method eat =
	  _health <- (self#add _health 25);
	  _energy <- (self#sub _energy 10);
	  _hygiene <- (self#sub _hygiene 20);
	  _happy <- (self#add _happy 5)

	method thunder =
	  _health <- (self#sub _health 20);
	  _energy <- (self#add _energy 25);
	  _happy <- (self#sub _happy 20)

	method bath =
	  _health <- (self#sub _health 20);
	  _energy <- (self#sub _energy 10);
	  _hygiene <- (self#add _hygiene 25);
	  _happy <- (self#add _happy 5)

	method kill =
	  _health <- (self#sub _health 20);
	  _energy <- (self#sub _energy 10);
	  _happy <- (self#add _happy 20)

	method die =
	  print_endline "Game Over !!"

	method decr =
	  _health <- (self#sub _health 1)

	method update =
	  print_endline "update bars !"

	method recover =
	  print_endline "Recover !!"

	method save =
	  print_endline "Save !!"

	method private add a b =
	  if a + b > 100 then 100
	  else a + b

	method private sub a b =
	  if a - b < 0 then (print_endline "Game Over !!"; self#save; exit 0; 0)
	  else a - b
  end

(* ************************************************************************** *)
