extends KinematicBody

#primal variables
var gravity = 9.81                   #m/s^2
export var car_mass = 1500           #Kg
export var engine_power = 100000     #Watt

var air_density = 1.2                #kg/m3   ///  #Deniz seviyesinde, 15°C, kuru hava
var air_resistance_coefficient = 0.3 #Sedan car
var air_front_surface_area = 2.5     #Sedan car

var current_speed = 1                #m/s
var friction_coefficient = 0.015


var eta_factor = 0.85

var velocity = Vector3.ZERO

func _ready():
	print("Engine Force: ", calc_engine_force())
	print("Air Resistance: ", calc_air_resistance())
	print("Friction: ", calc_floor_friction())
	print("Net Force: ", calc_net_force())
	print("Acceleration: ", calc_acceleration())
	print("Max Speed: ", calc_maxspeed())

# FLOOR FRICTION /// AIR RESISTANCE /// MOTOR FORCE /// NET FORCE
# /// ACCELERATION /// MAXSPEED /// CURRENTSPEED
##########################################

func calc_engine_force():
	if current_speed == 0:
		return 0 # Avoid division by zero
	var motor_force = engine_power / current_speed
	return motor_force # Newton

func calc_air_resistance():
	var air_res = 0.5 * air_density * air_front_surface_area * air_resistance_coefficient * pow(current_speed, 2)
	return air_res # Newton

func calc_floor_friction():
	var friction_force = friction_coefficient * car_mass * gravity
	return friction_force # Newton

func calc_net_force():
	var net_force = calc_engine_force() - (calc_air_resistance() + calc_floor_friction())
	return net_force # Newton

func calc_acceleration():
	var current_acc = calc_net_force() / car_mass
	return current_acc # m/s^2

func calc_maxspeed():
	var a = eta_factor*engine_power*2
	var b = air_density*air_front_surface_area*air_resistance_coefficient
	var c = gravity*car_mass*friction_coefficient
	var d = a/b+c
	var max_speed = pow(d,1.0/3.0)
	return max_speed # m/s
########################################
# END
