Return-Path: <stable+bounces-33057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36ED88F8DE
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 08:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51C81C2788D
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2450279;
	Thu, 28 Mar 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PH7x8DOf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050F3DABF3
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611312; cv=none; b=VxTksi896sSnc9+pbJJoMhBwCTAUcs5dwoXFb6V33wLGyjPIYuRvI2SSLbEb0MzqrzaS9Po0gJeCNosulC+4ShpczbKoUzYJWokzcPaDyJ7gHcbRTvHulsdeN6HVYjEDRig8tLuWKVgbagJcf7I6GqtwCG49IFaMFwd6pplseu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611312; c=relaxed/simple;
	bh=k8Ql+VLU1en2pJZ1eYsJpuDGO5FG0FeYjxlH+JUGc08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Th6mQe3WoJzR4oLfFcnqcEI4WxhPwjU//m1+rs9QKhPt/xy8qA/ssdQutxHFKR84AKp+RF/KqDYVSlmZ/ZL8eFKvydJeOANKa2pBDWA00jX7kq2gF672JZBcvkT/sNH2MBM7ctxTcBHt22gQMm9Z8BK5+2Glhib8ge1jQjTHcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PH7x8DOf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711611311; x=1743147311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8Ql+VLU1en2pJZ1eYsJpuDGO5FG0FeYjxlH+JUGc08=;
  b=PH7x8DOf1jefUXoPl0b8Rj5yex2x5/VWYEqN0M1levzQb0uyw7vR1KUs
   3lCMefZ01KEXufMzkh+VTPQAVJZ7Bc9vavfhmmmELJC0G6+RugEgaQ0ip
   Smb74P0zECxoRpSt6Aq4IEKaNe5kpo+hnl0jpz7cCUNyPdASxLZPmjnf8
   2U2xoJt4AUp5R7Q395V9g2GWYJtxY+xWmOrVnuVOkAURtnXTYUauS2wV0
   kBXlBGYB7dThfUybxeb08L3+FE43L0MsCmgGNT3EcUQEUopLsAkL0KO1w
   RloZHLQwG00KQXLWtVkznpzwPr/v/cDm+3Z83Ay5IJGrEmGL8RXkLSz8S
   Q==;
X-CSE-ConnectionGUID: OusrwMuCRx2pfljyTHtEcg==
X-CSE-MsgGUID: V3gT2U0aQkKyC79C7LH18Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10555573"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="10555573"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="16568639"
Received: from unknown (HELO intel.com) ([10.247.118.221])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:35:03 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH v8 3/3] drm/i915/gt: Enable only one CCS for compute workload
Date: Thu, 28 Mar 2024 08:34:05 +0100
Message-ID: <20240328073409.674098-4-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328073409.674098-1-andi.shyti@linux.intel.com>
References: <20240328073409.674098-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable only one CCS engine by default with all the compute sices
allocated to it.

While generating the list of UABI engines to be exposed to the
user, exclude any additional CCS engines beyond the first
instance.

This change can be tested with igt i915_query.

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
---
 drivers/gpu/drm/i915/Makefile               |  1 +
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c | 39 +++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h | 13 +++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  5 +++
 drivers/gpu/drm/i915/gt/intel_workarounds.c |  7 ++++
 5 files changed, 65 insertions(+)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 3ef6ed41e62b..a6885a1d41a1 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -118,6 +118,7 @@ gt-y += \
 	gt/intel_ggtt_fencing.o \
 	gt/intel_gt.o \
 	gt/intel_gt_buffer_pool.o \
+	gt/intel_gt_ccs_mode.o \
 	gt/intel_gt_clock_utils.o \
 	gt/intel_gt_debugfs.o \
 	gt/intel_gt_engines_debugfs.o \
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
new file mode 100644
index 000000000000..044219c5960a
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2024 Intel Corporation
+ */
+
+#include "i915_drv.h"
+#include "intel_gt.h"
+#include "intel_gt_ccs_mode.h"
+#include "intel_gt_regs.h"
+
+void intel_gt_apply_ccs_mode(struct intel_gt *gt)
+{
+	int cslice;
+	u32 mode = 0;
+	int first_ccs = __ffs(CCS_MASK(gt));
+
+	if (!IS_DG2(gt->i915))
+		return;
+
+	/* Build the value for the fixed CCS load balancing */
+	for (cslice = 0; cslice < I915_MAX_CCS; cslice++) {
+		if (CCS_MASK(gt) & BIT(cslice))
+			/*
+			 * If available, assign the cslice
+			 * to the first available engine...
+			 */
+			mode |= XEHP_CCS_MODE_CSLICE(cslice, first_ccs);
+
+		else
+			/*
+			 * ... otherwise, mark the cslice as
+			 * unavailable if no CCS dispatches here
+			 */
+			mode |= XEHP_CCS_MODE_CSLICE(cslice,
+						     XEHP_CCS_MODE_CSLICE_MASK);
+	}
+
+	intel_uncore_write(gt->uncore, XEHP_CCS_MODE, mode);
+}
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h
new file mode 100644
index 000000000000..9e5549caeb26
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2024 Intel Corporation
+ */
+
+#ifndef __INTEL_GT_CCS_MODE_H__
+#define __INTEL_GT_CCS_MODE_H__
+
+struct intel_gt;
+
+void intel_gt_apply_ccs_mode(struct intel_gt *gt);
+
+#endif /* __INTEL_GT_CCS_MODE_H__ */
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index f8829be40199..e42b3a5d4e63 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1427,6 +1427,11 @@
 #define   XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE	REG_BIT(1)
 #define   GEN12_RCU_MODE_CCS_ENABLE		REG_BIT(0)
 
+#define XEHP_CCS_MODE				_MMIO(0x14804)
+#define   XEHP_CCS_MODE_CSLICE_MASK		REG_GENMASK(2, 0) /* CCS0-3 + rsvd */
+#define   XEHP_CCS_MODE_CSLICE_WIDTH		ilog2(XEHP_CCS_MODE_CSLICE_MASK + 1)
+#define   XEHP_CCS_MODE_CSLICE(cslice, ccs)	(ccs << (cslice * XEHP_CCS_MODE_CSLICE_WIDTH))
+
 #define CHV_FUSE_GT				_MMIO(VLV_GUNIT_BASE + 0x2168)
 #define   CHV_FGT_DISABLE_SS0			(1 << 10)
 #define   CHV_FGT_DISABLE_SS1			(1 << 11)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 74cf678b7589..68b6aa11bcf7 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -10,6 +10,7 @@
 #include "intel_engine_regs.h"
 #include "intel_gpu_commands.h"
 #include "intel_gt.h"
+#include "intel_gt_ccs_mode.h"
 #include "intel_gt_mcr.h"
 #include "intel_gt_print.h"
 #include "intel_gt_regs.h"
@@ -2713,6 +2714,12 @@ static void ccs_engine_wa_mode(struct intel_engine_cs *engine, struct i915_wa_li
 	 * made to completely disable automatic CCS load balancing.
 	 */
 	wa_masked_en(wal, GEN12_RCU_MODE, XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE);
+
+	/*
+	 * After having disabled automatic load balancing we need to
+	 * assign all slices to a single CCS. We will call it CCS mode 1
+	 */
+	intel_gt_apply_ccs_mode(gt);
 }
 
 /*
-- 
2.43.0


