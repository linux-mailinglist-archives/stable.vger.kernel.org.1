Return-Path: <stable+bounces-33003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B188EA04
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E39D1C2FC0F
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447CE12DDAD;
	Wed, 27 Mar 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpP+sIYE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD112FB0E
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555038; cv=none; b=YxpkbXeS/B8+oAHM56EW61ltWZ2gr5CsjRVLJmvhllyCYCVBR+oFDTWbhuf5k4iVmqimHOJTOQ+xZ9FYw00M5ETNS3O5EifxMm6Ksf9rCsVeIGa8LUQKC9y8IRMW4nThm3jqI2n+GRgfRUj7h9wLEpCmUC/Gm8YHx5/opEvjXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555038; c=relaxed/simple;
	bh=NcYUa5H9OhtOPTzdqOxiIjhrbGUI6lmFfgm3D7rltBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC7/h0GCKMpvUO70lmJ9reLoAcPg4n/50uMZiaInTwUV5vti7deEnf03EaG6wHfLwznuAfMSmk0jMOLXNLdjYDCk+bhP0Le89Vq5QBRyXR4wXCDSPti8JDAA6m2J1Dx+iYfdBjQJq0+4Bp7K3gB0VEmOTEcYG4/zaYWDR4tmyB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpP+sIYE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711555037; x=1743091037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NcYUa5H9OhtOPTzdqOxiIjhrbGUI6lmFfgm3D7rltBU=;
  b=hpP+sIYEHUW+quxkL+MyxYAn5pu43isNy0OoGHjiibFuFJ+mVEOhmMeK
   p2Z9tSpJ/X0lbcjAqFmuiRGF+wgX510R6+Cyt5+ybfqf0GpUTgzmR6Hyy
   VRW01O9jIqFGh2uOqd1lQNXAUO/1VGb7Y+awuDLSUcoQBjCZ4ZcHKs5yk
   eVGZnfHzRtD2G5aZXcBZyVK2hyglUitY0WHX+fKgeBpY6V3DBdvvz+uDe
   LCgXGAUUCMNqpDRfdtAZivO+EvzFz9fDAVf9vPAvNTBOes6UkPHQrC1sH
   zu3hESJn1A+rB0xnRar4G+ywkxohX8KcDa/+WIBVwwErin8k5yCZIjDmT
   A==;
X-CSE-ConnectionGUID: UiRpU5HeSU6fCe+7wNclag==
X-CSE-MsgGUID: 5+JQsIT1RY+Ea50rmfLmfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6491656"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6491656"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:57:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16388193"
Received: from unknown (HELO intel.com) ([10.247.118.215])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:57:08 -0700
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
Subject: [PATCH v7 1/3] drm/i915/gt: Disable HW load balancing for CCS
Date: Wed, 27 Mar 2024 16:56:17 +0100
Message-ID: <20240327155622.538140-2-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327155622.538140-1-andi.shyti@linux.intel.com>
References: <20240327155622.538140-1-andi.shyti@linux.intel.com>
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
index 50962cfd1353..31b102604e3d 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1477,6 +1477,7 @@
 #define   ECOBITS_PPGTT_CACHE4B			(0 << 8)
 
 #define GEN12_RCU_MODE				_MMIO(0x14800)
+#define   XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE	REG_BIT(1)
 #define   GEN12_RCU_MODE_CCS_ENABLE		REG_BIT(0)
 
 #define CHV_FUSE_GT				_MMIO(VLV_GUNIT_BASE + 0x2168)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index b079cbbc1897..9963e5725ae5 100644
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
@@ -2854,6 +2855,22 @@ add_render_compute_tuning_settings(struct intel_gt *gt,
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
@@ -3000,8 +3017,10 @@ engine_init_workarounds(struct intel_engine_cs *engine, struct i915_wa_list *wal
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


