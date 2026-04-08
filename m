Return-Path: <stable+bounces-234605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDG7OI6g1mlDGwgAu9opvQ
	(envelope-from <stable+bounces-234605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:38:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0043C11FF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81ED4302BF65
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75C33B19A3;
	Wed,  8 Apr 2026 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xxnNbYGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644A35C1B2;
	Wed,  8 Apr 2026 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673292; cv=none; b=aO2fj1GhBJGZcwwwWIYtHgTjFEv8jday2LdCxT9SbiYmNeXsnF7OZHoa+51j6hfxkR2oGWIwR6wAo2wAn93YAHaYsa709qPIlQ88O7qpI7bm813RQu8n/v47sTNNVsTd71x9XPCle892VNR24w9DMKFN8NnP2TfSDs0Newv0o3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673292; c=relaxed/simple;
	bh=HiCeHIgUG7blIvh43P0irj100OFSBgxSWs+C8RX83EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwdnKWsS5O24fRD2BvqGS2wizLQgoyvq2VBO2q8f/ffUxhVGePJ43Axq3slj5KjS/L/lgp7ykDEqexTe5gZlBWukmi3KIdWEXkKAOWCPI0Tx6fRENO9ymasT9YLAa/F9Rr+ohyU9n+KYJ3N3VS3eBOZVzfalvR8pSTtWUxNAdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxnNbYGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01735C19421;
	Wed,  8 Apr 2026 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673292;
	bh=HiCeHIgUG7blIvh43P0irj100OFSBgxSWs+C8RX83EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xxnNbYGmo4b9XDYmBVnk4oXn3gw+XneVpBAHD3wYgXEO0uAd3XS5mVDkLGajw5ky/
	 hbZNZauO8jXJ8oTjix3mQ4QV7lm1+vvX1rhFnc2DwBpCqOOgbdQRrkc8Baw5MbMUpP
	 lMnNl1Hb4Jx8f+fthkVB6p30ANmdBeCxf5fRsjeQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengyu Qu <wiagn233@outlook.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.18 174/277] Input: xpad - add support for BETOP BTP-KP50B/C controllers wireless mode
Date: Wed,  8 Apr 2026 20:02:39 +0200
Message-ID: <20260408175940.363468165@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-234605-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2E0043C11FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengyu Qu <wiagn233@outlook.com>

commit 0d9363a764d9d601a05591f9695cea8b429e9be3 upstream.

BETOP's BTP-KP50B and BTP-KP50C controller's wireless dongles are both
working as standard Xbox 360 controllers. Add USB device IDs for them to
xpad driver.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Link: https://patch.msgid.link/TY4PR01MB14432B4B298EA186E5F86C46B9855A@TY4PR01MB14432.jpnprd01.prod.outlook.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/xpad.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -360,6 +360,8 @@ static const struct xpad_device {
 	{ 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
 	{ 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XBOX360 },
 	{ 0x20d6, 0x2001, "BDA Xbox Series X Wired Controller", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2009, "PowerA Enhanced Wired Controller for Xbox Series X|S", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2064, "PowerA Wired Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
@@ -562,6 +564,7 @@ static const struct usb_device_id xpad_t
 	XPAD_XBOX360_VENDOR(0x1a86),		/* Nanjing Qinheng Microelectronics (WCH) */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harmonix Rock Band guitar and drums */
 	XPAD_XBOX360_VENDOR(0x1ee9),		/* ZOTAC Technology Limited */
+	XPAD_XBOX360_VENDOR(0x20bc),		/* BETOP wireless dongles */
 	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA controllers */
 	XPAD_XBOXONE_VENDOR(0x20d6),		/* PowerA controllers */
 	XPAD_XBOX360_VENDOR(0x2345),		/* Machenike Controllers */



