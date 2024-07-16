Return-Path: <stable+bounces-60083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99C932D4D
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D05D1C20C6A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037E19E830;
	Tue, 16 Jul 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzDxaaMk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23619AD5A;
	Tue, 16 Jul 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145803; cv=none; b=seuzz5t4/lZe2B9NicTflXodCYLKyRy9cpD+tsmhOE/fJfeXegxAQ8Wbxf54KOkwlkh5SVFiAs5v2zVYl/Ld3ePumo2wb5vbghaQQQXjqSgIbDlkg+X7yymGUMkpJrlz6Bo0lKXTzcJBvl1d8+s/kCntT0ov3Jv+o6g7kvYKOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145803; c=relaxed/simple;
	bh=Gvr/kV+mTATdh6YIuC7CPpJstknVMGhM2EDOP5Sy7IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5Yp1REmfsoSMAIMNbjgzrF4dlq6wBbAJbVxLcPYdmLtYYia0III8db23c1jlIpuQWjQSDzJWqUeNXYa+03gheUPA/qhrzt39HTLPGrzuO16kaK5Z1+0Xypi2/wiIIMaDnOlGmtLkHdLWrFB0mEOu+WZ1cjlAH+6xlEOG1D4DXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzDxaaMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD6C4AF0B;
	Tue, 16 Jul 2024 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145802;
	bh=Gvr/kV+mTATdh6YIuC7CPpJstknVMGhM2EDOP5Sy7IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzDxaaMkJOki0nT579qX6zGUpUNgVHBQ1DVAhBwz6NlOmrytvRj5twujUS3zk9xER
	 2XZJGO8ftjK9X1BtvfRD881qTaLSYbqDw+Wckr8eoVoeJv+GRftTweqg3yrxY9giwm
	 lYZ6fU2NRv1GmGqgeWpb+YJRgzKc71Ct2Ssj0Gso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.6 059/121] USB: serial: option: add Fibocom FM350-GL
Date: Tue, 16 Jul 2024 17:32:01 +0200
Message-ID: <20240716152753.598819479@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjørn Mork <bjorn@mork.no>

commit 2604e08ff251dba330e16b65e80074c9c540aad7 upstream.

FM350-GL is 5G Sub-6 WWAN module which uses M.2 form factor interface.
It is based on Mediatek's MTK T700 CPU. The module supports PCIe Gen3
x1 and USB 2.0 and 3.0 interfaces.

The manufacturer states that USB is "for debug" but it has been
confirmed to be fully functional, except for modem-control requests on
some of the interfaces.

USB device composition is controlled by AT+GTUSBMODE=<mode> command.
Two values are currently supported for the <mode>:

40: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB
41: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB+AP(LOG)+AP(META) (default value)

[ Note that the functions above are not ordered by interface number. ]

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
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2230,6 +2230,10 @@ static const struct usb_device_id option
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



