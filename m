Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6887037EE
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244147AbjEORZ1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244161AbjEORZM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D93AD22
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA3962C9F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC18C433EF;
        Mon, 15 May 2023 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171442;
        bh=byG0udeRT6QxyOVvEuQ6qi40lkuRkj6s4Jhm8Rz2kOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZPMaJkeUZ4QaAKMdx6sKzvvxcEjJp9slB6RP7k7BoZwZz6yf05tY4Fww4hAZr5zI
         KxvniEWvIck5QcWeihgKwWH07zJbZ2kYc4M6cvchG60QBJuaHdDqf1/0FWd590bfhI
         nqQ53bVqK2gcUkP/h2p2G07Jh8Qy3eH9EVJMRtcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Haridhar Kalvala <haridhar.kalvala@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 211/242] drm/i915/mtl: Add Wa_14017856879
Date:   Mon, 15 May 2023 18:28:57 +0200
Message-Id: <20230515161728.262059683@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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
index cd45a45066ccb..0c30738087a79 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1162,7 +1162,9 @@
 #define   THREAD_EX_ARB_MODE_RR_AFTER_DEP	REG_FIELD_PREP(THREAD_EX_ARB_MODE, 0x2)
 
 #define HSW_ROW_CHICKEN3			_MMIO(0xe49c)
+#define GEN9_ROW_CHICKEN3			MCR_REG(0xe49c)
 #define   HSW_ROW_CHICKEN3_L3_GLOBAL_ATOMICS_DISABLE	(1 << 6)
+#define   MTL_DISABLE_FIX_FOR_EOT_FLUSH		REG_BIT(9)
 
 #define GEN8_ROW_CHICKEN			MCR_REG(0xe4f0)
 #define   FLOW_CONTROL_ENABLE			REG_BIT(15)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 526fb9cc36b9b..09455682967de 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -3035,6 +3035,11 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 
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



