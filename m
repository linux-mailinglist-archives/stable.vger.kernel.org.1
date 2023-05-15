Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3857035C6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbjEORCo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243458AbjEORCT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592048A7D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2CBF62A32
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62252C4339E;
        Mon, 15 May 2023 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170018;
        bh=PPut6dtIJcJlxShP/lc91v5Nt1YB2mUvCf1jObvBFKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQWXHzqKiWx2pjc2ldyEDkz1L8RKnSeCWP4vJ/H/ie1FAqxmxZZJfqjxEhTdYjjaA
         ODvFdjxuqzqd+R1+EEc2xcQRjyTzW3pl2pJyH61RO2JD1qyuYNLxuw4UskdeiQopGa
         Bw9gA8MoGV3USttLkGAtcshCzSIrjTbAb2HQOoa8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Haridhar Kalvala <haridhar.kalvala@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 219/246] drm/i915/mtl: Add Wa_14017856879
Date:   Mon, 15 May 2023 18:27:11 +0200
Message-Id: <20230515161729.163333116@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Haridhar Kalvala <haridhar.kalvala@intel.com>

[ Upstream commit 4b51210f98c2b89ce37aede5b8dc5105be0572c6 ]

Wa_14017856879 implementation for mtl.

Bspec: 46046

Signed-off-by: Haridhar Kalvala <haridhar.kalvala@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230404173220.3175577-1-haridhar.kalvala@intel.com
Stable-dep-of: 81900e3a3775 ("drm/i915: disable sampler indirect state in bindless heap")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     | 2 ++
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 15b8636853ff0..72275749686aa 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1172,7 +1172,9 @@
 #define   THREAD_EX_ARB_MODE_RR_AFTER_DEP	REG_FIELD_PREP(THREAD_EX_ARB_MODE, 0x2)
 
 #define HSW_ROW_CHICKEN3			_MMIO(0xe49c)
+#define GEN9_ROW_CHICKEN3			MCR_REG(0xe49c)
 #define   HSW_ROW_CHICKEN3_L3_GLOBAL_ATOMICS_DISABLE	(1 << 6)
+#define   MTL_DISABLE_FIX_FOR_EOT_FLUSH		REG_BIT(9)
 
 #define GEN8_ROW_CHICKEN			MCR_REG(0xe4f0)
 #define   FLOW_CONTROL_ENABLE			REG_BIT(15)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index bfdffb6a013ce..b7c6c078dcc02 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -3015,6 +3015,11 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 
 	add_render_compute_tuning_settings(i915, wal);
 
+	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_B0, STEP_FOREVER) ||
+	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_B0, STEP_FOREVER))
+		/* Wa_14017856879 */
+		wa_mcr_masked_en(wal, GEN9_ROW_CHICKEN3, MTL_DISABLE_FIX_FOR_EOT_FLUSH);
+
 	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_A0, STEP_B0) ||
 	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_A0, STEP_B0))
 		/*
-- 
2.39.2



