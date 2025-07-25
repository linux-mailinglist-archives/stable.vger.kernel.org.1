Return-Path: <stable+bounces-164748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C644B121BB
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 18:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33ADB7BABBF
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2011B2EF9D2;
	Fri, 25 Jul 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClZJji21"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04E2EF9CD;
	Fri, 25 Jul 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460121; cv=none; b=D1OShj+Wo23ZZR4gHiqC1xDpdoULl4kbnvC/pUkGl92QUQxUllxYAuVCYYcIc45uyHbHlOQ7+EeuMghC2SoUpfptwzykj1gLfvOzBER9BT1dmqnEYf+kXzA8qJHPJ2vgAbjHwefdVNnKDXMvYoUU6AwNoKbwceZCmc1+sd5ZkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460121; c=relaxed/simple;
	bh=fh0CjKHTZvu0FuhvdnqoJwzPfDDNX+QCT7SyJ14PPQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwmDzzZNt4w/bZy4krBuZ+jK8TWoE59bWkoT3JKiDCgBDlT5p8RhIVxa/vGRnFnlV8A7x5RR6GrjyRdAMwdRibJOjP5IQSs8UNJQ9soqYARS4DUooKDWwPn7JV8rWHy4y3gDPQdwO+r2G4tmxJcREcBcXMhWIpSvzd/AzWaQM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClZJji21; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313f68bc519so1811684a91.0;
        Fri, 25 Jul 2025 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460117; x=1754064917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cFi0vD7YessLF2r15au7TPe/jon8lIosOISFCfh1VM=;
        b=ClZJji21xibaWUctuamOxgpSpc2mWYLC7998HFSvr1waknytKwxETK8Js3VFTMQ3st
         lxN422PYDdPWmCmxYPmGJ0irMB6Gg17Q+DdlenHEHDTfUfhU3Y0cMkLlLFm4UFU5gNUR
         oETKHBBn5amByFsXcXmSEJZ+veccns0GrT9o90P5no93Iw/RbC/99DCFfMCbVrP6/8+P
         374xghyt9uYjMrFAHJM08VWmSKmW6Ql5Ohy8qrjzqHKJIQHEqfnD6W+XVsfcfyFIRWB1
         Ig4X7hyp2culaIF0aVN0Rw38hMdeNk6otrr1ctr22KHSFReZcKVlLPaBFfGfpnn/2Q3Y
         fH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460117; x=1754064917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cFi0vD7YessLF2r15au7TPe/jon8lIosOISFCfh1VM=;
        b=wQ1yysnnMZkcn7A0GnIxjSZwUQeFyGIcRjxf1dJsyGvUMbb4i3W3T14CFD/61VqIMz
         LYUtFl3To5gdYQNHGA6kx+yDccz6vnwfcoQqAWuq6a+UAAtIbj+Bydd21W3wENsHnsJS
         1HHBo7x3kvln/nEGdZk27XWkLXz7vMrMd0oplVmhtRHgzXNPfLs20tGXPLQBiWK7MZW0
         whiX3GyQKFgW+u20uKOyvtFAtwRwnpFHkDfJN4/moK75h9xe1MERnn2IIWZbMHk7B1mD
         ZtYayb8AVbi6MzkP2EIMA/g4XhTdRx5WTVLNuVnBZdeUvm4l5n9gvZCS43ZnccoyGQs8
         +WRA==
X-Forwarded-Encrypted: i=1; AJvYcCUi3m+v8hkx9HctBTWWskhwgEsD2PSCxatVbf9KKzDmOg74mjxFDmQg1whw5ztTe5aYXu7nT7zr@vger.kernel.org, AJvYcCVvAOTc6O/THNH1+pEYMqn/tu/RFCWzEz/5wmwhhPJIGw4/cPzoSTX01461covuPJy4I+v7DuaWInqGlTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzJhe5aTVF0Zwllkj6hkCoBUEN3urDpr3ElxOcYBGmRuC6186
	o+MhLa6rkrsosPalcg8Dc7jIGqVkRFlmqR9/jYsjYrJ4LM5lKeQxlxYt89pJu5/6uQg=
X-Gm-Gg: ASbGnct8SJRoLRAZRny46nkCGJKHDC8qOAmDer8kRKBv9GE7/JxN0xazyxaAffPxOvV
	DGE9lsJxJbIVx2kzfAbo6ngARIG7NZdRmQIQElW6YASDoO/wj9MsbVbmqHEVap0F8N/9D2zH2xv
	lryfWQZ8EsVW1LMeA4WfKEUiL4TQPY9mvGG5j30DlRmQ++VzOz1jPP1hqEEURnFS83hhgWfCrCm
	JBepGoHYE9EYv+AXLrCvjV6oX6gpO2xWdocZwmaQkSMvYTIEr8qMGAQGsDxxvp9i+UiXbuwM/35
	Ov7RF7WxotcxpQczeq9r+0RITlMg9ossGTp4VWw0/KNi9c1RQpI6m/UBxSbceACvW8ulUqgghed
	IND1+6Fxy1xLAGF3hmWDlRMehJxn35O1AbYa2FezNjisx7RLR/wwY
X-Google-Smtp-Source: AGHT+IEmBI+tcBrcxIwV7kA6wcfnWlRhgQZw2jycq881kY+fEq6W73LTONd/xlqvx9aFZrbYHRbH9Q==
X-Received: by 2002:a17:90b:134e:b0:311:9c9a:58ca with SMTP id 98e67ed59e1d1-31e7788a6aemr3965185a91.8.1753460117304;
        Fri, 25 Jul 2025 09:15:17 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31e832fb879sm61604a91.6.2025.07.25.09.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:15:17 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: pkshih@realtek.com,
	hildawu@realtek.com,
	max.chou@realtek.com,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	Zenm Chen <zenmchen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1
Date: Sat, 26 Jul 2025 00:14:32 +0800
Message-ID: <20250725161432.5401-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8085fabad..3595a8bad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -522,6 +522,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
-- 
2.50.1


