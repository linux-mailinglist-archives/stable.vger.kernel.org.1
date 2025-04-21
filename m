Return-Path: <stable+bounces-134779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5AA95031
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA023B289D
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F821DD873;
	Mon, 21 Apr 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ERvyVwjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B63594C
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234859; cv=none; b=hhZUx+G8gK8Vrktl11HrFouIOPo2u+80UjmIkPUAs0eHWwmqzb1HvSPxrMdQgJM82buKENdua62m+ZBxeJDSHM/I9Ytli/nOKgdSugXqaG8SwP3o8gOCZFYlfV2qearmqfwJacul+BIa/5Whsb96GulaV8NVjl1fM6hTpNF00kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234859; c=relaxed/simple;
	bh=bUc5hVv56B8nGsISAt5YFSFCXSIyHzOKKB6onIHBVLQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M67IZyj1mzk/ML5ITdgyQq478vJrHCvTNxqd7z9HzrexsEoCLpkWU0jZdG3nAXHJJmp590og5ZLQMjArwkZXCVe0SiOhRB/1B8wP09JXuc7wn1hQ9LqkjtyuM/jWy4UEP7tOcVnR8g49uqzvYui/4Si8NIrDqI8zfS1i/Y92iYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ERvyVwjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB34C4CEE4;
	Mon, 21 Apr 2025 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745234859;
	bh=bUc5hVv56B8nGsISAt5YFSFCXSIyHzOKKB6onIHBVLQ=;
	h=Subject:To:Cc:From:Date:From;
	b=ERvyVwjX+fobJpuAOFOENXe/xwqSvyz/ZD1534Q0RiUwkA9SN5DjYvypHpjo5oPuw
	 OhTNFPy7JWE6hZHYYU++hCIJLD085pxmVG/UdUGtBf1ABuJ0CEAa5Pvdbx1wFEScW2
	 gAeoiLVHbe8J3uFiadntkMXlZqYbzUP0wQ0jbiqI=
Subject: FAILED: patch "[PATCH] accel/ivpu: Fix the NPU's DPU frequency calculation" failed to apply to 6.12-stable tree
To: Andrzej.Kacprowski@intel.com,jacek.lawrynowicz@linux.intel.com,jeff.hugo@oss.qualcomm.com,maciej.falkowski@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 13:27:36 +0200
Message-ID: <2025042136-unbeaten-duh-abe1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6c2b75404d33caa46a582f2791a70f92232adb71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042136-unbeaten-duh-abe1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c2b75404d33caa46a582f2791a70f92232adb71 Mon Sep 17 00:00:00 2001
From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
Date: Tue, 1 Apr 2025 17:59:11 +0200
Subject: [PATCH] accel/ivpu: Fix the NPU's DPU frequency calculation

Fix the frequency returned to the user space by
the DRM_IVPU_PARAM_CORE_CLOCK_RATE GET_PARAM IOCTL.
The kernel driver returned CPU frequency for MTL and bare
PLL frequency for LNL - this was inconsistent and incorrect
for both platforms. With this fix the driver returns maximum
frequency of the NPU data processing unit (DPU) for all HW
generations. This is what user space always expected.

Also do not set CPU frequency in boot params - the firmware
does not use frequency passed from the driver, it was only
used by the early pre-production firmware.
With that we can remove CPU frequency calculation code.

Show NPU frequency in FREQ_CHANGE interrupt when frequency
tracking is enabled.

Fixes: 8a27ad81f7d3 ("accel/ivpu: Split IP and buttress code")
Cc: stable@vger.kernel.org # v6.11+
Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://lore.kernel.org/r/20250401155912.4049340-2-maciej.falkowski@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 5e3888ff1022..eff1d3ca075f 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #include <linux/firmware.h>
@@ -164,7 +164,7 @@ static int ivpu_get_param_ioctl(struct drm_device *dev, void *data, struct drm_f
 		args->value = vdev->platform;
 		break;
 	case DRM_IVPU_PARAM_CORE_CLOCK_RATE:
-		args->value = ivpu_hw_ratio_to_freq(vdev, vdev->hw->pll.max_ratio);
+		args->value = ivpu_hw_dpu_max_freq_get(vdev);
 		break;
 	case DRM_IVPU_PARAM_NUM_CONTEXTS:
 		args->value = ivpu_get_context_count(vdev);
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 3799231b39e7..5e1d709c6a46 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #include <linux/firmware.h>
@@ -576,7 +576,6 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
 
 	boot_params->magic = VPU_BOOT_PARAMS_MAGIC;
 	boot_params->vpu_id = to_pci_dev(vdev->drm.dev)->bus->number;
-	boot_params->frequency = ivpu_hw_pll_freq_get(vdev);
 
 	/*
 	 * This param is a debug firmware feature.  It switches default clock
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index 16435f2756d0..6e67e736ef8e 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #ifndef __IVPU_HW_H__
@@ -82,9 +82,9 @@ static inline u64 ivpu_hw_range_size(const struct ivpu_addr_range *range)
 	return range->end - range->start;
 }
 
-static inline u32 ivpu_hw_ratio_to_freq(struct ivpu_device *vdev, u32 ratio)
+static inline u32 ivpu_hw_dpu_max_freq_get(struct ivpu_device *vdev)
 {
-	return ivpu_hw_btrs_ratio_to_freq(vdev, ratio);
+	return ivpu_hw_btrs_dpu_max_freq_get(vdev);
 }
 
 static inline void ivpu_hw_irq_clear(struct ivpu_device *vdev)
@@ -92,11 +92,6 @@ static inline void ivpu_hw_irq_clear(struct ivpu_device *vdev)
 	ivpu_hw_ip_irq_clear(vdev);
 }
 
-static inline u32 ivpu_hw_pll_freq_get(struct ivpu_device *vdev)
-{
-	return ivpu_hw_btrs_pll_freq_get(vdev);
-}
-
 static inline u32 ivpu_hw_profiling_freq_get(struct ivpu_device *vdev)
 {
 	return vdev->hw->pll.profiling_freq;
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index 56c56012b980..91eb8a93c15b 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
+#include <linux/units.h>
+
 #include "ivpu_drv.h"
 #include "ivpu_hw.h"
 #include "ivpu_hw_btrs.h"
@@ -28,17 +30,13 @@
 
 #define BTRS_LNL_ALL_IRQ_MASK ((u32)-1)
 
-#define BTRS_MTL_WP_CONFIG_1_TILE_5_3_RATIO WP_CONFIG(MTL_CONFIG_1_TILE, MTL_PLL_RATIO_5_3)
-#define BTRS_MTL_WP_CONFIG_1_TILE_4_3_RATIO WP_CONFIG(MTL_CONFIG_1_TILE, MTL_PLL_RATIO_4_3)
-#define BTRS_MTL_WP_CONFIG_2_TILE_5_3_RATIO WP_CONFIG(MTL_CONFIG_2_TILE, MTL_PLL_RATIO_5_3)
-#define BTRS_MTL_WP_CONFIG_2_TILE_4_3_RATIO WP_CONFIG(MTL_CONFIG_2_TILE, MTL_PLL_RATIO_4_3)
-#define BTRS_MTL_WP_CONFIG_0_TILE_PLL_OFF   WP_CONFIG(0, 0)
 
 #define PLL_CDYN_DEFAULT               0x80
 #define PLL_EPP_DEFAULT                0x80
 #define PLL_CONFIG_DEFAULT             0x0
-#define PLL_SIMULATION_FREQ            10000000
-#define PLL_REF_CLK_FREQ               50000000
+#define PLL_REF_CLK_FREQ               50000000ull
+#define PLL_RATIO_TO_FREQ(x)           ((x) * PLL_REF_CLK_FREQ)
+
 #define PLL_TIMEOUT_US		       (1500 * USEC_PER_MSEC)
 #define IDLE_TIMEOUT_US		       (5 * USEC_PER_MSEC)
 #define TIMEOUT_US                     (150 * USEC_PER_MSEC)
@@ -62,6 +60,8 @@
 #define DCT_ENABLE                     0x1
 #define DCT_DISABLE                    0x0
 
+static u32 pll_ratio_to_dpu_freq(struct ivpu_device *vdev, u32 ratio);
+
 int ivpu_hw_btrs_irqs_clear_with_0_mtl(struct ivpu_device *vdev)
 {
 	REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, BTRS_MTL_ALL_IRQ_MASK);
@@ -156,7 +156,7 @@ static int info_init_mtl(struct ivpu_device *vdev)
 
 	hw->tile_fuse = BTRS_MTL_TILE_FUSE_ENABLE_BOTH;
 	hw->sku = BTRS_MTL_TILE_SKU_BOTH;
-	hw->config = BTRS_MTL_WP_CONFIG_2_TILE_4_3_RATIO;
+	hw->config = WP_CONFIG(MTL_CONFIG_2_TILE, MTL_PLL_RATIO_4_3);
 
 	return 0;
 }
@@ -334,8 +334,8 @@ int ivpu_hw_btrs_wp_drive(struct ivpu_device *vdev, bool enable)
 
 	prepare_wp_request(vdev, &wp, enable);
 
-	ivpu_dbg(vdev, PM, "PLL workpoint request: %u Hz, config: 0x%x, epp: 0x%x, cdyn: 0x%x\n",
-		 PLL_RATIO_TO_FREQ(wp.target), wp.cfg, wp.epp, wp.cdyn);
+	ivpu_dbg(vdev, PM, "PLL workpoint request: %lu MHz, config: 0x%x, epp: 0x%x, cdyn: 0x%x\n",
+		 pll_ratio_to_dpu_freq(vdev, wp.target) / HZ_PER_MHZ, wp.cfg, wp.epp, wp.cdyn);
 
 	ret = wp_request_send(vdev, &wp);
 	if (ret) {
@@ -573,6 +573,39 @@ int ivpu_hw_btrs_wait_for_idle(struct ivpu_device *vdev)
 		return REGB_POLL_FLD(VPU_HW_BTRS_LNL_VPU_STATUS, IDLE, 0x1, IDLE_TIMEOUT_US);
 }
 
+static u32 pll_config_get_mtl(struct ivpu_device *vdev)
+{
+	return REGB_RD32(VPU_HW_BTRS_MTL_CURRENT_PLL);
+}
+
+static u32 pll_config_get_lnl(struct ivpu_device *vdev)
+{
+	return REGB_RD32(VPU_HW_BTRS_LNL_PLL_FREQ);
+}
+
+static u32 pll_ratio_to_dpu_freq_mtl(u16 ratio)
+{
+	return (PLL_RATIO_TO_FREQ(ratio) * 2) / 3;
+}
+
+static u32 pll_ratio_to_dpu_freq_lnl(u16 ratio)
+{
+	return PLL_RATIO_TO_FREQ(ratio) / 2;
+}
+
+static u32 pll_ratio_to_dpu_freq(struct ivpu_device *vdev, u32 ratio)
+{
+	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
+		return pll_ratio_to_dpu_freq_mtl(ratio);
+	else
+		return pll_ratio_to_dpu_freq_lnl(ratio);
+}
+
+u32 ivpu_hw_btrs_dpu_max_freq_get(struct ivpu_device *vdev)
+{
+	return pll_ratio_to_dpu_freq(vdev, vdev->hw->pll.max_ratio);
+}
+
 /* Handler for IRQs from Buttress core (irqB) */
 bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
 {
@@ -582,9 +615,12 @@ bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
 	if (!status)
 		return false;
 
-	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, FREQ_CHANGE, status))
-		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq: %08x",
-			 REGB_RD32(VPU_HW_BTRS_MTL_CURRENT_PLL));
+	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, FREQ_CHANGE, status)) {
+		u32 pll = pll_config_get_mtl(vdev);
+
+		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq, wp %08x, %lu MHz",
+			 pll, pll_ratio_to_dpu_freq_mtl(pll) / HZ_PER_MHZ);
+	}
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, ATS_ERR, status)) {
 		ivpu_err(vdev, "ATS_ERR irq 0x%016llx", REGB_RD64(VPU_HW_BTRS_MTL_ATS_ERR_LOG_0));
@@ -633,8 +669,12 @@ bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq)
 		queue_work(system_wq, &vdev->irq_dct_work);
 	}
 
-	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE, status))
-		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq: %08x", REGB_RD32(VPU_HW_BTRS_LNL_PLL_FREQ));
+	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE, status)) {
+		u32 pll = pll_config_get_lnl(vdev);
+
+		ivpu_dbg(vdev, IRQ, "FREQ_CHANGE irq, wp %08x, %lu MHz",
+			 pll, pll_ratio_to_dpu_freq_lnl(pll) / HZ_PER_MHZ);
+	}
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, ATS_ERR, status)) {
 		ivpu_err(vdev, "ATS_ERR LOG1 0x%08x ATS_ERR_LOG2 0x%08x\n",
@@ -717,60 +757,6 @@ void ivpu_hw_btrs_dct_set_status(struct ivpu_device *vdev, bool enable, u32 acti
 	REGB_WR32(VPU_HW_BTRS_LNL_PCODE_MAILBOX_STATUS, val);
 }
 
-static u32 pll_ratio_to_freq_mtl(u32 ratio, u32 config)
-{
-	u32 pll_clock = PLL_REF_CLK_FREQ * ratio;
-	u32 cpu_clock;
-
-	if ((config & 0xff) == MTL_PLL_RATIO_4_3)
-		cpu_clock = pll_clock * 2 / 4;
-	else
-		cpu_clock = pll_clock * 2 / 5;
-
-	return cpu_clock;
-}
-
-u32 ivpu_hw_btrs_ratio_to_freq(struct ivpu_device *vdev, u32 ratio)
-{
-	struct ivpu_hw_info *hw = vdev->hw;
-
-	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
-		return pll_ratio_to_freq_mtl(ratio, hw->config);
-	else
-		return PLL_RATIO_TO_FREQ(ratio);
-}
-
-static u32 pll_freq_get_mtl(struct ivpu_device *vdev)
-{
-	u32 pll_curr_ratio;
-
-	pll_curr_ratio = REGB_RD32(VPU_HW_BTRS_MTL_CURRENT_PLL);
-	pll_curr_ratio &= VPU_HW_BTRS_MTL_CURRENT_PLL_RATIO_MASK;
-
-	if (!ivpu_is_silicon(vdev))
-		return PLL_SIMULATION_FREQ;
-
-	return pll_ratio_to_freq_mtl(pll_curr_ratio, vdev->hw->config);
-}
-
-static u32 pll_freq_get_lnl(struct ivpu_device *vdev)
-{
-	u32 pll_curr_ratio;
-
-	pll_curr_ratio = REGB_RD32(VPU_HW_BTRS_LNL_PLL_FREQ);
-	pll_curr_ratio &= VPU_HW_BTRS_LNL_PLL_FREQ_RATIO_MASK;
-
-	return PLL_RATIO_TO_FREQ(pll_curr_ratio);
-}
-
-u32 ivpu_hw_btrs_pll_freq_get(struct ivpu_device *vdev)
-{
-	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
-		return pll_freq_get_mtl(vdev);
-	else
-		return pll_freq_get_lnl(vdev);
-}
-
 u32 ivpu_hw_btrs_telemetry_offset_get(struct ivpu_device *vdev)
 {
 	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.h b/drivers/accel/ivpu/ivpu_hw_btrs.h
index 1fd71b4d4ab0..a2f0877237e8 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #ifndef __IVPU_HW_BTRS_H__
@@ -13,7 +13,6 @@
 
 #define PLL_PROFILING_FREQ_DEFAULT   38400000
 #define PLL_PROFILING_FREQ_HIGH      400000000
-#define PLL_RATIO_TO_FREQ(x)         ((x) * PLL_REF_CLK_FREQ)
 
 #define DCT_DEFAULT_ACTIVE_PERCENT 15u
 #define DCT_PERIOD_US		   35300u
@@ -32,12 +31,11 @@ int ivpu_hw_btrs_ip_reset(struct ivpu_device *vdev);
 void ivpu_hw_btrs_profiling_freq_reg_set_lnl(struct ivpu_device *vdev);
 void ivpu_hw_btrs_ats_print_lnl(struct ivpu_device *vdev);
 void ivpu_hw_btrs_clock_relinquish_disable_lnl(struct ivpu_device *vdev);
+u32 ivpu_hw_btrs_dpu_max_freq_get(struct ivpu_device *vdev);
 bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq);
 bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq);
 int ivpu_hw_btrs_dct_get_request(struct ivpu_device *vdev, bool *enable);
 void ivpu_hw_btrs_dct_set_status(struct ivpu_device *vdev, bool enable, u32 dct_percent);
-u32 ivpu_hw_btrs_pll_freq_get(struct ivpu_device *vdev);
-u32 ivpu_hw_btrs_ratio_to_freq(struct ivpu_device *vdev, u32 ratio);
 u32 ivpu_hw_btrs_telemetry_offset_get(struct ivpu_device *vdev);
 u32 ivpu_hw_btrs_telemetry_size_get(struct ivpu_device *vdev);
 u32 ivpu_hw_btrs_telemetry_enable_get(struct ivpu_device *vdev);
diff --git a/include/uapi/drm/ivpu_accel.h b/include/uapi/drm/ivpu_accel.h
index 746c43bd3eb6..2f24103f4533 100644
--- a/include/uapi/drm/ivpu_accel.h
+++ b/include/uapi/drm/ivpu_accel.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2025 Intel Corporation
  */
 
 #ifndef __UAPI_IVPU_DRM_H__
@@ -147,7 +147,7 @@ struct drm_ivpu_param {
 	 * platform type when executing on a simulator or emulator (read-only)
 	 *
 	 * %DRM_IVPU_PARAM_CORE_CLOCK_RATE:
-	 * Current PLL frequency (read-only)
+	 * Maximum frequency of the NPU data processing unit clock (read-only)
 	 *
 	 * %DRM_IVPU_PARAM_NUM_CONTEXTS:
 	 * Maximum number of simultaneously existing contexts (read-only)


