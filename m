Return-Path: <stable+bounces-172657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530A5B32B2E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 18:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B3FAA5129
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3EE1F419B;
	Sat, 23 Aug 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmmTTgF1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB319E968
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755968181; cv=none; b=n1a0iLt6n19hBpORYbGHUlxVELeagL+m/MuRBDUVfTtQZ6toK5wpDQhMYoA941/Gly6mSJFcfuf4RVln62ZAOq1GEBpnOXNHMyfGWIxCbVZTAaGWYhKL7/VoVPsHPU4Jzw4kmJoxln/XFV1OwXyKq4sH3gOEJNlTjuCsbVlO6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755968181; c=relaxed/simple;
	bh=7V5IuY1gwX9msyu/Z10x7PoyhCdoYK5tg4zG07BYJ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMaXydXQJPOYwfoEWHmcEnRe0xl6UannLrTaJ6rTvOz4ViCFulYK/JwDJZ4sgHy3kGXu4uX3yEjXW1GFiVZzhefV68kPnD5qCfvbkACFVhiD2ukG3zVzsUrPLMSm2atwQVfYs83OX0wx9IwQTB8l//jE3HDFQ8gaEKbMzmDkVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmmTTgF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E02C4CEE7;
	Sat, 23 Aug 2025 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755968180;
	bh=7V5IuY1gwX9msyu/Z10x7PoyhCdoYK5tg4zG07BYJ1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmmTTgF1ItNTYw/pJz4cpCvC1lpb8lDZ51Fn0matlQZ09mt1TgLMJgu3MUGYlONh2
	 N1+K+b12vJMx/ElThos3C8K1pKvgCUJQhut7mrQX2WSdzb6ZFwghm3Gz5lgc11hdJl
	 /S3PsbgAYKOMDIzaZlokInOSKX9o7FCXZllbHYGMAb+/t9jOnUs3bu1UMvJKbJ2/vp
	 khrtq3KZKA0QVFmB/FF2vel1vtXlaMBMgTOyH65+hnQBoqGMzsQKmfs1kXls9hMprH
	 d8MIEt8SNPWYFwipaRM6TN6yT6svEqEerq/ILQoLfrHzyfpK0QX/nX5aDWgykwujCC
	 2WhVvOvYkEr3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Charlton Lin <charlton.lin@intel.com>,
	Khaled Almahallawy <khaled.almahallawy@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/icl+/tc: Cache the max lane count value
Date: Sat, 23 Aug 2025 12:56:18 -0400
Message-ID: <20250823165618.2341421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082305-reappoint-annotate-8587@gregkh>
References: <2025082305-reappoint-annotate-8587@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit 5fd35236546abe780eaadb7561e09953719d4fc3 ]

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
[ adapted APIs from intel_display to drm_i915_private structures ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_tc.c | 55 +++++++++++++++++++++----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 6f2ee7dbc43b..ad1f7c53afe6 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -63,6 +63,7 @@ struct intel_tc_port {
 	enum tc_port_mode init_mode;
 	enum phy_fia phy_fia;
 	u8 phy_fia_idx;
+	u8 max_lane_count;
 };
 
 static enum intel_display_power_domain
@@ -366,12 +367,12 @@ static int intel_tc_port_get_max_lane_count(struct intel_digital_port *dig_port)
 	}
 }
 
-int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
+static int get_max_lane_count(struct intel_tc_port *tc)
 {
+	struct intel_digital_port *dig_port = tc->dig_port;
 	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
-	struct intel_tc_port *tc = to_tc_port(dig_port);
 
-	if (!intel_encoder_is_tc(&dig_port->base) || tc->mode != TC_PORT_DP_ALT)
+	if (tc->mode != TC_PORT_DP_ALT)
 		return 4;
 
 	assert_tc_cold_blocked(tc);
@@ -385,6 +386,21 @@ int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
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
@@ -597,9 +613,12 @@ static void icl_tc_phy_get_hw_state(struct intel_tc_port *tc)
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
 
@@ -657,8 +676,11 @@ static bool icl_tc_phy_connect(struct intel_tc_port *tc,
 
 	tc->lock_wakeref = tc_cold_block(tc);
 
-	if (tc->mode == TC_PORT_TBT_ALT)
+	if (tc->mode == TC_PORT_TBT_ALT) {
+		read_pin_configuration(tc);
+
 		return true;
+	}
 
 	if ((!tc_phy_is_ready(tc) ||
 	     !icl_tc_phy_take_ownership(tc, true)) &&
@@ -669,6 +691,7 @@ static bool icl_tc_phy_connect(struct intel_tc_port *tc,
 		goto out_unblock_tc_cold;
 	}
 
+	read_pin_configuration(tc);
 
 	if (!tc_phy_verify_legacy_or_dp_alt_mode(tc, required_lanes))
 		goto out_release_phy;
@@ -859,9 +882,12 @@ static void adlp_tc_phy_get_hw_state(struct intel_tc_port *tc)
 	port_wakeref = intel_display_power_get(i915, port_power_domain);
 
 	tc->mode = tc_phy_get_current_mode(tc);
-	if (tc->mode != TC_PORT_DISCONNECTED)
+	if (tc->mode != TC_PORT_DISCONNECTED) {
 		tc->lock_wakeref = tc_cold_block(tc);
 
+		read_pin_configuration(tc);
+	}
+
 	intel_display_power_put(i915, port_power_domain, port_wakeref);
 }
 
@@ -874,6 +900,9 @@ static bool adlp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
 
 	if (tc->mode == TC_PORT_TBT_ALT) {
 		tc->lock_wakeref = tc_cold_block(tc);
+
+		read_pin_configuration(tc);
+
 		return true;
 	}
 
@@ -895,6 +924,8 @@ static bool adlp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
 
 	tc->lock_wakeref = tc_cold_block(tc);
 
+	read_pin_configuration(tc);
+
 	if (!tc_phy_verify_legacy_or_dp_alt_mode(tc, required_lanes))
 		goto out_unblock_tc_cold;
 
@@ -1094,9 +1125,12 @@ static void xelpdp_tc_phy_get_hw_state(struct intel_tc_port *tc)
 	tc_cold_wref = __tc_cold_block(tc, &domain);
 
 	tc->mode = tc_phy_get_current_mode(tc);
-	if (tc->mode != TC_PORT_DISCONNECTED)
+	if (tc->mode != TC_PORT_DISCONNECTED) {
 		tc->lock_wakeref = tc_cold_block(tc);
 
+		read_pin_configuration(tc);
+	}
+
 	drm_WARN_ON(&i915->drm,
 		    (tc->mode == TC_PORT_DP_ALT || tc->mode == TC_PORT_LEGACY) &&
 		    !xelpdp_tc_phy_tcss_power_is_enabled(tc));
@@ -1108,14 +1142,19 @@ static bool xelpdp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
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
 
-- 
2.50.1


