Return-Path: <stable+bounces-238403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF4iOq/A4WnixgAAu9opvQ
	(envelope-from <stable+bounces-238403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:10:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC878416FE9
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33E21302866B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F83624B0;
	Fri, 17 Apr 2026 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/L4L4KI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277353624A6
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776402601; cv=none; b=RxdevXpdfMvSwKLmHGdfPTkH6uvI4vzewckynKqFcAeFuPVjF2QCftSGfPKV++kql1tt0g20nTVICs9D3fxyBVdy+9J4mrNkzWyVKcW0SoRIKVAlfUbmGNA0MbEqOn0HgN40M5EO7YQ+BAZ3oicDrG0I8zvTxcHPjtxxIdiKnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776402601; c=relaxed/simple;
	bh=TRpltXnPilb2jllDQ4xqfTOJJjFXmMeXlpCKG4UKTvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4jmgRChSgKHKgGUp5hugGUt3xZ+dLlBn5F6Pg15id6pNONbSjDniw5Jr63emeSjV7GQB48P9mONF71YAXDHE5Fv2hkqXhg6VeKcQHEaICsAgreLw2FmmERyPtR6cN1ukRu2DZ8fS8+Q6aSebx/mS4gx0GDRr1lsRM4i5eTfslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/L4L4KI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776402599; x=1807938599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TRpltXnPilb2jllDQ4xqfTOJJjFXmMeXlpCKG4UKTvM=;
  b=f/L4L4KI2fGrBQ2F6XqKytuLFQiIIxs9TxR/9t23ZxncFu9F84ngQuhN
   vU1DZnKC5gq/fS5RhWUJqrBrn6SzVtvJW8V0zbyULrEaRGMpWqlmHNsqJ
   17UW682QBg7ptQGTJd3OyRTFJ4GnYMK9OzOtHTQY6cPMrV2d8wBEFbe46
   6AxZJr7it6ENh0Pd195PjdEAMEf4iylbWQcj5LTXtA+hs9uBLr6FPXhyY
   D6OT+ws8wtXkeupy0XzKBKYKYXJtZWYb7mDGNSGlKk3ckPG0x0Se68c5V
   TW1uQKUHHB28ZRhh2AlyKZdYKrPwhkJglEVVgaaTs9HxRzPAi69OCPYn8
   Q==;
X-CSE-ConnectionGUID: E5K+XAWARUqz3ulO+X1X9Q==
X-CSE-MsgGUID: 4T6dfRiMS9m2TSk68jkzqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88796780"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="88796780"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 22:09:58 -0700
X-CSE-ConnectionGUID: Wz+IUFsaQi2mdyNDVvdcPw==
X-CSE-MsgGUID: OmPL2U5sT/SAuO98lg+/PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="228266452"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by fmviesa008.fm.intel.com with ESMTP; 16 Apr 2026 22:09:58 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maciej Plewka <maciej.plewka@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3] drm/i915/dg2: Add per-context control for Wa_22013059131
Date: Fri, 17 Apr 2026 05:09:56 +0000
Message-ID: <20260417050956.1945481-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238403-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC878416FE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
at engine init, but this is known to cause GPU hangs in certain workloads.
Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
kernel know bit 15 programming is not needed for that context.

LSC_CHICKEN_BIT_0 is not context-saved by hardware, so the kernel restores
the correct value on every context switch via the indirect context
batchbuffer to avoid leaking state between contexts. The old unconditional
application of Wa22013059131 in intel_workarounds.c is removed.

v3:
- Kernel-internal context will not change workaround settings

Bspec: 54833
Fixes: 645cc0b9d972 ("drm/i915/dg2: Add initial gt/ctx/engine workarounds")
Cc: stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Maciej Plewka <maciej.plewka@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c   | 12 +++++
 .../gpu/drm/i915/gem/i915_gem_context_types.h |  1 +
 drivers/gpu/drm/i915/gt/intel_context_types.h |  1 +
 drivers/gpu/drm/i915/gt/intel_lrc.c           | 44 ++++++++++++++++++-
 drivers/gpu/drm/i915/gt/intel_workarounds.c   | 10 ++---
 include/uapi/drm/i915_drm.h                   | 10 +++++
 6 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 6ac0f23570f3..d24e449f1eb3 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -911,6 +911,15 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
 			ret = -EINVAL;
 		break;
 
+	case I915_CONTEXT_PARAM_WA_22013059131:
+		if (args->size)
+			ret = -EINVAL;
+		else if (args->value)
+			pc->user_flags |= BIT(UCONTEXT_WA_22013059131);
+		else
+			pc->user_flags &= ~BIT(UCONTEXT_WA_22013059131);
+		break;
+
 	case I915_CONTEXT_PARAM_RECOVERABLE:
 		if (args->size)
 			ret = -EINVAL;
@@ -1003,6 +1012,9 @@ static int intel_context_set_gem(struct intel_context *ce,
 	if (test_bit(UCONTEXT_LOW_LATENCY, &ctx->user_flags))
 		__set_bit(CONTEXT_LOW_LATENCY, &ce->flags);
 
+	if (test_bit(UCONTEXT_WA_22013059131, &ctx->user_flags))
+		__set_bit(CONTEXT_WA_22013059131, &ce->flags);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
index 0267c924634b..4efc0e758d3b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
@@ -338,6 +338,7 @@ struct i915_gem_context {
 #define UCONTEXT_RECOVERABLE		3
 #define UCONTEXT_PERSISTENCE		4
 #define UCONTEXT_LOW_LATENCY		5
+#define UCONTEXT_WA_22013059131		6
 
 	/**
 	 * @flags: small set of booleans
diff --git a/drivers/gpu/drm/i915/gt/intel_context_types.h b/drivers/gpu/drm/i915/gt/intel_context_types.h
index 10070ee4d74c..84011ce7c84d 100644
--- a/drivers/gpu/drm/i915/gt/intel_context_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_context_types.h
@@ -133,6 +133,7 @@ struct intel_context {
 #define CONTEXT_EXITING			13
 #define CONTEXT_LOW_LATENCY		14
 #define CONTEXT_OWN_STATE		15
+#define CONTEXT_WA_22013059131		16
 
 	struct {
 		u64 timeout_us;
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index 147d22907960..bab4f38515d4 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1348,6 +1348,37 @@ gen12_invalidate_state_cache(u32 *cs)
 	return cs;
 }
 
+static u32 *
+dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
+{
+	/*
+	 * While re-writing LSC_CHICKEN_BIT_0 for Wa_22013059131, the
+	 * other bits of the register will also get overwritten.  The
+	 * hardware default for all other bits is 0, but any workarounds
+	 * that adjust the other bits in the lower dword of the register
+	 * also need to be re-applied here.  At the moment that's just
+	 * Wa_22014226127, which is always set for DG2-G11 platforms.
+	 */
+	u32 val = DISABLE_D8_D16_COASLESCE;
+
+	/*
+	 * Wa_22013059131: only set FORCE_1_SUB_MESSAGE_PER_FRAGMENT for
+	 * userspace contexts that have not opted out.  Kernel-internal
+	 * contexts (gem_context == NULL) never run shader workloads that
+	 * require this workaround, so skip them unconditionally.
+	 */
+	if (rcu_access_pointer(ce->gem_context) &&
+	    !test_bit(CONTEXT_WA_22013059131, &ce->flags)) {
+		val |= FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
+	}
+
+	*cs++ = MI_LOAD_REGISTER_IMM(1);
+	*cs++ = i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
+	*cs++ = val;
+
+	return cs;
+}
+
 static u32 *
 gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 {
@@ -1371,6 +1402,11 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	    IS_DG2(ce->engine->i915))
 		cs = dg2_emit_draw_watermark_setting(cs);
 
+	/* Wa_22013059131:dg2 */
+	if (IS_DG2_G11(ce->engine->i915))
+		cs = dg2_g11_emit_wa_22013059131(ce, cs);
+
+
 	return cs;
 }
 
@@ -1387,7 +1423,13 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
 						    PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE,
 						    0);
 
-	return gen12_emit_aux_table_inv(ce->engine, cs);
+	cs = gen12_emit_aux_table_inv(ce->engine, cs);
+
+	/* Wa_22013059131:dg2 */
+	if (IS_DG2_G11(ce->engine->i915))
+		cs = dg2_g11_emit_wa_22013059131(ce, cs);
+
+	return cs;
 }
 
 static u32 *xehp_emit_fastcolor_blt_wabb(const struct intel_context *ce, u32 *cs)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 24ea5d8d529c..ef6eea3ab597 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2840,7 +2840,11 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 	if (IS_GFX_GT_IP_STEP(gt, IP_VER(12, 70), STEP_A0, STEP_B0) ||
 	    IS_GFX_GT_IP_STEP(gt, IP_VER(12, 71), STEP_A0, STEP_B0) ||
 	    IS_DG2(i915)) {
-		/* Wa_22014226127 */
+		/*
+		 * Wa_22014226127: Note that this workaround also needs to be
+		 * re-applied in intel_lrc.c when LSC_CHICKEN_BIT_0 is
+		 * re-written for Wa_22013059131.
+		 */
 		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0, DISABLE_D8_D16_COASLESCE);
 	}
 
@@ -2867,10 +2871,6 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 				     MAXREQS_PER_BANK,
 				     REG_FIELD_PREP(MAXREQS_PER_BANK, 2));
 
-		/* Wa_22013059131:dg2 */
-		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0,
-				FORCE_1_SUB_MESSAGE_PER_FRAGMENT);
-
 		/*
 		 * Wa_22012654132
 		 *
diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
index 535cb68fdb5c..0f553bb12fb0 100644
--- a/include/uapi/drm/i915_drm.h
+++ b/include/uapi/drm/i915_drm.h
@@ -2172,6 +2172,16 @@ struct drm_i915_gem_context_param {
  * Note that this is a debug API not available on production kernel builds.
  */
 #define I915_CONTEXT_PARAM_CONTEXT_IMAGE	0xf
+
+/*
+ * I915_CONTEXT_PARAM_WA_22013059131:
+ *
+ * Default value 0 means the kernel programs Wa_22013059131 for this context.
+ * Set to 1 to inform the kernel that userspace is taking responsibility for
+ * applying the preferred workaround implementation, so the kernel programming
+ * of LSC_CHICKEN_BIT_0 bit 15 is not needed for this context. DG2-G11 only.
+ */
+#define I915_CONTEXT_PARAM_WA_22013059131	0x10
 /* Must be kept compact -- no holes and well documented */
 
 	/** @value: Context parameter value to be set or queried */
-- 
2.43.0


