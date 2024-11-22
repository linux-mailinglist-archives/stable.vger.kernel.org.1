Return-Path: <stable+bounces-94663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786EE9D6530
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED5F2830D8
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9BF1DFE02;
	Fri, 22 Nov 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZInMSKG8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC701DFDA4
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309674; cv=none; b=IeufjkuI1DneFk/Pnu1mv8Z8z73Dl9dU8IoheniR5PS8TDjO9EdCHI2rSo8idiEeuROwGTVwbaXQPNX7YY104B57CrwCZ4ACCScn/P6RPGUjbOYa6ZBdlAcWMfWorjHMh+belu2rwN7eK3OkO75PWwDmqDks324/RvCX4NyfC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309674; c=relaxed/simple;
	bh=4Cec/2UMWp8ojHm2LcK5q4Ct9yId++4aGHPDaRIIt04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajCABxYeRwUcjJKsa9A7K6CvwVC+s8JwWHR9TwBamcCPkV9be2ku+0DaPtugCeGfqFrbBDUI1/B4gNtPOOLpSDdKiCwfxHKar9AEcS7Pev9zD8B4+fJMNiWH9viq0m14Qw4B32YV7GhIOJ0jVr3um/LFwfysKyEFxOGlfrZQ2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZInMSKG8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309673; x=1763845673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Cec/2UMWp8ojHm2LcK5q4Ct9yId++4aGHPDaRIIt04=;
  b=ZInMSKG8sYznfxE289mAVpYuUYdHBwJN+ldzIAwa6Wi7+F2gqFOyW44V
   769Occck5kiqvAGHo7/16qk034P3iP3mgL5yDkgT640MpFrf23cXibekp
   HpLJL57T880+UysIiam48qHR3IJd99BfmqoL2hi20fT4muGyu5PxfTDnW
   5cjSYynzY8EZZUFJcQIBTuByGX3BUcg9nA570uWNhIzWrcM7W4HWKm8Iw
   0aTwXHr+i2oIBlXgBNCAjAWIQzVOxwa6Lz4lap3PTUs7oFV/Gk16F3Pwr
   IW4Ls/B7M+8/WEmqcB9d2YDrNFddAKqglkEjjtO80xx1CoiT2PVY6lX3k
   w==;
X-CSE-ConnectionGUID: fjPvOqxQQBOJGPTjZr/A+g==
X-CSE-MsgGUID: iMSDrp8NTJOuvX/k9qe77A==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878282"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878282"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
X-CSE-ConnectionGUID: FVEE8+AlS+mMdwH0hXtNXw==
X-CSE-MsgGUID: 4lvVQw+ORBGd57LwxALn0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457288"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:43 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 26/31] drm/i915: Do not explicilty enable FEC in DP_TP_CTL for UHBR rates
Date: Fri, 22 Nov 2024 13:07:14 -0800
Message-ID: <20241122210719.213373-27-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

commit 26c85e7f40f9aed4f5f04dcb0ea0bce5d44f6f54 upstream.

In case of UHBR rates, we do not need to explicitly enable FEC by writing
to DP_TP_CTL register.
For MST use-cases, intel_dp_mst_find_vcpi_slots_for_bpp() takes care of
setting fec_enable to false. However, it gets overwritten in
intel_dp_dsc_compute_config(). This change keeps fec_enable false across
MST and SST use-cases for UHBR rates.

While at it, add a comment explaining why we don't enable FEC in eDP v1.5.

v2: Correct logic to cater to SST use-cases (Jani)

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240822061448.4085693-1-chaitanya.kumar.borah@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6ce3d9c4904eb..7c1565e744ed6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2205,9 +2205,15 @@ int intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
 		&pipe_config->hw.adjusted_mode;
 	int ret;
 
+	/*
+	 * Though eDP v1.5 supports FEC with DSC, unlike DP, it is optional.
+	 * Since, FEC is a bandwidth overhead, continue to not enable it for
+	 * eDP. Until, there is a good reason to do so.
+	 */
 	pipe_config->fec_enable = pipe_config->fec_enable ||
 		(!intel_dp_is_edp(intel_dp) &&
-		 intel_dp_supports_fec(intel_dp, connector, pipe_config));
+		 intel_dp_supports_fec(intel_dp, connector, pipe_config) &&
+		 !intel_dp_is_uhbr(pipe_config));
 
 	if (!intel_dp_supports_dsc(connector, pipe_config))
 		return -EINVAL;
-- 
2.47.0


