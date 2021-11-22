# calls player_individual_peaceful_mode:remove_monsters when necessary.
#
# called by: #minecraft:tick

execute if entity @a[tag=PeacefulPlayer] run function player_individual_peaceful_mode:remove_monsters
