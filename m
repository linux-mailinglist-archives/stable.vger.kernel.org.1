Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2BA771B38
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHGHLa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjHGHL2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1F2171E
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B56BA615B2
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0D1C433C7;
        Mon,  7 Aug 2023 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392286;
        bh=o25qnkcHSTBvd1+3MNxqSLS4jI+G0HU4FDoJLRtO+Mk=;
        h=Subject:To:Cc:From:Date:From;
        b=2lcjR29ZcrbECbHJJ0GjeIzvSWX+jqPDbJQ0ioJsuw33JBhj3ZCQ3Qn2Um7NU3rkC
         450JJOUtTa5ie3jm7M0ykW3l9BqkElDBlaLKTgivarGGw8VqYyLG9NW8MQZWh6Wkz6
         mxZFF+5TUOIHJ3oYB4PgwJtViNeWHysLSb4BWEPw=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Rename flags with bit_group_X according to the" failed to apply to 6.1-stable tree
To:     andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        matthew.d.roper@intel.com, nirmoy.das@intel.com,
        stable@vger.kernel.org, tvrtko.ursulin@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:11:21 +0200
Message-ID: <2023080721-urethane-unedited-c67b@gregkh>
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
git cherry-pick -x 592b228f12e15867a63e3a6eeeb54c5c12662a62
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080721-urethane-unedited-c67b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

592b228f12e1 ("drm/i915/gt: Rename flags with bit_group_X according to the datasheet")
78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before invalidation")
d922b80b1010 ("drm/i915/gt: Add workaround 14016712196")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 592b228f12e15867a63e3a6eeeb54c5c12662a62 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@linux.intel.com>
Date: Tue, 25 Jul 2023 02:19:47 +0200
Subject: [PATCH] drm/i915/gt: Rename flags with bit_group_X according to the
 datasheet

In preparation of the next patch align with the datasheet (BSPEC
47112) with the naming of the pipe control set of flag values.
The variable "flags" in gen12_emit_flush_rcs() is applied as a
set of flags called Bit Group 1.

Define also the Bit Group 0 as bit_group_0 where currently only
PIPE_CONTROL0_HDC_PIPELINE_FLUSH bit is set.

Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230725001950.1014671-5-andi.shyti@linux.intel.com
(cherry picked from commit f2dcd21d5a22e13f2fbfe7ab65149038b93cf2ff)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 6210b38a2d38..5d2175e918dd 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -219,7 +219,8 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 	 * table requires quiescing memory traffic beforehand
 	 */
 	if (mode & EMIT_FLUSH || gen12_needs_ccs_aux_inv(engine)) {
-		u32 flags = 0;
+		u32 bit_group_0 = 0;
+		u32 bit_group_1 = 0;
 		int err;
 		u32 *cs;
 
@@ -227,32 +228,33 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 		if (err)
 			return err;
 
-		flags |= PIPE_CONTROL_TILE_CACHE_FLUSH;
-		flags |= PIPE_CONTROL_FLUSH_L3;
-		flags |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
-		flags |= PIPE_CONTROL_DEPTH_CACHE_FLUSH;
+		bit_group_0 |= PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
+
+		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
+		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
+		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
+		bit_group_1 |= PIPE_CONTROL_DEPTH_CACHE_FLUSH;
 		/* Wa_1409600907:tgl,adl-p */
-		flags |= PIPE_CONTROL_DEPTH_STALL;
-		flags |= PIPE_CONTROL_DC_FLUSH_ENABLE;
-		flags |= PIPE_CONTROL_FLUSH_ENABLE;
+		bit_group_1 |= PIPE_CONTROL_DEPTH_STALL;
+		bit_group_1 |= PIPE_CONTROL_DC_FLUSH_ENABLE;
+		bit_group_1 |= PIPE_CONTROL_FLUSH_ENABLE;
 
-		flags |= PIPE_CONTROL_STORE_DATA_INDEX;
-		flags |= PIPE_CONTROL_QW_WRITE;
+		bit_group_1 |= PIPE_CONTROL_STORE_DATA_INDEX;
+		bit_group_1 |= PIPE_CONTROL_QW_WRITE;
 
-		flags |= PIPE_CONTROL_CS_STALL;
+		bit_group_1 |= PIPE_CONTROL_CS_STALL;
 
 		if (!HAS_3D_PIPELINE(engine->i915))
-			flags &= ~PIPE_CONTROL_3D_ARCH_FLAGS;
+			bit_group_1 &= ~PIPE_CONTROL_3D_ARCH_FLAGS;
 		else if (engine->class == COMPUTE_CLASS)
-			flags &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
+			bit_group_1 &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
 
 		cs = intel_ring_begin(rq, 6);
 		if (IS_ERR(cs))
 			return PTR_ERR(cs);
 
-		cs = gen12_emit_pipe_control(cs,
-					     PIPE_CONTROL0_HDC_PIPELINE_FLUSH,
-					     flags, LRC_PPHWSP_SCRATCH_ADDR);
+		cs = gen12_emit_pipe_control(cs, bit_group_0, bit_group_1,
+					     LRC_PPHWSP_SCRATCH_ADDR);
 		intel_ring_advance(rq, cs);
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.h b/drivers/gpu/drm/i915/gt/gen8_engine_cs.h
index 655e5c00ddc2..a44eda096557 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.h
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.h
@@ -49,25 +49,29 @@ u32 *gen12_emit_fini_breadcrumb_rcs(struct i915_request *rq, u32 *cs);
 u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv_reg);
 
 static inline u32 *
-__gen8_emit_pipe_control(u32 *batch, u32 flags0, u32 flags1, u32 offset)
+__gen8_emit_pipe_control(u32 *batch, u32 bit_group_0,
+			 u32 bit_group_1, u32 offset)
 {
 	memset(batch, 0, 6 * sizeof(u32));
 
-	batch[0] = GFX_OP_PIPE_CONTROL(6) | flags0;
-	batch[1] = flags1;
+	batch[0] = GFX_OP_PIPE_CONTROL(6) | bit_group_0;
+	batch[1] = bit_group_1;
 	batch[2] = offset;
 
 	return batch + 6;
 }
 
-static inline u32 *gen8_emit_pipe_control(u32 *batch, u32 flags, u32 offset)
+static inline u32 *gen8_emit_pipe_control(u32 *batch,
+					  u32 bit_group_1, u32 offset)
 {
-	return __gen8_emit_pipe_control(batch, 0, flags, offset);
+	return __gen8_emit_pipe_control(batch, 0, bit_group_1, offset);
 }
 
-static inline u32 *gen12_emit_pipe_control(u32 *batch, u32 flags0, u32 flags1, u32 offset)
+static inline u32 *gen12_emit_pipe_control(u32 *batch, u32 bit_group_0,
+					   u32 bit_group_1, u32 offset)
 {
-	return __gen8_emit_pipe_control(batch, flags0, flags1, offset);
+	return __gen8_emit_pipe_control(batch, bit_group_0,
+					bit_group_1, offset);
 }
 
 static inline u32 *

