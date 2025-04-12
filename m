Return-Path: <stable+bounces-132324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2E0A86EE7
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 20:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AF68C0147
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C921C19A;
	Sat, 12 Apr 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB6r2lBL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E5222565;
	Sat, 12 Apr 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483132; cv=none; b=B5x38aY90L3s1OUTAi/RXIOxTtj0U6BcBUTCDem/wOyR8i5ZTpuno/XwHuz77vDYklVoUqRQUtgBKyY5p5F7UDkM3ZT5RTPpvZ4yysU18XO6l1t/uXCgvdbO9UZ7fFXMYO6XRUaQ6qddNnM1DzY+RoqlkEd3SIyzGitPBWSv44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483132; c=relaxed/simple;
	bh=pbWG1NuW44d0XHkj7KB2doeEqkX9NqKKFm40CfzHlJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Er5hz/poeQ3AmdP+J5M2kAwg6qbwY90ftao6DdXqkOzrAhMiLSBvrOMkAKlO+ycMEE0gsl/ofFQqi6QZXcLg8vkfQn7qowoldMvBfuO0XOwEDHskYCHceQynuCXFp25KGbdMm5eMnUUCR3WYxg0Vq5Y9xJsTBOdLZ5wixhnCNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB6r2lBL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so26038745e9.3;
        Sat, 12 Apr 2025 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483129; x=1745087929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM5uFKAHI/bfbAV4bgQOJ/dtNzxx2KflwSSXyFhKQ54=;
        b=YB6r2lBLu57irImszoHJ8FINaVvHFgl6mubyam8p516v3YuEl510eW51VZgJ0iMbIJ
         Gu/lMJqwZIF+9k+bxMa85OQIppehf1oin5AoTDzqDwF6pW9R320X9QoKFSKTLfWmC9TJ
         Q3EAugimXCuPcqrP96JK3O5soTFpvf93K9yHhZ6KYXROteZnlTRexlphJBfSVA77wOuH
         sYWEHFYaHyT6t5QfdR5I60pwTrE7XlmS149PpdUpzbwUN4GAWdzpS/iSld5K4jab+iqT
         KfNY60i0/udkUgNz7aJugsfLAbSvSW822H/wPV+JGnotIwjEh9vpmr0bJlkxzpnMXTs0
         10rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483129; x=1745087929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM5uFKAHI/bfbAV4bgQOJ/dtNzxx2KflwSSXyFhKQ54=;
        b=Eixr08aS0Fnau29myT2aPM/OUVexSngsk/3pL0zJ7upJHghowoATNk5cEmeQiUt2Ic
         KTSqHcdGGjsX0ckREXi7DJHgXBL4aahsK+sMqO2xxftdMw1hgyiqV5PQVFopvowbT5LI
         fssydtgUhA431og8y6F7MWKF4CNspt8KETbHxKyLfGax9wEJa+zqVx48DYr3/GfhcBB/
         uIjKb9IO1y8wjdZu1kxwhrKFGfcWNzIGCSgc6K+WUXFpLUkkbZPQqCDTnNpB8+53qlRj
         z/zQZL0Raz4WH53/4sutowmJOrbpi8bm39QKfeSCgXZKc2NH2CYzARCdZ4KdLhOnMnk6
         6Vhg==
X-Forwarded-Encrypted: i=1; AJvYcCV4lmNTY470RppjFZk62rXK661qHoZp1stN6mljdqEjB00SNz8Rx8kW+7eMznv8YPCfeibSMgEf@vger.kernel.org, AJvYcCVMhSLq6HtoRZeGNe31mg4macrgNaf/v9Kc38NICH9U8ABIjd9/G7slZnzqbEwJxOVI/Qe4Iwmo@vger.kernel.org, AJvYcCWv3tfR/1JjFWPMLJ/MBRL/TDuYNSKj5Pf1pWc16EqW1MMvWSww7T+P0VSC/ZWei+NHSXkhgKAlAztmGIc=@vger.kernel.org, AJvYcCXFXtaPLbgdM5+1EBtlU7TkZ8Yu6+lPJpJ9vZmwF3nD4TroRXJqWvDAq7gXnYWDcySej55uPUcuj4GH@vger.kernel.org
X-Gm-Message-State: AOJu0YyRpH+Y9YQxfr3w0/0VM91jaSF+iFfoqvx++U8zUimfqw6MxRN5
	aXy94lTEA9kooBJ/qmYztOrsts0Of11AjuMCkLocFtvEgyuacg1/
X-Gm-Gg: ASbGnctg7Pr3sVOQDbMKl3qfb/8TVdMO8yeBM9u+2lvvO+/5PKISte7rlLdn92R2AKG
	TfmM/ktLJ7svuI27UNjZmdl/HNSpIbOV/65pMJxdNvYeoWHRFP52kfy++rCOkrSxgKNH6ic7Y1e
	kW483aQgIpT2cm3MhIY9WusMkSSlc1FUNpEW4ecvEHGugnWwVr9A08gJ/zVRKrnQq0pbywILO8i
	39L0q2MlH7zgPMmcVuT2dyhUqglxO/uF215iCxPgno1jzRAR4+oKFC8p/0xzZvqumZVHm3dui7m
	aqXGDveY1x92R2P7M6UJ4vpzi4kVJ3qOrIdJ+5HxVwAhvACZ7AK8KC8=
X-Google-Smtp-Source: AGHT+IGOjRMbGNcVSyofzN/ItKV09dIC/2nWWi/KZ+1aoX3auTz02NmOy7o6NMmHWYvVaCx0vDG3zQ==
X-Received: by 2002:a05:600c:154d:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-43f3a9aee78mr48790995e9.29.1744483128872;
        Sat, 12 Apr 2025 11:38:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:f069:f1cb:5bbc:db26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm120599515e9.23.2025.04.12.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:38:48 -0700 (PDT)
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
Subject: [PATCH 3/5] net: ch9200: fail fast on control_read() failures during get_mac_address()
Date: Sat, 12 Apr 2025 19:38:27 +0100
Message-Id: <20250412183829.41342-4-qasdev00@gmail.com>
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

The get_mac_address() function has an issue where it does not
directly check the return value of each control_read(), instead
it sums up the return values and checks them all at the end
which means if any call to control_read() fails the function just
continues on.

Handle this by validating the return value of each call and fail fast
and early instead of continuing.

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index 61eb6c207eb1..4f1d2e9045a9 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -304,24 +304,27 @@ static int ch9200_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
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
+	if (rd_mac_len < 0)
+		return rd_mac_len;
+
+	rd_mac_len = control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_M,
+				  mac_addr + 2, 0x02, CONTROL_TIMEOUT_MS);
+	if (rd_mac_len < 0)
+		return rd_mac_len;
+
+	rd_mac_len = control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_H,
+				  mac_addr + 4, 0x02, CONTROL_TIMEOUT_MS);
+	if (rd_mac_len < 0)
+		return rd_mac_len;
 
 	data[0] = mac_addr[5];
 	data[1] = mac_addr[4];
@@ -330,7 +333,7 @@ static int get_mac_address(struct usbnet *dev, unsigned char *data)
 	data[4] = mac_addr[1];
 	data[5] = mac_addr[0];
 
-	return err;
+	return 0;
 }
 
 static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
@@ -386,6 +389,9 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 			       CONTROL_TIMEOUT_MS);
 
 	retval = get_mac_address(dev, addr);
+	if (retval < 0)
+		return retval;
+
 	eth_hw_addr_set(dev->net, addr);
 
 	return retval;
-- 
2.39.5


