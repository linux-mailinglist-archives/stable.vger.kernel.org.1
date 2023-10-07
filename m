Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288457BC78D
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 14:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbjJGMdQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbjJGMdP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 08:33:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074FCB6
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 05:33:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88F3C433C9;
        Sat,  7 Oct 2023 12:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696681993;
        bh=EbrTfUug2+LzFXKyMcNruvdyGbgqdS4imbiWM0GPgtY=;
        h=Subject:To:Cc:From:Date:From;
        b=TTUb8bC905CHwtXud4BtLC/3rLwA985CGoLyxboxzQn1XG8YTBns3KFTxqv5uMVOa
         mHS+NxsG13x1snH0vWPBqkkMBD+vmyCwkoS+Eu356pf5DQ7s9TVVA8FFBuSVXxext2
         5UwZUAbNGBhbb91XFqtZs2EJAg5hxzNQMSD4Nduk=
Subject: FAILED: patch "[PATCH] drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval" failed to apply to 6.1-stable tree
To:     nirmoy.das@intel.com, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, jonathan.cavitt@intel.com,
        lucas.demarchi@intel.com, mark.janes@intel.com,
        matthew.d.roper@intel.com, prathap.kumar.valsan@intel.com,
        rodrigo.vivi@intel.com, stable@vger.kernel.org,
        tapani.palli@intel.com, tejas.upadhyay@intel.com,
        tvrtko.ursulin@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 07 Oct 2023 14:33:10 +0200
Message-ID: <2023100709-prototype-augmented-6ab7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
git cherry-pick -x 128c20eda73bd3e78505c574fb17adb46195c98b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100709-prototype-augmented-6ab7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

128c20eda73b ("drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval")
b70df82b4287 ("drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control and in the CS")
f2dcd21d5a22 ("drm/i915/gt: Rename flags with bit_group_X according to the datasheet")
ad8ebf12217e ("drm/i915/gt: Ensure memory quiesced before invalidation")
d922b80b1010 ("drm/i915/gt: Add workaround 14016712196")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 128c20eda73bd3e78505c574fb17adb46195c98b Mon Sep 17 00:00:00 2001
From: Nirmoy Das <nirmoy.das@intel.com>
Date: Tue, 26 Sep 2023 16:24:01 +0200
Subject: [PATCH] drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PIPE_CONTROL_FLUSH_L3 is not needed for aux invalidation
so don't set that.

Fixes: 78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before invalidation")
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
Cc: Tapani Pälli <tapani.palli@intel.com>
Cc: Mark Janes <mark.janes@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Acked-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Tested-by: Tapani Pälli <tapani.palli@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230926142401.25687-1-nirmoy.das@intel.com
(cherry picked from commit 03d681412b38558aefe4fb0f46e36efa94bb21ef)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index a4ff55aa5e55..7ad36198aab2 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -271,8 +271,17 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 		if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
 			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
 
+		/*
+		 * L3 fabric flush is needed for AUX CCS invalidation
+		 * which happens as part of pipe-control so we can
+		 * ignore PIPE_CONTROL_FLUSH_L3. Also PIPE_CONTROL_FLUSH_L3
+		 * deals with Protected Memory which is not needed for
+		 * AUX CCS invalidation and lead to unwanted side effects.
+		 */
+		if (mode & EMIT_FLUSH)
+			bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
+
 		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
-		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
 		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
 		bit_group_1 |= PIPE_CONTROL_DEPTH_CACHE_FLUSH;
 		/* Wa_1409600907:tgl,adl-p */

