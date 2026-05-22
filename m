Return-Path: <stable+bounces-253805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLHULgFsEGqgXAYAu9opvQ
	(envelope-from <stable+bounces-253805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:45:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF15B6690
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49490309153D
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EEC3CFF5A;
	Fri, 22 May 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmci/S5q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F09421F16;
	Fri, 22 May 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459752; cv=none; b=LsFoiJ/A15RIChmVPJd6nQ4SgFYwItfui6qrDwU8uejbMWPJ+T2A0Ek9vYMMwNCD+09o56pQBchTE5BZz5GgsKlz+dD+DP54+nmm0/7xcLf9wz4ymgFX5tEb/EpsxkKdWZQDBnWswdDXnTzsu1pO0ZGZmDUB1MGgOTT07LqvKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459752; c=relaxed/simple;
	bh=SmnPE+UUgKqkAGj5Fh4vh1PzGk9CDM/x9mSnHpezBMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJXno5Pv3Dk05jwvj2LLcgcqywS58vb6bTMmAiqiyZfzaIvG5k+Y+V3NeHxvtel1KrONeleTyzMdH/a1f2xq7tuc7kTQ2hch5IEra9ejfKyyQ/+KH9RP0m+IfSuGnfgF0Bo3DsG6RrDlbQpZNAEeDbEJeQU+AnpNH7w1KijGdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmci/S5q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247FF1F00A3D;
	Fri, 22 May 2026 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459743;
	bh=SOegj8RlYd8aMl5fWMItxIVNwvXG8Gl6pyLcTMwAtXo=;
	h=From:To:Cc:Subject:Date;
	b=Vmci/S5qS1Nv6tBRlfoxUjxTQZLlycIXd6yxB1llgeOd9oh1Z3vuzx6FUPbzafR2Y
	 ZDYyFqpIoeOt/0WmTjkpTEqSbaD/pr2S0Yk3l3e4zpbvpAHWnrBOjm3dDWROO8Mvv1
	 ztE87WxduvtYvnRwDbDa2sBpJmj0mzEsB+bNb+43672CtAAgmBkzPKtsfgD55SaBNP
	 B40f1uDHlgV0oZhNpeelk94FZTUN3ag8kv4suxYyNRpRXEeTGaGfLuakApq0iowFgG
	 mtUncK5FZ7d4VsduaLFwrj5gO0RmoivOZkcn4JGCpR9Lbbpstl6q1fnZnIUh78PSaV
	 esGNT07jSJThQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wQQlZ-00000003yX4-07F8;
	Fri, 22 May 2026 16:22:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: safe_serial: fix memory corruption with small endpoint
Date: Fri, 22 May 2026 16:22:18 +0200
Message-ID: <20260522142218.947657-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253805-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1FDF15B6690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure that the bulk-out buffer size is at least eight bytes to avoid
user-controlled slab corruption in "safe" mode should a malicious device
report a smaller size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/safe_serial.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/serial/safe_serial.c b/drivers/usb/serial/safe_serial.c
index 238b54993446..d267a31dcccf 100644
--- a/drivers/usb/serial/safe_serial.c
+++ b/drivers/usb/serial/safe_serial.c
@@ -259,6 +259,7 @@ static int safe_prepare_write_buffer(struct usb_serial_port *port,
 static int safe_startup(struct usb_serial *serial)
 {
 	struct usb_interface_descriptor	*desc;
+	int bulk_out_size;
 
 	if (serial->dev->descriptor.bDeviceClass != CDC_DEVICE_CLASS)
 		return -ENODEV;
@@ -279,6 +280,16 @@ static int safe_startup(struct usb_serial *serial)
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
 
-- 
2.53.0


