Return-Path: <stable+bounces-69581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B46A956A86
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415BF1C237DC
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4A168486;
	Mon, 19 Aug 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKx0k5TZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C913DBA0
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069434; cv=none; b=r/xEYiJSUo5+Q/MotVzAuu8V8Afhx6BZ7Wuzso04kgUM8whalIu9q0AHs9SBXsKBLlD2K+z5uvx5tDNNraigBOs+/EKER4x4vHKi2F2BcpASQ4q2iMH9368RI2pSXZMcBZTObuWxgwrbaA5wVG6oxPbVk+oUM3UVFUwA7XwgCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069434; c=relaxed/simple;
	bh=IaK9RlV7QXerXLcnrRZk0SnIcw7IFKx06nrVbcSlUSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLGvLWJUIJKs2DWJORP/pSS+xte6sXagY79DlCtDgA85p1O5XgVbBuFWU6NVlUAw+QSUiq1UbXEMftG3yYjfB+T/XU2xpsvuqwO1SnejaVBY8TQPgSGpXMu0a0eUib8dyxXgZEe4Qk9/rBtjODGXlASsnu93N56+gDkzFTuWVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RKx0k5TZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d7bc07b7so292985485a.0
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724069431; x=1724674231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CajuTsdCi2RSIdgmS0S2t7VToev9SgQSYdEMxQ8U1ko=;
        b=RKx0k5TZTFuwjmZlDKoy2Tmc5k5yV3mW41Ytyq5dn+NPIVgsSN5QsqkK2LgTvB+6Z5
         PhcZdQxKsnYisgzff++6ceWGeRYefYn8F1Tbq45blFIe1ygklFm0tbCW7WJH9zWDeQy6
         f9uQ8+A56ybCK6LfhI9LGns87CI0UUr64SHW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069431; x=1724674231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CajuTsdCi2RSIdgmS0S2t7VToev9SgQSYdEMxQ8U1ko=;
        b=BEOQfr8MqYVX1kpInG1C/nQh5YNWMYWhcRJlMIOmrymw0+p2runIz68fJWiJyxWYjy
         PyfbCPS8ZwxiA/UkqRX3g5tSM0jMHI94yj23f90c9X86x+neRufensfcQxiqtVerFLMQ
         52bVOIELiVZfe0qJ5iUsrjjE8BPMPKo5Gau0opD3JgaYzAJ2k9eSQiqX9kZhpKyb/UkA
         bR9mJ5YyACH76129dlygF7XpJvsI855xxraN8aCaM/cddVQlUgmxSft1AcH2pRopCydm
         umpPvU7CnuGwW7O5s2XsrhWBMTTVngVxBeZhaRlk8gGgEHSFYTvHC96Yt/VFb95Bl20Q
         LCrw==
X-Gm-Message-State: AOJu0YwLZboxBubX2UMQ2SaOJVjMbIEkrLq/2WTYQhR5+VlXmSyiD3mO
	imw3Umga9/Gh6Jt5moNga2bSY8YKFxeM9ybhFoqeZX6u5jOuPXtGDPSJTxOQAvfKDrowU1CernM
	=
X-Google-Smtp-Source: AGHT+IFbB5eLtuDYhWf/uWLmgFWnr9O6Vqyq4JE2byFBVsXJOe/0VjQTFJ2YymfeaFRUjsitJ0cXKA==
X-Received: by 2002:a05:620a:284a:b0:7a4:dfd6:5fb8 with SMTP id af79cd13be357-7a506937f19mr1074130085a.23.1724069431143;
        Mon, 19 Aug 2024 05:10:31 -0700 (PDT)
Received: from denia.c.googlers.com.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02e5cdsm427296985a.4.2024.08.19.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:10:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 5.4.y] media: uvcvideo: Fix integer overflow calculating timestamp
Date: Mon, 19 Aug 2024 12:10:26 +0000
Message-ID: <20240819121026.35515-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <2024072901-duct-manager-b71e@gregkh>
References: <2024072901-duct-manager-b71e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 8676a5e796fa18f55897ca36a94b2adf7f73ebd1)
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 8a8271e23c63..e62afdee20db 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -723,11 +723,11 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
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
@@ -767,7 +767,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	sof = y;
 
 	uvc_trace(UVC_TRACE_CLOCK, "%s: PTS %u y %llu.%06llu SOF %u.%06llu "
-		  "(x1 %u x2 %u y1 %u y2 %u SOF offset %u)\n",
+		  "(x1 %u x2 %u y1 %u y2 %llu SOF offset %u)\n",
 		  stream->dev->name, buf->pts,
 		  y >> 16, div_u64((y & 0xffff) * 1000000, 65536),
 		  sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
@@ -782,7 +782,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		goto done;
 
 	y1 = NSEC_PER_SEC;
-	y2 = (u32)ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
+	y2 = ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
 
 	/* Interpolated and host SOF timestamps can wrap around at slightly
 	 * different times. Handle this by adding or removing 2048 to or from
@@ -802,7 +802,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	timestamp = ktime_to_ns(first->host_time) + y - y1;
 
 	uvc_trace(UVC_TRACE_CLOCK, "%s: SOF %u.%06llu y %llu ts %llu "
-		  "buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %u)\n",
+		  "buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %llu)\n",
 		  stream->dev->name,
 		  sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
 		  y, timestamp, vbuf->vb2_buf.timestamp,
-- 
2.46.0.184.g6999bdac58-goog


