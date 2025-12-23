Return-Path: <stable+bounces-203272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DACD84BF
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 07:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A89E0300F303
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0273009F2;
	Tue, 23 Dec 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="0qdA4Jzd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAD2F39B9
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766472800; cv=none; b=GbnU0A7LWVI5krEp7Hikk1ImFRKQvcbj+zi7BV3a+fXPJKgnPZv/zbSOhE6oluKtz2RS11gSTLMO2R1uDvvAR7MQaCDkEjRPzLSu5wgOrq+RjlL9MJ8x7zyOHBUvVpN1PenHJ48+DXpniR7t/JCLP4RM30a+e8OyTxYADl2brwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766472800; c=relaxed/simple;
	bh=0Mqi7dBywdOuhuH+YUhkuktsUNLkUWukjoOq8PzZrdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BV1Tt5G/fNlkLHKg7DRxxU8Ho95dS1EwWmgx0BA08RGkbMXXY1o8jpSLJQ/SfVd1KQk5tMScWo/4Y0tr+kQqcbV/ZbnXQBCNz5ashFiRJYNFINxP7kutRexyzTYz9fOMVc4EaW++5ZtvsqcVzsrbh+wHTIsy7dkZWE8XzWW24IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=0qdA4Jzd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7e2762ad850so4943740b3a.3
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 22:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1766472798; x=1767077598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Omie+aIP/M9di46gB5qUKmryRAwukobUHm+cdMjFh30=;
        b=0qdA4Jzdc+fKSRdy9TJZObD43qatIQhLMCEbM45NgduJGfImP5MOwRAtJkghXEwsvU
         tTdGHQTKKBLjHwwLCCnsx7/OqQziim02gjeDQgI854S+jHJmZ+NXwSApqm+RY9chkl6d
         MH2g/Jqk93NrIPJmbuY47PilblKYf8epFS+sDuvswyXPkgZqQFGN8KSYbhi8y/q1Y3iw
         VhSIB4KccCmG2HXGVP6VlBtqbCgD/fIexHIK0RRIvhbVQ93NzPDD2eRnfSbuuLSboCA1
         dAGKGtGTQ7E3sjgPR4DqT/DwjChSF6WM97DpT+HlMuM/xGcGx9iRm7Vk/1gQaILtJViK
         xUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766472798; x=1767077598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Omie+aIP/M9di46gB5qUKmryRAwukobUHm+cdMjFh30=;
        b=UoflAmkk6nwwmyiVeHVCWgtYF0muTMZDt4oe076nfE4B23M7WP2MvDUOJOcXPrPXWd
         dKwpoSmLZwBRzIJNzq9bck444IO8nV23iFicFhLktSxpwxd9p5g76g8PyZ16JEJXPuDY
         54gzrZ5uuY4ER5IXAb55wMf19la0U70iw8otJ6bT3AnrJfRTlaHwU2zjUmeoWUgmqxKG
         gw69eLoMSSf3kdYMtdTLgKAW71/Vu5cNN+wZRwJiqB4CaFi8NpmAFpVsl+xmpRi0nk9C
         7PTmxuSQvr9iOCsvSmxeCqnpor2SdRn3dLPb5MgQlp+kfsvn3SF5IzpQ/q2uWG2KoyCu
         22og==
X-Forwarded-Encrypted: i=1; AJvYcCV4HZnt9xgInJ73QTTCRZqdV13cgxHlrPzgI0hDY/Sdxk7b4DrZRBdgEW/p9O/rdWWKioXDlDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDMRw/6fXTxPqMAjDFYBgUls4pc8xodkx+CApM20OkcgMJz2T
	4NxV+4/BlqCy4koEeLMlYOWPg1dEwDPlQPrp1fcMIPP6V5OMn2/sDPML2uJmImOdgZUkRO/cnbZ
	iNhhx
X-Gm-Gg: AY/fxX5EJHr3pFv7toqXlktfaJ/RRC7IwJpzn3DAMgfKbOLdds6AwXM7OBK3yVEM5WI
	bmaAruVGQVE+toOsyc7R1Cdz78jOMIMmP1KQ2y4YJ9Blic/f1EuIINT0L/o0OvdMtljOWAf+1Gv
	Exj/uN2St5JxNerA9pNoIjIe6JYxL8vcbnBsxE8K8fgYSWkTFuqrnEdJCCwtUB1MblrxZZLQG9P
	WLsCu3IJnjsFo96HKol3shJAefOrHI5QERCVEiDpUw3NHd82NwNmm++w8zfURf+7dztlLM7egaI
	+H0wqb1pzJbrUF/v6eM21Jcx0aAck9Ip6QtEZ0uXUsoQc/ySmkRDb+dJ8mWKZBaZDSDAk1y+WXV
	CRHbPQG1t7bMq7kdiAlyKJ8KnZOLVKbFGVFRA5Jt6I42tZegR4Hmbk14nZRvo7dL5pqYnHXfPSv
	0pYo/ZdBqOsm+1kiR2tUABvbks
X-Google-Smtp-Source: AGHT+IE9aDkJ4ZmTo42FTF2x3yvPVHXivvnWkrQMedEhpuyk1W6PnwRGT+VNRs55UHHmOHVjeO6dlQ==
X-Received: by 2002:a05:6a20:6a09:b0:371:d67d:e56a with SMTP id adf61e73a8af0-376a9ae2989mr13490259637.57.1766472797865;
        Mon, 22 Dec 2025 22:53:17 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm118295755ad.59.2025.12.22.22.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:53:17 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: linusw@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	brgl@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gpio: mpsse: fix reference leak in gpio_mpsse_probe() error paths
Date: Tue, 23 Dec 2025 12:23:05 +0530
Message-ID: <20251223065306.131008-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference obtained by calling usb_get_dev() is not released in the
gpio_mpsse_probe() error paths. Fix that by calling usb_put_dev().

Cc: stable@vger.kernel.org
Fixes: c46a74ff05c0 ("gpio: add support for FTDI's MPSSE as GPIO")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/gpio/gpio-mpsse.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index ace652ba4df1..b473db9c3c4d 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -596,24 +596,26 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 	priv->intf_id = interface->cur_altsetting->desc.bInterfaceNumber;
 
 	priv->id = ida_alloc(&gpio_mpsse_ida, GFP_KERNEL);
-	if (priv->id < 0)
-		return priv->id;
+	if (priv->id < 0) {
+		err = priv->id;
+		goto error;
+	}
 
 	err = devm_add_action_or_reset(dev, gpio_mpsse_ida_remove, priv);
 	if (err)
-		return err;
+		goto error;
 
 	err = devm_mutex_init(dev, &priv->io_mutex);
 	if (err)
-		return err;
+		goto error;
 
 	err = devm_mutex_init(dev, &priv->irq_mutex);
 	if (err)
-		return err;
+		goto error;
 
 	err = devm_mutex_init(dev, &priv->irq_race);
 	if (err)
-		return err;
+		goto error;
 
 	raw_spin_lock_init(&priv->irq_spin);
 
@@ -626,8 +628,10 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 					  id->idVendor, id->idProduct,
 					  priv->intf_id, priv->id,
 					  serial);
-	if (!priv->gpio.label)
-		return -ENOMEM;
+	if (!priv->gpio.label) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	priv->gpio.owner = THIS_MODULE;
 	priv->gpio.parent = interface->usb_dev;
@@ -657,12 +661,14 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 					&priv->bulk_in, &priv->bulk_out,
 					NULL, NULL);
 	if (err)
-		return err;
+		goto error;
 
 	priv->bulk_in_buf = devm_kmalloc(dev, usb_endpoint_maxp(priv->bulk_in),
 					 GFP_KERNEL);
-	if (!priv->bulk_in_buf)
-		return -ENOMEM;
+	if (!priv->bulk_in_buf) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	usb_set_intfdata(interface, priv);
 
@@ -673,7 +679,7 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 			      MODE_RESET, priv->intf_id + 1, NULL, 0,
 			      USB_CTRL_SET_TIMEOUT);
 	if (err)
-		return err;
+		goto error;
 
 	/* Enter MPSSE mode */
 	err = usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
@@ -682,7 +688,7 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 			      MODE_MPSSE, priv->intf_id + 1, NULL, 0,
 			      USB_CTRL_SET_TIMEOUT);
 	if (err)
-		return err;
+		goto error;
 
 	gpio_irq_chip_set_chip(&priv->gpio.irq, &gpio_mpsse_irq_chip);
 
@@ -695,9 +701,12 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 
 	err = devm_gpiochip_add_data(dev, &priv->gpio, priv);
 	if (err)
-		return err;
+		goto error;
 
 	return 0;
+error:
+	usb_put_dev(priv->udev);
+	return err;
 }
 
 static void gpio_mpsse_disconnect(struct usb_interface *intf)
-- 
2.43.0


