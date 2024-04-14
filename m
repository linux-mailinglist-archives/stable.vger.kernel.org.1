Return-Path: <stable+bounces-36607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40289C099
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87521F21CC9
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200ED70CCB;
	Mon,  8 Apr 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mf4VuM0U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27916F08E;
	Mon,  8 Apr 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581820; cv=none; b=aZSAHLLP0C+/TmXqRSzJQrN7YuPOdEiIPfl7DcyJPXmo55GxcZxAwgInoFKdt2PL3i37YEvdI2Ehf9+YxMbM2ym5+soiFydgNYZXORkiuGhm+CILNZz2u+pjo5A1FB5QkSYExhKD/LiyAGpU/l0JBLujnz5hg2Yaejzp8PBcrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581820; c=relaxed/simple;
	bh=JI2ij18zujxj3ZF32qWFG1kYL3T/jyWAkJgsx4Vg+zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JStx4ru0jvsjK0NK4yI/pKK7zBwCPziGRqIA7NHJDPP7As+yTqaetxpuFLi7LYvFUnFAP4YO9674ige3zUUSpnSJ5Nf9projc/suw+hhUBMQfKIAnRlRZUenY7g1Re/A1gsDDOKi4dZL4vWtJ24j62a7GebDeYsM3cMRiNnl0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mf4VuM0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAD6C433F1;
	Mon,  8 Apr 2024 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581820;
	bh=JI2ij18zujxj3ZF32qWFG1kYL3T/jyWAkJgsx4Vg+zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mf4VuM0U+8B9QBXz/q0fHugsYX9RIBuWkbC+dw68O1KBpyN9dh7sUnIk6VsQ4K7f1
	 ihCLcl0UMUPTYjVjSKfV5CxT2a1kKfubUxM0qJcrYmgAoFlVcqfv82ejuZEzKpcLoW
	 U2lFea5TzbHvbgmb0ivOvnI7VOTTbSLfeNHVbRCU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Roper <matthew.d.roper@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 042/252] drm/i915/dg2: Drop pre-production GT workarounds
Date: Mon,  8 Apr 2024 14:55:41 +0200
Message-ID: <20240408125307.945128592@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Roper <matthew.d.roper@intel.com>

[ Upstream commit eaeb4b3614529bfa8a7edfdd7ecf6977b27f18b2 ]

DG2 first production steppings were C0 (for DG2-G10), B1 (for DG2-G11),
and A1 (for DG2-G12).  Several workarounds that apply onto to
pre-production hardware can be dropped.  Furthermore, several
workarounds that apply to all production steppings can have their
conditions simplified to no longer check the GT stepping.

v2:
 - Keep Wa_16011777198 in place for now; it will be removed separately
   in a follow-up patch to keep review easier.

Bspec: 44477
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Matt Atwood <matthew.s.atwood@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230816214201.534095-10-matthew.d.roper@intel.com
Stable-dep-of: 186bce682772 ("drm/i915/mtl: Update workaround 14018575942")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_lrc.c         |  34 +---
 drivers/gpu/drm/i915/gt/intel_mocs.c        |  21 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c         |   6 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 211 +-------------------
 drivers/gpu/drm/i915/gt/uc/intel_guc.c      |  20 +-
 drivers/gpu/drm/i915/intel_clock_gating.c   |   8 -
 6 files changed, 21 insertions(+), 279 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index c378cc7c953c4..f297c5808e7c8 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1316,29 +1316,6 @@ gen12_emit_cmd_buf_wa(const struct intel_context *ce, u32 *cs)
 	return cs;
 }
 
-/*
- * On DG2 during context restore of a preempted context in GPGPU mode,
- * RCS restore hang is detected. This is extremely timing dependent.
- * To address this below sw wabb is implemented for DG2 A steppings.
- */
-static u32 *
-dg2_emit_rcs_hang_wabb(const struct intel_context *ce, u32 *cs)
-{
-	*cs++ = MI_LOAD_REGISTER_IMM(1);
-	*cs++ = i915_mmio_reg_offset(GEN12_STATE_ACK_DEBUG(ce->engine->mmio_base));
-	*cs++ = 0x21;
-
-	*cs++ = MI_LOAD_REGISTER_REG;
-	*cs++ = i915_mmio_reg_offset(RING_NOPID(ce->engine->mmio_base));
-	*cs++ = i915_mmio_reg_offset(XEHP_CULLBIT1);
-
-	*cs++ = MI_LOAD_REGISTER_REG;
-	*cs++ = i915_mmio_reg_offset(RING_NOPID(ce->engine->mmio_base));
-	*cs++ = i915_mmio_reg_offset(XEHP_CULLBIT2);
-
-	return cs;
-}
-
 /*
  * The bspec's tuning guide asks us to program a vertical watermark value of
  * 0x3FF.  However this register is not saved/restored properly by the
@@ -1363,14 +1340,8 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	cs = gen12_emit_cmd_buf_wa(ce, cs);
 	cs = gen12_emit_restore_scratch(ce, cs);
 
-	/* Wa_22011450934:dg2 */
-	if (IS_DG2_GRAPHICS_STEP(ce->engine->i915, G10, STEP_A0, STEP_B0) ||
-	    IS_DG2_GRAPHICS_STEP(ce->engine->i915, G11, STEP_A0, STEP_B0))
-		cs = dg2_emit_rcs_hang_wabb(ce, cs);
-
 	/* Wa_16013000631:dg2 */
-	if (IS_DG2_GRAPHICS_STEP(ce->engine->i915, G10, STEP_B0, STEP_C0) ||
-	    IS_DG2_G11(ce->engine->i915))
+	if (IS_DG2_G11(ce->engine->i915))
 		cs = gen8_emit_pipe_control(cs, PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE, 0);
 
 	cs = gen12_emit_aux_table_inv(ce->engine, cs);
@@ -1391,8 +1362,7 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
 	cs = gen12_emit_restore_scratch(ce, cs);
 
 	/* Wa_16013000631:dg2 */
-	if (IS_DG2_GRAPHICS_STEP(ce->engine->i915, G10, STEP_B0, STEP_C0) ||
-	    IS_DG2_G11(ce->engine->i915))
+	if (IS_DG2_G11(ce->engine->i915))
 		if (ce->engine->class == COMPUTE_CLASS)
 			cs = gen8_emit_pipe_control(cs,
 						    PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE,
diff --git a/drivers/gpu/drm/i915/gt/intel_mocs.c b/drivers/gpu/drm/i915/gt/intel_mocs.c
index 2c014407225cc..bf8b42d2d3279 100644
--- a/drivers/gpu/drm/i915/gt/intel_mocs.c
+++ b/drivers/gpu/drm/i915/gt/intel_mocs.c
@@ -404,18 +404,6 @@ static const struct drm_i915_mocs_entry dg2_mocs_table[] = {
 	MOCS_ENTRY(3, 0, L3_3_WB | L3_LKUP(1)),
 };
 
-static const struct drm_i915_mocs_entry dg2_mocs_table_g10_ax[] = {
-	/* Wa_14011441408: Set Go to Memory for MOCS#0 */
-	MOCS_ENTRY(0, 0, L3_1_UC | L3_GLBGO(1) | L3_LKUP(1)),
-	/* UC - Coherent; GO:Memory */
-	MOCS_ENTRY(1, 0, L3_1_UC | L3_GLBGO(1) | L3_LKUP(1)),
-	/* UC - Non-Coherent; GO:Memory */
-	MOCS_ENTRY(2, 0, L3_1_UC | L3_GLBGO(1)),
-
-	/* WB - LC */
-	MOCS_ENTRY(3, 0, L3_3_WB | L3_LKUP(1)),
-};
-
 static const struct drm_i915_mocs_entry pvc_mocs_table[] = {
 	/* Error */
 	MOCS_ENTRY(0, 0, L3_3_WB),
@@ -521,13 +509,8 @@ static unsigned int get_mocs_settings(const struct drm_i915_private *i915,
 		table->wb_index = 2;
 		table->unused_entries_index = 2;
 	} else if (IS_DG2(i915)) {
-		if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_A0, STEP_B0)) {
-			table->size = ARRAY_SIZE(dg2_mocs_table_g10_ax);
-			table->table = dg2_mocs_table_g10_ax;
-		} else {
-			table->size = ARRAY_SIZE(dg2_mocs_table);
-			table->table = dg2_mocs_table;
-		}
+		table->size = ARRAY_SIZE(dg2_mocs_table);
+		table->table = dg2_mocs_table;
 		table->uc_index = 1;
 		table->n_entries = GEN9_NUM_MOCS_ENTRIES;
 		table->unused_entries_index = 3;
diff --git a/drivers/gpu/drm/i915/gt/intel_rc6.c b/drivers/gpu/drm/i915/gt/intel_rc6.c
index ccdc1afbf11b5..b8c9338176bd6 100644
--- a/drivers/gpu/drm/i915/gt/intel_rc6.c
+++ b/drivers/gpu/drm/i915/gt/intel_rc6.c
@@ -118,14 +118,12 @@ static void gen11_rc6_enable(struct intel_rc6 *rc6)
 			GEN6_RC_CTL_EI_MODE(1);
 
 	/*
-	 * Wa_16011777198 and BSpec 52698 - Render powergating must be off.
+	 * BSpec 52698 - Render powergating must be off.
 	 * FIXME BSpec is outdated, disabling powergating for MTL is just
 	 * temporary wa and should be removed after fixing real cause
 	 * of forcewake timeouts.
 	 */
-	if (IS_METEORLAKE(gt->i915) ||
-	    IS_DG2_GRAPHICS_STEP(gt->i915, G10, STEP_A0, STEP_C0) ||
-	    IS_DG2_GRAPHICS_STEP(gt->i915, G11, STEP_A0, STEP_B0))
+	if (IS_METEORLAKE(gt->i915))
 		pg_enable =
 			GEN9_MEDIA_PG_ENABLE |
 			GEN11_MEDIA_SAMPLER_PG_ENABLE;
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 3ae0dbd39eaa3..7b426f3015b34 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -764,39 +764,15 @@ static void dg2_ctx_workarounds_init(struct intel_engine_cs *engine,
 {
 	dg2_ctx_gt_tuning_init(engine, wal);
 
-	/* Wa_16011186671:dg2_g11 */
-	if (IS_DG2_GRAPHICS_STEP(engine->i915, G11, STEP_A0, STEP_B0)) {
-		wa_mcr_masked_dis(wal, VFLSKPD, DIS_MULT_MISS_RD_SQUASH);
-		wa_mcr_masked_en(wal, VFLSKPD, DIS_OVER_FETCH_CACHE);
-	}
-
-	if (IS_DG2_GRAPHICS_STEP(engine->i915, G10, STEP_A0, STEP_B0)) {
-		/* Wa_14010469329:dg2_g10 */
-		wa_mcr_masked_en(wal, XEHP_COMMON_SLICE_CHICKEN3,
-				 XEHP_DUAL_SIMD8_SEQ_MERGE_DISABLE);
-
-		/*
-		 * Wa_22010465075:dg2_g10
-		 * Wa_22010613112:dg2_g10
-		 * Wa_14010698770:dg2_g10
-		 */
-		wa_mcr_masked_en(wal, XEHP_COMMON_SLICE_CHICKEN3,
-				 GEN12_DISABLE_CPS_AWARE_COLOR_PIPE);
-	}
-
 	/* Wa_16013271637:dg2 */
 	wa_mcr_masked_en(wal, XEHP_SLICE_COMMON_ECO_CHICKEN1,
 			 MSC_MSAA_REODER_BUF_BYPASS_DISABLE);
 
 	/* Wa_14014947963:dg2 */
-	if (IS_DG2_GRAPHICS_STEP(engine->i915, G10, STEP_B0, STEP_FOREVER) ||
-	    IS_DG2_G11(engine->i915) || IS_DG2_G12(engine->i915))
-		wa_masked_field_set(wal, VF_PREEMPTION, PREEMPTION_VERTEX_COUNT, 0x4000);
+	wa_masked_field_set(wal, VF_PREEMPTION, PREEMPTION_VERTEX_COUNT, 0x4000);
 
 	/* Wa_18018764978:dg2 */
-	if (IS_DG2_GRAPHICS_STEP(engine->i915, G10, STEP_C0, STEP_FOREVER) ||
-	    IS_DG2_G11(engine->i915) || IS_DG2_G12(engine->i915))
-		wa_mcr_masked_en(wal, XEHP_PSS_MODE2, SCOREBOARD_STALL_FLUSH_CONTROL);
+	wa_mcr_masked_en(wal, XEHP_PSS_MODE2, SCOREBOARD_STALL_FLUSH_CONTROL);
 
 	/* Wa_15010599737:dg2 */
 	wa_mcr_masked_en(wal, CHICKEN_RASTER_1, DIS_SF_ROUND_NEAREST_EVEN);
@@ -1606,31 +1582,11 @@ xehpsdv_gt_workarounds_init(struct intel_gt *gt, struct i915_wa_list *wal)
 static void
 dg2_gt_workarounds_init(struct intel_gt *gt, struct i915_wa_list *wal)
 {
-	struct intel_engine_cs *engine;
-	int id;
-
 	xehp_init_mcr(gt, wal);
 
 	/* Wa_14011060649:dg2 */
 	wa_14011060649(gt, wal);
 
-	/*
-	 * Although there are per-engine instances of these registers,
-	 * they technically exist outside the engine itself and are not
-	 * impacted by engine resets.  Furthermore, they're part of the
-	 * GuC blacklist so trying to treat them as engine workarounds
-	 * will result in GuC initialization failure and a wedged GPU.
-	 */
-	for_each_engine(engine, gt, id) {
-		if (engine->class != VIDEO_DECODE_CLASS)
-			continue;
-
-		/* Wa_16010515920:dg2_g10 */
-		if (IS_DG2_GRAPHICS_STEP(gt->i915, G10, STEP_A0, STEP_B0))
-			wa_write_or(wal, VDBOX_CGCTL3F18(engine->mmio_base),
-				    ALNUNIT_CLKGATE_DIS);
-	}
-
 	if (IS_DG2_G10(gt->i915)) {
 		/* Wa_22010523718:dg2 */
 		wa_write_or(wal, UNSLICE_UNIT_LEVEL_CLKGATE,
@@ -1641,65 +1597,6 @@ dg2_gt_workarounds_init(struct intel_gt *gt, struct i915_wa_list *wal)
 				DSS_ROUTER_CLKGATE_DIS);
 	}
 
-	if (IS_DG2_GRAPHICS_STEP(gt->i915, G10, STEP_A0, STEP_B0) ||
-	    IS_DG2_GRAPHICS_STEP(gt->i915, G11, STEP_A0, STEP_B0)) {
-		/* Wa_14012362059:dg2 */
-		wa_mcr_write_or(wal, XEHP_MERT_MOD_CTRL, FORCE_MISS_FTLB);
-	}
-
-	if (IS_DG2_GRAPHICS_STEP(gt->i915, G10, STEP_A0, STEP_B0)) {
-		/* Wa_14010948348:dg2_g10 */
-		wa_write_or(wal, UNSLCGCTL9430, MSQDUNIT_CLKGATE_DIS);
-
-		/* Wa_14011037102:dg2_g10 */
-		wa_write_or(wal, UNSLCGCTL9444, LTCDD_CLKGATE_DIS);
-
-		/* Wa_14011371254:dg2_g10 */
-		wa_mcr_write_or(wal, XEHP_SLICE_UNIT_LEVEL_CLKGATE, NODEDSS_CLKGATE_DIS);
-
-		/* Wa_14011431319:dg2_g10 */
-		wa_write_or(wal, UNSLCGCTL9440, GAMTLBOACS_CLKGATE_DIS |
-			    GAMTLBVDBOX7_CLKGATE_DIS |
-			    GAMTLBVDBOX6_CLKGATE_DIS |
-			    GAMTLBVDBOX5_CLKGATE_DIS |
-			    GAMTLBVDBOX4_CLKGATE_DIS |
-			    GAMTLBVDBOX3_CLKGATE_DIS |
-			    GAMTLBVDBOX2_CLKGATE_DIS |
-			    GAMTLBVDBOX1_CLKGATE_DIS |
-			    GAMTLBVDBOX0_CLKGATE_DIS |
-			    GAMTLBKCR_CLKGATE_DIS |
-			    GAMTLBGUC_CLKGATE_DIS |
-			    GAMTLBBLT_CLKGATE_DIS);
-		wa_write_or(wal, UNSLCGCTL9444, GAMTLBGFXA0_CLKGATE_DIS |
-			    GAMTLBGFXA1_CLKGATE_DIS |
-			    GAMTLBCOMPA0_CLKGATE_DIS |
-			    GAMTLBCOMPA1_CLKGATE_DIS |
-			    GAMTLBCOMPB0_CLKGATE_DIS |
-			    GAMTLBCOMPB1_CLKGATE_DIS |
-			    GAMTLBCOMPC0_CLKGATE_DIS |
-			    GAMTLBCOMPC1_CLKGATE_DIS |
-			    GAMTLBCOMPD0_CLKGATE_DIS |
-			    GAMTLBCOMPD1_CLKGATE_DIS |
-			    GAMTLBMERT_CLKGATE_DIS   |
-			    GAMTLBVEBOX3_CLKGATE_DIS |
-			    GAMTLBVEBOX2_CLKGATE_DIS |
-			    GAMTLBVEBOX1_CLKGATE_DIS |
-			    GAMTLBVEBOX0_CLKGATE_DIS);
-
-		/* Wa_14010569222:dg2_g10 */
-		wa_write_or(wal, UNSLICE_UNIT_LEVEL_CLKGATE,
-			    GAMEDIA_CLKGATE_DIS);
-
-		/* Wa_14011028019:dg2_g10 */
-		wa_mcr_write_or(wal, SSMCGCTL9530, RTFUNIT_CLKGATE_DIS);
-
-		/* Wa_14010680813:dg2_g10 */
-		wa_mcr_write_or(wal, XEHP_GAMSTLB_CTRL,
-				CONTROL_BLOCK_CLKGATE_DIS |
-				EGRESS_BLOCK_CLKGATE_DIS |
-				TAG_BLOCK_CLKGATE_DIS);
-	}
-
 	/* Wa_14014830051:dg2 */
 	wa_mcr_write_clr(wal, SARB_CHICKEN1, COMP_CKN_IN);
 
@@ -2242,29 +2139,10 @@ static void dg2_whitelist_build(struct intel_engine_cs *engine)
 
 	switch (engine->class) {
 	case RENDER_CLASS:
-		/*
-		 * Wa_1507100340:dg2_g10
-		 *
-		 * This covers 4 registers which are next to one another :
-		 *   - PS_INVOCATION_COUNT
-		 *   - PS_INVOCATION_COUNT_UDW
-		 *   - PS_DEPTH_COUNT
-		 *   - PS_DEPTH_COUNT_UDW
-		 */
-		if (IS_DG2_GRAPHICS_STEP(engine->i915, G10, STEP_A0, STEP_B0))
-			whitelist_reg_ext(w, PS_INVOCATION_COUNT,
-					  RING_FORCE_TO_NONPRIV_ACCESS_RD |
-					  RING_FORCE_TO_NONPRIV_RANGE_4);
-
 		/* Required by recommended tuning setting (not a workaround) */
 		whitelist_mcr_reg(w, XEHP_COMMON_SLICE_CHICKEN3);
 
 		break;
-	case COMPUTE_CLASS:
-		/* Wa_16011157294:dg2_g10 */
-		if (IS_DG2_GRAPHICS_STEP(engine->i915, G10, STEP_A0, STEP_B0))
-			whitelist_reg(w, GEN9_CTX_PREEMPT_REG);
-		break;
 	default:
 		break;
 	}
@@ -2415,12 +2293,6 @@ engine_fake_wa_init(struct intel_engine_cs *engine, struct i915_wa_list *wal)
 	}
 }
 
-static bool needs_wa_1308578152(struct intel_engine_cs *engine)
-{
-	return intel_sseu_find_first_xehp_dss(&engine->gt->info.sseu, 0, 0) >=
-		GEN_DSS_PER_GSLICE;
-}
-
 static void
 rcs_engine_wa_init(struct intel_engine_cs *engine, struct i915_wa_list *wal)
 {
@@ -2435,42 +2307,20 @@ rcs_engine_wa_init(struct intel_engine_cs *engine, struct i915_wa_list *wal)
 
 	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_A0, STEP_B0) ||
 	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_A0, STEP_B0) ||
-	    IS_DG2_GRAPHICS_STEP(i915, G10, STEP_B0, STEP_FOREVER) ||
-	    IS_DG2_G11(i915) || IS_DG2_G12(i915)) {
+	    IS_DG2(i915)) {
 		/* Wa_1509727124 */
 		wa_mcr_masked_en(wal, GEN10_SAMPLER_MODE,
 				 SC_DISABLE_POWER_OPTIMIZATION_EBB);
 	}
 
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_B0, STEP_FOREVER) ||
-	    IS_DG2_G11(i915) || IS_DG2_G12(i915) ||
-	    IS_MTL_GRAPHICS_STEP(i915, M, STEP_A0, STEP_B0)) {
+	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_A0, STEP_B0) ||
+	    IS_DG2(i915)) {
 		/* Wa_22012856258 */
 		wa_mcr_masked_en(wal, GEN8_ROW_CHICKEN2,
 				 GEN12_DISABLE_READ_SUPPRESSION);
 	}
 
-	if (IS_DG2_GRAPHICS_STEP(i915, G11, STEP_A0, STEP_B0)) {
-		/* Wa_14013392000:dg2_g11 */
-		wa_mcr_masked_en(wal, GEN8_ROW_CHICKEN2, GEN12_ENABLE_LARGE_GRF_MODE);
-	}
-
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_A0, STEP_B0) ||
-	    IS_DG2_GRAPHICS_STEP(i915, G11, STEP_A0, STEP_B0)) {
-		/* Wa_14012419201:dg2 */
-		wa_mcr_masked_en(wal, GEN9_ROW_CHICKEN4,
-				 GEN12_DISABLE_HDR_PAST_PAYLOAD_HOLD_FIX);
-	}
-
-	/* Wa_1308578152:dg2_g10 when first gslice is fused off */
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_B0, STEP_C0) &&
-	    needs_wa_1308578152(engine)) {
-		wa_masked_dis(wal, GEN12_CS_DEBUG_MODE1_CCCSUNIT_BE_COMMON,
-			      GEN12_REPLAY_MODE_GRANULARITY);
-	}
-
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_B0, STEP_FOREVER) ||
-	    IS_DG2_G11(i915) || IS_DG2_G12(i915)) {
+	if (IS_DG2(i915)) {
 		/*
 		 * Wa_22010960976:dg2
 		 * Wa_14013347512:dg2
@@ -2479,34 +2329,7 @@ rcs_engine_wa_init(struct intel_engine_cs *engine, struct i915_wa_list *wal)
 				  LSC_L1_FLUSH_CTL_3D_DATAPORT_FLUSH_EVENTS_MASK);
 	}
 
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_A0, STEP_B0)) {
-		/*
-		 * Wa_1608949956:dg2_g10
-		 * Wa_14010198302:dg2_g10
-		 */
-		wa_mcr_masked_en(wal, GEN8_ROW_CHICKEN,
-				 MDQ_ARBITRATION_MODE | UGM_BACKUP_MODE);
-	}
-
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_A0, STEP_B0))
-		/* Wa_22010430635:dg2 */
-		wa_mcr_masked_en(wal,
-				 GEN9_ROW_CHICKEN4,
-				 GEN12_DISABLE_GRF_CLEAR);
-
-	/* Wa_14013202645:dg2 */
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_B0, STEP_C0) ||
-	    IS_DG2_GRAPHICS_STEP(i915, G11, STEP_A0, STEP_B0))
-		wa_mcr_write_or(wal, RT_CTRL, DIS_NULL_QUERY);
-
-	/* Wa_22012532006:dg2 */
-	if (IS_DG2_GRAPHICS_STEP(engine->i915, G10, STEP_A0, STEP_C0) ||
-	    IS_DG2_GRAPHICS_STEP(engine->i915, G11, STEP_A0, STEP_B0))
-		wa_mcr_masked_en(wal, GEN9_HALF_SLICE_CHICKEN7,
-				 DG2_DISABLE_ROUND_ENABLE_ALLOW_FOR_SSLA);
-
-	if (IS_DG2_GRAPHICS_STEP(i915, G11, STEP_B0, STEP_FOREVER) ||
-	    IS_DG2_G10(i915)) {
+	if (IS_DG2_G11(i915) || IS_DG2_G10(i915)) {
 		/* Wa_22014600077:dg2 */
 		wa_mcr_add(wal, GEN10_CACHE_MODE_SS, 0,
 			   _MASKED_BIT_ENABLE(ENABLE_EU_COUNT_FOR_TDL_FLUSH),
@@ -3050,8 +2873,7 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 
 	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_A0, STEP_B0) ||
 	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_A0, STEP_B0) ||
-	    IS_DG2_GRAPHICS_STEP(i915, G10, STEP_B0, STEP_FOREVER) ||
-	    IS_DG2_G11(i915) || IS_DG2_G12(i915)) {
+	    IS_DG2(i915)) {
 		/* Wa_22013037850 */
 		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0_UDW,
 				DISABLE_128B_EVICTION_COMMAND_UDW);
@@ -3072,8 +2894,7 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 		wa_masked_en(wal, VFG_PREEMPTION_CHICKEN, POLYGON_TRIFAN_LINELOOP_DISABLE);
 	}
 
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_B0, STEP_C0) ||
-	    IS_DG2_G11(i915)) {
+	if (IS_DG2_G11(i915)) {
 		/*
 		 * Wa_22012826095:dg2
 		 * Wa_22013059131:dg2
@@ -3087,18 +2908,6 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 				FORCE_1_SUB_MESSAGE_PER_FRAGMENT);
 	}
 
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_A0, STEP_B0)) {
-		/*
-		 * Wa_14010918519:dg2_g10
-		 *
-		 * LSC_CHICKEN_BIT_0 always reads back as 0 is this stepping,
-		 * so ignoring verification.
-		 */
-		wa_mcr_add(wal, LSC_CHICKEN_BIT_0_UDW, 0,
-			   FORCE_SLM_FENCE_SCOPE_TO_TILE | FORCE_UGM_FENCE_SCOPE_TO_TILE,
-			   0, false);
-	}
-
 	if (IS_XEHPSDV(i915)) {
 		/* Wa_1409954639 */
 		wa_mcr_masked_en(wal,
@@ -3131,7 +2940,7 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0_UDW, DIS_CHAIN_2XSIMD8);
 	}
 
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_A0, STEP_C0) || IS_DG2_G11(i915))
+	if (IS_DG2_G11(i915))
 		/*
 		 * Wa_22012654132
 		 *
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
index 569b5fe94c416..82a2ecc12b212 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
@@ -272,18 +272,14 @@ static u32 guc_ctl_wa_flags(struct intel_guc *guc)
 	    GRAPHICS_VER_FULL(gt->i915) < IP_VER(12, 50))
 		flags |= GUC_WA_POLLCS;
 
-	/* Wa_16011759253:dg2_g10:a0 */
-	if (IS_DG2_GRAPHICS_STEP(gt->i915, G10, STEP_A0, STEP_B0))
-		flags |= GUC_WA_GAM_CREDITS;
-
 	/* Wa_14014475959 */
 	if (IS_MTL_GRAPHICS_STEP(gt->i915, M, STEP_A0, STEP_B0) ||
 	    IS_DG2(gt->i915))
 		flags |= GUC_WA_HOLD_CCS_SWITCHOUT;
 
 	/*
-	 * Wa_14012197797:dg2_g10:a0,dg2_g11:a0
-	 * Wa_22011391025:dg2_g10,dg2_g11,dg2_g12
+	 * Wa_14012197797
+	 * Wa_22011391025
 	 *
 	 * The same WA bit is used for both and 22011391025 is applicable to
 	 * all DG2.
@@ -297,17 +293,11 @@ static u32 guc_ctl_wa_flags(struct intel_guc *guc)
 	    GRAPHICS_VER_FULL(gt->i915) < IP_VER(12, 70)))
 		flags |= GUC_WA_PRE_PARSER;
 
-	/* Wa_16011777198:dg2 */
-	if (IS_DG2_GRAPHICS_STEP(gt->i915, G10, STEP_A0, STEP_C0) ||
-	    IS_DG2_GRAPHICS_STEP(gt->i915, G11, STEP_A0, STEP_B0))
-		flags |= GUC_WA_RCS_RESET_BEFORE_RC6;
-
 	/*
-	 * Wa_22012727170:dg2_g10[a0-c0), dg2_g11[a0..)
-	 * Wa_22012727685:dg2_g11[a0..)
+	 * Wa_22012727170
+	 * Wa_22012727685
 	 */
-	if (IS_DG2_GRAPHICS_STEP(gt->i915, G10, STEP_A0, STEP_C0) ||
-	    IS_DG2_GRAPHICS_STEP(gt->i915, G11, STEP_A0, STEP_FOREVER))
+	if (IS_DG2_G11(gt->i915))
 		flags |= GUC_WA_CONTEXT_ISOLATION;
 
 	/* Wa_16015675438 */
diff --git a/drivers/gpu/drm/i915/intel_clock_gating.c b/drivers/gpu/drm/i915/intel_clock_gating.c
index 81a4d32734e94..c66eb6abd4a2e 100644
--- a/drivers/gpu/drm/i915/intel_clock_gating.c
+++ b/drivers/gpu/drm/i915/intel_clock_gating.c
@@ -396,14 +396,6 @@ static void dg2_init_clock_gating(struct drm_i915_private *i915)
 	/* Wa_22010954014:dg2 */
 	intel_uncore_rmw(&i915->uncore, XEHP_CLOCK_GATE_DIS, 0,
 			 SGSI_SIDECLK_DIS);
-
-	/*
-	 * Wa_14010733611:dg2_g10
-	 * Wa_22010146351:dg2_g10
-	 */
-	if (IS_DG2_GRAPHICS_STEP(i915, G10, STEP_A0, STEP_B0))
-		intel_uncore_rmw(&i915->uncore, XEHP_CLOCK_GATE_DIS, 0,
-				 SGR_DIS | SGGI_DIS);
 }
 
 static void pvc_init_clock_gating(struct drm_i915_private *i915)
-- 
2.43.0




