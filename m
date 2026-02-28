Return-Path: <stable+bounces-220397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEdhJBlIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B001C1C7893
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7998311F43B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA6480964;
	Sat, 28 Feb 2026 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6RmttdN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9FF3AB45D;
	Sat, 28 Feb 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300289; cv=none; b=ezjSAoCycPOa/rp6/rol5KHh/i+UDYB9khlp4F1GYsdUl/xRBJslqS4DeIW7NUKYpQgJ5X6lCmE0dnoZkt6BCb8meG7HwNnJxRLMcGeWByL0yMeB7+58XaRwOzyghzWCmEaNjRY7wezIfGOZ6vveXIn+znkHiVMoux5HG1qQi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300289; c=relaxed/simple;
	bh=eRepZaOczSFY2csbs4wBiKgRnSPTFjNzmPSi9otYBP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dsd+6IXkk9ev56hQI3VnBYbtiYNdeMBanusVPH6/Lp8W7JqJB9xEBmC5CVhBdeVVxeJeysAqPAeNoTHlUoUZZxyit5dmv0iGow2GhkBhYMtvdvWTbir6aaqOPljFQE4SBVATv5rL04VWIo5s6EyeyH9OWJZyu2p3H9Otq663jN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6RmttdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0045DC19423;
	Sat, 28 Feb 2026 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300289;
	bh=eRepZaOczSFY2csbs4wBiKgRnSPTFjNzmPSi9otYBP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6RmttdN08BWSBJSNymbVQDKWP2+3lO8U7c/R5uIQQvJNdSh41APDAW35BIt7UB0G
	 LjoCV/Ni0aQdXMo29NCpA8uK4d5C3fV1PjbmB1Lb8TJ2qzNsbMOdSxjzvMx195u/qI
	 q7P/Yp0eL5pZzKJJhaY1KEXA0NnQON5vno/0bfQubunFPqZYZGnknIYwzG7dYeDki+
	 qVKSLFY/JPLyXmZumiqSe4P7Kcy5MhJm3P4dW7Otth2z0tXl4vfoyjEkbnTSnRnfxx
	 /carbagUWThn4Hyn8CV8/zbAqQRFBj9G89C2SOjq0ySiO9TWXwgDxQ/zotdfwEr1k3
	 a+iG+PQDQmjAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Techie Ernie <techieernie@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 318/844] Bluetooth: btusb: Add USB ID 0489:e112 for Realtek 8851BE
Date: Sat, 28 Feb 2026 12:23:51 -0500
Message-ID: <20260228173244.1509663-319-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220397-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B001C1C7893
X-Rspamd-Action: no action

From: Techie Ernie <techieernie@gmail.com>

[ Upstream commit e07094a51ad8faf98ea64320799ce550828e97cd ]

Add USB ID 0489:e112 for the Realtek 8851BE Bluetooth adapter.
Without this entry, the device is not handled correctly by btusb and Bluetooth fails to initialise.
Adding the ID enables proper Realtek initialization for Bluetooth to work on various motherboards using this Bluetooth adapter.

The device identifies as:
  Bus 001 Device XXX: ID 0489:e112 Foxconn / Hon Hai Bluetooth Radio

Tested on Realtek 8851BE. Bluetooth works after this change is made.

Signed-off-by: Techie Ernie <techieernie@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ef08567a7487c..66e266e93cc12 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -521,6 +521,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
-- 
2.51.0


