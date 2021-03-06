/*
Copyright (c) 2011-2013 Timur Gafarov 

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
*/

module dlib.math.matrix4x4;

private 
{
    import std.math;
    import dlib.math.utils;
    import dlib.math.vector;
    import dlib.math.matrix3x3;
}

public:

struct Matrix4x4(T)
{
    public:

    this(Matrix4x4!(T) m)
    body
    {
        arrayof[] = m.arrayof[];
    }

   /*
    * Return an identity matrix
    */
    static opCall() 
    {
        Matrix4x4!(T) res;
        res.identity();
        return res;
    }

   /*
    * Matrix4x4!(T) * Matrix4x4!(T)
    */
    Matrix4x4!(T) opMul (Matrix4x4!(T) m)
    body
    {       
        Matrix4x4!(T) res;
        res.identity;

        res.m11 = (m11 * m.m11) + (m21 * m.m12) + (m31 * m.m13);
        res.m12 = (m12 * m.m11) + (m22 * m.m12) + (m32 * m.m13);
        res.m13 = (m13 * m.m11) + (m23 * m.m12) + (m33 * m.m13);

        res.m21 = (m11 * m.m21) + (m21 * m.m22) + (m31 * m.m23);
        res.m22 = (m12 * m.m21) + (m22 * m.m22) + (m32 * m.m23);
        res.m23 = (m13 * m.m21) + (m23 * m.m22) + (m33 * m.m23);

        res.m31 = (m11 * m.m31) + (m21 * m.m32) + (m31 * m.m33);
        res.m32 = (m12 * m.m31) + (m22 * m.m32) + (m32 * m.m33);
        res.m33 = (m13 * m.m31) + (m23 * m.m32) + (m33 * m.m33);

        res.tx = (m11 * m.tx) + (m21 * m.ty) + (m31 * m.tz) + tx;
        res.ty = (m12 * m.tx) + (m22 * m.ty) + (m32 * m.tz) + ty;
        res.tz = (m13 * m.tx) + (m23 * m.ty) + (m33 * m.tz) + tz;

        return res;
    }

   /*
    * Matrix4x4!(T) *= Matrix4x4!(T)
    */
    Matrix4x4!(T) opMulAssign (Matrix4x4!(T) m)
    body
    {
        Matrix4x4!(T) res;
        res.identity();

        res.m11 = (m11 * m.m11) + (m21 * m.m12) + (m31 * m.m13);
        res.m12 = (m12 * m.m11) + (m22 * m.m12) + (m32 * m.m13);
        res.m13 = (m13 * m.m11) + (m23 * m.m12) + (m33 * m.m13);

        res.m21 = (m11 * m.m21) + (m21 * m.m22) + (m31 * m.m23);
        res.m22 = (m12 * m.m21) + (m22 * m.m22) + (m32 * m.m23);
        res.m23 = (m13 * m.m21) + (m23 * m.m22) + (m33 * m.m23);

        res.m31 = (m11 * m.m31) + (m21 * m.m32) + (m31 * m.m33);
        res.m32 = (m12 * m.m31) + (m22 * m.m32) + (m32 * m.m33);
        res.m33 = (m13 * m.m31) + (m23 * m.m32) + (m33 * m.m33);

        res.tx = (m11 * m.tx) + (m21 * m.ty) + (m31 * m.tz) + tx;
        res.ty = (m12 * m.tx) + (m22 * m.ty) + (m32 * m.tz) + ty;
        res.tz = (m13 * m.tx) + (m23 * m.ty) + (m33 * m.tz) + tz;
		
        arrayof[] = res.arrayof[];

        return m;
    }

   /* 
    * T = Matrix4x4!(T)[index]
    */
    T opIndex(in int index) const
    in
    {
        assert ((0 <= index) && (index < 16), 
            "Matrix4x4!(T).opIndex(int index): array index out of bounds");
    }
    body
    {
        return arrayof[index];
    }

   /*
    * Matrix4x4!(T)[index] = T
    */
    T opIndexAssign(in T t, in int index)
    in
    {
        assert ((0 <= index) && (index < 16), 
            "Matrix4x4!(T).opIndexAssign(T t, int index): array index out of bounds");
    }
    body
    {
        return (arrayof[index] = t);
    }

   /*
    * Matrix4x4!(T)[index1..index2] = T
    */
    T[] opSliceAssign(in T t, in int index1, in int index2)
    in
    {
        assert ((0 <= index1) && (index1 < 16) && (0 <= index2) && (index2 < 16), 
            "Matrix4x4!(T).opSliceAssign(T t, int index1, int index2): array index out of bounds");
    }
    body
    {
        return (arrayof[index1..index2] = t);
    }

   /* 
    * T = Matrix4x4!(T)[x, y]
    */
    T opIndex(in int x, in int y) const
    in
    {
        assert ((0 < x) && (x < 4) && (0 < y) && (y < 4), 
            "Matrix4x4!(T).opIndex(int x, int y): array index out of bounds");
    }
    body
    {
        return arrayof[y * 4 + x];
    }

   /* 
    * Matrix4x4!(T)[x, y] = T
    */
    T opIndexAssign(in T t, in int x, in int y)
    in
    {
        assert ((0 < x) && (x < 4) && (0 < y) && (y < 4), 
            "Matrix4x4!(T).opIndexAssign(int x, int y): array index out of bounds");
    }
    body
    {
        return (arrayof[y * 4 + x] = t);
    }

   /* 
    * Matrix4x4!(T)[] = T
    */
    T[] opSliceAssign(in T t)
    body
    {
        return (arrayof[] = t);
    }

   /*
    * Set to identity
    */
    void identity()
    body
    {
        m11 = 1.0; m21 = 0.0; m31 = 0.0; tx = 0.0;
        m12 = 0.0; m22 = 1.0; m32 = 0.0; ty = 0.0;
        m13 = 0.0; m23 = 0.0; m33 = 1.0; tz = 0.0;
        h14 = 0.0; h24 = 0.0; h34 = 0.0; tw = 1.0;
    }

   /*
    * Transpose
    */
    void transpose()
    body
    {
        this = transposed;
    }

   /*
    * Convert row-major to column-major and vice versa
    */
    alias transpose toggleStorageOrder;

   /*
    * Invert
    */
    void invert()
    body
    {
        this = inverse;
    }

   /*
    * Transform a point by the matrix
    */
    Vector!(T,3) transform(Vector!(T,3) v)
    body
    {
        return Vector!(T,3) 
        (
            (v.x * m11) + (v.y * m21) + (v.z * m31) + tx,
            (v.x * m12) + (v.y * m22) + (v.z * m32) + ty,
            (v.x * m13) + (v.y * m23) + (v.z * m33) + tz
        );
    }

   /*
    * Rotate a point by the 3x3 upper left portion of the matrix
    */
    Vector!(T,3) rotate(Vector!(T,3) v) 
    body
    {
        return Vector!(T,3) 
        (
            (v.x * m11) + (v.y * m21) + (v.z * m31),
            (v.x * m12) + (v.y * m22) + (v.z * m32),
            (v.x * m13) + (v.y * m23) + (v.z * m33)
        );
    }

   /*
    * Rotate a point by the inverse 3x3 upper left portion of the matrix
    */
    Vector!(T,3) invRotate(Vector!(T,3) v)
    body
    {
        return Vector!(T,3) 
        (
            (v.x * m11) + (v.y * m12) + (v.z * m13),
            (v.x * m21) + (v.y * m22) + (v.z * m23),
            (v.x * m31) + (v.y * m32) + (v.z * m33)
        );
    }
	
   /*
    * Setup a rotation matrix, given XYZ rotation angles
    */
    void fromEuler (Vector!(T,3) v)
    body
    {
        T cx = cos(v.x);
        T sx = sin(v.x);
        T cy = cos(v.y);
        T sy = sin(v.y);
        T cz = cos(v.z);
        T sz = sin(v.z);

        T sxsy = sx * sy;
        T cxsy = cx * sy;

        m11 =  (cy * cz);
        m12 =  (sxsy * cz) + (cx * sz);
        m13 = -(cxsy * cz) + (sx * sz);

        m21 = -(cy * sz);
        m22 = -(sxsy * sz) + (cx * cz);
        m23 =  (cxsy * sz) + (sx * cz);

        m31 =  (sy);
        m32 = -(sx * cy);
        m33 =  (cx * cy);

        tx = ty = tz = 0.0;
    }
	
   /*
    * Setup the euler angles in radians, given a rotation matrix
    */
    void toEuler (ref Vector!(T,3) v)
    body
    {
        v.y = asin(m31);

        T cy = cos(v.y);
        T oneOverCosY = 1.0 / cy;

        if (fabs(cy) > 0.001)
        {
            v.x = atan2(-m32 * oneOverCosY, m33 * oneOverCosY);
            v.z = atan2(-m21 * oneOverCosY, m11 * oneOverCosY);
        }
        else
        {
            v.x = 0.0;
            v.z = atan2(m12, m22);
        }
    }

   /*
    * Right vector of the matrix
    */
    @property
    {
        Vector!(T,3) right()
        body
        {
            return Vector!(T,3) (m11, m12, m13);
        }

        Vector!(T,3) right(Vector!(T,3) v)
        body
        {
            m11 = v.x; m12 = v.y; m13 = v.z;
            return Vector!(T,3) (m11, m12, m13);
        }
    }

   /*
    * Up vector of the matrix
    */
    @property
    {
        Vector!(T,3) up()
        body
        {
            return Vector!(T,3) (m21, m22, m23);
        }

        Vector!(T,3) up(Vector!(T,3) v)
        body
        {
            m21 = v.x; m22 = v.y; m23 = v.z;
            return Vector!(T,3) (m21, m22, m23);
        }
    }

   /* 
    * Forward (direction) vector of the matrix
    */
    @property
    {
        Vector!(T,3) forward()
        body
        {
            return Vector!(T,3) (m31, m32, m33);
        }

        Vector!(T,3) forward(Vector!(T,3) v)
        body
        {
            m31 = v.x; m32 = v.y; m33 = v.z;
            return Vector!(T,3) (m31, m32, m33);
        }
    }

   /*
    * Translation vector of the matrix
    */
    @property
    {
        Vector!(T,3) translation()
        body
        {
            return Vector!(T,3) (tx, ty, tz);
        }

        Vector!(T,3) translation(Vector!(T,3) v)
        body
        {
            tx = v.x; ty = v.y; tz = v.z;
            return v;
        }
    }

   /*
    * Scaling vector of the matrix
    */
    @property
    {
        Vector!(T,3) scaling()
        body
        {
            return Vector!(T,3) (m11, m22, m33);
        }

        Vector!(T,3) scaling(Vector!(T,3) v)
        body
        {
            m11 = v.x; m22 = v.y; m33 = v.z;
            return v;
        }
    }

   /*
    * Return the transpose matrix
    */
    @property Matrix4x4!(T) transposed()
    body
    {
        Matrix4x4!(T) res;

        res.m11 = m11; res.m21 = m12; res.m31 = m13; res.tx = h14;
        res.m12 = m21; res.m22 = m22; res.m32 = m23; res.ty = h24;
        res.m13 = m31; res.m23 = m32; res.m33 = m33; res.tz = h34;
        res.h14 = tx;  res.h24 = ty;  res.h34 = tz;  res.tw = tw;

        return res;	
    }

   /* 
    * Return the determinant of the 3x3 portion of the matrix
    */
    @property T determinant3x3()
    body
    {
        return m11 * ((m22 * m33) - (m23 * m32))
             + m12 * ((m23 * m31) - (m21 * m33))
             + m13 * ((m21 * m32) - (m22 * m31));
    }

   /* 
    * Return the inverse of a matrix
    */
    @property Matrix4x4!(T) inverse()
    body
    {
        T det = determinant3x3;
        assert (fabs(det) > 0.000001);

        T oneOverDet = 1.0 / det;

        Matrix4x4!(T) res;
        res.identity();

        res.m11 = ((m22 * m33) - (m23 * m32)) * oneOverDet;
        res.m12 = ((m13 * m32) - (m12 * m33)) * oneOverDet;
        res.m13 = ((m12 * m23) - (m13 * m22)) * oneOverDet;

        res.m21 = ((m23 * m31) - (m21 * m33)) * oneOverDet;
        res.m22 = ((m11 * m33) - (m13 * m31)) * oneOverDet;
        res.m23 = ((m13 * m21) - (m11 * m23)) * oneOverDet;

        res.m31 = ((m21 * m32) - (m22 * m31)) * oneOverDet;
        res.m32 = ((m12 * m31) - (m11 * m32)) * oneOverDet;
        res.m33 = ((m11 * m22) - (m12 * m21)) * oneOverDet;
      
        res.tx = -((tx * res.m11) + (ty * res.m21) + (tz * res.m31));
        res.ty = -((tx * res.m12) + (ty * res.m22) + (tz * res.m32));
        res.tz = -((tx * res.m13) + (ty * res.m23) + (tz * res.m33));

        return res;
    }

    @property Matrix4x4!(T) negative()
    body
    {
        Matrix4x4!(T) res;
        res.arrayof[] = -arrayof[];
        return res;
    }
	
   /* 
    * Matrix components
    */
    union 
    { 
        struct
        {
            T m11, m12, m13, h14;
            T m21, m22, m23, h24;
            T m31, m32, m33, h34;
            T tx,  ty,  tz,  tw;
        }
        
        T[16] arrayof;
    }
}

/*
 * Return identity matrix
 */
Matrix4x4!(T) identityMatrix4x4(T) ()
body
{
    Matrix4x4!(T) res;
    res.identity();
    return res;
}

/* 
 * Create a matrix to perform a rotation about an arbitrary axis
 */
Matrix4x4!(T) rotationMatrix(T) (int rotaxis, T theta)
body
{
    Matrix4x4!(T) res;
    res.identity();

    T s = sin(theta);
    T c = cos(theta);

    switch (rotaxis)
    {
        case Axis.x:
            res.m11 = 1.0; res.m21 = 0.0; res.m31 = 0.0;
            res.m12 = 0.0; res.m22 = c;   res.m32 = -s;
            res.m13 = 0.0; res.m23 = s;   res.m33 =  c;
            break;

        case Axis.y:
            res.m11 = c;   res.m21 = 0.0; res.m31 = s;
            res.m12 = 0.0; res.m22 = 1.0; res.m32 = 0.0;
            res.m13 = -s;  res.m23 = 0.0; res.m33 = c;
            break;

        case Axis.z:
            res.m11 = c;   res.m21 = -s;  res.m31 = 0.0;
            res.m12 = s;   res.m22 =  c;  res.m32 = 0.0;
            res.m13 = 0.0; res.m23 = 0.0; res.m33 = 1.0;
            break;

        default:
            assert(0);
    }

    res.tx = res.ty = res.tz = 0.0;
    return res;
}

/* 
 * Create a translation matrix given a translation vector
 */
Matrix4x4!(T) translationMatrix(T) (Vector!(T,3) v)
body
{
    Matrix4x4!(T) res;
    res.identity();

    res.m11 = 1.0; res.m21 = 0.0; res.m31 = 0.0; res.tx = v.x;
    res.m12 = 0.0; res.m22 = 1.0; res.m32 = 0.0; res.ty = v.y;
    res.m13 = 0.0; res.m23 = 0.0; res.m33 = 1.0; res.tz = v.z;	

    return res;
}

/*
 * Create a matrix to perform scale on each axis
 */
Matrix4x4!(T) scaleMatrix(T) (Vector!(T,3) v)
body
{
    Matrix4x4!(T) res;
    res.identity();

    res.m11 = v.x;  res.m21 = 0.0;  res.m31 = 0.0;
    res.m12 = 0.0;  res.m22 = v.y;  res.m32 = 0.0;
    res.m13 = 0.0;  res.m23 = 0.0;  res.m33 = v.z;
    res.tx = res.ty = res.tz = 0.0;

    return res;
}

/*
 * Setup the matrix to perform scale along an arbitrary axis
 */
Matrix4x4!(T) scaleAlongAxisMatrix(T) (Vector!(T,3) scaleAxis, T k)
in
{
    assert (fabs (dot(scaleAxis, scaleAxis) - 1.0) < 0.001);
}
body
{
    Matrix4x4!(T) res;

    T a = k - 1.0;
    T ax = a * scaleAxis.x;
    T ay = a * scaleAxis.y;
    T az = a * scaleAxis.z;

    res.m11 = (ax * scaleAxis.x) + 1.0;
    res.m22 = (ay * scaleAxis.y) + 1.0;
    res.m32 = (az * scaleAxis.z) + 1.0;

    res.m12 = res.m21 = (ax * scaleAxis.y);
    res.m13 = res.m31 = (ax * scaleAxis.z);
    res.m23 = res.m32 = (ay * scaleAxis.z);

    res.tx = res.ty = res.tz = 0.0;

    return res;
}

/*
 * Setup the matrix to perform a shear
 */
Matrix4x4!(T) shearMatrix(T) (axis shearAxis, T s, T t)
body
{
    Matrix4x4!(T) res;

    switch (shearAxis)
    {
        case axis.x:
            res.m11 = 1.0; res.m21 = 0.0; res.m31 = 0.0;
            res.m12 = s;   res.m22 = 1.0; res.m32 = 0.0;
            res.m13 = t;   res.m23 = 0.0; res.m33 = 1.0;
            break;

        case axis.y:
            res.m11 = 1.0; res.m21 = s;   res.m31 = 0.0;
            res.m12 = 0.0; res.m22 = 1.0; res.m32 = 0.0;
            res.m13 = 0.0; res.m23 = t;   res.m33 = 1.0;
            break;

        case axis.z:
            res.m11 = 1.0; res.m21 = 0.0; res.m31 = s;
            res.m12 = 0.0; res.m22 = 1.0; res.m32 = t;
            res.m13 = 0.0; res.m23 = 0.0; res.m33 = 1.0;
            break;

        default:
            assert(0);
    }

    res.tx = res.ty = res.tz = 0.0;
    return res;
}

/* 
 * Setup the matrix to perform a projection onto a plane passing
 * through the origin.  The plane is perpendicular to the
 * unit vector n.
 */
Matrix4x4!(T) projectionMatrix(T) (Vector!(T,3) n)
in
{
    assert (fabs(dot(n, n) - 1.0) < 0.001);
}
body
{
    Matrix4x4!(T) res;

    res.m11 = 1.0 - (n.x * n.x);
    res.m22 = 1.0 - (n.y * n.y);
    res.m33 = 1.0 - (n.z * n.z);

    res.m12 = res.m21 = -(n.x * n.y);
    res.m13 = res.m31 = -(n.x * n.z);
    res.m23 = res.m32 = -(n.y * n.z);

    res.tx = res.ty = res.tz = 0.0;

    return res;
}

/*
 * Setup the matrix to perform a reflection about a plane parallel
 * to a cardinal plane.
 */
Matrix4x4!(T) reflectionMatrix(T) (axis reflectionAxis, T k)
body
{
    Matrix4x4!(T) res;

    switch (reflectionAxis)
    {
        case axis.x:
            res.m11 = -1.0; res.m21 =  0.0; res.m31 =  0.0; res.tx = 2.0 * k;
            res.m12 =  0.0; res.m22 =  1.0; res.m32 =  0.0; res.ty = 0.0;
            res.m13 =  0.0; res.m23 =  0.0; res.m33 =  1.0; res.tz = 0.0;
            break;

        case axis.y:
            res.m11 =  1.0; res.m21 =  0.0; res.m31 =  0.0; res.tx = 0.0;
            res.m12 =  0.0; res.m22 = -1.0; res.m32 =  0.0; res.ty = 2.0 * k;
            res.m13 =  0.0; res.m23 =  0.0; res.m33 =  1.0; res.tz = 0.0;
            break;

        case axis.z:
            res.m11 =  1.0; res.m21 =  0.0; res.m31 =  0.0; res.tx = 0.0;
            res.m12 =  0.0; res.m22 =  1.0; res.m32 =  0.0; res.ty = 0.0;
            res.m13 =  0.0; res.m23 =  0.0; res.m33 = -1.0; res.tz = 2.0 * k;
            break;

        default:
            assert(0);
    }

    return res;
}

/*
 * Setup the matrix to perform a reflection about an arbitrary plane
 * through the origin.  The unit vector n is perpendicular to the plane.
 */
Matrix4x4!(T) axisReflectionMatrix(T) (Vector!(T,3) n)
in
{
    assert (fabs(dot(n, n) - 1.0) < 0.001);
}
body
{
    Matrix4x4!(T) res;

    T ax = -2.0 * n.x;
    T ay = -2.0 * n.y;
    T az = -2.0 * n.z;

    res.m11 = 1.0 + (ax * n.x);
    res.m22 = 1.0 + (ay * n.y);
    res.m32 = 1.0 + (az * n.z);

    res.m12 = res.m21 = (ax * n.y);
    res.m13 = res.m31 = (ax * n.z);
    res.m23 = res.m32 = (ay * n.z);

    res.tx = res.ty = res.tz = 0.0;

    return res;
}

/*
 * Setup the matrix to perform a "Look At" transformation 
 * like a first person camera
 */
Matrix4x4!(T) lookAtMatrix(T) (Vector!(T,3) camPos, Vector!(T,3) target, Vector!(T,3) camUp)
body
{
    Matrix4x4!(T) rot, trans;

    Vector!(T,3) forward = camPos - target;
    forward.normalize();

    Vector!(T,3) right = cross(camUp, forward);
    right.normalize();

    Vector!(T,3) up = cross(forward, right);
    up.normalize();

    rot.m11 = right.x;
    rot.m21 = right.y;
    rot.m31 = right.z;

    rot.m12 = up.x;
    rot.m22 = up.y;
    rot.m32 = up.z;

    rot.m13 = forward.x;
    rot.m23 = forward.y;
    rot.m33 = forward.z;

    rot.tx  = 0.0;
    rot.ty  = 0.0;
    rot.tz  = 0.0;

    trans = translationMatrix(-camPos);
    return (rot * trans);
}

/*
 * Setup a frustum matrix given the left, right, bottom, top, near, and far
 * values for the frustum boundaries.
 */
Matrix4x4!(T) frustumMatrix(T) (T l, T r, T b, T t, T n, T f)
in
{
    assert (n >= 0.0);
    assert (f >= 0.0);
}
body
{
    Matrix4x4!(T) res;

    T width  = r - l;
    T height = t - b;
    T depth  = f - n;

    res.m[0] = (2 * n) / width;
    res.m[1] = 0.0;
    res.m[2] = 0.0;
    res.m[3] = 0.0;

    res.m[4] = 0.0;
    res.m[5] = (2 * n) / height;
    res.m[6] = 0.0;
    res.m[7] = 0.0;

    res.m[8] = (r + l) / width;
    res.m[9] = (t + b) / height;
    res.m[10]= -(f + n) / depth;
    res.m[11]= -1.0;

    res.m[12]= 0.0;
    res.m[13]= 0.0;
    res.m[14]= -(2 * f * n) / depth;
    res.m[15]= 0.0;

    return res;
}

/*
 * Setup a perspective matrix given the field-of-view in the Y direction
 * in degrees, the aspect ratio of Y/X, and near and far plane distances
 */
Matrix4x4!(T) perspectiveMatrix(T) (T fovY, T aspect, T n, T f)
body
{
    Matrix4x4!(T) res;

    T angle;
    T cot;

    angle = fovY / 2.0;
    angle = degtorad(angle);

    cot = cos(angle) / sin(angle);

    res.m[0] = cot / aspect;
    res.m[1] = 0.0;
    res.m[2] = 0.0;
    res.m[3] = 0.0;

    res.m[4] = 0.0;
    res.m[5] = cot;
    res.m[6] = 0.0;
    res.m[7] = 0.0;

    res.m[8] = 0.0;
    res.m[9] = 0.0;
    res.m[10]= -(f + n) / (f - n);
    res.m[11]= -1.0;

    res.m[12]= 0.0;
    res.m[13]= 0.0;
    res.m[14]= -(2 * f * n) / (f - n);
    res.m[15]= 0.0;

    return res;
}

/*
 * Setup an orthographic Matrix4x4 given the left, right, bottom, top, near,
 * and far values for the frustum boundaries.
 */
Matrix4x4!(T) orthoMatrix(T) (T l, T r, T b, T t, T n, T f)
body
{
    Matrix4x4!(T) res;

    T width  = r - l;
    T height = t - b;
    T depth  = f - n;

    res.m[0] =  2.0 / width;
    res.m[1] =  0.0;
    res.m[2] =  0.0;
    res.m[3] =  0.0;

    res.m[4] =  0.0;
    res.m[5] =  2.0 / height;
    res.m[6] =  0.0;
    res.m[7] =  0.0;

    res.m[8] =  0.0;
    res.m[9] =  0.0;
    res.m[10]= -2.0 / depth;
    res.m[11]=  0.0;

    res.m[12]= -(r + l) / width;
    res.m[13]= -(t + b) / height;
    res.m[14]= -(f + n) / depth;
    res.m[15]=  1.0;

    return res;
}

/*
 * Setup an orientation matrix using 3 basis normalized vectors
 */
Matrix4x4!(T) orthoNormalMatrix(T) (Vector!(T,3) xdir, Vector!(T,3) ydir, Vector!(T,3) zdir)
body
{
    Matrix4x4!(T) res;

    res.m[0] = xdir.x; res.m[4] = ydir.x; res.m[8] = zdir.x; res.m[12] = 0.0;
    res.m[1] = xdir.y; res.m[5] = ydir.y; res.m[9] = zdir.y; res.m[13] = 0.0;
    res.m[2] = xdir.z; res.m[6] = ydir.z; res.m[10]= zdir.z; res.m[14] = 0.0;
    res.m[3] = 0.0;    res.m[7] = 0.0;    res.m[11]= 0.0;    res.m[15] = 1.0;

    return res;
}

/*
 * Setup a matrix that flattens geometry into a plane, 
 * as if it were casting a shadow from a light
 */
Matrix4x4!(T) shadowMatrix(T) (Vector!(T,4) groundplane, Vector!(T,4) lightpos)
{
    T d = dot(groundplane, lightpos);

    Matrix4x4f shadowMat;

    shadowMat.m11 = d-lightpos.x * groundplane.x;
    shadowMat.m21 =  -lightpos.x * groundplane.y;
    shadowMat.m31 =  -lightpos.x * groundplane.z;
    shadowMat.tx  =  -lightpos.x * groundplane.w;

    shadowMat.m12 =  -lightpos.y * groundplane.x;
    shadowMat.m22 = d-lightpos.y * groundplane.y;
    shadowMat.m32 =  -lightpos.y * groundplane.z;
    shadowMat.ty  =  -lightpos.y * groundplane.w;

    shadowMat.m13 =  -lightpos.z * groundplane.x;
    shadowMat.m23 =  -lightpos.z * groundplane.y;
    shadowMat.m33 = d-lightpos.z * groundplane.z;
    shadowMat.tz  =  -lightpos.z * groundplane.w;

    shadowMat.h14 =  -lightpos.w * groundplane.x;
    shadowMat.h24 =  -lightpos.w * groundplane.y;
    shadowMat.h34 =  -lightpos.w * groundplane.z;
    shadowMat.tw  = d-lightpos.w * groundplane.w;
    
    return shadowMat;
}

/*
 * Setup an orientation matrix using forward direction vector
 */
Matrix4x4!(T) directionToMatrix(T) (Vector!(T,3) zdir)
{
    Vector!(T,3) xdir = Vector!(T,3)(0.0, 0.0, 1.0);
    Vector!(T,3) ydir;
    float d = zdir.z;

    if (d > -0.999999999 && d < 0.999999999)
    {
        xdir = xdir - zdir * d;
        xdir.normalize();
        ydir = cross(zdir, xdir);
    }
    else
    {
        xdir = Vector!(T,3)(zdir.z, 0.0, -zdir.x);
        ydir = Vector!(T,3)(0.0, 1.0, 0.0);
    }

    Matrix4x4!(T) m = identityMatrix4x4!T();
    m.forward = zdir;
    m.right = xdir;
    m.up = ydir;

    return m;
}

Matrix4x4!(T) rotationBetweenVectors(T) (Vector!(T,3) source, Vector!(T,3) target)
{
    T d = dot(source, target);
    Vector!(T,3) c = cross(source, target);
    c.normalize();
    return matrixFromAxisAngle(c, acos(d));
}

Matrix4x4!(T) matrixFromAxisAngle(T) (Vector!(T,3) axis, T angle)
{
    T c = cos(angle);
    T s = sin(angle);
    T t = 1.0 - c;

    T x = axis.x;
    T y = axis.y;
    T z = axis.z;

    Matrix4x4!(T) m = identityMatrix4x4!T();

    m.m11 = t*x*x + c;   m.m12 = t*x*y - z*s; m.m13 = t*x*z + y*s;
    m.m21 = t*x*y + z*s; m.m22 = t*y*y + c;   m.m23 = t*y*z - x*s;
    m.m31 = t*x*z + y*s; m.m32 = t*y*z + x*s; m.m33 = t*z*z + c;

    return m;
}

Matrix4x4!(T) matrix3x3to4x4(T) (Matrix3x3!(T) m)
{
    Matrix4x4!(T) res = identityMatrix4x4!(T)();
    res.m11 = m.m11; res.m12 = m.m12; res.m13 = m.m13;
    res.m21 = m.m21; res.m22 = m.m22; res.m23 = m.m23;
    res.m31 = m.m31; res.m32 = m.m32; res.m33 = m.m33;
    return res;
}

Matrix3x3!(T) matrix4x4to3x3(T) (Matrix4x4!(T) m)
{
    Matrix3x3!(T) res = identityMatrix3x3!(T)();
    res.m11 = m.m11; res.m12 = m.m12; res.m13 = m.m13;
    res.m21 = m.m21; res.m22 = m.m22; res.m23 = m.m23;
    res.m31 = m.m31; res.m32 = m.m32; res.m33 = m.m33;
    return res;
}

/*
 * Predefined matrix type aliases
 */
alias Matrix4x4!(float) Matrix4x4f;
alias Matrix4x4!(double) Matrix4x4d;

alias identityMatrix4x4!(float) identityMatrix4x4f;
alias identityMatrix4x4!(double) identityMatrix4x4d;
