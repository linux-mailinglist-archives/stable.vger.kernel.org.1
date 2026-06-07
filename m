Return-Path: <stable+bounces-261399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JGS8L1dJJWqaGAIAu9opvQ
	(envelope-from <stable+bounces-261399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:35:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF2B64FD20
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:35:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=JEh5ZVVp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261399-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261399-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC6333024451
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492022D3A69;
	Sun,  7 Jun 2026 10:33:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184626ED5D;
	Sun,  7 Jun 2026 10:33:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828400; cv=none; b=Z1RljOtvI8u46HXGPil6DRliEywPKqWhVDA+kqatNujiP8gT3GwxZZbnadQlKJZxtCFKrgdFS+cTJtUaEcGU+4s+fw+/IPvHKIzaAH7qW8T6sLq4aD8LOBDF4FmJ+98NkwY174ndFMrlfdhtHQo669ceO6H40z/GR9zUTAxRaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828400; c=relaxed/simple;
	bh=KiEk4GaVywkJr5Djzm6W01omN6o0LnRwCrw/w4tIYQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLUDWbN55moqgxc0Xfy/3xu1GGrLzEA/Ms3+vaAJ9W5blreYUPvY6DqWQOEZ5UmAxRtuXLz6T/IjN8h8ABYZAd7A2pkGLJE2S9Cj+4Mdv835b4TcQ9Oyg9DTgQ0uXL0Z3aFERaGfS2iXI9Bo+aHJhLj0RnxvPyco7DxrQFPMR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEh5ZVVp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C2D1F00893;
	Sun,  7 Jun 2026 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828398;
	bh=F96ov87pkOzKR0YXeQKGDGteawIHBFHeCWGm1bgOZ4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JEh5ZVVpbKs6o5QjJxPPdRG30z97IOS2k8nGpiyeMdh0djQZYrzFWYblbaJURPcry
	 MoErGmZwV8fK2JpVt7f0aQA2PQrspQydSfNS2njnfkxLAQWPbzjHIX4QYFFYLfm0+e
	 YnN7ATlDoV6DPKzfbRMmV1uKJ7D7DzmvCjCHZQNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.12 135/307] USB: serial: safe_serial: fix memory corruption with small endpoint
Date: Sun,  7 Jun 2026 11:58:52 +0200
Message-ID: <20260607095732.703802268@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261399-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johan@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DF2B64FD20

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 438061ed1ad85e6743e2dce826671772d81089ec upstream.

Make sure that the bulk-out buffer size is at least eight bytes to avoid
user-controlled slab corruption in "safe" mode should a malicious device
report a smaller size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/safe_serial.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/serial/safe_serial.c
+++ b/drivers/usb/serial/safe_serial.c
@@ -259,6 +259,7 @@ static int safe_prepare_write_buffer(str
 static int safe_startup(struct usb_serial *serial)
 {
 	struct usb_interface_descriptor	*desc;
+	int bulk_out_size;
 
 	if (serial->dev->descriptor.bDeviceClass != CDC_DEVICE_CLASS)
 		return -ENODEV;
@@ -279,6 +280,16 @@ static int safe_startup(struct usb_seria
 	default:
 		return -EINVAL;
 	}
+
+	/*
+	 * The bulk-out buffer needs to be large enough for the two-byte
+	 * trailer in safe mode, but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	bulk_out_size = serial->port[0]->bulk_out_size;
+	if (bulk_out_size > 0 && bulk_out_size < 8)
+		return -EINVAL;
+
 	return 0;
 }
 



