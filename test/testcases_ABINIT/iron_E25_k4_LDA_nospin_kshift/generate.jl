include("../../testcases.jl")
using PyCall
using DFTK

atoms = [ElementPsp(:Fe, psp=load_psp(iron_bcc.psp)) => iron_bcc.positions]
model = model_DFT(iron_bcc.lattice, atoms, :lda_xc_teter93,
                  temperature=iron_bcc.temperature, smearing=Smearing.FermiDirac())

abinitpseudos = [joinpath(@__DIR__, "Fe-q8-lda.abinit.hgh")]
DFTK.run_abinit_scf(model, @__DIR__; abinitpseudos=abinitpseudos,
                    Ecut=25, kgrid=[4, 4, 4], shiftk=[1/2, 1/2, 1/2],
                    n_bands=10, tol=1e-10, iscf=3)
# iscf == 3: Use Anderson mixing instead of minimization
