Return-Path: <stable+bounces-103377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7849EF682
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C017628788D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19C216E3B;
	Thu, 12 Dec 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQ+8S0F7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A1215764;
	Thu, 12 Dec 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024384; cv=none; b=Z2ogIKMCZ/BSkhzIpi/XU0jxiWBNDJa2AmhoYQqvSqKaHoWoYFOvC8yLyNdUTDIK77+c/ls9KMQe5i5d4jgD0T2+f5bCop91H85FLb4u01QimmXodOdkyWCAmM8KwmCG5teDs/qdA6HFFvc4tkaZfXK38MT3HZYgABzjKdL/Qh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024384; c=relaxed/simple;
	bh=fM0kFrmI5n8fpH8H1q+ZLKtbiaHfogl4XMR3kFXvSX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir+n8V8ocxnr4sx+h4FBAQb6wTD4gEJXZVDCtyItKS0GcoDXyrKGlwRTGpwvT+fm2dfOjzAqsB8ELkhTrL4I87jTfh1Wb/y82DSTt8E+2opJbiwF6iT6NSPHFefTD9BqsZH23aTgmfcnFLuYp17ZYyuafz9K7574Nr8KH9FsnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQ+8S0F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B34AC4CED0;
	Thu, 12 Dec 2024 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024384;
	bh=fM0kFrmI5n8fpH8H1q+ZLKtbiaHfogl4XMR3kFXvSX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQ+8S0F7bPFvhZKtkYw6WiKBNWTd9E+Ml/htzrEfordxlfBFFdoq8LqQ2GNOMsuoN
	 5etva1HPoXeyybTte5C54gRCuYXiIAadygazNiAsUAJsMx/VTnw/4RGY6+n1p4M489
	 cggmIS6fsrUjCge+zvzN9KGOOw3DIBhD9W9sUXAQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil@xs4all.nl>,
	syzbot+a828133770f62293563e@syzkaller.appspotmail.com
Subject: [PATCH 5.10 277/459] media: v4l2-core: v4l2-dv-timings: check cvt/gtf result
Date: Thu, 12 Dec 2024 16:00:15 +0100
Message-ID: <20241212144304.568386184@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit 9f070b1862f3411b8bcdfd51a8eaad25286f9deb upstream.

The v4l2_detect_cvt/gtf functions should check the result against the
timing capabilities: these functions calculate the timings, so if they
are out of bounds, they should be rejected.

To do this, add the struct v4l2_dv_timings_cap as argument to those
functions.

This required updates to the adv7604 and adv7842 drivers since the
prototype of these functions has now changed. The timings struct
that is passed to v4l2_detect_cvt/gtf in those two drivers is filled
with the timings detected by the hardware.

The vivid driver was also updated, but an additional check was added:
the width and height specified by VIDIOC_S_DV_TIMINGS has to match the
calculated result, otherwise something went wrong. Note that vivid
*emulates* hardware, so all the values passed to the v4l2_detect_cvt/gtf
functions came from the timings struct that was filled by userspace
and passed on to the driver via VIDIOC_S_DV_TIMINGS. So these fields
can contain random data. Both the constraints check via
struct v4l2_dv_timings_cap and the additional width/height check
ensure that the resulting timings are sane and not messed up by the
v4l2_detect_cvt/gtf calculations.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Fixes: 2576415846bc ("[media] v4l2: move dv-timings related code to v4l2-dv-timings.c")
Cc: stable@vger.kernel.org
Reported-by: syzbot+a828133770f62293563e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-media/000000000000013050062127830a@google.com/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/adv7604.c                      |    5 
 drivers/media/i2c/adv7842.c                      |   13 +-
 drivers/media/test-drivers/vivid/vivid-vid-cap.c |   15 ++
 drivers/media/v4l2-core/v4l2-dv-timings.c        |  132 ++++++++++++-----------
 include/media/v4l2-dv-timings.h                  |   18 ++-
 5 files changed, 107 insertions(+), 76 deletions(-)

--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -1391,12 +1391,13 @@ static int stdi2dv_timings(struct v4l2_s
 	if (v4l2_detect_cvt(stdi->lcf + 1, hfreq, stdi->lcvs, 0,
 			(stdi->hs_pol == '+' ? V4L2_DV_HSYNC_POS_POL : 0) |
 			(stdi->vs_pol == '+' ? V4L2_DV_VSYNC_POS_POL : 0),
-			false, timings))
+			false, adv76xx_get_dv_timings_cap(sd, -1), timings))
 		return 0;
 	if (v4l2_detect_gtf(stdi->lcf + 1, hfreq, stdi->lcvs,
 			(stdi->hs_pol == '+' ? V4L2_DV_HSYNC_POS_POL : 0) |
 			(stdi->vs_pol == '+' ? V4L2_DV_VSYNC_POS_POL : 0),
-			false, state->aspect_ratio, timings))
+			false, state->aspect_ratio,
+			adv76xx_get_dv_timings_cap(sd, -1), timings))
 		return 0;
 
 	v4l2_dbg(2, debug, sd,
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -1443,14 +1443,15 @@ static int stdi2dv_timings(struct v4l2_s
 	}
 
 	if (v4l2_detect_cvt(stdi->lcf + 1, hfreq, stdi->lcvs, 0,
-			(stdi->hs_pol == '+' ? V4L2_DV_HSYNC_POS_POL : 0) |
-			(stdi->vs_pol == '+' ? V4L2_DV_VSYNC_POS_POL : 0),
-			false, timings))
+			    (stdi->hs_pol == '+' ? V4L2_DV_HSYNC_POS_POL : 0) |
+			    (stdi->vs_pol == '+' ? V4L2_DV_VSYNC_POS_POL : 0),
+			    false, adv7842_get_dv_timings_cap(sd), timings))
 		return 0;
 	if (v4l2_detect_gtf(stdi->lcf + 1, hfreq, stdi->lcvs,
-			(stdi->hs_pol == '+' ? V4L2_DV_HSYNC_POS_POL : 0) |
-			(stdi->vs_pol == '+' ? V4L2_DV_VSYNC_POS_POL : 0),
-			false, state->aspect_ratio, timings))
+			    (stdi->hs_pol == '+' ? V4L2_DV_HSYNC_POS_POL : 0) |
+			    (stdi->vs_pol == '+' ? V4L2_DV_VSYNC_POS_POL : 0),
+			    false, state->aspect_ratio,
+			    adv7842_get_dv_timings_cap(sd), timings))
 		return 0;
 
 	v4l2_dbg(2, debug, sd,
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -1711,12 +1711,19 @@ static bool valid_cvt_gtf_timings(struct
 	h_freq = (u32)bt->pixelclock / total_h_pixel;
 
 	if (bt->standards == 0 || (bt->standards & V4L2_DV_BT_STD_CVT)) {
+		struct v4l2_dv_timings cvt = {};
+
 		if (v4l2_detect_cvt(total_v_lines, h_freq, bt->vsync, bt->width,
-				    bt->polarities, bt->interlaced, timings))
+				    bt->polarities, bt->interlaced,
+				    &vivid_dv_timings_cap, &cvt) &&
+		    cvt.bt.width == bt->width && cvt.bt.height == bt->height) {
+			*timings = cvt;
 			return true;
+		}
 	}
 
 	if (bt->standards == 0 || (bt->standards & V4L2_DV_BT_STD_GTF)) {
+		struct v4l2_dv_timings gtf = {};
 		struct v4l2_fract aspect_ratio;
 
 		find_aspect_ratio(bt->width, bt->height,
@@ -1724,8 +1731,12 @@ static bool valid_cvt_gtf_timings(struct
 				  &aspect_ratio.denominator);
 		if (v4l2_detect_gtf(total_v_lines, h_freq, bt->vsync,
 				    bt->polarities, bt->interlaced,
-				    aspect_ratio, timings))
+				    aspect_ratio, &vivid_dv_timings_cap,
+				    &gtf) &&
+		    gtf.bt.width == bt->width && gtf.bt.height == bt->height) {
+			*timings = gtf;
 			return true;
+		}
 	}
 	return false;
 }
--- a/drivers/media/v4l2-core/v4l2-dv-timings.c
+++ b/drivers/media/v4l2-core/v4l2-dv-timings.c
@@ -481,25 +481,28 @@ EXPORT_SYMBOL_GPL(v4l2_calc_timeperframe
  * @polarities - the horizontal and vertical polarities (same as struct
  *		v4l2_bt_timings polarities).
  * @interlaced - if this flag is true, it indicates interlaced format
- * @fmt - the resulting timings.
+ * @cap - the v4l2_dv_timings_cap capabilities.
+ * @timings - the resulting timings.
  *
  * This function will attempt to detect if the given values correspond to a
  * valid CVT format. If so, then it will return true, and fmt will be filled
  * in with the found CVT timings.
  */
-bool v4l2_detect_cvt(unsigned frame_height,
-		     unsigned hfreq,
-		     unsigned vsync,
-		     unsigned active_width,
+bool v4l2_detect_cvt(unsigned int frame_height,
+		     unsigned int hfreq,
+		     unsigned int vsync,
+		     unsigned int active_width,
 		     u32 polarities,
 		     bool interlaced,
-		     struct v4l2_dv_timings *fmt)
+		     const struct v4l2_dv_timings_cap *cap,
+		     struct v4l2_dv_timings *timings)
 {
-	int  v_fp, v_bp, h_fp, h_bp, hsync;
-	int  frame_width, image_height, image_width;
+	struct v4l2_dv_timings t = {};
+	int v_fp, v_bp, h_fp, h_bp, hsync;
+	int frame_width, image_height, image_width;
 	bool reduced_blanking;
 	bool rb_v2 = false;
-	unsigned pix_clk;
+	unsigned int pix_clk;
 
 	if (vsync < 4 || vsync > 8)
 		return false;
@@ -625,36 +628,39 @@ bool v4l2_detect_cvt(unsigned frame_heig
 		h_fp = h_blank - hsync - h_bp;
 	}
 
-	fmt->type = V4L2_DV_BT_656_1120;
-	fmt->bt.polarities = polarities;
-	fmt->bt.width = image_width;
-	fmt->bt.height = image_height;
-	fmt->bt.hfrontporch = h_fp;
-	fmt->bt.vfrontporch = v_fp;
-	fmt->bt.hsync = hsync;
-	fmt->bt.vsync = vsync;
-	fmt->bt.hbackporch = frame_width - image_width - h_fp - hsync;
+	t.type = V4L2_DV_BT_656_1120;
+	t.bt.polarities = polarities;
+	t.bt.width = image_width;
+	t.bt.height = image_height;
+	t.bt.hfrontporch = h_fp;
+	t.bt.vfrontporch = v_fp;
+	t.bt.hsync = hsync;
+	t.bt.vsync = vsync;
+	t.bt.hbackporch = frame_width - image_width - h_fp - hsync;
 
 	if (!interlaced) {
-		fmt->bt.vbackporch = frame_height - image_height - v_fp - vsync;
-		fmt->bt.interlaced = V4L2_DV_PROGRESSIVE;
+		t.bt.vbackporch = frame_height - image_height - v_fp - vsync;
+		t.bt.interlaced = V4L2_DV_PROGRESSIVE;
 	} else {
-		fmt->bt.vbackporch = (frame_height - image_height - 2 * v_fp -
+		t.bt.vbackporch = (frame_height - image_height - 2 * v_fp -
 				      2 * vsync) / 2;
-		fmt->bt.il_vbackporch = frame_height - image_height - 2 * v_fp -
-					2 * vsync - fmt->bt.vbackporch;
-		fmt->bt.il_vfrontporch = v_fp;
-		fmt->bt.il_vsync = vsync;
-		fmt->bt.flags |= V4L2_DV_FL_HALF_LINE;
-		fmt->bt.interlaced = V4L2_DV_INTERLACED;
+		t.bt.il_vbackporch = frame_height - image_height - 2 * v_fp -
+					2 * vsync - t.bt.vbackporch;
+		t.bt.il_vfrontporch = v_fp;
+		t.bt.il_vsync = vsync;
+		t.bt.flags |= V4L2_DV_FL_HALF_LINE;
+		t.bt.interlaced = V4L2_DV_INTERLACED;
 	}
 
-	fmt->bt.pixelclock = pix_clk;
-	fmt->bt.standards = V4L2_DV_BT_STD_CVT;
+	t.bt.pixelclock = pix_clk;
+	t.bt.standards = V4L2_DV_BT_STD_CVT;
 
 	if (reduced_blanking)
-		fmt->bt.flags |= V4L2_DV_FL_REDUCED_BLANKING;
+		t.bt.flags |= V4L2_DV_FL_REDUCED_BLANKING;
 
+	if (!v4l2_valid_dv_timings(&t, cap, NULL, NULL))
+		return false;
+	*timings = t;
 	return true;
 }
 EXPORT_SYMBOL_GPL(v4l2_detect_cvt);
@@ -699,22 +705,25 @@ EXPORT_SYMBOL_GPL(v4l2_detect_cvt);
  *		image height, so it has to be passed explicitly. Usually
  *		the native screen aspect ratio is used for this. If it
  *		is not filled in correctly, then 16:9 will be assumed.
- * @fmt - the resulting timings.
+ * @cap - the v4l2_dv_timings_cap capabilities.
+ * @timings - the resulting timings.
  *
  * This function will attempt to detect if the given values correspond to a
  * valid GTF format. If so, then it will return true, and fmt will be filled
  * in with the found GTF timings.
  */
-bool v4l2_detect_gtf(unsigned frame_height,
-		unsigned hfreq,
-		unsigned vsync,
-		u32 polarities,
-		bool interlaced,
-		struct v4l2_fract aspect,
-		struct v4l2_dv_timings *fmt)
+bool v4l2_detect_gtf(unsigned int frame_height,
+		     unsigned int hfreq,
+		     unsigned int vsync,
+		     u32 polarities,
+		     bool interlaced,
+		     struct v4l2_fract aspect,
+		     const struct v4l2_dv_timings_cap *cap,
+		     struct v4l2_dv_timings *timings)
 {
+	struct v4l2_dv_timings t = {};
 	int pix_clk;
-	int  v_fp, v_bp, h_fp, hsync;
+	int v_fp, v_bp, h_fp, hsync;
 	int frame_width, image_height, image_width;
 	bool default_gtf;
 	int h_blank;
@@ -783,36 +792,39 @@ bool v4l2_detect_gtf(unsigned frame_heig
 
 	h_fp = h_blank / 2 - hsync;
 
-	fmt->type = V4L2_DV_BT_656_1120;
-	fmt->bt.polarities = polarities;
-	fmt->bt.width = image_width;
-	fmt->bt.height = image_height;
-	fmt->bt.hfrontporch = h_fp;
-	fmt->bt.vfrontporch = v_fp;
-	fmt->bt.hsync = hsync;
-	fmt->bt.vsync = vsync;
-	fmt->bt.hbackporch = frame_width - image_width - h_fp - hsync;
+	t.type = V4L2_DV_BT_656_1120;
+	t.bt.polarities = polarities;
+	t.bt.width = image_width;
+	t.bt.height = image_height;
+	t.bt.hfrontporch = h_fp;
+	t.bt.vfrontporch = v_fp;
+	t.bt.hsync = hsync;
+	t.bt.vsync = vsync;
+	t.bt.hbackporch = frame_width - image_width - h_fp - hsync;
 
 	if (!interlaced) {
-		fmt->bt.vbackporch = frame_height - image_height - v_fp - vsync;
-		fmt->bt.interlaced = V4L2_DV_PROGRESSIVE;
+		t.bt.vbackporch = frame_height - image_height - v_fp - vsync;
+		t.bt.interlaced = V4L2_DV_PROGRESSIVE;
 	} else {
-		fmt->bt.vbackporch = (frame_height - image_height - 2 * v_fp -
+		t.bt.vbackporch = (frame_height - image_height - 2 * v_fp -
 				      2 * vsync) / 2;
-		fmt->bt.il_vbackporch = frame_height - image_height - 2 * v_fp -
-					2 * vsync - fmt->bt.vbackporch;
-		fmt->bt.il_vfrontporch = v_fp;
-		fmt->bt.il_vsync = vsync;
-		fmt->bt.flags |= V4L2_DV_FL_HALF_LINE;
-		fmt->bt.interlaced = V4L2_DV_INTERLACED;
+		t.bt.il_vbackporch = frame_height - image_height - 2 * v_fp -
+					2 * vsync - t.bt.vbackporch;
+		t.bt.il_vfrontporch = v_fp;
+		t.bt.il_vsync = vsync;
+		t.bt.flags |= V4L2_DV_FL_HALF_LINE;
+		t.bt.interlaced = V4L2_DV_INTERLACED;
 	}
 
-	fmt->bt.pixelclock = pix_clk;
-	fmt->bt.standards = V4L2_DV_BT_STD_GTF;
+	t.bt.pixelclock = pix_clk;
+	t.bt.standards = V4L2_DV_BT_STD_GTF;
 
 	if (!default_gtf)
-		fmt->bt.flags |= V4L2_DV_FL_REDUCED_BLANKING;
+		t.bt.flags |= V4L2_DV_FL_REDUCED_BLANKING;
 
+	if (!v4l2_valid_dv_timings(&t, cap, NULL, NULL))
+		return false;
+	*timings = t;
 	return true;
 }
 EXPORT_SYMBOL_GPL(v4l2_detect_gtf);
--- a/include/media/v4l2-dv-timings.h
+++ b/include/media/v4l2-dv-timings.h
@@ -146,15 +146,18 @@ void v4l2_print_dv_timings(const char *d
  * @polarities: the horizontal and vertical polarities (same as struct
  *		v4l2_bt_timings polarities).
  * @interlaced: if this flag is true, it indicates interlaced format
+ * @cap: the v4l2_dv_timings_cap capabilities.
  * @fmt: the resulting timings.
  *
  * This function will attempt to detect if the given values correspond to a
  * valid CVT format. If so, then it will return true, and fmt will be filled
  * in with the found CVT timings.
  */
-bool v4l2_detect_cvt(unsigned frame_height, unsigned hfreq, unsigned vsync,
-		unsigned active_width, u32 polarities, bool interlaced,
-		struct v4l2_dv_timings *fmt);
+bool v4l2_detect_cvt(unsigned int frame_height, unsigned int hfreq,
+		     unsigned int vsync, unsigned int active_width,
+		     u32 polarities, bool interlaced,
+		     const struct v4l2_dv_timings_cap *cap,
+		     struct v4l2_dv_timings *fmt);
 
 /**
  * v4l2_detect_gtf - detect if the given timings follow the GTF standard
@@ -170,15 +173,18 @@ bool v4l2_detect_cvt(unsigned frame_heig
  *		image height, so it has to be passed explicitly. Usually
  *		the native screen aspect ratio is used for this. If it
  *		is not filled in correctly, then 16:9 will be assumed.
+ * @cap: the v4l2_dv_timings_cap capabilities.
  * @fmt: the resulting timings.
  *
  * This function will attempt to detect if the given values correspond to a
  * valid GTF format. If so, then it will return true, and fmt will be filled
  * in with the found GTF timings.
  */
-bool v4l2_detect_gtf(unsigned frame_height, unsigned hfreq, unsigned vsync,
-		u32 polarities, bool interlaced, struct v4l2_fract aspect,
-		struct v4l2_dv_timings *fmt);
+bool v4l2_detect_gtf(unsigned int frame_height, unsigned int hfreq,
+		     unsigned int vsync, u32 polarities, bool interlaced,
+		     struct v4l2_fract aspect,
+		     const struct v4l2_dv_timings_cap *cap,
+		     struct v4l2_dv_timings *fmt);
 
 /**
  * v4l2_calc_aspect_ratio - calculate the aspect ratio based on bytes



