Return-Path: <stable+bounces-25350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE2986ABFB
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 11:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889532828C3
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80635381D2;
	Wed, 28 Feb 2024 10:13:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73D3770C
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115238; cv=none; b=nA/vZnHfgqrtqAIN97u9NUiYSUfQCjCYlfwVvFoSzxF2dRXd7UtDLdOSwn3T0CfYV/9XuSaM4rReurUzxefx7qfGv8wNpqkbABHyTVdfe1jbFrb4kVEN5cpoyzZznpPy7cecIHfRVBM+kYL9Q+p4BfIw51o/DTp0hWwNq3a1UVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115238; c=relaxed/simple;
	bh=14hXcN/pmzBveu368LN55D75J7WvTTeDWA9NxgE0OFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tt0rbCWsQNaddGx+B02ha6XPjfQSBdXXE9bYstPkq77Woxq6RAqvZCRxqQpX3ySg8Dep2Nby5v/MeubkUHZwP+TMNVIqycfAGlKiv/15krON1Jy6iribXjRfLTWSJtY+9y1xiyq85StqmnWRKK064MeUs+FNGrhtqL1cJ33ZlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp62t1709115208trocn87m
X-QQ-Originating-IP: uUjka9UhITDP7iDTrIHmRHuOAbTk4TgE8jMpLxt6AAw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 28 Feb 2024 18:13:26 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: znfcQSa1hKZ1OQVbZm+fYQPI766XCh6aUqJjjI3UFo6bHEOOYrK8E6ZzzpNis
	ycaJcFnW7c2mXQJwc+RqnVogWPbYMcSAv8hA8efuy/WRWupRkx3ZWoUN1CKpsMkyIYOlClg
	BZODt/hGk0/WtBdkbW8w5Wzr0PMkLTZZOPbG5W82KGr01PTYu06sOuO6zTw3xeLcvfWSgLR
	IphPH5ln9CRwC8PZI8NqyNJdPkQOy+DgcALgtEiPGy/9zFs0+NKiRkTqbIFeCi4YGsFvJ4g
	MFpj/eCArxgqV4y6V5xIzrQ7nD1HxksrJ/S86wnz4+0GSnW7HkVYYeysrGmx1DYO7YByuCf
	vkOrlaeNXkrFCkxcsG7x05NJftxLRd8i09aIFezP65YkmfvZmmo80PGCGmxTDNSmsRkh9uz
	VA5jfZmnplQ=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16063273281454352206
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] Bluetooth: Add device 0bda:4853 to blacklist/quirk table
Date: Wed, 28 Feb 2024 18:13:23 +0800
Message-ID: <A3926852489BE409+20240228101324.18086-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This new device is part of a Realtek RTW8852BE chip. Without this change
the device utilizes an obsolete version of the firmware that is encoded
in it rather than the updated Realtek firmware and config files from
the firmware directory. The latter files implement many new features.

The device table is as follows:

T: Bus=03 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#= 4 Spd=12 MxCh= 0
D: Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0bda ProdID=4853 Rev= 0.00
S: Manufacturer=Realtek
S: Product=Bluetooth Radio
S: SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
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

Link: https://lore.kernel.org/all/20230810144507.9599-1-Larry.Finger@lwfinger.net/
Cc: stable@vger.kernel.org
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfb49bbaa28..5225a6075626 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -542,6 +542,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0x4853), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0xb85b), .driver_info = BTUSB_REALTEK |
-- 
2.43.0


