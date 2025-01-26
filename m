Return-Path: <stable+bounces-110798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F981A1CD16
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D381163D86
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86F170A13;
	Sun, 26 Jan 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IshJcf+O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD7158A09;
	Sun, 26 Jan 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909949; cv=none; b=Ki9itpsExMsEWk8lu0ZgqzXoYJLc88pKuzbcv5GyZGtOIbeWr+RpKPAf7pRQx8Tl23UQkuK2eEE0RrVN3/eWXHYKH/tTCKzqVNv+vZZsnSnO2x++u9ctVqh8By3iqD1oRWJR1U75rBEt8lo0LqMJwlWUFHUWojDScOd4Yxm2tok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909949; c=relaxed/simple;
	bh=MUSbd6MS1V2ZedDRIbqY9pCPcg95FOTVc9b05vkH/zM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMVz/SJNCgPAWCjZK+kHGoDxJvpVScY0C/IT2Dgi4B+RFuE6sVpoouRBG6gTws5sYo/mk1hFVTPJ1SPDLxG/+xQfpqUy9UYiHS2MQFQHjkbNQY8vvnCW8ZQ7NWg23RojxgJXyR7rnWY1SiYPfUlOzjuI839E3q/aBdHZ8okROQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IshJcf+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD268C4CED3;
	Sun, 26 Jan 2025 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737909948;
	bh=MUSbd6MS1V2ZedDRIbqY9pCPcg95FOTVc9b05vkH/zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IshJcf+Og7bSIqBpPMuNafbjFJGksieaM09YVUwpqKxkBiHdIAVnUSTWp8oEHX0+l
	 dpzZfrH4eh9lyoKA1pGlOCJFSayb67PvSQLTQCooLvujNSi4aBHwqwOY04IrfageaH
	 971kMZLO1a0fSKbLdH8t2DGSFcDZOb1xC2KJf7jt1qJc9LHDdwm2wq/QsXKAuU+Vao
	 STe10ANrLX6kMRC/X4ChT0YpRq4G4n/H8GwmWjy9jEfkp4E3AjdH32taY7YdZ0xCOY
	 6fqfaJDM1Y8ZpbbgbZwNC4KezigDLQS3UbG/ZyhB01AFInCMKKFN+beeEpVDAcUuf/
	 gaj/6C6uj4d6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	Guruvendra.Punugupati@amd.com,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 8/8] i3c: mipi-i3c-hci: Add support for MIPI I3C HCI on PCI bus
Date: Sun, 26 Jan 2025 11:45:23 -0500
Message-Id: <20250126164523.963930-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126164523.963930-1-sashal@kernel.org>
References: <20250126164523.963930-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 30bb1ce71215645fa6a92f4fa8cbb8f58db68f12 ]

Add a glue code for the MIPI I3C HCI on PCI bus with Intel Panther Lake
I3C controller PCI IDs.

MIPI I3C HCI on Intel platforms has additional logic around the MIPI I3C
HCI core logic. Those together create so called I3C slice on PCI bus.
Intel specific initialization code does a reset cycle to the I3C slice
before probing the MIPI I3C HCI part.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20241231115904.620052-2-jarkko.nikula@linux.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/Kconfig                    |  11 ++
 drivers/i3c/master/mipi-i3c-hci/Makefile      |   1 +
 .../master/mipi-i3c-hci/mipi-i3c-hci-pci.c    | 148 ++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c

diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 90dee3ec55209..77da199c7413e 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -57,3 +57,14 @@ config MIPI_I3C_HCI
 
 	  This driver can also be built as a module.  If so, the module will be
 	  called mipi-i3c-hci.
+
+config MIPI_I3C_HCI_PCI
+	tristate "MIPI I3C Host Controller Interface PCI support"
+	depends on MIPI_I3C_HCI
+	depends on PCI
+	help
+	  Support for MIPI I3C Host Controller Interface compatible hardware
+	  on the PCI bus.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mipi-i3c-hci-pci.
diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
index 1f8cd5c48fdef..e3d3ef757035f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/Makefile
+++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
@@ -5,3 +5,4 @@ mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
 					   cmd_v1.o cmd_v2.o \
 					   dat_v1.o dct_v1.o \
 					   hci_quirks.o
+obj-$(CONFIG_MIPI_I3C_HCI_PCI)		+= mipi-i3c-hci-pci.o
diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
new file mode 100644
index 0000000000000..c6c3a3ec11eae
--- /dev/null
+++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI glue code for MIPI I3C HCI driver
+ *
+ * Copyright (C) 2024 Intel Corporation
+ *
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ */
+#include <linux/acpi.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+struct mipi_i3c_hci_pci_info {
+	int (*init)(struct pci_dev *pci);
+};
+
+#define INTEL_PRIV_OFFSET		0x2b0
+#define INTEL_PRIV_SIZE			0x28
+#define INTEL_PRIV_RESETS		0x04
+#define INTEL_PRIV_RESETS_RESET		BIT(0)
+#define INTEL_PRIV_RESETS_RESET_DONE	BIT(1)
+
+static DEFINE_IDA(mipi_i3c_hci_pci_ida);
+
+static int mipi_i3c_hci_pci_intel_init(struct pci_dev *pci)
+{
+	unsigned long timeout;
+	void __iomem *priv;
+
+	priv = devm_ioremap(&pci->dev,
+			    pci_resource_start(pci, 0) + INTEL_PRIV_OFFSET,
+			    INTEL_PRIV_SIZE);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Assert reset, wait for completion and release reset */
+	writel(0, priv + INTEL_PRIV_RESETS);
+	timeout = jiffies + msecs_to_jiffies(10);
+	while (!(readl(priv + INTEL_PRIV_RESETS) &
+		 INTEL_PRIV_RESETS_RESET_DONE)) {
+		if (time_after(jiffies, timeout))
+			break;
+		cpu_relax();
+	}
+	writel(INTEL_PRIV_RESETS_RESET, priv + INTEL_PRIV_RESETS);
+
+	return 0;
+}
+
+static struct mipi_i3c_hci_pci_info intel_info = {
+	.init = mipi_i3c_hci_pci_intel_init,
+};
+
+static int mipi_i3c_hci_pci_probe(struct pci_dev *pci,
+				  const struct pci_device_id *id)
+{
+	struct mipi_i3c_hci_pci_info *info;
+	struct platform_device *pdev;
+	struct resource res[2];
+	int dev_id, ret;
+
+	ret = pcim_enable_device(pci);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci);
+
+	memset(&res, 0, sizeof(res));
+
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = pci_resource_start(pci, 0);
+	res[0].end = pci_resource_end(pci, 0);
+
+	res[1].flags = IORESOURCE_IRQ;
+	res[1].start = pci->irq;
+	res[1].end = pci->irq;
+
+	dev_id = ida_alloc(&mipi_i3c_hci_pci_ida, GFP_KERNEL);
+	if (dev_id < 0)
+		return dev_id;
+
+	pdev = platform_device_alloc("mipi-i3c-hci", dev_id);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.parent = &pci->dev;
+	device_set_node(&pdev->dev, dev_fwnode(&pci->dev));
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret)
+		goto err;
+
+	info = (struct mipi_i3c_hci_pci_info *)id->driver_data;
+	if (info && info->init) {
+		ret = info->init(pci);
+		if (ret)
+			goto err;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err;
+
+	pci_set_drvdata(pci, pdev);
+
+	return 0;
+
+err:
+	platform_device_put(pdev);
+	ida_free(&mipi_i3c_hci_pci_ida, dev_id);
+	return ret;
+}
+
+static void mipi_i3c_hci_pci_remove(struct pci_dev *pci)
+{
+	struct platform_device *pdev = pci_get_drvdata(pci);
+	int dev_id = pdev->id;
+
+	platform_device_unregister(pdev);
+	ida_free(&mipi_i3c_hci_pci_ida, dev_id);
+}
+
+static const struct pci_device_id mipi_i3c_hci_pci_devices[] = {
+	/* Panther Lake-H */
+	{ PCI_VDEVICE(INTEL, 0xe37c), (kernel_ulong_t)&intel_info},
+	{ PCI_VDEVICE(INTEL, 0xe36f), (kernel_ulong_t)&intel_info},
+	/* Panther Lake-P */
+	{ PCI_VDEVICE(INTEL, 0xe47c), (kernel_ulong_t)&intel_info},
+	{ PCI_VDEVICE(INTEL, 0xe46f), (kernel_ulong_t)&intel_info},
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, mipi_i3c_hci_pci_devices);
+
+static struct pci_driver mipi_i3c_hci_pci_driver = {
+	.name = "mipi_i3c_hci_pci",
+	.id_table = mipi_i3c_hci_pci_devices,
+	.probe = mipi_i3c_hci_pci_probe,
+	.remove = mipi_i3c_hci_pci_remove,
+};
+
+module_pci_driver(mipi_i3c_hci_pci_driver);
+
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MIPI I3C HCI driver on PCI bus");
-- 
2.39.5


