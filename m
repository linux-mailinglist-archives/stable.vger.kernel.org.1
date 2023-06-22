Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847A73A83C
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 20:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjFVS2Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFVS2Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 14:28:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6340A211D
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458489; x=1718994489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oDGnrM8mPdOzz/LaBZ/fq0QjNJDKpZ9c/B2SP3KZECM=;
  b=LlQhg57prxkw8VnFL7gfHmVa6yzek+1D9k++4wU7eea/KDAZJjDYuSqI
   MKcjxi0Lwru47IXX7QYQXz1rmLZUAiWhMiQfMf+OV0ZiiZ9UEm3VDH85d
   YW+VKpB9lqFtfmQvxNfTUCCmR1L0oVeVWH+MgoB/oO3FeNBWTa+L66ezr
   gTlSQ1UsGsYuyQP/MSU/t0QOKn1442c5CBdFDaVQZtvyEunSK+ehhqNmD
   tH+dTSjIr8lOkX1dz5doOmmIf9YebK4F0kFou7Q+12Dh1ir8YezFwS4Hg
   lQ9tjMsCzqj1r5svoRBDdecswrn1nVUyxAq87a/MW+W7B5iEwGOc+/no6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359437773"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="359437773"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:27:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="780345383"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="780345383"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:27:44 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Kenneth Graunke <kenneth@whitecape.org>,
        Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/3] drm/i915/gt: Fix context workarounds with non-masked regs
Date:   Thu, 22 Jun 2023 11:27:30 -0700
Message-Id: <20230622182731.3765039-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622182731.3765039-1-lucas.demarchi@intel.com>
References: <20230622182731.3765039-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Most of the context workarounds tweak masked registers, but not all. For
masked registers, when writing the value it's sufficient to just write
the wa->set_bits since that will take care of both the clr and set bits
as well as not overwriting other bits.

However there are some workarounds, the registers are non-masked. Up
until now the driver was simply emitting a MI_LOAD_REGISTER_IMM with the
set_bits to program the register via the GPU in the WA bb. This has the
side effect of overwriting the content of the register outside of bits
that should be set and also doesn't handle the bits that should be
cleared.

Kenneth reported that on DG2, mesa was seeing a weird behavior due to
the kernel programming of L3SQCREG5 in dg2_ctx_gt_tuning_init(). With
the GPU idle, that register could be read via intel_reg as 0x00e001ff,
but during a 3D workload it would change to 0x0000007f. So the
programming of that tuning was affecting more than the bits in
L3_PWM_TIMER_INIT_VAL_MASK. Matt Roper noticed the lack of rmw for the
context workarounds due to the use of MI_LOAD_REGISTER_IMM.

So, for registers that are not masked, read its value via mmio, modify
and then set it in the buffer to be written by the GPU. This should take
care in a simple way of programming just the bits required by the
tuning/workaround. If in future there are registers that involved that
can't be read by the CPU, a more complex approach may be required like
a) issuing additional instructions to read and modify; or b) scan the
golden context and patch it in place before saving it; or something
else. But for now this should suffice.

Scanning the context workarounds for all platforms, these are the
impacted ones with the respective registers

	mtl: DRAW_WATERMARK
	mtl/dg2: XEHP_L3SQCREG5, XEHP_FF_MODE2
	gen12: GEN12_FF_MODE2

ICL has some non-masked registers in the context workarounds:
GEN8_L3CNTLREG, IVB_FBC_RT_BASE and VB_FBC_RT_BASE_UPPER, but there
shouldn't be an impact. The first is already being manually read and the
other 2 are intentionally overwriting the entire register.

Cc: Kenneth Graunke <kenneth@whitecape.org>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: stable@vger.kernel.org # v5.7+
Link: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23783#note_1968971
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 27 ++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 0578fc2c9e60..a013f245a790 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -1003,6 +1003,9 @@ void intel_engine_init_ctx_wa(struct intel_engine_cs *engine)
 int intel_engine_emit_ctx_wa(struct i915_request *rq)
 {
 	struct i915_wa_list *wal = &rq->engine->ctx_wa_list;
+	struct intel_uncore *uncore = rq->engine->uncore;
+	enum forcewake_domains fw;
+	unsigned long flags;
 	struct i915_wa *wa;
 	unsigned int i;
 	u32 *cs;
@@ -1019,13 +1022,35 @@ int intel_engine_emit_ctx_wa(struct i915_request *rq)
 	if (IS_ERR(cs))
 		return PTR_ERR(cs);
 
+	fw = wal_get_fw_for_rmw(uncore, wal);
+
+	intel_gt_mcr_lock(wal->gt, &flags);
+	spin_lock(&uncore->lock);
+	intel_uncore_forcewake_get__locked(uncore, fw);
+
 	*cs++ = MI_LOAD_REGISTER_IMM(wal->count);
 	for (i = 0, wa = wal->list; i < wal->count; i++, wa++) {
+		u32 val;
+
+		if (wa->masked_reg || wa->set == U32_MAX) {
+			val = wa->set;
+		} else {
+			val = wa->is_mcr ?
+				intel_gt_mcr_read_any_fw(wal->gt, wa->mcr_reg) :
+				intel_uncore_read_fw(uncore, wa->reg);
+			val &= ~wa->clr;
+			val |= wa->set;
+		}
+
 		*cs++ = i915_mmio_reg_offset(wa->reg);
-		*cs++ = wa->set;
+		*cs++ = val;
 	}
 	*cs++ = MI_NOOP;
 
+	intel_uncore_forcewake_put__locked(uncore, fw);
+	spin_unlock(&uncore->lock);
+	intel_gt_mcr_unlock(wal->gt, flags);
+
 	intel_ring_advance(rq, cs);
 
 	ret = rq->engine->emit_flush(rq, EMIT_BARRIER);
-- 
2.40.1

