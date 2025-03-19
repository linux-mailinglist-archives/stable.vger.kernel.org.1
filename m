Return-Path: <stable+bounces-124913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556CA68B84
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 12:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980451B61705
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1886255233;
	Wed, 19 Mar 2025 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4cgMsPl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99093254B05;
	Wed, 19 Mar 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383357; cv=none; b=raKyw7pOcN4TTNzZYcB1ILDjNdCeyQLbkShU2lY/d2QmLiWjXaKSgWj6RvGLlaq8IdMAs4PiPPGC8A4n08vdkzXi/9+qXv7BWV2VwaDJJ6Wg5dIoL+8nePyKLjyeHiD+D9swJiuEQ0RzichBsCFmtJvSrMhPrF62x9us5Thn0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383357; c=relaxed/simple;
	bh=aY+wT718jcd7J9zYcBPNjAxxvgMi/7jJqwdrk3HqTIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kw9ZIaHRHCLshYBxRrDRpObi7AkeYU+L+9rNMERPJM211/gCFRf3XZtovWbfWxS1uAP0CNhpbvctJ6ndgCKxbm8OTWo5pKSTRZnUkJjTtQXGCC7g1aVBzA5NuKhFQZJR5NH0+tdCFOMQM/uW2Kj179gqjJoOloJb1rWX++Lie/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4cgMsPl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5986130f8f.0;
        Wed, 19 Mar 2025 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742383353; x=1742988153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqFmyb1JpY335n5hykX+2u4g/6H0xVX+LFgESzsIi/w=;
        b=A4cgMsPla1CWwWVu7RKMYAxXi19+QtETv5crQ+5eO1po7uYNVFhhCtP5IeOO5o+s5x
         mmRWbvFbrclzhsMmZWx5ksCxSoey4gTmAiLA/V3y7NwGD36un8bUowS+c5zvFfLKuD8f
         D+G7BDIHAxevKCsWu3MCJvNJZXYPnEK+GslXLwPmTIYio8RCkS3zqbqWZJAqR6G75DjV
         oDTpyww7ZnOL16SlFrrls+IWUk0AW9s8jDNZ0koqYB4vRUbCjeGPlloDNUVFEw+fIF64
         WR3SFc/2crfyT3fl1Jtre+THj9yecE1Zy7C2X0U0iwjnMHN6q+AAZfbpmmfc9bF6uDxH
         vBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383353; x=1742988153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqFmyb1JpY335n5hykX+2u4g/6H0xVX+LFgESzsIi/w=;
        b=a9S6Ebtemt/0wHCe9P2QvOPyUusk9pyd4LbeJJgg9K+KmnYcKRvioTVAK/p1IDTEFU
         N2eTTrfJeRfHB6wpMZ4b/X4SdlPw4dO5mF0tGLMK/v9bhr4FNkOOqWY+MkPcrJKiwuVV
         BtaCBuACfobWECHFb9tZnDtG1x5VkUMAGlNtapVCCG8sWEhvImcRX+DP2VYcAasCuTHy
         0/DEQgAc7fwZhwz66/AnV+WbnBWFa/U0HOrf6xJn/VxASn2C0ucTTRhfrt+iFoYhyj3n
         AZOrwCPasUVtmXnzM66ECfVzOtzXdxm1NUFyHBi1wTbsmh97yLoC34EA6EgZ2Xz25OX6
         +YCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8zZZpuHilNMH47pYDF0GzOQwFRcz7KIclZonVLCZNciOrewb6SL9Sx7MTEDsqZsRDQm2MeFFd@vger.kernel.org, AJvYcCVyTdgRUlz9FSxLqy/Em+T4Cj3uKbaPb/3KCjOKWCKCoRWp+D5FUOHPW/1DjsMRmO+eOkw/LNNWvXQIYxQ=@vger.kernel.org, AJvYcCXfr14WRzbzNbJZA4ZhphZZL9dagqqSK4NwFxD75aQ90ZUEuAN2r8v5oS/k3N7NpGQU+FbXzyQi@vger.kernel.org
X-Gm-Message-State: AOJu0Yykyq9nazoH97AJT7CiYqp1ffneAxfBLyQ7q1nAu+6aTCCm5dBp
	MJ47gtXJVWT5CU13zFP4Z/P1uWCZoL19WSJptL422FK9115kguzp
X-Gm-Gg: ASbGncslXTMpnM3bhCvESr0DJ6jL4/GJMCETxS2RxUS/CRCuuhKVVU7NtDLvJ1QUJnC
	nDoPFmolnxc4BtyoM0em7Y56B5L1DlPQchgIvi4vqBd2zZXy7ntxPA/OdP1hOahZFw8CQuOzxsv
	qZkBNZ+A0q2462rduhLb4hNfBFQNp7wUb0YlxN72BJDdZa1CsI3HaifqpHuLshxV3pk1mXBj3xq
	moKepkHDkLXeaCqBx45Gq2ISx7/hsO+Bn1lzh7Inq+IZh7zngZGzoxrn7m4nHaVf53dn0DA1/+q
	klac+C2Q36seGXSHDyO30tSahDphfM0j1DtDMBq7E3uy
X-Google-Smtp-Source: AGHT+IFL9MGUujUDBlU3/GDWOPTBACNACMU/SkTPOYXvhtc0IL+svb6lUh6e379UZLXYraEphqGwbg==
X-Received: by 2002:a5d:5847:0:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-399739b63d0mr1968735f8f.5.1742383352680;
        Wed, 19 Mar 2025 04:22:32 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:7659:65a:5e42:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f331dasm16129995e9.8.2025.03.19.04.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:22:32 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qasim Ijaz <qasdev00@gmail.com>,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Date: Wed, 19 Mar 2025 11:21:53 +0000
Message-Id: <20250319112156.48312-2-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319112156.48312-1-qasdev00@gmail.com>
References: <20250319112156.48312-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mii_nway_restart() during the line:

        bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);

The code attempts to call mii->mdio_read which is ch9200_mdio_read().

ch9200_mdio_read() utilises a local buffer, which is initialised
with control_read():

        unsigned char buff[2];

However buff is conditionally initialised inside control_read():

        if (err == size) {
                memcpy(data, buf, size);
        }

If the condition of "err == size" is not met, then buff remains
uninitialised. Once this happens the uninitialised buff is accessed
and returned during ch9200_mdio_read():

        return (buff[0] | buff[1] << 8);

The problem stems from the fact that ch9200_mdio_read() ignores the
return value of control_read(), leading to uinit-access of buff.

To fix this we should check the return value of control_read()
and return early on error.

Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/mii.c        | 2 ++
 drivers/net/usb/ch9200.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mii.c b/drivers/net/mii.c
index 37bc3131d31a..e305bf0f1d04 100644
--- a/drivers/net/mii.c
+++ b/drivers/net/mii.c
@@ -464,6 +464,8 @@ int mii_nway_restart (struct mii_if_info *mii)
 
 	/* if autoneg is off, it's an error */
 	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
+	if (bmcr < 0)
+		return bmcr;
 
 	if (bmcr & BMCR_ANENABLE) {
 		bmcr |= BMCR_ANRESTART;
diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index f69d9b902da0..a206ffa76f1b 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -178,6 +178,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 {
 	struct usbnet *dev = netdev_priv(netdev);
 	unsigned char buff[2];
+	int ret;
 
 	netdev_dbg(netdev, "%s phy_id:%02x loc:%02x\n",
 		   __func__, phy_id, loc);
@@ -185,8 +186,10 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	if (phy_id != 0)
 		return -ENODEV;
 
-	control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
-		     CONTROL_TIMEOUT_MS);
+	ret = control_read(dev, REQUEST_READ, 0, loc * 2, buff, 0x02,
+			   CONTROL_TIMEOUT_MS);
+	if (ret < 0)
+		return ret;
 
 	return (buff[0] | buff[1] << 8);
 }
-- 
2.39.5


