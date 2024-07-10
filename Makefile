# Makefile for CACHE

# Macros

.IGNORE :

RM_LIST = $(OBJS)

# Targets
# original
# FC      = pgf90
FC      = gfortran
# FC = ifort

# normal FLAGS
# FLAGS = -c -Mpreprocess -O -fast -pc 64 -Kieee 
# sometimes used for run-time checking of array index output bounds
# FLAGS = -c -Mpreprocess -O -fast -pc 64 -Kieee -Mdclchk

# FLAGS gnu
# -Kieee = strict compliance with IEEE 754 -> -frounding-math -fsignaling-nans (Full compliance in GCC)
# -Mpreprocess = cpp (invoke C preprocessor)
# -fast optimizes runtime but less trustworthy, O3 is considered a better option 
# -pc 64 = -fdefault-real-8 -fdefault-double-8 (double precision floating point operations_
# Add ffree-line-length-132 to catch long lines in module_parameters_ddw.f90 
# Add -fno-align-commons
# FLAGS = -c -cpp -O2 -fdefault-real-8 -fdefault-double-8 -frounding-math -fsignaling-nans -ffree-line-length-256 -fno-align-commons -check all
# debug flags - gdb
FLAGS = -c -g -cpp -O2 -fdefault-real-8 -fdefault-double-8 -frounding-math -fsignaling-nans -ffree-line-length-256 -fno-align-commons


# FLAGS ifort
# normal FLAGS
# FLAGS = -c -fpp -O -pc 64 -mieee-fp
# debuggin FLAGS
# FLAGS = -c -g -fpp -O0 -pc64 -mieee-fp 
# Additional flag to check additional issues
# FLAGS = -c -g -fpp -O0 -pc64 -mieee-fp -check all


# Suffix rules and commands

.SUFFIXES : .f .f90 .F .o .mod

.f.o :
	$(FC) $(FLAGS) $<

.f90.mod:
	$(FC) $(FLAGS) $<

.f90.o :
	$(FC) $(FLAGS) $<

.F.o   :
	$(FC) $(FLAGS) $<

OBJS= cacm3_Precision.o \
      cacm3_Parameters.o\
      module_parameters_ddw.o\
      module_wkppc_constants.o\
      cacm3_Rates.o \
      cacm3_JacobianSP.o \
      cacm3_Jacobian.o   \
      cacm3_LinearAlgebra.o   \
      cacm3_Function.o   \
      cacm3_Integrator.o  \
      module_cacm_interface.o  \
      main.o\
      save.o\
      plant.o\
      transp.o \
      soil.o\
      sources.o\
      radia.o\
      modd_glodef.o modd_glo.o modd_aunifacparam.o modd_binsolu.o\
      modd_bunifacparam.o mode_zsrpun.o mode_unifac.o mode_soatinit.o\
      mode_soaeqlutl.o mode_soaeql.o mode_firstguess.o mode_oamain.o\
      soa_main_mpmpo.o mpmpo_interface.o  
      

EXE   = forcast.exe

$(EXE):	$(OBJS)
	$(FC) -o $@   $(OBJS)

main.o : main.f
	$(FC) $(FLAGS)   main.f
save.o : save.f
	$(FC) $(FLAGS)   save.f
plant.o : plant.f
	$(FC) $(FLAGS)   plant.f
transp.o : transp.f
	$(FC) $(FLAGS)   transp.f
soil.o : soil.f
	$(FC) $(FLAGS)   soil.f
sources.o : sources.f
	$(FC) $(FLAGS)   sources.f
radia.o : radia.f
	$(FC) $(FLAGS)   radia.f
module_parameters_ddw.o : module_parameters_ddw.f90 
	$(FC) $(FLAGS)    module_parameters_ddw.f90
module_wkppc_constants.o : module_wkppc_constants.f90 
	$(FC) $(FLAGS)    module_wkppc_constants.f90
module_cacm_interface.o : module_cacm_interface.f90 
	$(FC) $(FLAGS)    module_cacm_interface.f90
cacm_Precision.o : cacm3_Precision.f90 
	$(FC) $(FLAGS)    cacm3_Precision.f90
cacm_Parameters.o : cacm3_Parameters.f90
	$(FC) $(FLAGS)    cacm3_Parameters.f90
cacm_JacobianSP.o : cacm3_JacobianSP.f90
	$(FC) $(FLAGS)    cacm3_JacobianSP.f90
cacm_Jacobian.o : cacm3_Jacobian.f90
	$(FC) $(FLAGS)    cacm3_Jacobian.f90
cacm_Rates.o : cacm3_Rates.f90 
	$(FC) $(FLAGS)   cacm3_Rates.f90
cacm_LinearAlgebra.o : cacm3_LinearAlgebra.f90
	$(FC) $(FLAGS)    cacm3_LinearAlgebra.f90
cacm_Function.o : cacm3_Function.f90
	$(FC) $(FLAGS)    cacm3_Function.f90
cacm_Integrator.o : cacm3_Integrator.f90
	$(FC) $(FLAGS)    cacm3_Integrator.f90

clean :
	$(RM) $(RM_LIST) *.mod *.o

distclean :
	$(RM) $(RM_LIST) $(EXE) *.mod
