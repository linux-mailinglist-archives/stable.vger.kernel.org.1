Return-Path: <stable+bounces-130320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCFBA80424
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4EA466176
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE0268FDB;
	Tue,  8 Apr 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufoHgesK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872B267F6E;
	Tue,  8 Apr 2025 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113404; cv=none; b=s+xwYIV4xy78oK+CAo60wtTJg2ieoWcKq9nCmnZ0x3j98f4i14IrlZp9zvUgVg/TNHkq4oy/KK4tUVbcFuq5mtuccfTPFxWrMlLekBua77IBh8MRQw8NVCkn5PB0YYnQ0X7MY+jgcjdZEZVLHWyTUPYRtD02nxBMTkQ/zEeRJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113404; c=relaxed/simple;
	bh=nh+qVWbdCmVkP/HZwM5y2w86G1g9ucZvUHTQPc7e8OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilWPikvVgMwTeHf2abO3yB7UYw3EvJQH7uoH0PzKYf4b0XGYtKqrzBTpt7shwpH4wNInZnP8Zl69M/WaPRvnvW6tOWv3iGZK+p7xW7CMAyDBR+O0oYUyfDLrnlML7NxPLJdmgMwNaexGA7mWb/X1DbWnTc9U38tjZuH/a4CpsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufoHgesK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48691C4CEE5;
	Tue,  8 Apr 2025 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113404;
	bh=nh+qVWbdCmVkP/HZwM5y2w86G1g9ucZvUHTQPc7e8OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufoHgesKKYasJqyiwTL3JqXoip4/qF+yA+0rswmmiQ/x02kwnb0N5UHNNHXbLk6cE
	 MbGZRqSrdFJKvkQJMrT63LiGIem9t0gST4ebn/HG8xdlRN7giK3e4Po98Q5DHU8tsy
	 uAZIgCiBRdPZ6Jlgmn88cvkIQSP/InMbmz+Tk+VA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lubomir Rintel <lkundrak@v3.sk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 146/268] rndis_host: Flag RNDIS modems as WWAN devices
Date: Tue,  8 Apr 2025 12:49:17 +0200
Message-ID: <20250408104832.470117194@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
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

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit 67d1a8956d2d62fe6b4c13ebabb57806098511d8 ]

Set FLAG_WWAN instead of FLAG_ETHERNET for RNDIS interfaces on Mobile
Broadband Modems, as opposed to regular Ethernet adapters.

Otherwise NetworkManager gets confused, misjudges the device type,
and wouldn't know it should connect a modem to get the device to work.
What would be the result depends on ModemManager version -- older
ModemManager would end up disconnecting a device after an unsuccessful
probe attempt (if it connected without needing to unlock a SIM), while
a newer one might spawn a separate PPP connection over a tty interface
instead, resulting in a general confusion and no end of chaos.

The only way to get this work reliably is to fix the device type
and have good enough version ModemManager (or equivalent).

Fixes: 63ba395cd7a5 ("rndis_host: support Novatel Verizon USB730L")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Link: https://patch.msgid.link/20250325095842.1567999-1-lkundrak@v3.sk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/rndis_host.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29c8f7..bb0bf14158727 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -630,6 +630,16 @@ static const struct driver_info	zte_rndis_info = {
 	.tx_fixup =	rndis_tx_fixup,
 };
 
+static const struct driver_info	wwan_rndis_info = {
+	.description =	"Mobile Broadband RNDIS device",
+	.flags =	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
+	.bind =		rndis_bind,
+	.unbind =	rndis_unbind,
+	.status =	rndis_status,
+	.rx_fixup =	rndis_rx_fixup,
+	.tx_fixup =	rndis_tx_fixup,
+};
+
 /*-------------------------------------------------------------------------*/
 
 static const struct usb_device_id	products [] = {
@@ -666,9 +676,11 @@ static const struct usb_device_id	products [] = {
 	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
 	.driver_info = (unsigned long) &rndis_info,
 }, {
-	/* Novatel Verizon USB730L */
+	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
+	 * Telit FN990A (RNDIS)
+	 */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
-	.driver_info = (unsigned long) &rndis_info,
+	.driver_info = (unsigned long)&wwan_rndis_info,
 },
 	{ },		// END
 };
-- 
2.39.5




