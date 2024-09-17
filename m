Return-Path: <stable+bounces-76589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C2F97B18F
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC51928533F
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64727175D5D;
	Tue, 17 Sep 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="X0nCawQw"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84480535DC;
	Tue, 17 Sep 2024 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584465; cv=none; b=KepUesOah7N17M+zig2QzUt3o7yaLveuqnPgpZju60mRL1Imf95a3UFtCfE2+khPXJv5fZKBqSnpY0VrsiZSyzm5Ea9uOwgAi+yzi70VvnMkpoM8Xse6mprZtUgmT4LJQbkJk9zXQEpjg3jLVdH0SoTc50eZvAfkhDZ73mrTDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584465; c=relaxed/simple;
	bh=0gmS0CrHykIuqhYWHp6T8EI7WFpQtf/PrGx+TvZzGoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8cVB1OIhyHueQP+MujsHcNbesvmmXWyuL+MUcVTLN9XHSszJsXob6yd0GJQjttE9PaWudNdAFMcR5ijsaZZn0y//GnrA48Zyor7bWtt3EaXy1CQPV7G++7Uz/as64AI4yRoSy4fJkWUhCU3/iGzKzkuxMQhCNLLL3+46Mi2xjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=X0nCawQw; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726584453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D2tUHWrlbsrsSeaQbFVGiyfoPkRoLq2KwPhMPJ3F3JU=;
	b=X0nCawQwbGEgDMmhhMD4sukzDsJaEkSWLq7/ZjBOlgl1XJSqJnpJDcRicCxFwHe/Pt9zEN
	JscIr4xZCtAp3Kg1cRWlnKmUyaMXL0QEniR6DvoJ+XIAxCdPll6a6fPbbYlSq0ecRVQiW0
	q1wx1vYhEoaAPE3wZOWDFCZFMUIoVb8=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] mtd: rawnand: mxc: Remove platform data support
Date: Tue, 17 Sep 2024 17:47:33 +0300
Message-Id: <20240917144733.47815-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 0f6b791955a6365b5ebe8b6a5b01de69a47ee92e ]

i.MX is a devicetree-only platform now and the existing platform data
support in this driver was only useful for old non-devicetree platforms.

Get rid of the platform data support since it is no longer used.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20201110121908.19400-1-festevam@gmail.com
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/mtd/nand/raw/Kconfig               |  2 +-
 drivers/mtd/nand/raw/mxc_nand.c            | 75 ++--------------------
 include/linux/platform_data/mtd-mxc_nand.h | 19 ------
 3 files changed, 5 insertions(+), 91 deletions(-)
 delete mode 100644 include/linux/platform_data/mtd-mxc_nand.h

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 6c46f25b57e2..58421866bdc3 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -313,7 +313,7 @@ config MTD_NAND_VF610_NFC
 config MTD_NAND_MXC
 	tristate "Freescale MXC NAND controller"
 	depends on ARCH_MXC || COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && OF
 	help
 	  This enables the driver for the NAND flash controller on the
 	  MXC processors.
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 684c51e5e60d..f896364968d8 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -21,7 +21,6 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/platform_data/mtd-mxc_nand.h>
 
 #define DRIVER_NAME "mxc_nand"
 
@@ -184,7 +183,6 @@ struct mxc_nand_host {
 	unsigned int		buf_start;
 
 	const struct mxc_nand_devtype_data *devtype_data;
-	struct mxc_nand_platform_data pdata;
 };
 
 static const char * const part_probes[] = {
@@ -1611,29 +1609,6 @@ static inline int is_imx53_nfc(struct mxc_nand_host *host)
 	return host->devtype_data == &imx53_nand_devtype_data;
 }
 
-static const struct platform_device_id mxcnd_devtype[] = {
-	{
-		.name = "imx21-nand",
-		.driver_data = (kernel_ulong_t) &imx21_nand_devtype_data,
-	}, {
-		.name = "imx27-nand",
-		.driver_data = (kernel_ulong_t) &imx27_nand_devtype_data,
-	}, {
-		.name = "imx25-nand",
-		.driver_data = (kernel_ulong_t) &imx25_nand_devtype_data,
-	}, {
-		.name = "imx51-nand",
-		.driver_data = (kernel_ulong_t) &imx51_nand_devtype_data,
-	}, {
-		.name = "imx53-nand",
-		.driver_data = (kernel_ulong_t) &imx53_nand_devtype_data,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, mxcnd_devtype);
-
-#ifdef CONFIG_OF
 static const struct of_device_id mxcnd_dt_ids[] = {
 	{
 		.compatible = "fsl,imx21-nand",
@@ -1655,26 +1630,6 @@ static const struct of_device_id mxcnd_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxcnd_dt_ids);
 
-static int mxcnd_probe_dt(struct mxc_nand_host *host)
-{
-	struct device_node *np = host->dev->of_node;
-	const struct of_device_id *of_id =
-		of_match_device(mxcnd_dt_ids, host->dev);
-
-	if (!np)
-		return 1;
-
-	host->devtype_data = of_id->data;
-
-	return 0;
-}
-#else
-static int mxcnd_probe_dt(struct mxc_nand_host *host)
-{
-	return 1;
-}
-#endif
-
 static int mxcnd_attach_chip(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -1759,6 +1714,7 @@ static const struct nand_controller_ops mxcnd_controller_ops = {
 
 static int mxcnd_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
 	struct mxc_nand_host *host;
@@ -1800,20 +1756,8 @@ static int mxcnd_probe(struct platform_device *pdev)
 	if (IS_ERR(host->clk))
 		return PTR_ERR(host->clk);
 
-	err = mxcnd_probe_dt(host);
-	if (err > 0) {
-		struct mxc_nand_platform_data *pdata =
-					dev_get_platdata(&pdev->dev);
-		if (pdata) {
-			host->pdata = *pdata;
-			host->devtype_data = (struct mxc_nand_devtype_data *)
-						pdev->id_entry->driver_data;
-		} else {
-			err = -ENODEV;
-		}
-	}
-	if (err < 0)
-		return err;
+	of_id = of_match_device(mxcnd_dt_ids, host->dev);
+	host->devtype_data = of_id->data;
 
 	if (!host->devtype_data->setup_interface)
 		this->options |= NAND_KEEP_TIMINGS;
@@ -1843,14 +1787,6 @@ static int mxcnd_probe(struct platform_device *pdev)
 
 	this->legacy.select_chip = host->devtype_data->select_chip;
 
-	/* NAND bus width determines access functions used by upper layer */
-	if (host->pdata.width == 2)
-		this->options |= NAND_BUSWIDTH_16;
-
-	/* update flash based bbt */
-	if (host->pdata.flash_bbt)
-		this->bbt_options |= NAND_BBT_USE_FLASH;
-
 	init_completion(&host->op_completion);
 
 	host->irq = platform_get_irq(pdev, 0);
@@ -1891,9 +1827,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 		goto escan;
 
 	/* Register the partitions */
-	err = mtd_device_parse_register(mtd, part_probes, NULL,
-					host->pdata.parts,
-					host->pdata.nr_parts);
+	err = mtd_device_parse_register(mtd, part_probes, NULL, NULL, 0);
 	if (err)
 		goto cleanup_nand;
 
@@ -1930,7 +1864,6 @@ static struct platform_driver mxcnd_driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = of_match_ptr(mxcnd_dt_ids),
 	},
-	.id_table = mxcnd_devtype,
 	.probe = mxcnd_probe,
 	.remove = mxcnd_remove,
 };
diff --git a/include/linux/platform_data/mtd-mxc_nand.h b/include/linux/platform_data/mtd-mxc_nand.h
deleted file mode 100644
index d1230030c6db..000000000000
--- a/include/linux/platform_data/mtd-mxc_nand.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Sascha Hauer, kernel@pengutronix.de
- */
-
-#ifndef __ASM_ARCH_NAND_H
-#define __ASM_ARCH_NAND_H
-
-#include <linux/mtd/partitions.h>
-
-struct mxc_nand_platform_data {
-	unsigned int width;	/* data bus width in bytes */
-	unsigned int hw_ecc:1;	/* 0 if suppress hardware ECC */
-	unsigned int flash_bbt:1; /* set to 1 to use a flash based bbt */
-	struct mtd_partition *parts;	/* partition table */
-	int nr_parts;			/* size of parts */
-};
-#endif /* __ASM_ARCH_NAND_H */
-- 
2.25.1


