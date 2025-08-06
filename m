Return-Path: <stable+bounces-166695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C8B1C59D
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76659188C947
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968626E16C;
	Wed,  6 Aug 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcOVTG3P"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3A241686;
	Wed,  6 Aug 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482173; cv=none; b=QIdi6t02D9keGIu1mfh2sBg3TPSSS8crgCmsud8wDU4FPsrR2bQmI6nnabT/+VNR63+yGy34ZfHlYZTod161/tkQZjdNZxemkxapDW0oryY+YbeLeKI49pM5xMElKm/x/iRqdFNtYbsOABzeW7nu08JeQPTUWXHFihOnZPj0Zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482173; c=relaxed/simple;
	bh=Op9LbOLKVbtPqmYL7m2V3UzzmYFcNgPQA8CroiBhgXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5vOA7eTBteu1pwDZT8RGjQQeTmiFsKG4LgOT99verRr1afOco0kl57Wfb7UiwHzg3b/dxUSD49HK91rhOk//mjuBd3dzxHq/NvANILlfwSFrsAKxEz9QwYMhLHPmpJJ6I3oaqaynf+DLi4mvzX2I+GJsaGWus45RBHTY2DXdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcOVTG3P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459d40d16bdso23639545e9.0;
        Wed, 06 Aug 2025 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754482169; x=1755086969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gj4cRs5IgB7NdFKvxqo2bYf9NaXPvZDKyYp8DsSdMXw=;
        b=dcOVTG3PX14xi8Go7MXXw7LU0yyjWQR6nOzGRlgf8b2JssDocvMexS6O0ihnfgl3vf
         q8ilJg3kicS6CABK8mKxidnKRl5MxTo8sZidsvP7GVVGFtwSnnGuANQjZCEVsvEB8y6a
         ctlanMhIXBAFRaMNbsLYMGWas8OPNAh87PX+yJgVqkfjYl6J9Ex9fjaN0ifQx0UzmuC+
         SLkDFaPSRYGgXJYj5ISuXnCaqeF/Yy0MVW0fCLTzO3Y9aF+K9MLBTntBs90edb2Sn3pa
         cdMdYS9nGsgxXQBHTCrpsveiqghCNN+topKyLVawSKBooUK9wtMcVQWS24m8Y1km7VvZ
         T1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754482169; x=1755086969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj4cRs5IgB7NdFKvxqo2bYf9NaXPvZDKyYp8DsSdMXw=;
        b=an8ed5CHJEiP3Z6GIMXcYL/mcaccEGz+NP2ar4kYa4kT2xrbotz7owpFncYigUk8di
         r9OXBwCfRB7mrpHRYqwvWwmwTFyAi1bmQHdi1xLwozxbX7yiKYOAlCElq0LuPMGBP22y
         yjl8dOPTOVv7b9CHpz2VsgAyS/jK3CiTupKzzbzvBwfO0vIUHVPWFjKssoekdgi9nKAy
         BnKgWqUWn09tYTwa0dglVuzorJp6PeEJSNSUtwD9LR5W53R97YepoONAg3klEHM5GnUf
         IaUmnys4xbFjQ3quEIw0GKEa9bUpMvjq4fOIo6Pj6+rJrfFfqrtH5KOul7jCulOFUwhV
         Nj9A==
X-Forwarded-Encrypted: i=1; AJvYcCVlOLOaAKpb3D2mbVNYHK8M4ehTCLmEmSwupU9E2RsXBEsnEWt8d4txsnutZC1dp7rnV30oiSq1RVQ=@vger.kernel.org, AJvYcCW+LcZbKJeMjBXt8aXCYVN7k9pdh6DXUCkJbmTbfNYX2Km4rdWvZ+Z2mxG2DH0rzvJeFRstAsDa@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmZezbxHCDmtWXawf5X1Q+7dVtwYUkcaUTA5I5mvVwamtNqAT
	SAgmxYZ3pILtvGYRPCS8hAm4Ro9YG3dEKCVwT0yx3zaAQD87KaazQjY3
X-Gm-Gg: ASbGncsB8ZxsODELvkcAHBnSeLeGhKDgAswJHrKWH1xEANa92kYLgv9p7ZwVTwqUH2d
	O4ySNC/Lnrb6Yc2Sb/3YMg33gao5Q3GtG1OQy5zMCsRVPa/L3wur6+0WcEaqYHMLMnDpZs98zPc
	fbKFCfIf3jD4A/3b7vJDmRndNqHpMDlMRWUdn0Qkt3mpjgC62OAxXgrc98Hg2l1fRSwyuftRLQ2
	gbj4Ryu+vOeow/Gmp3CoRDIPIaYQrJnCYz8w3CEMg5nIaLwB071IuUIiK/WVJpaDByrXmFEA3zK
	2IUtfGZYg1fEWXTbh7XFvJN3XEtiJQCzSStyLqymnVnzQ6EwcdnTNI20vGeHvTxC/cFpn/AoCQ+
	evpX+yxW97qQnDPeIjrLxwWDeYm1yzXKwHotLox3wu5+yM9nhylPwgQ==
X-Google-Smtp-Source: AGHT+IH8ouqRvFfotPN8et/z+HBGCkGs1B83Oc8nEGT9AMN5+DJA7UmnjCcFUx1m3NjmSWPA2n8CZA==
X-Received: by 2002:a05:600c:3503:b0:456:f9f:657 with SMTP id 5b1f17b1804b1-459e74720eemr19411115e9.27.1754482169112;
        Wed, 06 Aug 2025 05:09:29 -0700 (PDT)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc2647f6sm59299185e9.2.2025.08.06.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:09:28 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: option: add Telit Cinterion FN990A w/audio compositions
Date: Wed,  6 Aug 2025 14:09:26 +0200
Message-ID: <20250806120926.144800-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Telit Cinterion FN990A w/audio compositions:

0x1077: tty (diag) + adb + rmnet + audio + tty (AT/NMEA) + tty (AT) +
tty (AT) + tty (AT)
T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1077 Rev=05.04
S:  Manufacturer=Telit Wireless Solutions
S:  Product=FN990
S:  SerialNumber=67e04c35
C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=20 Driver=snd-usb-audio
I:  If#= 4 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=03(O) Atr=0d(Isoc) MxPS=  68 Ivl=1ms
I:  If#= 5 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=84(I) Atr=0d(Isoc) MxPS=  68 Ivl=1ms
I:  If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 7 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 8 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 9 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8c(I) Atr=03(Int.) MxPS=  10 Ivl=32ms

0x1078: tty (diag) + adb + MBIM + audio + tty (AT/NMEA) + tty (AT) +
tty (AT) + tty (AT)
T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=01 Dev#= 21 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1078 Rev=05.04
S:  Manufacturer=Telit Wireless Solutions
S:  Product=FN990
S:  SerialNumber=67e04c35
C:  #Ifs=11 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#=10 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8c(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=20 Driver=snd-usb-audio
I:  If#= 5 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
I:  If#= 6 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=84(I) Atr=0d(Isoc) MxPS=  68 Ivl=1ms
I:  If#= 7 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 8 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 9 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms

0x1079: RNDIS + tty (diag) + adb + audio + tty (AT/NMEA) + tty (AT) +
tty (AT) + tty (AT)
T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=01 Dev#= 23 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1079 Rev=05.04
S:  Manufacturer=Telit Wireless Solutions
S:  Product=FN990
S:  SerialNumber=67e04c35
C:  #Ifs=11 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#=10 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8c(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=20 Driver=snd-usb-audio
I:  If#= 5 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
I:  If#= 6 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=84(I) Atr=0d(Isoc) MxPS=  68 Ivl=1ms
I:  If#= 7 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 8 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 9 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index e5cd33093423..1f4da8120111 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1369,6 +1369,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1077, 0xff),	/* Telit FN990A (rmnet + audio) */
+	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1078, 0xff),	/* Telit FN990A (MBIM + audio) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1079, 0xff),	/* Telit FN990A (RNDIS + audio) */
+	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990A (MBIM) */
-- 
2.50.1


