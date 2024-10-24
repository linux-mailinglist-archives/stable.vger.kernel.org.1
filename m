Return-Path: <stable+bounces-87983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32089ADA83
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29959B224C1
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132B8166302;
	Thu, 24 Oct 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMw6BR6C"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3E156F39
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741135; cv=none; b=glnkp38NJ9qP92jccGicsXavkv1g7ttRSjxxi0WxKOMt5qQw2nVGWD6puJNrSmV4jOuNwXe1yDzdVmHMY6BXwOznkAHf1fShjKSWUSJY49VTYpvAzBL1q5vv9BHTYICaMeplw/staOV7leGS7lvM0DJH8tDH90pxfzTuFYUju88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741135; c=relaxed/simple;
	bh=aUSBq0jGiyabOieUFBg9pUClhzx+TS01UM/DO7b81ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDe0CmqfL3gZvnfWQB5+s+cHAbVvZGlBkc6qU4EFFQ41eVWf/ZKL9f874tWq8sE9kik/dCNAOrwwdzbODvnQjpK29Nfx2T1mzYI3xUeb5khuS7hsUh+wBhlcxu9K5hpY+uBP667rC/tCC8uWT3UAwOQ+lttCeiiNwSDxUMZBC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMw6BR6C; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741133; x=1761277133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aUSBq0jGiyabOieUFBg9pUClhzx+TS01UM/DO7b81ok=;
  b=BMw6BR6C8n7Seq+NPbNUrImP+HiJoQFPk1WH5BKCweJ4C+5/S+KKRShN
   nPlSZ531dwDXul7ks9/YJ0omZD4gxYyXppcr14nqzlWny27M2fskFm0QQ
   rr8hd6Ua0Zw3LE4Up3cyPvgPr3MlN+UTlONuZg4YhWfvN10kEEYdVjxCi
   XCbRphiubUeGXNLAqmEuAnkuUdNXI7G0mq3BVC/NupMNcXXYp3O67KvZs
   lO/An+pYAJ2dkI53FHxN+AiKjxeoS1ajbnACkm+Xv2Usx7zSYJDc4ro4s
   eLclL2rOkorZ9nEN504x2qsUQgmHt0fdAJRRJGi+2W2OQGR9pBQZImLz9
   A==;
X-CSE-ConnectionGUID: 8SEW6wMJTZeZxyO0EBtEuw==
X-CSE-MsgGUID: F/ox95SzRJ6DwIcCpar+Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264986"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264986"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
X-CSE-ConnectionGUID: NVrcfL68Q4+bdE0slNhAaQ==
X-CSE-MsgGUID: kx+3hf6sR+uvn96YH8Bpmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384942"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	Arun R Murthy <arun.r.murthy@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 03/22] drm/i915/display: Cache adpative sync caps to use it later
Date: Wed, 23 Oct 2024 20:37:55 -0700
Message-ID: <20241024033815.3538736-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>

commit b2013783c4458a1fe8b25c0b249d2e878bcf6999 upstream.

Add new member to struct intel_dp to cache support of Adaptive Sync
SDP capabilities and use it whenever required to avoid HW access
to read capability during each atomic commit.

-v2:
- Squash both the patches

Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Reviewed-by: Arun R Murthy <arun.r.murthy@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240704082638.2302092-2-mitulkumar.ajitkumar.golani@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     |  2 +-
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 22 ++++++++++---------
 drivers/gpu/drm/i915/display/intel_dp.h       |  1 -
 drivers/gpu/drm/i915/display/intel_vrr.c      |  3 +--
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 10689480338eb..90a960fb1d143 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -280,7 +280,7 @@ void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
 	if (DISPLAY_VER(i915) < 20)
 		return;
 
-	if (!intel_dp_as_sdp_supported(intel_dp))
+	if (!intel_dp->as_sdp_supported)
 		return;
 
 	if (crtc_state->has_psr)
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index f9d3cc3c342bb..160098708eba2 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1806,6 +1806,7 @@ struct intel_dp {
 
 	/* connector directly attached - won't be use for modeset in mst world */
 	struct intel_connector *attached_connector;
+	bool as_sdp_supported;
 
 	struct drm_dp_tunnel *tunnel;
 	bool tunnel_suspended:1;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ffc0d1b140455..d5ce883b289dc 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -130,14 +130,6 @@ bool intel_dp_is_edp(struct intel_dp *intel_dp)
 	return dig_port->base.type == INTEL_OUTPUT_EDP;
 }
 
-bool intel_dp_as_sdp_supported(struct intel_dp *intel_dp)
-{
-	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
-
-	return HAS_AS_SDP(i915) &&
-		drm_dp_as_sdp_supported(&intel_dp->aux, intel_dp->dpcd);
-}
-
 static void intel_dp_unset_edid(struct intel_dp *intel_dp);
 
 /* Is link rate UHBR and thus 128b/132b? */
@@ -2635,8 +2627,7 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
 
-	if (!crtc_state->vrr.enable ||
-	    !intel_dp_as_sdp_supported(intel_dp))
+	if (!crtc_state->vrr.enable || intel_dp->as_sdp_supported)
 		return;
 
 	crtc_state->infoframes.enable |= intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC);
@@ -5921,6 +5912,15 @@ intel_dp_detect_dsc_caps(struct intel_dp *intel_dp, struct intel_connector *conn
 					  connector);
 }
 
+static void
+intel_dp_detect_sdp_caps(struct intel_dp *intel_dp)
+{
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+
+	intel_dp->as_sdp_supported = HAS_AS_SDP(i915) &&
+		drm_dp_as_sdp_supported(&intel_dp->aux, intel_dp->dpcd);
+}
+
 static int
 intel_dp_detect(struct drm_connector *connector,
 		struct drm_modeset_acquire_ctx *ctx,
@@ -5991,6 +5991,8 @@ intel_dp_detect(struct drm_connector *connector,
 
 	intel_dp_detect_dsc_caps(intel_dp, intel_connector);
 
+	intel_dp_detect_sdp_caps(intel_dp);
+
 	intel_dp_mst_configure(intel_dp);
 
 	if (intel_dp->reset_link_params) {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index a0f990a95ecca..9be539edf817b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -85,7 +85,6 @@ void intel_dp_audio_compute_config(struct intel_encoder *encoder,
 				   struct drm_connector_state *conn_state);
 bool intel_dp_has_hdmi_sink(struct intel_dp *intel_dp);
 bool intel_dp_is_edp(struct intel_dp *intel_dp);
-bool intel_dp_as_sdp_supported(struct intel_dp *intel_dp);
 bool intel_dp_is_uhbr(const struct intel_crtc_state *crtc_state);
 bool intel_dp_has_dsc(const struct intel_connector *connector);
 int intel_dp_link_symbol_size(int rate);
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 5a0da64c7db33..7e1d9c718214c 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -233,8 +233,7 @@ intel_vrr_compute_config(struct intel_crtc_state *crtc_state,
 		crtc_state->mode_flags |= I915_MODE_FLAG_VRR;
 	}
 
-	if (intel_dp_as_sdp_supported(intel_dp) &&
-	    crtc_state->vrr.enable) {
+	if (intel_dp->as_sdp_supported && crtc_state->vrr.enable) {
 		crtc_state->vrr.vsync_start =
 			(crtc_state->hw.adjusted_mode.crtc_vtotal -
 			 crtc_state->hw.adjusted_mode.vsync_start);
-- 
2.47.0


