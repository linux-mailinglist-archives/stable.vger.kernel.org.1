Return-Path: <stable+bounces-204202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1302CE9C3A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAC47300384D
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF571F4CBB;
	Tue, 30 Dec 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYgiVS6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864E1EEA5F
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100764; cv=none; b=V4ktTJC42Zmq6K1BmMgkew5nBAWbYLCfAy5cO5NKyeS4n947N78plMsvq6Er2YblGzfjHNU4NWfD3AhoCX2LnVg9HEbdkOS+EvcFbAeCyxgDikSh3AeYCDDkIdB5vfKz5nISeRhw+zphozQlEJNjAQRs/yO/0zcVTmfuHQo9Xp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100764; c=relaxed/simple;
	bh=w73gBAReQ9sCrgWV8zxfLd2z4dP4eSwqXJxwW4OI9Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eopRBTfaNr9KnOMAFch7GwZ12jK/ZTVwBO7ZgJYnhbPCVV0EaXp+oFn+A6SiiV36lSmsXkH35DQTJqjRoKM4wlQmc8Hm0hYcbjGcda0C4GgCHRC5xJri38tDbLsQrk1gMbPjfRJLVQupsqgg/tuDtldrj64swgdXa0NcwKZjsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYgiVS6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B797C19422;
	Tue, 30 Dec 2025 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767100763;
	bh=w73gBAReQ9sCrgWV8zxfLd2z4dP4eSwqXJxwW4OI9Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYgiVS6/uBoLW6lXW/OfHK/QAeemU/esWelQaph2DYPTkLhDq8oy3QIvuXiJZTekL
	 beSSJ/7GfXgRl3muhGp0p/64MxLqCLG9goRgOQyUoyL9X7aYwxukB3LKmarqp3KKcZ
	 43o3EFd5+wmuxKSW9nScd6jccubF+Et6P8IVaG8KVLKqpshM3KsC6paszdyse3+VXJ
	 nb2IPfuoRS8Ap0ov7PzVk1oyC5FiV+ZskGj7rKrhKmJDGNC+CgziFI6D3+e691Nd1J
	 iZBnRE6FAjDKkNmarFDrWgozGd5P6LdJfjYjhh4qTTwSELb2Xg1xXH+Iw9X2/EwL8q
	 Br5Z7cWATaHdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: ohci-nxp: Use helper function devm_clk_get_enabled()
Date: Tue, 30 Dec 2025 08:19:20 -0500
Message-ID: <20251230131921.2177523-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122926-cushy-unstylish-3577@gregkh>
References: <2025122926-cushy-unstylish-3577@gregkh>
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
index 8264c454f6bd..5b775e1ea527 100644
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
 
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -229,8 +222,6 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	ohci_nxp_stop_hc();
 fail_resource:
 	usb_put_hcd(hcd);
-fail_hcd:
-	clk_disable_unprepare(usb_host_clk);
 fail_disable:
 	isp1301_i2c_client = NULL;
 	return ret;
@@ -243,7 +234,6 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
-	clk_disable_unprepare(usb_host_clk);
 	isp1301_i2c_client = NULL;
 }
 
-- 
2.51.0


