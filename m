Return-Path: <stable+bounces-181802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E204FBA5829
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 04:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E4232336C
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 02:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C3E198E91;
	Sat, 27 Sep 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4pnLC4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181901A267;
	Sat, 27 Sep 2025 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758940185; cv=none; b=s3SJXCbU+QFdNdtGwt2FeaEpKf/k2bRERoGgVePgwJ2aI8mTdZg8Dd3zIwO1a/hlu/SVZH53gdb0mr3UPWIZZPIP29UKTutcuu6gztnkE/qNy/J5tLiIxNgOHftI5RtX7VU3UIzPB8LHB5tQpoQSEOVTfnCfq9UMIFR2Od/8C4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758940185; c=relaxed/simple;
	bh=bxZHY0G3LSE1TLel39JL0bINmxacUD7SmlVol7Qqix4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LmBXE64Ofi4gYIffcqkGxSvbgnTJD1LVBRQdAnyit8f6CXuS6bL3bObHY4Fi0YUAmz+WgJVm+Uuh5AMTcApAS8+kXGl1y8MzlJIPKpQ6CHWmzoPIdPPySaKsi26Vx5CU5v+eYiL/p/UBctj7AIqVvGua5VqvgTB3APlKilFlvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4pnLC4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 901DBC4CEF4;
	Sat, 27 Sep 2025 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758940184;
	bh=bxZHY0G3LSE1TLel39JL0bINmxacUD7SmlVol7Qqix4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=J4pnLC4wMKlkSYzle6guutb7pFk8niyLbF4ggVN3MPHaecyfYeLMowF/ppbwXGNbH
	 9qHkOtjvMcXF8Qo70nLWG1gtUawdt5U/m8jux8RvWVnTk/vO/iaMPGax0F4ed4myLk
	 Iihb8oABrhq3wrNbP9t0uSeynh8yHaO3vp3C3SvVHVDrvpbH3/NfwBIXGRrw65rVlW
	 esBawn5gqrGv9ZJ62SLeO4rsLDRtIPIedekGPMUe8tMKlRRhXVP5e/KXP6lON8WLHr
	 VQfRcg8x6tsqp9aZgMzY8RRCCgTEfklNW0Cziu+Ey0f7nY8S3+UkxpE6GV3eOgAnVH
	 /DjSUVOpQsIsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832D5CAC5B9;
	Sat, 27 Sep 2025 02:29:44 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 27 Sep 2025 10:29:42 +0800
Subject: [PATCH] Bluetooth: btusb: Add one more ID 0x13d3:0x3612 for
 Realtek 8852CE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-ble-13d3-3612-v1-1-c62bbb0bc77c@outlook.com>
X-B4-Tracking: v=1; b=H4sIABVM12gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNz3aScVF1D4xRjXWMzQyNdU+NEIyMTs1QTCzMjJaCegqLUtMwKsHn
 RsbW1AMMgODpfAAAA
X-Change-ID: 20250927-ble-13d3-3612-53a2246e4862
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697;
 i=rsworktech@outlook.com; s=ryzen; h=from:subject:message-id;
 bh=0PHaemvygidLVIPnBlULH0clIkTjQK06pLw2gSJsUyg=;
 b=owEBbQKS/ZANAwAKAW87mNQvxsnYAcsmYgBo10wWJwpMWJDI6Gv60GqMSHPYr0X1WYBzIct1+
 lw0sH6qYJiJAjMEAAEKAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCaNdMFgAKCRBvO5jUL8bJ
 2OsoD/0WSK8QvBcFB1Z4C7W03UKv7j22OBBm+Vhel+zEYq+fGvYoBZFNLr8M88HMMfSDHkVFD3l
 qFoIoQZ4UDS2kUdj/n0E+DcdOgjhGpxsoMKrMskpL5m71FoZTFGwRxRX8QQmhZr1jgMIMF74rJP
 lN2bV07z+Y/11la2SaPt1iSfmr6w6+CmWJeMbOCYDKkgo4HLVJyJvhUCsWwZyrntY+JvBp6VPFX
 cnLItdUixcYQgD+fn3M5sbrZVOCQmn/QbCz6keOuAQcLHzHw5Z33VM/QVjot7d5g2auSEvJRpQA
 Ug32gZBfp4wIWD0Ja/4OdDt13kZfh+qoZT4RcpbDTMSMDbH1v+V7QFwTiG2w0usB7KZ87cJQOu8
 Zv5ItzoshBPsndHZNiMt+YlA0nHZhQszuL5MqJagt7CK78sVmadlLQ7M7ZLrmd36kfDXqkQHgnP
 r5mEgLgeQH9PN/35Rq/WjoJHgVlMbGTOfNHkUkXBqnRhlLjv4/i+wXpeJrt4WviNZWC/yX71rP2
 9fhSYWHqayVGxHWc8GNBhwPmTr/biFiL0uqsILNCdCMd3UQPXL9HJyIzF5bhabplB8Jt6XuC4s7
 S96EVjihqO59jkkpSyWuTYf6oB0MtVzyaVECtcXZXyzPbedCOxOHmqSENr3UyHuvXxOOKXywAYK
 pOrKoyEUswevf2g==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/ryzen with
 auth_id=536
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

Devices with ID 13d3:3612 are found in ASUS TUF Gaming A16 (2025)
and ASUS TX Gaming FA608FM.

The corresponding device info from /sys/kernel/debug/usb/devices is

T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=02 Dev#=  6 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3612 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
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

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8085fabadde8ff01171783b59226589757bbbbbc..d1e62b3158166a33153a6dfaade03fd3fb7d8231 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -552,6 +552,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3612), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 

---
base-commit: 302a1f674c00dd5581ab8e493ef44767c5101aab
change-id: 20250927-ble-13d3-3612-53a2246e4862

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



