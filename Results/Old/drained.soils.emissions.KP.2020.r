

#11.7.2012: Copied to 2011 folder, updated paths

### Taken to the hsan2 25.10.2010
#######################
##############   15.10.2009 yasso model for drained organic soils

#Modified from 2009 inventory to 2010 inventory, 24.5.2011, PPuo
# taken to be used for inventory 10.10.2011 Aleh
# NOTE THIS IS FOR KP REPORTING!!

yr <- 2020
yr.VANHA <- 2019

#<path <- '/hsan2/khk/ghg/'
path <- '/data/d4/projects/khk/ghg/'
#Input paths:

funpath <- paste(path,yr,'/soil/functions/',sep="")
nfidata <- paste(path,yr,'/soil/nfidata/',sep="")
draindata <- paste(path,yr,'/trees/drain/remaining/litter/lulucf/',sep="")
figpath <- paste(path,yr,'/soil/organic/remaining/figs/', sep="")
resultspath <- paste(path,yr,'/soil/organic/remaining/results/', sep="")
undpath <- paste(path,yr,'/soil/understorey/litter/',sep="")
areas <- paste(path,yr,'/areas/',sep="")
crf <- paste(path,yr,'/crf/',sep="")
nir <- paste(path,yr,'/NIR/',sep="")

# Southern Finland

# UND
und.org.abv <-  (read.csv(paste(undpath,"und.org.abv.csv", sep=""), header=TRUE))
und.org.bel <-  (read.csv(paste(undpath,"und.org.bel.csv", sep=""), header=TRUE))

# TRE
nwl.sf.nfi90.org.abv <-  (read.csv(paste(nfidata,"nfi10/litter/nwl.sf.1990",yr,".org.abv.csv", sep=""), header=TRUE))
fwl.sf.nfi90.org.abv <-  (read.csv(paste(nfidata,"nfi10/litter/fwl.sf.1990",yr,".org.abv.csv", sep=""), header=TRUE))
nwl.sf.nfi90.org.bel <-  (read.csv(paste(nfidata,"nfi10/litter/nwl.sf.1990",yr,".org.bel.csv", sep=""), header=TRUE))
fwl.sf.nfi90.org.bel <-  (read.csv(paste(nfidata,"nfi10/litter/fwl.sf.1990",yr,".org.bel.csv", sep=""), header=TRUE))


#LOG
log.nwl.SF.org.abv <-  read.csv(paste(draindata,"log.nwl.SF.org.abv.csv", sep=""), header=TRUE)
log.nwl.SF.org.bel <-  read.csv(paste(draindata,"log.nwl.SF.org.bel.csv", sep=""), header=TRUE)
log.fwl.SF.org.abv <-  read.csv(paste(draindata,"log.fwl.SF.org.abv.csv", sep=""), header=TRUE)
log.fwl.SF.org.bel <-  read.csv(paste(draindata,"log.fwl.SF.org.bel.csv", sep=""), header=TRUE)
log.cwl.SF.org.abv <-  read.csv(paste(draindata,"log.cwl.SF.org.abv.csv", sep=""), header=TRUE)

#NAT
nat.nwl.SF.org.abv <-  read.csv(paste(draindata,"nat.nwl.SF.org.abv.csv", sep=""), header=TRUE)
nat.nwl.SF.org.bel <-  read.csv(paste(draindata,"nat.nwl.SF.org.bel.csv", sep=""), header=TRUE)
nat.fwl.SF.org.abv <-  read.csv(paste(draindata,"nat.fwl.SF.org.abv.csv", sep=""), header=TRUE)
nat.fwl.SF.org.bel <-  read.csv(paste(draindata,"nat.fwl.SF.org.bel.csv", sep=""), header=TRUE)
nat.cwl.SF.org.abv <-  read.csv(paste(draindata,"nat.cwl.SF.org.abv.csv", sep=""), header=TRUE)
 
## DOM
impute.sf <- length(seq(1998,yr))
dom.sf <- c(0,0,0,0,0,0,0,0,rep(0.00754106277747484,impute.sf))
# based on NFI9 and NFI10 permanent sample plots !



#####################
# 3b. Northern Finland
#####################

# UND
und.org.abv <-  (read.csv(paste(undpath,"und.org.abv.csv", sep=""), header=TRUE))
und.org.bel <-  (read.csv(paste(undpath,"und.org.bel.csv", sep=""), header=TRUE))

# TRE

#NOTE: Here 2011!
nwl.nf.nfi90.org.abv <-  (read.csv(paste(nfidata,"nfi10/litter/nwl.nf.1990",yr,".org.abv.csv", sep=""), header=TRUE))
fwl.nf.nfi90.org.abv <-  (read.csv(paste(nfidata,"nfi10/litter/fwl.nf.1990",yr,".org.abv.csv", sep=""), header=TRUE))
nwl.nf.nfi90.org.bel <-  (read.csv(paste(nfidata,"nfi10/litter/nwl.nf.1990",yr,".org.bel.csv", sep=""), header=TRUE))
fwl.nf.nfi90.org.bel <-  (read.csv(paste(nfidata,"nfi10/litter/fwl.nf.1990",yr,".org.bel.csv", sep=""), header=TRUE))

#LOG
log.nwl.NF.org.abv <-  read.csv(paste(draindata,"log.nwl.NF.org.abv.csv", sep=""), header=TRUE)
log.nwl.NF.org.bel <-  read.csv(paste(draindata,"log.nwl.NF.org.bel.csv", sep=""), header=TRUE)
log.fwl.NF.org.abv <-  read.csv(paste(draindata,"log.fwl.NF.org.abv.csv", sep=""), header=TRUE)
log.fwl.NF.org.bel <-  read.csv(paste(draindata,"log.fwl.NF.org.bel.csv", sep=""), header=TRUE)
log.cwl.NF.org.abv <-  read.csv(paste(draindata,"log.cwl.NF.org.abv.csv", sep=""), header=TRUE)

#NAT
nat.nwl.NF.org.abv <-  read.csv(paste(draindata,"nat.nwl.NF.org.abv.csv", sep=""), header=TRUE)
nat.nwl.NF.org.bel <-  read.csv(paste(draindata,"nat.nwl.NF.org.bel.csv", sep=""), header=TRUE)
nat.fwl.NF.org.abv <-  read.csv(paste(draindata,"nat.fwl.NF.org.abv.csv", sep=""), header=TRUE)
nat.fwl.NF.org.bel <-  read.csv(paste(draindata,"nat.fwl.NF.org.bel.csv", sep=""), header=TRUE)
nat.cwl.NF.org.abv <-  read.csv(paste(draindata,"nat.cwl.NF.org.abv.csv", sep=""), header=TRUE)

### DOM
# based on NFI9 and NFI10 permanent sample plot data

impute.nf <- length(seq(2002,yr))
dom.nf <- c(0,0,0,0,0,0,0,0,0,0,0,0, rep(0.00720002212248889,impute.nf) )

###Annual litter flux to belowground

nwl.bel <- nwl.sf.nfi90.org.bel+log.nwl.SF.org.bel[21:dim(log.nwl.SF.org.bel)[1], ]+nat.nwl.SF.org.bel[21:dim(nat.nwl.SF.org.bel)[1], ]+t(matrix(und.org.bel))
fwl.bel <- fwl.sf.nfi90.org.bel+log.fwl.SF.org.bel[21:dim(log.fwl.SF.org.bel)[1], ]+nat.fwl.SF.org.bel[21:dim(nat.fwl.SF.org.bel)[1], ]


litter.bel.sf <- rowSums(nwl.bel+fwl.bel)

#### Annual emissions from drained peat sites  g C m-2 a-1 to ton C /ha (note CARBON)

Rhtkg <- 425.7*0.01
Mtkg <- 312.1*0.01
Ptkg <- 242.3*0.01
Vatkg <- 218.9*0.01
Jatkg <- 185.2*0.01



Rhtkg.emis.sf <- (litter.bel.sf-Rhtkg)+dom.sf
Mtkg.emis.sf <- (litter.bel.sf-Mtkg)+dom.sf
Ptkg.emis.sf <- (litter.bel.sf-Ptkg)+dom.sf
Vatkg.emis.sf <- (litter.bel.sf-Vatkg)+dom.sf
Jatkg.emis.sf <- (litter.bel.sf-Jatkg)+dom.sf



## Writing tkg emissions

tkg.emiss.sf <- rbind(Rhtkg.emis.sf,Mtkg.emis.sf,Ptkg.emis.sf,Vatkg.emis.sf,Jatkg.emis.sf)
write.csv(tkg.emiss.sf, (paste(resultspath,"tkg.emiss.sf.KP.csv", sep="")))

###Annual litter flux to belowground

nwl.bel <- nwl.nf.nfi90.org.bel+log.nwl.NF.org.bel[9:dim(log.nwl.NF.org.bel)[1], ]+nat.nwl.NF.org.bel[9:dim(nat.nwl.NF.org.bel)[1], ]+t(matrix(und.org.bel))
fwl.bel <- fwl.nf.nfi90.org.bel+log.fwl.NF.org.bel[9:dim(log.fwl.NF.org.bel)[1], ]+nat.fwl.NF.org.bel[9:dim(nat.fwl.NF.org.bel)[1], ]


litter.bel.nf <- rowSums(nwl.bel+fwl.bel)

#### Annual emissions from drained peat sites  g C m-2 a-1 to ton C /ha (note CARBON)

Rhtkg <- 425.7*0.01
Mtkg <- 312.1*0.01
Ptkg <- 242.3*0.01
Vatkg <- 218.9*0.01
Jatkg <- 185.2*0.01

Rhtkg.emis.nf <- (litter.bel.nf-Rhtkg)+dom.nf
Mtkg.emis.nf <- (litter.bel.nf-Mtkg)+dom.nf
Ptkg.emis.nf <- (litter.bel.nf-Ptkg)+dom.nf
Vatkg.emis.nf <- (litter.bel.nf-Vatkg)+dom.nf
Jatkg.emis.nf <- (litter.bel.nf-Jatkg)+dom.nf
## 
tkg.emiss.nf <- rbind(Rhtkg.emis.nf,Mtkg.emis.nf,Ptkg.emis.nf,Vatkg.emis.nf,Jatkg.emis.nf)
write.csv(tkg.emiss.nf, (paste(resultspath,"tkg.emiss.nf.KP.csv", sep="")))

##################################################
# 6. MAKING SOME GRAPHS                          #
##################################################



##############################################
###
### Reading in land areas, estimating total emissions for Finland, 
### writing output to crf and NIR folders
##############################################



fmareas <-  read.table(paste(areas,"kplulucf/results/FM.txt", sep=""), header=TRUE)
# according to the vegetation class
fmareaskpy <-  read.table(paste(areas,"kplulucf/results/FM_kptyy.txt", sep=""), header=TRUE)

#kpy <- aggregate(fmareaskpy[, c("X1990","X1991","X1992","X1993","X1994","X1995","X1996","X1997","X1998","X1999","X2000","X2001","X2002","X2003","X2004","X2005","X2006","X2007","X2008","X2009","X2010","X2011","X2012","X2013","X2014","X2015","X2016")], by=list(region=fmareaskpy$region, soil=fmareaskpy$soil,kptyy=fmareaskpy$kptyy), FUN=sum)
kpy <- aggregate(fmareaskpy[, paste("X",1990:yr,sep="")], by=list(region=fmareaskpy$region, soil=fmareaskpy$soil,kptyy=fmareaskpy$kptyy), FUN=sum) 

                           
fm.sf <- subset(kpy, (region==1 & kptyy>0 & kptyy <10)) #NOTE: check
fm.nf <- subset(kpy, (region==2 & kptyy>0 & kptyy <10)) #NOTE: check

rep.years <- seq(1990,yr)
nobs <- length(rep.years)

emis.sf.fm <- tkg.emiss.sf * fm.sf[,4:dim(fm.sf)[2]]
emis.nf.fm <- tkg.emiss.nf * fm.nf[,4:dim(fm.nf)[2]]

emis.sf <- colSums(emis.sf.fm)
emis.nf <- colSums(emis.nf.fm)

emis.fm <- colSums(emis.sf.fm+emis.nf.fm)


emis.fm.co2 <- emis.fm*(44/12)


# Kyoto
KP5B1.organic.soil.sf <- t(round(emis.sf/1000,3))
KP5B1.organic.soil.nf <- t(round(emis.nf/1000,3))
KP5B1.organic.soil <- rbind(KP5B1.organic.soil.sf,KP5B1.organic.soil.nf)
rownames(KP5B1.organic.soil) <- c("#SF,ktC# {A97AC51C-B072-430E-9A9F-367B4C0B91EA}","#NF,ktC# {85EA1BE9-24CE-4C70-AB99-35E670076887}")


write.table(KP5B1.organic.soil, paste(crf,"KP4B1_organic_soil_emission.csv", sep=""), sep=" ", row.names = TRUE, col.names = FALSE, quote=FALSE)

plot(seq(1990,yr), colSums(KP5B1.organic.soil), type="l", col="blue", ylab="carbon stock change Gg C", main="Carbon stock change of drained organic soils, Finland", xlab="years")
dev.print(file=paste(figpath,"emissions.drained.org.kp.eps", sep=""), height=12, width=10, horizontal=FALSE)

###NIR-table 11.1-2

emis.nir <- -round(emis.fm.co2/1000, 3)

write.table(emis.nir, paste(nir,"Table_11.1-2_org_soils.csv", sep=""), sep=" ", row.names = TRUE, col.names = FALSE, quote=FALSE)


