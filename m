Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688D375B4E4
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjGTQqE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGTQqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 12:46:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6E1B9
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689871563; x=1721407563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N1/f7eHpD3wncHsxl/HrkcBG8S0cn6TBumJQPowD3Pk=;
  b=BAHgu1cMN8GovgXG/oKlptXyLz00WEqINfKSHR8av3DJf9TC4XbaV2rw
   FVqNF7ZGWLcZ5N1qAg+aC226KmN2MOloveMEAM/31wQreI6TgYPDEBDj/
   iHSzLAVXINDWgA5kt+6cLYMmdzeAiBbIkbQfGwmcvUf9AXDl28YbQwXTW
   UrVj77qoVAAX3EOCHnTrU0P3coESFCYyOwUXJsrbPYdy7bloOsRvzeS/9
   zf9dAMfsnPIm7drEg3fu1O9l/NwsS4Pm3fprWtk/u8IC4QFa8Lx6ONzXu
   /uLozYu0wUMO3x+ZNOfyrD2X6FB4aPUws/+w89aK4UFlUBgVTNa759BpI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351680929"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="351680929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="754116028"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="754116028"
Received: from sdene1-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.32.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:45:52 -0700
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-evel <dri-devel@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v6 8/9] drm/i915/gt: Poll aux invalidation register bit on invalidation
Date:   Thu, 20 Jul 2023 18:44:53 +0200
Message-Id: <20230720164454.757075-9-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720164454.757075-1-andi.shyti@linux.intel.com>
References: <20230720164454.757075-1-andi.shyti@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonathan Cavitt <jonathan.cavitt@intel.com>

For platforms that use Aux CCS, wait for aux invalidation to
complete by checking the aux invalidation register bit is
cleared.

Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c     | 17 ++++++++++++-----
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 78bbd55262a2d..bedd1586c978f 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -172,7 +172,15 @@ u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv
 	*cs++ = MI_LOAD_REGISTER_IMM(1) | MI_LRI_MMIO_REMAP_EN;
 	*cs++ = i915_mmio_reg_offset(inv_reg) + gsi_offset;
 	*cs++ = AUX_INV;
-	*cs++ = MI_NOOP;
+
+	*cs++ = MI_SEMAPHORE_WAIT_TOKEN |
+		MI_SEMAPHORE_REGISTER_POLL |
+		MI_SEMAPHORE_POLL |
+		MI_SEMAPHORE_SAD_EQ_SDD;
+	*cs++ = 0;
+	*cs++ = i915_mmio_reg_offset(inv_reg) + gsi_offset;
+	*cs++ = 0;
+	*cs++ = 0;
 
 	return cs;
 }
@@ -282,10 +290,9 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 		else if (engine->class == COMPUTE_CLASS)
 			flags &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
 
+		count = 8;
 		if (HAS_AUX_CCS(rq->engine->i915))
-			count = 8 + 4;
-		else
-			count = 8;
+			count += 8;
 
 		cs = intel_ring_begin(rq, count);
 		if (IS_ERR(cs))
@@ -335,7 +342,7 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 		u32 bit_group_0 = 0;
 		u32 bit_group_1 = 0;
 
-		cmd += 4;
+		cmd += 8;
 
 		bit_group_0 |= PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
index 5df7cce23197c..2bd8d98d21102 100644
--- a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
+++ b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
@@ -121,6 +121,7 @@
 #define   MI_SEMAPHORE_TARGET(engine)	((engine)<<15)
 #define MI_SEMAPHORE_WAIT	MI_INSTR(0x1c, 2) /* GEN8+ */
 #define MI_SEMAPHORE_WAIT_TOKEN	MI_INSTR(0x1c, 3) /* GEN12+ */
+#define   MI_SEMAPHORE_REGISTER_POLL	(1 << 16)
 #define   MI_SEMAPHORE_POLL		(1 << 15)
 #define   MI_SEMAPHORE_SAD_GT_SDD	(0 << 12)
 #define   MI_SEMAPHORE_SAD_GTE_SDD	(1 << 12)
-- 
2.40.1

