Return-Path: <stable+bounces-200229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36362CAA7C8
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 15:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4461630AB84A
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022EE19F40B;
	Sat,  6 Dec 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF23UqS/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADEE2FE575;
	Sat,  6 Dec 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029785; cv=none; b=W+ikFIYcOcbBN7WB2jteEEszlB54oMQjwZiYkPURR9MUKUnvogTMEGMQ/az7d6gi5myzA/gJb1iQXwa4UT5bRTnSsnA/i98xnxYbJDQTRsu/IwgCB3THBAQSS5+otXa1hOiD0yyy2FHGnze4P5SljkM51ZP0k5FrSMd7yEesQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029785; c=relaxed/simple;
	bh=acnhzokXQFTn9Unxjt4+V60Qfn9zz+tC2Hkix+piSbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE5i/9jFS1yCr2CmYbStD6LVHiTFTIRC9ySjTjX+AWauAx1lKx0kPvCzvd1Nb1kIFNg1Yq7AUMoBiqxS8W5mCH6lBBiT51tp3REYX7PbAPz66ozugtloYPw+on5sFCZesFzlSLSOGIbEzAVhBGYcYjyOwin+LBDSaaXaaG9n1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF23UqS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB79C4CEF5;
	Sat,  6 Dec 2025 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029785;
	bh=acnhzokXQFTn9Unxjt4+V60Qfn9zz+tC2Hkix+piSbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YF23UqS/o/kkbR3IElLE2ZQbKsXzlkfpXdtjitHWHgjAcqrFUhdyUPApl20p+jYkS
	 LdOYOHWuSwVg5s+izEETUuihLW7aiVuEfD8j1R2/cbp0A1DJXCMeJyleKNDHxfsats
	 3tff3UIiFxBHHBG490+wgqGaJOI9vyE2rBjxWaaGTvdBAQWYtlsIZz3hjRtfdVafDG
	 LLCwdi9//5vWcLa1RTJPxw/wds4Gz7INuDkDvRXq6iO+aBcKCIs+M0VjgKmx985uND
	 Z6GvmNnZSGoQY7aBeTLqeGHexFh7zWSo9ZrsiUfBk418Vf+bgxWYpqeLc/NYK61xoF
	 YHu60LiBJx9UQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Max Chou <max.chou@realtek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] Bluetooth: btusb: Add new VID/PID 0x0489/0xE12F for RTL8852BE-VT
Date: Sat,  6 Dec 2025 09:02:11 -0500
Message-ID: <20251206140252.645973-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206140252.645973-1-sashal@kernel.org>
References: <20251206140252.645973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Transfer-Encoding: 8bit

From: Max Chou <max.chou@realtek.com>

[ Upstream commit 32caa197b9b603e20f49fd3a0dffecd0cd620499 ]

Add the support ID(0x0489, 0xE12F) to usb_device_id table for
Realtek RTL8852BE-VT.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=04 Lev=02 Prnt=02 Port=05 Cnt=01 Dev#= 86 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e12f Rev= 0.00
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

Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:



 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bd26a8db64096..b92bfd131567e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -587,6 +587,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8852BT/8852BE-VT Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8520), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe12f), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8922AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
-- 
2.51.0


