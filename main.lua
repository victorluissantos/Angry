local text=" "
local img


function beginContact(a, b, coll)
    x,y = coll:getNormal()
	
   -- text = text.."\n"..a:getUserData().." colidindo com "..b:getUserData().." with a vector normal of: "..x..", "..y
    if((a:getUserData() =="porco") and (b:getUserData() == "arodireito")) 
	      or ((a:getUserData() =="arodireito") and (b:getUserData() == "porco"))  then
		     text = a:getUserData() .." colidindo com "..b:getUserData()
				
	end	
	
	
end




function love.load()
  img = love.graphics.newImage("angry.png")
  imgbola = love.graphics.newImage("bola.png")
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(-0.1, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
   posicaoXBola = 100
  posicaoYBola = 100

  objects = {} -- table to hold all our physical objects
  
  --########################CHÃO#####################
  
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) --o retângulo que será desenhado é desenhado a partir do centro da tela
  objects.ground.shape = love.physics.newRectangleShape(900, 350) --make a rectangle with a width of 650 and a height of 50
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body
  objects.ground.fixture:setUserData("Chao")
  
  --########################CHÃO#####################
  
  
  
    ---obstaculo 1 - parede horizontal da esquerda
  objects.obstaculo1 = {}
  objects.obstaculo1.body = love.physics.newBody(world, 100, 150,"static") -- em newBody, cria-se um "corpo" que ocupará um determinado lugar no espaço
  objects.obstaculo1.shape = love.physics.newRectangleShape(0, 0, 150, 10)
  objects.obstaculo1.fixture = love.physics.newFixture(objects.obstaculo1.body, objects.obstaculo1.shape) -- A higher density gives it more mass.
   objects.obstaculo1.fixture:setUserData("obstaculo1")

  
  
  
  
  
  --criando a bola que será "atachada " a imagem do porco
  objects.ball = {}
  
  objects.ball.body = love.physics.newBody(world, 100, 150/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.ball.shape = love.physics.newCircleShape(12) --the ball's shape has a radius of 20
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Attach fixture to body and give it a density of 1.Quanto maior a densidade, mais difícil mover a bola
  objects.ball.fixture:setRestitution(0.9) --let the ball bounce
  objects.ball.fixture:setUserData("porco") 
  
  
  
  
   --criando a bola 2 ( basquete)
  objects.bola2 = {}
  
  objects.bola2.body = love.physics.newBody(world, 150, 150/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  objects.bola2.shape = love.physics.newCircleShape(12) --the ball's shape has a radius of 20
  objects.bola2.fixture = love.physics.newFixture(objects.bola2.body, objects.bola2.shape, 1) -- Attach fixture to body and give it a density of 1.Quanto maior a densidade, mais difícil mover a bola
  objects.bola2.fixture:setRestitution(0.8) --let the ball bounce
  objects.bola2.fixture:setUserData("bola2") 
  
  
  
  

  --ARO ESQUERDO
  objects.aroesquerdo = {}
  objects.aroesquerdo.body = love.physics.newBody(world, 300, 350, "dynamic") -- em newBody, cria-se um "corpo" que ocupará um determinado lugar no espaço
  objects.aroesquerdo.shape = love.physics.newRectangleShape(0, 0, 10, 100)
  objects.aroesquerdo.fixture = love.physics.newFixture(objects.aroesquerdo.body, objects.aroesquerdo.shape, 150) -- A higher density gives it more mass.
   objects.aroesquerdo.fixture:setUserData("aroesquerdo")
   
   
   --ARO DIREITO
  objects.arodireito = {}
  objects.arodireito.body = love.physics.newBody(world, 450, 350, "dynamic") -- em newBody, cria-se um "corpo" que ocupará um determinado lugar no espaço
  objects.arodireito.shape = love.physics.newRectangleShape(0, 0, 10, 100)
  objects.arodireito.fixture = love.physics.newFixture(objects.arodireito.body, objects.arodireito.shape, 150) -- A higher density gives it more mass.
   objects.arodireito.fixture:setUserData("arodireito")
   
   

  

  --initial graphics setup
  love.graphics.setBackgroundColor(104, 136, 148) --set the background color to a nice blue
  love.graphics.setMode(800, 600, false, true, 0) --set the window dimensions to 650 by 650
end


function love.update(dt)
  world:update(dt) --this puts the world into motion
  
  
  

  if love.keyboard.isDown("right") then 
     posicaoXBola = posicaoXBola + (200*dt)
  end
  
  if love.keyboard.isDown("left") then 
    posicaoXBola = posicaoXBola -(200*dt)
  end
  
  if love.keyboard.isDown("up") then 
    posicaoYBola = posicaoYBola - (200*dt)
  end
  
  if love.keyboard.isDown("down") then 
    posicaoYBola = posicaoYBola + (200*dt)
  end
   
  -- POSICIONANDO O PORCO 
  objects.ball.body:setPosition(posicaoXBola, posicaoYBola)
   
end

function love.draw()
	
  love.graphics.setColor(72, 160, 14) 
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) 

  love.graphics.setColor(193, 47, 14) 
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
  
  
  love.graphics.setColor(50, 50, 50) 
  love.graphics.polygon("fill", objects.aroesquerdo.body:getWorldPoints(objects.aroesquerdo.shape:getPoints()))
  love.graphics.polygon("fill", objects.arodireito.body:getWorldPoints(objects.arodireito.shape:getPoints()))
  
  
  love.graphics.setColor(50, 50, 50) 
  love.graphics.polygon("fill", objects.obstaculo1.body:getWorldPoints(objects.obstaculo1.shape:getPoints()))
  
 
   love.graphics.print(text, 10, 10)
    love.graphics.setColor(255, 255, 255)
	
  -- desenhando o porco	
  love.graphics.draw(img,objects.ball.body:getX()-img:getWidth()/2,objects.ball.body:getY()-img:getHeight()/2)
  
  --desenhando a segunda bola
  love.graphics.draw(imgbola,objects.bola2.body:getX()-img:getWidth()/2,objects.bola2.body:getY()-img:getHeight()/2)
   
   
   love.graphics.print(objects.ball.body:getX(), 10, 40)
end