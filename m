Return-Path: <stable+bounces-154674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E9ADEDB8
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBBE3A6FF9
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 13:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C252E92AA;
	Wed, 18 Jun 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sr9ute9v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8F2E8E06
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252910; cv=none; b=ctnjH85VgedqS4SCaqLSZh6FGDUt2eiQubsZWH8/kYNN3DoU85dZxF2VwuN3whf+vmdOcZHRuoyegYcX7pKT5xNf5VgiNoVMBbdcCpfQ35nsL+Ak7HH4ToeOGKg9ssL5xP5iszgdeXEHi6mXK6Qizub8OpcYNldRTbINuVfUoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252910; c=relaxed/simple;
	bh=OuGooMJPMGApLsEwwkYJWV1YAFpxZLbRBA+/r+Y3Cvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huOtYI99jgfTVUSxVaobqwUvtP5ZKe02YIzSZeAZCOXYNB+KSw4aH5Hlpzt+AAsDiAogmK8qzcixdIGjW9bN2WpLweGJn3oppyylXzRM5eb5+2dpIfjVmjsL5KXPGBfyJIjJRP+ncB9w4pjNHvWk3PfVD8Ty/tEens55VX4tfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sr9ute9v; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750252910; x=1781788910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OuGooMJPMGApLsEwwkYJWV1YAFpxZLbRBA+/r+Y3Cvk=;
  b=Sr9ute9vvm05oDREL9A8hnbheIpej+SGNF7t/zWW+m1z1FeZWF+MPn28
   XX8KedgQ7QX/X8zKjMHGCQxwHoHSs2iBwb4shc6jfpPTrvpsWpkcpcBnr
   67TRWnP30jNnkpUkB3jr29q+nGkJQRGK+Y42z247mdYCRjnODDXO/atqS
   pCghhDmqs0sjaQkFyF9qFmkAqTsL2XfzlR/XDw5UJDfBneTU1YnMm6XQ0
   uNgh4uIRovFasFaeMJtdTchDSdCO+IB+CK0i2hBk69tILilq6etYx4rbX
   qomLic/M/N1DPoy75oDgn5lRyn9CNEPM6Gxj4KwjhhE1aUbufO8bSCweL
   Q==;
X-CSE-ConnectionGUID: ZWCCIAG7TQGI6OnhrwTw2g==
X-CSE-MsgGUID: KeohJvFBSpKOAohNhxOSXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56272581"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56272581"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:20:42 -0700
X-CSE-ConnectionGUID: c01gP76MTI+qcQKht6KiCQ==
X-CSE-MsgGUID: zH2GG/pwSouig4jIJe22Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150297065"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:20:39 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	suraj.kandpal@intel.com,
	jani.nikula@linux.intel.com,
	stable@vger.kernel.org,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 2/2] drm/i915/snps_hdmi_pll: Use clamp() instead of max(min())
Date: Wed, 18 Jun 2025 18:39:51 +0530
Message-ID: <20250618130951.1596587-3-ankit.k.nautiyal@intel.com>
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

The values of ana_cp_int, and ana_cp_prop are clamped between 1 and 127.
Use the more intuitive and readable clamp() macro instead of using
nested max(min(...)).

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c b/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
index 5111bdc3075b..7fe6b4a18213 100644
--- a/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
+++ b/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
@@ -106,7 +106,7 @@ static void get_ana_cp_int_prop(u64 vco_clk,
 		DIV64_U64_ROUND_CLOSEST(DIV_ROUND_DOWN_ULL(adjusted_vco_clk1, curve_2_scaled1),
 					CURVE2_MULTIPLIER);
 
-	*ana_cp_int = max(1, min(ana_cp_int_temp, 127));
+	*ana_cp_int = clamp(ana_cp_int_temp, 1, 127);
 
 	curve_2_scaled_int = curve_2_scaled1 * (*ana_cp_int);
 
@@ -125,7 +125,7 @@ static void get_ana_cp_int_prop(u64 vco_clk,
 						       curve_1_interpolated);
 
 	*ana_cp_prop = DIV64_U64_ROUND_UP(adjusted_vco_clk2, curve_2_scaled2);
-	*ana_cp_prop = max(1, min(*ana_cp_prop, 127));
+	*ana_cp_prop = clamp(*ana_cp_prop, 1, 127);
 }
 
 static void compute_hdmi_tmds_pll(u64 pixel_clock, u32 refclk,
-- 
2.45.2


