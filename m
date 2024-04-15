Return-Path: <stable+bounces-39582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB7F8A5363
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7B21C20DCF
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5378C6F;
	Mon, 15 Apr 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkylFsFV"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4274BE1;
	Mon, 15 Apr 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191197; cv=none; b=cuvsob5g/AJlB0tWoPXN+f6MqpgE0gST3q6ogT2ZTq0IS8qelow6ZZvcIl+iiYc4OfXLnP/3bc3LK8ObIqFjKUw2/+wC/or7Y8hXd28i4M/UYMW7b+tiWF2YIW40ab42MZvAu7qDG2atz0Njj2MWKIi2EWDL7E3TG9s355fRuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191197; c=relaxed/simple;
	bh=NNIshefLpmbBfseg7oNz1AWThCB1avrXRm+qLOzxsHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0ESzKrzA7M+QKcKt/GS9VS/uRjMqUHnF9VTrs6wFmIF8H1RI1gsuGPP1hwZi5gp2ZiyUryW+Btaw8btGrOwkz8pN0vIiN6VK/YbKy1At2beawSKnMpSxz2zD4Q7v3KNpAQYmwgqiR2+pXWF6CFYjWXWMDL9I06EqXJ4vSn+DDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkylFsFV; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-5a9d93ed063so1305063eaf.0;
        Mon, 15 Apr 2024 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713191194; x=1713795994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUXvNH+A1dYlL51PDLi10PMnSW30uLSu7HDtJ4JEVEg=;
        b=mkylFsFVBjTeSh65akikDJRRp/rwc8LmqyS5+r6YFY4NKSTAEx/2A5UDH4xPwSzNfG
         CMEH2VtvFctVqCA6WKwwIoM7dSBmXc1JYIG4o4IT8N30p9N+hE8QsAIU0JOq1ZB25Mxi
         XnUYjJk4X0hjrGBCU3xH42xh3BfM0foajhkSFdt/7xqV7KBcFdshkjO3+WxPrkZ3kDGL
         Bff3w1zYt00SNbvJNyJsG2SvDl4L1kIVtZvtRbbBdT9A4alrCSqXb95uZCch6nbpHi0b
         hc2ow7i799YdtkgMPee/YAioZ6ZoU3FjLmLpcmh4aQQgSVqWwsIvbk7X9zbh/vbP5I+C
         iBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191194; x=1713795994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUXvNH+A1dYlL51PDLi10PMnSW30uLSu7HDtJ4JEVEg=;
        b=GGQWDH23aejUOFI6tJ0O/T5xwX8JcjWwUg0z6cy6hZ0ARsqwhuDas3VYKwqoTnIQl1
         IOnOHtFH9BCRrEvprFtZ/buIjNW9hzFog0P1iV6GrMTH+071SMtSsHMa54Cus/LcAwj9
         Nr3eJN7ZVyyWNqadhd1yjxFxKLIWHJCt+5vCoR67tI9ddF8Gvgfo0a68qn8TRvBUJ71O
         PJhV7gl5ErbhGpz4xYxkjBTJPEYguJzLUHkWD/MGZYmfVO5FxX9Z87bSUQiT0fJApWjm
         iJGcZn4t+qsHKCHb73tOB1KPHT7nW4B2bHPZ36x4Ee3roj2QDBNs9ypTUS+/GNaNy1es
         x0HA==
X-Forwarded-Encrypted: i=1; AJvYcCWnxtn9spVYXdNGzMts0c+oumJPGVZ/lLKqTh4ysEGe1W2K1Gy0L4are3S7/iXfZuaIR40N2jp6NrFnGJ5hq0eWFuAS7D/9Zby9oQsmuZ0Z0VvhuLR5kij4VTxF+ZDX
X-Gm-Message-State: AOJu0YxMTIH9daSJ/mahGHwklgL6/IMDRSUvaHCQ2BlWUSRpNihE4Slg
	oWmxC73sclj35Lv/pkRZ1+O/0IPHOEJQDtPGwgybbtMFxk9QBgkr89ytCq2Z9UYLrg==
X-Google-Smtp-Source: AGHT+IGrxJ7QnpQtzt4t8mt6YQlLM5PesGNv4tvZzGsa279Up7Z2o9O+NpbIRrxFqgWt8JdEI9ljew==
X-Received: by 2002:a4a:8c68:0:b0:5ac:9e53:1efc with SMTP id v37-20020a4a8c68000000b005ac9e531efcmr1298126ooj.0.1713191194537;
        Mon, 15 Apr 2024 07:26:34 -0700 (PDT)
Received: from localhost.localdomain ([2604:abc0:1234:22::2])
        by smtp.gmail.com with ESMTPSA id bv19-20020a0568201b1300b005a9c7753d84sm2105770oob.31.2024.04.15.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:26:34 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>,
	Lars Melin <larsm17@gmail.com>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2 v3] USB: serial: option: add Lonsung U8300/U9300 product
Date: Mon, 15 Apr 2024 07:26:25 -0700
Message-Id: <20240415142625.1756740-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the USB serial option driver to support Longsung U8300/U9300.

For U8300

Interface 4 is used by for QMI interface in stock firmware of U8300, the
router which uses U8300 modem. Free the interface up, to rebind it to
qmi_wwan driver.
Interface 5 is used by for ADB interface in stock firmware of U8300, the
router which uses U8300 modem. Free the interface up.
The proper configuration is:

Interface mapping is:
0: unknown (Debug), 1: AT (Modem), 2: AT, 3: PPP (NDIS / Pipe), 4: QMI, 5: ADB

T:  Bus=05 Lev=01 Prnt=03 Port=02 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1c9e ProdID=9b05 Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
C:  #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

For U9300

Interface 1 is used by for ADB interface in stock firmware of U9300, the
router which uses U9300 modem. Free the interface up.
Interface 4 is used by for QMI interface in stock firmware of U9300, the
router which uses U9300 modem. Free the interface up, to rebind it to
qmi_wwan driver.
The proper configuration is:

Interface mapping is:
0: ADB, 1: AT (Modem), 2: AT, 3: PPP (NDIS / Pipe), 4: QMI

Note: Interface 3 of some models of the U9300 series can send AT commands.

T:  Bus=05 Lev=01 Prnt=05 Port=04 Cnt=01 Dev#=  6 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1c9e ProdID=9b3c Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
C:  #Ifs= 5 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms

Tested successfully using Modem Manager on U9300.
Tested successfully AT commands using If=1, If=2 and If=3 on U9300.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
Reviewed-by: Lars Melin <larsm17@gmail.com>
Cc: stable@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/usb/serial/option.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 55a65d941ccb..27a116901459 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -412,6 +412,10 @@ static void option_instat_callback(struct urb *urb);
  */
 #define LONGCHEER_VENDOR_ID			0x1c9e
 
+/* Longsung products */
+#define LONGSUNG_U8300_PRODUCT_ID		0x9b05
+#define LONGSUNG_U9300_PRODUCT_ID		0x9b3c
+
 /* 4G Systems products */
 /* This one was sold as the VW and Skoda "Carstick LTE" */
 #define FOUR_G_SYSTEMS_PRODUCT_CARSTICK_LTE	0x7605
@@ -2054,6 +2058,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, ZOOM_PRODUCT_4597) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, IBALL_3_5G_CONNECT) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U8300_PRODUCT_ID),
+	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U9300_PRODUCT_ID),
+	  .driver_info = RSVD(0) | RSVD(4) },
 	{ USB_DEVICE(HAIER_VENDOR_ID, HAIER_PRODUCT_CE100) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(HAIER_VENDOR_ID, HAIER_PRODUCT_CE81B, 0xff, 0xff, 0xff) },
 	/* Pirelli  */
-- 
2.39.2


