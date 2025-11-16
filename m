Return-Path: <stable+bounces-194852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E124FC60EBE
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 02:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63F3435D350
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0051F4168;
	Sun, 16 Nov 2025 01:50:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BC1DA23;
	Sun, 16 Nov 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763257816; cv=none; b=e8fhFGVR1ozhysJeK7RNQ8GOwopqF+fR3uQ+MqiSzh84lX2HOwnSe2CXAgiHJFv0vmsZ80UWs8Lp5AXxJj0VYUBPVfggxGM8K1xag/mYiQavIcybEDwFq4Q7jVmqN7g3bsXQIDJ7BHfcJ1Q6SsRVWjkQpAErd1FXIuGU/01BEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763257816; c=relaxed/simple;
	bh=uf49/6eknRCvXoQMkkLGmvy+FYqcoEWtiuIlzP8T3cc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mK1+QtLeXvwxPYiW6M+39oZOaTQxH9qdkfnRqQrAEDsVqXGZkRmzgpgZCH3kAIEKukci/gEQW+enKWlL8S0WwW7SGahXpABlOFo7xowvXH7Nib3Oxsy3QWMUYzRk4KX/QcxpxhVfthC6GwoIR/KkY0D78BmgoLw7DEIaKfKfeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowACHD9K9LRlpsrLqAA--.8809S2;
	Sun, 16 Nov 2025 09:50:00 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com,
	make24@iscas.ac.cn,
	arnd@arndb.de,
	stigge@antcom.de
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH] USB: Fix error handling in gadget driver
Date: Sun, 16 Nov 2025 09:49:48 +0800
Message-Id: <20251116014948.14093-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowACHD9K9LRlpsrLqAA--.8809S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48CrWxCryUAry7Gr15Arb_yoWruryUpr
	18GFWYkrWDGr9Fkw17A3WDuF1SkF4Iy3yrtrZ7G3Wqk3ZxZr9rJ3W8uFy2qF4xJF97Cr4f
	Aanxta10y3W8urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmQ6LU
	UUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

lpc32xx_udc_probe() acquires an i2c_client reference through
isp1301_get_client() but fails to release it in both error handling
paths and the normal removal path. This could result in a reference
count leak for the I2C device, preventing proper cleanup and
potentially leading to resource exhaustion. Add put_device() to
release the reference in the probe failure path and in the remove
function.

Calling path: isp1301_get_client() -> of_find_i2c_device_by_node() ->
i2c_find_device_by_fwnode(). As comments of
i2c_find_device_by_fwnode() says, 'The user must call
put_device(&client->dev) once done with the i2c client.'

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 35 +++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 1a7d3c4f652f..b6fddfff712d 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -2986,6 +2986,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	int retval, i;
 	dma_addr_t dma_handle;
 	struct device_node *isp1301_node;
+	bool isp1301_acquired = false;
 
 	udc = devm_kmemdup(dev, &controller_template, sizeof(*udc), GFP_KERNEL);
 	if (!udc)
@@ -3013,6 +3014,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	if (!udc->isp1301_i2c_client) {
 		return -EPROBE_DEFER;
 	}
+	isp1301_acquired = true;
 
 	dev_info(udc->dev, "ISP1301 I2C device at address 0x%x\n",
 		 udc->isp1301_i2c_client->addr);
@@ -3020,7 +3022,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	pdev->dev.dma_mask = &lpc32xx_usbd_dmamask;
 	retval = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (retval)
-		return retval;
+		goto i2c_fail;
 
 	udc->board = &lpc32xx_usbddata;
 
@@ -3038,28 +3040,32 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	/* Get IRQs */
 	for (i = 0; i < 4; i++) {
 		udc->udp_irq[i] = platform_get_irq(pdev, i);
-		if (udc->udp_irq[i] < 0)
-			return udc->udp_irq[i];
+		if (udc->udp_irq[i] < 0) {
+			retval = udc->udp_irq[i];
+			goto i2c_fail;
+		}
 	}
 
 	udc->udp_baseaddr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(udc->udp_baseaddr)) {
 		dev_err(udc->dev, "IO map failure\n");
-		return PTR_ERR(udc->udp_baseaddr);
+		retval = PTR_ERR(udc->udp_baseaddr);
+		goto i2c_fail;
 	}
 
 	/* Get USB device clock */
 	udc->usb_slv_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(udc->usb_slv_clk)) {
 		dev_err(udc->dev, "failed to acquire USB device clock\n");
-		return PTR_ERR(udc->usb_slv_clk);
+		retval = PTR_ERR(udc->usb_slv_clk);
+		goto i2c_fail;
 	}
 
 	/* Enable USB device clock */
 	retval = clk_prepare_enable(udc->usb_slv_clk);
 	if (retval < 0) {
 		dev_err(udc->dev, "failed to start USB device clock\n");
-		return retval;
+		goto i2c_fail;
 	}
 
 	/* Setup deferred workqueue data */
@@ -3161,6 +3167,8 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
 			  udc->udca_v_base, udc->udca_p_base);
 i2c_fail:
+	if (isp1301_acquired && udc->isp1301_i2c_client)
+		put_device(&udc->isp1301_i2c_client->dev);
 	clk_disable_unprepare(udc->usb_slv_clk);
 	dev_err(udc->dev, "%s probe failed, %d\n", driver_name, retval);
 
@@ -3170,6 +3178,18 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 static void lpc32xx_udc_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_udc *udc = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *isp1301_node;
+	bool isp1301_acquired = false;
+
+	/* Check if we acquired isp1301 via device tree */
+	if (dev->of_node) {
+		isp1301_node = of_parse_phandle(dev->of_node, "transceiver", 0);
+		if (isp1301_node) {
+			isp1301_acquired = true;
+			of_node_put(isp1301_node);
+		}
+	}
 
 	usb_del_gadget_udc(&udc->gadget);
 	if (udc->driver) {
@@ -3189,6 +3209,9 @@ static void lpc32xx_udc_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
 			  udc->udca_v_base, udc->udca_p_base);
 
+	if (isp1301_acquired && udc->isp1301_i2c_client)
+		put_device(&udc->isp1301_i2c_client->dev);
+
 	clk_disable_unprepare(udc->usb_slv_clk);
 }
 
-- 
2.17.1


