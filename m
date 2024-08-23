Return-Path: <stable+bounces-70065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AE095D370
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1336286DB0
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DE18BBBA;
	Fri, 23 Aug 2024 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxjSzJkp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC9418BBB7
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430542; cv=none; b=Gq3r7MNDCclFKLTOXIBfwYvOshjtt7LggI2x9epncTVvW2N5Yw6wBx1gQYykG5N/mtZHNjmOIQrBahxKyqKKDE2MNMaof5OWE/CJq/cu6mBvWuu1fZ1FJMuOa1L3rkqEXDyA9TTpGNmtiDjCwIn8ezwNxu6vNHMF5XavS8MKBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430542; c=relaxed/simple;
	bh=mSr8EHOPVIl1bro3w6AIZ6BqWJplG8ume4e2DUkHh/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IW4jg3FTUD7OxTJDwlfuG9C2VQpDxEZXiRkrb1nBIDjz8Jqy4TJnsEp/P3Hrp+uT0X/P3TidNbhFOjkqTQpXmY3qFxWPJSP8zWRmiMCW+BMwRb/MhdrOJ8UIhziX28u2hflrn03AbW5vcWGTUOeldaRF/jmVSN3/1RTShOLX5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxjSzJkp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724430541; x=1755966541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mSr8EHOPVIl1bro3w6AIZ6BqWJplG8ume4e2DUkHh/Q=;
  b=kxjSzJkpxBVC+NQXVzRcF1UtsQMPXgGhmL1PfyvfS3R7PE7vpqxU8CsD
   q8k1sgCeTOqRTuVq7serk9W8wir7hK6mICAxp+498AD5K84I2Q3HCJu5K
   3d2HUO3292CeZPrYDtmAKmwyW212VkljHIBgw1KxNJw2PKjnpnUEb0jF7
   OlGmAuLgll3PpTXsbvnXQ2lIffZwXt3VY16eDOuOTjJ8BLguy3m4K4mcN
   Xj4rCNF8ocstfn7GHWVILPgS1lDrhzme4oVKvH9MmcX3NtNwKQSJ2BDG3
   SIkG+A52EMPZFQfXLnKoSS7dRGBjlu7SvFZJaozRDGYkaIiktmM+1x3KQ
   g==;
X-CSE-ConnectionGUID: 7xycLLljQn6iu0ahQGAEjw==
X-CSE-MsgGUID: Pw6vYLNmT0is0XXquhV68w==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="48300250"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="48300250"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 09:29:00 -0700
X-CSE-ConnectionGUID: O8fkD6P1SgmSGOMO9KknMg==
X-CSE-MsgGUID: a/2TZWI1TNSxCPnIxnXmAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="99365096"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 09:28:58 -0700
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH v2] drm/i915/dp_mst: Fix MST state after a sink reset
Date: Fri, 23 Aug 2024 19:29:18 +0300
Message-ID: <20240823162918.1211875-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240724161223.2291853-1-imre.deak@intel.com>
References: <20240724161223.2291853-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases the sink can reset itself after it was configured into MST
mode, without the driver noticing the disconnected state. For instance
the reset may happen in the middle of a modeset, or the (long) HPD pulse
generated may be not long enough for the encoder detect handler to
observe the HPD's deasserted state. In this case the sink's DPCD
register programmed to enable MST will be reset, while the driver still
assumes MST is still enabled. Detect this condition, which will tear
down and recreate/re-enable the MST topology.

v2:
- Add a code comment about adjusting the expected DP_MSTM_CTRL register
  value for SST + SideBand. (Suraj, Jani)
- Print a debug message about detecting the link reset. (Jani)
- Verify the DPCD MST state only if it wasn't already determined that
  the sink is disconnected.

Cc: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11195
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com> (v1)
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c     | 12 +++++++
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 40 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp_mst.h |  1 +
 3 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6a0c7ae654f40..789c2f78826d0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5999,6 +5999,18 @@ intel_dp_detect(struct drm_connector *connector,
 	else
 		status = connector_status_disconnected;
 
+	if (status != connector_status_disconnected &&
+	    !intel_dp_mst_verify_dpcd_state(intel_dp))
+		/*
+		 * This requires retrying detection for instance to re-enable
+		 * the MST mode that got reset via a long HPD pulse. The retry
+		 * will happen either via the hotplug handler's retry logic,
+		 * ensured by setting the connector here to SST/disconnected,
+		 * or via a userspace connector probing in response to the
+		 * hotplug uevent sent when removing the MST connectors.
+		 */
+		status = connector_status_disconnected;
+
 	if (status == connector_status_disconnected) {
 		memset(&intel_dp->compliance, 0, sizeof(intel_dp->compliance));
 		memset(intel_connector->dp.dsc_dpcd, 0, sizeof(intel_connector->dp.dsc_dpcd));
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 45d2230d1801b..15541932b809e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -2062,3 +2062,43 @@ void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp)
 
 	intel_mst_set_probed_link_params(intel_dp, link_rate, lane_count);
 }
+
+/*
+ * intel_dp_mst_verify_dpcd_state - verify the MST SW enabled state wrt. the DPCD
+ * @intel_dp: DP port object
+ *
+ * Verify if @intel_dp's MST enabled SW state matches the corresponding DPCD
+ * state. A long HPD pulse - not long enough to be detected as a disconnected
+ * state - could've reset the DPCD state, which requires tearing
+ * down/recreating the MST topology.
+ *
+ * Returns %true if the SW MST enabled and DPCD states match, %false
+ * otherwise.
+ */
+bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+	struct intel_connector *connector = intel_dp->attached_connector;
+	struct intel_digital_port *dig_port = dp_to_dig_port(intel_dp);
+	struct intel_encoder *encoder = &dig_port->base;
+	int ret;
+	u8 val;
+
+	if (!intel_dp->is_mst)
+		return true;
+
+	ret = drm_dp_dpcd_readb(intel_dp->mst_mgr.aux, DP_MSTM_CTRL, &val);
+
+	/* Adjust the expected register value for SST + SideBand. */
+	if (ret < 0 || val != (DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC)) {
+		drm_dbg_kms(display->drm,
+			    "[CONNECTOR:%d:%s][ENCODER:%d:%s] MST mode got reset, removing topology (ret=%d, ctrl=0x%02x)\n",
+			    connector->base.base.id, connector->base.name,
+			    encoder->base.base.id, encoder->base.name,
+			    ret, val);
+
+		return false;
+	}
+
+	return true;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.h b/drivers/gpu/drm/i915/display/intel_dp_mst.h
index fba76454fa67f..8343804ce3f8d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
@@ -28,5 +28,6 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_state *state,
 bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 				     struct intel_crtc *crtc);
 void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
+bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
 
 #endif /* __INTEL_DP_MST_H__ */
-- 
2.44.2


