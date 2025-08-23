Return-Path: <stable+bounces-172561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C98B32778
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7136880D4
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20E21930A;
	Sat, 23 Aug 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TgBDggrg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D21DE4C4
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935528; cv=none; b=bE2j7sVI0ZGDQNJ2EG7TfM/oHORBhk5FClKCIx1TQPQdi2580BeVoTU1sSKkaQR0zwdv135jsJrfuTwMvOfl4m6b4hgVpdp0wuwgxFs94xamKjR5Q5hvgQv5begkBo11StMoty1SIvULFxt+/4DMXb0G6Ao+B7Ap19siFrjrlnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935528; c=relaxed/simple;
	bh=HcHvhqp9G+FlH/EH+UIe2QXytwiWOB3xT33CFk7Ryik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XPBKRYosmvUfBpiqPTvQrbwqtbVK3LGQH1uHUaxSef+QqOxB1fZCooj6lZVASQPr/Oz5ACZqWRNJKHGSfFm4UadUNHIqbSITbwwF4+kC2oSzM2m11nNzvDli6FaglPIipL5l/GehbN6DXO/3AK6XN1WSaQdSS1GwTl68Q3npN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TgBDggrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE3FC4CEE7;
	Sat, 23 Aug 2025 07:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755935528;
	bh=HcHvhqp9G+FlH/EH+UIe2QXytwiWOB3xT33CFk7Ryik=;
	h=Subject:To:Cc:From:Date:From;
	b=TgBDggrg30zq8PW5mxbQC17Y9HqWlG8B86aT91IFsSeFlOTWyW6SSnPfTsgvo8lIa
	 bUtgGlm5d5B1HD+VemceFLjio+AyAbnAaBdiNyAuuI8wbO9KSGi2tIMKNe1qXE+n/H
	 VsAnx29m8zJdPGjibqOWUGE+XT6ssJOYeYvj5kKs=
Subject: FAILED: patch "[PATCH] drm/i915/icl+/tc: Cache the max lane count value" failed to apply to 6.12-stable tree
To: imre.deak@intel.com,charlton.lin@intel.com,khaled.almahallawy@intel.com,mika.kahola@intel.com,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 09:52:05 +0200
Message-ID: <2025082305-reappoint-annotate-8587@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5fd35236546abe780eaadb7561e09953719d4fc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082305-reappoint-annotate-8587@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5fd35236546abe780eaadb7561e09953719d4fc3 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 11 Aug 2025 11:01:49 +0300
Subject: [PATCH] drm/i915/icl+/tc: Cache the max lane count value

The PHY's pin assignment value in the TCSS_DDI_STATUS register - as set
by the HW/FW based on the connected DP-alt sink's TypeC/PD pin
assignment negotiation - gets cleared by the HW/FW on LNL+ as soon as
the sink gets disconnected, even if the PHY ownership got acquired
already by the driver (and hence the PHY itself is still connected and
used by the display). This is similar to how the PHY Ready flag gets
cleared on LNL+ in the same register.

To be able to query the max lane count value on LNL+ - which is based on
the above pin assignment - at all times even after the sink gets
disconnected, the max lane count must be determined and cached during
the PHY's HW readout and connect sequences. Do that here, leaving the
actual use of the cached value to a follow-up change.

v2: Don't read out the pin configuration if the PHY is disconnected.

Cc: stable@vger.kernel.org # v6.8+
Reported-by: Charlton Lin <charlton.lin@intel.com>
Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250811080152.906216-3-imre.deak@intel.com
(cherry picked from commit 3e32438fc406761f81b1928d210b3d2a5e7501a0)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 8208539bfe66..34435c4fc280 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -66,6 +66,7 @@ struct intel_tc_port {
 	enum tc_port_mode init_mode;
 	enum phy_fia phy_fia;
 	u8 phy_fia_idx;
+	u8 max_lane_count;
 };
 
 static enum intel_display_power_domain
@@ -365,12 +366,12 @@ static int intel_tc_port_get_max_lane_count(struct intel_digital_port *dig_port)
 	}
 }
 
-int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
+static int get_max_lane_count(struct intel_tc_port *tc)
 {
-	struct intel_display *display = to_intel_display(dig_port);
-	struct intel_tc_port *tc = to_tc_port(dig_port);
+	struct intel_display *display = to_intel_display(tc->dig_port);
+	struct intel_digital_port *dig_port = tc->dig_port;
 
-	if (!intel_encoder_is_tc(&dig_port->base) || tc->mode != TC_PORT_DP_ALT)
+	if (tc->mode != TC_PORT_DP_ALT)
 		return 4;
 
 	assert_tc_cold_blocked(tc);
@@ -384,6 +385,21 @@ int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
 	return intel_tc_port_get_max_lane_count(dig_port);
 }
 
+static void read_pin_configuration(struct intel_tc_port *tc)
+{
+	tc->max_lane_count = get_max_lane_count(tc);
+}
+
+int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
+{
+	struct intel_tc_port *tc = to_tc_port(dig_port);
+
+	if (!intel_encoder_is_tc(&dig_port->base))
+		return 4;
+
+	return get_max_lane_count(tc);
+}
+
 void intel_tc_port_set_fia_lane_count(struct intel_digital_port *dig_port,
 				      int required_lanes)
 {
@@ -596,9 +612,12 @@ static void icl_tc_phy_get_hw_state(struct intel_tc_port *tc)
 	tc_cold_wref = __tc_cold_block(tc, &domain);
 
 	tc->mode = tc_phy_get_current_mode(tc);
-	if (tc->mode != TC_PORT_DISCONNECTED)
+	if (tc->mode != TC_PORT_DISCONNECTED) {
 		tc->lock_wakeref = tc_cold_block(tc);
 
+		read_pin_configuration(tc);
+	}
+
 	__tc_cold_unblock(tc, domain, tc_cold_wref);
 }
 
@@ -656,8 +675,11 @@ static bool icl_tc_phy_connect(struct intel_tc_port *tc,
 
 	tc->lock_wakeref = tc_cold_block(tc);
 
-	if (tc->mode == TC_PORT_TBT_ALT)
+	if (tc->mode == TC_PORT_TBT_ALT) {
+		read_pin_configuration(tc);
+
 		return true;
+	}
 
 	if ((!tc_phy_is_ready(tc) ||
 	     !icl_tc_phy_take_ownership(tc, true)) &&
@@ -668,6 +690,7 @@ static bool icl_tc_phy_connect(struct intel_tc_port *tc,
 		goto out_unblock_tc_cold;
 	}
 
+	read_pin_configuration(tc);
 
 	if (!tc_phy_verify_legacy_or_dp_alt_mode(tc, required_lanes))
 		goto out_release_phy;
@@ -858,9 +881,12 @@ static void adlp_tc_phy_get_hw_state(struct intel_tc_port *tc)
 	port_wakeref = intel_display_power_get(display, port_power_domain);
 
 	tc->mode = tc_phy_get_current_mode(tc);
-	if (tc->mode != TC_PORT_DISCONNECTED)
+	if (tc->mode != TC_PORT_DISCONNECTED) {
 		tc->lock_wakeref = tc_cold_block(tc);
 
+		read_pin_configuration(tc);
+	}
+
 	intel_display_power_put(display, port_power_domain, port_wakeref);
 }
 
@@ -873,6 +899,9 @@ static bool adlp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
 
 	if (tc->mode == TC_PORT_TBT_ALT) {
 		tc->lock_wakeref = tc_cold_block(tc);
+
+		read_pin_configuration(tc);
+
 		return true;
 	}
 
@@ -894,6 +923,8 @@ static bool adlp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
 
 	tc->lock_wakeref = tc_cold_block(tc);
 
+	read_pin_configuration(tc);
+
 	if (!tc_phy_verify_legacy_or_dp_alt_mode(tc, required_lanes))
 		goto out_unblock_tc_cold;
 
@@ -1124,9 +1155,12 @@ static void xelpdp_tc_phy_get_hw_state(struct intel_tc_port *tc)
 	tc_cold_wref = __tc_cold_block(tc, &domain);
 
 	tc->mode = tc_phy_get_current_mode(tc);
-	if (tc->mode != TC_PORT_DISCONNECTED)
+	if (tc->mode != TC_PORT_DISCONNECTED) {
 		tc->lock_wakeref = tc_cold_block(tc);
 
+		read_pin_configuration(tc);
+	}
+
 	drm_WARN_ON(display->drm,
 		    (tc->mode == TC_PORT_DP_ALT || tc->mode == TC_PORT_LEGACY) &&
 		    !xelpdp_tc_phy_tcss_power_is_enabled(tc));
@@ -1138,14 +1172,19 @@ static bool xelpdp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
 {
 	tc->lock_wakeref = tc_cold_block(tc);
 
-	if (tc->mode == TC_PORT_TBT_ALT)
+	if (tc->mode == TC_PORT_TBT_ALT) {
+		read_pin_configuration(tc);
+
 		return true;
+	}
 
 	if (!xelpdp_tc_phy_enable_tcss_power(tc, true))
 		goto out_unblock_tccold;
 
 	xelpdp_tc_phy_take_ownership(tc, true);
 
+	read_pin_configuration(tc);
+
 	if (!tc_phy_verify_legacy_or_dp_alt_mode(tc, required_lanes))
 		goto out_release_phy;
 


