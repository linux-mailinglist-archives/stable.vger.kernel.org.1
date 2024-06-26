Return-Path: <stable+bounces-55848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019EB9182F0
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3436D1C2241E
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57C1836E7;
	Wed, 26 Jun 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="KGNsPbGF"
X-Original-To: stable@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED41836E8;
	Wed, 26 Jun 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409507; cv=none; b=r73GdbPJ8a7NeB0u6lorGJpgFDC7KUj4GawldkKwtYuVwcdMZg9HUE97sWFni4liJ9Xh18GMCcbaJ9M7iRdiffd2h8yA7/0Of+bMxn20AVjN9bgzA4JZ8tKWEjhwuiF4Q0qiEamGwRej7T32B3Nd+K44CEtuorTyLSNDGeK9waA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409507; c=relaxed/simple;
	bh=mAVRzzjl2ml2u8Gmy2oB6sT+YlAVVokF49bVXnJUqi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BM7ubBFnw09LuLpPygcrYq+feUACOVyq4x0nkLtuXDalbRHcAlerzIjtwHEb5bMmT1diN7ACYxtD9kzC0qhn78yIAIg23tc16VZMNVVs/bBWmPA768e0kGU1WYGm1rDvJBqQwJB9P4LfWYaUqJhJqdKD4SNBWxc2UDnIC+Iz+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=KGNsPbGF; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 45QDWY7F785538
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 14:32:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1719408754; bh=kx9LHtWevguXGUlSVbRkqpwgE6B/HVVWlJYSESFJwrA=;
	h=From:To:Cc:Subject:Date:Message-Id:From;
	b=KGNsPbGFmIs6ninv526omMMespR1WgnKV4dKhVF8mudTO/qTMeNSTOkahKOcGBVDn
	 LZSpFZQYYu1i7UyUM8dZCollOTWL2wW5tfyX9WBF/Vsz7jLgGXaM6UVd2jDcDnwfMO
	 Pm87OB2yUaCO/NMNscGrxG3WrhF0a3OqMrtPUwGg=
Received: from miraculix.mork.no ([IPv6:2a01:799:964:4b0a:9af7:269:d286:bcf0])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 45QDWYQF3643882
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 15:32:34 +0200
Received: (nullmailer pid 2316567 invoked by uid 1000);
	Wed, 26 Jun 2024 13:32:34 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: linux-usb@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>, stable@vger.kernel.org
Subject: [PATCH] USB: serial: option: add Fibocom FM350-GL
Date: Wed, 26 Jun 2024 15:32:23 +0200
Message-Id: <20240626133223.2316555-1-bjorn@mork.no>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

FM350-GL is 5G Sub-6 WWAN module which uses M.2 form factor interface.
It is based on Mediatek's MTK T700 CPU. The module supports PCIe Gen3
x1 and USB 2.0 and 3.0 interfaces.

The manufacturer states that USB is "for debug" but it has been
confirmed to be fully functional, except for modem-control requests on
some of the interfaces.

USB device composition is controlled by AT+GTUSBMODE=<mode> command.
Two values are currently supported for the <mode>:

40: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB
41: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB+AP(LOG)+AP(META)(default value)

Mode 40 corresponds to:

T:  Bus=03 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#= 22 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0e8d ProdID=7126 Rev= 0.01
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=FM350-GL
C:* #Ifs= 8 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=03
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=ff Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Mode 41 corresponds to:

T:  Bus=03 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0e8d ProdID=7127 Rev= 0.01
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=FM350-GL
C:* #Ifs=10 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=03
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=ff Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8a5846d4adf6..599439bddfb7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2224,6 +2224,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_7106_2COM, 0x02, 0x02, 0x01) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_DC_4COM2, 0xff, 0x02, 0x01) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_DC_4COM2, 0xff, 0x00, 0x00) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7126, 0xff, 0x00, 0x00),
+	  .driver_info = NCTRL(2) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff, 0x00, 0x00),
+	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
 	  .driver_info = RSVD(1) | RSVD(4) },
-- 
2.39.2


