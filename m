Return-Path: <stable+bounces-180904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D9EB8F9EB
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6AF3B0D0E
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ADE277CBF;
	Mon, 22 Sep 2025 08:45:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB918A6A5;
	Mon, 22 Sep 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530740; cv=none; b=rpbU6TcC7dwzQ42vgZMMZUJlkHE2QUmIXZl9JyZXfdjTw2u6v/WiAMChrEGVU4CreLqbsYss/3Ys0Hj1pGCGCLnhTVdZKAhXxt4vtd4aS8kdriwA+vHQiPo1mul2Cdz5RutS2wrN1xDSCWTT/EgcuRTgX1aHuP0mb/ujzlrgxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530740; c=relaxed/simple;
	bh=vbKdgEGj+Nr6AxwJ+6W6+x69mUP+qFpAekN5T6aTStY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=epABNnPN3xYVYB5Am9Vg58HVNHIO+D2GDs/wr5D4Ll+njEpvMKwGmLFesps4/UOTERVFdyeRSYqRK2LoXHATA+tcayT12LOR5s70ykHT4GML4c4nicIzZNtE6QZbcMHGzhbg4OTXT+S6562hstoNTNAIhIRAA8KvgWpMdZ0YBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowADniBKZDNFovBhHBA--.4477S2;
	Mon, 22 Sep 2025 16:45:22 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	matchstick@neverthere.org,
	dominik.karol.piatkowski@protonmail.com,
	arnd@arndb.de,
	nichen@iscas.ac.cn,
	paul.retourne@orange.fr,
	dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] staging: gpib: Fix device reference leak in fmh_gpib driver
Date: Mon, 22 Sep 2025 16:45:12 +0800
Message-Id: <20250922084512.9174-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowADniBKZDNFovBhHBA--.4477S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW8Xw1xAFW8WF4kAw4UCFg_yoW7uw17pa
	yxWa15KrW8twnaqF43Jw1UXFsYyw42y345uw47C343A3ZYvrWjyF4kKa4a9ryrtrWkJr45
	trWjgr409FWDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYv38UUUU
	U
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
Changes in v2:
- modified the free operations as suggestions. Thanks for dan carpenter's instructions.
---
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 66 +++++++++++++++++++-----
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 4138f3d2bae7..f5be24b44238 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -1396,7 +1396,7 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 
 	retval = fmh_gpib_generic_attach(board);
 	if (retval)
-		return retval;
+		goto err_put_device;
 
 	e_priv = board->private_data;
 	nec_priv = &e_priv->nec7210_priv;
@@ -1404,14 +1404,16 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpib_control_status");
 	if (!res) {
 		dev_err(board->dev, "Unable to locate mmio resource\n");
-		return -ENODEV;
+		retval = -ENODEV;
+		goto err_generic_detach;
 	}
 
 	if (request_mem_region(res->start,
 			       resource_size(res),
 			       pdev->name) == NULL) {
 		dev_err(board->dev, "cannot claim registers\n");
-		return -ENXIO;
+		retval = -ENXIO;
+		goto err_generic_detach;
 	}
 	e_priv->gpib_iomem_res = res;
 
@@ -1419,7 +1421,8 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 				     resource_size(e_priv->gpib_iomem_res));
 	if (!nec_priv->mmiobase) {
 		dev_err(board->dev, "Could not map I/O memory\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto err_release_mmio_region;
 	}
 	dev_dbg(board->dev, "iobase %pr remapped to %p\n",
 		e_priv->gpib_iomem_res, nec_priv->mmiobase);
@@ -1427,34 +1430,41 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos");
 	if (!res) {
 		dev_err(board->dev, "Unable to locate mmio resource for gpib dma port\n");
-		return -ENODEV;
+		retval = -ENODEV;
+		goto err_iounmap_mmio;
 	}
 	if (request_mem_region(res->start,
 			       resource_size(res),
 			       pdev->name) == NULL) {
 		dev_err(board->dev, "cannot claim registers\n");
-		return -ENXIO;
+		retval = -ENXIO;
+		goto err_iounmap_mmio;
 	}
 	e_priv->dma_port_res = res;
+
 	e_priv->fifo_base = ioremap(e_priv->dma_port_res->start,
 				    resource_size(e_priv->dma_port_res));
 	if (!e_priv->fifo_base) {
 		dev_err(board->dev, "Could not map I/O memory for fifos\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto err_release_dma_region;
 	}
 	dev_dbg(board->dev, "dma fifos 0x%lx remapped to %p, length=%ld\n",
 		(unsigned long)e_priv->dma_port_res->start, e_priv->fifo_base,
 		(unsigned long)resource_size(e_priv->dma_port_res));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -EBUSY;
+	if (irq < 0) {
+		retval = -EBUSY;
+		goto err_iounmap_fifo;
+	}
+
 	retval = request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev->name, board);
 	if (retval) {
 		dev_err(board->dev,
 			"cannot register interrupt handler err=%d\n",
 			retval);
-		return retval;
+		goto err_iounmap_fifo;
 	}
 	e_priv->irq = irq;
 
@@ -1462,9 +1472,11 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 		e_priv->dma_channel = dma_request_slave_channel(board->dev, "rxtx");
 		if (!e_priv->dma_channel) {
 			dev_err(board->dev, "failed to acquire dma channel \"rxtx\".\n");
-			return -EIO;
+			retval = -EIO;
+			goto err_free_irq;
 		}
 	}
+
 	/*
 	 * in the future we might want to know the half-fifo size
 	 * (dma_burst_length) even when not using dma, so go ahead an
@@ -1473,7 +1485,32 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
 	e_priv->dma_burst_length = fifos_read(e_priv, FIFO_MAX_BURST_LENGTH_REG) &
 		fifo_max_burst_length_mask;
 
-	return fmh_gpib_init(e_priv, board, handshake_mode);
+	retval = fmh_gpib_init(e_priv, board, handshake_mode);
+	if (retval)
+		goto err_release_dma;
+
+	return 0;
+
+err_release_dma:
+	if (acquire_dma && e_priv->dma_channel)
+		dma_release_channel(e_priv->dma_channel);
+err_free_irq:
+	free_irq(irq, board);
+err_iounmap_fifo:
+	iounmap(e_priv->fifo_base);
+err_release_dma_region:
+	release_mem_region(e_priv->dma_port_res->start,
+			   resource_size(e_priv->dma_port_res));
+err_iounmap_mmio:
+	iounmap(nec_priv->mmiobase);
+err_release_mmio_region:
+	release_mem_region(e_priv->gpib_iomem_res->start,
+			   resource_size(e_priv->gpib_iomem_res));
+err_generic_detach:
+	fmh_gpib_generic_detach(board);
+err_put_device:
+	put_device(board->dev);
+	return retval;
 }
 
 int fmh_gpib_attach_holdoff_all(struct gpib_board *board, const struct gpib_board_config *config)
@@ -1517,6 +1554,11 @@ void fmh_gpib_detach(struct gpib_board *board)
 					   resource_size(e_priv->gpib_iomem_res));
 	}
 	fmh_gpib_generic_detach(board);
+
+	if (board->dev) {
+		put_device(board->dev);
+		board->dev = NULL;
+	}
 }
 
 static int fmh_gpib_pci_attach_impl(struct gpib_board *board,
-- 
2.17.1


