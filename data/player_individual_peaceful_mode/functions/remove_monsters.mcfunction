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
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:cave_spider,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:creeper,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:drowned,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:enderman,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:endermite,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:guardian,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:husk,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:phantom,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:silverfish,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:skeleton,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:slime,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:spider,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:stray,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:witch,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:zombie,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:zombified_piglin,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:zombie_villager,distance=..24,tag=!PeacefulPersisted] add r

execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:evoker,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:pillager,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:ravager,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:vex,distance=..24,tag=!PeacefulPersisted] add r
execute at @a[tag=PeacefulPlayer] run tag @e[type=minecraft:vindicator,distance=..24,tag=!PeacefulPersisted] add r

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
