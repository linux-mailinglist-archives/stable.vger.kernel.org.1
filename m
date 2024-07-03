Return-Path: <stable+bounces-57949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B98ED926576
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC2A1C24AA6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152E18131E;
	Wed,  3 Jul 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjwLcI0N"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB5181B9D
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022372; cv=none; b=hrsntprQfxYMlImW+GjCtA6EqHUCMaNGJIsXeFXp99sYvqJ9OSRmNgDWaYcueunhX1BVjZlGJBweKsFCuZQZ0rA6aiSoZWlvzAux/YRn/DqhxCP2FdN7KflMxu2XjxDppVbKeVP3O0nkSHmwuNRLsn0BrJVtlPVURXDd1nFa+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022372; c=relaxed/simple;
	bh=a5G7GdCvYtVSgoq8mJSDbDY0emnk/htaPIkcwOG8Uh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHTLxB/NV7+bC826RYG3OiJq9FT4gOHZ44FctcQrykUX8N0ItYw+kML1pO7BwxKrHDs62Bq7tsSYc6eRsYbKG93Syhh787z/k8wJJTVDEwGHWwbT/JQg5E0BEGNYd4y9XYtgjXkZ8i/diVnjDOsd8sqAQ5zNq07lgFoTymRiXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjwLcI0N; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720022370; x=1751558370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5G7GdCvYtVSgoq8mJSDbDY0emnk/htaPIkcwOG8Uh0=;
  b=jjwLcI0NU1VWZPRPiTD7eJRJfiLg/yYbq/Wz++2IV+R1t1f2vCCwFCZD
   yoHxKLUEeLfInMAemwSWkWPvzovaiQuP3CAgcjk8rpCESCOL7oNISTmTA
   YvQy2vZOiFoJd8JP2YtvFt9Z6+e8BZENm8KjJudWxdK6duvzOBFzahbjH
   HavTp2PiKtCjjROLkr3KqOkLNXQryWBHshqeuvyeDrXJJ40Q4s90wWK5j
   O8HkRQejOuYXBLhV7PgpjnhYJzqhVotkSJAe3jlX2hW7Y4qIWb7Or9G5o
   oVOv1A5YU+0OKQDkODOM0lEqYZoexISurB9qZE8CMwtP1kIsLnOPq+blQ
   Q==;
X-CSE-ConnectionGUID: +e2E/7vVQCmrOoAF8QE34w==
X-CSE-MsgGUID: 2hkkIyohSc2bI9fsd9QHTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17131766"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17131766"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:59:29 -0700
X-CSE-ConnectionGUID: /OZVeDPrT4SelhBKUHjfWQ==
X-CSE-MsgGUID: QkPpuAfhSz24BeP84Fuyrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46964108"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:59:26 -0700
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Gareth Yu <gareth.yu@intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 1/5] drm/i915/dp: Don't switch the LTTPR mode on an active link
Date: Wed,  3 Jul 2024 18:59:33 +0300
Message-ID: <20240703155937.1674856-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.43.3
In-Reply-To: <20240703155937.1674856-1-imre.deak@intel.com>
References: <20240703155937.1674856-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Switching to transparent mode leads to a loss of link synchronization,
so prevent doing this on an active link. This happened at least on an
Intel N100 system / DELL UD22 dock, the LTTPR residing either on the
host or the dock. To fix the issue, keep the current mode on an active
link, adjusting the LTTPR count accordingly (resetting it to 0 in
transparent mode).

Fixes: 7b2a4ab8b0ef ("drm/i915: Switch to LTTPR transparent mode link training")
Reported-and-tested-by: Gareth Yu <gareth.yu@intel.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/10902
Cc: <stable@vger.kernel.org> # v5.15+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 .../drm/i915/display/intel_dp_link_training.c | 49 +++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 1bc4ef84ff3bc..08a27fe077917 100644
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
 
-- 
2.43.3


