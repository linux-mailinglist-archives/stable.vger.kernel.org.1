Return-Path: <stable+bounces-62480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF82793F34C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E8828208D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448E14389B;
	Mon, 29 Jul 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sGTwl3/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31028399
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250447; cv=none; b=l7AqiQikhsPfz8LxnZHbl5CdJq5ZBv7jzKPBnCtNNYYALbkpnzoliSeJ0+JzPLXD2w4G64EqU+BN/iyTl40mBOPDOqRMU3SL5aT5cDh6ZteKAtx9zr+o/3efCAygSTRcDM46WN+5UuM4HyrjvqyUaap3VtQhx3V5bUXPFLDDjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250447; c=relaxed/simple;
	bh=1foJlU4QN7zjsjuQzKwnnJc+16Cc7HL7eQ/QubDaEMI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rmFDilBIhOoUbiutUJ2Pz6FyDUTTCFDpDbKvomLtLNqv3O3CMpcCSVizN20sDKEtsfXKbI0p4AkkNNRlQqXbbbGe8md1E5Y1PPbyZ0Ps45QHBZANb6ypyn8jL+CCfZBViP8Q5vlKf15q5UPj+0SRaejH4h44AhkfmvYVqBPRJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sGTwl3/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39170C4AF0A;
	Mon, 29 Jul 2024 10:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250447;
	bh=1foJlU4QN7zjsjuQzKwnnJc+16Cc7HL7eQ/QubDaEMI=;
	h=Subject:To:Cc:From:Date:From;
	b=sGTwl3/YqVHduK94ait1SEhCLAOppiUV0C5KrV0oVc37/fBED0G05pqVMqV0aiFrf
	 9TuO8QzQFkeB6Qxc5e8hZk5uW7WYYl6pm/TFrBkEcONCNPMBZAYkwH/p3fE8tVEshD
	 VP8UqrXY2BEEtqoilXqnQjTvkwFNntVr8hY0OqhE=
Subject: FAILED: patch "[PATCH] media: uvcvideo: Fix integer overflow calculating timestamp" failed to apply to 5.10-stable tree
To: ribalda@chromium.org,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:53:59 +0200
Message-ID: <2024072959-overpass-sapling-797e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8676a5e796fa18f55897ca36a94b2adf7f73ebd1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072959-overpass-sapling-797e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8676a5e796fa ("media: uvcvideo: Fix integer overflow calculating timestamp")
9e56380ae625 ("media: uvcvideo: Rename debug functions")
ed4c5fa4d804 ("media: uvcvideo: use dev_printk() for uvc_trace()")
59e92bf62771 ("media: uvcvideo: New macro uvc_trace_cont")
69df09547e7a ("media: uvcvideo: Use dev_ printk aliases")
2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
351509c604dc ("media: uvcvideo: Move guid to entity")
dc9455ffae02 ("media: uvcvideo: Accept invalid bFormatIndex and bFrameIndex values")
b400b6f28af0 ("media: uvcvideo: Force UVC version to 1.0a for 1bcf:0b40")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8676a5e796fa18f55897ca36a94b2adf7f73ebd1 Mon Sep 17 00:00:00 2001
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 10 Jun 2024 19:17:49 +0000
Subject: [PATCH] media: uvcvideo: Fix integer overflow calculating timestamp

The function uvc_video_clock_update() supports a single SOF overflow. Or
in other words, the maximum difference between the first ant the last
timestamp can be 4096 ticks or 4.096 seconds.

This results in a maximum value for y2 of: 0x12FBECA00, that overflows
32bits.
y2 = (u32)ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;

Extend the size of y2 to u64 to support all its values.

Without this patch:
 # yavta -s 1920x1080 -f YUYV -t 1/5 -c /dev/video0
Device /dev/v4l/by-id/usb-Shine-Optics_Integrated_Camera_0001-video-index0 opened.
Device `Integrated Camera: Integrated C' on `usb-0000:00:14.0-6' (driver 'uvcvideo') supports video, capture, without mplanes.
Video format set: YUYV (56595559) 1920x1080 (stride 3840) field none buffer size 4147200
Video format: YUYV (56595559) 1920x1080 (stride 3840) field none buffer size 4147200
Current frame rate: 1/5
Setting frame rate to: 1/5
Frame rate set: 1/5
8 buffers requested.
length: 4147200 offset: 0 timestamp type/source: mono/SoE
Buffer 0/0 mapped at address 0x7947ea94c000.
length: 4147200 offset: 4149248 timestamp type/source: mono/SoE
Buffer 1/0 mapped at address 0x7947ea557000.
length: 4147200 offset: 8298496 timestamp type/source: mono/SoE
Buffer 2/0 mapped at address 0x7947ea162000.
length: 4147200 offset: 12447744 timestamp type/source: mono/SoE
Buffer 3/0 mapped at address 0x7947e9d6d000.
length: 4147200 offset: 16596992 timestamp type/source: mono/SoE
Buffer 4/0 mapped at address 0x7947e9978000.
length: 4147200 offset: 20746240 timestamp type/source: mono/SoE
Buffer 5/0 mapped at address 0x7947e9583000.
length: 4147200 offset: 24895488 timestamp type/source: mono/SoE
Buffer 6/0 mapped at address 0x7947e918e000.
length: 4147200 offset: 29044736 timestamp type/source: mono/SoE
Buffer 7/0 mapped at address 0x7947e8d99000.
0 (0) [-] none 0 4147200 B 507.554210 508.874282 242.836 fps ts mono/SoE
1 (1) [-] none 2 4147200 B 508.886298 509.074289 0.751 fps ts mono/SoE
2 (2) [-] none 3 4147200 B 509.076362 509.274307 5.261 fps ts mono/SoE
3 (3) [-] none 4 4147200 B 509.276371 509.474336 5.000 fps ts mono/SoE
4 (4) [-] none 5 4147200 B 509.476394 509.674394 4.999 fps ts mono/SoE
5 (5) [-] none 6 4147200 B 509.676506 509.874345 4.997 fps ts mono/SoE
6 (6) [-] none 7 4147200 B 509.876430 510.074370 5.002 fps ts mono/SoE
7 (7) [-] none 8 4147200 B 510.076434 510.274365 5.000 fps ts mono/SoE
8 (0) [-] none 9 4147200 B 510.276421 510.474333 5.000 fps ts mono/SoE
9 (1) [-] none 10 4147200 B 510.476391 510.674429 5.001 fps ts mono/SoE
10 (2) [-] none 11 4147200 B 510.676434 510.874283 4.999 fps ts mono/SoE
11 (3) [-] none 12 4147200 B 510.886264 511.074349 4.766 fps ts mono/SoE
12 (4) [-] none 13 4147200 B 511.070577 511.274304 5.426 fps ts mono/SoE
13 (5) [-] none 14 4147200 B 511.286249 511.474301 4.637 fps ts mono/SoE
14 (6) [-] none 15 4147200 B 511.470542 511.674251 5.426 fps ts mono/SoE
15 (7) [-] none 16 4147200 B 511.672651 511.874337 4.948 fps ts mono/SoE
16 (0) [-] none 17 4147200 B 511.873988 512.074462 4.967 fps ts mono/SoE
17 (1) [-] none 18 4147200 B 512.075982 512.278296 4.951 fps ts mono/SoE
18 (2) [-] none 19 4147200 B 512.282631 512.482423 4.839 fps ts mono/SoE
19 (3) [-] none 20 4147200 B 518.986637 512.686333 0.149 fps ts mono/SoE
20 (4) [-] none 21 4147200 B 518.342709 512.886386 -1.553 fps ts mono/SoE
21 (5) [-] none 22 4147200 B 517.909812 513.090360 -2.310 fps ts mono/SoE
22 (6) [-] none 23 4147200 B 517.590775 513.294454 -3.134 fps ts mono/SoE
23 (7) [-] none 24 4147200 B 513.298465 513.494335 -0.233 fps ts mono/SoE
24 (0) [-] none 25 4147200 B 513.510273 513.698375 4.721 fps ts mono/SoE
25 (1) [-] none 26 4147200 B 513.698904 513.902327 5.301 fps ts mono/SoE
26 (2) [-] none 27 4147200 B 513.895971 514.102348 5.074 fps ts mono/SoE
27 (3) [-] none 28 4147200 B 514.099091 514.306337 4.923 fps ts mono/SoE
28 (4) [-] none 29 4147200 B 514.310348 514.510567 4.734 fps ts mono/SoE
29 (5) [-] none 30 4147200 B 514.509295 514.710367 5.026 fps ts mono/SoE
30 (6) [-] none 31 4147200 B 521.532513 514.914398 0.142 fps ts mono/SoE
31 (7) [-] none 32 4147200 B 520.885277 515.118385 -1.545 fps ts mono/SoE
32 (0) [-] none 33 4147200 B 520.411140 515.318336 -2.109 fps ts mono/SoE
33 (1) [-] none 34 4147200 B 515.325425 515.522278 -0.197 fps ts mono/SoE
34 (2) [-] none 35 4147200 B 515.538276 515.726423 4.698 fps ts mono/SoE
35 (3) [-] none 36 4147200 B 515.720767 515.930373 5.480 fps ts mono/SoE

Cc: stable@vger.kernel.org
Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20240610-hwtimestamp-followup-v1-2-f9eaed7be7f0@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index aebcf9b25a16..4dfc1b86bdee 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -760,11 +760,11 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	unsigned long flags;
 	u64 timestamp;
 	u32 delta_stc;
-	u32 y1, y2;
+	u32 y1;
 	u32 x1, x2;
 	u32 mean;
 	u32 sof;
-	u64 y;
+	u64 y, y2;
 
 	if (!uvc_hw_timestamps_param)
 		return;
@@ -816,7 +816,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	sof = y;
 
 	uvc_dbg(stream->dev, CLOCK,
-		"%s: PTS %u y %llu.%06llu SOF %u.%06llu (x1 %u x2 %u y1 %u y2 %u SOF offset %u)\n",
+		"%s: PTS %u y %llu.%06llu SOF %u.%06llu (x1 %u x2 %u y1 %u y2 %llu SOF offset %u)\n",
 		stream->dev->name, buf->pts,
 		y >> 16, div_u64((y & 0xffff) * 1000000, 65536),
 		sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
@@ -831,7 +831,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		goto done;
 
 	y1 = NSEC_PER_SEC;
-	y2 = (u32)ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
+	y2 = ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
 
 	/*
 	 * Interpolated and host SOF timestamps can wrap around at slightly
@@ -852,7 +852,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	timestamp = ktime_to_ns(first->host_time) + y - y1;
 
 	uvc_dbg(stream->dev, CLOCK,
-		"%s: SOF %u.%06llu y %llu ts %llu buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %u)\n",
+		"%s: SOF %u.%06llu y %llu ts %llu buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %llu)\n",
 		stream->dev->name,
 		sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
 		y, timestamp, vbuf->vb2_buf.timestamp,


