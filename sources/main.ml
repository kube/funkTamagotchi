
let () =
  let pet = new Pet.pet in
  pet#get_save;

  if pet#is_dead then
    pet#regeneration;

  let ui = new Ui.ui pet in
  ui#init
