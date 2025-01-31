Return-Path: <stable+bounces-111807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88824A23DE5
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 13:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2125162B56
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A3619DF99;
	Fri, 31 Jan 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScmNmAXM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9D1DFF0
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738327825; cv=none; b=JsIhkqHW6vL2c+OFUeV7DDBhZABLXzV6SYpEHHPQVFUza5GPHstBspaE8BJs4Nh0dPdYsDTMjKD3fLToVldvvKuMIL1mTo1orNw8hYvFt7qcqKcYYPGCE77Cdw+dWYWFTTtHevK9zr+KcRRuuA5Ys9EqzDKHDTr7Y42Jyk+4Gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738327825; c=relaxed/simple;
	bh=BGET/UU/2bV5Re6ziqCj4p0mZbhPAXcfyFDC0FmfJTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KrMQ7i0tAWO4+GBHT+jVUGvQ2U+uHva9Kqd8SiovwrrYm7g4/XClHAZyZRWC55fXRPVPCCVb831Hc67J9G4DVWYlnaVJkLAVTEVCxaVQyb7U8nQv8yX+Y5pD7Yv84KxpdrkjuThCeUhTYWMm6Srv/BVjpNuW2xQ9kPTgd0yv3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScmNmAXM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738327823; x=1769863823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGET/UU/2bV5Re6ziqCj4p0mZbhPAXcfyFDC0FmfJTA=;
  b=ScmNmAXM+frcFaCE7PMgz2PfchyHi5EnED0JFNZbzdcI1YWWzIsvKjOV
   +rKhqfFJ/JpIfMdGRCATaibhxU5pe97gs1wqME7rl3LgXtzMaLAbX9m7D
   22paNeNir7/VjxsHPdt+GQ+7FZUYL2drsb/ecYK2NVWooodMJ0WeALgBZ
   m/H4etb8P25hQBGmV3unDO9uAp4weiqcI/HLY7fdSo+dDN+/ztJ1N3FTI
   jmzIHNX04oAPq9+a9B1RByuL2V2GjeVqfYz/ArB7iu4HnwsXBU88z7bVI
   tODZg6tcoWprI7wBidZKzl2GZPQ7cSWAGX2Q7YMnIz7jJ6PTt4LFZp9iA
   g==;
X-CSE-ConnectionGUID: 0G15qDW8Tz6ZB/diBJZlzw==
X-CSE-MsgGUID: 4HnaOg2OSU2CAGjgoHiLug==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38798436"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="38798436"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 04:50:22 -0800
X-CSE-ConnectionGUID: zlk9dCfuRNSr/+XeEPvKNA==
X-CSE-MsgGUID: h4Zkr3+dTomk03TDK+2HBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="110203309"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.174])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 04:50:20 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: imre.deak@intel.com,
	jani.nikula@intel.com,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/14] drm/i915/dp: Iterate DSC BPP from high to low on all platforms
Date: Fri, 31 Jan 2025 14:49:54 +0200
Message-Id: <3bba67923cbcd13a59d26ef5fa4bb042b13c8a9b.1738327620.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1738327620.git.jani.nikula@intel.com>
References: <cover.1738327620.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Commit 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best
compressed bpp") tries to find the best compressed bpp for the
link. However, it iterates from max to min bpp on display 13+, and from
min to max on other platforms. This presumably leads to minimum
compressed bpp always being chosen on display 11-12.

Iterate from high to low on all platforms to actually use the best
possible compressed bpp.

Fixes: 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best compressed bpp")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d1b4fd542a1f..ecf192262eb9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2073,11 +2073,10 @@ icl_dsc_compute_link_config(struct intel_dp *intel_dp,
 	/* Compressed BPP should be less than the Input DSC bpp */
 	dsc_max_bpp = min(dsc_max_bpp, output_bpp - 1);
 
-	for (i = 0; i < ARRAY_SIZE(valid_dsc_bpp); i++) {
-		if (valid_dsc_bpp[i] < dsc_min_bpp)
+	for (i = ARRAY_SIZE(valid_dsc_bpp) - 1; i >= 0; i--) {
+		if (valid_dsc_bpp[i] < dsc_min_bpp ||
+		    valid_dsc_bpp[i] > dsc_max_bpp)
 			continue;
-		if (valid_dsc_bpp[i] > dsc_max_bpp)
-			break;
 
 		ret = dsc_compute_link_config(intel_dp,
 					      pipe_config,
-- 
2.39.5


