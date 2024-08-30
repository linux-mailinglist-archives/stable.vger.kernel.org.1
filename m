Return-Path: <stable+bounces-71620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A6965F4A
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1A71F27D94
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F57173C;
	Fri, 30 Aug 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WneWJi/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4D18FC61
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013804; cv=none; b=BzxRORFhhqBS/x97jj2N6OmB6uy9b6w67jjpIdnJxOzYSux8VK20aATJ9eEGbEI1t8aT+Vq1W2qJspmi6TiBrElFo25BGCJ+G6FjWy53lB9cj7Crlv1p6Bb8Fe8cuLUNkgCbAmOp/JdnBpCIyw3GyzNhOZjwd8Qa3qzI/HW1BbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013804; c=relaxed/simple;
	bh=DUkzaOwmgUGq/eEiACbu3sF06gJk2WjEJFM4nAnEeDg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MDpsPPhINR6B0cg+AGyjWn7eaRvihTJvvGM/jJpSaSyguDklsAxtyC1q1Uc9QiBULNttLHz2UOEhshdH7f9B7aT34fbw5vUgkhQxdH2EI3ehypiXe4lMtH84DR5VaLLzKOVnTm+H3e5qPpPHJSzZyaaRcStS2W6F7FNPxBdB230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WneWJi/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1BAC4CEC7;
	Fri, 30 Aug 2024 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013804;
	bh=DUkzaOwmgUGq/eEiACbu3sF06gJk2WjEJFM4nAnEeDg=;
	h=Subject:To:Cc:From:Date:From;
	b=WneWJi/FnuvsuLEVBfx9wUD312N+mufeZnmnNoYaJfLIqKf8D4l343hflXxBUOsXW
	 AG5Nr9RvhofUhtLnvdHnc6mV4wifvRryVptmGcr+ZVFCdmGch5OlQBOYKgfn8MO8D5
	 PxsVoBIxanMy/5cyBTuc9PI5lv4Vz56o5iIpKIvw=
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Fix MST state after a sink reset" failed to apply to 6.1-stable tree
To: imre.deak@intel.com,jani.nikula@intel.com,joonas.lahtinen@linux.intel.com,suraj.kandpal@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:29:53 +0200
Message-ID: <2024083052-definite-customs-8a5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a2ccc33b88e2953a6bf0b309e7e8849cc5320018
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083052-definite-customs-8a5e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a2ccc33b88e2 ("drm/i915/dp_mst: Fix MST state after a sink reset")
e37137380931 ("drm/i915/dp_mst: Force modeset CRTC if DSC toggling requires it")
326b1e792ff0 ("drm/i915/dp_mst: Add the MST topology state for modesetted CRTCs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2ccc33b88e2953a6bf0b309e7e8849cc5320018 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Fri, 23 Aug 2024 19:29:18 +0300
Subject: [PATCH] drm/i915/dp_mst: Fix MST state after a sink reset

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
Link: https://patchwork.freedesktop.org/patch/msgid/20240823162918.1211875-1-imre.deak@intel.com
(cherry picked from commit 594cf78dc36f31c0c7e0de4567e644f406d46bae)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 59f11af3b0a1..dc75a929d3ed 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5935,6 +5935,18 @@ intel_dp_detect(struct drm_connector *connector,
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
index 27ce5c3f5951..17978a1f9ab0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1998,3 +1998,43 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 
 	return false;
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
index 8ca1d599091c..9e4c7679f1c3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
@@ -27,5 +27,6 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_state *state,
 				   struct intel_link_bw_limits *limits);
 bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 				     struct intel_crtc *crtc);
+bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
 
 #endif /* __INTEL_DP_MST_H__ */


