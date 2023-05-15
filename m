Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED37037EF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbjEORZb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbjEORZO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:25:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3E712E8F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE5762CAD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5013C433D2;
        Mon, 15 May 2023 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171445;
        bh=2WJEHbltfK+962lN2ytJ9AYBAltXnSy/AHNXzKm6IQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ns8QkAI28MP9PiHfJ+YoICbF5chIUf2vQibxCJ7j7R5oqS+FtZx9/cWAqNS+wqyZb
         5tpH4kUq4lq9W4v/kwscO50B0XoF4pFvdgElnGXQ6bE1ugR1c9BQNW3E3AZXaEg0cQ
         z1w+xQu1EiFHcgzqZknUulTTY1PH0IbMmAYlOSnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Haridhar Kalvala <haridhar.kalvala@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 212/242] drm/i915: disable sampler indirect state in bindless heap
Date:   Mon, 15 May 2023 18:28:58 +0200
Message-Id: <20230515161728.290726011@linuxfoundation.org>
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

From: Lionel Landwerlin <lionel.g.landwerlin@intel.com>

[ Upstream commit 81900e3a37750d8c6ad705045310e002f6dd0356 ]

By default the indirect state sampler data (border colors) are stored
in the same heap as the SAMPLER_STATE structure. For userspace drivers
that can be 2 different heaps (dynamic state heap & bindless sampler
state heap). This means that border colors have to copied in 2
different places so that the same SAMPLER_STATE structure find the
right data.

This change is forcing the indirect state sampler data to only be in
the dynamic state pool (more convenient for userspace drivers, they
only have to have one copy of the border colors). This is reproducing
the behavior of the Windows drivers.

BSpec: 46052

Signed-off-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Haridhar Kalvala <haridhar.kalvala@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230407093237.3296286-1-lionel.g.landwerlin@intel.com
(cherry picked from commit 16fc9c08f0ec7b1c95f1ea4a16097acdb3fc943d)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  1 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 0c30738087a79..1d96c36f9efc2 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1136,6 +1136,7 @@
 #define   SC_DISABLE_POWER_OPTIMIZATION_EBB	REG_BIT(9)
 #define   GEN11_SAMPLER_ENABLE_HEADLESS_MSG	REG_BIT(5)
 #define   MTL_DISABLE_SAMPLER_SC_OOO		REG_BIT(3)
+#define   GEN11_INDIRECT_STATE_BASE_ADDR_OVERRIDE	REG_BIT(0)
 
 #define GEN9_HALF_SLICE_CHICKEN7		MCR_REG(0xe194)
 #define   DG2_DISABLE_ROUND_ENABLE_ALLOW_FOR_SSLA	REG_BIT(15)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 09455682967de..620071efb2fc1 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -3035,6 +3035,25 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 
 	add_render_compute_tuning_settings(i915, wal);
 
+	if (GRAPHICS_VER(i915) >= 11) {
+		/* This is not a Wa (although referred to as
+		 * WaSetInidrectStateOverride in places), this allows
+		 * applications that reference sampler states through
+		 * the BindlessSamplerStateBaseAddress to have their
+		 * border color relative to DynamicStateBaseAddress
+		 * rather than BindlessSamplerStateBaseAddress.
+		 *
+		 * Otherwise SAMPLER_STATE border colors have to be
+		 * copied in multiple heaps (DynamicStateBaseAddress &
+		 * BindlessSamplerStateBaseAddress)
+		 *
+		 * BSpec: 46052
+		 */
+		wa_mcr_masked_en(wal,
+				 GEN10_SAMPLER_MODE,
+				 GEN11_INDIRECT_STATE_BASE_ADDR_OVERRIDE);
+	}
+
 	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_B0, STEP_FOREVER) ||
 	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_B0, STEP_FOREVER))
 		/* Wa_14017856879 */
-- 
2.39.2



