' GDI Draw test by Julien Moog
' julien.moog@laposte.net
' Credits to:
'
' A form designer the one used in the RapidQ IDE
' Copyright (c) 2014 cxs77
' cxs77@yahoo.com
'
' No warranties or guarantees of any kind; use at your own risk.
'
' If you do use the code, please give me credit. THanks.
'
' KPD-Team 1998
' URL: http://www.allapi.net/
' E-Mail: KPDTeam@Allapi.net
    

$apptype console
$typecheck on

$Include "windows.inc"
$INclude "RapidQ2.inc"

'used with fnWeight
'Const FW_DONTCARE = 0
'Const FW_THIN = 100
'Const FW_EXTRALIGHT = 200
'Const FW_LIGHT = 300
'Const FW_NORMAL = 400
'Const FW_MEDIUM = 500
'Const FW_SEMIBOLD = 600
'Const FW_BOLD = 700
'Const FW_EXTRABOLD = 800
'Const FW_HEAVY = 900
'Const FW_BLACK = FW_HEAVY
'Const FW_DEMIBOLD = FW_SEMIBOLD
'Const FW_REGULAR = FW_NORMAL
'Const FW_ULTRABOLD = FW_EXTRABOLD
'Const FW_ULTRALIGHT = FW_EXTRALIGHT
''used with fdwCharSet
'Const ANSI_CHARSET = 0
'Const DEFAULT_CHARSET = 1
'Const SYMBOL_CHARSET = 2
'Const SHIFTJIS_CHARSET = 128
'Const HANGEUL_CHARSET = 129
'Const CHINESEBIG5_CHARSET = 136
'Const OEM_CHARSET = 255
''used with fdwOutputPrecision
'Const OUT_CHARACTER_PRECIS = 2
'Const OUT_DEFAULT_PRECIS = 0
'Const OUT_DEVICE_PRECIS = 5
''used with fdwClipPrecision
'Const CLIP_DEFAULT_PRECIS = 0
'Const CLIP_CHARACTER_PRECIS = 1
'Const CLIP_STROKE_PRECIS = 2
''used with fdwQuality
'Const DEFAULT_QUALITY = 0
'Const DRAFT_QUALITY = 1
'Const PROOF_QUALITY = 2
''used with fdwPitchAndFamily
'Const DEFAULT_PITCH = 0
'Const FIXED_PITCH = 1
'Const VARIABLE_PITCH = 2
''used with SetBkMode
'Const OPAQUE = 2
'Const TRANSPARENT = 1

'Const LOGPIXELSY = 90
'Const COLOR_WINDOW = 5

declare sub graphclicked
DECLARE SUB Timer1_onTimer
declare sub ovl_paint
declare sub drawselrect
declare SUB graphmousedown(Button AS INTEGER , x AS INTEGER , y AS INTEGER)
declare sub parameterssub
declare sub savebmpsub
declare sub savelsyssub
declare sub loadlsyssub

DIM red AS INTEGER , orange AS INTEGER , yellow AS INTEGER , green AS INTEGER , blue AS INTEGER , lightblue AS INTEGER , purple AS INTEGER , _
    gray AS INTEGER , black AS INTEGER , pink AS INTEGER , olive AS INTEGER , aqua AS INTEGER , crimson AS INTEGER , gold AS INTEGER , _
    white AS INTEGER , mediumseagreen AS INTEGER , lightgray AS INTEGER , sweetblue AS INTEGER
defint darkgreen,darkslategray,teal,navy,maroon,indigo,midnightblue,darkblue,darkolivegreen,saddlebrown,forestgreen,olivedrab,_
seagreen,darkgoldenrod,darkslateblue,sienna,mediumblue,brown,darkturquoise,dimgray,lightseagreen,darkviolet,firebrick,_
mediumvioletred,chocolate,steelblue,goldenrod,mediumspringgreen,lawngreen,cadetblue,darkorchid,yellowgreen,_
limegreen,orangered,darkorange,chartreuse,lime,springgreen,_
deepskyblue,magenta,slategray,peru,blueviolet,_
lightslategray,deeppink,mediumturquoise,dodgerblue,turquoise,royalblue,slateblue,darkkhaki,_
indianred,mediumorchid,greenyellow,mediumaquamarine,darkseagreen,tomato,rosybrown,orchid,_
mediumpurple,palevioletred,coral,cornflowerblue,darkgray,sandybrown,mediumslateblue,clrtan,_
darksalmon,burlywood,hotpink,salmon,violet,lightcoral,skyblue,lightsalmon,_
plum,khaki,lightgreen,aquamarine,silver,lightskyblue,lightsteelblue,_
palegreen,thistle,powderblue,palegoldenrod,paleturquoise,wheat,navajowhite,_
moccasin,lightpink,gainsboro,peachpuff,bisque,lightgoldenrod,blanchedalmond,_
lemonchiffon,beige,antiquewhite,papayawhip,cornsilk,lightyellow,lightcyan,linen,_
lavender,mistyrose,oldlace,whitesmoke,seashell,ivory,honeydew,aliceblue,_
lavenderblush,mintcream,snow    
red = RGB(255 , 0 , 0)
orange = RGB(255 , 165 , 0)
yellow = RGB(255 , 255 , 0)
green = RGB(1 , 128 , 0)
blue = RGB(0 , 0 , 255)
lightblue = RGB(173 , 216 , 230)
purple = RGB(128 , 0 , 128)
gray = RGB(128 , 128 , 128)
black = RGB(0 , 0 , 0)
pink = RGB(255 , 192 , 203)
olive = RGB(128 , 128 , 0)
aqua = RGB(0 , 255 , 255)
crimson = RGB(220 , 20 , 60)
gold = RGB(255 , 215 , 0)
white = RGB(255 , 255 , 255)
lightgray = RGB(240 , 248 , 255)
sweetblue = RGB(166 , 166 , 210)
mediumseagreen = RGB(60 , 179 , 113)
darkgreen=RGB(0,64,0)
darkslategray=RGB(48,61,139)
teal=RGB(0,128,128)
navy=RGB(0,0,128)
maroon=RGB(128,0,0)
indigo=RGB(75,0,130)
midnightblue=RGB(25,25,112)
darkblue=RGB(0,0,139)
darkolivegreen=RGB(85,107,47)
saddlebrown=RGB(139,69,19)
forestgreen=RGB(34,139,34)
olivedrab=RGB(107,142,35)
seagreen=RGB(46,139,87)
darkgoldenrod=RGB(184,134,11)
darkslateblue=RGB(72,61,139)
sienna=RGB(160,82,45)
mediumblue=RGB(0,0,205)
brown=RGB(165,42,42)
darkturquoise=RGB(0,206,209)
dimgray=RGB(105,105,105)
lightseagreen=RGB(32,178,170)
darkviolet=RGB(148,0,211)
firebrick=RGB(178,34,34)
mediumvioletred=RGB(199,21,133)
chocolate=RGB(210,105,30)
steelblue=RGB(70,130,180)
goldenrod=RGB(218,165,32)
mediumspringgreen=RGB(0,250,154)
lawngreen=RGB(124,152,0)
cadetblue=RGB(95,158,160)
darkorchid=RGB(153,50,204)
yellowgreen=RGB(154,205,50)
limegreen=RGB(50,205,50)
orangered=RGB(255,69,0)
darkorange=RGB(255,140,0)
chartreuse=RGB(127,255,0)
lime=RGB(0,255,0)
springgreen=RGB(0,255,127)
deepskyblue=RGB(0,191,255)
magenta=RGB(255,0,255)
slategray=RGB(112,128,128)
peru=RGB(205,133,63)
blueviolet=RGB(138,43,226)
lightslategray=RGB(119,136,153)
deeppink=RGB(255,20,147)
mediumturquoise=RGB(72,209,204)
dodgerblue=RGB(30,144,255)
turquoise=RGB(64,224,208)
royalblue=RGB(65,105,225)
slateblue=RGB(106,90,205)
darkkhaki=RGB(189,183,107)
indianred=RGB(205,92,92)
mediumorchid=RGB(186,85,211)
greenyellow=RGB(173,255,47)
mediumaquamarine=RGB(102,205,170)
darkseagreen=RGB(143,188,143)
tomato=RGB(255,99,71)
rosybrown=RGB(188,143,143)
orchid=RGB(218,112,214)
mediumpurple=RGB(147,112,219)
palevioletred=RGB(219,112,147)
coral=RGB(255,127,80)
cornflowerblue=RGB(100,149,237)
darkgray=RGB(169,169,169)
sandybrown=RGB(244,164,96)
mediumslateblue=RGB(123,104,238)
clrtan=RGB(210,180,140)
darksalmon=RGB(233,150,122)
burlywood=RGB(222,184,135)
hotpink=RGB(255,105,180)
salmon=RGB(250,128,114)
violet=RGB(238,130,238)
lightcoral=RGB(240,128,128)
skyblue=RGB(135,206,235)
lightsalmon=RGB(255,160,122)
plum=RGB(221,160,221)
khaki=RGB(240,230,140)
lightgreen=RGB(144,238,144)
aquamarine=RGB(127,255,212)
silver=RGB(192,192,192)
lightskyblue=RGB(135,206,250)
lightsteelblue=RGB(176,196,222)
palegreen=RGB(152,251,152)
thistle=RGB(216,191,216)
powderblue=RGB(176,224,230)
palegoldenrod=RGB(238,232,170)
paleturquoise=RGB(175,238,238)
wheat=RGB(245,222,179)
navajowhite=RGB(255,222,173)
moccasin=RGB(255,228,181)
lightpink=RGB(255,182,193)
gainsboro=RGB(220,220,220)
peachpuff=RGB(255,218,185)
bisque=RGB(255,228,196)
lightgoldenrod=RGB(238,220,130)
blanchedalmond=RGB(255,235,205)
lemonchiffon=RGB(255,250,205)
beige=RGB(245,245,220)
antiquewhite=RGB(250,235,215)
papayawhip=RGB(255,239,213)
cornsilk=RGB(255,248,220)
lightyellow=RGB(255,255,224)
lightcyan=RGB(224,255,255)
linen=RGB(250,240,230)
lavender=RGB(230,230,250)
mistyrose=RGB(255,228,225)
oldlace=RGB(253,245,230)
whitesmoke=RGB(245,245,245)
seashell=RGB(255,245,238)
ivory=RGB(255,255,240)
honeydew=RGB(240,255,240)
aliceblue=RGB(240,248,255)
lavenderblush=RGB(255,240,245)
mintcream=RGB(245,255,250)
snow=RGB(255,250,250)

defint mouseposx,mouseposy,DownX,DownY,mousediffx,mousediffy,relativecordx,relativecordy

defint graphclick=0
DIM bmOvl AS QBITMAP

dim Timer1 AS QTIMER
timer1.Interval = 10
timer1.OnTimer = Timer1_onTimer
timer1.enabled=0

create frmmain as qform
caption="Draw GDI test"
height=screen.height
width=screen.width

create graph as qcanvas
height=frmmain.clientheight
width=frmmain.clientwidth
''onpaint=DrawSelRect
'onclick=graphclicked
'OnMouseDown = graphmousedown

end create
create button as qbutton
left=0
top=0
onclick=DrawSelRect
caption="Draw"
end create
create parametersbtn as qbutton
top=40
left=0
caption="Parameters"
onclick=parameterssub
end create
end create

create parametersfrm as qform
caption="Parameters"
visible=0
height=700
width=800
create axiomlbl as qlabel
left=0
top=0
caption="Axiom:"
end create
create axiom as qedit
left=axiomlbl.left+axiomlbl.width
top=axiomlbl.top
text="F+(90)F+(90)F"
end create
create production1lbl as qlabel
left=0
top=20
caption="Production 1:"
end create
create production1 as qedit
left=production1lbl.left+production1lbl.width
top=production1lbl.top
text="F"
end create
create rule1lbl as qlabel
left=0
top=40
caption="Rule 1:"
end create
create rule1 as qedit
left=rule1lbl.left+rule1lbl.width
top=rule1lbl.top
text="F-F++F-F"
end create
create production2lbl as qlabel
left=0
top=60
caption="Production 2:"
end create
create production2 as qedit
left=production2lbl.left+production2lbl.width
top=production2lbl.top
text=""
end create
create rule2lbl as qlabel
left=0
top=80
caption="Rule 2:"
end create
create rule2 as qedit
left=rule2lbl.left+rule2lbl.width
top=rule2lbl.top
text=""
end create
create production3lbl as qlabel
left=0
top=100
caption="Production 3:"
end create
create production3 as qedit
left=production3lbl.left+production3lbl.width
top=production3lbl.top
text=""
end create
create rule3lbl as qlabel
left=0
top=120
caption="Rule 3:"
end create
create rule3 as qedit
left=rule3lbl.left+rule3lbl.width
top=rule3lbl.top
text=""
end create
create production4lbl as qlabel
left=0
top=140
caption="Production 4:"
end create
create production4 as qedit
left=production4lbl.left+production4lbl.width
top=production4lbl.top
text=""
end create
create rule4lbl as qlabel
left=0
top=160
caption="Rule 4:"
end create
create rule4 as qedit
left=rule4lbl.left+rule4lbl.width
top=rule4lbl.top
text=""
end create
create production5lbl as qlabel
left=0
top=180
caption="Production 5:"
end create
create production5 as qedit
left=production5lbl.left+production5lbl.width
top=production5lbl.top
text=""
end create
create rule5lbl as qlabel
left=0
top=200
caption="Rule 5:"
end create
create rule5 as qedit
left=rule5lbl.left+rule5lbl.width
top=rule5lbl.top
text=""
end create
create production6lbl as qlabel
left=0
top=220
caption="Production 6:"
end create
create production6 as qedit
left=production6lbl.left+production6lbl.width
top=production6lbl.top
text=""
end create
create rule6lbl as qlabel
left=0
top=240
caption="Rule 6:"
end create
create rule6 as qedit
left=rule6lbl.left+rule6lbl.width
top=rule6lbl.top
text=""
end create
create production7lbl as qlabel
left=0
top=260
caption="Production 7:"
end create
create production7 as qedit
left=production7lbl.left+production7lbl.width
top=production7lbl.top
text=""
end create
create rule7lbl as qlabel
left=0
top=280
caption="Rule 7:"
end create
create rule7 as qedit
left=rule7lbl.left+rule7lbl.width
top=rule7lbl.top
text=""
end create
create production8lbl as qlabel
left=0
top=300
caption="Production 8:"
end create
create production8 as qedit
left=production8lbl.left+production8lbl.width
top=production8lbl.top
text=""
end create
create rule8lbl as qlabel
left=0
top=320
caption="Rule 8:"
end create
create rule8 as qedit
left=rule8lbl.left+rule8lbl.width
top=rule8lbl.top
text=""
end create
create production9lbl as qlabel
left=0
top=340
caption="Production 9:"
end create
create production9 as qedit
left=production9lbl.left+production9lbl.width
top=production9lbl.top
text=""
end create
create rule9lbl as qlabel
left=0
top=360
caption="Rule 9:"
end create
create rule9 as qedit
left=rule9lbl.left+rule9lbl.width
top=rule9lbl.top
text=""
end create
create incrementlbl as qlabel
left=0
top=380
caption="Iterations :"
end create
create increment as qedit
left=incrementlbl.left+incrementlbl.width
top=incrementlbl.top
text="4"
end create
create depthlbl as qlabel
left=0
top=400
caption="Depth :"
end create
create depth as qedit
left=depthlbl.left+depthlbl.width
top=depthlbl.top
text="22.5"
enabled=0
end create
create depthlbl2 as qlabel
left=depth.left+depth.width
top=depth.top
caption="(Default Rotation Value)"
end create
create lengthlbl as qlabel
left=0
top=420
caption="Length :"
end create
create length as qedit
left=lengthlbl.left+lengthlbl.width
top=lengthlbl.top
text="5"
end create
create lengthlbl2 as qlabel
left=length.left+length.width
top=length.top
caption="(Initial line length)"
end create
create rangelbl as qlabel
left=0
top=440
caption="Rate :"
end create
create range as qedit
left=rangelbl.left+rangelbl.width
top=rangelbl.top
text="2.3"
enabled=0
end create
create rangelbl2 as qlabel
left=range.left+range.width
top=range.top
caption="(The multiplier of shrinking after each iteration)"
end create
create penxlbl as qlabel
left=0
top=460
caption="Pen x :"
end create
create penx as qedit
left=penxlbl.left+penxlbl.width
top=penxlbl.top
text="400"
enabled=0
end create
create penylbl as qlabel
left=0
top=480
caption="Pen y :"
end create
create peny as qedit
left=penylbl.left+penylbl.width
top=penylbl.top
text="470"
enabled=0
end create
create anglelbl as qlabel
left=0
top=500
caption="Angle :"
end create
create angle as qedit
left=anglelbl.left+anglelbl.width
top=anglelbl.top
text="75"
end create
create pointxlbl as qlabel
left=0
top=520
caption="Point x :"
end create
create pointx as qedit
left=pointxlbl.left+pointxlbl.width
top=pointxlbl.top
text="400"
end create
create pointxlbl2 as qlabel
left=pointx.left+pointx.width
top=pointx.top
caption="(x pixel location of the drawing)"
end create
create pointylbl as qlabel
left=0
top=540
caption="Point y :"
end create
create pointy as qedit
left=pointylbl.left+pointylbl.width
top=pointylbl.top
text="400"
end create
create pointylbl2 as qlabel
left=pointy.left+pointy.width
top=pointy.top
caption="(y pixel location of the drawing)"
end create
'create Infolbl as qlabel
'left=0
'top=560
''caption="Note: sometimes you'll have to put your rules within quotes ('rule')"
'caption=""
'end create
create savelsys as qbutton
left=0
top=560
caption="Save LSys"
onclick=savelsyssub
end create
create loadlsys as qbutton
left=0
top=580
caption="Load LSys"
onclick=loadlsyssub
end create
create savebmp as qbutton
left=0
top=600
caption="Save BMP"
onclick=savebmpsub
end create

end create

sub parameterssub
parametersfrm.visible=1
setfocus(parametersfrm.handle)
end sub

SUB Timer1_onTimer
mouseposx=screen.mousex-mousediffx
mouseposy=screen.mousey-mousediffy
drawselrect
END SUB    

sub graphclicked
if graphclick=0 then
graphclick=1
DownX=relativecordx
DownY=relativecordy
Timer1.enabled=1
exit sub
end if
if graphclick=1 then
graphclick=0
Timer1.enabled=0
exit sub
end if

end sub

SUB PaintChart  'Assign this to the QChart.OnPaint Event
        'Draws Buffer.BMP to Canvas
                
            graph.Draw(0 , 0 , bmOvl.BMP)
       

    END SUB

SUB DrawSelRect
    DIM rcDraw AS Rect
    rcDraw.Top = DownY
    rcDraw.Left = DownX
    rcDraw.Right = mouseposx
    rcDraw.Bottom = mouseposy
 
    bmOvl.Width = graph.Width
    bmOvl.Height = graph.Height
    bmOvl.fillrect(0 , 0 , graph.width,graph.height,white)
    
   
    dim filestream as qfilestream
    
filestream.Open("axiom.txt" , fmCreate)
filestream.WriteLine(axiom.text)
filestream.Close    
    
filestream.Open("production1.txt" , fmCreate)
filestream.WriteLine(production1.text)
filestream.Close

filestream.Open("rule1.txt" , fmCreate)
filestream.WriteLine(rule1.text)
filestream.Close

filestream.Open("production2.txt" , fmCreate)
filestream.WriteLine(production2.text)
filestream.Close

filestream.Open("rule2.txt" , fmCreate)
filestream.WriteLine(rule2.text)
filestream.Close

filestream.Open("production3.txt" , fmCreate)
filestream.WriteLine(production3.text)
filestream.Close

filestream.Open("rule3.txt" , fmCreate)
filestream.WriteLine(rule3.text)
filestream.Close

filestream.Open("production4.txt" , fmCreate)
filestream.WriteLine(production4.text)
filestream.Close

filestream.Open("rule4.txt" , fmCreate)
filestream.WriteLine(rule4.text)
filestream.Close

filestream.Open("production5.txt" , fmCreate)
filestream.WriteLine(production5.text)
filestream.Close

filestream.Open("rule5.txt" , fmCreate)
filestream.WriteLine(rule5.text)
filestream.Close

filestream.Open("production6.txt" , fmCreate)
filestream.WriteLine(production6.text)
filestream.Close

filestream.Open("rule6.txt" , fmCreate)
filestream.WriteLine(rule6.text)
filestream.Close

filestream.Open("production7.txt" , fmCreate)
filestream.WriteLine(production7.text)
filestream.Close

filestream.Open("rule7.txt" , fmCreate)
filestream.WriteLine(rule7.text)
filestream.Close

filestream.Open("production8.txt" , fmCreate)
filestream.WriteLine(production8.text)
filestream.Close

filestream.Open("rule8.txt" , fmCreate)
filestream.WriteLine(rule8.text)
filestream.Close

filestream.Open("production9.txt" , fmCreate)
filestream.WriteLine(production9.text)
filestream.Close

filestream.Open("rule9.txt" , fmCreate)
filestream.WriteLine(rule9.text)
filestream.Close
    
    filestream.Open("test.bat" , fmCreate)
'filestream.WriteLine("dist\tree5\tree5 -a "+axiom.text+" -p1 "+chr$(34)+production1.text+chr$(34)+" -r1 "+chr$(34)+rule1.text+chr$(34)+" -p2 "+chr$(34)+production2.text+chr$(34)+" -r2 "+chr$(34)+rule2.text+chr$(34)+" -p3 "+chr$(34)+production3.text+chr$(34)+" -r3 "+chr$(34)+rule3.text+chr$(34)+" -p4 "+chr$(34)+production4.text+chr$(34)+" -r4 "+chr$(34)+rule4.text+chr$(34)+" -p5 "+chr$(34)+production5.text+chr$(34)+" -r5 "+chr$(34)+rule5.text+chr$(34)+" -i "+increment.text+" -d "+depth.text+" -l "+length.text+" -r "+range.text+" -px "+penx.text+" -py "+peny.text+" -ang "+angle.text+" -ptx "+pointx.text+" -pty "+pointy.text)
filestream.WriteLine("..\python ./lsystem2.py -i "+increment.text+" -l "+length.text+" -ang "+angle.text)
filestream.WriteLine("echo 0 > isbusy.txt")
filestream.Close

filestream.Open("isbusy.txt" , fmCreate)
filestream.WriteLine("1")
filestream.Close

frmmain.caption="Please wait while calculating..."

deflng pid = SHELL("test.bat", 0)

DEFSTR isbusy = "1"

while VAL(isbusy) = 1 
    
    filestream.Open("isbusy.txt" , 0)
    
    isbusy=""

    WHILE NOT filestream.eof
        isbusy = isbusy + filestream.ReadLine
    WEND
    filestream.Close   
    
    sleep 1000 
    'print "test"
    doevents
    wend
    'print "ok"
    
    defstr filecontentstr
    defdbl xfrac,yfrac,xfrac2=0,yfrac2=0
    defint i=0
    
'    deflng hSrcDC = bmOvl.Handle
'    'create pen with style, width and color
'    deflng hPen = CreatePen(0 , 1 , blue)
'    SelectObject(hSrcDC , hPen)

    
    filestream.Open("test.csv" , 0)
        WHILE NOT filestream.eof            
            filecontentstr = filestream.ReadLine
            i++  
            
            
            
'    xfrac=xfrac2
'    yfrac=yfrac2
'    xfrac2=val(mid$(filecontentstr,1,instr(filecontentstr,",")-1))+600
'    yfrac2=val(mid$(filecontentstr,instr(filecontentstr,",")+1,len(filecontentstr)))+300
' draw line
'            MoveToEx(hSrcDC , xfrac , yfrac , 0)
'            LineTo(hSrcDC , xfrac2 , yfrac2)
         
    
'bmOvl.line(xfrac,yfrac,xfrac2,yfrac2,blue)
            
            'xfrac=xfrac2
            'yfrac=yfrac2
            'xfrac2=val(mid$(filecontentstr,1,instr(filecontentstr,",")-1))+600
            'yfrac2=val(mid$(filecontentstr,instr(filecontentstr,",")+1,len(filecontentstr)))+300
            
            'if xfrac<>0 and yfrac<>0 then bmOvl.line(xfrac,yfrac,xfrac2,yfrac2,blue)
            
            
            if i=1 then
            xfrac=val(mid$(filecontentstr,1,instr(filecontentstr,",")-1))+val(pointx.text)
            yfrac=val(mid$(filecontentstr,instr(filecontentstr,",")+1,len(filecontentstr)))+val(pointy.text)
            'bmOvl.line(xfrac2,yfrac2,xfrac,yfrac,blue)
            end if
            if i=2 then
            xfrac2=val(mid$(filecontentstr,1,instr(filecontentstr,",")-1))+val(pointx.text)
            yfrac2=val(mid$(filecontentstr,instr(filecontentstr,",")+1,len(filecontentstr)))+val(pointy.text)
            bmOvl.line(xfrac,yfrac,xfrac2,yfrac2,black)
            ' draw line
            ''MoveToEx(hSrcDC , xfrac , yfrac , 0)
            ''LineTo(hSrcDC , xfrac2 , yfrac2)

            i=0
            end if
            
            'print str$(xfrac+300)+" "+str$(yfrac)
        'PaintChart
    'doevents
    WEND        
        filestream.Close
    'deflng hSrcDC = bmOvl.Handle
    
    'create pen with style, width and color
    'deflng hPen = CreatePen(PS_DOT , 1 , blue)
    'SelectObject(hSrcDC , hPen)
     
    ' draw line
    'MoveToEx(hSrcDC , rcDraw.Left , rcDraw.Top , 0)
    'LineTo(hSrcDC , rcDraw.Right , rcDraw.Bottom)
    
    ' draw rectangle
    'Rectangle(hSrcDC , rcDraw.Left , rcDraw.Top , rcDraw.Right , rcDraw.Bottom)
    
    ' write text
    'Dim intCount As Integer, strString As String
    'strString = "Cool, text on screen !"    
    'Draw the text on the screen
    'SetTextColor hSrcDC, blue
    'Set the bitmap's backmode to transparent
    'SetBkMode hSrcDC, TRANSPARENT
    'defint nSize=24    
    'deflng nDegrees=0
    'deflng CreateMyFont = CreateFont(-MulDiv(nSize, GetDeviceCaps(hSrcDC, LOGPIXELSY), 72), 0, nDegrees * 10, 0, FW_NORMAL, 0, 0, 0, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, "Times New Roman")
    'SelectObject(hSrcDC , CreateMyFont)    
    'TextOut hSrcDC, rcDraw.Left, rcDraw.Top, strString, Len(strString)

    
    'bmOvl.Line(rcDraw.Left , rcDraw.Top , rcDraw.Right , rcDraw.Bottom, 0)
    'BitBlt(graph.handle , 0 , 0 , graph.Width , graph.Height , hSrcDC , 0 , 0 , SRCCOPY)
    'ReleaseDC(hSrcDC , hSrcDC)
    
'    ' delete pen object
'    DeleteObject(hPen)
    
    PaintChart
    'graph.repaint
    frmmain.caption="Ready"
END SUB      

SUB graphmousedown(Button AS INTEGER , x AS INTEGER , y AS INTEGER)

    relativecordx = x
    relativecordy = y
    mousediffx=screen.mousex-relativecordx
    mousediffy=screen.mousey-relativecordy    
    
end sub  

sub savebmpsub
defstr curdirtmp=curdir$
dim dlgSave as qsavedialog

qcShowSave :
dlgSave.Caption = "Save Graph"
dlgSave.Filter = "Bitmap Files|*.bmp|All Files|*.*"
dlgSave.FilterIndex = 1
dlgSave.FileName = "*.bmp"
IF dlgSave.Execute AND LEN(dlgSave.FileName) <> 0 THEN
    IF FILEEXISTS(dlgSave.FileName) THEN  'check if file exists
        DIM Response AS INTEGER  'ask user for decision
        Response = MESSAGEDLG("File Already Exists. Overwrite " + dlgSave.FileName + "?" , 0 , 1 OR 2 OR 8 , 0) 'Y OR N OR Cancel
        SELECT CASE Response
            CASE 7  'NO; don't overwrite, ask again
                GOTO qcShowSave  '<--- Use of a local GOTO loop!
            CASE 2  'CANCEL;don't overwrite, don't ask again
                EXIT SUB
        END SELECT
    END IF
END IF
                DIM File AS QFILESTREAM
                File.Open(dlgSave.FileName , 65535) '65535 = fmCreate
                bmOvl.SaveToStream(File) 'save the data
                File.Close
                chdir curdirtmp
end sub  

sub savelsyssub
defstr curdirtmp=curdir$
DIM SaveDialog AS QSAVEDIALOG
    SaveDialog.Caption = "Save LSys"
    SaveDialog.Filter = "LSY File|*.lsy"
    SaveDialog.FilterIndex = 1
    SaveDialog.FileName = "template.lsy"

    IF SaveDialog.Execute THEN
    
        DIM filestream AS QFILESTREAM
        filestream.open(SaveDialog.FileName , 65535) '65535 = fmCreate 
        'filestream.writeline("test")    
        defint i
        
        
        filestream.writeline("axiom="+axiom.text+",")
filestream.writeline("production1="+production1.text+",")
filestream.writeline("rule1="+rule1.text+",")
filestream.writeline("production2="+production2.text+",")
filestream.writeline("rule2="+rule2.text+",")
filestream.writeline("production3="+production3.text+",")
filestream.writeline("rule3="+rule3.text+",")
filestream.writeline("production4="+production4.text+",")
filestream.writeline("rule4="+rule4.text+",")
filestream.writeline("production5="+production5.text+",")
filestream.writeline("rule5="+rule5.text+",")
filestream.writeline("production6="+production6.text+",")
filestream.writeline("rule6="+rule6.text+",")
filestream.writeline("production7="+production7.text+",")
filestream.writeline("rule7="+rule7.text+",")
filestream.writeline("production8="+production8.text+",")
filestream.writeline("rule8="+rule8.text+",")
filestream.writeline("production9="+production9.text+",")
filestream.writeline("rule9="+rule9.text+",")
filestream.writeline("increment="+increment.text+",")
filestream.writeline("length="+length.text+",")
filestream.writeline("angle="+angle.text+",")
filestream.writeline("pointx="+pointx.text+",")
filestream.writeline("pointy="+pointy.text+",")          
filestream.close
END IF
  chdir curdirtmp
end sub

sub loadlsyssub
defstr curdirtmp=curdir$
DIM OpenDialog AS QOPENDIALOG
    IF OpenDialog.Execute THEN
         OpenDialog.Caption = "Open LSys"
    OpenDialog.Filter = "LSY File|*.lsy"
    OpenDialog.FilterIndex = 1    

DIM filestream AS QFILESTREAM
        DEFSTR filecontentstr = ""
        defint separatorpos,j=1
        defstr valuestr,objectname,price1,price2,unixtime1,unixtime2,labelname,value2str,value3str,value4str,value5str,objectnametmp=""
               
filestream.Open(OpenDialog.FileName , 0)
        WHILE NOT filestream.eof            
            filecontentstr = filestream.ReadLine
            
            separatorpos = 0

            valuestr = MID$(filecontentstr , separatorpos + 1 , LEN(filecontentstr))
            separatorpos=INSTR(0 , valuestr , "=")
            objectname = MID$(valuestr , 0 , separatorpos - 1)
            if objectname=objectnametmp then 
                j++            
            else
                j=1
            end if
            objectnametmp=objectname            
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            price1 = MID$(valuestr , 0 , separatorpos - 1)
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            price2 = MID$(valuestr , 0 , separatorpos - 1)
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            unixtime1 = MID$(valuestr , 0 , separatorpos - 1)
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            unixtime2 = MID$(valuestr , 0 , separatorpos - 1)
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            labelname = MID$(valuestr , 0 , separatorpos - 1)
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            value2str = MID$(valuestr , 0 , separatorpos - 1)
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            value3str = MID$(valuestr , 0 , separatorpos - 1)
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            value4str = MID$(valuestr , 0 , separatorpos - 1)
            
            valuestr = MID$(valuestr , separatorpos + 1 , LEN(valuestr))
            separatorpos=INSTR(0 , valuestr , ",")
            value5str = MID$(valuestr , 0 , separatorpos - 1)
            
            select case objectname
            
                case "axiom":
                axiom.text=price1
                case "production1":
                production1.text=price1
                case "rule1":
                rule1.text=price1
                case "production2":
                production2.text=price1
                case "rule2":
                rule2.text=price1
                case "production3":
                production3.text=price1
                case "rule3":
                rule3.text=price1
                case "production4":
                production4.text=price1
                case "rule4":
                rule4.text=price1
                case "production5":
                production5.text=price1
                case "rule5":
                rule5.text=price1
                case "production6":
                production6.text=price1
                case "rule6":
                rule6.text=price1
                case "production7":
                production7.text=price1
                case "rule7":
                rule7.text=price1
                case "production8":
                production8.text=price1
                case "rule8":
                rule8.text=price1
                case "production9":
                production9.text=price1
                case "rule9":
                rule9.text=price1
                case "increment":
                increment.text=price1
                case "length":
                length.text=price1
                case "angle":
                angle.text=price1
                case "pointx":
                pointx.text=price1
                case "pointy":
                pointy.text=price1
                                                
            end select
        WEND        
        filestream.Close
        end if
        chdir curdirtmp
        IF FILEEXISTS(OpenDialog.FileName) = FALSE THEN
        PRINT " file not found "
        EXIT SUB
    END IF
end sub  

frmmain.showmodal