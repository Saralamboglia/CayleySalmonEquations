print 'The following 45 equations are for the tritangent planes. If one of them equals 0 then rerun the code'

#choose a random point in the line defined by P1, P2
def RandomPoint(P1, P2):
    rnumber = ZZ.random_element(0,21) - 10
    return [P1[i] + rnumber*P2[i] for i in range(4)];
    
def SQRTconjugate(n,d):
    return (n-2*n.coefficient(sqrt(d))*sqrt(d))
    
def RotateAndPlane(P1,P2,P3):
    return Matrix([[x,y,z,w],P1,P2,P3]).det();

var('x y z w')
tritangentplanes = {}

Q1 =  -2
Q2 = -sqrt(5) - 3
Q3 = -sqrt(5) + 1
Q4 =  2*sqrt(5)

R1 = 1 + sqrt(5)
R2 = 2
R3 = -2
R4 = -(1 + sqrt(5))

Lines = {
    'E1' : RandomPoint([1,-1,0,0],[0,0,1,-1]),
    'E2' : RandomPoint([1,0,-1,0],[0,0,0,1]),
    'E3' : RandomPoint([4,Q1,Q3,Q4],[0,R1,R3,R4]),
    'E4' : RandomPoint([4,Q2,Q3,Q1],[0,R2,R3,R1]),
    'E5' : RandomPoint([4,Q2,Q1,Q4],[0,R2,R1,R4]),
    'E6' : RandomPoint([1,0,0,0],[0,1,0,-1]),
    
    'F12' : RandomPoint([4,Q3,Q1,Q2],[0,R3,R1,R2]),
    'F13' : RandomPoint([1,0,0,-1],[0,1,-1,0]),
    'F14' : RandomPoint([1,-1,0,0],[0,0,1,0]),
    'F15' : RandomPoint([0,1,0,0],[0,0,1,-1]),
    'F16' : RandomPoint([4,Q1,Q4,Q2],[0,R1,R4,R2]),
    
    'F23' : RandomPoint([1,0,-1,0],[0,1,0,0]),
    'F24' : RandomPoint([0,1,-1,0],[0,0,0,1]),
    'F25' : RandomPoint([1,0,0,-1],[0,0,1,0]),
    'F26' : RandomPoint([4,Q1,Q2,Q3],[0,R1,R2,R3]),
    
    'F34' : RandomPoint([4,Q1,Q3,Q2],[0,R1,R3,R2]),
    'F35' : RandomPoint([4,Q1,Q4,Q3],[0,R1,R4,R3]),
    'F36' : RandomPoint([0,1,0,-1],[0,0,1,0]),
    
    'F45' : RandomPoint([4,Q2,Q1,Q3],[0,R2,R1,R3]),
    'F46' : RandomPoint([1,0,0,-1],[0,1,0,0]),
    
    'F56' : RandomPoint([1,0,0,0],[0,1,-1,0]),
    
    'G1' : RandomPoint([4,Q2,Q4,Q1],[0,R2,R4,R1]),
    'G2' : RandomPoint([4,Q2,Q3,Q4],[0,R2,R3,R4]),
    'G3' : RandomPoint([1,0,-1,0],[0,1,0,-1]),
    'G4' : RandomPoint([1,-1,0,0],[0,0,0,1]),
    'G5' : RandomPoint([1,0,0,0],[0,0,1,-1]),
    'G6' : RandomPoint([4,Q1,Q2,Q4],[0,R1,R2,R4])
}

#First loop for Type Il planes
for Il in Arrangements([1,2,3,4,5,6],2):
    i = Il[0];
    j = Il[1];
    io = str(min(i,j));
    jo = str(max(i,j));
    i = str(i)
    j = str(j)
    A = [Lines["E" + i], Lines["G" + j], Lines["F" + io +jo]]
    
    fA = RotateAndPlane(A[0],A[1],A[2])
    
    if fA.coefficient(w) != 0:
        fA = (fA * SQRTconjugate(fA.coefficient(w), 5)).simplify_full()
        fA = fA/fA.coefficient(w) 
        
    if fA.coefficient(z) != 0:
        fA = (fA * SQRTconjugate(fA.coefficient(z), 5)).simplify_full()
        fA = fA/fA.coefficient(z) 
    
    if fA.coefficient(y) != 0:
        fA = (fA * SQRTconjugate(fA.coefficient(y), 5)).simplify_full()
        fA = fA/fA.coefficient(y)   
        
    if fA.coefficient(x) != 0:
        fA = (fA * SQRTconjugate(fA.coefficient(x), 5)).simplify_full()
        fA = fA/fA.coefficient(x)
        
    tritangentplanes["E" + i + "G" + j + "F" + io +jo] = fA
          
    print fA
    
    
#First loop for Type II planes
for Il in SetPartitions(6, [2,2,2]):
    i = str(list(Il[0])[0])
    j = str(list(Il[0])[1])
    k = str(list(Il[1])[0])
    l = str(list(Il[1])[1])
    m = str(list(Il[2])[0])
    n = str(list(Il[2])[1])
    A = [Lines["F" + i + j], Lines["F" + k + l], Lines["F" + m + n]]
    
    fA = RotateAndPlane(A[0],A[1],A[2])
    
    if fA.coefficient(w) != 0:
        fA = (fA * SQRTconjugate(fA.coefficient(w), 5)).simplify_full()
        fA = fA/fA.coefficient(w) 
        
    if fA.coefficient(z) != 0:
        fA = (fA * SQRTconjugate(fA.coefficient(z), 5)).simplify_full()
        fA = fA/fA.coefficient(z) 
    
    if fA.coefficient(y) != 0:
        fA = (fA * SQRTconjugate(fA.coefficient(y), 5)).simplify_full()
        fA = fA/fA.coefficient(y)   
        
    if fA.coefficient(x) != 0:
        fA = (fA * SQRTconjugate(fA.coefficient(x), 5)).simplify_full()
        fA = fA/fA.coefficient(x)
        
    tritangentplanes[frozenset(["F" + i + j, "F" + k + l, "F" + m + n])] = fA
          
    print fA


print 'The following 120 equations are the CS forms, the constant K can be determined in each individual case by evaluating at some point P in S outside l1, l2, l3, m1, m2, m3'


def jin(i,j):
    return ''.join(map(str,list(set([int(i),int(j)]))))

var('K, eta')

eta = 1
S = x^3 + y^3 + z^3 + w^3 - (x+y+z+w)^3
Triederpaare = []

#First loop for Type I Triederpaare
for Il in Subsets([1,2,3,4,5,6],3):
    i = str(Il[0])
    j = str(Il[1])
    k = str(Il[2])
    l1 = tritangentplanes["E" + i + "G" + j + "F" + i + j]
    l2 = tritangentplanes["E" + j + "G" + k + "F" + j + k]
    l3 = tritangentplanes["E" + k + "G" + i + "F" + i + k]
    m1 = tritangentplanes["E" + i + "G" + k + "F" + i + k]
    m2 = tritangentplanes["E" + k + "G" + j + "F" + j + k]
    m3 = tritangentplanes["E" + j + "G" + i + "F" + i + j]

    print eta, " :    ", l1*l2*l3 - K * m1*m2*m3
    eta = eta+1
    
#Second loop for type II Triederpaare
for Il in Subsets([1,2,3,4,5,6],4): 
    for J1 in Subsets(Il,2):
        J2 = list(set(Il) - set(J1))
        J3 = list(set([1,2,3,4,5,6]) - set(Il))     
        i = str(J1[0])
        j = str(J1[1])
        k = str(min(J2[0],J2[1]))
        l = str(max(J2[0],J2[1]))
        m = str(min(J3[0],J3[1]))
        n = str(max(J3[0],J3[1]))
                        
        l1 = tritangentplanes["E" + i + "G" + j + "F" + i + j]
        l2 = tritangentplanes["E" + l + "G" + k + "F" + k + l]
        l3 = tritangentplanes[frozenset(["F" + jin(i, k), "F" + jin(j, l), "F" + jin(m, n)])]
        m1 = tritangentplanes["E" + i + "G" + k + "F" + jin(i, k)]
        m2 = tritangentplanes["E" + l + "G" + j + "F" + jin(j, l)]
        l3 = tritangentplanes[frozenset(["F" + jin(i, j), "F" + jin(k, l), "F" + jin(m, n)])]
        
        print eta, " :    ", l1*l2*l3 - K * m1*m2*m3
        eta = eta+1

#Third loop for type III Triederpaare    
for Il in Subsets([2,3,4,5,6],3): 
    J = list(set([2,3,4,5,6]) - set(Il))     
    i = str(1)
    j = str(Il[0])
    k = str(Il[1])
    l = str(Il[2])
    m = str(J[0])
    n = str(J[1])
    
    l1 = tritangentplanes[frozenset(["F" + jin(i, j), "F" + jin(l, m), "F" + jin(k, n)])]
    l2 = tritangentplanes[frozenset(["F" + jin(l, n), "F" + jin(i, k), "F" + jin(j, m)])]
    l3 = tritangentplanes[frozenset(["F" + jin(k, m), "F" + jin(j, n), "F" + jin(i, l)])]
    m1 = tritangentplanes[frozenset(["F" + jin(i, j), "F" + jin(l, n), "F" + jin(k, m)])]
    m2 = tritangentplanes[frozenset(["F" + jin(l, m), "F" + jin(i, k), "F" + jin(j, n)])]
    m3 = tritangentplanes[frozenset(["F" + jin(k, n), "F" + jin(j, m), "F" + jin(i, l)])]
    
    print eta, " :    ", l1*l2*l3 - K * m1*m2*m3
    eta = eta+1
