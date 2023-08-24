Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700BF7876A0
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbjHXRSD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbjHXRRt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACBA1993
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A09F66698
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C596C433C8;
        Thu, 24 Aug 2023 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897465;
        bh=0yUoJ0T/7F6vX/j1im8cjO4/zTCOjho4GIr5fkXCzmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2MWaP1NnWHMKtJ8IgnBbisi2C+29QPcSgIA7kljm5X1W15jX2mHXqpA/bVlJaQFKe
         v5FABm0VZmzynzuQYzljqZT8920m4FxBIfXkZ/yAQL2R9hpMYDLqBBWgC/T6GjwTFQ
         1o79Y+2uak2vdfqgvDiOrzgXW5kxQobUOzCpgN6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Loic Poulain <loic.poulain@linaro.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 048/135] bus: mhi: Add MHI PCI support for WWAN modems
Date:   Thu, 24 Aug 2023 19:08:40 +0200
Message-ID: <20230824170619.231324724@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 855a70c12021bdc5df60512f1d3f6d492dc715be ]

This is a generic MHI-over-PCI controller driver for MHI only devices
such as QCOM modems. For now it supports registering of Qualcomm SDX55
based PCIe modules. The MHI channels have been extracted from mhi
downstream driver.

This driver is for MHI-only devices which have all functionalities
exposed through MHI channels and accessed by the corresponding MHI
device drivers (no out-of-band communication).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[mani: fixed up the Makefile rule]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Stable-dep-of: 6a0c637bfee6 ("bus: mhi: host: Range check CHDBOFF and ERDBOFF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/mhi/Kconfig       |   9 +
 drivers/bus/mhi/Makefile      |   4 +
 drivers/bus/mhi/pci_generic.c | 345 ++++++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 drivers/bus/mhi/pci_generic.c

diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
index e841c1097fb4d..da5cd0c9fc620 100644
--- a/drivers/bus/mhi/Kconfig
+++ b/drivers/bus/mhi/Kconfig
@@ -20,3 +20,12 @@ config MHI_BUS_DEBUG
 	  Enable debugfs support for use with the MHI transport. Allows
 	  reading and/or modifying some values within the MHI controller
 	  for debug and test purposes.
+
+config MHI_BUS_PCI_GENERIC
+	tristate "MHI PCI controller driver"
+	depends on MHI_BUS
+	depends on PCI
+	help
+	  This driver provides MHI PCI controller driver for devices such as
+	  Qualcomm SDX55 based PCIe modems.
+
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 19e6443b72df4..0a2d778d6fb42 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -1,2 +1,6 @@
 # core layer
 obj-y += core/
+
+obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
+mhi_pci_generic-y += pci_generic.o
+
diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
new file mode 100644
index 0000000000000..e3df838c3c80e
--- /dev/null
+++ b/drivers/bus/mhi/pci_generic.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MHI PCI driver - MHI over PCI controller driver
+ *
+ * This module is a generic driver for registering MHI-over-PCI devices,
+ * such as PCIe QCOM modems.
+ *
+ * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
+ */
+
+#include <linux/device.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#define MHI_PCI_DEFAULT_BAR_NUM 0
+
+/**
+ * struct mhi_pci_dev_info - MHI PCI device specific information
+ * @config: MHI controller configuration
+ * @name: name of the PCI module
+ * @fw: firmware path (if any)
+ * @edl: emergency download mode firmware path (if any)
+ * @bar_num: PCI base address register to use for MHI MMIO register space
+ * @dma_data_width: DMA transfer word size (32 or 64 bits)
+ */
+struct mhi_pci_dev_info {
+	const struct mhi_controller_config *config;
+	const char *name;
+	const char *fw;
+	const char *edl;
+	unsigned int bar_num;
+	unsigned int dma_data_width;
+};
+
+#define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_TO_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}						\
+
+#define MHI_CHANNEL_CONFIG_DL(ch_num, ch_name, el_count, ev_ring) \
+	{						\
+		.num = ch_num,				\
+		.name = ch_name,			\
+		.num_elements = el_count,		\
+		.event_ring = ev_ring,			\
+		.dir = DMA_FROM_DEVICE,			\
+		.ee_mask = BIT(MHI_EE_AMSS),		\
+		.pollcfg = 0,				\
+		.doorbell = MHI_DB_BRST_DISABLE,	\
+		.lpm_notify = false,			\
+		.offload_channel = false,		\
+		.doorbell_mode_switch = false,		\
+	}
+
+#define MHI_EVENT_CONFIG_CTRL(ev_ring)		\
+	{					\
+		.num_elements = 64,		\
+		.irq_moderation_ms = 0,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_CTRL,	\
+		.hardware_event = false,	\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+	}
+
+#define MHI_EVENT_CONFIG_DATA(ev_ring)		\
+	{					\
+		.num_elements = 128,		\
+		.irq_moderation_ms = 5,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_DATA,	\
+		.hardware_event = false,	\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+	}
+
+#define MHI_EVENT_CONFIG_HW_DATA(ev_ring, ch_num) \
+	{					\
+		.num_elements = 128,		\
+		.irq_moderation_ms = 5,		\
+		.irq = (ev_ring) + 1,		\
+		.priority = 1,			\
+		.mode = MHI_DB_BRST_DISABLE,	\
+		.data_type = MHI_ER_DATA,	\
+		.hardware_event = true,		\
+		.client_managed = false,	\
+		.offload_channel = false,	\
+		.channel = ch_num,		\
+	}
+
+static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
+	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
+	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
+	MHI_CHANNEL_CONFIG_UL(14, "QMI", 4, 0),
+	MHI_CHANNEL_CONFIG_DL(15, "QMI", 4, 0),
+	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 8, 0),
+	MHI_CHANNEL_CONFIG_DL(21, "IPCR", 8, 0),
+	MHI_CHANNEL_CONFIG_UL(100, "IP_HW0", 128, 1),
+	MHI_CHANNEL_CONFIG_DL(101, "IP_HW0", 128, 2),
+};
+
+static const struct mhi_event_config modem_qcom_v1_mhi_events[] = {
+	/* first ring is control+data ring */
+	MHI_EVENT_CONFIG_CTRL(0),
+	/* Hardware channels request dedicated hardware event rings */
+	MHI_EVENT_CONFIG_HW_DATA(1, 100),
+	MHI_EVENT_CONFIG_HW_DATA(2, 101)
+};
+
+static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
+	.max_channels = 128,
+	.timeout_ms = 5000,
+	.num_channels = ARRAY_SIZE(modem_qcom_v1_mhi_channels),
+	.ch_cfg = modem_qcom_v1_mhi_channels,
+	.num_events = ARRAY_SIZE(modem_qcom_v1_mhi_events),
+	.event_cfg = modem_qcom_v1_mhi_events,
+};
+
+static const struct mhi_pci_dev_info mhi_qcom_sdx55_info = {
+	.name = "qcom-sdx55m",
+	.fw = "qcom/sdx55m/sbl1.mbn",
+	.edl = "qcom/sdx55m/edl.mbn",
+	.config = &modem_qcom_v1_mhiv_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32
+};
+
+static const struct pci_device_id mhi_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),
+		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx55_info },
+	{  }
+};
+MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
+
+static int mhi_pci_read_reg(struct mhi_controller *mhi_cntrl,
+			    void __iomem *addr, u32 *out)
+{
+	*out = readl(addr);
+	return 0;
+}
+
+static void mhi_pci_write_reg(struct mhi_controller *mhi_cntrl,
+			      void __iomem *addr, u32 val)
+{
+	writel(val, addr);
+}
+
+static void mhi_pci_status_cb(struct mhi_controller *mhi_cntrl,
+			      enum mhi_callback cb)
+{
+	/* Nothing to do for now */
+}
+
+static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
+			 unsigned int bar_num, u64 dma_mask)
+{
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+	int err;
+
+	err = pci_assign_resource(pdev, bar_num);
+	if (err)
+		return err;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable pci device: %d\n", err);
+		return err;
+	}
+
+	err = pcim_iomap_regions(pdev, 1 << bar_num, pci_name(pdev));
+	if (err) {
+		dev_err(&pdev->dev, "failed to map pci region: %d\n", err);
+		return err;
+	}
+	mhi_cntrl->regs = pcim_iomap_table(pdev)[bar_num];
+
+	err = pci_set_dma_mask(pdev, dma_mask);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot set proper DMA mask\n");
+		return err;
+	}
+
+	err = pci_set_consistent_dma_mask(pdev, dma_mask);
+	if (err) {
+		dev_err(&pdev->dev, "set consistent dma mask failed\n");
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
+static int mhi_pci_get_irqs(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_controller_config *mhi_cntrl_config)
+{
+	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
+	int nr_vectors, i;
+	int *irq;
+
+	/*
+	 * Alloc one MSI vector for BHI + one vector per event ring, ideally...
+	 * No explicit pci_free_irq_vectors required, done by pcim_release.
+	 */
+	mhi_cntrl->nr_irqs = 1 + mhi_cntrl_config->num_events;
+
+	nr_vectors = pci_alloc_irq_vectors(pdev, 1, mhi_cntrl->nr_irqs, PCI_IRQ_MSI);
+	if (nr_vectors < 0) {
+		dev_err(&pdev->dev, "Error allocating MSI vectors %d\n",
+			nr_vectors);
+		return nr_vectors;
+	}
+
+	if (nr_vectors < mhi_cntrl->nr_irqs) {
+		dev_warn(&pdev->dev, "Not enough MSI vectors (%d/%d), use shared MSI\n",
+			 nr_vectors, mhi_cntrl_config->num_events);
+	}
+
+	irq = devm_kcalloc(&pdev->dev, mhi_cntrl->nr_irqs, sizeof(int), GFP_KERNEL);
+	if (!irq)
+		return -ENOMEM;
+
+	for (i = 0; i < mhi_cntrl->nr_irqs; i++) {
+		int vector = i >= nr_vectors ? (nr_vectors - 1) : i;
+
+		irq[i] = pci_irq_vector(pdev, vector);
+	}
+
+	mhi_cntrl->irq = irq;
+
+	return 0;
+}
+
+static int mhi_pci_runtime_get(struct mhi_controller *mhi_cntrl)
+{
+	/* no PM for now */
+	return 0;
+}
+
+static void mhi_pci_runtime_put(struct mhi_controller *mhi_cntrl)
+{
+	/* no PM for now */
+}
+
+static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	const struct mhi_pci_dev_info *info = (struct mhi_pci_dev_info *) id->driver_data;
+	const struct mhi_controller_config *mhi_cntrl_config;
+	struct mhi_controller *mhi_cntrl;
+	int err;
+
+	dev_dbg(&pdev->dev, "MHI PCI device found: %s\n", info->name);
+
+	mhi_cntrl = mhi_alloc_controller();
+	if (!mhi_cntrl)
+		return -ENOMEM;
+
+	mhi_cntrl_config = info->config;
+	mhi_cntrl->cntrl_dev = &pdev->dev;
+	mhi_cntrl->iova_start = 0;
+	mhi_cntrl->iova_stop = DMA_BIT_MASK(info->dma_data_width);
+	mhi_cntrl->fw_image = info->fw;
+	mhi_cntrl->edl_image = info->edl;
+
+	mhi_cntrl->read_reg = mhi_pci_read_reg;
+	mhi_cntrl->write_reg = mhi_pci_write_reg;
+	mhi_cntrl->status_cb = mhi_pci_status_cb;
+	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
+	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
+
+	err = mhi_pci_claim(mhi_cntrl, info->bar_num, DMA_BIT_MASK(info->dma_data_width));
+	if (err)
+		goto err_release;
+
+	err = mhi_pci_get_irqs(mhi_cntrl, mhi_cntrl_config);
+	if (err)
+		goto err_release;
+
+	pci_set_drvdata(pdev, mhi_cntrl);
+
+	err = mhi_register_controller(mhi_cntrl, mhi_cntrl_config);
+	if (err)
+		goto err_release;
+
+	/* MHI bus does not power up the controller by default */
+	err = mhi_prepare_for_power_up(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to prepare MHI controller\n");
+		goto err_unregister;
+	}
+
+	err = mhi_sync_power_up(mhi_cntrl);
+	if (err) {
+		dev_err(&pdev->dev, "failed to power up MHI controller\n");
+		goto err_unprepare;
+	}
+
+	return 0;
+
+err_unprepare:
+	mhi_unprepare_after_power_down(mhi_cntrl);
+err_unregister:
+	mhi_unregister_controller(mhi_cntrl);
+err_release:
+	mhi_free_controller(mhi_cntrl);
+
+	return err;
+}
+
+static void mhi_pci_remove(struct pci_dev *pdev)
+{
+	struct mhi_controller *mhi_cntrl = pci_get_drvdata(pdev);
+
+	mhi_power_down(mhi_cntrl, true);
+	mhi_unprepare_after_power_down(mhi_cntrl);
+	mhi_unregister_controller(mhi_cntrl);
+	mhi_free_controller(mhi_cntrl);
+}
+
+static struct pci_driver mhi_pci_driver = {
+	.name		= "mhi-pci-generic",
+	.id_table	= mhi_pci_id_table,
+	.probe		= mhi_pci_probe,
+	.remove		= mhi_pci_remove
+};
+module_pci_driver(mhi_pci_driver);
+
+MODULE_AUTHOR("Loic Poulain <loic.poulain@linaro.org>");
+MODULE_DESCRIPTION("Modem Host Interface (MHI) PCI controller driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1



