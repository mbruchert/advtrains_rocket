local S
if minetest.get_modpath("intllib") then
    S = intllib.Getter()
else
    S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end

advtrains.register_wagon("rocket", {
	mesh="advtrains_rocket.b3d",
	textures = {"advtrains_rocket.png"},
	is_locomotive=true,
	drives_on={default=true},
	max_speed=5,
	seats = {
		{
			name=S("Driver Stand"),
			attach_offset={x=0, y=10, z=-10},
			view_offset={x=0, y=6, z=0},
			driving_ctrl_access=true,
			group = "dstand",
		},
	},
	seat_groups = {
		dstand={
			name = "Driver Stand",
			access_to = {},
		},
	},
	assign_to_seat_group = {"dstand"},
	visual_size = {x=1, y=1},
	wagon_span=1.6,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,3.5,1.0},
	update_animation=function(self, velocity)
		if self.old_anim_velocity~=advtrains.abs_ceil(velocity) then
			self.object:set_animation({x=1,y=80}, advtrains.abs_ceil(velocity)*15, 0, true)
			self.old_anim_velocity=advtrains.abs_ceil(velocity)
		end
	end,
	custom_on_activate = function(self, staticdata_table, dtime_s)
		minetest.add_particlespawner({
			amount = 20,
			time = 0,
		--  ^ If time is 0 has infinite lifespan and spawns the amount on a per-second base
			minpos = {x=0, y=3.2, z=1.4},
			maxpos = {x=0, y=3.2, z=1.4},
			minvel = {x=-0.2, y=1.8, z=-0.2},
			maxvel = {x=0.2, y=2, z=0.2},
			minacc = {x=0, y=-0.1, z=0},
			maxacc = {x=0, y=-0.3, z=0},
			minexptime = 2,
			maxexptime = 4,
			minsize = 2,
			maxsize = 8,
		--  ^ The particle's properties are random values in between the bounds:
		--  ^ minpos/maxpos, minvel/maxvel (velocity), minacc/maxacc (acceleration),
		--  ^ minsize/maxsize, minexptime/maxexptime (expirationtime)
			collisiondetection = true,
		--  ^ collisiondetection: if true uses collision detection
			vertical = false,
		--  ^ vertical: if true faces player using y axis only
			texture = "smoke_puff.png",
		--  ^ Uses texture (string)
			attached = self.object,
		})
	end,
	drops={"advtrains:rocket"},
}, S("Rocket"), "advtrains_rocket_inv.png")






advtrains.register_wagon("rocket_wagon_tender", {
	mesh="advtrains_rocket_wagon.b3d",
	textures = {"advtrains_rocket_wagon.png"},
	drives_on={default=true},
	max_speed=3,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=1.0,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,1.5,1.0},
	drops={"default:steelblock 4"},
	has_inventory = true,
	get_inventory_formspec = function(self)
		return "size[8,11]"..
			"list[detached:advtrains_wgn_"..self.unique_id..";box;0,0;8,6;]"..
			"list[current_player;main;0,7;8,4;]"..
			"listring[]"
	end,
	inventory_list_sizes = {
		box=8*2,
	},
}, S("Rocket tender"), "advtrains_wagon_rocket_tender_inv.png")



advtrains.register_wagon("rocket_wagon_box", {
	mesh="advtrains_rocket_wagon_long.b3d",
	textures = {"advtrains_rocket_wagon.png"},
	drives_on={default=true},
	max_speed=3,
	seats = {},
	visual_size = {x=1, y=1},
	wagon_span=1.9,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,1.5,1.0},
	drops={"default:steelblock 4"},
	has_inventory = true,
	get_inventory_formspec = function(self)
		return "size[8,11]"..
			"list[detached:advtrains_wgn_"..self.unique_id..";box;0,0;8,6;]"..
			"list[current_player;main;0,7;8,4;]"..
			"listring[]"
	end,
	inventory_list_sizes = {
		box=8*6,
	},
}, S("Rocket Box Wagon"), "advtrains_wagon_rocket_box_inv.png")

