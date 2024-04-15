Return-Path: <stable+bounces-39540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6048A531D
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FE51F21378
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13D7602D;
	Mon, 15 Apr 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXBDhizB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959475810;
	Mon, 15 Apr 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191075; cv=none; b=I81yGs1Z39p0C7H5LnRz5KgaLr9OpmDDtN5Pwp0ogArpCJh6leByJ90Vj0e92oiYtPC5ZVUp9Z1h4J05mfUkqbXXI4UMiTeG5LnScfxfRjqohdNgIWhPH8HIIWcbfu/Le5vi9nAqM93bwR0ic2g2o+vNnpvpbpkpbohJRC32l08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191075; c=relaxed/simple;
	bh=51JiZLWwzmoHsTR8Y55uPMCJp+7RqC2aBEJMMYbpgTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcyOAPe4oVFaoda8/XcCpRs0YW2wPP1YsNMkfT43h2ZsgfaGv39n0zrmdOu01BqLHp43rYD8m1y5raW4rdHjP/k1DX4lGy2wupY8jCMKWjBdkdHg0icA/g8dbjnsMXJuPXfSgaWuGNGgOBtXYk7Jshc0gEbApy8q776VqioYqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXBDhizB; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-2343ae31a9bso1153236fac.1;
        Mon, 15 Apr 2024 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713191073; x=1713795873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2kgpJIRC3ydW4yxNPxsM/DQ/+n0IFaV1OJYHgod3sg=;
        b=iXBDhizB0N9IqMQ0Tvym1+ZZJE7LJTu5Oav2w1u0VHG7u5V1ToA0m5eBvd6bUoluzt
         bEp2rUuOHsrtDlNvEJgJtLpAAUPnzMnXlGtLvwc3oEdyFZ+tlrqvXtKNvr9Lz6cgp+PX
         4hZGgMk5F3DlccTKK5rcpjih7KgQzey3+CqC/+iQ+HEouDPtaTSC8OEWN3WO9zA5FNMY
         BmzEnTilwil13Y/wjngFE5l5LI7A3uyg8zPk/VGO7tHdzfHQ2KXwnGfFblND+xWHg6Dy
         2ueEc3ypPR6D+CDpo+qCkcLTW8x3oxijJKYHOZnjLKKZg9WTxAwZamRlZI/YOikYXSWD
         gRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191073; x=1713795873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2kgpJIRC3ydW4yxNPxsM/DQ/+n0IFaV1OJYHgod3sg=;
        b=e8176arriQItcTi+gtGGnrzYxhMs4puamGTAdkPanxXvZj7/DZAth62oePZr0wWyFv
         icxMTXL+FRgpNNtOZ2nStb41XSxlKishp+HgfQBDNYRYnEcxCbFJTI+KN2Xzl589/zGV
         PdAR0HH1X8YPqbaWzNI/NInPG/cJQRd4mkdpXBSpNMcFH9Kz8KGs2/kVXjEUuvTyNtzB
         a2S9smIoOcgngCaYBc4fBHsL+NRNSPdCkLfUImjnICifbcRgVg72lQ5q5QUFrrYGchod
         2/lVocxNYA0WZEhmNMNxgL1YAwkjb8DcWTveMY41bufrBvF6VXksBWVfTk4clCtV2LpN
         yRrw==
X-Forwarded-Encrypted: i=1; AJvYcCWaB7jtZScYwyRG4L4Sfd8QODzVeb9qDowdlBWnuwKJDimeleskweVBi4yMlRfbtoMzLEZQoE03e5sLSC8POOmzg18EPyd87TAfcHDj1cmnRe3Vs2o1fJw7Oj5XgC9v8dLO
X-Gm-Message-State: AOJu0Yy+sAoY9prbol5BkU9vQBneCgwVRFzmX8kcj2p0DE0V4dqXk8Je
	bXo/Xn32oJhT7LbYcZEPOuRz1LOu9/smXIgFgTQUQwnqj4wcj2gOQkGK54k3uV+/FcU1
X-Google-Smtp-Source: AGHT+IHP4IIeTP6bX1KUBA7w09JmZGZetiriSpBwT4bA/7p2KXM/LF0oKmSHzzQhROGkFjL+ZmSd1g==
X-Received: by 2002:a05:6871:5209:b0:222:8fd3:262 with SMTP id ht9-20020a056871520900b002228fd30262mr12934626oac.24.1713191072959;
        Mon, 15 Apr 2024 07:24:32 -0700 (PDT)
Received: from localhost.localdomain ([2604:abc0:1234:22::2])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm2269850oac.11.2024.04.15.07.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:24:32 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: netdev@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 2/2 v2] net: usb: qmi_wwan: add Lonsung U8300/U9300 product
Date: Mon, 15 Apr 2024 07:24:23 -0700
Message-Id: <20240415142423.1754445-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the net usb qmi_wwan driver to support Longsung U8300/U9300.
Enabling DTR on this modem was necessary to ensure stable operation.

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
Tested successfully using qmicli on U9300.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
Cc: stable@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---
 drivers/net/usb/qmi_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e2e181378f41..3dd8a2e24837 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1380,6 +1380,8 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
+	{QMI_QUIRK_SET_DTR(0x1c9e, 0x9b05, 4)},	/* Longsung U8300 */
+	{QMI_QUIRK_SET_DTR(0x1c9e, 0x9b3c, 4)},	/* Longsung U9300 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc000, 4)},	/* Olivetti Olicard 100 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc001, 4)},	/* Olivetti Olicard 120 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc002, 4)},	/* Olivetti Olicard 140 */
-- 
2.39.2


