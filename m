Return-Path: <stable+bounces-132325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741AA86EE0
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E43189FCAB
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6222D4FE;
	Sat, 12 Apr 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwSsVDnS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946F2253F6;
	Sat, 12 Apr 2025 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483134; cv=none; b=JV9t3cu1H+QttCclweK5IYe6JyyTdyXcKRuEI5ov7iv7r7c+a5qxhlC4ZRdB/DJ/lENhmoM+os3RWZUlb6ZfuPiFZ4+oGZkzr18OL1TPL6QSEPy28gfbK0UGCxNP4O80T/TBQZTMeM7f+FK4VoAUWgk8HxP6YAKGMDhVl36m8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483134; c=relaxed/simple;
	bh=aAE/d7UpQHFw50I58n0+tir89bev9C8/OsLlB+W1FH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BvExVQ3DR6OJRVTlHvAcCj5DNQ8/6EIrzf+K9x1jywNcJuDXgq9bG2MRtdaMLSFbNETZy592v97aVN55k8oPgGJ1X8S9zQriXzh+3OrY+/CK3NNIsvyADZMlydXzZbW40lFHEfLw+w66dNAckPo/c7bxZKObpVDebYzZ++YjeRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwSsVDnS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-399737f4fa4so1622329f8f.0;
        Sat, 12 Apr 2025 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483131; x=1745087931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvqb0KMQk6u+lJxNrDAty2Q7xf8HSHBvDR79iDfIorw=;
        b=GwSsVDnS4xYQn7mig9Lye7LGhHzVxNSyOCPrVyZF6wB68blCbsx6v1sbhaBEWKzvMf
         +ixz7MGb7MuQdbqHRRgGJBzVbNq2yey4cVFt/tsWBHA1DCd0FSNbiju/W4H5QX6sr2IJ
         ZJ1gcB7H5ObWuimGB6jcod14s7MnXc4rG9rSZtlIwSf6ebOiz+QnNkfTammeno+QcxLM
         MIr1zqBLlNzhG4iubT4NTISp0UhXzU1ULCJ2aT4HuL+x1Rk0ErWgHtfy95Agixdkv5Ad
         /mQZLWDL8pQEKr3jWJihbRdvarZ1qNNK7yEtSd0MGcheTGedQxAQ53Z6deZjlSB7foyv
         Wa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483131; x=1745087931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvqb0KMQk6u+lJxNrDAty2Q7xf8HSHBvDR79iDfIorw=;
        b=HrU9/IpL6Wz56IVwlyX4xQU19lteOn0s1Wu/L5jKQtmR8y/txNtrEy7MnuB44Cs9p9
         TfnHbmNHiyVnWIT2FeWoe7PMmj4JYuFZpnqyIUAtnh0p9nqXXJI4Nh9JIpcK5Ps0B4ig
         dqD3akhT6IkxfxpY1Iv3n/3Ol/jhJWxKRDadLq2uxdu2WayL3t+VJs2QluaGd6gKtHCp
         0l4VdQbMSgc6j8cdWMjVSVx0Bx250JTfltyFYXfLpplbPZj1saBApLTnlBIwDfh/IDO8
         Jbs7wQuxI7cWCdubclb6WNUK8S6APFTBXsRa1Fy4aAan9p7LmojRyACevP0HaoexNfKn
         k5lw==
X-Forwarded-Encrypted: i=1; AJvYcCVOfeSi6mAdmosWtI/oSYv6Wd0EKWQxi5WHRseylk00zIkwAfd83KT70fDD26ZkAlp+hJAqX1kc@vger.kernel.org, AJvYcCXBD6BkWgCQE+mQtTCwBgkaq4tGK4kD40E3yXALAWPt6nLHnK08TNElGJkjV0h7Vi0JRcS1DC6sep+1@vger.kernel.org, AJvYcCXHYtgQX/mvK/0CdeBVfSqYy4/j/TLEUwMm/ovYAcgm/qHYTWtVV3V3xnP1btfEB0m0acmR8YZa@vger.kernel.org, AJvYcCXNjCgnsbaW61Ue3AgpRR8+EawE0aYet+3mOji8KekYU/K1q9+iI40PPcA+QQ1g2BsaptjOvp2iKRhfOaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXTi/jMgYS1PDr+2wiTMUeecmdtgKIvy9Kf80GvFkSSqPtQrU
	044INP9s1pSzLNULw4eV67/Q6A+IhuHPrq2dycYYiKNT0feSM8+K
X-Gm-Gg: ASbGncs/VLIjVWFBt899NPxgcY/LH5cdM1c+RfIwliPC74AvZbfTzJYU3pImX7lsZTj
	Up67tvkV08xQCVo+Kor/JJoBcECLz5h+b14PCmaX+63w3Bywxtd9g0VekpGZqHnguXcLn2Qdteu
	cmyQB5kD3VFNYSYAFQIh0rX5RrD4Ddd16BmSeJ+MN1RCTI20tN+oiuRria/Ez6zUkkaNBObyRS2
	qGTebcKKl3F19qKwhBNjCsS3dOY4TjdR2sLQqAOnV6zjBF2TdBMKbbJq6TUmcHLswUx/JD75LvG
	3D9xhHqHGMVJwdVnfTMWRU0VPVD6nVr9rcg8eW3/QbQnaSSODPhAg+0=
X-Google-Smtp-Source: AGHT+IEML3MWxiYWXhrvkSwTw5jVxeWZ37spCp+ourghAiC/n6v6Nrk1vNemPhLImYX0Oqyo/GpbHQ==
X-Received: by 2002:adf:b650:0:b0:399:6d26:7752 with SMTP id ffacd0b85a97d-39eaaed220dmr4425241f8f.38.1744483130917;
        Sat, 12 Apr 2025 11:38:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:f069:f1cb:5bbc:db26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm120599515e9.23.2025.04.12.11.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:38:50 -0700 (PDT)
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
Subject: [PATCH 4/5] net: ch9200: add missing error handling in ch9200_bind()
Date: Sat, 12 Apr 2025 19:38:28 +0100
Message-Id: <20250412183829.41342-5-qasdev00@gmail.com>
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

The ch9200_bind() function has no error handling for any
control_write() calls.

Fix this by checking if any control_write() call fails and 
propagate the error to the caller.

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index 4f1d2e9045a9..187bbfc991f5 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -338,12 +338,12 @@ static int get_mac_address(struct usbnet *dev, unsigned char *data)
 
 static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	int retval = 0;
+	int retval;
 	unsigned char data[2];
 	u8 addr[ETH_ALEN];
 
 	retval = usbnet_get_endpoints(dev, intf);
-	if (retval)
+	if (retval < 0)
 		return retval;
 
 	dev->mii.dev = dev->net;
@@ -361,32 +361,44 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 	data[1] = 0x0F;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0xA0;
 	data[1] = 0x90;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FIFO_DEPTH, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x30;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_PAUSE, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x17;
 	data[1] = 0xD8;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FLOW_CONTROL,
 			       data, 0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	/* Undocumented register */
 	data[0] = 0x01;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, 254, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x5F;
 	data[1] = 0x0D;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	retval = get_mac_address(dev, addr);
 	if (retval < 0)
@@ -394,7 +406,7 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	eth_hw_addr_set(dev->net, addr);
 
-	return retval;
+	return 0;
 }
 
 static const struct driver_info ch9200_info = {
-- 
2.39.5


