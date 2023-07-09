Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89574C2B9
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjGILX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjGILX6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816EB90
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0172860BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F8AC433C7;
        Sun,  9 Jul 2023 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901836;
        bh=FsYL38Lg6mo+P1dW9U0WoXVn8cNFBgdXR+obqNHGfPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwvUKtNNqBWvBgwGXRgNsu7r+/wUKY2SjDaCElRN0f8SBLa5PBu0tgM4akeGpS6Ed
         I8kuDT36BzMXbmaKJztOnOqvyH/stQA1fG8Ugfe+iS7wymSnA3pCjXruaZbAjJ5sd4
         mGebnW/OxajPFUq9qjZypjKB31/6KQTO4kjqRk+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Harrison <John.C.Harrison@Intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 162/431] drm/i915/guc: More debug print updates - GuC SLPC
Date:   Sun,  9 Jul 2023 13:11:50 +0200
Message-ID: <20230709111454.973426993@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Harrison <John.C.Harrison@Intel.com>

[ Upstream commit 9847ffce9b5f83a7707504b0127aeb6a05dbd378 ]

Update a bunch more debug prints to use the new GT based scheme.

v2: Also change prints to use %pe for error values (MichalW).

Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230207050717.1833718-6-John.C.Harrison@Intel.com
Stable-dep-of: 55f9720dbf23 ("drm/i915/guc/slpc: Provide sysfs for efficient freq")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c   |  8 +--
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c | 61 ++++++++-------------
 2 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c
index 8f8dd05835c5a..1adec6de223c7 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c
@@ -6,6 +6,7 @@
 #include <linux/string_helpers.h>
 
 #include "intel_guc_rc.h"
+#include "intel_guc_print.h"
 #include "gt/intel_gt.h"
 #include "i915_drv.h"
 
@@ -59,13 +60,12 @@ static int __guc_rc_control(struct intel_guc *guc, bool enable)
 
 	ret = guc_action_control_gucrc(guc, enable);
 	if (ret) {
-		i915_probe_error(guc_to_gt(guc)->i915, "Failed to %s GuC RC (%pe)\n",
-				 str_enable_disable(enable), ERR_PTR(ret));
+		guc_probe_error(guc, "Failed to %s RC (%pe)\n",
+				str_enable_disable(enable), ERR_PTR(ret));
 		return ret;
 	}
 
-	drm_info(&gt->i915->drm, "GuC RC: %s\n",
-		 str_enabled_disabled(enable));
+	guc_info(guc, "RC %s\n", str_enabled_disabled(enable));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
index 63464933cbceb..026d73855f36c 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
@@ -9,6 +9,7 @@
 #include "i915_drv.h"
 #include "i915_reg.h"
 #include "intel_guc_slpc.h"
+#include "intel_guc_print.h"
 #include "intel_mchbar_regs.h"
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_regs.h"
@@ -171,14 +172,12 @@ static int guc_action_slpc_query(struct intel_guc *guc, u32 offset)
 static int slpc_query_task_state(struct intel_guc_slpc *slpc)
 {
 	struct intel_guc *guc = slpc_to_guc(slpc);
-	struct drm_i915_private *i915 = slpc_to_i915(slpc);
 	u32 offset = intel_guc_ggtt_offset(guc, slpc->vma);
 	int ret;
 
 	ret = guc_action_slpc_query(guc, offset);
 	if (unlikely(ret))
-		i915_probe_error(i915, "Failed to query task state (%pe)\n",
-				 ERR_PTR(ret));
+		guc_probe_error(guc, "Failed to query task state: %pe\n", ERR_PTR(ret));
 
 	drm_clflush_virt_range(slpc->vaddr, SLPC_PAGE_SIZE_BYTES);
 
@@ -188,15 +187,14 @@ static int slpc_query_task_state(struct intel_guc_slpc *slpc)
 static int slpc_set_param(struct intel_guc_slpc *slpc, u8 id, u32 value)
 {
 	struct intel_guc *guc = slpc_to_guc(slpc);
-	struct drm_i915_private *i915 = slpc_to_i915(slpc);
 	int ret;
 
 	GEM_BUG_ON(id >= SLPC_MAX_PARAM);
 
 	ret = guc_action_slpc_set_param(guc, id, value);
 	if (ret)
-		i915_probe_error(i915, "Failed to set param %d to %u (%pe)\n",
-				 id, value, ERR_PTR(ret));
+		guc_probe_error(guc, "Failed to set param %d to %u: %pe\n",
+				id, value, ERR_PTR(ret));
 
 	return ret;
 }
@@ -212,8 +210,8 @@ static int slpc_unset_param(struct intel_guc_slpc *slpc, u8 id)
 
 static int slpc_force_min_freq(struct intel_guc_slpc *slpc, u32 freq)
 {
-	struct drm_i915_private *i915 = slpc_to_i915(slpc);
 	struct intel_guc *guc = slpc_to_guc(slpc);
+	struct drm_i915_private *i915 = slpc_to_i915(slpc);
 	intel_wakeref_t wakeref;
 	int ret = 0;
 
@@ -236,9 +234,8 @@ static int slpc_force_min_freq(struct intel_guc_slpc *slpc, u32 freq)
 					SLPC_PARAM_GLOBAL_MIN_GT_UNSLICE_FREQ_MHZ,
 					freq);
 		if (ret)
-			drm_notice(&i915->drm,
-				   "Failed to send set_param for min freq(%d): (%d)\n",
-				   freq, ret);
+			guc_notice(guc, "Failed to send set_param for min freq(%d): %pe\n",
+				   freq, ERR_PTR(ret));
 	}
 
 	return ret;
@@ -267,7 +264,6 @@ static void slpc_boost_work(struct work_struct *work)
 int intel_guc_slpc_init(struct intel_guc_slpc *slpc)
 {
 	struct intel_guc *guc = slpc_to_guc(slpc);
-	struct drm_i915_private *i915 = slpc_to_i915(slpc);
 	u32 size = PAGE_ALIGN(sizeof(struct slpc_shared_data));
 	int err;
 
@@ -275,9 +271,7 @@ int intel_guc_slpc_init(struct intel_guc_slpc *slpc)
 
 	err = intel_guc_allocate_and_map_vma(guc, size, &slpc->vma, (void **)&slpc->vaddr);
 	if (unlikely(err)) {
-		i915_probe_error(i915,
-				 "Failed to allocate SLPC struct (err=%pe)\n",
-				 ERR_PTR(err));
+		guc_probe_error(guc, "Failed to allocate SLPC struct: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
@@ -338,7 +332,6 @@ static int guc_action_slpc_reset(struct intel_guc *guc, u32 offset)
 
 static int slpc_reset(struct intel_guc_slpc *slpc)
 {
-	struct drm_i915_private *i915 = slpc_to_i915(slpc);
 	struct intel_guc *guc = slpc_to_guc(slpc);
 	u32 offset = intel_guc_ggtt_offset(guc, slpc->vma);
 	int ret;
@@ -346,15 +339,14 @@ static int slpc_reset(struct intel_guc_slpc *slpc)
 	ret = guc_action_slpc_reset(guc, offset);
 
 	if (unlikely(ret < 0)) {
-		i915_probe_error(i915, "SLPC reset action failed (%pe)\n",
-				 ERR_PTR(ret));
+		guc_probe_error(guc, "SLPC reset action failed: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	if (!ret) {
 		if (wait_for(slpc_is_running(slpc), SLPC_RESET_TIMEOUT_MS)) {
-			i915_probe_error(i915, "SLPC not enabled! State = %s\n",
-					 slpc_get_state_string(slpc));
+			guc_probe_error(guc, "SLPC not enabled! State = %s\n",
+					slpc_get_state_string(slpc));
 			return -EIO;
 		}
 	}
@@ -495,8 +487,8 @@ int intel_guc_slpc_set_min_freq(struct intel_guc_slpc *slpc, u32 val)
 			     SLPC_PARAM_IGNORE_EFFICIENT_FREQUENCY,
 			     val < slpc->rp1_freq);
 	if (ret) {
-		i915_probe_error(i915, "Failed to toggle efficient freq (%pe)\n",
-				 ERR_PTR(ret));
+		guc_probe_error(slpc_to_guc(slpc), "Failed to toggle efficient freq: %pe\n",
+				ERR_PTR(ret));
 		goto out;
 	}
 
@@ -611,15 +603,12 @@ static int slpc_set_softlimits(struct intel_guc_slpc *slpc)
 
 static bool is_slpc_min_freq_rpmax(struct intel_guc_slpc *slpc)
 {
-	struct drm_i915_private *i915 = slpc_to_i915(slpc);
 	int slpc_min_freq;
 	int ret;
 
 	ret = intel_guc_slpc_get_min_freq(slpc, &slpc_min_freq);
 	if (ret) {
-		drm_err(&i915->drm,
-			"Failed to get min freq: (%d)\n",
-			ret);
+		guc_err(slpc_to_guc(slpc), "Failed to get min freq: %pe\n", ERR_PTR(ret));
 		return false;
 	}
 
@@ -685,9 +674,8 @@ int intel_guc_slpc_override_gucrc_mode(struct intel_guc_slpc *slpc, u32 mode)
 	with_intel_runtime_pm(&i915->runtime_pm, wakeref) {
 		ret = slpc_set_param(slpc, SLPC_PARAM_PWRGATE_RC_MODE, mode);
 		if (ret)
-			drm_err(&i915->drm,
-				"Override gucrc mode %d failed %d\n",
-				mode, ret);
+			guc_err(slpc_to_guc(slpc), "Override RC mode %d failed: %pe\n",
+				mode, ERR_PTR(ret));
 	}
 
 	return ret;
@@ -702,9 +690,7 @@ int intel_guc_slpc_unset_gucrc_mode(struct intel_guc_slpc *slpc)
 	with_intel_runtime_pm(&i915->runtime_pm, wakeref) {
 		ret = slpc_unset_param(slpc, SLPC_PARAM_PWRGATE_RC_MODE);
 		if (ret)
-			drm_err(&i915->drm,
-				"Unsetting gucrc mode failed %d\n",
-				ret);
+			guc_err(slpc_to_guc(slpc), "Unsetting RC mode failed: %pe\n", ERR_PTR(ret));
 	}
 
 	return ret;
@@ -725,7 +711,7 @@ int intel_guc_slpc_unset_gucrc_mode(struct intel_guc_slpc *slpc)
  */
 int intel_guc_slpc_enable(struct intel_guc_slpc *slpc)
 {
-	struct drm_i915_private *i915 = slpc_to_i915(slpc);
+	struct intel_guc *guc = slpc_to_guc(slpc);
 	int ret;
 
 	GEM_BUG_ON(!slpc->vma);
@@ -734,8 +720,7 @@ int intel_guc_slpc_enable(struct intel_guc_slpc *slpc)
 
 	ret = slpc_reset(slpc);
 	if (unlikely(ret < 0)) {
-		i915_probe_error(i915, "SLPC Reset event returned (%pe)\n",
-				 ERR_PTR(ret));
+		guc_probe_error(guc, "SLPC Reset event returned: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -743,7 +728,7 @@ int intel_guc_slpc_enable(struct intel_guc_slpc *slpc)
 	if (unlikely(ret < 0))
 		return ret;
 
-	intel_guc_pm_intrmsk_enable(to_gt(i915));
+	intel_guc_pm_intrmsk_enable(slpc_to_gt(slpc));
 
 	slpc_get_rp_values(slpc);
 
@@ -753,16 +738,14 @@ int intel_guc_slpc_enable(struct intel_guc_slpc *slpc)
 	/* Set SLPC max limit to RP0 */
 	ret = slpc_use_fused_rp0(slpc);
 	if (unlikely(ret)) {
-		i915_probe_error(i915, "Failed to set SLPC max to RP0 (%pe)\n",
-				 ERR_PTR(ret));
+		guc_probe_error(guc, "Failed to set SLPC max to RP0: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	/* Revert SLPC min/max to softlimits if necessary */
 	ret = slpc_set_softlimits(slpc);
 	if (unlikely(ret)) {
-		i915_probe_error(i915, "Failed to set SLPC softlimits (%pe)\n",
-				 ERR_PTR(ret));
+		guc_probe_error(guc, "Failed to set SLPC softlimits: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
-- 
2.39.2



