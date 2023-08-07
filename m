Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50791771B3D
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjHGHLt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjHGHLo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:11:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECBA10EC
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC9CB615B7
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94F0C433C8;
        Mon,  7 Aug 2023 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392302;
        bh=cbFW7o07XvwJrnPhKzInqOfvn8I1TrnE+9HEEWWFheo=;
        h=Subject:To:Cc:From:Date:From;
        b=ZZOUJd9UGt3EDogc0ngIemPnP1XoxA817py+9wUis7afuw1py3KGFbE/kCvR9I/Y0
         LPtA0VPgZ+LeJKMxGtoFGwUv0t4jdIjm3+Rb+E7CcXNO76cKc5xv49NPEcZByeyJDc
         19T9DMYNm+PN7bYTsOiqFweMDJ6C4RjWESjxyBZc=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Poll aux invalidation register bit on" failed to apply to 5.15-stable tree
To:     jonathan.cavitt@intel.com, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, matthew.d.roper@intel.com,
        nirmoy.das@intel.com, stable@vger.kernel.org,
        tvrtko.ursulin@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:11:29 +0200
Message-ID: <2023080729-opulently-resemble-4943@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0fde2f23516a00fd90dfb980b66b4665fcbfa659
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080729-opulently-resemble-4943@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0fde2f23516a ("drm/i915/gt: Poll aux invalidation register bit on invalidation")
b2f59e902603 ("drm/i915: Add the gen12_needs_ccs_aux_inv helper")
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

From 0fde2f23516a00fd90dfb980b66b4665fcbfa659 Mon Sep 17 00:00:00 2001
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
Date: Tue, 25 Jul 2023 02:19:49 +0200
Subject: [PATCH] drm/i915/gt: Poll aux invalidation register bit on
 invalidation

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
Link: https://patchwork.freedesktop.org/patch/msgid/20230725001950.1014671-7-andi.shyti@linux.intel.com
(cherry picked from commit d459c86f00aa98028d155a012c65dc42f7c37e76)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index ec54d36eaef7..ec7a0ddf9e12 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -184,7 +184,15 @@ u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv
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
@@ -292,10 +300,9 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 		else if (engine->class == COMPUTE_CLASS)
 			flags &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
 
+		count = 8;
 		if (gen12_needs_ccs_aux_inv(rq->engine))
-			count = 8 + 4;
-		else
-			count = 8;
+			count += 8;
 
 		cs = intel_ring_begin(rq, count);
 		if (IS_ERR(cs))
@@ -338,7 +345,7 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 			aux_inv = rq->engine->mask &
 				~GENMASK(_BCS(I915_MAX_BCS - 1), BCS0);
 			if (aux_inv)
-				cmd += 4;
+				cmd += 8;
 		}
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
index 5df7cce23197..2bd8d98d2110 100644
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

