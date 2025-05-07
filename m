Return-Path: <stable+bounces-142277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C3AAE9E8
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F9B1C423FE
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666812144CC;
	Wed,  7 May 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U3xBLone"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238AF1DDC23;
	Wed,  7 May 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643760; cv=none; b=IDWi01P/C/ItoI4Q29PbZRwAOpOUQLyRZ6SiEyWWYrQzxw93zqTmB8XsK26ab3A96lyHAG1GPKzombiXGM2TvmsyFZq+t5/AtGvN+oKaYCz7qxAdY9Xh/ztry2Ec7+Ctv/9IfuwKHcXp5tNvIKxeSOQmcYMM3UCVtse5KGjpJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643760; c=relaxed/simple;
	bh=U2S4aeme5OAJi5ei4hlgu1MYuzxusRwsqSkgBA9dRbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqgqI85T3Vm0THXZ8a8fztzf4EqHh7rU6ltzVNTgZm/qQ4eZcsrZpqtE2/sTsWH5p1sdW2A2vZSIQG4v/+opzk9K8nwFC0TwYQTP1hIviqpprDrq/mK5djlHXbbkqZMBNftfGF5em8TO7gMSfvE7zlyUnNXnJRF6uSCUM9L4bOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U3xBLone; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13BBC4CEE2;
	Wed,  7 May 2025 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643760;
	bh=U2S4aeme5OAJi5ei4hlgu1MYuzxusRwsqSkgBA9dRbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3xBLonekqZamjuVd9qM/lubxyrbqPEjw03eKRCk07Dr7r+rWak62c70SQR84s8nq
	 xg9cew7Y6cieBRk/Z8TkEh0bOBj0X85F0b90Z+Xih/nD0MRXVX6I0sSJ9ENbJvPmjL
	 DAQ/a4prTocgsuzn+oOPWisZqUNEl14sox/Ywun8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lubomir Rintel <lkundrak@v3.sk>,
	Christian Heusel <christian@heusel.eu>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.14 001/183] Revert "rndis_host: Flag RNDIS modems as WWAN devices"
Date: Wed,  7 May 2025 20:37:26 +0200
Message-ID: <20250507183824.744350503@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Heusel <christian@heusel.eu>

commit 765f253e28909f161b0211f85cf0431cfee7d6df upstream.

This reverts commit 67d1a8956d2d62fe6b4c13ebabb57806098511d8. Since this
commit has been proven to be problematic for the setup of USB-tethered
ethernet connections and the related breakage is very noticeable for
users it should be reverted until a fixed version of the change can be
rolled out.

Closes: https://lore.kernel.org/all/e0df2d85-1296-4317-b717-bd757e3ab928@heusel.eu/
Link: https://chaos.social/@gromit/114377862699921553
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220002
Link: https://bugs.gentoo.org/953555
Link: https://bbs.archlinux.org/viewtopic.php?id=304892
Cc: stable@vger.kernel.org
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Christian Heusel <christian@heusel.eu>
Link: https://patch.msgid.link/20250424-usb-tethering-fix-v1-1-b65cf97c740e@heusel.eu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/rndis_host.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -630,16 +630,6 @@ static const struct driver_info	zte_rndi
 	.tx_fixup =	rndis_tx_fixup,
 };
 
-static const struct driver_info	wwan_rndis_info = {
-	.description =	"Mobile Broadband RNDIS device",
-	.flags =	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
-	.bind =		rndis_bind,
-	.unbind =	rndis_unbind,
-	.status =	rndis_status,
-	.rx_fixup =	rndis_rx_fixup,
-	.tx_fixup =	rndis_tx_fixup,
-};
-
 /*-------------------------------------------------------------------------*/
 
 static const struct usb_device_id	products [] = {
@@ -676,11 +666,9 @@ static const struct usb_device_id	produc
 	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
 	.driver_info = (unsigned long) &rndis_info,
 }, {
-	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
-	 * Telit FN990A (RNDIS)
-	 */
+	/* Novatel Verizon USB730L */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
-	.driver_info = (unsigned long)&wwan_rndis_info,
+	.driver_info = (unsigned long) &rndis_info,
 },
 	{ },		// END
 };



