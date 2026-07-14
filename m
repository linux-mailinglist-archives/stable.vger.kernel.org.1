Return-Path: <stable+bounces-274244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fo9QMZs6Vmpl1wAAu9opvQ
	(envelope-from <stable+bounces-274244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:33:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 153717552E1
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:33:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jOMuuEAE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274244-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274244-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC61A3152ECA
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD234752B;
	Tue, 14 Jul 2026 13:27:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914F29D270
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:27:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035624; cv=none; b=OC9xEghGmW7UmoWVGmw9ICA4l7xiDZZDOhwfYgeRWfDfZdjTP8d7zoZX3fsvw1MVpcrvQ6afCQ49pOgxqEN8wAoAOVssf1k1hOKEOVsiLYZzlx2TiYq7VUuyoi0oR/yVCbnR3eDbXojHQtfA5JyOfmvtT82VfisWCmAwbNihKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035624; c=relaxed/simple;
	bh=DDg+t5cm11rzsXQUBMNg+Rt7FRuBbv5HIyPlil+C2E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPkRQjIdoAEnfIp9H5bRuuLSpXg1eKDEwzg7XMcGcuPsYm1LXOOM3FDWG22Vac3D/TY9ZJIR4Ujq08Rpxmszph2KRY+qrZ/mrFGZBGulORBzHEMahECCC5tvZhT7uoxQHgfdsJ+q29ELEqnTy2iWiZxQx9/VCEeVP5FCeX2XnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOMuuEAE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32031F00ADF;
	Tue, 14 Jul 2026 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035622;
	bh=4m/yWmySOxM7X740O+/R1gX6GATgiWZ+QPcVVK261P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jOMuuEAEHKAX7nUjHnNYl99g5l4X+kseJnCrHJbsds3EsyjrczV4jA2FItJGlAe/i
	 1WavexR2CEr4bm8vvtjrax8Vnm7/nMs18dy48sQiMIaO8W9w/tFmHiM/v6F15S5xXk
	 L8W95c/Bi6tlmmzOIj6LUo+8Ay/5j7R1Qzmva7hen25X1NdZoVkIOd55RPfrbjmDrV
	 VrBX1hZKiV6IXVSU3iapLT6Ry5ESOSuO24d0DdTUsFoJ0b9xh+D4Drd4n814J0mmay
	 7vsO03YNY68RsTsBFgvECsHSlOeNDtSo9RLrSftfWQPta5xr3XymMKj+XuLtrwG5KJ
	 cPcJeeiFibeTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] Bluetooth: btusb: fix use-after-free on marvell probe failure
Date: Tue, 14 Jul 2026 09:26:56 -0400
Message-ID: <20260714132657.2663805-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714132657.2663805-1-sashal@kernel.org>
References: <2026071341-glamorous-shower-90f7@gregkh>
 <20260714132657.2663805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274244-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:johan@kernel.org,m:rajatja@google.com,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 153717552E1

From: Johan Hovold <johan@kernel.org>

[ Upstream commit c5b600a3c05b1a7a110d558df935a8fc8a471c79 ]

Make sure to stop any TX URBs submitted during Marvell OOB wakeup
configuration on later probe failures to avoid use-after-free in the
completion callback.

This issue was reported by Sashiko while reviewing a fix for a wakeup
source leak in the btusb probe errors paths.

Link: https://sashiko.dev/#/patchset/20260402092704.2346710-1-johan%40kernel.org
Fixes: a4ccc9e33d2f ("Bluetooth: btusb: Configure Marvell to use one of the pins for oob wakeup")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 3d93e1bb0fb8 ("Bluetooth: btusb: fix wakeup source leak on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 620dc80992b727..6d32e48418da78 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4352,7 +4352,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_set_interface(data->udev, 0, 0);
 		if (err < 0) {
 			BT_ERR("failed to set interface 0, alt 0 %d", err);
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 		}
 	}
 
@@ -4360,7 +4360,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_driver_claim_interface(&btusb_driver,
 						 data->isoc, data);
 		if (err < 0)
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4391,6 +4391,8 @@ static int btusb_probe(struct usb_interface *intf,
 		usb_set_intfdata(data->isoc, NULL);
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 	}
+err_kill_tx_urbs:
+	usb_kill_anchored_urbs(&data->tx_anchor);
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
-- 
2.53.0


