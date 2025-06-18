Return-Path: <stable+bounces-154672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF7ADEDB5
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F29C7AC7CE
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBA2E8E17;
	Wed, 18 Jun 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLyGyfQc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A32E719C
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252910; cv=none; b=mnt/SCvm1nLQN1Sr0DtZ/t7SyO+nCUmwhtAGlmDQtblHkAwPX+pkyPF7z1xGUc2VG8APL6eze/Gf0vOQTymgbcCNT/3u9VdFTB/6aBEePP2Aebbpqg6Tq9i3ePI1AWWyegRqqZDfcR/K5N0eDRVkB6WtkcRxK3ZCQhGGrOXSKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252910; c=relaxed/simple;
	bh=cbt+jOHvgjZU/QXSbM4J3l+ejf9IVw2JWQv5cCzRcUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dzp/YJJ4G2BLmabMcTXQR8o7BgVDdn5dSx4t1QZCOxlcLzUPPibNxDDsZ3efMF5cLepNh4tee3ZG/j7y6NegENQuUdo5cBj+Y69myBMHlPH5iLSHoo/WZ0OHuIH6FZZKZihLnCHuxD1zSrkMjuGdELJphcI6rSXhGRhaATirc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLyGyfQc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750252909; x=1781788909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbt+jOHvgjZU/QXSbM4J3l+ejf9IVw2JWQv5cCzRcUE=;
  b=lLyGyfQc1oHv6Vf2+/Fz8OJzo1JmnXMXJhoGnoiNaa/eUAZV99m2FDRR
   N0oDZHlKhIrPN3GxyWSR1iXfJbs6jOqIbEPRhRapRKlm0hUDeabVNaMhd
   H0gsHEhk7Zz+ECzzqtRKh/ZCGgaofDwkHkXDUdIWbUUk9inDkolcZzdCQ
   b1zLAzeelk+YtJwTqHVH5dlSSS+Q2XW9XH3rC6MY2t6//MY7rohYSTEF8
   oA7nAa78/0Bgz0aWep31s0TH+9CNTt3yPhQsQ8eI8hZQsmByzWGUCF74l
   iKBWykgQLPmkx184NeVd7mWPUaXSuyMzslc59R8AWx+c54g6QKvSoq6XQ
   Q==;
X-CSE-ConnectionGUID: awdLRADETdOBCGkMg87dgw==
X-CSE-MsgGUID: 97JNo1S9Q7SdVRyCS7UeZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56272574"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56272574"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:20:40 -0700
X-CSE-ConnectionGUID: ytmWU8nkTVOjzsy+jQM+iw==
X-CSE-MsgGUID: 7jqfrvHZRv6XNrRKyIQwcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150297042"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:20:36 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	suraj.kandpal@intel.com,
	jani.nikula@linux.intel.com,
	stable@vger.kernel.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Vas Novikov <vasya.novikov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 1/2] drm/i915/snps_hdmi_pll: Fix 64-bit divisor truncation by using div64_u64
Date: Wed, 18 Jun 2025 18:39:50 +0530
Message-ID: <20250618130951.1596587-2-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250618130951.1596587-1-ankit.k.nautiyal@intel.com>
References: <20250618130951.1596587-1-ankit.k.nautiyal@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIV_ROUND_CLOSEST_ULL uses do_div(), which expects a 32-bit divisor.
When passing a 64-bit constant like CURVE2_MULTIPLIER, the value is
silently truncated to u32, potentially leading to incorrect results
on large divisors.

Replace DIV_ROUND_CLOSEST_ULL with DIV64_U64_ROUND_CLOSEST which correctly
handles full 64-bit division.

v2: Use DIV64_U64_ROUND_CLOSEST instead of div64_u64 macro. (Jani)

Fixes: 5947642004bf ("drm/i915/display: Add support for SNPS PHY HDMI PLL algorithm for DG2")
Reported-by: Vas Novikov <vasya.novikov@gmail.com>
Closes: https://lore.kernel.org/all/8d7c7958-9558-4c8a-a81a-e9310f2d8852@gmail.com/
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Vas Novikov <vasya.novikov@gmail.com>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c b/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
index 74bb3bedf30f..5111bdc3075b 100644
--- a/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
+++ b/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
@@ -103,8 +103,8 @@ static void get_ana_cp_int_prop(u64 vco_clk,
 			    DIV_ROUND_DOWN_ULL(curve_1_interpolated, CURVE0_MULTIPLIER)));
 
 	ana_cp_int_temp =
-		DIV_ROUND_CLOSEST_ULL(DIV_ROUND_DOWN_ULL(adjusted_vco_clk1, curve_2_scaled1),
-				      CURVE2_MULTIPLIER);
+		DIV64_U64_ROUND_CLOSEST(DIV_ROUND_DOWN_ULL(adjusted_vco_clk1, curve_2_scaled1),
+					CURVE2_MULTIPLIER);
 
 	*ana_cp_int = max(1, min(ana_cp_int_temp, 127));
 
-- 
2.45.2


