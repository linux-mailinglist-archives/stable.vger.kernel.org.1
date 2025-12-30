Return-Path: <stable+bounces-204217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C609CE9CDF
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE37930184E4
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FF621B9D2;
	Tue, 30 Dec 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etpBrQPA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963F2A1BB
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767102085; cv=none; b=G1uxUAAvT9YFiExhkqIFNf4x6tzbseRK6p+bFYZPorMPdDWawBHhq7EQK+O34q9sOKGLhc5mAWwbNH+wDCLjQVgdODfRYvTIXwPMF7XWSMjnJB2YBX7q4XPH49EluGQBy6UX99p7a2eIgwiip+IrIuTt5ceip11u/51einSLfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767102085; c=relaxed/simple;
	bh=EqRI1jsgVZzjC7lkFNMYWxegwlGlPFg5gxM5HPhE5Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW90VBAIArZPsgl3i6geJQBLcDDV3v/q6gVCUr6VoKza/g749dsKas/tFCyo82S7vsirWa1hSDxQzoF2YjeW2yOxlNwYngz9zAaYUVctbVXWf7L2FNCOBqzW5TxXJwC5Qko0olDQJPjcl8BLxK19I90pKTYt92nHKqv3ndzA4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etpBrQPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B857BC4CEFB;
	Tue, 30 Dec 2025 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767102085;
	bh=EqRI1jsgVZzjC7lkFNMYWxegwlGlPFg5gxM5HPhE5Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etpBrQPA098oQNq53sLud7da0TNG3V4l1MK1pZxQTEwjN4e8tKDGOo47h6DmTmQUR
	 XdLoNs6Rg1z4wXrFkzExT3DENVgM+nMO03kkBxwLRks0mUk94rn8diSakJJjnabHPO
	 QXCwxMTWIZMIl7/sRz2aSAiLR+AZrhXORAPLOkt+SdLnXjc8pYlcdB2EIfsXv4gZAI
	 /6oua7uiTRywtKklUDkRmKigOc3XSdBpG+hmyVynSLs1eGhMY2slrbLqa8xw2Q+I+G
	 SXIfl9bjGZZMqX794Xk4rnTBNw1qrqDgOTpAzuAIE/Undg0x0UHuRCaEAVfFB0A5i2
	 F9uRVFhOkOj0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] usb: ohci-nxp: Use helper function devm_clk_get_enabled()
Date: Tue, 30 Dec 2025 08:41:22 -0500
Message-ID: <20251230134123.2206998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122927-preppy-grab-bb17@gregkh>
References: <2025122927-preppy-grab-bb17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Zekun <zhangzekun11@huawei.com>

[ Upstream commit c146ede472717f352b7283a525bd9a1a2b15e2cf ]

devm_clk_get() and clk_prepare_enable() can be replaced by helper
function devm_clk_get_enabled(). Let's use devm_clk_get_enabled() to
simplify code and avoid calling clk_disable_unprepare().

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20240902123020.29267-3-zhangzekun11@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b4c61e542faf ("usb: ohci-nxp: fix device leak on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-nxp.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 106a6bcefb08..f7f85fc9ce8f 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -51,8 +51,6 @@ static struct hc_driver __read_mostly ohci_nxp_hc_driver;
 
 static struct i2c_client *isp1301_i2c_client;
 
-static struct clk *usb_host_clk;
-
 static void isp1301_configure_lpc32xx(void)
 {
 	/* LPC32XX only supports DAT_SE0 USB mode */
@@ -155,6 +153,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret = 0, irq;
 	struct device_node *isp1301_node;
+	struct clk *usb_host_clk;
 
 	if (pdev->dev.of_node) {
 		isp1301_node = of_parse_phandle(pdev->dev.of_node,
@@ -180,26 +179,20 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	}
 
 	/* Enable USB host clock */
-	usb_host_clk = devm_clk_get(&pdev->dev, NULL);
+	usb_host_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(usb_host_clk)) {
-		dev_err(&pdev->dev, "failed to acquire USB OHCI clock\n");
+		dev_err(&pdev->dev, "failed to acquire and start USB OHCI clock\n");
 		ret = PTR_ERR(usb_host_clk);
 		goto fail_disable;
 	}
 
-	ret = clk_prepare_enable(usb_host_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to start USB OHCI clock\n");
-		goto fail_disable;
-	}
-
 	isp1301_configure();
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
 		dev_err(&pdev->dev, "Failed to allocate HC buffer\n");
 		ret = -ENOMEM;
-		goto fail_hcd;
+		goto fail_disable;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -230,8 +223,6 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	ohci_nxp_stop_hc();
 fail_resource:
 	usb_put_hcd(hcd);
-fail_hcd:
-	clk_disable_unprepare(usb_host_clk);
 fail_disable:
 	isp1301_i2c_client = NULL;
 	return ret;
@@ -244,7 +235,6 @@ static int ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
-	clk_disable_unprepare(usb_host_clk);
 	isp1301_i2c_client = NULL;
 
 	return 0;
-- 
2.51.0


