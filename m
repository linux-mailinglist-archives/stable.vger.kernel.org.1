Return-Path: <stable+bounces-120061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C152A4C07B
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 13:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276D13A7417
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D401F0E5A;
	Mon,  3 Mar 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxoHCP4V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8697FBAC
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005597; cv=none; b=uYGBB31cCi1JqxCr1nQEmNekLpM9xb9f4HJEdgzZ4fFsKY6Fj4rPkcSyKDkVexkBah1SQviQfF3rPjwytODN/NlFjVYdao/l0Ei7qNVxxSQ/eOU10NOHoEj0DOMdqFMAHcfW7IMujCmLxDMVT8+j0I1eALJ3V7Z/lVKtkkeHAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005597; c=relaxed/simple;
	bh=rXeG8MbAFrJU9iC0Xz5B8YCxrtJT9CB0qT3kFmj1hY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WER6tb83kUDZbs5TyQtnkobSy5dI0c5NOg9VYmRL/rvCP6s0DUbj8v4/Qpt/XrN7iznS1vZR+vWEvVENCjY6iOoe2qPqQY86ApqemYcxtpqbenfm1heghE0I5OlX4VGsecHpaWNkDlzKnGRPi6NQGp/wQwDnmOK20dQEbbnLsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxoHCP4V; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741005595; x=1772541595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rXeG8MbAFrJU9iC0Xz5B8YCxrtJT9CB0qT3kFmj1hY8=;
  b=SxoHCP4VGm56IC/tSdGynJ0uEHqkonBH0dEM82lR+9zTtl+Ei7LuLuIe
   WkDrdL8B/67WpGAa6XfmETOUsnkbQjZfJjBvfXFboO5ZFmSvayy2oxKtf
   a4hcZuvSa6qwtkxgWC1CbrSuYBT10T9G12OpQBmx6KpSVFmKCWaccNqH1
   uJF6F0hlP6lXnktKDtFVp7mICvQhUKksAkL5i062FJc4OILq/kuQOab9+
   306PFlikxmeWZA9k05MNIEKlGGF/DzGGIXPeLvPBt33jWCJtd7RMcYkyt
   h2Be+MIb3pG+zBzesZXOCtTr7slgau42EgHU+hkMKZH2P8q2Hukw3a1b1
   A==;
X-CSE-ConnectionGUID: 4K6wVcoIQ92NCr5NbE/a3g==
X-CSE-MsgGUID: BFNCv6hwQRCNJb+VU1Pn+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41731744"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41731744"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:39:55 -0800
X-CSE-ConnectionGUID: 2iENDMQYR5OBAXvJnDtXZQ==
X-CSE-MsgGUID: MWCHMSAwR0Sb8td9njhlqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123211424"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 03 Mar 2025 04:39:53 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 03 Mar 2025 14:39:52 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915/dp: Reject HBR3 when sink doesn't support TPS4
Date: Mon,  3 Mar 2025 14:39:51 +0200
Message-ID: <20250303123952.5669-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.3
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

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/5969
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 36 ++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 205ec315b413..61a58ff801a5 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -172,10 +172,22 @@ int intel_dp_link_symbol_clock(int rate)
 
 static int max_dprx_rate(struct intel_dp *intel_dp)
 {
+	int max_rate;
+
 	if (intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
-		return drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
+		max_rate = drm_dp_tunnel_max_dprx_rate(intel_dp->tunnel);
+	else
+		max_rate = drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RATE]);
+
+	/*
+	 * Some broken eDP sinks illegally declare support for
+	 * HBR3 without TPS4, and are unable to produce a stable
+	 * output. Reject HBR3 when TPS4 is not available.
+	 */
+	if (!drm_dp_tps4_supported(intel_dp->dpcd))
+		max_rate = min(max_rate, 540000);
 
-	return drm_dp_bw_code_to_link_rate(intel_dp->dpcd[DP_MAX_LINK_RATE]);
+	return max_rate;
 }
 
 static int max_dprx_lane_count(struct intel_dp *intel_dp)
@@ -4180,10 +4192,7 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 				 sink_rates, sizeof(sink_rates));
 
 		for (i = 0; i < ARRAY_SIZE(sink_rates); i++) {
-			int val = le16_to_cpu(sink_rates[i]);
-
-			if (val == 0)
-				break;
+			int rate;
 
 			/* Value read multiplied by 200kHz gives the per-lane
 			 * link rate in kHz. The source rates are, however,
@@ -4191,7 +4200,20 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
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
+			if (rate >= 810000 && !drm_dp_tps4_supported(intel_dp->dpcd))
+				break;
+
+			intel_dp->sink_rates[i] = rate;
 		}
 		intel_dp->num_sink_rates = i;
 	}
-- 
2.45.3


