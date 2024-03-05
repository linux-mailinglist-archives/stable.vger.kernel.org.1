Return-Path: <stable+bounces-26734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0DA871850
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 09:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF61C2179B
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7021C2E40B;
	Tue,  5 Mar 2024 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtE63Y9W"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FC1EEFD
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627825; cv=none; b=Z1CfHwncA7j6Q9ENs6awTgW6d3IMP9wbxg4wPYtFv2k3FpRO3k/vfB788TqlAlDcurkGaj3mzJrdPWtAiv8uY6/p/u2Z+VUKVutPBreMTALhuh1Pi/nXCqlj2SPyA2BEBbQbG6YSyoFya00hfyTCzqSz2sc9lWubfCFgVSiyOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627825; c=relaxed/simple;
	bh=d3r4OE9u4jjIl5jkj+IOWi1AHAspsSPNRjH8yXNEI5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVa/KvpNRlAJilak8dPs56xSLPiYEHbT1TOYJZk+MaPp21urPuMr3Bf8ehUATwquhvFC+mOuHBWyoAivhO9JFXyxWVM8m7u9/JIgi089Y4swZ4x4PKDnLOvsb6YhJX/Cl84Zp528rPCpZTRbWljvQs6uoIJWtMbBV9kO4FG/RKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtE63Y9W; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709627823; x=1741163823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d3r4OE9u4jjIl5jkj+IOWi1AHAspsSPNRjH8yXNEI5E=;
  b=PtE63Y9WppGb3r/gb7UjBYbw/GPpGvuGFM4KnO5Q9nhr95EmrvaNtRdZ
   i4lmt0nO7WNHdb7xD4YBVvdBt5/raFjuiNN2EwRmwzCtxrBzj2v0Z17bj
   mFfmehmIh3Ws4RdMP7r5lVmldAJgQ+jaQ9SHJWcm63C68UDRumIiv+1yc
   8qJXmxEUtzh3hbGX8CNWd4AWjE8RVpJPJbpj5AZ3iQHmSeuxQGma5r/V5
   +vJX43U7HjGc+wgi28JhdVWA4XuwHZag1Sa+fDUGVWJpT1IK3XtWlbDgS
   idCtFcmaBvXDziXtnBw9zUCaqkQs6aJhtfx/tL9cDvZG1vQcnpcmSEcl/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7111424"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7111424"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 00:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="827773656"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="827773656"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 05 Mar 2024 00:37:00 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 05 Mar 2024 10:36:59 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915/dsi: Go back to the previous INIT_OTP/DISPLAY_ON order, mostly
Date: Tue,  5 Mar 2024 10:36:59 +0200
Message-ID: <20240305083659.8396-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Reinstate commit 88b065943cb5 ("drm/i915/dsi: Do display on
sequence later on icl+"), for the most part. Turns out some
machines (eg. Chuwi Minibook X) really do need that updated order.
It is also the order the Windows driver uses.

However we can't just undo the revert since that would again
break Lenovo 82TQ. After staring at the VBT sequences for both
machines I've concluded that the Lenovo 82TQ sequences look
somewhat broken:
 - INIT_OTP is not present at all
 - what should be in INIT_OTP is found in DISPLAY_ON
 - what should be in DISPLAY_ON is found in BACKLIGHT_ON
   (along with the actual backlight stuff)

The Chuwi Minibook X on the other hand has a full complement
of sequences in its VBT.

So let's try to deal with the broken sequences in the
Lenovo 82TQ VBT by simply swapping the (non-existent)
INIT_OTP sequence with the DISPLAY_ON sequence. Thus we
execute DISPLAY_ON when intending to execute INIT_OTP,
and execute nothing at all when intending to execute
DISPLAY_ON. That should be 100% equivalent to the
revert, for such broken VBTs.

Cc: stable@vger.kernel.org
Fixes: dc524d05974f ("Revert "drm/i915/dsi: Do display on sequence later on icl+"")
References: https://gitlab.freedesktop.org/drm/intel/-/issues/10071
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10334
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c    |  3 +-
 drivers/gpu/drm/i915/display/intel_bios.c | 43 +++++++++++++++++++----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index eda4a8b88590..ac456a2275db 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1155,7 +1155,6 @@ static void gen11_dsi_powerup_panel(struct intel_encoder *encoder)
 	}
 
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_INIT_OTP);
-	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
 
 	/* ensure all panel commands dispatched before enabling transcoder */
 	wait_for_cmds_dispatched_to_panel(encoder);
@@ -1256,6 +1255,8 @@ static void gen11_dsi_enable(struct intel_atomic_state *state,
 	/* step6d: enable dsi transcoder */
 	gen11_dsi_enable_transcoder(encoder);
 
+	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_DISPLAY_ON);
+
 	/* step7: enable backlight */
 	intel_backlight_enable(crtc_state, conn_state);
 	intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_BACKLIGHT_ON);
diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 343726de9aa7..373291d10af9 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -1955,16 +1955,12 @@ static int get_init_otp_deassert_fragment_len(struct drm_i915_private *i915,
  * these devices we split the init OTP sequence into a deassert sequence and
  * the actual init OTP part.
  */
-static void fixup_mipi_sequences(struct drm_i915_private *i915,
-				 struct intel_panel *panel)
+static void vlv_fixup_mipi_sequences(struct drm_i915_private *i915,
+				     struct intel_panel *panel)
 {
 	u8 *init_otp;
 	int len;
 
-	/* Limit this to VLV for now. */
-	if (!IS_VALLEYVIEW(i915))
-		return;
-
 	/* Limit this to v1 vid-mode sequences */
 	if (panel->vbt.dsi.config->is_cmd_mode ||
 	    panel->vbt.dsi.seq_version != 1)
@@ -2000,6 +1996,41 @@ static void fixup_mipi_sequences(struct drm_i915_private *i915,
 	panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP] = init_otp + len - 1;
 }
 
+/*
+ * Some machines (eg. Lenovo 82TQ) appear to have broken
+ * VBT sequences:
+ * - INIT_OTP is not present at all
+ * - what should be in INIT_OTP is in DISPLAY_ON
+ * - what should be in DISPLAY_ON is in BACKLIGHT_ON
+ *   (along with the actual backlight stuff)
+ *
+ * To make those work we simply swap DISPLAY_ON and INIT_OTP.
+ *
+ * TODO: Do we need to limit this to specific machines,
+ *       or examine the contents of the sequences to
+ *       avoid false positives?
+ */
+static void icl_fixup_mipi_sequences(struct drm_i915_private *i915,
+				     struct intel_panel *panel)
+{
+	if (!panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP] &&
+	    panel->vbt.dsi.sequence[MIPI_SEQ_DISPLAY_ON]) {
+		drm_dbg_kms(&i915->drm, "Broken VBT: Swapping INIT_OTP and DISPLAY_ON sequences\n");
+
+		swap(panel->vbt.dsi.sequence[MIPI_SEQ_INIT_OTP],
+		     panel->vbt.dsi.sequence[MIPI_SEQ_DISPLAY_ON]);
+	}
+}
+
+static void fixup_mipi_sequences(struct drm_i915_private *i915,
+				 struct intel_panel *panel)
+{
+	if (DISPLAY_VER(i915) >= 11)
+		icl_fixup_mipi_sequences(i915, panel);
+	else if (IS_VALLEYVIEW(i915))
+		vlv_fixup_mipi_sequences(i915, panel);
+}
+
 static void
 parse_mipi_sequence(struct drm_i915_private *i915,
 		    struct intel_panel *panel)
-- 
2.43.0


