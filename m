Return-Path: <stable+bounces-202994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6E4CCC418
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 15:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E9D30A9DDA
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFC285C88;
	Thu, 18 Dec 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH4mhZSy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BE257852;
	Thu, 18 Dec 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067646; cv=none; b=k0MtO8VOhH+uNP3RyQvdST31kZjKy5KUtXIAshdf6C6bqsUn9cTtEZyI6Xlq6jFiyCO4GQJPC8c3yR7NZJ9fn9DIGyPCYQmD2/iSPBYyW8WJNjgw3rliCtq0FnztYqSqynWR9fgCFncUIoANFlWTC6+6dDNl11gzC2rTlHDk5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067646; c=relaxed/simple;
	bh=n1EbVAM7CU4kmC42XnjfjvQExlpZouOeA9C4bDSbnCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxjI6bL48MdjKHcU9sMb4JKlFdwyW8shDIFoaDnos6Tox+eJbna7Rbc2ZZM/zM8wiolChQhKfNvLODccON1WfWtYV9jv+pFRHyi7Mg1oruK/DG37fP4pOEA4b551UHsBmwsV/9SL2+1vLMf4mnyUOvvZ9Z6Th2NBCGPpv/nFVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH4mhZSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818C6C116C6;
	Thu, 18 Dec 2025 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766067646;
	bh=n1EbVAM7CU4kmC42XnjfjvQExlpZouOeA9C4bDSbnCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mH4mhZSyKLO5PFKSsDNX04SyNYfZTlQ5ApFSKS0+GQKXCjf0xW87qp/Nw+8CP9pYS
	 eqIfrC2M+MOZ8AwvPwd2hrRV5Zkxb1/D39s3IhNobVyY1wgI4tOG6pkficJpI+joKR
	 Jjq6kIuJyJU4lPM8qO9WBMaSE7Mpfy7YSsVIef/9kONKGV7Agwji1Ouab2G8Bbcy4k
	 +b1wFDZJCfxX1iPNvwEGfHgKMZNDn1lbDqkPgST5K8EZadkGeoF8x3hIh8qHw9bzmH
	 DmsjFw+Zzu3Hrlgnd6nmF6kkV1H/gTrd3aDEoPCcyy2Q/2zAtQyMWWNAT5ZqEDD4V0
	 P+lBPvF9l2uuw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vWEs0-000000001YG-2rLt;
	Thu, 18 Dec 2025 15:20:44 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ma Ke <make24@iscas.ac.cn>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] usb: gadget: lpc32xx_udc: fix clock imbalance in error path
Date: Thu, 18 Dec 2025 15:19:41 +0100
Message-ID: <20251218141945.5884-2-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251218141945.5884-1-johan@kernel.org>
References: <20251218141945.5884-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change fixing a device reference leak introduced a clock
imbalance by reusing an error path so that the clock may be disabled
before having been enabled.

Note that the clock framework allows for passing in NULL clocks so there
is no risk for a NULL pointer dereference.

Also drop the bogus I2C client NULL check added by the offending commit
as the pointer has already been verified to be non-NULL.

Fixes: c84117912bdd ("USB: lpc32xx_udc: Fix error handling in probe")
Cc: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 73c0f28a8585..a962d4294fbe 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3020,7 +3020,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	pdev->dev.dma_mask = &lpc32xx_usbd_dmamask;
 	retval = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (retval)
-		goto i2c_fail;
+		goto err_put_client;
 
 	udc->board = &lpc32xx_usbddata;
 
@@ -3040,7 +3040,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 		udc->udp_irq[i] = platform_get_irq(pdev, i);
 		if (udc->udp_irq[i] < 0) {
 			retval = udc->udp_irq[i];
-			goto i2c_fail;
+			goto err_put_client;
 		}
 	}
 
@@ -3048,7 +3048,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	if (IS_ERR(udc->udp_baseaddr)) {
 		dev_err(udc->dev, "IO map failure\n");
 		retval = PTR_ERR(udc->udp_baseaddr);
-		goto i2c_fail;
+		goto err_put_client;
 	}
 
 	/* Get USB device clock */
@@ -3056,14 +3056,14 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	if (IS_ERR(udc->usb_slv_clk)) {
 		dev_err(udc->dev, "failed to acquire USB device clock\n");
 		retval = PTR_ERR(udc->usb_slv_clk);
-		goto i2c_fail;
+		goto err_put_client;
 	}
 
 	/* Enable USB device clock */
 	retval = clk_prepare_enable(udc->usb_slv_clk);
 	if (retval < 0) {
 		dev_err(udc->dev, "failed to start USB device clock\n");
-		goto i2c_fail;
+		goto err_put_client;
 	}
 
 	/* Setup deferred workqueue data */
@@ -3165,9 +3165,10 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
 			  udc->udca_v_base, udc->udca_p_base);
 i2c_fail:
-	if (udc->isp1301_i2c_client)
-		put_device(&udc->isp1301_i2c_client->dev);
 	clk_disable_unprepare(udc->usb_slv_clk);
+err_put_client:
+	put_device(&udc->isp1301_i2c_client->dev);
+
 	dev_err(udc->dev, "%s probe failed, %d\n", driver_name, retval);
 
 	return retval;
@@ -3195,10 +3196,9 @@ static void lpc32xx_udc_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
 			  udc->udca_v_base, udc->udca_p_base);
 
-	if (udc->isp1301_i2c_client)
-		put_device(&udc->isp1301_i2c_client->dev);
-
 	clk_disable_unprepare(udc->usb_slv_clk);
+
+	put_device(&udc->isp1301_i2c_client->dev);
 }
 
 #ifdef CONFIG_PM
-- 
2.51.2


