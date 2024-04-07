Return-Path: <stable+bounces-36185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D062289AF4E
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59816B21581
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45F12B7D;
	Sun,  7 Apr 2024 07:59:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7522F4E7;
	Sun,  7 Apr 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476750; cv=none; b=uiAfq5Z5ka8lHxz/rAPL3mYy3UJ9mTMfBviU+TgduSNcXvusyL5JXafI3CzbuE17wN9NEUK9xdE5YUUWA6S2eTQm0mhD0au2de4k+VfVW1mJ2KL5h5bsP5TfHYh+sKygvosSTmirkFE8BfZCclxjIkxP8wEGevOSXaugVtrvv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476750; c=relaxed/simple;
	bh=umpEPG5e4IRUn6CQljWlAIot08VG+XtIQj73ktnnmY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omd83Mm5L690Gfj92UtGN4hSaplk3S3VfM3Em5iipTyqhtYJ+FIT4MjwzmxVdtnnqhv0ZUlwUyJAgqcjvxrMnznXKGLvpJ/LMIF9iAqvzLjTZwnP/bV7R/zH5D9pfeEjDSQNViXPpU2KHqjb3yvWlebwPN4Sg97ZLxomdwrcRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VC4N20xm9zbfMx;
	Sun,  7 Apr 2024 15:58:10 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id D9C3D14010C;
	Sun,  7 Apr 2024 15:59:06 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 7 Apr
 2024 15:59:06 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <horms@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <nichen@iscas.ac.cn>
CC: <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<stable@vger.kernel.org>, <wangweiyang2@huawei.com>
Subject: [PATCH net 2/2] net: usb: asix: Replace the direct return with goto statement
Date: Sun, 7 Apr 2024 07:55:13 +0000
Message-ID: <20240407075513.923435-3-yiyang13@huawei.com>
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

Replace the direct return statement in ax88772_bind() with goto, to adhere
to the kernel coding style.

Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/net/usb/asix_devices.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index d8f86bafad6a..11417ed86d9e 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -838,7 +838,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	ret = usbnet_get_endpoints(dev, intf);
 	if (ret)
-		return ret;
+		goto mdio_err;
 
 	/* Maybe the boot loader passed the MAC address via device tree */
 	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
@@ -862,7 +862,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 		if (ret < 0) {
 			netdev_dbg(dev->net, "Failed to read MAC address: %d\n",
 				   ret);
-			return ret;
+			goto mdio_err;
 		}
 	}
 
@@ -875,7 +875,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	ret = asix_read_phy_addr(dev, true);
 	if (ret < 0)
-		return ret;
+		goto mdio_err;
 
 	priv->phy_addr = ret;
 	priv->embd_phy = ((priv->phy_addr & 0x1f) == AX_EMBD_PHY_ADDR);
@@ -884,7 +884,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 			    &priv->chipcode, 0);
 	if (ret < 0) {
 		netdev_dbg(dev->net, "Failed to read STATMNGSTS_REG: %d\n", ret);
-		return ret;
+		goto mdio_err;
 	}
 
 	priv->chipcode &= AX_CHIPCODE_MASK;
@@ -899,7 +899,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	ret = priv->reset(dev, 0);
 	if (ret < 0) {
 		netdev_dbg(dev->net, "Failed to reset AX88772: %d\n", ret);
-		return ret;
+		goto mdio_err;
 	}
 
 	/* Asix framing packs multiple eth frames into a 2K usb bulk transfer */
-- 
2.25.1


