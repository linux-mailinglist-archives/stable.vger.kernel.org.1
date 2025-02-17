Return-Path: <stable+bounces-115212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7BA34272
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D893A9B29
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C8A2222AC;
	Thu, 13 Feb 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fofmoMgs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73DC281341;
	Thu, 13 Feb 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457271; cv=none; b=Q+JU2My4zhlfD9b+rhE9IozmufAmAH/CTOuzZNM7GLHg/78w5A9tedccbkmkvhpuNFOm2R25T9fHVVUj6/GM4frlDt/40Pi7k19UCMpa9gIGotP1AI+HBavVT/erSq5MX3ij2xn5zIyF1PSJVH2skn0At9Rnnd8t8qREQeIjF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457271; c=relaxed/simple;
	bh=W+jx9K1IubQWgyqCBjI7T5Ur16+9B3XKxJJiJ1OYFuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWTAiEprZvFg6cWmulC2qPE5Q9uC2Y3wz8TbGOFw/5Ytz3jZHK4NWN3e8eomm/Istfgh+UQ6edpqRuuTz8b1fL6JiAXhMa/LcPaC4PQSSYBTh6J1apcXoh/xsZak4QjoqC22lUzB8zXTwQbCTwbcRmOn7KV9relJcZfUeITWZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fofmoMgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C622C4CEE2;
	Thu, 13 Feb 2025 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457271;
	bh=W+jx9K1IubQWgyqCBjI7T5Ur16+9B3XKxJJiJ1OYFuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fofmoMgsIEMMUW1Op9nr75yVCcWSjeqM2EUnBUEVM4n1vktKY/+K1yFDOaRtP+q/h
	 qGV7DYhjxzezw+4BXu7spmA/9vTb5dXyyGmRjaMVRCgujx+d1/CTQ1ZxSxRuzgK5QK
	 PVuoFxeNISrOGd2kkjjkUqCKn+syeDAhxC0IsJoo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Halaney <ajhalaney@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 065/422] Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922
Date: Thu, 13 Feb 2025 15:23:34 +0100
Message-ID: <20250213142439.069327971@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Halaney <ajhalaney@gmail.com>

[ Upstream commit 45e7d389bf2e52dfc893779c611dd5cff461b590 ]

A new machine has a Archer AX3000 / TX55e in it,
and out the box reported issues resetting hci0. It looks like
this is a MT7922 from the lspci output, so treat it as a MediaTek
device and use the proper callbacks. With that in place an xbox
controller can be used without issue as seen below:

    [    7.047388] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
    [    9.583883] Bluetooth: hci0: Device setup in 2582842 usecs
    [    9.583895] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
    [    9.644780] Bluetooth: hci0: AOSP extensions version v1.00
    [    9.644784] Bluetooth: hci0: AOSP quality report is supported
    [  876.379876] input: Xbox Wireless Controller as /devices/virtual/misc/uhid/0005:045E:0B13.0006/input/input27
    [  876.380215] hid-generic 0005:045E:0B13.0006: input,hidraw3: BLUETOOTH HID v5.15 Gamepad [Xbox Wireless Controller] on c0:bf:be:27:de:f7
    [  876.429368] input: Xbox Wireless Controller as /devices/virtual/misc/uhid/0005:045E:0B13.0006/input/input28
    [  876.429423] microsoft 0005:045E:0B13.0006: input,hidraw3: BLUETOOTH HID v5.15 Gamepad [Xbox Wireless Controller] on c0:bf:be:27:de:f7

lspci output:

    root@livingroom:/home/ajhalaney/git# lspci
    ...
    05:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter

and USB device:

    root@livingroom:/home/ajhalaney/git# cat /sys/kernel/debug/usb/devices
    ...
    T:  Bus=01 Lev=01 Prnt=01 Port=10 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
    D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=13d3 ProdID=3610 Rev= 1.00
    S:  Manufacturer=MediaTek Inc.
    S:  Product=Wireless_Device
    S:  SerialNumber=000000000
    C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
    A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
    I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
    E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
    I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
    I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
    E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
    I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
    E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Andrew Halaney <ajhalaney@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 258a5cb6f27af..a5dec56de893d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -604,6 +604,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3610), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* MediaTek MT7922A Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe0d8), .driver_info = BTUSB_MEDIATEK |
-- 
2.39.5




