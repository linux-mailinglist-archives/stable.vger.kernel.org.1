Return-Path: <stable+bounces-202993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF3CCC41B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 15:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE5CC30ABFBD
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCB285050;
	Thu, 18 Dec 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1qogwPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B423D7FF;
	Thu, 18 Dec 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067646; cv=none; b=kLBjW9BI2ekgAgbwSY7o6ibPfgDIpwFPlp2JW/d4MUYKbCUghp+0Y8MT+3MHffX2d6YYGkqjQh7wQQXl09nO3tRFkrmaX3lURTCCZcL5bYQigvY7yRWqCA6kE+ucYqEYWomxIQcIOx/3g6CwxddXqWNhHSj1rKqmraLmHj7SokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067646; c=relaxed/simple;
	bh=FhwZAwxk5GSdjJw5kwHI4Ojzyh/ABP7YaR9bgf68cMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUWKdwcpoL1g/pNskdbUgKes49bVtC8wDUAw0SleRDMnLNuGh4rh+n9clMQ2BQSSlbJm5lCz7zaCfKxBYOdSiBK0IihfICAUVV6u/0ZtCn6+zyPQPIYDeUa4lAgFkXGi21hT5bMzkK4+3Vyy7ojYU0msOc9vZLWZOOfyGY85PP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1qogwPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BC1C19422;
	Thu, 18 Dec 2025 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766067646;
	bh=FhwZAwxk5GSdjJw5kwHI4Ojzyh/ABP7YaR9bgf68cMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1qogwPGzBaD9hwd1h9D1mHjLUEBpD5l1/ZK3BjjYX3SpxgvGhse9RArBzhNoWXO7
	 0GmQbr30h9PB0Zc/m63Yn1iDySyU1z7acpVCnoKNMI/cZwKKlsoOeOy40Wo9VRIMm2
	 PxT28n4IT2/7/j54z2fjqFASMRbcxR1jJUc9CVYGsOQAuYqYctyXfxb7QY0wbt4Fqp
	 Knlr46/nLtmrUVmmPCyfeqDySD3YkVf3XJwmNgtquvRSBPjEGL1QJIFyYwZnV0tFJI
	 Q+pKBm5109VsuSJgW/2gd+He05jVJ1ujP5gw8urqnUbKa/owbtAfk9KVrU6SBVYFY+
	 /ztM9f1rQENxA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vWEs0-000000001YL-3cGR;
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
Subject: [PATCH 3/5] usb: ohci-nxp: fix device leak on probe failure
Date: Thu, 18 Dec 2025 15:19:43 +0100
Message-ID: <20251218141945.5884-4-johan@kernel.org>
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

Make sure to drop the reference taken when looking up the PHY I2C device
during probe on probe failure (e.g. probe deferral) and on driver
unbind.

Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
Cc: stable@vger.kernel.org	# 3.5
Reported-by: Ma Ke <make24@iscas.ac.cn>
Link: https://lore.kernel.org/lkml/20251117013428.21840-1-make24@iscas.ac.cn/
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/host/ohci-nxp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 24d5a1dc5056..9a05828bbba1 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -169,13 +169,13 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 
 	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
-		goto fail_disable;
+		goto err_put_client;
 
 	dev_dbg(&pdev->dev, "%s: " DRIVER_DESC " (nxp)\n", hcd_name);
 	if (usb_disabled()) {
 		dev_err(&pdev->dev, "USB is disabled\n");
 		ret = -ENODEV;
-		goto fail_disable;
+		goto err_put_client;
 	}
 
 	/* Enable USB host clock */
@@ -183,7 +183,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	if (IS_ERR(usb_host_clk)) {
 		dev_err(&pdev->dev, "failed to acquire and start USB OHCI clock\n");
 		ret = PTR_ERR(usb_host_clk);
-		goto fail_disable;
+		goto err_put_client;
 	}
 
 	isp1301_configure();
@@ -192,7 +192,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	if (!hcd) {
 		dev_err(&pdev->dev, "Failed to allocate HC buffer\n");
 		ret = -ENOMEM;
-		goto fail_disable;
+		goto err_put_client;
 	}
 
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -222,7 +222,8 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	ohci_nxp_stop_hc();
 fail_resource:
 	usb_put_hcd(hcd);
-fail_disable:
+err_put_client:
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 	return ret;
 }
@@ -234,6 +235,7 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 }
 
-- 
2.51.2


