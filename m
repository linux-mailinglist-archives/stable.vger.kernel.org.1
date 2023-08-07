Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9005A771B41
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjHGHL6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjHGHL5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694ECE78
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2A41615AC
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7CBC433C8;
        Mon,  7 Aug 2023 07:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392315;
        bh=mKvgneXDUkgGR47nNHNjo/jQW/5Ek2kXg9XQz7H0FM4=;
        h=Subject:To:Cc:From:Date:From;
        b=LFyBI6XJXIJqkGELvF1zUSvrM+vgxCnu/xVgANHofDFSyDddaWc+SUOv9vu/dkmds
         rtDwCvmjfqpHCJe2Mi69PnlFu5V1ekNALOFSX44fZF5Pl/5TMpX2dXfkyhBciC2yYN
         ayOyzhOlSjqO7uHI4yYrqpO7vCiiuOYishQa5MvE=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Support aux invalidation on all engines" failed to apply to 6.1-stable tree
To:     andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        jonathan.cavitt@intel.com, matthew.d.roper@intel.com,
        stable@vger.kernel.org, tvrtko.ursulin@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:11:35 +0200
Message-ID: <2023080734-ladder-viscous-30c9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6a35f22d222528e1b157c6978c9424d2f8cbe0a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080734-ladder-viscous-30c9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6a35f22d2225 ("drm/i915/gt: Support aux invalidation on all engines")
0fde2f23516a ("drm/i915/gt: Poll aux invalidation register bit on invalidation")
b2f59e902603 ("drm/i915: Add the gen12_needs_ccs_aux_inv helper")
d14560ac1b59 ("drm/i915/gt: Cleanup aux invalidation registers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a35f22d222528e1b157c6978c9424d2f8cbe0a1 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@linux.intel.com>
Date: Tue, 25 Jul 2023 02:19:50 +0200
Subject: [PATCH] drm/i915/gt: Support aux invalidation on all engines

Perform some refactoring with the purpose of keeping in one
single place all the operations around the aux table
invalidation.

With this refactoring add more engines where the invalidation
should be performed.

Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230725001950.1014671-8-andi.shyti@linux.intel.com
(cherry picked from commit 76ff7789d6e63d1a10b3b58f5c70b2e640c7a880)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index ec7a0ddf9e12..2702ad4c26c8 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -165,21 +165,47 @@ static u32 preparser_disable(bool state)
 	return MI_ARB_CHECK | 1 << 8 | state;
 }
 
+static i915_reg_t gen12_get_aux_inv_reg(struct intel_engine_cs *engine)
+{
+	switch (engine->id) {
+	case RCS0:
+		return GEN12_CCS_AUX_INV;
+	case BCS0:
+		return GEN12_BCS0_AUX_INV;
+	case VCS0:
+		return GEN12_VD0_AUX_INV;
+	case VCS2:
+		return GEN12_VD2_AUX_INV;
+	case VECS0:
+		return GEN12_VE0_AUX_INV;
+	case CCS0:
+		return GEN12_CCS0_AUX_INV;
+	default:
+		return INVALID_MMIO_REG;
+	}
+}
+
 static bool gen12_needs_ccs_aux_inv(struct intel_engine_cs *engine)
 {
+	i915_reg_t reg = gen12_get_aux_inv_reg(engine);
+
 	if (IS_PONTEVECCHIO(engine->i915))
 		return false;
 
 	/*
-	 * so far platforms supported by i915 having
-	 * flat ccs do not require AUX invalidation
+	 * So far platforms supported by i915 having flat ccs do not require
+	 * AUX invalidation. Check also whether the engine requires it.
 	 */
-	return !HAS_FLAT_CCS(engine->i915);
+	return i915_mmio_reg_valid(reg) && !HAS_FLAT_CCS(engine->i915);
 }
 
-u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv_reg)
+u32 *gen12_emit_aux_table_inv(struct intel_engine_cs *engine, u32 *cs)
 {
-	u32 gsi_offset = gt->uncore->gsi_offset;
+	i915_reg_t inv_reg = gen12_get_aux_inv_reg(engine);
+	u32 gsi_offset = engine->gt->uncore->gsi_offset;
+
+	if (!gen12_needs_ccs_aux_inv(engine))
+		return cs;
 
 	*cs++ = MI_LOAD_REGISTER_IMM(1) | MI_LRI_MMIO_REMAP_EN;
 	*cs++ = i915_mmio_reg_offset(inv_reg) + gsi_offset;
@@ -317,11 +343,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 		cs = gen8_emit_pipe_control(cs, flags, LRC_PPHWSP_SCRATCH_ADDR);
 
-		if (gen12_needs_ccs_aux_inv(rq->engine)) {
-			/* hsdes: 1809175790 */
-			cs = gen12_emit_aux_table_inv(rq->engine->gt, cs,
-						      GEN12_CCS_AUX_INV);
-		}
+		cs = gen12_emit_aux_table_inv(engine, cs);
 
 		*cs++ = preparser_disable(false);
 		intel_ring_advance(rq, cs);
@@ -332,21 +354,14 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 {
-	intel_engine_mask_t aux_inv = 0;
-	u32 cmd, *cs;
+	u32 cmd = 4;
+	u32 *cs;
 
-	cmd = 4;
 	if (mode & EMIT_INVALIDATE) {
 		cmd += 2;
 
-		if (gen12_needs_ccs_aux_inv(rq->engine) &&
-		    (rq->engine->class == VIDEO_DECODE_CLASS ||
-		     rq->engine->class == VIDEO_ENHANCEMENT_CLASS)) {
-			aux_inv = rq->engine->mask &
-				~GENMASK(_BCS(I915_MAX_BCS - 1), BCS0);
-			if (aux_inv)
-				cmd += 8;
-		}
+		if (gen12_needs_ccs_aux_inv(rq->engine))
+			cmd += 8;
 	}
 
 	cs = intel_ring_begin(rq, cmd);
@@ -381,14 +396,7 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 	*cs++ = 0; /* upper addr */
 	*cs++ = 0; /* value */
 
-	if (aux_inv) { /* hsdes: 1809175790 */
-		if (rq->engine->class == VIDEO_DECODE_CLASS)
-			cs = gen12_emit_aux_table_inv(rq->engine->gt,
-						      cs, GEN12_VD0_AUX_INV);
-		else
-			cs = gen12_emit_aux_table_inv(rq->engine->gt,
-						      cs, GEN12_VE0_AUX_INV);
-	}
+	cs = gen12_emit_aux_table_inv(rq->engine, cs);
 
 	if (mode & EMIT_INVALIDATE)
 		*cs++ = preparser_disable(false);
diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.h b/drivers/gpu/drm/i915/gt/gen8_engine_cs.h
index a44eda096557..867ba697aceb 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.h
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.h
@@ -13,6 +13,7 @@
 #include "intel_gt_regs.h"
 #include "intel_gpu_commands.h"
 
+struct intel_engine_cs;
 struct intel_gt;
 struct i915_request;
 
@@ -46,7 +47,7 @@ u32 *gen8_emit_fini_breadcrumb_rcs(struct i915_request *rq, u32 *cs);
 u32 *gen11_emit_fini_breadcrumb_rcs(struct i915_request *rq, u32 *cs);
 u32 *gen12_emit_fini_breadcrumb_rcs(struct i915_request *rq, u32 *cs);
 
-u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv_reg);
+u32 *gen12_emit_aux_table_inv(struct intel_engine_cs *engine, u32 *cs);
 
 static inline u32 *
 __gen8_emit_pipe_control(u32 *batch, u32 bit_group_0,
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index 325f3dbfb90e..9477c2422321 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1364,10 +1364,7 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	    IS_DG2_G11(ce->engine->i915))
 		cs = gen8_emit_pipe_control(cs, PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE, 0);
 
-	/* hsdes: 1809175790 */
-	if (!HAS_FLAT_CCS(ce->engine->i915))
-		cs = gen12_emit_aux_table_inv(ce->engine->gt,
-					      cs, GEN12_CCS_AUX_INV);
+	cs = gen12_emit_aux_table_inv(ce->engine, cs);
 
 	/* Wa_16014892111 */
 	if (IS_MTL_GRAPHICS_STEP(ce->engine->i915, M, STEP_A0, STEP_B0) ||
@@ -1392,17 +1389,7 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
 						    PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE,
 						    0);
 
-	/* hsdes: 1809175790 */
-	if (!HAS_FLAT_CCS(ce->engine->i915)) {
-		if (ce->engine->class == VIDEO_DECODE_CLASS)
-			cs = gen12_emit_aux_table_inv(ce->engine->gt,
-						      cs, GEN12_VD0_AUX_INV);
-		else if (ce->engine->class == VIDEO_ENHANCEMENT_CLASS)
-			cs = gen12_emit_aux_table_inv(ce->engine->gt,
-						      cs, GEN12_VE0_AUX_INV);
-	}
-
-	return cs;
+	return gen12_emit_aux_table_inv(ce->engine, cs);
 }
 
 static void

