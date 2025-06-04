Return-Path: <stable+bounces-150895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A5ACD208
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567D53A847F
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07901DE2BC;
	Wed,  4 Jun 2025 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAo+yf4k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2444A2D;
	Wed,  4 Jun 2025 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998541; cv=none; b=dyxrFESHBtyr1jcjiXHv3zEm6l1hBzf9rxA+ZK9fLA0KrYqE5jQuerMrP4jc+u7YbuAg1hPnZBE5vZKSD/k/Q1RKoxhxu8+FJQcZmvCelMK8OtrcMVFFSujGnuC6t/T0xQ6xZATDJv3mKecYqtBfjlG44VJHKNOHR2tAmlEK9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998541; c=relaxed/simple;
	bh=s+kccaFySQTv4dX2KEsncq8P9jbYWjo0NP++dg4HWh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2buxQPPEASHQrNHJfXlM9T7M9/W9KteU6sCnm4S5jnJqciUvfe9FhNTdWa1r91UMwGU911jXlzWZ9hxaW8vqm7vaKC107S2fpZys4K495mjI1aD88OSdmSTfMDQQSWiOR3oJpicL1DvGBniMm9EkDLafkjPwPc0D20Kw18LVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAo+yf4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C27C4CEED;
	Wed,  4 Jun 2025 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998541;
	bh=s+kccaFySQTv4dX2KEsncq8P9jbYWjo0NP++dg4HWh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAo+yf4kQSsPx0kMQQ0VdUf9IQoyl26iN4CjM4sVj2D04+8XTyAZzIxNT9Ns+KIja
	 rzKplV5eZijkEYerSCvo5OgZR1H+TOW9m0PBH7Ko/7Aj43aaVZL/rk2iYOHxUnr9zG
	 hWkGrgHzzzZROtk2Wi0l2d6rrtGOhAeZq4g2HhmhnAnp0CflHfEFs68/Yhzylqx48c
	 AXddMSkIRdukOf2bBu6/vQxlzBzsMwn/nSIbpq3QAF5vCQlFkG3JN09kJtlxQfmCI+
	 NZVPAWEFBiM2rOBZhdjonFrzihXo2+gtA11SzRGuS7X+iRqCqN2fAaTAs9hWOGSFfL
	 +SCNt8ZGtEf8Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Liwei Sun <sunliweis@126.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 006/108] Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
Date: Tue,  3 Jun 2025 20:53:49 -0400
Message-Id: <20250604005531.4178547-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Liwei Sun <sunliweis@126.com>

[ Upstream commit 71d9d3522aec301e4a1c4eae4b5e0656fc4a7262 ]

A new variant of MT7922 wireless device has been identified.
The device introduces itself as MEDIATEK MT7922,
so treat it as MediaTek device.
With this patch, btusb driver works as expected:
[    3.151162] Bluetooth: Core ver 2.22
[    3.151185] Bluetooth: HCI device and connection manager initialized
[    3.151189] Bluetooth: HCI socket layer initialized
[    3.151191] Bluetooth: L2CAP socket layer initialized
[    3.151194] Bluetooth: SCO socket layer initialized
[    3.295718] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
[    4.676634] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.676637] Bluetooth: BNEP filters: protocol multicast
[    4.676640] Bluetooth: BNEP socket layer initialized
[    5.560453] Bluetooth: hci0: Device setup in 2320660 usecs
[    5.560457] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[    5.619197] Bluetooth: hci0: AOSP extensions version v1.00
[    5.619204] Bluetooth: hci0: AOSP quality report is supported
[    5.619301] Bluetooth: MGMT ver 1.23
[    6.741247] Bluetooth: RFCOMM TTY layer initialized
[    6.741258] Bluetooth: RFCOMM socket layer initialized
[    6.741261] Bluetooth: RFCOMM ver 1.11

lspci output:
04:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter

USB information:
T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3584 Rev= 1.00
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

Signed-off-by: Liwei Sun <sunliweis@126.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Analysis ### Commit Assessment: 1. **Bug Fix Nature**: This commit fixes
a user-facing issue where the MediaTek MT7922 Bluetooth device with
VID/PID 13d3:3584 was not recognized by the btusb driver. Without this
fix, users with this specific hardware variant would have non-functional
Bluetooth. 2. **Code Changes**: The change is minimal and extremely
safe: - Adds a single line: `{ USB_DEVICE(0x13d3, 0x3584), .driver_info
= BTUSB_MEDIATEK | BTUSB_WIDEBAND_SPEECH }` - This is purely additive -
it only adds device recognition without modifying any existing
functionality - Uses existing, well-tested driver flags (`BTUSB_MEDIATEK
| BTUSB_WIDEBAND_SPEECH`) that are already used for other MT7922
variants 3. **Historical Pattern**: Based on the similar commits
provided and git history analysis: - All 4 similar commits (adding
MT7922/MT7925 VID/PIDs) were marked as "Backport Status: YES" - Multiple
similar MT7922 VID/PID additions have been backported to stable kernels
(confirmed by git tag analysis showing commits like bf809efdcc4d
appearing in v6.10.x stable releases) - The pattern shows these hardware
enablement patches are consistently considered appropriate for stable
backports 4. **Risk Assessment**: - **Minimal Risk**: Only affects
systems with this specific USB device (VID 13d3, PID 3584) - **No
Behavioral Changes**: Doesn't modify any existing code paths or
algorithms - **Self-Contained**: Single device ID addition with proven
driver flags - **No Side Effects**: Cannot impact other hardware or
break existing functionality 5. **User Impact**: - **Immediate
Benefit**: Users with this MT7922 variant get working Bluetooth
functionality - **Hardware Support**: Essential for device recognition
on newer hardware that might ship with this specific variant - **No
Downside**: Zero impact on users without this hardware 6. **Stable Tree
Criteria Compliance**: - ✅ Fixes important user-facing issue (non-
working Bluetooth hardware) - ✅ Small, contained change - ✅ No
architectural modifications - ✅ Uses existing, stable code paths - ✅
Follows established pattern of similar backported commits The commit is
a textbook example of a stable-appropriate hardware enablement fix -
minimal risk, clear user benefit, and consistent with established
backport patterns for MediaTek Bluetooth device additions.

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b15f3ed767c53..61d5e0d165bcd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -678,6 +678,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3584), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3605), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3607), .driver_info = BTUSB_MEDIATEK |
-- 
2.39.5


