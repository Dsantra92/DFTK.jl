# Writes various array to VTK files
# Uses WriteVTK.jl
using WriteVTK

function EnergyToVTK(VTKFileName::String, energy::Energies{<:Number})
    vtkfile = vtk_grid(VTKFileName, 1, 1)
    @inbounds for i in keys(energy)
        vtkfile[i] = energy.energies[i]
    end
    out = vtk_save(vtkfile)
    return out
end

