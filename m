Return-Path: <stable+bounces-187661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB96FBEAA1D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EB32585C09
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58C189F20;
	Fri, 17 Oct 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moRfPMcX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588024DCF6
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717252; cv=none; b=YOAmsU2pxSc91glxvJCRUR4KZ5DBRKkBKIz7JrjrwWfGIPKtZCC9HxsRPEJcwZFFRJtvyfWtngqLwLcLxnLOul2wjleRRKvAHnjsbvK+/o0s+NCLNnoY9Zmkt0YYJdP2e72kDFl5ph/d691EeVEdGNNBI00vbrSiUpaUP8qW++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717252; c=relaxed/simple;
	bh=v2AMK2rr3zOhCRXS4lgxTqyS7QAPNJO49kwq7Hl0VsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKbIBF2x5WzgoitTlWwFVc3D1wy4cJRad16ZSnj8+PG1nozNEwbm/MJwWSgwRy/CJMtnSOGIZYQfpIn2mmGjdUTXLyj+PxWY+dj4Md2RptG1aMYE1viOlmTJl6hq5xbf5DBbShzbrd5vm77+nnOtmx2cM8Q9sEt0PPf33hlcKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moRfPMcX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so2037631a91.1
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760717250; x=1761322050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Nvb3Fnr1covThu7mwDGM8JE3WZ2RwCAsPQQpCNAR2k=;
        b=moRfPMcXA010JpP+MNdUstQjY3oszO22ru9NYhIQ2VsXMxQDH+4QKIyHVPgrgkzEwr
         /FzJNLX6fPXJ+BdHUdH4u6J/zjqWpza4a43NqVn7f/0ixqtwACNi+NWaPoHiLo1J0F9K
         YQ2tvKVmJFIWFsIWOwjEZgnd4Vq7lFlq0BkrzcTfWfmBw84UO/R2D8IXG4hS5WXLlaBU
         heztSuAYVK03Y1OaCtEIkbpvBVUSjIbA8Kk0uKXMVmcZsJHmfFySIiY7RIH702NPHpc0
         kmD0u9Rw6ycm035KymsLHwltIXrZ1LcuSAh8jrh6umNIADWSegg9leplRPPOImy4//IQ
         298w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717250; x=1761322050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Nvb3Fnr1covThu7mwDGM8JE3WZ2RwCAsPQQpCNAR2k=;
        b=s4dj5SDh3+C2K6T+PT90NADJNK0D6ZNGQHgmvrZu2Qiz4RyC1fefWCWBiE30NdE/er
         271YaimvGBOi7vPr2EEP3VQmFsrtt0HP2LYsoad8vGTQwzCMygXB7s46ZEOK3MQReJem
         /ZPRwuJKZbKfJsyU4ssjRHjDJdNB0InCytihVHChupGnFG82mpv4cu39NUMV3puJDGAg
         KyhmoKDGXO9vQZ9mOI9OWTsw+vJy7AHb1ueCROqgZwpKmUqJT7sPPMzbtWQsDy/txHqy
         XiLlZObNGIJe8T0jUcTQtR40QMiIzBd3B86+rpiQD4l1cfOeLnLjjyCqxmSQDKXooMub
         nixA==
X-Gm-Message-State: AOJu0Yy+y8desJx3xsvedhuhNjqSw0SzI9JR4+yKPCkHDNYe2oINvrWe
	5rdcO58V9hjW9FfNL3dzja52IQbmo2iZAG7ssUvt8TYTkHineM+LglQzGdCKYevD
X-Gm-Gg: ASbGncsXSVtg22lvlwaLy5do5rF5RFCDWM1ZTMfyak4Szn/HQJgJ3kB+zNV2scm9k+U
	pG2GIQjEoUYk4T2bUkEEOtSU/Lmj/FlT7E6W6pG99lKHMPzwxIA8ezBvJGEAaNRQxuG9ZHtBGYD
	BYJ1Ng+r6BrTqkwWKjW+DZpEQNEhMDOp7EliZkSFVABSrNjtEF7qkbJonDmxh2HeBXxd55EldbE
	ZU14RYwwiqR51AMNbknsU7eJCU5IgHN4U0wzaVQTUe8JCO3mvgp3wpwo5iRZVwnINvvyeffgblz
	jetPOzs9k/bUXeSEhbmxuVAYkulHuPQKBIlgtuGAWNp6sSzTjZARNVzpRHq3QBSvVakEWs+Qs4s
	Y2n3L5cna9CAC8CVwZg3/tAfsu7LkJuTMZKCklFejhi3KX5lY2Cpl6F5pcYSRmwM8FLm+vVl4E3
	15SWVESyHAH7LwA+xS9Ab7buTvambKhppjpxHZaEq4
X-Google-Smtp-Source: AGHT+IGasBZb3ZDIJBFGR34DbOkpWAyvSYeCxv0ixbDyayDO8r5S/X/W2EJxkGPC//CVXHjGAIkoEQ==
X-Received: by 2002:a17:90a:ec8b:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-33bcf8f7280mr4637271a91.25.1760717249607;
        Fri, 17 Oct 2025 09:07:29 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33d55f52936sm28637a91.3.2025.10.17.09.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:07:29 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6.y] Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1
Date: Sat, 18 Oct 2025 00:07:24 +0800
Message-ID: <20251017160724.6612-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zenm Chen <zenmchen@gmail.com>

[ Upstream commit 34ecb8760190606472f71ebf4ca2817928ce5d40 ]
 
Add USB ID 2001:332a for D-Link AX9U rev. A1 which is based on a Realtek
RTL8851BU chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2001 ProdID=332a Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=802.11ax WLAN Adapter
S:  SerialNumber=00e04c000001
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtw89_8851bu_git
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
The Bluetooth support for Realtek RTL8851BE/RTL8851BU chips was added into
the kernel since 6.4 [1], so it's also fine to backport this commit to 
6.6.y. 

Tested with D-Link AX9U rev. A1 on Arch Linux (kernel version: 6.6.103-1-lts66)
and no issue found.

[1] https://github.com/torvalds/linux/commit/7948fe1c92d92313eea5453f83deb7f0141355e8
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1a2d227b7..4c21230ae 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -511,6 +511,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
-- 
2.51.0


