Return-Path: <stable+bounces-203565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A515CCE6E9B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2363B3001BF4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFAC22A4EB;
	Mon, 29 Dec 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z/SWBHAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F303224AF0
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016435; cv=none; b=lj8+68RrdlRm1iRmEqy6CIUW73L+29jlxZ++sKbzGntf6ngFb4FaYevGiX2y02ZuzNE/0QJIrK5qZSkxKBau1UfpjG5Nv4udEbMpmTyOlliGo/fRtt5jolZvDiirKzHAZuMhtTykVKc3AZjy3HbYCunsBs3SC2+ylkrLH2i2rqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016435; c=relaxed/simple;
	bh=rqAYYsE35lQcnRYmKpgO/VReOcWEgyXNoCnAlkmO+ic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ju0+hthTY6daV6K9TmITXuG1bW0fBdNYgYed4zeNoXxRl0TLSW2zr6AGlxKNUnxF3Tc8Umv9PsP/KwLPiwHfVXZmVLS49h4SILf9mn/D+JIb+efk8qyGOL/klMctAo1joYYyhhWxoYnZkAy7hwOol3fqqv1mxU2RtsqodOePlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/SWBHAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7218C4CEF7;
	Mon, 29 Dec 2025 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016435;
	bh=rqAYYsE35lQcnRYmKpgO/VReOcWEgyXNoCnAlkmO+ic=;
	h=Subject:To:Cc:From:Date:From;
	b=Z/SWBHAhVDA4gciRsrHqyO+Yjk8nEQzXWwWNOnhel3+MXG59OrAUWfG3/fc4KzYS5
	 MlQwA5+fM0lV6SP89AOVgkC+Z9mttegQgFJyt90u91P+JLu3g6L1PirmD4UPNwyJcg
	 zQO+O/Z+1TdkNXdNIr0VpODkOd0FgpImL+mbi+OI=
Subject: FAILED: patch "[PATCH] usb: gadget: lpc32xx_udc: fix clock imbalance in error path" failed to apply to 5.15-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,make24@iscas.ac.cn,vz@mleia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:53:44 +0100
Message-ID: <2025122944-county-snowplow-ae8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 782be79e4551550d7a82b1957fc0f7347e6d461f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122944-county-snowplow-ae8e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


