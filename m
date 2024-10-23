Return-Path: <stable+bounces-87948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE1D9AD550
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 22:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB731F21ACA
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F21D2B3D;
	Wed, 23 Oct 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xrpx78YG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E861E51D
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714044; cv=none; b=LXXXF9IBSEI8q4uaeOUm9UCs2z5BiJcSPkUlaUy7PsUm3MwvZScqOY2UIyuNkOrWm3erm+8UaVwC3XgBDNxZraeStihK/A4N/pR5pOUfYE/UCdKXvANp/FW15fK9crIi5DKfG2KqmqW1canR/wONgLWxdgnsrzCavP+gByT6n4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714044; c=relaxed/simple;
	bh=SK5lPv3YuFK1hBUvd2UwNmsHOsoJKtMnR8B4JUF4BHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWnFYTYgS2VTeJlYRCePI+9GxBtuGgLePo0inBs9SkjaVqLhGSktrtSwFCmCmH21EWSMXR7Z340f8nLwX/s0K3OAnOA1VFLjxSHWQk9b8oJY185YCGFa03+O5oD5EOH4/PALxUbIFYuwBC6H8FUW8YtAaVpvbpH7mg7laXjltN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xrpx78YG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729714043; x=1761250043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SK5lPv3YuFK1hBUvd2UwNmsHOsoJKtMnR8B4JUF4BHQ=;
  b=Xrpx78YGbwmIpF/VZmzYF0fRHVfZLZUtzkuAHm4uYS2vS2/2/T/3h3Rs
   ynMRdr6KsUMfjLQZOsXKXKoMBic8K7ccMiMl6xne9Pv3z9yuoQEOiVadj
   so8G2/Xis9/DaAVZwRGAm8/OBfZwpmlYBNaTb9bxf+0Yjh4vfCN6NpcOr
   d0frJ/6ClYZC/VHkwJt0OL2s+eFR2dR6Oo/wgy0bABbKGBqrT8aQlJsiy
   3NTXeNP95+8Up1Swo2ep5dsOP8fvRG0/odQ7EcBBlzDOZ9+yDJLoLTWFg
   jxCNZ3Sgc0lYVcifRFyCU7X5kGZggasMz7tiSRADAOhY4MSO81EugVXYu
   g==;
X-CSE-ConnectionGUID: cmz0JpWSQumkpCsXLY4TFw==
X-CSE-MsgGUID: feRikZ8BQl+DAm/jjB7WqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29423307"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="29423307"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 13:07:21 -0700
X-CSE-ConnectionGUID: jvk8Op5RSlKDSKdXTkhXnA==
X-CSE-MsgGUID: o6BQM40KTEySnoEJ5NT3bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80543976"
Received: from dut4413lnl.fm.intel.com ([10.105.8.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 13:07:18 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: jonathan.cavitt@intel.com,
	saurabhg.gupta@intel.com,
	alex.zuo@intel.com,
	umesh.nerlige.ramappa@intel.com,
	john.c.harrison@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
Date: Wed, 23 Oct 2024 20:07:15 +0000
Message-ID: <20241023200716.82624-1-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several OA registers and allowlist registers were missing from the
save/restore list for GuC and could be lost during an engine reset.  Add
them to the list.

v2:
- Fix commit message (Umesh)
- Add missing closes (Ashutosh)

v3:
- Add missing fixes (Ashutosh)

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Suggested-by: John Harrison <john.c.harrison@intel.com>
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: stable@vger.kernel.org # v6.11+
Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 4e746ae98888..a196c4fb90fc 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -15,6 +15,7 @@
 #include "regs/xe_engine_regs.h"
 #include "regs/xe_gt_regs.h"
 #include "regs/xe_guc_regs.h"
+#include "regs/xe_oa_regs.h"
 #include "xe_bo.h"
 #include "xe_gt.h"
 #include "xe_gt_ccs_mode.h"
@@ -740,6 +741,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
 		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
 	}
 
+	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
+		guc_mmio_regset_write_one(ads, regset_map,
+					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
+					  count++);
+
 	/* Wa_1607983814 */
 	if (needs_wa_1607983814(xe) && hwe->class == XE_ENGINE_CLASS_RENDER) {
 		for (i = 0; i < LNCFCMOCS_REG_COUNT; i++) {
@@ -748,6 +754,14 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
 		}
 	}
 
+	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL0, count++);
+	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL1, count++);
+	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL2, count++);
+	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL3, count++);
+	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL4, count++);
+	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL5, count++);
+	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL6, count++);
+
 	return count;
 }
 
-- 
2.43.0


