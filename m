Return-Path: <stable+bounces-61390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682C693C232
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EC2B21389
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F461741F8;
	Thu, 25 Jul 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7Sv4iaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA526281
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911161; cv=none; b=sEhRoqghL/6cfghFmpx2tJLupg0h51/z1Jwa9TxM8WYait3WxJRMfxLk1zNBwISDBBKsB3HmEnYdAsRzhUvucBkvldzIgmOIWpU5R/yKIF7of6XOJDl94/+dJwVvecrf/OB24sZtKoVcDLckh7CMyfBZbNCe9mAKzbeov69vCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911161; c=relaxed/simple;
	bh=DvKogVU3C3cS+8vntqCiqj/wkIiIc0TP2bvjDfOTp6A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e6RcgJcZndwwBRNE1vm9hznZF4XFUV3a0jGocUccDtFiblNW0B+jFyZ0X28skroUtPmrC6h1RNa/uFrkfmYcLQ6DhoE+P7OypzMuM9u2LpqPVrnEJK4wycqBSZb2Sgb8FfQrw6YEKqFmi1fpIW0VUTNpV559bUS/viQD9diOT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7Sv4iaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC76DC116B1;
	Thu, 25 Jul 2024 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911161;
	bh=DvKogVU3C3cS+8vntqCiqj/wkIiIc0TP2bvjDfOTp6A=;
	h=Subject:To:Cc:From:Date:From;
	b=W7Sv4iaqnUC6i6KPiItCZUWeNStP3ce7MtXlpFpYBf9bODXYRsC/6+9m+qx2t9AQe
	 ArlYads0BgOuniXZHvP3cskShha35sbV46MS7as2dTcaKzqDAL8411uRuq6IDuAva3
	 /vn7UkTuHxQUnvZw6hSJJPelIVIjcMFZe7tlDj58=
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: Add Realtek RTL8852BE support ID" failed to apply to 5.15-stable tree
To: wangyuli@uniontech.com,guanwentao@uniontech.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:39:08 +0200
Message-ID: <2024072507-corridor-graceful-9eac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 473a89b4ed7fd52a419340f7c540d5c8fc96fc75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072507-corridor-graceful-9eac@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

473a89b4ed7f ("Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591")
295ef07a9dae ("Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables")
3600860a7193 ("Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio")
069f534247bb ("bluetooth: Add device 13d3:3571 to device tables")
730a1d1a93a3 ("bluetooth: Add device 0bda:887b to device tables")
393b4916b7b5 ("Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 473a89b4ed7fd52a419340f7c540d5c8fc96fc75 Mon Sep 17 00:00:00 2001
From: WangYuli <wangyuli@uniontech.com>
Date: Sat, 22 Jun 2024 12:09:59 +0800
Subject: [PATCH] Bluetooth: btusb: Add Realtek RTL8852BE support ID
 0x13d3:0x3591

Add the support ID(0x13d3, 0x3591) to usb_device_id table for
Realtek RTL8852BE.

The device table is as follows:

T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  5 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3591 Rev= 0.00
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

Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2d7d47f9d007..2d5c971a59ad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -555,6 +555,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3572), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 


