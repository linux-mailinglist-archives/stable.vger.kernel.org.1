Return-Path: <stable+bounces-203003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F2BCCCC8B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 17:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44B913021F78
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E21634F475;
	Thu, 18 Dec 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULoPjDa/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7934F26F;
	Thu, 18 Dec 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072244; cv=none; b=JL4rkOHqz8iL1e45B87ORK8ihC/aSOGUMG2gWG1ymXoqli6CnvuLsLuS/e5oXihwV8F5Lue5Cs5KBpy1178qPWlGnsX/5aQCqLdi7+RpXgS9cCppvp5cT4Ygz2m1zqUs/8MiX585bBv90l8SeGNlTWapS82I/T6tpkF5K/jhMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072244; c=relaxed/simple;
	bh=n1EbVAM7CU4kmC42XnjfjvQExlpZouOeA9C4bDSbnCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM+IiO+Nn/7xHwgvwiPx1PkPx6Rt9I9EVFvSPSanZ1pkHO9Cjul4ROMW1tr+Ia9i/JC1haaQOofZpQ2yqZwr9xvyY0rVfqkPVSKOZov6DQuMcKzok79VbQwdl6vv40txJ4GRwlHg0MxOwu30arHp4uyJ5Yn6/A8kQmtO+9zNqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULoPjDa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED78C4CEFB;
	Thu, 18 Dec 2025 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766072244;
	bh=n1EbVAM7CU4kmC42XnjfjvQExlpZouOeA9C4bDSbnCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULoPjDa/9dVXVV4Of3BLpEhw6vHhHPmcNrVSB14F67XX3QXFEMNFDC6NWUzisUXIo
	 rdenMVLEdit9FuEortHaJ0FkWYhDwB8vz80NqNGs4CPV25o9Q02F4p7W9SaFmkVgYB
	 /su6UQjg1xOtSKzCgEjsgSjXCrdqV8Y+sCfLf2f5bioOXlqEZur3gzol9zuZNJBwaE
	 58xY+kgrvnqTeQK/A8Tdzr5P0zzTmftXPlLEl4odp5rs1GcS6cxW/5If7AVVQNBEQw
	 HwaSJUD0ZjYVQI1E1zpftY4p9SLekq6p10SNQj54v2Qy7h9xOkrCHdeueQ+ERF1RA6
	 AgVVf9B3mjOaw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vWG4A-00000000567-45pg;
	Thu, 18 Dec 2025 16:37:23 +0100
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
Subject: [PATCH v2 1/5] usb: gadget: lpc32xx_udc: fix clock imbalance in error path
Date: Thu, 18 Dec 2025 16:35:15 +0100
Message-ID: <20251218153519.19453-2-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251218153519.19453-1-johan@kernel.org>
References: <20251218153519.19453-1-johan@kernel.org>
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


