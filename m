Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E42B75B94C
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 23:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGTVIk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 17:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTVIj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 17:08:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA11705
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 14:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689887318; x=1721423318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8PftsjpnhIbJM7cH1XP+PS2IDm3ZahoW3XZfOjq+elE=;
  b=mU8cMFQ5y8es9qc14/UzQ/962RHHiHI+5eEJwo2YX+Ji9iHEDnn/KK/8
   8Yi5fsd3TOqMEYH2F/3YSHlCPr19CPbQQX20suixD3SbdjPlBNIfInjA6
   msCU2s3RI51Ra1w/HDpWDX6olARJ6VOz14VwWCTmPb4fcRhH+Mmr3L5PP
   3qns7bEP3mtxdl+UKHZ1aE5XJXj4+R2oSp9gD03GeOVOhB7M7ES9SkQKC
   8m7/rRyXua/4hpiEF1hQmektlVLjqj+ADhfHxc7/EOpB0hmU5l0WjqbTP
   vtYvggpelX/xCGEx1cvM2lYPCYGETLXeD5jFX0hvqE33ArIpQrOSJ8TAU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370462386"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="370462386"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 14:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759704744"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="759704744"
Received: from sdene1-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.32.238])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 14:08:11 -0700
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
Subject: [PATCH v7 4/9] drm/i915/gt: Rename flags with bit_group_X according to the datasheet
Date:   Thu, 20 Jul 2023 23:07:32 +0200
Message-Id: <20230720210737.761400-5-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720210737.761400-1-andi.shyti@linux.intel.com>
References: <20230720210737.761400-1-andi.shyti@linux.intel.com>
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
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 34 +++++++++++++-----------
 drivers/gpu/drm/i915/gt/gen8_engine_cs.h | 18 ++++++++-----
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 5fbc3f630f32b..7566c89d9def3 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -207,7 +207,8 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 	 * table requires quiescing memory traffic beforehand
 	 */
 	if (mode & EMIT_FLUSH || HAS_AUX_CCS(engine->i915)) {
-		u32 flags = 0;
+		u32 bit_group_0 = 0;
+		u32 bit_group_1 = 0;
 		int err;
 		u32 *cs;
 
@@ -215,32 +216,33 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
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
index 655e5c00ddc27..a44eda096557c 100644
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
-- 
2.40.1

