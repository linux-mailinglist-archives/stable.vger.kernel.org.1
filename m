Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724F5771B30
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjHGHJr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHGHJq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0EC95
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2FCC615B0
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC65C433C8;
        Mon,  7 Aug 2023 07:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392184;
        bh=QC5synJFzkfLjEb9TwrxOmrGFkOw9aui48WB4Efr75k=;
        h=Subject:To:Cc:From:Date:From;
        b=GbThJoLWhM2X0mMmALixpTLZ4eZrNOOCqWzd/sCgu9P2BYJ3H2uQhnfTYg601BuqG
         KLzLvZEndR3GWI53nCw1g1KSCj3lLEQni4m0/JkC/X591+lmSeXAhE2jdh2/lG5821
         qZ079zg+a6bmmRVniPq+QuZArEfmFGmK95VYryoA=
Subject: FAILED: patch "[PATCH] drm/i915: Add the gen12_needs_ccs_aux_inv helper" failed to apply to 5.10-stable tree
To:     andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        jonathan.cavitt@intel.com, matthew.d.roper@intel.com,
        nirmoy.das@intel.com, stable@vger.kernel.org,
        tvrtko.ursulin@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:09:36 +0200
Message-ID: <2023080735-starlight-resonate-eca7@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b2f59e9026038a5bbcbc0019fa58f963138211ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080735-starlight-resonate-eca7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

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

From b2f59e9026038a5bbcbc0019fa58f963138211ee Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@linux.intel.com>
Date: Tue, 25 Jul 2023 02:19:45 +0200
Subject: [PATCH] drm/i915: Add the gen12_needs_ccs_aux_inv helper

We always assumed that a device might either have AUX or FLAT
CCS, but this is an approximation that is not always true, e.g.
PVC represents an exception.

Set the basis for future finer selection by implementing a
boolean gen12_needs_ccs_aux_inv() function that tells whether aux
invalidation is needed or not.

Currently PVC is the only exception to the above mentioned rule.

Requires: 059ae7ae2a1c ("drm/i915/gt: Cleanup aux invalidation registers")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230725001950.1014671-3-andi.shyti@linux.intel.com
(cherry picked from commit c827655b87ad201ebe36f2e28d16b5491c8f7801)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 563efee05560..460c9225a50f 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -165,6 +165,18 @@ static u32 preparser_disable(bool state)
 	return MI_ARB_CHECK | 1 << 8 | state;
 }
 
+static bool gen12_needs_ccs_aux_inv(struct intel_engine_cs *engine)
+{
+	if (IS_PONTEVECCHIO(engine->i915))
+		return false;
+
+	/*
+	 * so far platforms supported by i915 having
+	 * flat ccs do not require AUX invalidation
+	 */
+	return !HAS_FLAT_CCS(engine->i915);
+}
+
 u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv_reg)
 {
 	u32 gsi_offset = gt->uncore->gsi_offset;
@@ -267,7 +279,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 		else if (engine->class == COMPUTE_CLASS)
 			flags &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
 
-		if (!HAS_FLAT_CCS(rq->engine->i915))
+		if (gen12_needs_ccs_aux_inv(rq->engine))
 			count = 8 + 4;
 		else
 			count = 8;
@@ -285,7 +297,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 		cs = gen8_emit_pipe_control(cs, flags, LRC_PPHWSP_SCRATCH_ADDR);
 
-		if (!HAS_FLAT_CCS(rq->engine->i915)) {
+		if (gen12_needs_ccs_aux_inv(rq->engine)) {
 			/* hsdes: 1809175790 */
 			cs = gen12_emit_aux_table_inv(rq->engine->gt, cs,
 						      GEN12_CCS_AUX_INV);
@@ -307,7 +319,7 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 	if (mode & EMIT_INVALIDATE) {
 		cmd += 2;
 
-		if (!HAS_FLAT_CCS(rq->engine->i915) &&
+		if (gen12_needs_ccs_aux_inv(rq->engine) &&
 		    (rq->engine->class == VIDEO_DECODE_CLASS ||
 		     rq->engine->class == VIDEO_ENHANCEMENT_CLASS)) {
 			aux_inv = rq->engine->mask &

