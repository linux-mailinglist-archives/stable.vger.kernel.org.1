Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36F75B4DE
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 18:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGTQpw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGTQpv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 12:45:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A731B9
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689871550; x=1721407550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lZKyXR21ywDPXXELptJ4wqF4vkxC84X1KeZO6mk2rZ0=;
  b=dXUDM1e5jqOkVrhSbNmUy3fRXHLa4y3ZfxKe5U1Tvvtxq9df4SY0u6LF
   dUOzX+qphFlr3Cr4n3hXS+pNanHocTOiJDMH1EfBdsmvjNSgmspy7zn/f
   jneF0VuCHtuRmYFK+z+49WQbaeDlU+24unQWXTTDN1g57iRILFNt7uOsS
   +Vsy6WrIb9O4SIBsfMK6WD+nuNKZfQkq4hKPkYG0rU1vLhqP9wU/QF1xv
   oDnvNcrWt56ijpFLXltI9nkTQpanrc/JKHoEpnVME7G0kZFGXxxjAeaQn
   kcqhZxoknh5xcgd5s+CpRXWL57yGcS/529GBro8HeSLABBISOf9KnREjT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351680823"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="351680823"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="754115931"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="754115931"
Received: from sdene1-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.32.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:45:41 -0700
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
Subject: [PATCH v6 6/9] drm/i915/gt: Ensure memory quiesced before invalidation for all engines
Date:   Thu, 20 Jul 2023 18:44:51 +0200
Message-Id: <20230720164454.757075-7-andi.shyti@linux.intel.com>
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

Commit af9e423a8aae ("drm/i915/gt: Ensure memory quiesced before
invalidation") has made sure that the memory is quiesced before
invalidating the AUX CCS table. Do it for all the other engines
and not just RCS.

Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 46 ++++++++++++++++++------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 1b1dadacfbf42..3bedab8d61db1 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -309,19 +309,45 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 {
 	intel_engine_mask_t aux_inv = 0;
-	u32 cmd, *cs;
+	u32 cmd = 4;
+	u32 *cs;
 
-	cmd = 4;
-	if (mode & EMIT_INVALIDATE) {
+	if (mode & EMIT_INVALIDATE)
 		cmd += 2;
 
-		if (HAS_AUX_CCS(rq->engine->i915) &&
-		    (rq->engine->class == VIDEO_DECODE_CLASS ||
-		     rq->engine->class == VIDEO_ENHANCEMENT_CLASS)) {
-			aux_inv = rq->engine->mask &
-				~GENMASK(_BCS(I915_MAX_BCS - 1), BCS0);
-			if (aux_inv)
-				cmd += 4;
+	if (HAS_AUX_CCS(rq->engine->i915))
+		aux_inv = rq->engine->mask &
+			  ~GENMASK(_BCS(I915_MAX_BCS - 1), BCS0);
+
+	/*
+	 * On Aux CCS platforms the invalidation of the Aux
+	 * table requires quiescing memory traffic beforehand
+	 */
+	if (aux_inv) {
+		u32 bit_group_0 = 0;
+		u32 bit_group_1 = 0;
+
+		cmd += 4;
+
+		bit_group_0 |= PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
+
+		switch (rq->engine->class) {
+		case VIDEO_DECODE_CLASS:
+			bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
+			bit_group_1 |= PIPE_CONTROL_DEPTH_CACHE_FLUSH;
+			bit_group_1 |= PIPE_CONTROL_DC_FLUSH_ENABLE;
+			bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
+			bit_group_1 |= PIPE_CONTROL_CS_STALL;
+
+			intel_emit_pipe_control_cs(rq, bit_group_0, bit_group_1,
+						   LRC_PPHWSP_SCRATCH_ADDR);
+
+			break;
+
+		case VIDEO_ENHANCEMENT_CLASS:
+		case COMPUTE_CLASS:
+		case COPY_ENGINE_CLASS:
+			break;
 		}
 	}
 
-- 
2.40.1

