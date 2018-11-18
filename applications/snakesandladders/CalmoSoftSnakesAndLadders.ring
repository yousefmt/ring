# Project : Snakes and Ladders Game
# Date    : 2018/11/17
# Author : Gal Zsolt (~ CalmoSoft ~)
# Email   : <calmosoft@gmail.com>

size = 10
moveblack = 0
movered = 0
nDiscY = 1
nDiscX = 0
ncor = 0
mcor = 0
rnd = 0
nKey = 0
nKey2 = 0
nNext = 0
nNext2 = 0
movenew = 0
discyellow = "discyellow.png"
oGame = null
diceblack1 = "diceblack1.jpg"
diceblack2 = "diceblack2.jpg"
diceblack3 = "diceblack3.jpg"
diceblack4 = "diceblack4.jpg"
diceblack5 = "diceblack5.jpg"
diceblack6 = "diceblack6.jpg"
dicered1 = "dicered1.jpg"
dicered2 = "dicered2.jpg"
dicered3 = "dicered3.jpg"
dicered4 = "dicered4.jpg"
dicered5 = "dicered5.jpg"
dicered6 = "dicered6.jpg"
dicesblack = [diceblack1,diceblack2,diceblack3,diceblack4,diceblack5,diceblack6]
dicesred = [dicered1,dicered2,dicered3,dicered4,dicered5,dicered6]
ladder = [[5,26],[13,46],[18,39],[37,62],[48,72],[60,82],[65,95]]
snake = [[7,23],[9,33],[14,44],[25,68],[41,77],[66,97],[70,94]]

lSpaceKey = False

Load "gameengine.ring"                         

func main                                      

        oGame = New Game                      
        {
                     title = "Snakes And Ladders"
                     al_resize_display(display,650,593)
                     sprite
                     {
	                     x=0 y=0 width=590 height=593
	                     file = "gameimage.png"
	                     transparent = false
	                     Animate=false
	                     Move=false
	                     Scaled=true
                     }
                     sprite
                     {
	                       x=600 
	                       y=20 
	                       width=30 height=30
	                       file = dicered1
	                       transparent = true
	                       Animate=false
	                       Move=false
	                       Scaled=true
                     }
                     sprite
                     {
	                     x=20+58*(nDiscX-1) 
	                     y=20+58*(10-nDiscY) 
	                     width=30 height=30
	                     file = dicered1
	                     transparent = true
	                     Animate=false
	                     Move=false
	                     Scaled=true
                     }
                    pmove(oGame)
        } 

func nextdice(dicenr)
       oGame { sprite
                {
	         x=600 
	         y=20 
	         width=40 height=40
	         file = dicesred[dicenr]
	         transparent = true
	         Animate=false
	         Move=false
	         Scaled=true
                 } }


func pmove(oGame)
       oGame {
		sprite
          	{
                     x=20+58*(nDiscX-1) 
                     y=20+58*(10-nDiscY) 
                     width=40 height=40
                     file = discyellow
                     transparent = true
                     Animate=false
                     Move=false
                     Scaled=true
                     AddAttribute(self,:nClock)
                     nClock = clock()
                     state = func oGame,oSelf {
                                oSelf {
                                        nDiscX = ncor
                                        nDiscY = mcor
                                        x=20+58*(nDiscX-1) 
                                        y=20+58*(10-nDiscY) 
					if lSpaceKey = True 
						lSpaceKey = False
	                                        if (Clock()-nClock)/Clockspersecond() >= 0.1
	                                            nClock = clock()
	                                            nKey = 0
	                                            nNext = 0
	                                            rnd = random(5)+1 
                                                    see "dice: " + rnd + " move: " + moveblack + " -> "
	                                            moveblack = moveblack + rnd
                                                    see moveblack + nl
	                                            if moveblack > size*size-1
	                                              see "You won" + nl
	                                              see "Your Score: " + moveblack + nl
	                                              oGame.shutdown()
	                                            ok
	                                            moveold = moveblack
	                                            laddercheck = checkladder(moveblack)
	                                            if laddercheck = 1
	                                               moveblack = movenew
	                                            ok
	                                            if laddercheck = 1      
	                                               snakecheck = checksnake(moveblack)
	                                            else
	                                               snakecheck = checksnake(moveold)
	                                            ok
	                                            if snakecheck = 1
	                                               moveblack = movenew
	                                            but laddercheck = 0 and snakecheck = 0
	                                               moveblack = moveold
	                                            ok	
	                                            nextdice(rnd)
	                                            pcor(moveblack)	
	                                          ok
	                                ok
                                }
			}
                        keypress = func ogame,oself,nKey {
                                        if nKey = key_space 
					   lSpaceKey = True
                                        ok }
                  } 
	}
        return

func pcor(num)
       nr = 0
       for n = 1 to size
            for m = 1 to size
                 nr = nr + 1
                 if nr = num
                    if n%2 = 1
                       ncor = m
                    else
                       ncor = 11-m
                    ok
                    mcor = n
                 ok
            next
       next

func checkladder(num)
        flag = 0
        for n = 1 to len(ladder)
             if ladder[n][1] = num
                pcor(ladder[n][2])
                movenew = ladder[n][2]
                see "Ladder Move: " + ladder[n][1] + " -> " + ladder[n][2] + nl
                flag = 1
                exit
             ok
         next
         if flag = 1
            return 1
         else
            return 0
         ok

func checksnake(num)
        flag = 0
        for n = 1 to len(snake)
             if snake[n][2] = num
                pcor(snake[n][1])
                movenew = snake[n][1]
                see "Snake Move: " + snake[n][2] + " -> " + snake[n][1] + nl
                flag = 1
                exit
             ok
         next
         if flag = 1
            return 1
         else
            return 0
         ok