#!/usr/bin/env python
import freenect
import cv
import frame_convert

cv.NamedWindow('Depth')
#cv.NamedWindow('Video')
print('Press ESC in window to stop')


def get_depth():
    return frame_convert.pretty_depth_cv(freenect.sync_get_depth()[0])


def get_video():
    return frame_convert.video_cv(freenect.sync_get_video()[0])


#freenect(sync_set_range_mode, FREENECT_RANGE_NEAR_MODE)
while(1):
    cv.ShowImage('Depth', get_depth())
    #cv.ShowImage('Video', get_video())
    if cv.WaitKey(10) != -1:
        for i in range(101):
            print "Capturing image " + str(i) + "% complete"
            cv.SaveImage('/tmp/out' + str(i) + '.jpg', get_depth())
        break
