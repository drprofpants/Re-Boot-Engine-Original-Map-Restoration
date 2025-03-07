/// @description Initialize
event_inherited();

#region Initialize Base Variables

image_speed = 0;

aiStyle = 0;
hostile = false;
tileCollide = true;
multiHit = false;

isCharge = false;

damage = 0;
damageType = 0;
damageSubType[0] = true;
damageSubType[1] = false;
damageSubType[2] = false;
damageSubType[3] = false;
damageSubType[4] = false;
damageSubType[5] = false;

freezeType = 0;
freezeKill = false;

knockBack = 4;//9;
knockBackSpeed = 5;
damageImmuneTime = 96;

dmgDelay = 0;

ignoreCamera = false;

npcImmuneTime[instance_number(obj_NPC)] = 0;
npcDeathType = -1;

creator = noone;

particleType = -1;
impactSnd = noone;

impacted = 0;
reflected = false;

shift = 0;
t = 0;
t2 = 0;
increment = pi*2 / 60;
xx = xstart;
yy = ystart;
dir = 1;

waveStyle = 0;
waveDir = 1;

amplitude = 0;
wavesPerSecond = 0;
delay = 0;

//speed = 0;
//velocity = 0;
//direction = 0;
//image_angle = direction;
speed_x = 0;
speed_y = 0;

//particleDelay = 0;
rotation = direction;
for(var i = 0; i < 11; i++)
{
	oldPosX[i] = x;
	oldPosY[i] = y;
}
for(var i = 0; i < 11; i++)
{
	oldRot[i] = rotation;
}
oldPositionsSet = false;

/*
isBomb = false;
isMissile = false;
isSuperMissile = false;
isBeam = false;
isGrapple = false;

isCharge = false;
isIce = false;
isWave = false;
isSpazer = false;
isPlasma = false;
*/
enum ProjType
{
	Beam,
	Missile,
	Bomb
}
type = ProjType.Beam;


blockDestroyType = 0;
doorOpenType = 0;

projLength = 0;
rotFrame = 0;

//frame = 0;
//frameCounter = 0;

#endregion

#region Damage

function CanDamageNPC(damage,npc)
{
	return true;
}
function ModifyDamageNPC(damage,npc)
{
	return damage;
}
function OnDamageNPC(damage,npc) {}

#endregion

#region Collision (Unused atm)

function ModifyFinalVelX(fVX)
{
	if(impacted > 0)
	{
		return 0;
	}
	return fVX;
}
function ModifyFinalVelY(fVY)
{
	if(impacted > 0)
	{
		return 0;
	}
	return fVY;
}

function CanMoveUpSlope_Bottom() { return false; }
function CanMoveUpSlope_Top() { return false; }
function CanMoveUpSlope_Left() { return false; }
function CanMoveUpSlope_Right() { return false; }

function CanMoveDownSlope_Bottom() { return false; }
function CanMoveDownSlope_Top() { return false; }
function CanMoveDownSlope_Left() { return false; }
function CanMoveDownSlope_Right() { return false; }

function OnXCollision(fVX)
{
	Impact();
}
function OnYCollision(fVY)
{
	Impact();
}
function Impact()
{
	//velX = 0;
	//velY = 0;
	//fVelX = 0;
	//fVelY = 0;
	//speed_x = 0;
	//speed_y = 0;
	if(impacted <= 0)
	{
		if(impactSnd != noone)
		{
			audio_stop_sound(impactSnd);
			audio_play_sound(impactSnd,0,false);
		}
		if(particleType != -1 && particleType <= 4)
		{
			part_particles_create(obj_Particles.partSystemA,x,y,obj_Particles.bTrails[particleType],7*(1+isCharge));
			if(isCharge)
			{
				part_particles_create(obj_Particles.partSystemA,x,y,obj_Particles.cImpact[particleType],1);
			}
			else
			{
				part_particles_create(obj_Particles.partSystemA,x,y,obj_Particles.impact[particleType],1);
			}
		}
		impacted = 1;
	}
}

#endregion

function OnImpact() {}

function TileInteract(_x,_y)
{
	BreakBlock(_x,_y,blockDestroyType);
	OpenDoor(_x,_y,doorOpenType);
	ShutterSwitch(_x,_y,doorOpenType);
}