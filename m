Return-Path: <stable+bounces-121323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B295A5585B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 22:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB083AF816
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E65B207658;
	Thu,  6 Mar 2025 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dg5MfaKl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98221207A03
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295266; cv=none; b=MlzVwcJpIMvQ3T+rbltOtjoRj6VaDHzZvJR/s4awqw18FpJ+GNzxgzRJbR1rTBGv8a6rcWSaruiCRqj3apyHU2S0TrAQNJHV7wT/NCfyfGQKbEGj7Fqc8r1exlmsd1dgE3MaAyczVBqd1XKrMhlpXrdq7xoYoSPKM9qhWXRdUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295266; c=relaxed/simple;
	bh=NMDzyEFEq7Tdt7WZDX4UpUNyBopFMvPxnGh/s21M0zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2uO3APk9E9fsN2Ejk3HSp3u4WjxKiENpwOBxybFA6c/slLXUeeMvlEOAHIzsN56YLwXVpOiBHA4zRJfBLcpvLHyyOw0qBnhJ2CDrjDGwvIT3/PdkNAhqgaVbx0mKPIxAzgYWWiRSP+0cLQso6DUZV10Kna9t+6RuBd+f3Iq++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dg5MfaKl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741295265; x=1772831265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NMDzyEFEq7Tdt7WZDX4UpUNyBopFMvPxnGh/s21M0zY=;
  b=dg5MfaKleFMHuIeUUz8dIAl0v6Pb7aW/zG5q2wtFNneDk7yn43sF6MCd
   td1CFUdRXofU3gC+1knGhZ0j/LGoMHZy+SztiuKEa8LToyqHFhPdu5M59
   r4z9tsPJnmFYMi/uN8qBs3wSP5Lr+VWiMQWWdZb4xQOmBf2bCK/kAY2xd
   4UBizftvyPQNCqRK3ZFd16+qjYdxTWksT471luiHe6kNZCOZxr5EOG1FV
   qUKDmkHK3prK3cxOZQBB3oGAN1c9DMGeGca46mJy2gJWPFI4wXNCyn5mw
   Kp/sonKO+KL/clB++9d8yWBbaKiSGd2iI+bNR5IKwOgg3qNQDjQSGRWb6
   g==;
X-CSE-ConnectionGUID: 7w6BWltxT+uT2w6nlq7BmQ==
X-CSE-MsgGUID: GOWCc/7UQhuWHyL8V6BztA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42529838"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42529838"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:07:44 -0800
X-CSE-ConnectionGUID: jdwyqicOTvGmpMh/acdlbA==
X-CSE-MsgGUID: hkRngcWlRneGiyDonJhvMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124339188"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 06 Mar 2025 13:07:42 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 06 Mar 2025 23:07:40 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v2 1/2] drm/i915/dp: Reject HBR3 when sink doesn't support TPS4
Date: Thu,  6 Mar 2025 23:07:40 +0200
Message-ID: <20250306210740.11886-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250303123952.5669-1-ville.syrjala@linux.intel.com>
References: <20250303123952.5669-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

According to the DP spec TPS4 is mandatory for HBR3. We have
however seen some broken eDP sinks that violate this and
declare support for HBR3 without TPS4 support.

At least in the case of the icl Dell XPS 13 7390 this results
in an unstable output.

Reject HBR3 when TPS4 supports is unavailable on the sink.

v2: Leave breadcrumbs in dmesg to avoid head scratching (Jani)

Cc: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/5969
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 49 +++++++++++++++++++++----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 205ec315b413..70f5d1465f81 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -172,10 +172,28 @@ int intel_dp_link_symbol_clock(int rate)
 
 static int max_dprx_rate(struct intel_dp *intel_dp)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
+	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
+	int max_rate;
+
 	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
-		return drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
+		max_rate = drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
+	else
+		max_rate = drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RATE]);
 
-	return drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RATE]);
+	/*
+	 * Some broken eDP sinks illegally declare support for
+	 * HBR3 without TPS4, and are unable to produce a stable
+	 * output. Reject HBR3 when TPS4 is not available.
+	 */
+	if (max_rate >= 810000 && !drm_dp_tps4_supported(intel_dp->dpcd)) {
+		drm_dbg_kms(display->drm,
+			    "[ENCODER:%d:%s] Rejecting HBR3 due to missing TPS4 support\n",
+			    encoder->base.base.id, encoder->base.name);
+		max_rate = 540000;
+	}
+
+	return max_rate;
 }
 
 static int max_dprx_lane_count(struct intel_dp *intel_dp)
@@ -4170,6 +4188,9 @@ static void intel_edp_mso_init(struct intel_dp *intel_dp)
 static void
 intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
+	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
+
 	intel_dp->num_sink_rates = 0;
 
 	if (intel_dp->edp_dpcd[0] >= DP_EDP_14) {
@@ -4180,10 +4201,7 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 				 sink_rates, sizeof(sink_rates));
 
 		for (i = 0; i < ARRAY_SIZE(sink_rates); i++) {
-			int val = le16_to_cpu(sink_rates[i]);
-
-			if (val == 0)
-				break;
+			int rate;
 
 			/* Value read multiplied by 200kHz gives the per-lane
 			 * link rate in kHz. The source rates are, however,
@@ -4191,7 +4209,24 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 			 * back to symbols is
 			 * (val * 200kHz)*(8/10 ch. encoding)*(1/8 bit to Byte)
 			 */
-			intel_dp->sink_rates[i] = (val * 200) / 10;
+			rate = le16_to_cpu(sink_rates[i]) * 200 / 10;
+
+			if (rate == 0)
+				break;
+
+			/*
+			 * Some broken eDP sinks illegally declare support for
+			 * HBR3 without TPS4, and are unable to produce a stable
+			 * output. Reject HBR3 when TPS4 is not available.
+			 */
+			if (rate >= 810000 && !drm_dp_tps4_supported(intel_dp->dpcd)) {
+				drm_dbg_kms(display->drm,
+					    "[ENCODER:%d:%s] Rejecting HBR3 due to missing TPS4 support\n",
+					    encoder->base.base.id, encoder->base.name);
+				break;
+			}
+
+			intel_dp->sink_rates[i] = rate;
 		}
 		intel_dp->num_sink_rates = i;
 	}
-- 
2.45.3


