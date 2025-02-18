Return-Path: <stable+bounces-116631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7959FA38FE4
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 01:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB3C7A37EF
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 00:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB8A933;
	Tue, 18 Feb 2025 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny6faVZL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C976E545;
	Tue, 18 Feb 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739838327; cv=none; b=HpXPe/MmxmVfYPdGKRDIvVVWG9TnivhnHJRioc9HSGpm6Uf45cHVG/YKKZpQkTVB34K1Pq/KmGNdGEjrJ0tI8JLNBiYxKpDKjXdrCX8klF/kK7OoL1nwFsPNSSlQDktkh7jnZNKxLyFIb+EPxkVCeEXQuax3RSO9iMWzEpe+IlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739838327; c=relaxed/simple;
	bh=EFJw1G6AdYPAxqc3eJvXKne5aFMBnMqVqo01SdhVK8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2lN1PmEN2SgS6mBuM6Oo2h7wCjSpCRlp+CMQeXlyLmMeNa+lm1ch7VdXJ1gRaIBleKsbT2OwXSJ6x/jCoobyam+/lqTclc6/GjkFceZsS2Wy9pndItcGEps0xL7kPymQDycUHz2PD6HuTxQ8qWIlrXZIOGtFtHVJwZI/j0hmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny6faVZL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so51026305e9.1;
        Mon, 17 Feb 2025 16:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739838324; x=1740443124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8m1uQh6w5iYJ3orp8b5EeRdmeUvkTNV6vuD529TfFW8=;
        b=Ny6faVZLYssWlwOdj2XF1xCuezvAWM+r9xKXLicftU+sTUGu96MAa4rx0Mi4bHhhyO
         PzDrcyY7Jx988b/vdwCkozW5IUSi9es5iWgkaA+tEv4/x70nNIdTc9qPK4qQned9Tser
         hvREAeTYsxI+ZBBDGdODwIXLVtBhVR5+ayqpfUVic7dLjdrTixjF7AV1dYBEq88qBPAC
         YmR29vPie9vhmOEe3IxwKRx4ENqBRA2ZkeA5qqs4Z45U8oaT5m7DdbfJs3cWCE/ulBQ5
         NkVDdRZOyZk2/yiTsODj6VbHm7wbOTCfKuvBEA9jJAQlUz5Fzc+YDVOnF7NNd2eZrUAx
         ObVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739838324; x=1740443124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m1uQh6w5iYJ3orp8b5EeRdmeUvkTNV6vuD529TfFW8=;
        b=hVP0kFvOlXy2HzZDez3eL0OI8ykwdQMz/ClJrQP4YFFTyAMAmYydiVs3ourazYBrvO
         nUtkvrH9bxPvvCC4zLhprUxzADEwq3GO1lLe/NdgW2TOl/h3SznBRLxrgDq2HGzrVlLL
         h099/CiRTJJQ3YG3qgZRTfyzEj0+obzXN/LSHpo7JuZ5vwsiCEAv8pg+x3nXmayxAnJU
         bR2cZTQvK9RGfIztHCn5KYdHWQ6xqZsZJdgV9RyTeDCdjbIEoGWN1aC010m+emVK5wGp
         jtIpcGuq+x/Lop+NRlpwQLfDAxEBC38JC8pGDLuC1EQj0CI281RnPyfLUxWMDWaeDakv
         rrCA==
X-Forwarded-Encrypted: i=1; AJvYcCUQhzQ7d+ZBZlwLxxqnXgMoJyxTEW8zgMidAVAX4KivWlX3FTN2yTd5sFJZayYR4HxpMgLamNGCTOv9@vger.kernel.org, AJvYcCVLxeDuZG+PAec04eWS/md+URjcnUIird3uk/wufWvyrs0pnw2kihpfGMZIGxEBURjRTc1jJnAKbJuIqqI=@vger.kernel.org, AJvYcCWcPe5nmirJjFkYlLiIdEvOvcV+w6mxrxpJVoJ8n9q+EZluBQrojEgBv+oKDbpXb19XzC7wJgim@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqe6um5SFMrpHYFeR7F7m+4uSIoW94XRMJB3rpCWceFJm6a5KB
	NLdmrajFDyIZgx8aRnRINivRbQJx7+f37RT7Mq2Meu5tk+EvSHxhWwVSqGRV
X-Gm-Gg: ASbGnctH3ZtAgxrP18z11aBPAu8zVfkwuIJhQ2vQK8v3Myhqr4+hYe+mbw9oDIrFXyB
	n/XSdxIulHnHV4/U+mGrDwlKyPkYGCYog8KqXA+S6n0ncyqcEY5corucvq7zBw5WwcSvjCRycBz
	8B4F0iPaK8mpEeRgdv6eZ8i6ZorYDwRHuSiMv2+URPjr5SxqdNh4YhUSxskmvu+HunlsNq7K3KL
	uadInXd9fJ++//OXQ/ctL32yqQuV+DtcWvG5U6FKLhSE44j3tnZdvzAy961G8YupXlxQR/eWu2e
	Dp3LmViaSAFkpVl/
X-Google-Smtp-Source: AGHT+IFEwVOQfWAk3usB+gCbjckJ1M+hXwhwG3/4LSm+JCb/QOyIiORIX6KA7JP7mO6j+vJj81w/qw==
X-Received: by 2002:a05:600c:4f94:b0:439:4706:ae04 with SMTP id 5b1f17b1804b1-4396e7171b4mr123085705e9.16.1739838323483;
        Mon, 17 Feb 2025 16:25:23 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:1981:9861:b731:66d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b84bcsm171982195e9.40.2025.02.17.16.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 16:25:23 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: fix uninitialised access in mii_nway_restart()
Date: Tue, 18 Feb 2025 00:24:43 +0000
Message-Id: <20250218002443.11731-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Cc: stable@vger.kernel.org
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
index f69d9b902da0..e32d3c282dc1 100644
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
+	if (ret != 2)
+		return ret < 0 ? ret : -EINVAL;
 
 	return (buff[0] | buff[1] << 8);
 }
-- 
2.39.5


