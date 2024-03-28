Return-Path: <stable+bounces-33055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEAA88F8D8
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 08:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D950A2961C1
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 07:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429775102E;
	Thu, 28 Mar 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQPvj5yl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DB3DABF3
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611285; cv=none; b=NwWutqoNkvDBRK7V3L94iC4BFeuHJ/lz+yT5y56GIL3FRBwxIVILYPi7wIQmUseTDIgTIWU+rhdJrga0J0yhWZ2SU90FfMooK491yUL9jHWb82Fxyfe36N2tcwKr9EzV0lOGZ3FUN7GOuaI4Qq+USQ/r8awl07p2BwSx4xUzCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611285; c=relaxed/simple;
	bh=FKFKB6LJTj+6J253br0KzH504xeh2FZb6AMT/Xm7ae4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2HoJQYok1iVVqTO2QFWP6VBn/VU1uaNAzEu9IK2B0iXgE2WnenKLWtlkLflSDZQ0cJALZaLO59Lugg0GVzQ1GHynH+qIuJH0n/jJj6W3XWV8RiAYKSVvvO6UL4saC3b5Qkmz4v8czX14STwko3jYYnDAQXaghi2aIvzpqneLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQPvj5yl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711611283; x=1743147283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FKFKB6LJTj+6J253br0KzH504xeh2FZb6AMT/Xm7ae4=;
  b=XQPvj5yl9WEOXWoDK+8EoSSP6+JnaJfKCFG5cuqQjqPI0Z9LbKTVCQvW
   ZrMqfiHgjO62W+9sk62I5V/SZExeyJ2/g9MH4pWxFymHYScXOGlR7TSHZ
   ntpQo7TYUm9d+TefSU3P7QtWO6HZzj70+ksz6ci9Sb+1l18gi2RMTwfaW
   nppnCF+Wxu72ZheJ5ZWsPABXU2YenKKv+6dexAqQk+SdrxBUeunaolroy
   SrUbhXMnon2tMQ32wG+KnrjJnwPD7N8Jn/ALARQghO30tMmIHtGNHIztd
   9wI2J+WfKT/StJge4ijLgy2wXldXTxuusWC2vKGEszguzHsp09EkR/VUE
   w==;
X-CSE-ConnectionGUID: gFM1AswMQvqL+JMdNy0qqQ==
X-CSE-MsgGUID: Y3pFiZVcSWugdFNihHl2GQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6640588"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6640588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="47763959"
Received: from unknown (HELO intel.com) ([10.247.118.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:34:36 -0700
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
Subject: [PATCH v8 1/3] drm/i915/gt: Disable HW load balancing for CCS
Date: Thu, 28 Mar 2024 08:34:03 +0100
Message-ID: <20240328073409.674098-2-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328073409.674098-1-andi.shyti@linux.intel.com>
References: <20240328073409.674098-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware should not dynamically balance the load between CCS
engines. Wa_14019159160 recommends disabling it across all
platforms.

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  1 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 23 +++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 731ed3ecd9a6..f8829be40199 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1424,6 +1424,7 @@
 #define   ECOBITS_PPGTT_CACHE4B			(0 << 8)
 
 #define GEN12_RCU_MODE				_MMIO(0x14800)
+#define   XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE	REG_BIT(1)
 #define   GEN12_RCU_MODE_CCS_ENABLE		REG_BIT(0)
 
 #define CHV_FUSE_GT				_MMIO(VLV_GUNIT_BASE + 0x2168)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index de5fe26bb18e..74cf678b7589 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -51,7 +51,8 @@
  *   registers belonging to BCS, VCS or VECS should be implemented in
  *   xcs_engine_wa_init(). Workarounds for registers not belonging to a specific
  *   engine's MMIO range but that are part of of the common RCS/CCS reset domain
- *   should be implemented in general_render_compute_wa_init().
+ *   should be implemented in general_render_compute_wa_init(). The settings
+ *   about the CCS load balancing should be added in ccs_engine_wa_mode().
  *
  * - GT workarounds: the list of these WAs is applied whenever these registers
  *   revert to their default values: on GPU reset, suspend/resume [1]_, etc.
@@ -2698,6 +2699,22 @@ add_render_compute_tuning_settings(struct intel_gt *gt,
 		wa_write_clr(wal, GEN8_GARBCNTL, GEN12_BUS_HASH_CTL_BIT_EXC);
 }
 
+static void ccs_engine_wa_mode(struct intel_engine_cs *engine, struct i915_wa_list *wal)
+{
+	struct intel_gt *gt = engine->gt;
+
+	if (!IS_DG2(gt->i915))
+		return;
+
+	/*
+	 * Wa_14019159160: This workaround, along with others, leads to
+	 * significant challenges in utilizing load balancing among the
+	 * CCS slices. Consequently, an architectural decision has been
+	 * made to completely disable automatic CCS load balancing.
+	 */
+	wa_masked_en(wal, GEN12_RCU_MODE, XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE);
+}
+
 /*
  * The workarounds in this function apply to shared registers in
  * the general render reset domain that aren't tied to a
@@ -2830,8 +2847,10 @@ engine_init_workarounds(struct intel_engine_cs *engine, struct i915_wa_list *wal
 	 * to a single RCS/CCS engine's workaround list since
 	 * they're reset as part of the general render domain reset.
 	 */
-	if (engine->flags & I915_ENGINE_FIRST_RENDER_COMPUTE)
+	if (engine->flags & I915_ENGINE_FIRST_RENDER_COMPUTE) {
 		general_render_compute_wa_init(engine, wal);
+		ccs_engine_wa_mode(engine, wal);
+	}
 
 	if (engine->class == COMPUTE_CLASS)
 		ccs_engine_wa_init(engine, wal);
-- 
2.43.0


