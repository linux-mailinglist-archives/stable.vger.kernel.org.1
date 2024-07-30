Return-Path: <stable+bounces-62717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3FE940DC2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EE41C246BB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22262195807;
	Tue, 30 Jul 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RoEBoc8x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BD194C92
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331904; cv=none; b=e1FmqDNyU5KtviGjeXC/B0yJS2nbtC+4p76+V70hr6ImSPAcj6BzYAeNJ1+RXbMfDszwihoHsxprO1deMVyXKEIwmGHMdtN+o/Lx2HB8wvAWG1eM/6gWzMkny/RcHY6quFBL38OD5AB0NdeMqfmniiOC7A0R3AiYu2IxOSimRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331904; c=relaxed/simple;
	bh=He+LDZF5ksjuGtd+CbmZBlJgA5igf16Ml6Y+w3ro36o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tyjLkUakSGUgU8TlEAMgnHCdUEkX37C7fkziYXOSjrg5pOyTTE/FMcWntEEC5j0NDQywNsw+OJ04BCvghScs0r4BJPj3bfNdfBAok9wc4IAuN5vWxZfqBOV9x8nhyOoY4R5dmYf2YEHic2V0Lg0Acs9rgyhdF4hhZzdzlsNh1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RoEBoc8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADB3C32782;
	Tue, 30 Jul 2024 09:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331904;
	bh=He+LDZF5ksjuGtd+CbmZBlJgA5igf16Ml6Y+w3ro36o=;
	h=Subject:To:Cc:From:Date:From;
	b=RoEBoc8xMTT6dr00w7VnsXTDLLnVV2YnBEeFa8R7DXOPbKum8SfpGL0djTXBEcWzl
	 Rz33TQ9Zn16VwBiTr5dptmTW0HwtfjqcOw4593iszaarPTzuqJq5TUgnbvL3S2iUIb
	 1EaSsHBXEpspe/4nJdM2U151puI6Q1M7Dl6Gs/aE=
Subject: FAILED: patch "[PATCH] drm/i915/dp: Don't switch the LTTPR mode on an active link" failed to apply to 6.1-stable tree
To: imre.deak@intel.com,ankit.k.nautiyal@intel.com,gareth.yu@intel.com,stable@vger.kernel.org,tursulin@ursulin.net,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:31:41 +0200
Message-ID: <2024073041-suffocate-marrow-e9ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 509580fad7323b6a5da27e8365cd488f3b57210e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073041-suffocate-marrow-e9ec@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

509580fad732 ("drm/i915/dp: Don't switch the LTTPR mode on an active link")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 509580fad7323b6a5da27e8365cd488f3b57210e Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 8 Jul 2024 22:00:25 +0300
Subject: [PATCH] drm/i915/dp: Don't switch the LTTPR mode on an active link
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Switching to transparent mode leads to a loss of link synchronization,
so prevent doing this on an active link. This happened at least on an
Intel N100 system / DELL UD22 dock, the LTTPR residing either on the
host or the dock. To fix the issue, keep the current mode on an active
link, adjusting the LTTPR count accordingly (resetting it to 0 in
transparent mode).

v2: Adjust code comment during link training about reiniting the LTTPRs.
   (Ville)

Fixes: 7b2a4ab8b0ef ("drm/i915: Switch to LTTPR transparent mode link training")
Reported-and-tested-by: Gareth Yu <gareth.yu@intel.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/10902
Cc: <stable@vger.kernel.org> # v5.15+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240708190029.271247-3-imre.deak@intel.com
(cherry picked from commit 211ad49cf8ccfdc798a719b4d1e000d0a8a9e588)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 1bc4ef84ff3b..d044c8e36bb3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -117,10 +117,24 @@ intel_dp_set_lttpr_transparent_mode(struct intel_dp *intel_dp, bool enable)
 	return drm_dp_dpcd_write(&intel_dp->aux, DP_PHY_REPEATER_MODE, &val, 1) == 1;
 }
 
-static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+static bool intel_dp_lttpr_transparent_mode_enabled(struct intel_dp *intel_dp)
+{
+	return intel_dp->lttpr_common_caps[DP_PHY_REPEATER_MODE -
+					   DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV] ==
+		DP_PHY_REPEATER_MODE_TRANSPARENT;
+}
+
+/*
+ * Read the LTTPR common capabilities and switch the LTTPR PHYs to
+ * non-transparent mode if this is supported. Preserve the
+ * transparent/non-transparent mode on an active link.
+ *
+ * Return the number of detected LTTPRs in non-transparent mode or 0 if the
+ * LTTPRs are in transparent mode or the detection failed.
+ */
+static int intel_dp_init_lttpr_phys(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
 	int lttpr_count;
-	int i;
 
 	if (!intel_dp_read_lttpr_common_caps(intel_dp, dpcd))
 		return 0;
@@ -134,6 +148,19 @@ static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEI
 	if (lttpr_count == 0)
 		return 0;
 
+	/*
+	 * Don't change the mode on an active link, to prevent a loss of link
+	 * synchronization. See DP Standard v2.0 3.6.7. about the LTTPR
+	 * resetting its internal state when the mode is changed from
+	 * non-transparent to transparent.
+	 */
+	if (intel_dp->link_trained) {
+		if (lttpr_count < 0 || intel_dp_lttpr_transparent_mode_enabled(intel_dp))
+			goto out_reset_lttpr_count;
+
+		return lttpr_count;
+	}
+
 	/*
 	 * See DP Standard v2.0 3.6.6.1. about the explicit disabling of
 	 * non-transparent mode and the disable->enable non-transparent mode
@@ -154,11 +181,25 @@ static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEI
 		       "Switching to LTTPR non-transparent LT mode failed, fall-back to transparent mode\n");
 
 		intel_dp_set_lttpr_transparent_mode(intel_dp, true);
-		intel_dp_reset_lttpr_count(intel_dp);
 
-		return 0;
+		goto out_reset_lttpr_count;
 	}
 
+	return lttpr_count;
+
+out_reset_lttpr_count:
+	intel_dp_reset_lttpr_count(intel_dp);
+
+	return 0;
+}
+
+static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+{
+	int lttpr_count;
+	int i;
+
+	lttpr_count = intel_dp_init_lttpr_phys(intel_dp, dpcd);
+
 	for (i = 0; i < lttpr_count; i++)
 		intel_dp_read_lttpr_phy_caps(intel_dp, dpcd, DP_PHY_LTTPR(i));
 
@@ -1482,10 +1523,10 @@ void intel_dp_start_link_train(struct intel_atomic_state *state,
 	struct intel_digital_port *dig_port = dp_to_dig_port(intel_dp);
 	struct intel_encoder *encoder = &dig_port->base;
 	bool passed;
-
 	/*
-	 * TODO: Reiniting LTTPRs here won't be needed once proper connector
-	 * HW state readout is added.
+	 * Reinit the LTTPRs here to ensure that they are switched to
+	 * non-transparent mode. During an earlier LTTPR detection this
+	 * could've been prevented by an active link.
 	 */
 	int lttpr_count = intel_dp_init_lttpr_and_dprx_caps(intel_dp);
 


