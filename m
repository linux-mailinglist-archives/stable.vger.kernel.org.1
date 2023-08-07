Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2268A771B44
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjHGHMH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHGHMG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE910EC
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0FA612AF
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966A9C433C7;
        Mon,  7 Aug 2023 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392324;
        bh=35KeMli4rCNtl5Lb3j0SI+Q/ySLCAYzmLLz4l3q1ML4=;
        h=Subject:To:Cc:From:Date:From;
        b=RrSeQQADovpPsCTmz8fJCFfXLQyGr0S3BZpDK0c1wa+xdR1sd7TayyDFYC0YcDJ3Y
         GwPTjoHPJ8hBjm5HjxA7CqNse0K8FaOEtnhZtnDd6WA8+nKIKDUgyniYTuo6hucEeL
         3IDYNRNVRQhUZi/VNVpVT0tl3Z1Kte0eaUECbo90=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control and" failed to apply to 6.1-stable tree
To:     andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        jonathan.cavitt@intel.com, matthew.d.roper@intel.com,
        nirmoy.das@intel.com, stable@vger.kernel.org,
        tvrtko.ursulin@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:11:45 +0200
Message-ID: <2023080745-flashback-clavicle-561f@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 824df77ab2107d8d4740b834b276681a41ae1ac8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080745-flashback-clavicle-561f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

824df77ab210 ("drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control and in the CS")
592b228f12e1 ("drm/i915/gt: Rename flags with bit_group_X according to the datasheet")
78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before invalidation")
d922b80b1010 ("drm/i915/gt: Add workaround 14016712196")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 824df77ab2107d8d4740b834b276681a41ae1ac8 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@linux.intel.com>
Date: Tue, 25 Jul 2023 02:19:48 +0200
Subject: [PATCH] drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control and
 in the CS

Enable the CCS_FLUSH bit 13 in the control pipe for render and
compute engines in platforms starting from Meteor Lake (BSPEC
43904 and 47112).

For the copy engine add MI_FLUSH_DW_CCS (bit 16) in the command
streamer.

Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
Requires: 8da173db894a ("drm/i915/gt: Rename flags with bit_group_X according to the datasheet")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230725001950.1014671-6-andi.shyti@linux.intel.com
(cherry picked from commit b70df82b428774875c7c56d3808102165891547c)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 5d2175e918dd..ec54d36eaef7 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -230,6 +230,13 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 		bit_group_0 |= PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
 
+		/*
+		 * When required, in MTL and beyond platforms we
+		 * need to set the CCS_FLUSH bit in the pipe control
+		 */
+		if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
+			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
+
 		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
 		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
 		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
@@ -356,6 +363,10 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 		cmd |= MI_INVALIDATE_TLB;
 		if (rq->engine->class == VIDEO_DECODE_CLASS)
 			cmd |= MI_INVALIDATE_BSD;
+
+		if (gen12_needs_ccs_aux_inv(rq->engine) &&
+		    rq->engine->class == COPY_ENGINE_CLASS)
+			cmd |= MI_FLUSH_DW_CCS;
 	}
 
 	*cs++ = cmd;
diff --git a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
index 5d143e2a8db0..5df7cce23197 100644
--- a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
+++ b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
@@ -299,6 +299,7 @@
 #define   PIPE_CONTROL_QW_WRITE				(1<<14)
 #define   PIPE_CONTROL_POST_SYNC_OP_MASK                (3<<14)
 #define   PIPE_CONTROL_DEPTH_STALL			(1<<13)
+#define   PIPE_CONTROL_CCS_FLUSH			(1<<13) /* MTL+ */
 #define   PIPE_CONTROL_WRITE_FLUSH			(1<<12)
 #define   PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH	(1<<12) /* gen6+ */
 #define   PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE	(1<<11) /* MBZ on ILK */

