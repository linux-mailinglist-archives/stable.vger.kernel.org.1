Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AAC75CE1C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGUQSQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjGUQRm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:17:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB3C49FA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689956196; x=1721492196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+Ziei3JN9f9wklyKG1NVut1LdpdjdaYQTvQ5zK2uuo=;
  b=Oc7dntrjI5XKzDW3Mfdv6+elYL5e/BWfyzRrCoo+T34dnLq0kA+wQDUg
   ayfqPtTqYIQCWSyUa+nng1soSsXIM+xgbcl/3ylIqQ0Q6I/869kLryfWt
   CCTpKvSYCYIL7YzPE4gAX8kLA7R5OxwHOjGM/kJ/kbpe0h1GHSY+FlqCo
   0sFIdGkjHt3o2RKFwwNEsiMDJp7Xq4VrkCCteqrBL+SLeugNeczJ7r6Lp
   oRU1ZmyruDhUOESVjxRg3E/SR6HX3IDoVG8joDW8BZgutURr3Hqqqoey+
   8+XRoBxXRMWIWLYZeFLJ50jExD/Emx1Mk08hscSsulXojylzB8fJRLcOg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433292060"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="433292060"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="675095457"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="675095457"
Received: from hbockhor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:16:01 -0700
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
Subject: [PATCH v8 6/9] drm/i915/gt: Refactor intel_emit_pipe_control_cs() in a single function
Date:   Fri, 21 Jul 2023 18:15:11 +0200
Message-Id: <20230721161514.818895-7-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721161514.818895-1-andi.shyti@linux.intel.com>
References: <20230721161514.818895-1-andi.shyti@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Just a trivial refactoring for reducing the number of code
duplicate. This will come at handy in the next commits.

Meantime, propagate the error to the above layers if we fail to
emit the pipe control.

Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 47 +++++++++++++-----------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 139a7e69f5c4d..5e19b45a5cabe 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -7,6 +7,7 @@
 #include "i915_drv.h"
 #include "intel_engine_regs.h"
 #include "intel_gpu_commands.h"
+#include "intel_gt_print.h"
 #include "intel_lrc.h"
 #include "intel_ring.h"
 
@@ -189,23 +190,30 @@ u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv
 	return cs;
 }
 
+static int gen12_emit_pipe_control_cs(struct i915_request *rq, u32 bit_group_0,
+				      u32 bit_group_1, u32 offset)
+{
+	u32 *cs;
+
+	cs = intel_ring_begin(rq, 6);
+	if (IS_ERR(cs))
+		return PTR_ERR(cs);
+
+	cs = gen12_emit_pipe_control(cs, bit_group_0, bit_group_1,
+				     LRC_PPHWSP_SCRATCH_ADDR);
+	intel_ring_advance(rq, cs);
+
+	return 0;
+}
+
 static int mtl_dummy_pipe_control(struct i915_request *rq)
 {
 	/* Wa_14016712196 */
 	if (IS_MTL_GRAPHICS_STEP(rq->engine->i915, M, STEP_A0, STEP_B0) ||
-	    IS_MTL_GRAPHICS_STEP(rq->engine->i915, P, STEP_A0, STEP_B0)) {
-		u32 *cs;
-
-		/* dummy PIPE_CONTROL + depth flush */
-		cs = intel_ring_begin(rq, 6);
-		if (IS_ERR(cs))
-			return PTR_ERR(cs);
-		cs = gen12_emit_pipe_control(cs,
-					     0,
-					     PIPE_CONTROL_DEPTH_CACHE_FLUSH,
-					     LRC_PPHWSP_SCRATCH_ADDR);
-		intel_ring_advance(rq, cs);
-	}
+	    IS_MTL_GRAPHICS_STEP(rq->engine->i915, P, STEP_A0, STEP_B0))
+		return gen12_emit_pipe_control_cs(rq, 0,
+					PIPE_CONTROL_DEPTH_CACHE_FLUSH,
+					LRC_PPHWSP_SCRATCH_ADDR);
 
 	return 0;
 }
@@ -222,7 +230,6 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 		u32 bit_group_0 = 0;
 		u32 bit_group_1 = 0;
 		int err;
-		u32 *cs;
 
 		err = mtl_dummy_pipe_control(rq);
 		if (err)
@@ -256,13 +263,11 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 		else if (engine->class == COMPUTE_CLASS)
 			bit_group_1 &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
 
-		cs = intel_ring_begin(rq, 6);
-		if (IS_ERR(cs))
-			return PTR_ERR(cs);
-
-		cs = gen12_emit_pipe_control(cs, bit_group_0, bit_group_1,
-					     LRC_PPHWSP_SCRATCH_ADDR);
-		intel_ring_advance(rq, cs);
+		err = gen12_emit_pipe_control_cs(rq, bit_group_0, bit_group_1,
+						 LRC_PPHWSP_SCRATCH_ADDR);
+		if (err)
+			gt_warn(engine->gt,
+				"Failed to emit flush pipe control\n");
 	}
 
 	if (mode & EMIT_INVALIDATE) {
-- 
2.40.1

