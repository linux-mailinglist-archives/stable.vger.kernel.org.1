Return-Path: <stable+bounces-152607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA22AAD8334
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 08:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C6F1894F2F
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD8F256C73;
	Fri, 13 Jun 2025 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcBDW6EF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62218248F6F
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795818; cv=none; b=gnLaTgwQEeZS5FJrpvpcmEioHG1p4KVq4qBN0zVnypz9f/ZksPVROh/u9+Lyu4zeTaMdk6nvMF88FfE2N3FdcNbEyjEUJ9hoNwpTY4XM/oo+PuXYwzqVEu/egeN5cls4OE67Um5Q/ujLTvDpI8ysREnaPXKVm4CQj3Owc1SPI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795818; c=relaxed/simple;
	bh=F2LOkrfpeiM6BmjrkdE3s9OMnK4jBbJY2+dH9BOr+y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTxWz1Olk2eEmc0R2ebFYwB5kUKV2GSPhKTY5hU3iHrGcrxRY8+j5mE8JqlfdLSQLp3+iOkZLTQHd661t99KkfxnhCjpkT3bcg82ow8ItPgrROBSsz9aOJ2Ek4DMoIR7s+c/lY6X8UzTWfTuYG/uXjeD2g0rrr9GL7gJtLQ2B+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcBDW6EF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749795816; x=1781331816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F2LOkrfpeiM6BmjrkdE3s9OMnK4jBbJY2+dH9BOr+y0=;
  b=IcBDW6EFK6wI9GGSFT/lxn2ChPZmHQNGmkBYQDHIj3PXw42VQw3rMKKx
   TGefy1q9kdwdJiAfWAZFgNFug1Az9DmGIRKN0bLpwUWoRfBoPznvyztOH
   PdoesWALtUziHXFi+A7oBFZ4kHOpQ0YtzvhMvt/YluTkvG8Y7mgFumjdc
   ZlwWb3KIcMZS55seSWFNTqAQ6uL7DPIqXwgZYsC+BNbr1f2bzfXcXjO1y
   daWZnd2W4OEWLv8IUzeQm5H7YP9zkeeA+cY36GMQr5dLWNEpSVPFvDl7n
   IUOZRgt4JKNO4ZlB6D5tkGc/lXBSOwpfCpNogSNFHWueuYwMS/zveC+iR
   w==;
X-CSE-ConnectionGUID: c3Or0NQNQ9y844UsGj1tZg==
X-CSE-MsgGUID: CeccZ7L/Shi66RTSkEh9kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51918643"
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="51918643"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 23:23:35 -0700
X-CSE-ConnectionGUID: RgEmvXBMSRSmbeLBdQIZsg==
X-CSE-MsgGUID: wficdLL3T02Tslqa+9eDoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; 
   d="scan'208";a="178707602"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 23:23:32 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	suraj.kandpal@intel.com,
	jani.nikula@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/snps_hdmi_pll: Fix 64-bit divisor truncation by using div64_u64
Date: Fri, 13 Jun 2025 11:42:46 +0530
Message-ID: <20250613061246.1118579-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
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

Replace DIV_ROUND_CLOSEST_ULL with div64_u64(), which correctly
handles full 64-bit division. Since the result is clamped between
1 and 127, rounding is unnecessary and truncating division
is sufficient.

Fixes: 5947642004bf ("drm/i915/display: Add support for SNPS PHY HDMI PLL algorithm for DG2")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c b/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
index 74bb3bedf30f..ac609bdf6653 100644
--- a/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
+++ b/drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c
@@ -103,8 +103,8 @@ static void get_ana_cp_int_prop(u64 vco_clk,
 			    DIV_ROUND_DOWN_ULL(curve_1_interpolated, CURVE0_MULTIPLIER)));
 
 	ana_cp_int_temp =
-		DIV_ROUND_CLOSEST_ULL(DIV_ROUND_DOWN_ULL(adjusted_vco_clk1, curve_2_scaled1),
-				      CURVE2_MULTIPLIER);
+		div64_u64(DIV_ROUND_DOWN_ULL(adjusted_vco_clk1, curve_2_scaled1),
+			  CURVE2_MULTIPLIER);
 
 	*ana_cp_int = max(1, min(ana_cp_int_temp, 127));
 
-- 
2.45.2


