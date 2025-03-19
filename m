Return-Path: <stable+bounces-124911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF83A68B61
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 12:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586B1423D0D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544B25B670;
	Wed, 19 Mar 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvksRFPx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BC25524E
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382903; cv=none; b=qn95bjwBXqulfDN3wJznIOt4uA7o8wgnoxOooHfM8YLbnKNHjYgCemT8qFGH6qnWRYdqIJC88Sj3xRCm9HjvGqBQ3c5DkWE8LJa1VwE+atuGnNY94TLRggYnwhmpjwrB5AlGBBfNcXZrTpEag07KhIRneF6ZLjUrUwxxWleFR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382903; c=relaxed/simple;
	bh=aY+wT718jcd7J9zYcBPNjAxxvgMi/7jJqwdrk3HqTIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KH/oOijqpnd7GC8YZlZtebKbbIm2jGPran2geIZCZ2uzUpAXHhc3776DQzrjwqEBRCcOJrScFblkRR8HFIRkXANQ6s4VXEetIY80q+IRyfCjlS1+OZWiIVZtMPwdw+Hh9UFiMtH6MIwceJSBi198ixi5t52G47/plLWkSpgZY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvksRFPx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso45467815e9.3
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742382899; x=1742987699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqFmyb1JpY335n5hykX+2u4g/6H0xVX+LFgESzsIi/w=;
        b=gvksRFPxbM1gIIxu1jaFdAWL62IB+2Rxuheudo9U3B8jndaS63Wwvi1oHgTybl7cGF
         dbqYW7+8VpWM0CZx2MYUNC8YQOHVxGypSCY6nqSddO3Wu3sbZG/W2m6D2yj7bGxUOp2h
         QTHhrD4G8KxdwN0wjVszpEm5QMbgsd2t9aGUGLC9U4U3RvLIN24kYSKWwYxOYE53GyAG
         l8qeTssQkwj71ok4NuRqpVHa9LPQqc20KqO045l1reBCCAM1cLBKD/gXhspqwHcXNvHP
         ZGHjJ8E/hZ5uZMlBmySzEDP0e7HiHJvjovJipbX6ZY4SrxW8jEiArBJEY3UDP+enN8si
         4WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382899; x=1742987699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqFmyb1JpY335n5hykX+2u4g/6H0xVX+LFgESzsIi/w=;
        b=Gqz3RJYFYA/ORTby8csGRnFV09kUeY2h/QqGmToOv802By/5eWRYkWQzlZ/d78xrkc
         DaCP0G8joYpVjamrs68mkBF+6BYz0b5PJC5amAp0fFiFF/xlGlYXtsdqwtIDWzQnzDrh
         SsW7SiD6RPbGCMK9iOQhm08hOJTX0rsP0FL+H2aJReAPDrQWQa3giRWNlN1vMeqqucNw
         bXOscdy+6zi+D9+CcbiknguJl+2LHn3EMXEMhUEpF6j0WNakdtn3bGHgVEq/xAeVY4ff
         XQAuD9ScprPMgXusvp30qTAKMR6wGfGrh8nyB48E/D/LgKHbz57mGL2DJCKYWoiXzHQQ
         BbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTXrCRiWvKSGKA5VRGFXKteP4CPzxtcvmxjrScO9fvGgXEE39RmWUs8gKVhwS6jhFBIFczj8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwicoD1cFdQFfykj1G1v/bsIxGtwFL0PIGC66kkChPKtkFqN5vE
	ptprl2ju0uSTwdwNiB5SEF09mVNT/bXLLp3gz7YbQEXC5uY4YVrc
X-Gm-Gg: ASbGnctUwROEHwFvTCtThR6YetPDd0kCYs0msmA4vhmnB9LD6BCy51WjYgLKHOb6y/K
	qNU7vKYIl/ZeJESIhS/IYHO7Caa1lGc05DV+N4jrMo0xoWBaWAm6GQe+4+p8bkZ3+dTKEHLaWYw
	IRVLDAF02T250PFtr7T1fTFrenMR787NNFAb2gRTbl9eMej8R65bu9qMno+rshRK8TVukOLYG6Z
	9HF3qd2eKasntO0F6MmWzmIsqSmTMbEjXd62N6M9u6hJXYteRX0gZKFe0ZWZYkhBeaK8xyQUC/3
	sSgayDkO3DNyRCKoRFhVUSo7H2+x6/k/OrKzKKNUsj0x3QOf3Chpmniq1Q==
X-Google-Smtp-Source: AGHT+IF5u2+ZWno2imnegCnIpegs3nuXSbaY10+poB6n2yQwg8orjRtkDY8YtyKQ3z+9igvNP/Aflw==
X-Received: by 2002:a05:600c:19d2:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-43d43798a14mr17318605e9.13.1742382899162;
        Wed, 19 Mar 2025 04:14:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:7659:65a:5e42:31a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb953sm20948889f8f.93.2025.03.19.04.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:14:58 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: 
Cc: Qasim Ijaz <qasdev00@gmail.com>,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Date: Wed, 19 Mar 2025 11:14:41 +0000
Message-Id: <20250319111444.47843-2-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319111444.47843-1-qasdev00@gmail.com>
References: <20250319111444.47843-1-qasdev00@gmail.com>
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


