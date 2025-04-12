Return-Path: <stable+bounces-132322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF5A86EDF
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 20:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E255F8C1676
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 18:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6B221290;
	Sat, 12 Apr 2025 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8834B6M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80F1C3C08;
	Sat, 12 Apr 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483129; cv=none; b=DU2cc7wCaEXv2JveQVGPdCOX05lS4fr7G7oXBHA/V9ysB3hN26sOdEUTsLQ7aAnmrMQ+SIJYKlJ3c31hW5dxPJkMhXDzkzZeWde3BsZTQwE8A4nrALx1p1YkkOe/ZKWN1AV+i7w4SGnvBlLWp+0m66JG9BpR4L3mLjdod7sbD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483129; c=relaxed/simple;
	bh=ltZlME++UTgOP9mBlJKDodrJzoL8s2dPoYYY32aqyN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wy8rDMSH6B4r5kqjgzE3/yS7PBicDmrtN7UMjUMAtBEDlhzgSkRU2eaROG7awvJvYWxT6VRTgtVee783RskbRfxVP7RKNB6VyyKME04vbYQFE7BUbIk50oyZysFJvqVLUsrHWCxE9g/rbsSavQSGsMbKNXmKIcgtVXt0zy4KUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8834B6M; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-391342fc1f6so2404906f8f.1;
        Sat, 12 Apr 2025 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483125; x=1745087925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYDU3E3XPR50DS24Qi8VxPTo2QXky2XYmXYNdjritH4=;
        b=W8834B6MEXFSnPBmgM6SmX9/jFSwF4QnAFTTZicZHkC+8Qatq2rRDfEj1i3qgppdsz
         B3qD63k22KncZvi4DM09C6fQAgViVdtUdIdyXWvXEPN2ikziSK5UIZel7xCdB4hVCwCB
         P+GNg0BpcOBdgpk5btq4cif5/XC6cQ5hL9oyBn8iQiMPVMtzW8fxCca/dRdcODIpBrQW
         9J0PDsY2YkP+5uvWeNm1bKRQ1joTy2WSlM0NwL1PIhTF2Te5NyJ433I6pC4h/BJmF7aL
         G9Q+reIbkKwuc7V22dxOtRL8nyxrEyeEjvyMVBEP1mXmIzmLlZqhUxsdOTCefTizRUJj
         0h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483125; x=1745087925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYDU3E3XPR50DS24Qi8VxPTo2QXky2XYmXYNdjritH4=;
        b=jBLRjF7XcjYq5NXibM69Tv4mBTwChFATRdGRA8ARAdXTDmf6U14UKm5I/u03JAyj7G
         tcvKN47dC2QV6Maod3/QnXOjc6DvVLjPRWG2ygcdftvf+Bi28f/haaSzQ0wB5fnr3KaU
         VPxpF3ig0+JATPiN1BdCp1ayMcmv/5iHoi4li8v1qNAOrlE82ULjDadU098eF+mtnbpl
         CgMKu3VZmWppbwMps2kUnGJ4AyDMcAGasFN9tOdVupzSGr1YPNFTk8vapKDdkoxzG4TI
         gvzidIOrSWHFdY+SAuribfsA0U0w2a67SUVhW3ne+qoxS9MI45G+fjrPqREXd1a8W5JQ
         a/AA==
X-Forwarded-Encrypted: i=1; AJvYcCVjyR2LrvE8qIVAyLm/4O89fePU6fRnmPXlJKaSDn3ObUbT8lFQA2DBnsvHTkqZlU4HGsrpfJLckbKYL+c=@vger.kernel.org, AJvYcCVytRkziQgoloNazCLjbnRU2EaYKRsFqE+LpBN+ZS/rCNXbfUqVBabFiWTgGosp9EiiWMoxa44f@vger.kernel.org, AJvYcCWVYQsFFYI2A0vMvNubD+StIOdRFRNK41jtJVmjDFtz7TkpMvosdpsS0EDU5gKa2J/QxCHVWkA+wROq@vger.kernel.org, AJvYcCWdik+p+EQ+09m7fQzdtrEnOmcnZcjXk3JDLy4Z2VdeZFRA47DdZJcpMfdPX/lPrbPbuNkdYmJw@vger.kernel.org
X-Gm-Message-State: AOJu0YwyY29W5cJ/sDrZzwriSZNfcobzC8Hca+rJsmWNgjfSsbgC14qG
	ozsZ5WcvwY1mTW+hoREK+RYSg1CRx3/ENYLFiGxbNq6x7lRrLrQ+
X-Gm-Gg: ASbGnctjXqgvWe1hNj50R+ouiLwMC+DwMymoA29hZBs4SEp4wwN0sJcqF54LVmhyNha
	nO/fOibbXH/+JUCG22aOEJZJgoTwTeTplkNA3gV1EF0nSybXm7v1B6D+YieCxeS8lI7BpN6TgCq
	hlb9ZTk7aHUKPGl2JNoEXkb+qszzvAnXQyVI5SJ2xX5vAYPFWQWgUaiq3jAUl9OMEn1KNUneMYg
	kRXFxkMsXltGnfCT7vu5L1sJLIFwQx6uBYc7Heg154L+jFq0Gw4iUp8KUV5uMZ9XbRHIMOptY+p
	pQp3+WiL44Y7KoXtYNtGyjU1Xamia+/Im9YANbvflGoLBGZ+oAaH4g4=
X-Google-Smtp-Source: AGHT+IErCijy9ubZA0z2tHrjk+w1HwhThnpt/7AeExzcOuq7w3faR/wCCWwARUSq0fwgUXJprdt3dg==
X-Received: by 2002:a05:6000:4305:b0:391:ccf:2d17 with SMTP id ffacd0b85a97d-39e9f3cced7mr5640675f8f.0.1744483124681;
        Sat, 12 Apr 2025 11:38:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:f069:f1cb:5bbc:db26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm120599515e9.23.2025.04.12.11.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:38:43 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Cc: Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH 1/5] net: ch9200: fix uninitialised access bug during mii_nway_restart
Date: Sat, 12 Apr 2025 19:38:25 +0100
Message-Id: <20250412183829.41342-2-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250412183829.41342-1-qasdev00@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
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
and return early on error. We return 0 on control_read() failure here 
because returning a negative may trigger the "bmcr & BMCR_ANENABLE" 
check within mii_nway_restart.

Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index f69d9b902da0..4f29ecf2240a 100644
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
+		return 0;
 
 	return (buff[0] | buff[1] << 8);
 }
-- 
2.39.5


