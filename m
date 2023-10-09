Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730E37BE03B
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377254AbjJINiS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377275AbjJINiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:38:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848199
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:38:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B8FC433C7;
        Mon,  9 Oct 2023 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858693;
        bh=172FRMoyvJgLHMb1D7wPHrvJ837JJlFqqz/A0trJ1dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgQWMYrCdpO9baEbXKTtaERI19WYRpHYB5f0KfvJbVtBPjSB9gJVN9c+BQyyFnFCS
         lHWhIV1F9Ms4odkpxuzt57hT3Vu/ingvTMQUg40iNDJz7ND11wig8+rR+q2MSgyRUe
         FPkBDyROg+xbNj99k2KFIrZIqVlZttCGr95eI5HI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 071/226] media: venus: hfi,pm,firmware: Convert to block relative addressing
Date:   Mon,  9 Oct 2023 15:00:32 +0200
Message-ID: <20231009130128.640591787@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit ff2a7013b3e6a3d34d2b5c7786b8a73093d25319 ]

An upcoming silicon change places a number of existing blocks within the
Venus at different relative offsets to the base address of IO region.

In order to handle this difference this patch changes the address offsets
of the registers to function as offsets relative to the relevant sub-block
of registers within the IO region not the base address of the IO region.

As a result of this change venus_readl() and venus_writel() are deleted.

Co-developed-by: Dikshita Agarwal <dikshita@codeaurora.org>
Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: d74e48160980 ("media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/firmware.c  | 28 +++----
 drivers/media/platform/qcom/venus/hfi_venus.c | 82 ++++++++++---------
 .../media/platform/qcom/venus/hfi_venus_io.h  | 80 +++++++++---------
 .../media/platform/qcom/venus/pm_helpers.c    | 12 +--
 4 files changed, 105 insertions(+), 97 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 1db64a854b88b..67b9138a7c5fb 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -27,19 +27,19 @@
 static void venus_reset_cpu(struct venus_core *core)
 {
 	u32 fw_size = core->fw.mapped_mem_size;
-	void __iomem *base = core->base;
+	void __iomem *wrapper_base = core->wrapper_base;
 
-	writel(0, base + WRAPPER_FW_START_ADDR);
-	writel(fw_size, base + WRAPPER_FW_END_ADDR);
-	writel(0, base + WRAPPER_CPA_START_ADDR);
-	writel(fw_size, base + WRAPPER_CPA_END_ADDR);
-	writel(fw_size, base + WRAPPER_NONPIX_START_ADDR);
-	writel(fw_size, base + WRAPPER_NONPIX_END_ADDR);
-	writel(0x0, base + WRAPPER_CPU_CGC_DIS);
-	writel(0x0, base + WRAPPER_CPU_CLOCK_CONFIG);
+	writel(0, wrapper_base + WRAPPER_FW_START_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
+	writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
+	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
+	writel(0x0, wrapper_base + WRAPPER_CPU_CGC_DIS);
+	writel(0x0, wrapper_base + WRAPPER_CPU_CLOCK_CONFIG);
 
 	/* Bring ARM9 out of reset */
-	writel(0, base + WRAPPER_A9SS_SW_RESET);
+	writel(0, wrapper_base + WRAPPER_A9SS_SW_RESET);
 }
 
 int venus_set_hw_state(struct venus_core *core, bool resume)
@@ -56,7 +56,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	if (resume)
 		venus_reset_cpu(core);
 	else
-		writel(1, core->base + WRAPPER_A9SS_SW_RESET);
+		writel(1, core->wrapper_base + WRAPPER_A9SS_SW_RESET);
 
 	return 0;
 }
@@ -159,12 +159,12 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 	size_t unmapped;
 	u32 reg;
 	struct device *dev = core->fw.dev;
-	void __iomem *base = core->base;
+	void __iomem *wrapper_base = core->wrapper_base;
 
 	/* Assert the reset to ARM9 */
-	reg = readl_relaxed(base + WRAPPER_A9SS_SW_RESET);
+	reg = readl_relaxed(wrapper_base + WRAPPER_A9SS_SW_RESET);
 	reg |= WRAPPER_A9SS_SW_RESET_BIT;
-	writel_relaxed(reg, base + WRAPPER_A9SS_SW_RESET);
+	writel_relaxed(reg, wrapper_base + WRAPPER_A9SS_SW_RESET);
 
 	/* Make sure reset is asserted before the mapping is removed */
 	mb();
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 4be4a75ddcb6e..3d705fc5e1093 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -345,16 +345,6 @@ static void venus_free(struct venus_hfi_device *hdev, struct mem_desc *mem)
 	dma_free_attrs(dev, mem->size, mem->kva, mem->da, mem->attrs);
 }
 
-static void venus_writel(struct venus_hfi_device *hdev, u32 reg, u32 value)
-{
-	writel(value, hdev->core->base + reg);
-}
-
-static u32 venus_readl(struct venus_hfi_device *hdev, u32 reg)
-{
-	return readl(hdev->core->base + reg);
-}
-
 static void venus_set_registers(struct venus_hfi_device *hdev)
 {
 	const struct venus_resources *res = hdev->core->res;
@@ -363,12 +353,14 @@ static void venus_set_registers(struct venus_hfi_device *hdev)
 	unsigned int i;
 
 	for (i = 0; i < count; i++)
-		venus_writel(hdev, tbl[i].reg, tbl[i].value);
+		writel(tbl[i].value, hdev->core->base + tbl[i].reg);
 }
 
 static void venus_soft_int(struct venus_hfi_device *hdev)
 {
-	venus_writel(hdev, CPU_IC_SOFTINT, BIT(CPU_IC_SOFTINT_H2A_SHIFT));
+	void __iomem *cpu_ic_base = hdev->core->cpu_ic_base;
+
+	writel(BIT(CPU_IC_SOFTINT_H2A_SHIFT), cpu_ic_base + CPU_IC_SOFTINT);
 }
 
 static int venus_iface_cmdq_write_nolock(struct venus_hfi_device *hdev,
@@ -441,14 +433,16 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	static const unsigned int max_tries = 100;
 	u32 ctrl_status = 0;
 	unsigned int count = 0;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
 	int ret = 0;
 
-	venus_writel(hdev, VIDC_CTRL_INIT, BIT(VIDC_CTRL_INIT_CTRL_SHIFT));
-	venus_writel(hdev, WRAPPER_INTR_MASK, WRAPPER_INTR_MASK_A2HVCODEC_MASK);
-	venus_writel(hdev, CPU_CS_SCIACMDARG3, 1);
+	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
+	writel(WRAPPER_INTR_MASK_A2HVCODEC_MASK, wrapper_base + WRAPPER_INTR_MASK);
+	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
-		ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+		ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 		if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {
 			dev_err(dev, "invalid setting for UC_REGION\n");
 			ret = -EINVAL;
@@ -468,9 +462,11 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 static u32 venus_hwversion(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
-	u32 ver = venus_readl(hdev, WRAPPER_HW_VERSION);
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	u32 ver;
 	u32 major, minor, step;
 
+	ver = readl(wrapper_base + WRAPPER_HW_VERSION);
 	major = ver & WRAPPER_HW_VERSION_MAJOR_VERSION_MASK;
 	major = major >> WRAPPER_HW_VERSION_MAJOR_VERSION_SHIFT;
 	minor = ver & WRAPPER_HW_VERSION_MINOR_VERSION_MASK;
@@ -485,6 +481,7 @@ static u32 venus_hwversion(struct venus_hfi_device *hdev)
 static int venus_run(struct venus_hfi_device *hdev)
 {
 	struct device *dev = hdev->core->dev;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	int ret;
 
 	/*
@@ -493,12 +490,12 @@ static int venus_run(struct venus_hfi_device *hdev)
 	 */
 	venus_set_registers(hdev);
 
-	venus_writel(hdev, UC_REGION_ADDR, hdev->ifaceq_table.da);
-	venus_writel(hdev, UC_REGION_SIZE, SHARED_QSIZE);
-	venus_writel(hdev, CPU_CS_SCIACMDARG2, hdev->ifaceq_table.da);
-	venus_writel(hdev, CPU_CS_SCIACMDARG1, 0x01);
+	writel(hdev->ifaceq_table.da, cpu_cs_base + UC_REGION_ADDR);
+	writel(SHARED_QSIZE, cpu_cs_base + UC_REGION_SIZE);
+	writel(hdev->ifaceq_table.da, cpu_cs_base + CPU_CS_SCIACMDARG2);
+	writel(0x01, cpu_cs_base + CPU_CS_SCIACMDARG1);
 	if (hdev->sfr.da)
-		venus_writel(hdev, SFR_ADDR, hdev->sfr.da);
+		writel(hdev->sfr.da, cpu_cs_base + SFR_ADDR);
 
 	ret = venus_boot_core(hdev);
 	if (ret) {
@@ -513,17 +510,18 @@ static int venus_run(struct venus_hfi_device *hdev)
 
 static int venus_halt_axi(struct venus_hfi_device *hdev)
 {
-	void __iomem *base = hdev->core->base;
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	void __iomem *vbif_base = hdev->core->vbif_base;
 	struct device *dev = hdev->core->dev;
 	u32 val;
 	int ret;
 
 	if (IS_V4(hdev->core)) {
-		val = venus_readl(hdev, WRAPPER_CPU_AXI_HALT);
+		val = readl(wrapper_base + WRAPPER_CPU_AXI_HALT);
 		val |= WRAPPER_CPU_AXI_HALT_HALT;
-		venus_writel(hdev, WRAPPER_CPU_AXI_HALT, val);
+		writel(val, wrapper_base + WRAPPER_CPU_AXI_HALT);
 
-		ret = readl_poll_timeout(base + WRAPPER_CPU_AXI_HALT_STATUS,
+		ret = readl_poll_timeout(wrapper_base + WRAPPER_CPU_AXI_HALT_STATUS,
 					 val,
 					 val & WRAPPER_CPU_AXI_HALT_STATUS_IDLE,
 					 POLL_INTERVAL_US,
@@ -537,12 +535,12 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
 	}
 
 	/* Halt AXI and AXI IMEM VBIF Access */
-	val = venus_readl(hdev, VBIF_AXI_HALT_CTRL0);
+	val = readl(vbif_base + VBIF_AXI_HALT_CTRL0);
 	val |= VBIF_AXI_HALT_CTRL0_HALT_REQ;
-	venus_writel(hdev, VBIF_AXI_HALT_CTRL0, val);
+	writel(val, vbif_base + VBIF_AXI_HALT_CTRL0);
 
 	/* Request for AXI bus port halt */
-	ret = readl_poll_timeout(base + VBIF_AXI_HALT_CTRL1, val,
+	ret = readl_poll_timeout(vbif_base + VBIF_AXI_HALT_CTRL1, val,
 				 val & VBIF_AXI_HALT_CTRL1_HALT_ACK,
 				 POLL_INTERVAL_US,
 				 VBIF_AXI_HALT_ACK_TIMEOUT_US);
@@ -1035,19 +1033,21 @@ static irqreturn_t venus_isr(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	u32 status;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
 
 	if (!hdev)
 		return IRQ_NONE;
 
-	status = venus_readl(hdev, WRAPPER_INTR_STATUS);
+	status = readl(wrapper_base + WRAPPER_INTR_STATUS);
 
 	if (status & WRAPPER_INTR_STATUS_A2H_MASK ||
 	    status & WRAPPER_INTR_STATUS_A2HWD_MASK ||
 	    status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
 		hdev->irq_status = status;
 
-	venus_writel(hdev, CPU_CS_A2HSOFTINTCLR, 1);
-	venus_writel(hdev, WRAPPER_INTR_CLEAR, status);
+	writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
+	writel(status, wrapper_base + WRAPPER_INTR_CLEAR);
 
 	return IRQ_WAKE_THREAD;
 }
@@ -1380,6 +1380,7 @@ static int venus_suspend_1xx(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	struct device *dev = core->dev;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status;
 	int ret;
 
@@ -1414,7 +1415,7 @@ static int venus_suspend_1xx(struct venus_core *core)
 		return -EINVAL;
 	}
 
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+	ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 	if (!(ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)) {
 		mutex_unlock(&hdev->lock);
 		return -EINVAL;
@@ -1435,10 +1436,12 @@ static int venus_suspend_1xx(struct venus_core *core)
 
 static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
 {
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	cpu_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+	cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);
+	ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 
 	if (cpu_status & WRAPPER_CPU_STATUS_WFI &&
 	    ctrl_status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
@@ -1449,10 +1452,12 @@ static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
 
 static bool venus_cpu_idle_and_pc_ready(struct venus_hfi_device *hdev)
 {
+	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status, cpu_status;
 
-	cpu_status = venus_readl(hdev, WRAPPER_CPU_STATUS);
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+	cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);
+	ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 
 	if (cpu_status & WRAPPER_CPU_STATUS_WFI &&
 	    ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)
@@ -1465,6 +1470,7 @@ static int venus_suspend_3xx(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	struct device *dev = core->dev;
+	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
 	u32 ctrl_status;
 	bool val;
 	int ret;
@@ -1481,7 +1487,7 @@ static int venus_suspend_3xx(struct venus_core *core)
 		return -EINVAL;
 	}
 
-	ctrl_status = venus_readl(hdev, CPU_CS_SCIACMDARG0);
+	ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 	if (ctrl_status & CPU_CS_SCIACMDARG0_PC_READY)
 		goto power_off;
 
diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
index 3b52f98478db0..4c392b67252c2 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
+++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
@@ -8,27 +8,28 @@
 
 #define VBIF_BASE				0x80000
 
-#define VBIF_AXI_HALT_CTRL0			(VBIF_BASE + 0x208)
-#define VBIF_AXI_HALT_CTRL1			(VBIF_BASE + 0x20c)
+#define VBIF_AXI_HALT_CTRL0			0x208
+#define VBIF_AXI_HALT_CTRL1			0x20c
 
 #define VBIF_AXI_HALT_CTRL0_HALT_REQ		BIT(0)
 #define VBIF_AXI_HALT_CTRL1_HALT_ACK		BIT(0)
 #define VBIF_AXI_HALT_ACK_TIMEOUT_US		500000
 
 #define CPU_BASE				0xc0000
+
 #define CPU_CS_BASE				(CPU_BASE + 0x12000)
 #define CPU_IC_BASE				(CPU_BASE + 0x1f000)
 
-#define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE + 0x1c)
+#define CPU_CS_A2HSOFTINTCLR			0x1c
 
-#define VIDC_CTRL_INIT				(CPU_CS_BASE + 0x48)
+#define VIDC_CTRL_INIT				0x48
 #define VIDC_CTRL_INIT_RESERVED_BITS31_1_MASK	0xfffffffe
 #define VIDC_CTRL_INIT_RESERVED_BITS31_1_SHIFT	1
 #define VIDC_CTRL_INIT_CTRL_MASK		0x1
 #define VIDC_CTRL_INIT_CTRL_SHIFT		0
 
 /* HFI control status */
-#define CPU_CS_SCIACMDARG0			(CPU_CS_BASE + 0x4c)
+#define CPU_CS_SCIACMDARG0			0x4c
 #define CPU_CS_SCIACMDARG0_MASK			0xff
 #define CPU_CS_SCIACMDARG0_SHIFT		0x0
 #define CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK	0xfe
@@ -39,42 +40,43 @@
 #define CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK	BIT(30)
 
 /* HFI queue table info */
-#define CPU_CS_SCIACMDARG1			(CPU_CS_BASE + 0x50)
+#define CPU_CS_SCIACMDARG1			0x50
 
 /* HFI queue table address */
-#define CPU_CS_SCIACMDARG2			(CPU_CS_BASE + 0x54)
+#define CPU_CS_SCIACMDARG2			0x54
 
 /* Venus cpu */
-#define CPU_CS_SCIACMDARG3			(CPU_CS_BASE + 0x58)
+#define CPU_CS_SCIACMDARG3			0x58
 
-#define SFR_ADDR				(CPU_CS_BASE + 0x5c)
-#define MMAP_ADDR				(CPU_CS_BASE + 0x60)
-#define UC_REGION_ADDR				(CPU_CS_BASE + 0x64)
-#define UC_REGION_SIZE				(CPU_CS_BASE + 0x68)
+#define SFR_ADDR				0x5c
+#define MMAP_ADDR				0x60
+#define UC_REGION_ADDR				0x64
+#define UC_REGION_SIZE				0x68
 
-#define CPU_IC_SOFTINT				(CPU_IC_BASE + 0x18)
+/* Relative to CPU_IC_BASE */
+#define CPU_IC_SOFTINT				0x18
 #define CPU_IC_SOFTINT_H2A_MASK			0x8000
 #define CPU_IC_SOFTINT_H2A_SHIFT		0xf
 
 /* Venus wrapper */
 #define WRAPPER_BASE				0x000e0000
 
-#define WRAPPER_HW_VERSION			(WRAPPER_BASE + 0x00)
+#define WRAPPER_HW_VERSION			0x00
 #define WRAPPER_HW_VERSION_MAJOR_VERSION_MASK	0x78000000
 #define WRAPPER_HW_VERSION_MAJOR_VERSION_SHIFT	28
 #define WRAPPER_HW_VERSION_MINOR_VERSION_MASK	0xfff0000
 #define WRAPPER_HW_VERSION_MINOR_VERSION_SHIFT	16
 #define WRAPPER_HW_VERSION_STEP_VERSION_MASK	0xffff
 
-#define WRAPPER_CLOCK_CONFIG			(WRAPPER_BASE + 0x04)
+#define WRAPPER_CLOCK_CONFIG			0x04
 
-#define WRAPPER_INTR_STATUS			(WRAPPER_BASE + 0x0c)
+#define WRAPPER_INTR_STATUS			0x0c
 #define WRAPPER_INTR_STATUS_A2HWD_MASK		0x10
 #define WRAPPER_INTR_STATUS_A2HWD_SHIFT		0x4
 #define WRAPPER_INTR_STATUS_A2H_MASK		0x4
 #define WRAPPER_INTR_STATUS_A2H_SHIFT		0x2
 
-#define WRAPPER_INTR_MASK			(WRAPPER_BASE + 0x10)
+#define WRAPPER_INTR_MASK			0x10
 #define WRAPPER_INTR_MASK_A2HWD_BASK		0x10
 #define WRAPPER_INTR_MASK_A2HWD_SHIFT		0x4
 #define WRAPPER_INTR_MASK_A2HVCODEC_MASK	0x8
@@ -82,41 +84,41 @@
 #define WRAPPER_INTR_MASK_A2HCPU_MASK		0x4
 #define WRAPPER_INTR_MASK_A2HCPU_SHIFT		0x2
 
-#define WRAPPER_INTR_CLEAR			(WRAPPER_BASE + 0x14)
+#define WRAPPER_INTR_CLEAR			0x14
 #define WRAPPER_INTR_CLEAR_A2HWD_MASK		0x10
 #define WRAPPER_INTR_CLEAR_A2HWD_SHIFT		0x4
 #define WRAPPER_INTR_CLEAR_A2H_MASK		0x4
 #define WRAPPER_INTR_CLEAR_A2H_SHIFT		0x2
 
-#define WRAPPER_POWER_STATUS			(WRAPPER_BASE + 0x44)
-#define WRAPPER_VDEC_VCODEC_POWER_CONTROL	(WRAPPER_BASE + 0x48)
-#define WRAPPER_VENC_VCODEC_POWER_CONTROL	(WRAPPER_BASE + 0x4c)
-#define WRAPPER_VDEC_VENC_AHB_BRIDGE_SYNC_RESET	(WRAPPER_BASE + 0x64)
+#define WRAPPER_POWER_STATUS			0x44
+#define WRAPPER_VDEC_VCODEC_POWER_CONTROL	0x48
+#define WRAPPER_VENC_VCODEC_POWER_CONTROL	0x4c
+#define WRAPPER_VDEC_VENC_AHB_BRIDGE_SYNC_RESET	0x64
 
-#define WRAPPER_CPU_CLOCK_CONFIG		(WRAPPER_BASE + 0x2000)
-#define WRAPPER_CPU_AXI_HALT			(WRAPPER_BASE + 0x2008)
+#define WRAPPER_CPU_CLOCK_CONFIG		0x2000
+#define WRAPPER_CPU_AXI_HALT			0x2008
 #define WRAPPER_CPU_AXI_HALT_HALT		BIT(16)
-#define WRAPPER_CPU_AXI_HALT_STATUS		(WRAPPER_BASE + 0x200c)
+#define WRAPPER_CPU_AXI_HALT_STATUS		0x200c
 #define WRAPPER_CPU_AXI_HALT_STATUS_IDLE	BIT(24)
 
-#define WRAPPER_CPU_CGC_DIS			(WRAPPER_BASE + 0x2010)
-#define WRAPPER_CPU_STATUS			(WRAPPER_BASE + 0x2014)
+#define WRAPPER_CPU_CGC_DIS			0x2010
+#define WRAPPER_CPU_STATUS			0x2014
 #define WRAPPER_CPU_STATUS_WFI			BIT(0)
-#define WRAPPER_SW_RESET			(WRAPPER_BASE + 0x3000)
-#define WRAPPER_CPA_START_ADDR			(WRAPPER_BASE + 0x1020)
-#define WRAPPER_CPA_END_ADDR			(WRAPPER_BASE + 0x1024)
-#define WRAPPER_FW_START_ADDR			(WRAPPER_BASE + 0x1028)
-#define WRAPPER_FW_END_ADDR			(WRAPPER_BASE + 0x102C)
-#define WRAPPER_NONPIX_START_ADDR		(WRAPPER_BASE + 0x1030)
-#define WRAPPER_NONPIX_END_ADDR			(WRAPPER_BASE + 0x1034)
-#define WRAPPER_A9SS_SW_RESET			(WRAPPER_BASE + 0x3000)
+#define WRAPPER_SW_RESET			0x3000
+#define WRAPPER_CPA_START_ADDR			0x1020
+#define WRAPPER_CPA_END_ADDR			0x1024
+#define WRAPPER_FW_START_ADDR			0x1028
+#define WRAPPER_FW_END_ADDR			0x102C
+#define WRAPPER_NONPIX_START_ADDR		0x1030
+#define WRAPPER_NONPIX_END_ADDR			0x1034
+#define WRAPPER_A9SS_SW_RESET			0x3000
 #define WRAPPER_A9SS_SW_RESET_BIT		BIT(4)
 
 /* Venus 4xx */
-#define WRAPPER_VCODEC0_MMCC_POWER_STATUS	(WRAPPER_BASE + 0x90)
-#define WRAPPER_VCODEC0_MMCC_POWER_CONTROL	(WRAPPER_BASE + 0x94)
+#define WRAPPER_VCODEC0_MMCC_POWER_STATUS	0x90
+#define WRAPPER_VCODEC0_MMCC_POWER_CONTROL	0x94
 
-#define WRAPPER_VCODEC1_MMCC_POWER_STATUS	(WRAPPER_BASE + 0x110)
-#define WRAPPER_VCODEC1_MMCC_POWER_CONTROL	(WRAPPER_BASE + 0x114)
+#define WRAPPER_VCODEC1_MMCC_POWER_STATUS	0x110
+#define WRAPPER_VCODEC1_MMCC_POWER_CONTROL	0x114
 
 #endif
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index f7de02352f1b0..6bf9c5c319de7 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -304,9 +304,9 @@ vcodec_control_v3(struct venus_core *core, u32 session_type, bool enable)
 	void __iomem *ctrl;
 
 	if (session_type == VIDC_SESSION_TYPE_DEC)
-		ctrl = core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL;
+		ctrl = core->wrapper_base + WRAPPER_VDEC_VCODEC_POWER_CONTROL;
 	else
-		ctrl = core->base + WRAPPER_VENC_VCODEC_POWER_CONTROL;
+		ctrl = core->wrapper_base + WRAPPER_VENC_VCODEC_POWER_CONTROL;
 
 	if (enable)
 		writel(0, ctrl);
@@ -381,11 +381,11 @@ static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
 	int ret;
 
 	if (coreid == VIDC_CORE_ID_1) {
-		ctrl = core->base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
-		stat = core->base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
+		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
+		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
 	} else {
-		ctrl = core->base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
-		stat = core->base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
+		ctrl = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
+		stat = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
 	}
 
 	if (enable) {
-- 
2.40.1



