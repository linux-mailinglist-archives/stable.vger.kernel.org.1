Return-Path: <stable+bounces-169439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CBB24FE0
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3955C46A2
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52678286D52;
	Wed, 13 Aug 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFFUcB9/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1332857C1;
	Wed, 13 Aug 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102272; cv=none; b=kdhPQCIgh4v0w44QCc0573uGUX7qCxfz1IPMBXQlI6GLdWzn7POG9CcmdjAQkuR5zOZOgFyBH/fg9B67B5uFowEyBAPvwWs/YJ9w139aPDX6BD/Af9oX81CRs67QztTcBTmJYgWnDieiWZnPM4wvUYBbcNIW/+xsm7E2t2Ju/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102272; c=relaxed/simple;
	bh=xvqrrcpDlRkEXLftgfJwBkb/4SGhq3ZlmI8+oAtSdkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D72g/o9PlL7MeVpwU9epZqiAXlS6yDdQefxcLHxwaibBLiybwjYItQ3IuNt9IwIQDg0C/1IPmXF4ID/woO+67/B4xnAtYIw31bi5D+4pyD6A9TudRM8+QaoUFKOPzNTMb41oriy0t92MklnmzU/vrQFsVgQwcmvl5ji43NdJOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFFUcB9/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e67c95so98133a91.3;
        Wed, 13 Aug 2025 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755102270; x=1755707070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1fYfYwdb+xxWcrL06oZBXhXN1znw9DMoL0ryHqiAVc=;
        b=LFFUcB9/4HFtJ0YTLk6Tqqt+dSuOcVp5CxKXJqijwY+ILQgEPyocBkZCuv5FKS8IK5
         EPnr7m70VtgAZGnuPmlqS0sVDpGCAGqjX65Eipg2ReM78kFhhY+/9e1s6AbjjEFIiT5G
         h+2yC/5XmagakPRqH4OHMtsHhzQ0iJ7RmlWQik1D0yqSiIMa8+lN5ZdQRQzNlwj+05f0
         PR1MhpuKAzdE68p7rUEq1wCwyZXDcmJ1/EF8UlrgF2FPaDNAZH9PryCqzoq3GYmbBjwW
         wIXJ7lQAOGFbR3lxJYMm1NRogJrN0V9jS6bYPDmw5h4TDGrdIOSlou0bp9qXIOC9Vv0k
         TvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102270; x=1755707070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1fYfYwdb+xxWcrL06oZBXhXN1znw9DMoL0ryHqiAVc=;
        b=oVyUG8QZj3Sdy4SYtE2yujL8y50GoHj+Q6pG7VJvANcmpZyx+1vGBmqtYaq9pf+Nqw
         V7kBKyDLa8Up+pinYOtTXm9cCQhmdhSX8uaFm9jntrJclDXVPyfenhQIsMMvnMY+Or1s
         F/JkbukksxsUsQvnV2XrEs1p8zGwfas2Mv3oLJFXtLb4OauGs7qo5EZqq2u7F3BMzpmV
         aRZyodutxPHKnVFlD5XjtGUZ9i9eJGqVfKZL4jb/E6B5WftiOEbZmnfLXpQN2bG/75FN
         x+HGN970gcvLDu1HMfeS7LaJOZyfbGbS3JgI5p0CMcSbHTph8tiBShki4+zxPzDON+Ik
         F2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnn3V5Q382aWaCme1cmV+RYd4MW6LFQqgrCk/8va4/a0DXJ/woaTkuKvdLQ7nPjt+jaiCK1XnxvHzk@vger.kernel.org, AJvYcCW3/dFODUkwXSLvwa0lR9uFWmYeGhu1VQQLu2eMSOCzytRTJAV6RoUw+Xtp/GYa8nRdtSYX4EQWzPe3TFc=@vger.kernel.org, AJvYcCX/51RSD15qLjBBRZgH9U2Lfmwy1iX2aWWyG4X3tpzOz8b4nR4tmmr0SqSl+lc812+/0eTpkLmD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2d8W2Big2K5+IIWPWQEOH8EN5FHIChprfJVHY2CJodUqsQenA
	l2kzebIcelpNaQLf2wO2xD04mT68OGJb7Ca9lH4wYXM/FKDUUIJ8wdSBfR8VcU2o
X-Gm-Gg: ASbGncutH5B/EAQq31wHbKXXqtvnfHNl4/NDD7vLbl+VmmNLR4IZQbAQnhsSZlKOUfn
	SpK8AeUPqpLSJszmUBumrBgv6TuiqklXN5zNW/h28L3haP5dAKBFn1Vuwx2A0P/jATv5uFRI+jx
	qhOYoYWfsCtlqE1lmNQRqvbxKBWC+xW6oY9t4PwoJHvV6DdiqTpwS82VBnGqMhV3BJT8KkOyqEA
	Bp0wVEs8B67X/LEPlhJ/avbItaMlUNqFcOYvfUaGBvatQ/YXWLNWHotnmmYpXXCBE1X9Ge7jUCE
	KUQ3zoJMsTZzTykMjOhnVJkyShJovUx4RXbRRGe6dYTEHt/RFtfWiYt6d/pgupzp3/0i4hiuAzz
	cAXmXvGluaBGwIzEEByJw4bYud0ss4pSIkwYK9oHVBBAV55LZQq2P
X-Google-Smtp-Source: AGHT+IEp7rdSfbXkfRAvHxQ/8pSlg5nqWRdsJe7pGrzxWe31DZ032owbebBvYAfQFTs/z1iixKXmSw==
X-Received: by 2002:a17:90b:50cc:b0:31f:6ddd:ef3 with SMTP id 98e67ed59e1d1-321d0f253d2mr5202354a91.35.1755102269702;
        Wed, 13 Aug 2025 09:24:29 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3232579dfbesm558412a91.20.2025.08.13.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:24:29 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Cc: pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles
Date: Thu, 14 Aug 2025 00:24:15 +0800
Message-ID: <20250813162415.2630-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many Realtek USB Wi-Fi dongles released in recent years have two modes: 
one is driver CD mode which has Windows driver onboard, another one is
Wi-Fi mode. Add the US_FL_IGNORE_DEVICE quirk for these multi-mode devices.
Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode.

Currently there are only two USB IDs known to be used by these multi-mode
Wi-Fi dongles: 0bda:1a2b and 0bda:a192.

Information about Mercury MW310UH in /sys/kernel/debug/usb/devices.
T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 12 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=a192 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=DISK
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Information about D-Link AX9U rev. A1 in /sys/kernel/debug/usb/devices.
T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#= 55 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=1a2b Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=DISK
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org # 5.4.x
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/usb/storage/unusual_devs.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 54f0b1c83..5a6577a57 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1494,6 +1494,28 @@ UNUSUAL_DEV( 0x0bc2, 0x3332, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_WP_DETECT ),
 
+/*
+ * Reported by Zenm Chen <zenmchen@gmail.com>
+ * Ignore driver CD mode, otherwise usb_modeswitch may fail to switch
+ * the device into Wi-Fi mode.
+ */
+UNUSUAL_DEV( 0x0bda, 0x1a2b, 0x0000, 0xffff,
+		"Realtek",
+		"DISK",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE ),
+
+/*
+ * Reported by Zenm Chen <zenmchen@gmail.com>
+ * Ignore driver CD mode, otherwise usb_modeswitch may fail to switch
+ * the device into Wi-Fi mode.
+ */
+UNUSUAL_DEV( 0x0bda, 0xa192, 0x0000, 0xffff,
+		"Realtek",
+		"DISK",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE ),
+
 UNUSUAL_DEV(  0x0d49, 0x7310, 0x0000, 0x9999,
 		"Maxtor",
 		"USB to SATA",
-- 
2.50.1


