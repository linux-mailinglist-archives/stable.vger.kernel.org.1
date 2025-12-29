Return-Path: <stable+bounces-203567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 547EBCE6EA1
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238123005FF5
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557F22F16E;
	Mon, 29 Dec 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1mzbEZFZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36705224AF0
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016441; cv=none; b=J3hfIatMwH5Gq3/xBIMNUFnL5Ur6zVyGxDlPXa/nStgj3JqLOHP+C54xOkqhq8WTX/iDwS/+26EKUkpFUlgF2rAH5cyHzkRMoA3jXt72I/PiedmJ9SaAotuWKERJCvu9tIe/1aoq1j6Cbw1QRtsGP82Byk9eWkiRiNsDQ2i+RhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016441; c=relaxed/simple;
	bh=DhfI5Z+WcNIPWDjVCyVzYSjRYxJPIw5o11TCzLRBvY0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S6SU+8FtzLvabHzBZvyStOUgdFkKsXl9aP2WLl5t7w1BaEp38bzf4/5ArAnM4EnSmuZZP4ztXUwCU5enfqCd9PHYAgZGU3/8Pb9W4HYA0rOf84k7ZqJ5/wRhFXPWX162N+1aC6WfYVzzHSWGm2VJpzOE6btpWetJaeD9NxBDdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1mzbEZFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F57C4CEF7;
	Mon, 29 Dec 2025 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016441;
	bh=DhfI5Z+WcNIPWDjVCyVzYSjRYxJPIw5o11TCzLRBvY0=;
	h=Subject:To:Cc:From:Date:From;
	b=1mzbEZFZPSF/qPqk7nP2MU/gcQnXS+8ufwSc6mfwDXHHRqzg7oHLBlskbTUhLw8TM
	 OZH+pELlsg5U0YQ/E8865YcUUMAv1JRcpJcc0qlcLScFmQlf/WfBBFTZkhLlryoGsg
	 ET8Y1VU6VcruutD+gcG1V0xDTP9GUV6ffaP+8XYM=
Subject: FAILED: patch "[PATCH] usb: gadget: lpc32xx_udc: fix clock imbalance in error path" failed to apply to 5.10-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,make24@iscas.ac.cn,vz@mleia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:53:45 +0100
Message-ID: <2025122945-exemplary-politely-9c27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 782be79e4551550d7a82b1957fc0f7347e6d461f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122945-exemplary-politely-9c27@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 782be79e4551550d7a82b1957fc0f7347e6d461f Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 18 Dec 2025 16:35:15 +0100
Subject: [PATCH] usb: gadget: lpc32xx_udc: fix clock imbalance in error path

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
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Link: https://patch.msgid.link/20251218153519.19453-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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


