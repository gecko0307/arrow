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

module dlib.image.filters.boxblur;

private
{
    import dlib.image.color;
    import dlib.image.image;
}

private SuperImage boxBlurHorizontal(SuperImage src, int radius) 
body
{
    auto dest = src.dup;
    foreach (y; 0..src.height) 
    foreach (x; 0..src.width)
    {
        Color4f total = Color4f(0.0f, 0.0f, 0.0f, 1.0f);
        for (int kx = -radius; kx <= radius; ++kx)
             total += Color4f(src[x + kx, y], src.bitDepth);
        total /= (radius * 2.0f + 1.0f);
        dest[x, y] = total.convert(src.bitDepth);
    }
    return dest;
}

private SuperImage boxBlurVertical(SuperImage src, int radius) 
body
{
    auto dest = src.dup;
    foreach (y; 0..src.height) 
    foreach (x; 0..src.width)
    {
        Color4f total = Color4f(0.0f, 0.0f, 0.0f, 1.0f);
        for (int ky = -radius; ky <= radius; ++ky)
             total += Color4f(src[x, y + ky], src.bitDepth);
        total /= (radius * 2.0f + 1.0f);
        dest[x, y] = total.convert(src.bitDepth);
    }
    return dest;
}

SuperImage boxBlur(SuperImage src, int hradius, int vradius)
body
{
    auto output = src.dup;
    auto temp = src.dup;

    temp = src.boxBlurHorizontal(hradius);
    output = temp.boxBlurVertical(vradius);

    return output;
}

