Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D578ABA1
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjH1Kc7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjH1Kcs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC7198
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD24619F7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB66C433C9;
        Mon, 28 Aug 2023 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218698;
        bh=ZlHuRAIc8zumo+uHMSUIywOCqa6IBsvxCcXsxCuuMsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EObZcfDRkXesdBCZtsKYtwQ/07dquVv8laJTKVVk5d+l2lvlgOEF+koQn2otYOnVB
         ldAflcEO71mjypNuR0qxjh8TYSCozTDo29mHf9abMAKytRMICAYBz6IlEz4HGXHAwW
         iTqyrhrmbltvCCDW5lQqZVD5dPmJPbzwoB2KN6hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 023/122] drm/i915/gt: Support aux invalidation on all engines
Date:   Mon, 28 Aug 2023 12:12:18 +0200
Message-ID: <20230828101157.212000930@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Shyti <andi.shyti@linux.intel.com>

[ Upstream commit 6a35f22d222528e1b157c6978c9424d2f8cbe0a1 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 66 +++++++++++++-----------
 drivers/gpu/drm/i915/gt/gen8_engine_cs.h |  3 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c      | 17 +-----
 3 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 975e31d876b1a..cc84685368715 100644
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
@@ -277,11 +303,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 		cs = gen8_emit_pipe_control(cs, flags, LRC_PPHWSP_SCRATCH_ADDR);
 
-		if (gen12_needs_ccs_aux_inv(rq->engine)) {
-			/* hsdes: 1809175790 */
-			cs = gen12_emit_aux_table_inv(rq->engine->gt, cs,
-						      GEN12_CCS_AUX_INV);
-		}
+		cs = gen12_emit_aux_table_inv(engine, cs);
 
 		*cs++ = preparser_disable(false);
 		intel_ring_advance(rq, cs);
@@ -292,21 +314,14 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
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
@@ -337,14 +352,7 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
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
index e4d24c811dd61..651eb786e930c 100644
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
 __gen8_emit_pipe_control(u32 *batch, u32 flags0, u32 flags1, u32 offset)
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index 137e41e37ea54..7eb01ff17d89b 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1296,10 +1296,7 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	    IS_DG2_G11(ce->engine->i915))
 		cs = gen8_emit_pipe_control(cs, PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE, 0);
 
-	/* hsdes: 1809175790 */
-	if (!HAS_FLAT_CCS(ce->engine->i915))
-		cs = gen12_emit_aux_table_inv(ce->engine->gt,
-					      cs, GEN12_CCS_AUX_INV);
+	cs = gen12_emit_aux_table_inv(ce->engine, cs);
 
 	/* Wa_16014892111 */
 	if (IS_DG2(ce->engine->i915))
@@ -1322,17 +1319,7 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
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
-- 
2.40.1



