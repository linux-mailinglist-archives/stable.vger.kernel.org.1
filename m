Return-Path: <stable+bounces-145731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B36ABE91D
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C709189B902
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031916CD33;
	Wed, 21 May 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvnvub9e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BD21448E0;
	Wed, 21 May 2025 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791033; cv=none; b=dHSm96LZDmLCGh9pV1npJOJBMuQLBg2CiXJZjh9174E+ajRbtsDTzwT9ASt+IjPaNaemSsz7bUg13E5wJqHhpxsuE/XSuaCqEoEIB4c/ugBl4nVQAEFJizzqUN3m7rZ0Mf1GE04MThzxvXZtRBVEmHaYA3AcIJEGUzeILnPu7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791033; c=relaxed/simple;
	bh=JAi9je5re+b6y5f+ZxJTilrZ4zG+cYZXXo43+XlJLUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNJ7vRtiwImD69Czk25Uap20Oyis9W7dUhvc1wxcE+xhsq61QOGObGU0eCiwEXw90fBqubinoGCC9jcfXhY3k1HF1KFYwd7Ib3/XM/0s8AokmsSWxtoCNSD/eTAYxQs7Xck13kUXrM08QF+hzrjuLxLF3cQbra9+HKTkLrZS8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvnvub9e; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-231e011edfaso52384925ad.0;
        Tue, 20 May 2025 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747791029; x=1748395829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b89d54m5uN4jNy4p1tFkC9VyeRkwh4NFICMxAAagdE4=;
        b=Rvnvub9ek1Tpd8UE1xzMRExZj88KLhLm/oW82ogF80ywrcDnL5GzwRKSeWsZ1Q6grN
         siq3BorsLOq26Guw7PLEaAroaSCPIX7hfSRrp46Qj2R17WNS86mgJurWlojNQAxDKk4d
         dpncYsJHkOJi3QL77w1Hv66O0Tz48azc4CxqIgS/Duup9Krx0T49Db1VrtMUhI995ABI
         XCojCrpvvxb+8vQlbUSamvFHEiHNMTHG/ZuTdb41fko3vD6iZ4JL0Ye2CxrxUnqNZ4ze
         UiOjSn3waH5Aw+PKEyVVzBOZfJd3PRm4T1Tohs2dx7Luq/iHPWvT4hNXD6nNi+zfSjej
         yANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747791029; x=1748395829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b89d54m5uN4jNy4p1tFkC9VyeRkwh4NFICMxAAagdE4=;
        b=Jb3AicJtunpDQNTB/AsLqMnatv+XivNzmS5ByZ4oD6I7J38TX6FPcWI0LSTRqHsb+r
         WjTCbn5fLsbcuei/aaHLhXK2vc4nm7N9MghaaGPXDLs88Tz/W/D1CGZojmCO8Qt0yKI8
         FPMwcXt4n3+WvnTFrDjisRLRxKS75lPb26496fh2FeOFf02mysD7nIYEdUqRSdBbO4jQ
         hOVnJYPlWqR8LPMeCcRBCzRzaCrRc6BELvvHCQ4ZxvQu46NpsUjxCMN7EX/va+Tg8ZgX
         kJgiya48sM+2/RLbLYU/JpIAgnj6bg13R4GZa95lJrLpfeiboqSeMVSBb14gg9iQDrC0
         gc0w==
X-Forwarded-Encrypted: i=1; AJvYcCWi0SZW0H/uReHn3r0lXcoRKyhhbaT+vgliczgiEGpW2lKq1zpL9ve6kDAxdESp38LbkdkwhBK5z0edaU3R@vger.kernel.org, AJvYcCXmI89UTro1s/pyAn0cEi0itdPmOlyrnie+dupfYcTumBB0X/doKG+xY6f9a4HkPcIKveUlZWfb@vger.kernel.org, AJvYcCXqqrzPSTebEVwuYcTpraY6Fcjq+kzrmGu9pWBkmWO7Y0Y8OhI/ZahjUThpaTTrznNr9+XdY9AVjOvRbC75B2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylCJVncTo62k/A1k/xDoDftRxNV5oQmub7vIIHDntcXPzR4Qi7
	8dFanPnAh7fSd0VEE+mz7a2G0G67kcGAeFu3HnEP1ZqCaOXxcwb9bbMA
X-Gm-Gg: ASbGncvNiPxnal6XmIlH8wNCw/o+iR1OxxQsibR+Vj1jztijecBy66lcRvdnxx/3CQM
	jDPsqnXTohCmnkGOo/sQQ8oMfJanbvYhmnJVQjn6vnbMj2ra0SCW2/sJiwqemeCgqzE1O7PJklw
	iK+u9RQb7qZG2T+AHiQV+3F7t8+rEOh/211yF5K7GjjGdWS6dmV2wsD6Ty2AzE1zcQWaBjyzBVi
	pL0ZD0UvLosux3FyQL9ra3fmhJbzxt29+dCtAg1Fk450J9iozGcfqGmQaNy70dzmmFgq2tL77nF
	IC1Fr/6+0loyXFNFlG8yWu3bI0FjRdEfmyWZbHHNi5jaT4S0/ZgLLjMlDmZPX/JE1rIcQALb9cI
	98h2/UZ0+J8Befo7/hPq9RlO77Q==
X-Google-Smtp-Source: AGHT+IHZukRre5NVpkpvdCyhZ2EyhSlApApWFX/GUXZns/jeMPjxtwRTJDBxy5hEu0FwQTtjTj/+PQ==
X-Received: by 2002:a17:902:cecd:b0:210:f706:dc4b with SMTP id d9443c01a7336-231d44e7c4emr251754285ad.13.1747791028804;
        Tue, 20 May 2025 18:30:28 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-231d4adba91sm83224195ad.54.2025.05.20.18.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 18:30:28 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pkshih@realtek.com,
	max.chou@realtek.com,
	hildawu@realtek.com,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	Zenm Chen <zenmchen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano
Date: Wed, 21 May 2025 09:30:20 +0800
Message-ID: <20250521013020.1983-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 3625:010b for TP-LINK Archer TX10UB Nano which is based on
a Realtek RTL8851BU chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 9 Spd=480 MxCh= 0
D: Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=3625 ProdID=010b Rev= 0.00
S: Manufacturer=Realtek
S: Product=802.11ax WLAN Adapter
S: SerialNumber=00e04c000001
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
A: FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
I: If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 63 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtl8851bu
E: Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9ab661d2d1e6..3016ee9f2932 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -516,6 +516,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 
+	/* Realtek 8851BU Bluetooth devices */
+	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.49.0


