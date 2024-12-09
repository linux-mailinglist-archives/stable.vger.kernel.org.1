Return-Path: <stable+bounces-100219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F7E9E9ABA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93882286318
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068921C5CBD;
	Mon,  9 Dec 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvhGiT1z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FE61C5CBB;
	Mon,  9 Dec 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758828; cv=none; b=aSw8UYlcf1ikrPTexr48x+YN6xt06n1FJbuiFtHAIIXknWsdBQbmc4LthD3DipjrlXhD72nIxa8keq0lzXsfeBXjjGOTjdXVsiPhw5c1gmiF8Z5GKOSSkdx8vzorJrMjmXXzYhu0jAKuGUvfGqVfL3b6p7BkjFuVa8oHosHtq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758828; c=relaxed/simple;
	bh=v0qmFEPQJoqN571WZDmp772EQOLt21vXcTNq6l9K+Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LV7WQZV9fWxbdDCIp3r5tjgERZ5kNyN5nJ3JIy868b6/MHnuxmT3JHKnJwWxWm3WZ7NsdYMrTzfnsRKDadxvLZ/ne7zN04CohpBTvET1hPHkYiuSpl62SLHkpvtnFHomilkSTRcK+/ls2ufF9fikkDBBZyzYGbFhiJ63uErhPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvhGiT1z; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385d7f19f20so2029400f8f.1;
        Mon, 09 Dec 2024 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733758825; x=1734363625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THIVVsv4gFsQRzLTlgrKEIh5i75y63FKBQRh6bZVeLo=;
        b=CvhGiT1zWN8PXImjxswwYJOxGvc/0j+pM5H0ehzvQJq36HuRCXfWBTG1mVllo1k1Jz
         WOuQxtBSJtb59iFbbhQY1IijqIvlr+oOtTo7hwK87Nw1Zz2ic4+RZ66Jrn1A6s4AiGr9
         Zm6bCxatCtOs/B4nNt4NzZfIXb1WPHk+1ti/WSVucxE4EbmQ7Nt6e644BFpy1FN+wq7X
         HYv1ft8UXCZYK4plENMfHRf3AY1bjV0tnYJQqwhUDJhrDPFf1svCzlGEOoi4gLiSMMKS
         u2YOpMSSJFoEaAlz0rJrrTq1PTlAUdD0VRWiIWV8AZzYkLfWNU8/CZ+Xy6cEgRs31VzM
         q+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758825; x=1734363625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THIVVsv4gFsQRzLTlgrKEIh5i75y63FKBQRh6bZVeLo=;
        b=Hfehq1iYknvMOfTM1Lxj8gl4/SlE0oMs59Y/YLKBkM8sA1A83RIcyslL/bWBo4hou5
         xSQBhEfZ0hv2jIGJPNKGzPq+Y8mmL20Ms8a7AnnnUfXTb+XHzR48THLfqqgzV+KLyvtb
         Fz2thEZ59K568WJ700cIEmggY+e2bsuh5t/naYCOKcx6PqqCSGYfb9slIO067ilRGIc2
         TZdQVVDLaJfZMr0+F5AIATmcnsaDnh/++5cVmAqid+7ROpVYRKhZdX+jQ8HGOa8w8GLI
         IF+JcgHy8GbOrLBkJhWAcXtRc/wdZ9YpIY52+t9z3+82uX3R0P7XX8xTsVbLVEVfCtYB
         uKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkWClbihwdq0MS2A+tjfm2ybXzXZHX4hJhlSoGI5OLCKuHhGCqnhRvvevlypbrkSO02K/zBEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ksBuGi5gOnvoAhnyv+xCbDakLIh5gMpjBRld3xE4tAPoSn4J
	ZpUGxkYCmlZ5wFiNC1CE/Un+cSMaB6LQiYmFX3CLFzZOVZ1ZJNeY
X-Gm-Gg: ASbGnctzjIZ7iqb4x05Cp2nJFzRzoCG8OSUWyLdLx5CAFupS3c7MhvuXKKbm0ef4xJy
	Q2y4v6IF3PoyCsma6+1FmJuDGMKaRvyEXKgMY+eicnk36ZlayBVHACaP317FnUkh6kK5oj3Iuzt
	2GYk4gn5jOHlK+ilDHlZzSOFP/P0H67h6zroO6PQ7R6iLcz6WEh/8agDJAv51yTF6UbTjL8ScH9
	CJB3byOed3EXo/MLIAzULmrlzBp5VIsc4qL/V3JcSCjvT/GyDuYvHwC3LIq9SYd2UCSzC4fBw==
X-Google-Smtp-Source: AGHT+IFeayK/zc/dX5+/EUAGweidzTVymFAGnSR21oou+WeC63FyU+XpjumNNG6kz1KYSnELvXtxWA==
X-Received: by 2002:a5d:47a1:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-3862b38ee31mr9965731f8f.32.1733758824993;
        Mon, 09 Dec 2024 07:40:24 -0800 (PST)
Received: from ThinkStation-P340.tmt.telital.com ([2a01:7d0:4800:7:664c:aec9:433c:7b34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cd35sm13249681f8f.31.2024.12.09.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:40:24 -0800 (PST)
From: Daniele Palmas <dnlplm@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 1/1] USB: serial: option: add Telit FE910C04 rmnet compositions
Date: Mon,  9 Dec 2024 16:32:54 +0100
Message-Id: <20241209153254.3691495-1-dnlplm@gmail.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Telit FE910C04 compositions:

0x10c0: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 13 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c0 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c4: rmnet + tty (AT) + tty (AT) + tty (diag)
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 14 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c4 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x10c8: rmnet + tty (AT) + tty (diag) + DPL (data packet logging) + adb
T:  Bus=02 Lev=01 Prnt=03 Port=06 Cnt=01 Dev#= 17 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c8 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 9ba5584061c8..5680bd155a94 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1395,6 +1395,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
-- 
2.37.1


