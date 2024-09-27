Return-Path: <stable+bounces-78106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6873798851A
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AECD1C202ED
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A04918A6BB;
	Fri, 27 Sep 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfcOevUe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA63C3C;
	Fri, 27 Sep 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440448; cv=none; b=fQKzXxL1W6nRiNNTLQy3sPazwkdG2fOBPNJE0XRjLT6kC5uV4BCW//37dQmjiejl9qED9wgakZJdk1aCFSzYBNYP6WrKq8n5b4/cF9GIgSXbmIx7ORZB6nydqu52kw3RgTlXsJDHKbSkZ6zi0TjhTdih8GAvSN2ZS/pvZo5AtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440448; c=relaxed/simple;
	bh=y2+iNA2lOOacXErWskhZ/dVv2cX2grJVPD4gDrjCuIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6bF27X1MRShXzq9jMVh4dddP8YVPcNtIjvL28Qv37vA3U5W50GAs0wD6mYrr9K8qW0g7HBh24/kEMhpZWabBks0ddrKLnKVOPUfoBjDVj4CCCJnGoPQJQOKI86wJwmArVW7znMRu+dlISMbF0deAoulQ7rMXAg4xhGNv9U78aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfcOevUe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso13350575e9.0;
        Fri, 27 Sep 2024 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727440445; x=1728045245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=evjj42qW7BNFDPe1+RqgY/x7L3058jeNFIesKHV3B1M=;
        b=dfcOevUewbU/P+aB2FeawqgY2weTn+YUYtb8YvNxE7ZTdStalbrNJDYQ5YVNm9Oo6g
         0nUVEUc3uGt2C1nVhHgFVRiQOOEsxJIgSlKpIXYQv3T5iYsZG0jdeasKnCVZcUqw06Rq
         VH5Kwr48fNI3yeo4NjQjkSGMhZc96DKrUKnzQwQFuu4wFEdsp2gf4L/04sfeEeeUtyAt
         3tH5ti++QKUQnqXJkOhnGxx0JvnSgUGscANBH+1YZrzP+Vadm/+KYZFCWkzcx/n3Xf/v
         +/MJdVQ27RDcUdyMpM7rptkJb4POIjGAIl0KQbdBEMI02Y3PBSKAjb6OvPi36iDwLm8F
         7qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727440445; x=1728045245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evjj42qW7BNFDPe1+RqgY/x7L3058jeNFIesKHV3B1M=;
        b=jFXDJ9U3AzW47j5MBTP8EIaW30blUZPrT2O/wd22vYSQYRhbR6zm9fSiqF57BWtU2e
         OSNXXE3zxmm/G5z10yohOt5EDWJd4GIo/B442Z6j0Ku9OrtBeqi8KsPvO15IlUWgKjdV
         6hfN0HvUZSYdGKtAsHZHlDANSbDRhEj7SXrOI3ItgAOz9AIbK6J2FZ8yGMaQeRV9H+Md
         N1moWLegVrhz1pzKQKkqroWTEU05uHPu5fI9Eto0Fao532GwcEK8lvwCIu2wMjibmQC+
         zPdT4JgxYPDhcuDHP4qrzfaxlS3QjKyjAkRx0DxmpPT8YE2EsOTs54UX4YPi1x6IW6qU
         +IAA==
X-Forwarded-Encrypted: i=1; AJvYcCV6BnbGm+Dcu5Ln9GRidvlRvoQx9QgPnMgHJBFCp51QFcnBp2DDzySaXnTAA4Zg7wL5fn2jRR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mR61puoVo1ZIpylTlWz4LDn3qimG5k4iYXP2UiaSSBnB82PK
	dXM27KUVtoOjAgo88qKzFXJgaGay0SVrADjrx0D4a4XbHE3mJHc2USqJ7A==
X-Google-Smtp-Source: AGHT+IHhRNlzlXso40rovMU1RzZD+DZQwus7OixqfK79YLqIQVA3/MCZDLjqV5F3Y8YpHeaQxeaVlA==
X-Received: by 2002:a05:600c:5252:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42f521ce279mr41196315e9.6.1727440445154;
        Fri, 27 Sep 2024 05:34:05 -0700 (PDT)
Received: from ThinkStation-P340.tmt.telital.com ([2a01:7d0:4800:7:51bd:682:aaba:6770])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e3008bsm25447475e9.43.2024.09.27.05.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 05:34:04 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 1/1] USB: serial: option: add Telit FN920C04 MBIM compositions
Date: Fri, 27 Sep 2024 14:28:16 +0200
Message-Id: <20240927122816.1436915-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Telit FN920C04 compositions:

0x10a2: MBIM + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 17 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a2 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=92c4c4d8
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10a7: MBIM + tty (AT) + tty (AT) + tty (diag)
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 18 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a7 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=92c4c4d8
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10aa: MBIM + tty (AT) + tty (diag) + DPL (data packet logging) + adb
T:  Bus=03 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 15 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10aa Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=92c4c4d8
C:  #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 176f38750ad5..6dcb73586e0b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1380,10 +1380,16 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a9, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
+	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
-- 
2.37.1


