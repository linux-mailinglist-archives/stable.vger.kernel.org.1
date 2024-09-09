Return-Path: <stable+bounces-73987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1259712C9
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246FE284F39
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC71B253B;
	Mon,  9 Sep 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMW0HSj5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373171B14E1
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872446; cv=none; b=KcEnFHVVz32KnqduhF5K3tRlHFWeY7RbvDXZ8jzzd9emc2g0bXUJPGV8xXQ0bAAeL1FtLVGYXRG3bGrP2RfrMvQTm+KxnFfi+nwHfo8htZMx8OhbVFnZoHD1WhCCBcUIRP/E9A/71rZAZ1MSGoSj3diWmtBEgCIQiFxDi/NFaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872446; c=relaxed/simple;
	bh=2uC5gx32sskCSSJUT5Ov8169MdJ5hiOqqo6nmCSsehk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBxhWOlV0SagXeJy4zlhNw4Migao2FQ2uwNp8bfTMIIesN7LSLUgO4tAAI79NCH6/8vnSKYFDvlGS41fXDblbxescyxW+o9FNG+VHHabYyzgL6vZKyC4lV5BKDSNRknKggbBy55VYxRDUXH+oxoU2/NPpW6EBgTowhADgElmgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMW0HSj5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725872445; x=1757408445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2uC5gx32sskCSSJUT5Ov8169MdJ5hiOqqo6nmCSsehk=;
  b=bMW0HSj5VXeOrO+Z7eSakjQCzTx0zcE5iRM0XjBGN/JscYQHFiWmIfj1
   D9a1Ja9lJb2FxGBZcdI13D89vXaPq7+Cj1gVjP2931sWJr1h7AguOO//7
   q6xzNAJxy61GlBZEdJOpb6Dhdf4NAFBQ3bw+CefxUXMETRr6obBDXPb8t
   yp/Z7fIU1unDRluE6HYpGX4UQrSWBSX7FvcqsP/bDKYBVb1zBQp6L7MzT
   P1uTIV2Z3a22iftlULHmD4NXN7jTj35PQpvo6mreffcqMn88uYodIHaQt
   Vcadk8oV+Zrr152jOqAu8mPOwGDLRMBqnDtHBSI6SKRPyzZ+6EpKckwHg
   w==;
X-CSE-ConnectionGUID: 1ee9xPn7Rc614cmLmqdtrg==
X-CSE-MsgGUID: V9bUtr7wSyaD8kdOIzqMzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24702208"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24702208"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:00:44 -0700
X-CSE-ConnectionGUID: Xzeh5670Qo+L5eYCiSkdkg==
X-CSE-MsgGUID: saHSMxoWTLqBzmzXVkhq4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66237344"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO jhogande-mobl1..) ([10.245.245.9])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:00:42 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.10.y 2/2] drm/i915/display: Increase Fast Wake Sync length as a quirk
Date: Mon,  9 Sep 2024 11:59:18 +0300
Message-Id: <20240909085918.3239275-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909085918.3239275-1-jouni.hogander@intel.com>
References: <2024090806-marbles-stegosaur-6314@gregkh>
 <20240909085918.3239275-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
(cherry picked from commit a13494de53258d8cf82ed3bcd69176bbf7f2640e)
---
 drivers/gpu/drm/i915/display/intel_dp_aux.c | 16 +++++++++++-----
 drivers/gpu/drm/i915/display/intel_dp_aux.h |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c    |  2 +-
 drivers/gpu/drm/i915/display/intel_quirks.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
 5 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index b8a53bb174dab..be58185a77c01 100644
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
index 76d1f2ed7c2f4..593f58fafab71 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.h
@@ -20,6 +20,6 @@ enum aux_ch intel_dp_aux_ch(struct intel_encoder *encoder);
 
 void intel_dp_aux_irq_handler(struct drm_i915_private *i915);
 u32 intel_dp_aux_pack(const u8 *src, int src_bytes);
-int intel_dp_aux_fw_sync_len(void);
+int intel_dp_aux_fw_sync_len(struct intel_dp *intel_dp);
 
 #endif /* __INTEL_DP_AUX_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 3c7da862222bf..7173ffc7c66c1 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1356,7 +1356,7 @@ static bool _compute_alpm_params(struct intel_dp *intel_dp,
 	int tfw_exit_latency = 20; /* eDP spec */
 	int phy_wake = 4;	   /* eDP spec */
 	int preamble = 8;	   /* eDP spec */
-	int precharge = intel_dp_aux_fw_sync_len() - preamble;
+	int precharge = intel_dp_aux_fw_sync_len(intel_dp) - preamble;
 	u8 max_wake_lines;
 
 	io_wake_time = max(precharge, io_buffer_wake_time(crtc_state)) +
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index bce1f67c918bb..dfd8b4960e6d6 100644
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
index c8db50b9ab74d..cafdebda75354 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -19,6 +19,7 @@ enum intel_quirk_id {
 	QUIRK_INVERT_BRIGHTNESS,
 	QUIRK_LVDS_SSC_DISABLE,
 	QUIRK_NO_PPS_BACKLIGHT_POWER_HOOK,
+	QUIRK_FW_SYNC_LEN,
 };
 
 void intel_init_quirks(struct intel_display *display);
-- 
2.34.1


