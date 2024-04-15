Return-Path: <stable+bounces-39533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65288A5313
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617A31F22822
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169CA76C76;
	Mon, 15 Apr 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+ifGiXp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099D76046;
	Mon, 15 Apr 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191057; cv=none; b=FqxXZO3T/4AcLot9S05+SqNHlKhTwl9w05HHWb1R26WCzejZMXb08XIxQxMoevGc8qftW1kBxwQQSuglZnnq07w6zVGo1dZMoT5Ff9e8ic2CuubjdjwsFQ83S6TT0sHPYjy5fgAiWZkdPelxnc3IIO0xfCqMjQ9Eb0pkHSoY62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191057; c=relaxed/simple;
	bh=zADvG59klfrp3cGSIQm2FPnmTssHRT5Vs9SewETtI2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=guQBTBVjRvjt6Iu0JD2yW1CLPE6syl1igCYz5/1th01OgnRtSn5buZMiwG6E4s9IBMYfhFHTP/W9XoEnwk34NpTfISwCR9Kcl4wryecpPBT6VkOyXoyJoJWRAIZVaadk+3a7oD1Sw2IL78wLUOUaMuHh1eXH3bTBzdkXQ03F8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+ifGiXp; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5acb737b508so288915eaf.0;
        Mon, 15 Apr 2024 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713191055; x=1713795855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYJRn17VfvdXQm/cdUplbrdfiV69VkeoD82gcqz7jGo=;
        b=V+ifGiXpjLbwz3LkYB4ugHGIHgJLu2xCyLY/LIYxa/9Buf1dlNgQD9WadZFzFUXR/B
         99frYQw6EqNnpkby9sZHMfjans5TETw8lqG1SEnK0KVnF2BWoBXhL2WoIAoluV/iP4V5
         loWXyX35OPJNmsXy3hw7dBaMXXjQeZzxO9TlonXSc3Clj4i8eVsY7CF4deVV6spP4uu+
         0y2xf+1Id97wKMbl1Ee1eQbj6eNNbbXCfxasFEzotPcK8tjiWe52P5jSBILoD6u3tYfz
         U0wm2C7gsM2tFGDfBNGeV+EHWxFlx0FgvZapVc1vvbiQgdzoi1wXFU64raB6XdD9Nv1k
         FMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191055; x=1713795855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYJRn17VfvdXQm/cdUplbrdfiV69VkeoD82gcqz7jGo=;
        b=QUwy6Hx0S9KZObwEFh/OYSghDmi5BZvF5mKq419U2kFWWihw93RGJXJjDg7AjD0I65
         BMC0tQ4H/Vrzl46KMCHNlQb2q4QEXziZ3Mn6sqEY1YIwUSeDHWPOk2bjkJ2KjtsNo/aX
         qWUl9yoLpa1bA83UFfJ0xR3eckfxRVHJcvQafzAqreWsNPGmUv3xD0wh4+kf1B4pUMwJ
         TOzTYi/lNfI3YLW/q+iMXAkURUjmgY7J4TKL8a4KwH3og4dAU5t4x1ohO1USE2Eyf48K
         2CRqw6nJWlhrOCflMwsMhrkSpRQOaCOv9NmfpkJLd2bHT+9goknwueG93c32LoTwm/Un
         G5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUVxADisHwQem1v8HyAwUtAdQ3iIthh0AIKLC3/fPixNQr26hVBgamZaXpiZ43hm7eww/vtRBCI6LexTdk7tlFZWMJX/s4mowp4d1UKC1vKTre/ZtKQr/mXTB+gSARn
X-Gm-Message-State: AOJu0YzsAGw0pv80UFzpXGgYH9+hcMi06rebRK7Fva8qc1lp34MjqxVW
	Luv5hdZ1F0wcOx+3COk1I0UUIyPDXif2YTptStE7hkbFdW3MLWael5bVW4VUOvXE1w==
X-Google-Smtp-Source: AGHT+IF7KmqTdI563Kt82HQ0/HY/h0WtGBGuUGdLeaBGKqJNAH1kdpUy2yrBqmShs9z9WULibiwyIg==
X-Received: by 2002:a05:6820:209:b0:5aa:5206:30aa with SMTP id bw9-20020a056820020900b005aa520630aamr11000195oob.7.1713191055161;
        Mon, 15 Apr 2024 07:24:15 -0700 (PDT)
Received: from localhost.localdomain ([2604:abc0:1234:22::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a4aab4b000000b005ac85267c13sm1141856oon.33.2024.04.15.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:24:14 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>,
	Lars Melin <larsm17@gmail.com>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2 v2] USB: serial: option: add Lonsung U8300/U9300 product
Date: Mon, 15 Apr 2024 07:23:42 -0700
Message-Id: <20240415142342.1753810-1-coiaprant@gmail.com>
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
0: ADB, 1: AT (Modem), 2: AT, 3: PPP (NDIS / Pipe), 4: QMI, 5: ADB

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


