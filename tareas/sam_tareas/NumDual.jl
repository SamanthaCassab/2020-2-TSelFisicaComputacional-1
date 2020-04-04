
#+
#Modulo del numero dual 
module NumDual
export Dual,var_dual
struct Dual{ T <: Real}
x :: T
y :: T
end
Dual(x::T) where {T<:Real} = Dual{T}(x,zero(x))
import Base: show, +, *, -, /
+(a::Dual, b::Dual) = Dual(a.x + b.x,a.y + b.y)
-(a::Dual, b::Dual) = Dual(a.x - b.x,a.y - b.y)
*(a::Dual, b::Dual) = Dual(a.x*b.x,a.x*b.y + b.x*a.y)
/(a::Dual, b::Dual) = Dual(a.x/b.x,(b.x*a.y-a.x*b.y)/b.x^2)

+(a::T, b::Dual) where {T<:Real} = Dual(a + b.x, b.y)
+(a::Dual, b::T) where {T<:Real}  = b + a

*(a::T, b::Dual ) where {T<:Real} = Dual(a * b.x, a * b.y)
*(a::Dual, b::T) where {T<:Real}  = b * a

-(a::T, b::Dual) where {T<:Real} = Dual(a - b.x, -b.y)
-(a::Dual, b::T) where {T<:Real}  = Dual(a.x - b, a.y)

/(a::T, b::Dual) where {T<:Real} = Dual(a / b.x, -a * b.y/(b.x^2))
/(a::Dual, b::T) where {T<:Real}  = Dual(a.x / b, a.y / b)

var_dual(x) = Dual(x,one(x))
end
#+
