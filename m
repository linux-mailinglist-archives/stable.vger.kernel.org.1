Return-Path: <stable+bounces-189877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3633DC0AE0C
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 17:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D0243499D1
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026F2C11D4;
	Sun, 26 Oct 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxAXl5sQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887125485A
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497021; cv=none; b=FKxk6Cuoc171iItOzgX1gl9cJSVmXAIVr+QEQ/r4WxGHhVYMKFFuhe+CNpjNfvnqwnT5nRlU9/KcqwDjKQCl2gXPZh6lAXIvdCqmBoC6QgH9BV0cqtk4q8Y8Ldwsh6rMr38Xu+uXe2apbVUezP/++G6wYMQ47YRBA5zNl/n94Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497021; c=relaxed/simple;
	bh=2blCvwW/JNfSePtiQhOpyFAVkiDR84ySlcLJfmQoOvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1h9I64IbMDr8k8b7hw9szJVoH0/XxSVZ8l298Hcz5oj1fZwOS+imNtkOWNjhYyjN/R5wWYwpZFCxb6lgJFe0DR8AVSkz//DLMbW0/xkK4uTwTRoND3K5FXMN5qmxVDGYVyPbRvbnWPq6WNeP2FTERQ4vvB5UejbTJHt/ngOI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxAXl5sQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso3551416b3a.0
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761497018; x=1762101818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCF061NAS8FhFP3hNpS05moHDGkV+h3U/U3CN5+nY3Y=;
        b=DxAXl5sQtELRP1vcSZKU/GpY9atRPG/tlMzgWNQqc6HLf0hkZWybnzK7UbPByM98hn
         Za0+1LO4s9ryppsa1kUqDjYSOxw0yMVtUAQwNo80OkcPKVh6Xmz55KvA0704fhyd4edn
         dgqFKS4Dj1l/wHvZJqaeMPE054Yc+NqKGL5aefM5iba2iVEbzsUqvxcAthlx76k+ri7f
         uE1RdSVkJvk8Kq0zgLEnp/rjyBNQQvp7UMmqjYE+LOo6aoIgRpohGWilR9XYq81sy0QS
         F1WEzUBKhEVM5LCJqcrOD26IWhmOtvRU7/GGDzf28RQV2diUrJrX9ABeMt9rOYSPNL2E
         wkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761497018; x=1762101818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCF061NAS8FhFP3hNpS05moHDGkV+h3U/U3CN5+nY3Y=;
        b=D2rtGEuH4KTkPHCMIfNhzpBXzgKMzyalgc+bREM6vsZt3Mfy6SFeU1dpk3ROS4cTbH
         i2K73ZpysBwTWlHBQ6dglAA+3bGTVj/GkVROwY5hrq0Jt0arvj2bBzj51O3nGx5/hmsb
         D/PwjuprVoptVIg65X8cSIYtO4QJqyGB7kUJNwLvlA67vkUuxMt7aXGEcunBvvIBn4Ed
         IEPsM1XE9RFX/9eesw5vNgzzOHmCA5dro+BkU3JB63SIg0Fy5BYk/RkbxtTs0nAHHOve
         B9dRopVtbKZuyjjVD34FDdRFcVfrMAGhGA15X2P5rRHkLE3UGOltKy5sC8RiTucTDod1
         4Y6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgoke1zpLXWjvBpm8Xqk9QtHXCNulgaKWBytRNwzFI2zzAwGPGLhp6YnaPzZKEf8SKh8Zq384=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6c63BuyHAzQ56Xg9X1thCXulUWmlx/1753AJbCAGYuTCU1qr
	Ookdm5TxoBoMoXl8wbxG+xHCkN/bQtA0KWQH3wMLz0mWJ8OApbGlsYWeFcUA+8HL90U=
X-Gm-Gg: ASbGncvxBRad7O3DLtmF9HN//io92Wa54WKKH/jWX5/kcSFEf4H2KmKYKZfTIVufJlY
	PJtRG2YyPMZfrpyZ6L7A+IV0dw0l34u0o7t8HN/CqVNGZjbYDbNP8145LM4+TZeTcBdZlQ9sfwk
	a81slGaiO9ORLhmqdq8Zvo5fZODVWA7DK3k7dItEmVa+p3Fn2shlTLiRzmP1VtDvy4xA+S1afrE
	RcVdUN2CryNrcBqqE9QhtV/yEbzfs/zXuTngTxW8mlcTm51QN7uNWRXsDvbgaz1b0Hq8zFXFA3z
	W79jHtGMtiZgviKBlens6FBac65IpqfePR16trGUjItwmnmod5t7Y1iC/17d37i3eu6cyc2Rxcw
	H/I1Hp64xiWc2OpGwIGOVWSWAc4k7p22pWKKghvkVSvErLzL2ENBymquPTA48Y/lXFUJeG1vRjr
	OQ4mAuoo6kQ9sxuA+3q2UbYV7otDF/GoQ65CcvryWy+0c=
X-Google-Smtp-Source: AGHT+IFf+qjeyS6hjsC0nfYxfHIiI+ppqXHvuLXgsxBumfjvvdYcGEtHm3eqB+rkAU1cSh6c7pSxUA==
X-Received: by 2002:a17:903:2446:b0:290:6b30:fb3 with SMTP id d9443c01a7336-2948b97658bmr102681155ad.16.1761497017589;
        Sun, 26 Oct 2025 09:43:37 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fee8014f6sm2961731a91.0.2025.10.26.09.43.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 09:43:37 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Xu Yang <xu.yang_2@nxp.com>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Max Schulze <max.schulze@online.de>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	David Hollis <dhollis@davehollis.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <david-b@pacbell.net>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] net: usb: asix_devices: Check return value of usbnet_get_endpoints
Date: Mon, 27 Oct 2025 00:43:16 +0800
Message-Id: <20251026164318.57624-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code did not check the return value of usbnet_get_endpoints.
Add checks and return the error if it fails to transfer the error.

Found via static anlaysis and this is similar to
commit 07161b2416f7 ("sr9800: Add check for usbnet_get_endpoints").

Fixes: 933a27d39e0e ("USB: asix - Add AX88178 support and many other changes")
Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
- v1:http://lore.kernel.org/all/20250830103743.2118777-1-linmq006@gmail.com
changes in v2:
- fix the blank line.
- update message to clarify how this is detected
- add Cc: stable
---
 drivers/net/usb/asix_devices.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 85bd5d845409..232bbd79a4de 100644
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
@@ -848,7 +850,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	dev->driver_priv = priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Maybe the boot loader passed the MAC address via device tree */
 	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
@@ -1281,7 +1285,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
 	int ret;
 	u8 buf[ETH_ALEN] = {0};
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
-- 
2.39.5 (Apple Git-154)


