Return-Path: <stable+bounces-180874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1780B8ECA5
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 04:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A693B179C44
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC491547CC;
	Mon, 22 Sep 2025 02:39:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFA16CD33;
	Mon, 22 Sep 2025 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508756; cv=none; b=qkqEp3a1lHkI58Oo31ZBtNFOvgojkA0uQNI8HiOfcDDR3ITFxwhEj8d3N4cJMBN8CBzE9DtSTRGJUTbX+mj4An0MhMYXrLxqAAi1J11uv+dh8S2IMqo5kGycmRMmyJchh9Y0YIGITxQ5nBvF+N+Urmyss+3WwcSwIJWohMddx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508756; c=relaxed/simple;
	bh=2njLDJiojIEQxOF+htkPknhP0qErdIkYtULif4SAAOQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nr0i+JL2DgmMKnlOXt55oudfCYsKI8oGJKTSLL9nRwsP98/xdJnyDJuTFWw/pdB0y/ZTtsuYDWf6flAmLYdTQT1MhLHxYHhM8xJIlE/V3AB1SNXiNvdcpEweEWXmlphUTdDctD5uOGiYhtxiIp646b16eTJhQxH9NGNnUZYWAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAB3x4GpttBoZbgtBA--.19549S2;
	Mon, 22 Sep 2025 10:38:56 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	matchstick@neverthere.org,
	dominik.karol.piatkowski@protonmail.com,
	arnd@arndb.de,
	nichen@iscas.ac.cn,
	paul.retourne@orange.fr
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] staging: gpib: Fix device reference leak in fmh_gpib driver
Date: Mon, 22 Sep 2025 10:38:31 +0800
Message-Id: <20250922023831.21343-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAB3x4GpttBoZbgtBA--.19549S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4fCr1UuF1kKrWkAF1UZFb_yoWrCF1Upa
	17Xa1rKry0vrnaqF45Xr1UZFsayw4IyayYvw17C343Aa95Zry0ya1DW34ayryrAFykJr15
	trW09r40gFWkZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOTmh
	UUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The fmh_gpib driver contains a device reference count leak in
fmh_gpib_attach_impl() where driver_find_device() increases the
reference count of the device by get_device() when matching but this
reference is not properly decreased. Add put_device() in
fmh_gpib_attach_impl() and add put_device() in fmh_gpib_detach(),
which ensures that the reference count of the device is correctly
managed.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 4138f3d2bae7..245c8fe87eaa 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -1395,14 +1395,17 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	pdev = to_platform_device(board->dev);
 
 	retval = fmh_gpib_generic_attach(board);
-	if (retval)
+	if (retval) {
+		put_device(board->dev);
 		return retval;
+	}
 
 	e_priv = board->private_data;
 	nec_priv = &e_priv->nec7210_priv;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpib_control_status");
 	if (!res) {
+		put_device(board->dev);
 		dev_err(board->dev, "Unable to locate mmio resource\n");
 		return -ENODEV;
 	}
@@ -1410,6 +1413,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	if (request_mem_region(res->start,
 			       resource_size(res),
 			       pdev->name) == NULL) {
+		put_device(board->dev);
 		dev_err(board->dev, "cannot claim registers\n");
 		return -ENXIO;
 	}
@@ -1418,6 +1422,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	nec_priv->mmiobase = ioremap(e_priv->gpib_iomem_res->start,
 				     resource_size(e_priv->gpib_iomem_res));
 	if (!nec_priv->mmiobase) {
+		put_device(board->dev);
 		dev_err(board->dev, "Could not map I/O memory\n");
 		return -ENOMEM;
 	}
@@ -1426,12 +1431,14 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos");
 	if (!res) {
+		put_device(board->dev);
 		dev_err(board->dev, "Unable to locate mmio resource for gpib dma port\n");
 		return -ENODEV;
 	}
 	if (request_mem_region(res->start,
 			       resource_size(res),
 			       pdev->name) == NULL) {
+		put_device(board->dev);
 		dev_err(board->dev, "cannot claim registers\n");
 		return -ENXIO;
 	}
@@ -1439,6 +1446,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	e_priv->fifo_base = ioremap(e_priv->dma_port_res->start,
 				    resource_size(e_priv->dma_port_res));
 	if (!e_priv->fifo_base) {
+		put_device(board->dev);
 		dev_err(board->dev, "Could not map I/O memory for fifos\n");
 		return -ENOMEM;
 	}
@@ -1447,10 +1455,14 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 		(unsigned long)resource_size(e_priv->dma_port_res));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		put_device(board->dev);
 		return -EBUSY;
+	}
+
 	retval = request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev->name, board);
 	if (retval) {
+		put_device(board->dev);
 		dev_err(board->dev,
 			"cannot register interrupt handler err=%d\n",
 			retval);
@@ -1461,6 +1473,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	if (acquire_dma) {
 		e_priv->dma_channel = dma_request_slave_channel(board->dev, "rxtx");
 		if (!e_priv->dma_channel) {
+			put_device(board->dev);
 			dev_err(board->dev, "failed to acquire dma channel \"rxtx\".\n");
 			return -EIO;
 		}
@@ -1517,6 +1530,12 @@ void fmh_gpib_detach(struct gpib_board *board)
 					   resource_size(e_priv->gpib_iomem_res));
 	}
 	fmh_gpib_generic_detach(board);
+
+	if (board->dev) {
+		dev_set_drvdata(board->dev, NULL);
+		put_device(board->dev);
+		board->dev = NULL;
+	}
 }
 
 static int fmh_gpib_pci_attach_impl(struct gpib_board *board,
-- 
2.17.1


