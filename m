Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237BC75B4DF
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGTQpw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGTQpv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 12:45:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1102E43
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689871551; x=1721407551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=38AwnkN0YumeQq7fsgxzoNRm6OrTqRhepcQQhd9/NFA=;
  b=Hst3GwyYAbtGqCjiikcv/eKIuiyW6PmrO8mp+u/PRohroAItBm0CEBtZ
   VJzJTvrK3gg8qQlo2p1cHRIz4SFF2E2HwwmW2anIdJ83OSfSY74rBP9J4
   ws8PjdfLZyvfLmjdB1+3muGeyXNy5MI1YCkGx+KTbPABd1oV2N6iMG3C6
   359S1G9XSR75iG+HcwlbHwbxLV34I91qpDQIFaLBbJ6SL2h5BMP0MMh6N
   uFmztL/1gYi1xSaYMRBLBdu8Q6cA9oYwyBc1gAtc7Z7RnFYlCr/KNRCqq
   6XEAmFQT0V3ubcqbGM1iKWMBqNLS60Jkme60RiltjcEvYzhMGR50okhNq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="347104995"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="347104995"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="674747896"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="674747896"
Received: from sdene1-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.32.238])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:45:47 -0700
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-evel <dri-devel@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v6 7/9] drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control
Date:   Thu, 20 Jul 2023 18:44:52 +0200
Message-Id: <20230720164454.757075-8-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720164454.757075-1-andi.shyti@linux.intel.com>
References: <20230720164454.757075-1-andi.shyti@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Enable the CCS_FLUSH bit 13 in the control pipe for render and
compute engines in platforms starting from Meteor Lake (BSPEC
43904 and 47112). The VE and BCS engines need to add the flush
part in their command streamer.

Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c     | 31 ++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 3bedab8d61db1..78bbd55262a2d 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -225,6 +225,13 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 		bit_group_0 |= PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
 
+		/*
+		 * When required, in MTL+ platforms we need to
+		 * set the CCS_FLUSH bit in the pipe control
+		 */
+		if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
+			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
+
 		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
 		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
 		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
@@ -309,6 +316,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 {
 	intel_engine_mask_t aux_inv = 0;
+	u32 cmd_flush = 0;
 	u32 cmd = 4;
 	u32 *cs;
 
@@ -339,6 +347,13 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 			bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
 			bit_group_1 |= PIPE_CONTROL_CS_STALL;
 
+			/*
+			 * When required, in MTL+ platforms we need to
+			 * set the CCS_FLUSH bit in the pipe control
+			 */
+			if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
+				bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
+
 			intel_emit_pipe_control_cs(rq, bit_group_0, bit_group_1,
 						   LRC_PPHWSP_SCRATCH_ADDR);
 
@@ -346,7 +361,18 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 
 		case VIDEO_ENHANCEMENT_CLASS:
 		case COMPUTE_CLASS:
+			cmd += 2;
+			cmd_flush = MI_FLUSH_DW;
+
+			break;
+
 		case COPY_ENGINE_CLASS:
+			cmd += 2;
+			/*
+			 * When required, in MTL+ platforms we need to
+			 * set the CCS_FLUSH bit in the pipe control
+			 */
+			cmd_flush = MI_FLUSH_DW | MI_FLUSH_DW_CCS;
 			break;
 		}
 	}
@@ -355,6 +381,11 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 	if (IS_ERR(cs))
 		return PTR_ERR(cs);
 
+	if (cmd_flush) {
+		*cs++ = cmd_flush;
+		*cs++ = 0;
+	}
+
 	if (mode & EMIT_INVALIDATE)
 		*cs++ = preparser_disable(true);
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
index 5d143e2a8db03..5df7cce23197c 100644
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
-- 
2.40.1

