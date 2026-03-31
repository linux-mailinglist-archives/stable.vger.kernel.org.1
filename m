Return-Path: <stable+bounces-232572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IQAF2kszGkmQgYAu9opvQ
	(envelope-from <stable+bounces-232572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:19:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70D37119C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4539B3019F3F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874EF3D6692;
	Tue, 31 Mar 2026 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA7jSMk/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC692D46CE
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988390; cv=none; b=gmEi3VjmJSgYTuTaAu0IqBIGuE4vVypDihEuSX/wvCc69+JuSXeDyrneKheF0+pH5nWk6pmcTSy9zyEJmUUE7zwVhlZ4rZ/cic/CgbU6GS3OtVIClt2IkTUi1EawiGLAoPRU9e7RMeMKSwH2VZ2mZrbAek6tlKt7yfXJfCbZej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988390; c=relaxed/simple;
	bh=B80EtpnZK3f1gaQwFME8Vzv20eignLCQTepS0guWObo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+22Gj3Qmq/Gnjdw/IuafnXMkLO+6uYtX+wE6w2sZihdnqYquzn6DLan7NoaOGHp8hYFNfT2oeyQCuTU9ZXrhpvCz03WYpx+3/vac5/Frd+F1Xb8FfSqp/Uo3YkZ1YeW4RxtTxUpOdbELAxxe92UrekXAFHuz0WPclIP9YDKyT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA7jSMk/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774988388; x=1806524388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B80EtpnZK3f1gaQwFME8Vzv20eignLCQTepS0guWObo=;
  b=AA7jSMk/HoolDTj6NPBO43uZVDGpo4mwUSIVEln2ZwMWybN8c2hNfqQX
   i0XX8YbH6QeZlclZ6XDO7GcWZtfYBS7wk3Y3Cy60viaK95FHGGMt9vyoA
   qawlJePnqxcyBjbn5LuouoRVPZxibdCmJFHh9VuKZCZ8My0jbpgiEO6ks
   VTcin5wS7CCTkpLRYAsTKw7+IAZq8JIfKX17BqFuHAboavhFgXg2nF4j8
   tiexbY71sV3x65tk7f+0qhKJ5APgrpv4t/fcO0rSqA8TS/70Rs/0B2sah
   9Y98+pMAN5NYwYNAZAGHxT40UH7QHBfN51ug4BQRnuIQF6dKYiMhbj3uT
   g==;
X-CSE-ConnectionGUID: x0nhSP/YQ3C9gNnfquqe2Q==
X-CSE-MsgGUID: 3QoNDnp7TYSvoX88eLGEBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="78609739"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="78609739"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 13:19:47 -0700
X-CSE-ConnectionGUID: pdpaPXKyRAeJc6VZe2h9PQ==
X-CSE-MsgGUID: qoOd+aldSaKOA59Y2hI2rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="226332114"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.31])
  by orviesa009.jf.intel.com with ESMTP; 31 Mar 2026 13:19:47 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	stable@vger.kernel.org,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] drm/i915/dg2: Add per-context control for Wa_22013059131
Date: Tue, 31 Mar 2026 20:19:34 +0000
Message-ID: <20260331201935.2414108-1-jia.yao@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232572-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jia.yao@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA70D37119C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
at engine init, but this is known to cause GPU hangs in certain workloads.
Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
kernel know bit 15 programming is not needed for that context.

LSC_CHICKEN_BIT_0 is not context-saved by hardware, so the kernel restores
the correct value on every context switch via the indirect context
batchbuffer to avoid leaking state between contexts.

Bspec: 54833
Fixes: 645cc0b9d972 ("drm/i915/dg2: Add initial gt/ctx/engine workarounds")
Cc: stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c   | 12 +++++++++
 drivers/gpu/drm/i915/gem/i915_gem_context.h   | 18 +++++++++++++
 .../gpu/drm/i915/gem/i915_gem_context_types.h |  1 +
 drivers/gpu/drm/i915/gt/intel_context_types.h |  1 +
 drivers/gpu/drm/i915/gt/intel_lrc.c           | 27 ++++++++++++++++++-
 include/uapi/drm/i915_drm.h                   | 10 +++++++
 6 files changed, 68 insertions(+), 1 deletion(-)

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
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.h b/drivers/gpu/drm/i915/gem/i915_gem_context.h
index 6e682a6a0574..831574ec6e2b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.h
@@ -89,6 +89,24 @@ static inline void i915_gem_context_clear_persistence(struct i915_gem_context *c
 	clear_bit(UCONTEXT_PERSISTENCE, &ctx->user_flags);
 }
 
+static inline bool
+i915_gem_context_wa_22013059131_optout(const struct i915_gem_context *ctx)
+{
+	return test_bit(UCONTEXT_WA_22013059131, &ctx->user_flags);
+}
+
+static inline void
+i915_gem_context_set_wa_22013059131_optout(struct i915_gem_context *ctx)
+{
+	set_bit(UCONTEXT_WA_22013059131, &ctx->user_flags);
+}
+
+static inline void
+i915_gem_context_clear_wa_22013059131_optout(struct i915_gem_context *ctx)
+{
+	clear_bit(UCONTEXT_WA_22013059131, &ctx->user_flags);
+}
+
 static inline bool
 i915_gem_context_user_engines(const struct i915_gem_context *ctx)
 {
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
index d36e543e98df..8d17006f10bd 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1348,6 +1348,21 @@ gen12_invalidate_state_cache(u32 *cs)
 	return cs;
 }
 
+static u32 *
+dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
+{
+	u32 val = DISABLE_D8_D16_COASLESCE;	/* Wa_22014226127, always */
+
+	if (!test_bit(CONTEXT_WA_22013059131, &ce->flags))
+		val |= FORCE_1_SUB_MESSAGE_PER_FRAGMENT;	/* Wa_22013059131 */
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
@@ -1371,6 +1386,10 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	    IS_DG2(ce->engine->i915))
 		cs = dg2_emit_draw_watermark_setting(cs);
 
+	/* Wa_22013059131:dg2 */
+	if (IS_DG2_G11(ce->engine->i915))
+		cs = dg2_g11_emit_wa_22013059131(ce, cs);
+
 	return cs;
 }
 
@@ -1387,7 +1406,13 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
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
diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
index 535cb68fdb5c..8a1f40ae120c 100644
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
+ * Set to 1 to inform the kernel that userspace is implementing its half of
+ * the workaround (e.g. by limiting SLM size), so the kernel programming of
+ * LSC_CHICKEN_BIT_0 bit 15 is not needed for this context. DG2-G11 only.
+ */
+#define I915_CONTEXT_PARAM_WA_22013059131	0x10
 /* Must be kept compact -- no holes and well documented */
 
 	/** @value: Context parameter value to be set or queried */
-- 
2.43.0


