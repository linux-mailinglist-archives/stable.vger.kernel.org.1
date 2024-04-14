Return-Path: <stable+bounces-37397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7797289C4AE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0CD1C21099
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE17BB0F;
	Mon,  8 Apr 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lT/Ee0z4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1747BAEE;
	Mon,  8 Apr 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584112; cv=none; b=GYEpdWjAhqRNB0Sr3PUYMauiiUrx7mRYE/pYBDcTqXGFOwPeIyYHHXd+muD4UgCscXbANurG5+HFPldLL3F7d4qOVTOiSbYYM5wipGJ1GE3znJmWBM2Q68gGZwva4qrGvyjBRQCG/GVfA1OJPycBkqnPVc7++CmPH5/r5L9EkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584112; c=relaxed/simple;
	bh=sMWnnV2oqDgLNThvj4YPL6J4HWwNYPhnHM0sb0Fdtos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbZNMugR82gkSp+CkDNIRNodk3YALHZIZ8jngJ+Djj73xbOroE+g0tepNtczAZ3ZhqyOoe9Qq/Dl0PtEDyqF48d/xgX53TqVSJPvsQiM3YzsXSvBy6qvzYzgXnyqPUZZ7JCVjEJNUBtK3O0CDvEbuUdZYvaRBEtrssN3DzYTn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lT/Ee0z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364B6C433F1;
	Mon,  8 Apr 2024 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584112;
	bh=sMWnnV2oqDgLNThvj4YPL6J4HWwNYPhnHM0sb0Fdtos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lT/Ee0z44kvVpqGy6RrYHienLoe5l5iQ5ZkwnNM3oAvuQo9CdFSyy4wN9z4CfMXHj
	 8SHlj7fuZt5BN7ADD8c0YKsMDlNAJAv1vzDT4cSrI0XWEBBoOspECFDqjn9h8aWJON
	 h/4H6Q4pNYWXFTEUuCalDYNfROYLFoqLqevEtIcE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.8 263/273] drm/i915/gt: Enable only one CCS for compute workload
Date: Mon,  8 Apr 2024 14:58:58 +0200
Message-ID: <20240408125317.660155889@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Shyti <andi.shyti@linux.intel.com>

commit 6db31251bb265813994bfb104eb4b4d0f44d64fb upstream.

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
Link: https://patchwork.freedesktop.org/patch/msgid/20240328073409.674098-4-andi.shyti@linux.intel.com
(cherry picked from commit 2bebae0112b117de7e8a7289277a4bd2403b9e17)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/Makefile               |    1 
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c |   39 ++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h |   13 +++++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |    5 +++
 drivers/gpu/drm/i915/gt/intel_workarounds.c |    7 +++++
 5 files changed, 65 insertions(+)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h

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
@@ -2865,6 +2866,12 @@ static void ccs_engine_wa_mode(struct in
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



