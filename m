Return-Path: <stable+bounces-174258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B7B36259
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F7F8A55AA
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E6268C40;
	Tue, 26 Aug 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ocV6pu3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C81B85F8;
	Tue, 26 Aug 2025 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213911; cv=none; b=GoxznQSqH/U9mpulmxsuKDVQXtWsiYzo1J0kO13ASLB5JZodMrhQfUI0nLr/6yPLyLZu92Xcf9d5eiPmyburAWLOe2nC/M+9nbE1urwqALMOWnp+f0p6Ag7+o102OlY/gOVYEjUJ6+ZDKP4uES5fSdhqdH5RayVMlS2lxjdWa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213911; c=relaxed/simple;
	bh=OMoamD2RZGbFWXOWrJo8vyke3r7l30a0QH/kPTBUr2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji6xKqM/NHoWe+4eGNY3phlJlgb2S8E0rVNhLW4kLHAhTXnkwJ5LRuzngcDJQAF1VZk7/hJ1hFtv53ovGz1lUROn59CxFajIfvgATSK/LjClaSZszHz8bOCi6lqZVxR+3wDc7JVtPofDP+WldfaGmihf4FRF3bFfh6mhUUddqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ocV6pu3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F4AC4CEF1;
	Tue, 26 Aug 2025 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213911;
	bh=OMoamD2RZGbFWXOWrJo8vyke3r7l30a0QH/kPTBUr2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocV6pu3MNd6F+UFgE6lLvm+cStDaheSDGMRO0ZKdx2J1omgvLpU+mSz+1jL2JTMBl
	 V/d++kTVcbsRe4btxUmqPUpvAMgLqEQ7hji11E0aYA1GbDrLZosbr5oef4xXjtV1Q6
	 GbFh57NuSfP9M6Iu0u9gv2M+o8c2ORVl3xdhPu0s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Zenm Chen <zenmchen@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.6 527/587] USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles
Date: Tue, 26 Aug 2025 13:11:16 +0200
Message-ID: <20250826111006.407710680@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zenm Chen <zenmchen@gmail.com>

commit a3dc32c635bae0ae569f489e00de0e8f015bfc25 upstream.

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

Cc: stable <stable@kernel.org>
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20250813162415.2630-1-zenmchen@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/unusual_devs.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1501,6 +1501,28 @@ UNUSUAL_DEV( 0x0bc2, 0x3332, 0x0000, 0x9
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



