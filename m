Return-Path: <stable+bounces-124041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68890A5CA81
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D2A3B47F9
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0312126039A;
	Tue, 11 Mar 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXRE2DNo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8525F968;
	Tue, 11 Mar 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709544; cv=none; b=uf16g1ou9YEUg/8jgnYSSucB7oTHlck+q5Qq7k0TuAviyBSIy4tcHtKC/RCQ8+MqFNoBoTzFXGKuebJmB6BqNkZnU5BUQb/lL8KCdoELBermfjmbWtD8FNiJPP8bha0HoOjPRnplHOJhF8Qzhjaf3I7INgbHOO/ciZi3bEcmcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709544; c=relaxed/simple;
	bh=08ikVFE4r7eJqr1YdwoBE6cm67vMz6CsVPTbF/HeYwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/zYpolCt2I9yicTmOwxPt0gfPQ35htpNhwz7n1EMeaA6GRwitimDSAbh6w556x5+AgiMeOPyZs7SvgM2qkyrfGCn6rKuTR6c2NXMKuN96VzhZIJxiCfgjvujeRkgamA1PXDbd9XXqV1v8Gs08IILwY5X/lJqg5B8yoY2wBR3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXRE2DNo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bdf0cbb6bso33874855e9.1;
        Tue, 11 Mar 2025 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741709541; x=1742314341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YVAPWNU6X9KodjU6cnxu6uXZ4aud/elyY8D03IVUK4=;
        b=YXRE2DNo23+IHfRcRwA//AEy69psE6t2cZoVubpVam6xu+VulG4AkGSj9+6RKZM0xq
         tE+keIyScQffeHu5fBD1TaDOBp5BCR0iRzCdvQRy5SYWZepJxyfhdyFkmcsp+gCXdRCJ
         NHVbbqCOe/rPiyrYI1qG2i5Z0rIUxHb+IJwcqdPCTnVeWXy2D43HrOb/aK8EkE3qx6oE
         P4EsoAqg/kTiszdQZb+q52Xm6JN8wpLWS/xhD3GThsp93CwouD3oJ1swa+hbXV1kO2pS
         Jq0Hx898oehe0QYVFZh6+zFPmqhiT9v3wIZCEruAiz2lRJCcIpEFOfUx2sP5bFfDSV8H
         Sg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709541; x=1742314341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YVAPWNU6X9KodjU6cnxu6uXZ4aud/elyY8D03IVUK4=;
        b=OJ6al1a0UbP+jQHtEwhj3+8kt22c85OQrIfhKXKojx5bfSOgdWV2gwX+gaMlhPay0p
         9G+KG2pKZC5vEZceUR45T+dstEQsFOvkNnqxs7dRFMei5m9pIKjk+rLrQUECPqtnolee
         U9U/AjCwoIfF5cGu3KuWuLudJTeKQZJSfK+AR7m5tmCihugvo73icympH2uXAJ2uloOR
         E6PC06HNql5zp2F1mOHAgkekynC2ogd4XdRyw1rrdarSPg6glNnwd4Wf9PbGWx+JtwwR
         D4GmKJBY4uZP54dwO6fDwYftgbHgyqwWLZlOIieEM91bI/do+KDphai3Im3mOcHL+nvJ
         yFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBaUhMXhx09Q2BVPgVw0coit68cAW04jRtftaUEw1yqkut+FsaptDMt97ZYLqhUk84jeWYncyR@vger.kernel.org, AJvYcCUCDLOjueLj72XahV6vTfw0RccSeMq+pzgDBKE0xihXB2S8d7PucwAv6xj1kjnCrySwXIBYrF1algEl@vger.kernel.org, AJvYcCUn2t2o2l4HPWapqiKPsn1UwZigUCvTDEJSettWFEm4lh2T9rdkkQSroJohzTmmkebUFmdiFkL72bsu5ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWs0OWCElcA9NxolUek2cF2iw1NVTFeFLcT4/bIgo8mOZAIRuD
	mqZ/V1tTgOBkWdqzHgZM99t+1YkpHZZQUZZaRthhSCoPqc7UWxqs
X-Gm-Gg: ASbGncs5GFzr3RkZof2so9tE+BEDyJ7gWAlW9fYnQlIGKjSDDPt8LZBc9taDWN2EADD
	p0K1jY8BoZLTdhM5a5HOh4pCXFEO6DrQvSvFHhUJhPnGVKhxnHa0IRMEsdiYx6gYnYrLP682BQ+
	T8lMMhz7oVNX+JOwBAdGKLWZKaEBIJduFAUMoxK48ul6HhWVDS9d3DvU5+jp7yUUpUHffoj9Js8
	I+rz0y7d/01u7nGoUdv2Ld4FwdRB9TtfBtRhKWoE56HgwtQvsumJKY5nuNjAwUgxgDTvW2FejqC
	b7nVBvspH5EqxHpJfkB1/fWGANN/3DKhZVBb1PF2JL8ZUs5NgxQw/Xy8qig=
X-Google-Smtp-Source: AGHT+IFBLUgDMtRyAUVGrvv/9k4E3aCt70nIDcjTBdSBDZPdsLITH9UrfoUY3TMgTJSh+RJ7J+y8MQ==
X-Received: by 2002:a05:600c:3b94:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-43cf8fcf858mr77369445e9.3.1741709540584;
        Tue, 11 Mar 2025 09:12:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:4d2a:98a0:d51e:4f69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d073555e5sm15331905e9.4.2025.03.11.09.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:12:20 -0700 (PDT)
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
Subject: [PATCH] net: fix uninitialised access in mii_nway_restart() and cleanup error handling
Date: Tue, 11 Mar 2025 16:11:57 +0000
Message-Id: <20250311161157.49065-1-qasdev00@gmail.com>
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

Furthermore the get_mac_address() function has a similar problem where
it does not directly check the return value of each control_read(),
instead it sums up the return values and checks them all at the end
which means if any call to control_read() fails the function just 
continues on.

Handle this by validating the return value of each call and fail fast
and early instead of continuing.

Lastly ch9200_bind() ignores the return values of multiple 
control_write() calls.

Validate each control_write() call to ensure it succeeds before
continuing with the next call.

Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/mii.c        |  2 ++
 drivers/net/usb/ch9200.c | 55 +++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 17 deletions(-)

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
index f69d9b902da0..e938501a1fc8 100644
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
+		return ret;
 
 	return (buff[0] | buff[1] << 8);
 }
@@ -303,24 +306,27 @@ static int ch9200_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
 static int get_mac_address(struct usbnet *dev, unsigned char *data)
 {
-	int err = 0;
 	unsigned char mac_addr[0x06];
-	int rd_mac_len = 0;
+	int rd_mac_len;
 
 	netdev_dbg(dev->net, "%s:\n\tusbnet VID:%0x PID:%0x\n", __func__,
 		   le16_to_cpu(dev->udev->descriptor.idVendor),
 		   le16_to_cpu(dev->udev->descriptor.idProduct));
 
-	memset(mac_addr, 0, sizeof(mac_addr));
-	rd_mac_len = control_read(dev, REQUEST_READ, 0,
-				  MAC_REG_STATION_L, mac_addr, 0x02,
-				  CONTROL_TIMEOUT_MS);
-	rd_mac_len += control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_M,
-				   mac_addr + 2, 0x02, CONTROL_TIMEOUT_MS);
-	rd_mac_len += control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_H,
-				   mac_addr + 4, 0x02, CONTROL_TIMEOUT_MS);
-	if (rd_mac_len != ETH_ALEN)
-		err = -EINVAL;
+	rd_mac_len = control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_L,
+				  mac_addr, 0x02, CONTROL_TIMEOUT_MS);
+	if (rd_mac_len != 2)
+		return rd_mac_len;
+
+	rd_mac_len = control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_M,
+				  mac_addr + 2, 0x02, CONTROL_TIMEOUT_MS);
+	if (rd_mac_len != 2)
+		return rd_mac_len;
+
+	rd_mac_len = control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_H,
+				  mac_addr + 4, 0x02, CONTROL_TIMEOUT_MS);
+	if (rd_mac_len != 2)
+		return rd_mac_len;
 
 	data[0] = mac_addr[5];
 	data[1] = mac_addr[4];
@@ -329,12 +335,12 @@ static int get_mac_address(struct usbnet *dev, unsigned char *data)
 	data[4] = mac_addr[1];
 	data[5] = mac_addr[0];
 
-	return err;
+	return 0;
 }
 
 static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	int retval = 0;
+	int retval;
 	unsigned char data[2];
 	u8 addr[ETH_ALEN];
 
@@ -357,37 +363,52 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 	data[1] = 0x0F;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	data[0] = 0xA0;
 	data[1] = 0x90;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FIFO_DEPTH, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	data[0] = 0x30;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_PAUSE, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	data[0] = 0x17;
 	data[1] = 0xD8;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FLOW_CONTROL,
 			       data, 0x02, CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	/* Undocumented register */
 	data[0] = 0x01;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, 254, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	data[0] = 0x5F;
 	data[1] = 0x0D;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	retval = get_mac_address(dev, addr);
+	if (retval)
+		return retval;
+
 	eth_hw_addr_set(dev->net, addr);
 
-	return retval;
+	return 0;
 }
 
 static const struct driver_info ch9200_info = {
-- 
2.39.5


