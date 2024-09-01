Return-Path: <stable+bounces-71780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FD19677B7
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7175E28207A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3961F183CCD;
	Sun,  1 Sep 2024 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7Y3dFnz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD54143C6E;
	Sun,  1 Sep 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207792; cv=none; b=SNPCA0vgkd3l+2RIK2Cvm+ODRbfWX+31DGHNYcOXljDmCfDczxIFmjUO0w/BA7Z0mXJkwfpAzQ/DuyCiIt2rpjdicUa3j+UtNCck5Ognvn7Kw8BFgc65JpVpAHxDa5dSXJ+9N/L8/SxR0EOcQVr6ROJGAZpK0pfzyggWluUUbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207792; c=relaxed/simple;
	bh=Fu60aCMxs4al5hngoJDV+TQdM1dPkEc8YK8TZSH3pjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5johBOqD5IK+QmN/o2CqEOFElUq8zRTouYR5G2U7rxk1Mjxocrs5mJBDoiL/RGDB40my8PLNt2Oa17WvcbJqU8qp+KjqTJgWhA7Ir+/zJVXkqbQACnx1f5ZdEAjw9W2cmRcVTBrMNqrZlrTapGqmPHQv8GGwF7TrG6H6KqE5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7Y3dFnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A06EC4CEC3;
	Sun,  1 Sep 2024 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207791;
	bh=Fu60aCMxs4al5hngoJDV+TQdM1dPkEc8YK8TZSH3pjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7Y3dFnzJ4E51CQqljWNzB1I8QGzYLmjQayuzNYyB2GijVkG51sCnRniR7hoz70dF
	 QU4wsYlnbODbn24TTqNlSX9rC2DKzXxJ6w7V1Ru1peHVd6sofk/XjZBhlsnV/ao1oN
	 L3knjoe6OYQqhSLuyHmma5UBLa/Ua3zSUgannTyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 4.19 78/98] media: uvcvideo: Fix integer overflow calculating timestamp
Date: Sun,  1 Sep 2024 18:16:48 +0200
Message-ID: <20240901160806.637665373@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

commit 8676a5e796fa18f55897ca36a94b2adf7f73ebd1 upstream.

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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_video.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -728,11 +728,11 @@ void uvc_video_clock_update(struct uvc_s
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
@@ -772,7 +772,7 @@ void uvc_video_clock_update(struct uvc_s
 	sof = y;
 
 	uvc_trace(UVC_TRACE_CLOCK, "%s: PTS %u y %llu.%06llu SOF %u.%06llu "
-		  "(x1 %u x2 %u y1 %u y2 %u SOF offset %u)\n",
+		  "(x1 %u x2 %u y1 %u y2 %llu SOF offset %u)\n",
 		  stream->dev->name, buf->pts,
 		  y >> 16, div_u64((y & 0xffff) * 1000000, 65536),
 		  sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
@@ -787,7 +787,7 @@ void uvc_video_clock_update(struct uvc_s
 		goto done;
 
 	y1 = NSEC_PER_SEC;
-	y2 = (u32)ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
+	y2 = ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
 
 	/* Interpolated and host SOF timestamps can wrap around at slightly
 	 * different times. Handle this by adding or removing 2048 to or from
@@ -807,7 +807,7 @@ void uvc_video_clock_update(struct uvc_s
 	timestamp = ktime_to_ns(first->host_time) + y - y1;
 
 	uvc_trace(UVC_TRACE_CLOCK, "%s: SOF %u.%06llu y %llu ts %llu "
-		  "buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %u)\n",
+		  "buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %llu)\n",
 		  stream->dev->name,
 		  sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
 		  y, timestamp, vbuf->vb2_buf.timestamp,



