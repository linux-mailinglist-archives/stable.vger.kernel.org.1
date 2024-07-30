Return-Path: <stable+bounces-64232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB86941CFA
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4ADB2665F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58018B463;
	Tue, 30 Jul 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBs8z0+n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881D1A00FA;
	Tue, 30 Jul 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359431; cv=none; b=ktR8W/abtZsWf00rq6mixGIVqhgodq1784uflyuYi0Kb4kZMqeLVBVfygMsq8wAtN/PBFq9/6k1veZ74JojcwRfpx7d26lOlqz3Jg70cpBBzgc4QdONxFfphQkflruV4kRFEiXor9bYOs1Jb3PzQ4K9FrrBJAfnYnf0KT273QPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359431; c=relaxed/simple;
	bh=adJNj8hwTqC/thknBDSRkhvaYVLY3VBCYQMdQWCNAFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMkTDj99njwEYRhi0X23tBWVU+m2lAEclmx885w/+O336hwRxuyC45KMlC5Jx1hkMZ+1BohOS+wSYoGsLkAtbR0jjOX8FBuV8iBc4vk/vM9wUeVURbuxSW9JH6Ukr3e6FbCKJHwg2l0eTzsDlufJI0seyWzHKShmvFK13Gke74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBs8z0+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E35C32782;
	Tue, 30 Jul 2024 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359431;
	bh=adJNj8hwTqC/thknBDSRkhvaYVLY3VBCYQMdQWCNAFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBs8z0+nghy8YyIqDosYdv1nN16RM28I8DOGcnPTegiwMk4LxNOK570yFD72Y8+9Y
	 sSs2//HAUJNerumGWNTo6brSdEBoguOpkZ8SvMRz5+RjdcrBOXCOxbDxIXWwzVvZyU
	 KVRdCrcUxm2otow47w5oOBYeGj6SAIvBG0oWRFeQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Gareth Yu <gareth.yu@intel.com>
Subject: [PATCH 6.6 481/568] drm/i915/dp: Dont switch the LTTPR mode on an active link
Date: Tue, 30 Jul 2024 17:49:48 +0200
Message-ID: <20240730151658.826427668@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit 509580fad7323b6a5da27e8365cd488f3b57210e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_dp_link_training.c |   55 +++++++++++++++---
 1 file changed, 48 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -114,10 +114,24 @@ intel_dp_set_lttpr_transparent_mode(stru
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
@@ -132,6 +146,19 @@ static int intel_dp_init_lttpr(struct in
 		return 0;
 
 	/*
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
+	/*
 	 * See DP Standard v2.0 3.6.6.1. about the explicit disabling of
 	 * non-transparent mode and the disable->enable non-transparent mode
 	 * sequence.
@@ -151,11 +178,25 @@ static int intel_dp_init_lttpr(struct in
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
 
@@ -1353,10 +1394,10 @@ void intel_dp_start_link_train(struct in
 {
 	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
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
 



