Return-Path: <stable+bounces-33005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C988EA0F
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE5C29A1FE
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11312F5A2;
	Wed, 27 Mar 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fga2TmaG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BF12FB23
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555065; cv=none; b=RblmwkjV+c3/tXRSi+ctnxM+11qzBMcbqNNUI9puIj6UH6LfZviG1CC2osZXPY0k53VDb/IaIEwUrwBHy3IcMpvEi996pYnsM85FenGqgd+u8GvXDCQiDMqYBq7qMz/f4xtcWp7OfZQ/jbIJlnlGV0t8ixFlWX0MLB8yK49CybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555065; c=relaxed/simple;
	bh=SVSEbpnfo9jR/pyLP5sjcmm1mPcTxkJIQbjQMdwbd/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBNMq38SoY4oU+g1dVOG+PjHmM1hmLlnsbKvI06WsKvayq2v9f4S7r7vpWr/YPkX/JwsLGKXdBj7puDXT2NZhVHE/PC0AH2VKYVj/g/OTpcu8NIXVZA1PEQREZqPeTQtjajELLqcup/J72CW6pFOH7T+OOQPUkC4YosyKCbIhuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fga2TmaG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711555064; x=1743091064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVSEbpnfo9jR/pyLP5sjcmm1mPcTxkJIQbjQMdwbd/8=;
  b=fga2TmaGU5LA6chMWM6f1jPVQzvcnY8Prf8oLl2uNBLHzvkf8S1ffdgu
   ZayteVBM5pMcfOCqFwPjqobHoeSH0Mo/8VzfqVUOlNaj6Oftqpqe6m0bC
   ECycNckgOTM9LxCONRksEtNyOPGLXkVBtmjS0XSr9lq90CTDVUKwAmWr3
   FB2fCgB0fp5OCFkElMyScGfuDInn9ToQUf57wP+YfZfn44LxqwdzzAYyC
   pY16KHlwIkY+fo73M0ZOzaFJBJqB7BSMN8FnThzkfz2AZtpvKMgOIoJSn
   ykj8poCoBpAi7d7RrnUuVh+STKcwO1SUca65/r92TGcA9vhf3fNv21Tj8
   g==;
X-CSE-ConnectionGUID: QTDKMvoYSxKJMry10ZgOeA==
X-CSE-MsgGUID: P6JWC2zSRE+kE0MTtbx8Kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="7271794"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="7271794"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16787698"
Received: from unknown (HELO intel.com) ([10.247.118.215])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:57:37 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Michal Mrozek <michal.mrozek@intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v7 3/3] drm/i915/gt: Enable only one CCS for compute workload
Date: Wed, 27 Mar 2024 16:56:19 +0100
Message-ID: <20240327155622.538140-4-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327155622.538140-1-andi.shyti@linux.intel.com>
References: <20240327155622.538140-1-andi.shyti@linux.intel.com>
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
index 31b102604e3d..743fe3566722 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1480,6 +1480,11 @@
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
index 9963e5725ae5..8188c9f0b5ce 100644
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
@@ -2869,6 +2870,12 @@ static void ccs_engine_wa_mode(struct intel_engine_cs *engine, struct i915_wa_li
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


