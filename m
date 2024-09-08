Return-Path: <stable+bounces-73902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFB97076C
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF9728200C
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521F14D2AC;
	Sun,  8 Sep 2024 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cyod+yGP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFA1DA26
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798970; cv=none; b=ParHlPHsXDC6BXOCVnbWNyomKw5kUd1xgQrdLfhTu155kqJm4jZ3f1El2p9hd3aa0ijjsFaQ2v+9xP9YcsZhfMtGm+PidWDHzMihqSlbFUzu3+ss8KmxiUuVuG1vsTqit5y0RMVq2fqOwb9JCSWqOhLfYUedaSz64ePZF0J1dv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798970; c=relaxed/simple;
	bh=ixgySMfsbo2WEApjPs+zRwnC6lgeK37g4YCoPdCjLso=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SvdBWXc6kTQTXhw/Spblb4k7JyGmmHzrlUYz7ls7FAb/Y1ilcW5ahrULiIoSNRRo8eiP13NOgX3+6UuZFbaV9kyYoIhGUjxpiqvxUWyCT9YaZcjeirhfgcDG3MXniuaknJzQA7uennT0yPRb4hgJxqe/Hwpk/ls+OnX+91LdTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cyod+yGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FBEC4CEC3;
	Sun,  8 Sep 2024 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725798970;
	bh=ixgySMfsbo2WEApjPs+zRwnC6lgeK37g4YCoPdCjLso=;
	h=Subject:To:Cc:From:Date:From;
	b=cyod+yGP69K9mQDNrFZixWDjMft/MAAbB+s2AqXN6UbJ13jfPC3VEi/XLBUbV8Okt
	 DNhrcrEJ4JQeXVGMsPMSVnwSRrAvoMHeiEf7h7Gu/pmpwcmrdWo0dNsz9OD3JGIAy5
	 rbbY+R5GCZ+urMfKpLx/5+Q2pqKAXZ9xSMZwdcOw=
Subject: FAILED: patch "[PATCH] drm/i915/display: Increase Fast Wake Sync length as a quirk" failed to apply to 6.10-stable tree
To: jouni.hogander@intel.com,jani.nikula@intel.com,joonas.lahtinen@linux.intel.com,stable@vger.kernel.org,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:36:07 +0200
Message-ID: <2024090806-marbles-stegosaur-6314@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x a13494de53258d8cf82ed3bcd69176bbf7f2640e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090806-marbles-stegosaur-6314@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

a13494de5325 ("drm/i915/display: Increase Fast Wake Sync length as a quirk")
43cf50eb1408 ("drm/i915/display: Add mechanism to use sink model when applying quirk")
15438b325987 ("drm/i915/alpm: Add compute config for lobf")
8bdbde7c4c84 ("drm/i915/alpm: Move alpm related code to a new file")
dd73925e3b84 ("drm/i915/alpm: Move alpm parameters from intel_psr")
30dee753ca0a ("drm/i915/psr: LunarLake PSR2_CTL[IO Wake Lines] is 6 bits wide")
45430e7b7c8d ("drm/i915/psr: LunarLake IO and Fast Wake time line count maximums are 68")
ba7cf33f233e ("drm/i915/psr: Rename psr2_enabled as sel_update_enabled")
1e52db8a439b ("drm/i915/psr: Rename has_psr2 as has_sel_update")
accd3e041e8f ("drm/i915: pass dev_priv explicitly to PORT_ALPM_LFPS_CTL")
7f4eae0a9439 ("drm/i915: pass dev_priv explicitly to PORT_ALPM_CTL")
13b77ac5dc91 ("drm/i915: pass dev_priv explicitly to ALPM_CTL")
d82d1a6be60d ("drm/i915: pass dev_priv explicitly to EDP_PSR2_STATUS")
9b0dddd50e68 ("drm/i915: pass dev_priv explicitly to EDP_PSR2_CTL")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a13494de53258d8cf82ed3bcd69176bbf7f2640e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Mon, 2 Sep 2024 09:42:41 +0300
Subject: [PATCH] drm/i915/display: Increase Fast Wake Sync length as a quirk
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit "drm/i915/display: Increase number of fast wake precharge pulses"
we were increasing Fast Wake sync pulse length to fix problems observed on
Dell Precision 5490 laptop with AUO panel. Later we have observed this is
causing problems on other panels.

Fix these problems by increasing Fast Wake sync pulse length as a quirk
applied for Dell Precision 5490 with problematic panel.

Fixes: f77772866385 ("drm/i915/display: Increase number of fast wake precharge pulses")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Closes: http://gitlab.freedesktop.org/drm/i915/kernel/-/issues/9739
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2246
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11762
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Link: https://patchwork.freedesktop.org/patch/msgid/20240902064241.1020965-3-jouni.hogander@intel.com
(cherry picked from commit fcba2ed66b39252210f4e739722ebcc5398c2197)
Requires: 43cf50eb1408 ("drm/i915/display: Add mechanism to use sink model when applying quirk")
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 866b3b409c4d..10689480338e 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -228,7 +228,7 @@ bool intel_alpm_compute_params(struct intel_dp *intel_dp,
 	int tfw_exit_latency = 20; /* eDP spec */
 	int phy_wake = 4;	   /* eDP spec */
 	int preamble = 8;	   /* eDP spec */
-	int precharge = intel_dp_aux_fw_sync_len() - preamble;
+	int precharge = intel_dp_aux_fw_sync_len(intel_dp) - preamble;
 	u8 max_wake_lines;
 
 	io_wake_time = max(precharge, io_buffer_wake_time(crtc_state)) +
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index b8a53bb174da..be58185a77c0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -13,6 +13,7 @@
 #include "intel_dp_aux.h"
 #include "intel_dp_aux_regs.h"
 #include "intel_pps.h"
+#include "intel_quirks.h"
 #include "intel_tc.h"
 
 #define AUX_CH_NAME_BUFSIZE	6
@@ -142,16 +143,21 @@ static int intel_dp_aux_sync_len(void)
 	return precharge + preamble;
 }
 
-int intel_dp_aux_fw_sync_len(void)
+int intel_dp_aux_fw_sync_len(struct intel_dp *intel_dp)
 {
+	int precharge = 10; /* 10-16 */
+	int preamble = 8;
+
 	/*
 	 * We faced some glitches on Dell Precision 5490 MTL laptop with panel:
 	 * "Manufacturer: AUO, Model: 63898" when using HW default 18. Using 20
 	 * is fixing these problems with the panel. It is still within range
-	 * mentioned in eDP specification.
+	 * mentioned in eDP specification. Increasing Fast Wake sync length is
+	 * causing problems with other panels: increase length as a quirk for
+	 * this specific laptop.
 	 */
-	int precharge = 12; /* 10-16 */
-	int preamble = 8;
+	if (intel_has_dpcd_quirk(intel_dp, QUIRK_FW_SYNC_LEN))
+		precharge += 2;
 
 	return precharge + preamble;
 }
@@ -211,7 +217,7 @@ static u32 skl_get_aux_send_ctl(struct intel_dp *intel_dp,
 		DP_AUX_CH_CTL_TIME_OUT_MAX |
 		DP_AUX_CH_CTL_RECEIVE_ERROR |
 		DP_AUX_CH_CTL_MESSAGE_SIZE(send_bytes) |
-		DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(intel_dp_aux_fw_sync_len()) |
+		DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(intel_dp_aux_fw_sync_len(intel_dp)) |
 		DP_AUX_CH_CTL_SYNC_PULSE_SKL(intel_dp_aux_sync_len());
 
 	if (intel_tc_port_in_tbt_alt_mode(dig_port))
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.h b/drivers/gpu/drm/i915/display/intel_dp_aux.h
index 76d1f2ed7c2f..593f58fafab7 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.h
@@ -20,6 +20,6 @@ enum aux_ch intel_dp_aux_ch(struct intel_encoder *encoder);
 
 void intel_dp_aux_irq_handler(struct drm_i915_private *i915);
 u32 intel_dp_aux_pack(const u8 *src, int src_bytes);
-int intel_dp_aux_fw_sync_len(void);
+int intel_dp_aux_fw_sync_len(struct intel_dp *intel_dp);
 
 #endif /* __INTEL_DP_AUX_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index bce1f67c918b..dfd8b4960e6d 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -70,6 +70,14 @@ static void quirk_no_pps_backlight_power_hook(struct intel_display *display)
 	drm_info(display->drm, "Applying no pps backlight power quirk\n");
 }
 
+static void quirk_fw_sync_len(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	intel_set_dpcd_quirk(intel_dp, QUIRK_FW_SYNC_LEN);
+	drm_info(display->drm, "Applying Fast Wake sync pulse count quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -224,6 +232,15 @@ static struct intel_quirk intel_quirks[] = {
 };
 
 static struct intel_dpcd_quirk intel_dpcd_quirks[] = {
+	/* Dell Precision 5490 */
+	{
+		.device = 0x7d55,
+		.subsystem_vendor = 0x1028,
+		.subsystem_device = 0x0cc7,
+		.sink_oui = SINK_OUI(0x38, 0xec, 0x11),
+		.hook = quirk_fw_sync_len,
+	},
+
 };
 
 void intel_init_quirks(struct intel_display *display)
@@ -265,7 +282,7 @@ void intel_init_dpcd_quirks(struct intel_dp *intel_dp,
 		    !memcmp(q->sink_oui, ident->oui, sizeof(ident->oui)) &&
 		    (!memcmp(q->sink_device_id, ident->device_id,
 			    sizeof(ident->device_id)) ||
-		     mem_is_zero(q->sink_device_id, sizeof(q->sink_device_id))))
+		     !memchr_inv(q->sink_device_id, 0, sizeof(q->sink_device_id))))
 			q->hook(intel_dp);
 	}
 }
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index c8db50b9ab74..cafdebda7535 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -19,6 +19,7 @@ enum intel_quirk_id {
 	QUIRK_INVERT_BRIGHTNESS,
 	QUIRK_LVDS_SSC_DISABLE,
 	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
+	QUIRK_FW_SYNC_LEN,
 };
 
 void intel_init_quirks(struct intel_display *display);


