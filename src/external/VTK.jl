# Uses WriteVTK.jl to convert various structures to VTk file format
using WriteVTK

"""
Returns th
"""
function EnergyToVTK(VTKFileName::String, energy::Energies{<:Number})
    vtkfile = vtk_grid(VTKFileName, 1, 1)
    for i in keys(energy)
        vtkfile[i] = energy.energies[i]
    end
    out = vtk_save(vtkfile)
    return out[1]
end

"""
Returns Image data of densities.
"""
function DensityToVtk(VTKFileName::String, Density::RealFourierArray{T, <: AbstractArray{T, 3},  <: AbstractArray{Complex{T}, 3}}) where T<:Real
    out = vtk_write_array(VTKFileName,(Density.real, Base.getproperty.(Density.fourier, :re), Base.getproperty.(Density.fourier, :im)),
                    ("Real", "Fourier Real", "Fourier Complex"))
    return out[1]
end

"""
Returns Image data of Eigen values.
"""
function EigenValuesToVTK(VTKFileName::String, Eigenvalues::Array{Array{T,1},1}) where T<:Real
    eigen_mat = hcat(Eigenvalues...)
    out = vtk_write_array(VTKFileName, eigen_mat, "Occupation")
    return out[1]
end

"""
Returns Image data of the wave.
"""
function WavesTOVTK(VTKFIleName::String, wave)
    size = (size(wave[1])[2], maximum(x->size(x)[1], wave), length(wave))
    wave_mat = zeros(Complex, size...)
    @views for i = 1:length(wave)
        wave_mat[:,:,i] = wave[i]
    end
    out = vtk_write_array(VTKFileName, wave_mat, "Wave")
    return out[1]
end
"""
Returns Image data of the occupation.
"""
function OccupationToVTK(VTKFileName::String, occupation::Array{Array{T,1},1}) where T
    occupation_mat = hcat(occupation)
    out = vtk_write_array(VTKFileName, occupation_mat, "Eigen values")
    return out[1]
end