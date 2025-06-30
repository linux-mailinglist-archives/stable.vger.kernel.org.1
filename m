Return-Path: <stable+bounces-158950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE0AEDD59
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BDC3A7DCC
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449341DE891;
	Mon, 30 Jun 2025 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NUo8kngM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A471DFF7
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287534; cv=none; b=UjWozYaSrKU91fOEQ7saqdBZqM1pTZUL1wvTYTx4FBocxMMHJQWkGHy1t2m6WAmSSsnfwlhEbOTlHJixSZtwOk0B9pnUKXYodNmBkiDjQ4OTZmhUMqvzgWucqXdo+QtWthhTzDXvEahhlqytjnlot2jiGgl3J4FYnKYRP0yiM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287534; c=relaxed/simple;
	bh=4TZtyk4ch6wcy0H7CCCLdgpQU+4kKH2ad+LUxW0v4bA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IhavV+LtarFL6Nz6NIGpwKdEftTgUX2bruNRqY8T2ImoPd44/EDW3qaZydFsUFPEPs7xUcMlH8Tdtg1P5WMLed/1t9YU6JtyhGsPMgVtcPbN3YuPhqt/6O6N7wCTuDQZYBRPZ7xWOEmTh6IpUe5w9v+qbanB7zFQffFNuX0kY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NUo8kngM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13287C4CEE3;
	Mon, 30 Jun 2025 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751287533;
	bh=4TZtyk4ch6wcy0H7CCCLdgpQU+4kKH2ad+LUxW0v4bA=;
	h=Subject:To:Cc:From:Date:From;
	b=NUo8kngMkb/BEGlFsu8QgIcWkQVCiMg0MZODU1YGbO48ExoYWLlkwcar0NSAcoIY0
	 +fh/Kf2HbtXWApnxF9ZRkZq9h7XHkpGFMqwNvlP6NHJujtVKl5+EkjyegSuJjeR1K7
	 Xf94oF2vDIDpCN/wgiiepIuhwmNqylEZH1lqeUNA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Export full brightness range to userspace" failed to apply to 6.15-stable tree
To: mario.limonciello@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,roman.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 14:45:30 +0200
Message-ID: <2025063030-pardon-shock-f4d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 16dc8bc27c2aa3c93905d3e885e27f1e3535f09a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063030-pardon-shock-f4d7@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16dc8bc27c2aa3c93905d3e885e27f1e3535f09a Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 29 May 2025 09:46:32 -0500
Subject: [PATCH] drm/amd/display: Export full brightness range to userspace

[WHY]
Userspace currently is offered a range from 0-0xFF but the PWM is
programmed from 0-0xFFFF.  This can be limiting to some software
that wants to apply greater granularity.

[HOW]
Convert internally to firmware values only when mapping custom
brightness curves because these are in 0-0xFF range. Advertise full
PWM range to userspace.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8dbd72cb790058ce52279af38a43c2b302fdd3e5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0b5d5ab14a69..bc4cd11bfc79 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4718,9 +4718,23 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	return 1;
 }
 
-static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-				      uint32_t *brightness)
+/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
+static inline u32 scale_input_to_fw(int min, int max, u64 input)
 {
+	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
+}
+
+/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
+static inline u32 scale_fw_to_input(int min, int max, u64 input)
+{
+	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
+}
+
+static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
+				      unsigned int min, unsigned int max,
+				      uint32_t *user_brightness)
+{
+	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
 	u8 prev_signal = 0, prev_lum = 0;
 	int i = 0;
 
@@ -4731,7 +4745,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 		return;
 
 	/* choose start to run less interpolation steps */
-	if (caps->luminance_data[caps->data_points/2].input_signal > *brightness)
+	if (caps->luminance_data[caps->data_points/2].input_signal > brightness)
 		i = caps->data_points/2;
 	do {
 		u8 signal = caps->luminance_data[i].input_signal;
@@ -4742,17 +4756,18 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 		 * brightness < signal: interpolate between previous and current luminance numerator
 		 * brightness > signal: find next data point
 		 */
-		if (*brightness > signal) {
+		if (brightness > signal) {
 			prev_signal = signal;
 			prev_lum = lum;
 			i++;
 			continue;
 		}
-		if (*brightness < signal)
+		if (brightness < signal)
 			lum = prev_lum + DIV_ROUND_CLOSEST((lum - prev_lum) *
-							   (*brightness - prev_signal),
+							   (brightness - prev_signal),
 							   signal - prev_signal);
-		*brightness = DIV_ROUND_CLOSEST(lum * *brightness, 101);
+		*user_brightness = scale_fw_to_input(min, max,
+						     DIV_ROUND_CLOSEST(lum * brightness, 101));
 		return;
 	} while (i < caps->data_points);
 }
@@ -4765,11 +4780,10 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 	if (!get_brightness_range(caps, &min, &max))
 		return brightness;
 
-	convert_custom_brightness(caps, &brightness);
+	convert_custom_brightness(caps, min, max, &brightness);
 
-	// Rescale 0..255 to min..max
-	return min + DIV_ROUND_CLOSEST((max - min) * brightness,
-				       AMDGPU_MAX_BL_LEVEL);
+	// Rescale 0..max to min..max
+	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
 }
 
 static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
@@ -4782,8 +4796,8 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 
 	if (brightness < min)
 		return 0;
-	// Rescale min..max to 0..255
-	return DIV_ROUND_CLOSEST(AMDGPU_MAX_BL_LEVEL * (brightness - min),
+	// Rescale min..max to 0..max
+	return DIV_ROUND_CLOSEST_ULL((u64)max * (brightness - min),
 				 max - min);
 }
 
@@ -4933,11 +4947,10 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
 			caps->ac_level, caps->dc_level);
 	} else
-		props.brightness = AMDGPU_MAX_BL_LEVEL;
+		props.brightness = props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE))
 		drm_info(drm, "Using custom brightness curve\n");
-	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
 
 	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",


