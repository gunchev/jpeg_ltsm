JPEG Lossless Transformation Service Menu for KDE 4 README
==========================================================


.. contents::


Description
-----------

JPEG Lossless Transformation Service Menu for KDE_ 4, as the name
suggests, is a KDE service menu for KDE 4 that does lossless JPEG
transformations using ``jpegtran`` from libjpeg_ with the option
``-copy all`` to preserve all exif_ information. The user interface
uses kdialog.

The following operations are supported:

    - Flip Horizontally
        Mirror image horizontally (left-right).
    - Flip Vertically
        Mirror image vertically (top-bottom).
    - Grayscale
        Force grayscale output.
    - Optimize
        Perform optimization of entropy encoding parameters.
    - Rotate 90°
        Rotate image 90° clockwise.
    - Rotate 180°
        Rotate image 180°.
    - Rotate 270°
        Rotate image 270° clockwise (or 90° counter-clockwise).
    - Transpose
        Transpose image (across UL-to-LR axis).
    - Transverse
        Transverse transpose (across UR-to-LL axis).


.. warning::
    Grayscane conversion discards the chrominance channels which
    can not be reverted if you loose the original image. However,
    the grayscale part is untouched.


Screenshots
-----------

And because we all likes screenshots:

|KDE Service Menu| |KDE Service Sub-Menu|

|Action Animation|

.. |KDE Service Menu|     image:: jpeg_ltsm_menu.png
.. |KDE Service Sub-Menu| image:: jpeg_ltsm_submenu.png
.. |Action Animation|     image:: jpeg_ltsm_action.gif


Motivation
----------
jpeg_ltsm was written to offer two clicks JPEG rotation of photos
from Dolphin_ / Konqueror_ and because of `KDE bug #188927`_ -
JPEG transformation is **not** lossless in Gwenview and many others.


Usage
-----

To use this service menu just select one or more jpeg files from
Konqueror_ file manager or Dolphin_ and access the 'JPEG Lossless
Transformation' menu.


BUGS
----

1. Konqueror_ / Dolphin_ do not refresh their thumbnails because the
   file timestamps are preserved (even if size changes).


TODO
----

0. Find a way to refresh Konqueror / Dolphin thumbnails.

1. Add setup dialog.

    This will allow for items 2 and 3 to be implemented. Another
    approach might be a confirmation dialog before the operation
    begins.

2. Make the backup files optional.

    If everything goes as planned it might be a bit annoying to
    delete all ``.old`` files by hand...

3. Add some more lossy options (--crop).

    Low priority - never seen camera take pictures with dimensions
    that are not divisible by 8 (non-transformable edge blocks).

4. Add ``-progressive`` support?

5. Check if the optimized image is actually bigger.


License
-------

`GNU GPLv2`_ or later.


:Author:
    Doncho N. Gunchev <dgunchev@gmail.com>


:Version: 0.9.1


:Date: 2009-04-20


:Dedication: To my friends and family.


.. _KDE:             http://www.kde.org/
.. _libjpeg:         http://www.ijg.org/
.. _exif:            http://www.exif.org/
.. _Konqueror:       http://konqueror.kde.org/
.. _Dolphin:         http://dolphin.kde.org/
.. _KDE bug #188927: https://bugs.kde.org/show_bug.cgi?id=188927
.. _GNU GPLv2:       http://www.gnu.org/licenses/gpl-2.0.html
