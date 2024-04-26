Return-Path: <stable+bounces-41484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71EA8B2DD8
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 02:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD701F22451
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C0197;
	Fri, 26 Apr 2024 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7Ol7aN9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77EA364
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090068; cv=none; b=STnmotEOT4F6zpGUikqJ85PZZBAJowidOK61mSWaHLnIAEqAPYS9dddot5/i07FV3nCope/sayglqvXNqdVI+IeUcs57PAZRTk84Y8cRCofovibKxFMqHdgxCWpfpg71ISGqaO5kcIvoF9v0uBLb04S9QVnBDmuCXtwsA7ceE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090068; c=relaxed/simple;
	bh=XtSlt0teFWDksW/dP9m8HCNwWZgKnucmsYyYs43Q4EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TErrA1MHUCL8NvI00Om0L77gcSFFMT3DW9g1jwPPLeoaT/QfxnfkrbGJP3itgiUu35LXpqImTnkNXHE7WxMWIMdGNkn6sDZtWDoIdjm5GC1cz4JX3hqWZNdN9hPT3zvWumJhXjxU1PhYKMv/HiJb/lWh/80B6sPDY7WzSLcKGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7Ol7aN9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714090066; x=1745626066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XtSlt0teFWDksW/dP9m8HCNwWZgKnucmsYyYs43Q4EM=;
  b=U7Ol7aN9AOBaFayZFqtLE/BwpNH63RSRD/kO3GwHgev3ov6Cn4pxiRbe
   jby4mLB25eYsHKYD5GSjVcxgkJ+owFauzG30dxOow5Bp9jpb4fsE0DG8X
   dgBWzOYxBZZWFp0G1DawwblKWgWiupX55YqjucM+A5qWWJZHLfj64k6u5
   4t/cURJh+SpbqmKwHa5dZkb5Y+mioT+4f7d4eRpLkwZ61Yf852sNKgss3
   0d3MC24AMGKzhk3c8FB3O50h6l4MS+j4NS4r8qu00W4H3sL9o54X2K8pz
   jE1rB1U9aJ3Zm1s4iI0Gi1HbEvyTX7xT6cI1Lm7ojJRW6TuyilLHlPX6Q
   Q==;
X-CSE-ConnectionGUID: 2A/md62YR7O900ypwSdeZg==
X-CSE-MsgGUID: hbyEHddcRxGDp6z6+FQPLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9667709"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9667709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:07:45 -0700
X-CSE-ConnectionGUID: L2vEjMhKRgOsP9LQnA6dhw==
X-CSE-MsgGUID: IjGUGYI0Th+akFO0osIOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="56187921"
Received: from unknown (HELO intel.com) ([10.247.119.93])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:07:39 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Gnattu OC <gnattuoc@me.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Automate CCS Mode setting during engine resets
Date: Fri, 26 Apr 2024 02:07:23 +0200
Message-ID: <20240426000723.229296-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We missed setting the CCS mode during resume and engine resets.
Create a workaround to be added in the engine's workaround list.
This workaround sets the XEHP_CCS_MODE value at every reset.

The issue can be reproduced by running:

  $ clpeak --kernel-latency

Without resetting the CCS mode, we encounter a fence timeout:

  Fence expiration time out i915-0000:03:00.0:clpeak[2387]:2!

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/10895
Fixes: 6db31251bb26 ("drm/i915/gt: Enable only one CCS for compute workload")
Reported-by: Gnattu OC <gnattuoc@me.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
---
Hi Gnattu,

thanks again for reporting this issue and for your prompt
replies on the issue. Would you give this patch a chance?

Andi

 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c | 6 +++---
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h | 2 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
index 044219c5960a..99b71bb7da0a 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
@@ -8,14 +8,14 @@
 #include "intel_gt_ccs_mode.h"
 #include "intel_gt_regs.h"
 
-void intel_gt_apply_ccs_mode(struct intel_gt *gt)
+unsigned int intel_gt_apply_ccs_mode(struct intel_gt *gt)
 {
 	int cslice;
 	u32 mode = 0;
 	int first_ccs = __ffs(CCS_MASK(gt));
 
 	if (!IS_DG2(gt->i915))
-		return;
+		return 0;
 
 	/* Build the value for the fixed CCS load balancing */
 	for (cslice = 0; cslice < I915_MAX_CCS; cslice++) {
@@ -35,5 +35,5 @@ void intel_gt_apply_ccs_mode(struct intel_gt *gt)
 						     XEHP_CCS_MODE_CSLICE_MASK);
 	}
 
-	intel_uncore_write(gt->uncore, XEHP_CCS_MODE, mode);
+	return mode;
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h
index 9e5549caeb26..55547f2ff426 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h
@@ -8,6 +8,6 @@
 
 struct intel_gt;
 
-void intel_gt_apply_ccs_mode(struct intel_gt *gt);
+unsigned int intel_gt_apply_ccs_mode(struct intel_gt *gt);
 
 #endif /* __INTEL_GT_CCS_MODE_H__ */
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 68b6aa11bcf7..58693923bf6c 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2703,6 +2703,7 @@ add_render_compute_tuning_settings(struct intel_gt *gt,
 static void ccs_engine_wa_mode(struct intel_engine_cs *engine, struct i915_wa_list *wal)
 {
 	struct intel_gt *gt = engine->gt;
+	u32 mode;
 
 	if (!IS_DG2(gt->i915))
 		return;
@@ -2719,7 +2720,8 @@ static void ccs_engine_wa_mode(struct intel_engine_cs *engine, struct i915_wa_li
 	 * After having disabled automatic load balancing we need to
 	 * assign all slices to a single CCS. We will call it CCS mode 1
 	 */
-	intel_gt_apply_ccs_mode(gt);
+	mode = intel_gt_apply_ccs_mode(gt);
+	wa_masked_en(wal, XEHP_CCS_MODE, mode);
 }
 
 /*
-- 
2.43.0


