Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF11E7603CC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 02:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGYAUd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 20:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGYAUb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 20:20:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61861728
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 17:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690244430; x=1721780430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jP7hgRfapXywhiqSwhZDfIrQP+WmN++VSHr5kBnsoh0=;
  b=cTT6ZFMxUufJ7pbc8fSjJx834/Hslt2ss7m6ZkaG5KGYlcF1g9mmx/nc
   LpHOoF/wECvBq+SapU3EP8HaF6spfL8Cc4s98KlWPUj2Q2nyLCJNgSBoA
   sqzpDHkusk/fhX7M/Q0gaSLBc+v8kW78+tHRC5xw5MRNfTNkSnBDY0Mto
   AJBMMX3Tz10OA2R/dVWQsWZRAs74HavryFjpYdRQaNnwTPR7BYY/R0npZ
   i/JirX8dW8KgOQbDUtGg9xTqjHrbPTTXT6LLMTQrVR5Y16/VFbOb5hq/3
   nfFupeXttX9+blxcbSEqbwjw9dEi+Kp7q6Ad53Ru1mFBiTfT8M/UmZAeN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365043818"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="365043818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 17:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="791159978"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="791159978"
Received: from gionescu-mobl2.ger.corp.intel.com (HELO intel.com) ([10.252.34.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 17:20:26 -0700
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v9 2/7] drm/i915: Add the gen12_needs_ccs_aux_inv helper
Date:   Tue, 25 Jul 2023 02:19:45 +0200
Message-Id: <20230725001950.1014671-3-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725001950.1014671-1-andi.shyti@linux.intel.com>
References: <20230725001950.1014671-1-andi.shyti@linux.intel.com>
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
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 0bd9976966746..46744f9660771 100644
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
 
-		if (!HAS_FLAT_CCS(rq->i915))
+		if (gen12_needs_ccs_aux_inv(rq->engine))
 			count = 8 + 4;
 		else
 			count = 8;
@@ -285,7 +297,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 		cs = gen8_emit_pipe_control(cs, flags, LRC_PPHWSP_SCRATCH_ADDR);
 
-		if (!HAS_FLAT_CCS(rq->i915)) {
+		if (gen12_needs_ccs_aux_inv(rq->engine)) {
 			/* hsdes: 1809175790 */
 			cs = gen12_emit_aux_table_inv(rq->engine->gt, cs,
 						      GEN12_CCS_AUX_INV);
@@ -307,7 +319,7 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
 	if (mode & EMIT_INVALIDATE) {
 		cmd += 2;
 
-		if (!HAS_FLAT_CCS(rq->i915) &&
+		if (gen12_needs_ccs_aux_inv(rq->engine) &&
 		    (rq->engine->class == VIDEO_DECODE_CLASS ||
 		     rq->engine->class == VIDEO_ENHANCEMENT_CLASS)) {
 			aux_inv = rq->engine->mask &
-- 
2.40.1

