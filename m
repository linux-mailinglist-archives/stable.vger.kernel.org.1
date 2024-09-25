Return-Path: <stable+bounces-77124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63241985874
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D6B1C235AE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF81B18E02F;
	Wed, 25 Sep 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgADX/3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1117C9A0;
	Wed, 25 Sep 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264261; cv=none; b=RkC1lESMEhW4rSvTcyT8QCRYLD16baXB2Ri0wgYsE6hHJiZE9juxic+5YYkQU4DmFN0hweKxi6/1KRuPxT5m7S5q8QRlFsYL9WNDNAa6wV2qy62r2S7fleBWUKRh6Hb7pcsuM26V37WBGTei4GS8wHAGyuDO3loTHDyMuYSP5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264261; c=relaxed/simple;
	bh=EBIc08FaFVIEOG6cieNJyeZgRfP2sXWFqNPIYGh9ocw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjXHP/KqvyL5rgqSIAW6IjHIEzxKjWS/UxzZ7IstB4jDZzftKYSrsKEci8zq9JN6dCbqzc8Mdb+ROOeB4VquIhacpUPJ2OPKVZI8OCh+ur1KqgzcEotfKnTLKyDn+CoZjLfUCkjh+LQ0sle2jq64OR1GBj9whRoZDF3BTjAJKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgADX/3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F51C4CEC7;
	Wed, 25 Sep 2024 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264261;
	bh=EBIc08FaFVIEOG6cieNJyeZgRfP2sXWFqNPIYGh9ocw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgADX/3mPh8OUUTYsISpnHC3BTDrGDZR1Lg3r6jx0TNlPmwsdx3/LwhaZyDe2iRPA
	 zTcR6wf0J4qRrmPuRmmKNAGfVke/ClHBxrSaPq7oGjs36IM2zL+iiM4lpVf9kR5NvG
	 TzHzyb/U4Rz0rcRCIY76KSg8dwmLHhrr4IWEgyOpdS8nCr+V+wOd2PKpC1t1lN4I22
	 /DYSvXRr0/PurhrRHUrGLVNpkqrVZBw7kP8BCf+Wx90yUkjRKOxuD8WTsokbeiFI1s
	 WUyUGAYCtOw57+d7fuXFHkPjqkeo9LOKxrkYEx+pvp2VpnGVoXe7E7wHdKBmTtOXJ5
	 QDh874V7jGeDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hilda Wu <hildawu@realtek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 026/244] Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0489:0xe122
Date: Wed, 25 Sep 2024 07:24:07 -0400
Message-ID: <20240925113641.1297102-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Hilda Wu <hildawu@realtek.com>

[ Upstream commit bdf9557f70e7512bb2f754abf90d9e9958745316 ]

Add the support ID (0x0489, 0xe122) to usb_device_id table for
Realtek RTL8852C.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e122 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
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

Signed-off-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 51d9d4532dda4..49111f2316a69 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -540,6 +540,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
-- 
2.43.0


