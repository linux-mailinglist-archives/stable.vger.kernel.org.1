Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744BD771B33
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjHGHKc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHGHKb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F4E78
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CC21615B1
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C57C433C7;
        Mon,  7 Aug 2023 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392228;
        bh=YJTJWqEQNx/1slx6WTwjtmi8feckGeI0dFq9IC+ZwYU=;
        h=Subject:To:Cc:From:Date:From;
        b=HMHOFYgtmEVUl9BebVvWse/BIXEde0HIvgP5dMk/mTwCAm1qPaHntYgHJ4F4eIld2
         UUJzkQnaFinuUYo+dEI7Jh8kZFqSe4oT79gKp1pujj4GH1/26rDFpnh1wYxTs+2PMR
         nFXhOURoSFg9RPQACACVfZhZG1m7SGfJi9FpS+vw=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Cleanup aux invalidation registers" failed to apply to 5.10-stable tree
To:     andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        nirmoy.das@intel.com, stable@vger.kernel.org,
        tvrtko.ursulin@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:10:18 +0200
Message-ID: <2023080718-untie-washout-a0f4@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d14560ac1b595aa2e792365e91fea6aeaee66c2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080718-untie-washout-a0f4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

d14560ac1b59 ("drm/i915/gt: Cleanup aux invalidation registers")
29063c6a6a57 ("drm/i915/mtl: Add gsi_offset when emitting aux table invalidation")
d8b932014c4a ("drm/i915: avoid concurrent writes to aux_inv")
6639fabb1685 ("drm/i915/xehp: Drop aux table invalidation on FlatCCS platforms")
ff6b19d3a0f9 ("drm/i915/xehp: Add compute workarounds")
803efd297e31 ("drm/i915/xehp: compute engine pipe_control")
0d53879faada ("drm/i915/gt: Order GT registers by MMIO offset")
bd3de31950ae ("drm/i915/gt: Use consistent offset notation in intel_gt_regs.h")
680a5cd10b9c ("drm/i915/gt: Cleanup spacing of intel_gt_regs.h")
ab9e00a3509a ("drm/i915/gt: Use parameterized RING_MI_MODE")
93cc7aa0b037 ("drm/i915/gt: Move SFC lock bits to intel_engine_regs.h")
4895b90dd510 ("drm/i915/gt: Drop duplicate register definition for VDBOX_CGCTL3F18")
22ba60f617bd ("drm/i915: Move [more] GT registers to their own header file")
0d6419e9c855 ("drm/i915: Move GT registers to their own header file")
e71a74122863 ("drm/i915: Parameterize MI_PREDICATE registers")
7d296f369d38 ("drm/i915: Parameterize R_PWR_CLK_STATE register definition")
2ef6d3bf4262 ("drm/i915/perf: Move OA regs to their own header")
063565aca373 ("Merge drm/drm-next into drm-intel-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d14560ac1b595aa2e792365e91fea6aeaee66c2b Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@linux.intel.com>
Date: Tue, 25 Jul 2023 02:19:44 +0200
Subject: [PATCH] drm/i915/gt: Cleanup aux invalidation registers

Fix the 'NV' definition postfix that is supposed to be INV.

Take the chance to also order properly the registers based on
their address and call the GEN12_GFX_CCS_AUX_INV address as
GEN12_CCS_AUX_INV like all the other similar registers.

Remove also VD1, VD3 and VE1 registers that don't exist and add
BCS0 and CCS0.

Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230725001950.1014671-2-andi.shyti@linux.intel.com
(cherry picked from commit 2f0b927d3ca3440445975ebde27f3df1c3ed6f76)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 23857cc08eca..563efee05560 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -287,8 +287,8 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 		if (!HAS_FLAT_CCS(rq->engine->i915)) {
 			/* hsdes: 1809175790 */
-			cs = gen12_emit_aux_table_inv(rq->engine->gt,
-						      cs, GEN12_GFX_CCS_AUX_NV);
+			cs = gen12_emit_aux_table_inv(rq->engine->gt, cs,
+						      GEN12_CCS_AUX_INV);
 		}
 
 		*cs++ = preparser_disable(false);
@@ -348,10 +348,10 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 	if (aux_inv) { /* hsdes: 1809175790 */
 		if (rq->engine->class == VIDEO_DECODE_CLASS)
 			cs = gen12_emit_aux_table_inv(rq->engine->gt,
-						      cs, GEN12_VD0_AUX_NV);
+						      cs, GEN12_VD0_AUX_INV);
 		else
 			cs = gen12_emit_aux_table_inv(rq->engine->gt,
-						      cs, GEN12_VE0_AUX_NV);
+						      cs, GEN12_VE0_AUX_INV);
 	}
 
 	if (mode & EMIT_INVALIDATE)
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 718cb2c80f79..2cdfb2f713d0 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -332,9 +332,11 @@
 #define GEN8_PRIVATE_PAT_HI			_MMIO(0x40e0 + 4)
 #define GEN10_PAT_INDEX(index)			_MMIO(0x40e0 + (index) * 4)
 #define BSD_HWS_PGA_GEN7			_MMIO(0x4180)
-#define GEN12_GFX_CCS_AUX_NV			_MMIO(0x4208)
-#define GEN12_VD0_AUX_NV			_MMIO(0x4218)
-#define GEN12_VD1_AUX_NV			_MMIO(0x4228)
+
+#define GEN12_CCS_AUX_INV			_MMIO(0x4208)
+#define GEN12_VD0_AUX_INV			_MMIO(0x4218)
+#define GEN12_VE0_AUX_INV			_MMIO(0x4238)
+#define GEN12_BCS0_AUX_INV			_MMIO(0x4248)
 
 #define GEN8_RTCR				_MMIO(0x4260)
 #define GEN8_M1TCR				_MMIO(0x4264)
@@ -342,14 +344,12 @@
 #define GEN8_BTCR				_MMIO(0x426c)
 #define GEN8_VTCR				_MMIO(0x4270)
 
-#define GEN12_VD2_AUX_NV			_MMIO(0x4298)
-#define GEN12_VD3_AUX_NV			_MMIO(0x42a8)
-#define GEN12_VE0_AUX_NV			_MMIO(0x4238)
-
 #define BLT_HWS_PGA_GEN7			_MMIO(0x4280)
 
-#define GEN12_VE1_AUX_NV			_MMIO(0x42b8)
+#define GEN12_VD2_AUX_INV			_MMIO(0x4298)
+#define GEN12_CCS0_AUX_INV			_MMIO(0x42c8)
 #define   AUX_INV				REG_BIT(0)
+
 #define VEBOX_HWS_PGA_GEN7			_MMIO(0x4380)
 
 #define GEN12_AUX_ERR_DBG			_MMIO(0x43f4)
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index a4ec20aaafe2..325f3dbfb90e 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1367,7 +1367,7 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	/* hsdes: 1809175790 */
 	if (!HAS_FLAT_CCS(ce->engine->i915))
 		cs = gen12_emit_aux_table_inv(ce->engine->gt,
-					      cs, GEN12_GFX_CCS_AUX_NV);
+					      cs, GEN12_CCS_AUX_INV);
 
 	/* Wa_16014892111 */
 	if (IS_MTL_GRAPHICS_STEP(ce->engine->i915, M, STEP_A0, STEP_B0) ||
@@ -1396,10 +1396,10 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
 	if (!HAS_FLAT_CCS(ce->engine->i915)) {
 		if (ce->engine->class == VIDEO_DECODE_CLASS)
 			cs = gen12_emit_aux_table_inv(ce->engine->gt,
-						      cs, GEN12_VD0_AUX_NV);
+						      cs, GEN12_VD0_AUX_INV);
 		else if (ce->engine->class == VIDEO_ENHANCEMENT_CLASS)
 			cs = gen12_emit_aux_table_inv(ce->engine->gt,
-						      cs, GEN12_VE0_AUX_NV);
+						      cs, GEN12_VE0_AUX_INV);
 	}
 
 	return cs;

