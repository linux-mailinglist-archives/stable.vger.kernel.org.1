Return-Path: <stable+bounces-36183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11B89AF49
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A751F21BD8
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5214F107A8;
	Sun,  7 Apr 2024 07:59:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76007DDBD;
	Sun,  7 Apr 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476750; cv=none; b=rp00vffms7HIFlyDzD3m6DBFrQsyEVTNwPpkybAf98OCEV2pD8EBprzO6fu5B1VqMzxCiJOxcYv/IOk/DW72QDa9UcmPdQJRH6VTVEnX9gLUvQdYHWe7RHlSdNEXj722r7m+ydYFvULNb8l5aixA0PPp5CkI5BR22QnmsIGgMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476750; c=relaxed/simple;
	bh=cN2nfIJctyVX2abj+BMVaCeo6vMBONneF88FutMZ6Wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NluZu9DChoDYEqFxPzaH/urarRFDvkSwRG3Na5lZgLnrh9m6h1du3CZT8wJ3Bu14oGB5nPtLNfZBd+RWH3kc/ZFd2IFs56YH+GVO6zILdyKsir0z6NANEdW5LBgYfQDVbH3+t+XgkLeDdMTiSww0TH9xeKLeLLsdePWmWDF/LG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VC4Kp2KPlzwRTB;
	Sun,  7 Apr 2024 15:56:14 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id 64D82180A9B;
	Sun,  7 Apr 2024 15:59:06 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 7 Apr
 2024 15:59:05 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <horms@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nichen@iscas.ac.cn>
CC: <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<stable@vger.kernel.org>, <wangweiyang2@huawei.com>
Subject: [PATCH net 1/2] net: usb: asix: Add check for usbnet_get_endpoints
Date: Sun, 7 Apr 2024 07:55:12 +0000
Message-ID: <20240407075513.923435-2-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240407075513.923435-1-yiyang13@huawei.com>
References: <20240407075513.923435-1-yiyang13@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)

Add check for usbnet_get_endpoints() and return the error if it fails
in order to transfer the error.

Cc: stable@vger.kernel.org
Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
Fixes: 4ad1438f025e ("NET: fix phy init for AX88772 USB ethernet")
Fixes: 933a27d39e0e ("USB: asix - Add AX88178 support and many other changes")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/net/usb/asix_devices.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index f7cff58fe044..d8f86bafad6a 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
 	int i;
 	unsigned long gpio_bits = dev->driver_info->data;
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto out;
 
 	/* Toggle the GPIOs in a manufacturer/model specific way */
 	for (i = 2; i >= 0; i--) {
@@ -834,7 +836,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	dev->driver_priv = priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Maybe the boot loader passed the MAC address via device tree */
 	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
@@ -1258,7 +1262,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
 	int ret;
 	u8 buf[ETH_ALEN] = {0};
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
-- 
2.25.1


