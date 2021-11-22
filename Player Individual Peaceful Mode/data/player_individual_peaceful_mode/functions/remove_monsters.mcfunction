# function to be called every tick.
# removes all monsters close to a peaceful-player that have not been explicitly marked for persistence.
#
# called by: player_individual_peaceful_mode:tick

# tags:
#   PeacefulPlayer: marks peaceful-players
#   PeacefulPersisted: marks monsters that should not be removed

# temporary tags:
#   r: monster that should be removed
#   v: monster that may additionally vanish (i.e. has not picked up items)

# find monsters that have to be removed (i.e. close to players) -> tag r
execute at @a[tag=PeacefulPlayer] run tag @e[type=#player_individual_peaceful_mode:monsters,distance=..24,tag=!PeacefulPersisted] add r

# of those, decide if they can vanish (i.e. don't have anything picked up) -> v
# TODO can this be improved? maybe test for being nametaged, hand and armor items and CanPickUpLoot, or item drop chances?
tag @e[tag=r,nbt={PersistenceRequired:0b}] add v

# make them invisible and, if they can vanish, take away their stuff (so we don't see that either) and tp them into the void
effect give @e[tag=r] minecraft:invisibility 2 0 true
execute as @e[tag=v] run data merge entity @s {HandItems:[{},{}],ArmorItems:[{},{},{},{}],CanPickUpLoot:0b}
tp @e[tag=v] ~ -400 ~
# now kill them to be sure
kill @e[tag=r]
# remove temporary tags to avoid interference with other datapacks
tag @e[tag=v] remove v
tag @e[tag=r] remove r
