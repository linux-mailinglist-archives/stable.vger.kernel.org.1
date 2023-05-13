Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E607014C3
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjEMGrS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjEMGrR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EFC2D48
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E25A61B47
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C9EC433D2;
        Sat, 13 May 2023 06:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683960435;
        bh=mQX2EzDG7WPt1zeaNES6MupKRhyYsUohwBrfX0cpvcI=;
        h=Subject:To:Cc:From:Date:From;
        b=ORJ8ZUVm7zv/dacE+tdFhwY1E+B9FxQE+LM1dseN1xEz97XrL4ry/F3XTaW/oJUio
         53wLA/sm6K5F0X57QoliV9eak1pYMEbouX+HPqt3NjILpHVy1dyk0DOWmiqRm2wVTu
         3eUrLYF0xVhUzZ3YxbMoy07hWGtLAPO6HNE2bvOc=
Subject: FAILED: patch "[PATCH] drm/i915: disable sampler indirect state in bindless heap" failed to apply to 6.2-stable tree
To:     lionel.g.landwerlin@intel.com, haridhar.kalvala@intel.com,
        joonas.lahtinen@linux.intel.com, matthew.d.roper@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:46:30 +0900
Message-ID: <2023051330-endanger-twistable-6c02@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x 81900e3a37750d8c6ad705045310e002f6dd0356
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051330-endanger-twistable-6c02@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

81900e3a3775 ("drm/i915: disable sampler indirect state in bindless heap")
4b51210f98c2 ("drm/i915/mtl: Add Wa_14017856879")
5fba65efa7cf ("drm/i915/mtl: Add workarounds Wa_14017066071 and Wa_14017654203")
41bb543f5598 ("drm/i915/mtl: Add initial gt workarounds")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81900e3a37750d8c6ad705045310e002f6dd0356 Mon Sep 17 00:00:00 2001
From: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Date: Fri, 7 Apr 2023 12:32:37 +0300
Subject: [PATCH] drm/i915: disable sampler indirect state in bindless heap

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

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 492b3de6678d..fd1f9cd35e9d 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1145,6 +1145,7 @@
 #define   SC_DISABLE_POWER_OPTIMIZATION_EBB	REG_BIT(9)
 #define   GEN11_SAMPLER_ENABLE_HEADLESS_MSG	REG_BIT(5)
 #define   MTL_DISABLE_SAMPLER_SC_OOO		REG_BIT(3)
+#define   GEN11_INDIRECT_STATE_BASE_ADDR_OVERRIDE	REG_BIT(0)
 
 #define GEN9_HALF_SLICE_CHICKEN7		MCR_REG(0xe194)
 #define   DG2_DISABLE_ROUND_ENABLE_ALLOW_FOR_SSLA	REG_BIT(15)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 6ea453ddd011..b925ef47304b 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2971,6 +2971,25 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 
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

