	//Andyman105
/obj/item/device/communicator/andy
	icon = 'content_arfs/icons/obj/device/andy_communcator.dmi'

/obj/item/device/resizer
	name = "resizer"
	desc = "A device that resizes the user"
	icon_state = "capacitor"
	item_state = "capacitor"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = ITEMSIZE_SMALL
	throw_speed = 5
	throw_range = 10
	var/cooldown = 300
	var/cooling = 0

/obj/item/device/resizer/attack(mob/living/M, mob/living/U)
	if(U != M) //Must be used on self
		to_chat(U, "<span class='notice'>You cannot use this on another person!</span>")
		return
	if(cooling) //Must not be cooling down
		to_chat(U, "<span class='notice'>The device is recharging!</span>")
		return
	if(!ishuman(U)) //Must be human
		to_chat(U, "<span class='warning'>You must be a human to use this!</span>")
		return
	if(!ishuman(M)) //Must be human
		to_chat(U, "<span class='warning'>You cannot use this on this lifeform!</span>")
		return

	var/size_select = input("Put the desired size (50-200%)", "Set Size") as num
	if(size_select>200 || size_select<50)
		usr << "<span class='notice'>Invalid size.</span>"
		return

	U.resize(size_select/100)
	U.updateicon()
	cooling = 1
	spawn(cooldown)
		cooling = 0

/obj/item/weapon/commcard/resizer
	name="\improper Resizer"

/obj/item/weapon/commcard/resizer/New()
	..()
	internal_devices |= new /obj/item/device/resizer(src)

