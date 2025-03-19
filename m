Return-Path: <stable+bounces-124898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA42A68A00
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471847A2573
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F33253B5E;
	Wed, 19 Mar 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGvsf5ea"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB51AB50D
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381483; cv=none; b=O6/Qj7e6ui/Oa1s3nvRTOy0mXjUNqrhceM48dy6iJa7VuEyqrQlyla9ixDlwzBA7hexIjTRH8le1z8Ivt9PqgjIGDtXKvUkjS2hFZ1XygqNOu86AfjEA6yytQThJx4ycsQnTrgiWC7rS7sD2/up3ABMSH78IgLdmUAHWLKoxMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381483; c=relaxed/simple;
	bh=aY+wT718jcd7J9zYcBPNjAxxvgMi/7jJqwdrk3HqTIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqR2YLRJ6QgUM6/yIxRjHo24aIYV6yEeGQaKaeWp54lpT97/ZPHVVenFJqCEmtEz2pgaVUa0hMDFqdjc1dfLYQlHC1c+Gr87MMYPQ9Xvp17FGprDsBZC/9fT+fwc8o2so/MzA4Dl3m35w3loTRyecDLYhzer1CLbqG8Jz5sDUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGvsf5ea; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so28478275e9.1
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742381480; x=1742986280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqFmyb1JpY335n5hykX+2u4g/6H0xVX+LFgESzsIi/w=;
        b=cGvsf5eadSVa5djy8M0PXnNB3O4I6qPurrJwV5oW41jt8wKJtNsM0MdskNHk2ELAk1
         /XGf9AkVvNnb2FGYxoGqIHh4hAUJxTPNF2fxTOEtW1hN2zH8IucdMQTZ3DZdEOYGtRC5
         eL5idnUE4J+iA2ihnOKdWgwmyzM+0bjsc6Cv0CQrdY6YSmFckVt0tjzhiGfF7opNwjrr
         usrJ5/sl29o2BP1Tf9XaiNXDvGuqfAKXfjCDMSuSpRxF7gWBOPSaLBH89FZfMuc/YMNA
         3wmH0f2o70wgKff9Vp3Kq+48nGbrAB2jbxGFP/Qzv0bUkba5E4T9GYALunAWkuCUrMKB
         wRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742381480; x=1742986280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqFmyb1JpY335n5hykX+2u4g/6H0xVX+LFgESzsIi/w=;
        b=pkYrDjyHOK7Crw8frwxXqBc42tttA7TL5xBSZIXq9cCWkVI7QcpyyMd+Zy8YUskUaB
         KdZ0oJxdak87zcVNI2pfjqVncngDphU53MMHM9zp6AdOvvOXvlRRucPcA2IBfVdDnrIe
         BDtucapDn8ZCIAaDvYg9qiDaoFISqbeECkLQRDL8/geTdau8zCTiYDULN7eIzVp9+Am5
         F1mhh7FO+PVJBjeWU0bkqgMlxnKy31+mN/ivm1N7x3VxQZEO8P2dN6o86OMQtamWoFo6
         0+Xu1Sgt57hkggSHrO0ePDOyPB8WOqu2moI+Wg2ebFGTxUUSGpljEDe8k+KLyr5fX8Nz
         AoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs7S6duXLQ9/HEXXZgGCRcBCJyRiVbvF991evq736HUfXoaeVEKBYPUFQBHgKi8vUduZhYjmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtD0sopw4Fgg316fxEPoRK9SyyaCNLZc1agyIKFGNIhhkjvOKW
	FbmpcK3rbbJnK2NhbjupHwYFLBOWaDwsUtdRNIXCeKxB7ofbK5KQ+vZoTw==
X-Gm-Gg: ASbGncsb+4FfomnaYmGjbWwnwz66S+NtZO0KskgMlnijKeRhHJMXjcevMJRh8MBqOCj
	lyY9+UBlbWpuNKCpRYO6laNLF/JB3Kw5fCfIRH4oAHHz+IRlsIWfAyMDRr57RzOPQwH+Z3qx116
	8c99ZdmD2DA/DjS+bIuyi9MKBanJSookXlSTXdFB64v2yZt1zDVXTlaM9PNOMnRVJ4YfW2WKUys
	/hxrKOaY56g1HKGCsWvT/ZI8SBIGKtdYhuF1eiHtm1tVPqorAQ6UKa23XqN7/XlOLZvj6F1uNlc
	AcGI08c0DH+0ZbcGmPKQammouEu0pnqHQlaRGqLkCdseMcF+zLr3UPpJCQ==
X-Google-Smtp-Source: AGHT+IH9FRBtEm0zl/It/vymMpRwuZUssIHZt+F8O/mAoL4FRuD8LOG1RLUGuwHWcI0U33zvtgH2Ig==
X-Received: by 2002:a05:600c:4503:b0:43c:fab3:4fad with SMTP id 5b1f17b1804b1-43d437c3354mr20919835e9.16.1742381479303;
        Wed, 19 Mar 2025 03:51:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:7659:65a:5e42:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f74c2asm15027005e9.31.2025.03.19.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:51:18 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: 
Cc: Qasim Ijaz <qasdev00@gmail.com>,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Date: Wed, 19 Mar 2025 10:50:42 +0000
Message-Id: <20250319105045.43385-2-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319105045.43385-1-qasdev00@gmail.com>
References: <20250319105045.43385-1-qasdev00@gmail.com>
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


