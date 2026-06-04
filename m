Return-Path: <stable+bounces-260472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id umT4BilsIWreGAEAu9opvQ
	(envelope-from <stable+bounces-260472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 14:14:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9807B63FC44
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 14:14:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B4t8zSZC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260472-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260472-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68A0630300F9
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8659442B721;
	Thu,  4 Jun 2026 12:08:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3892F8EB0
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:08:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574897; cv=none; b=FzzWp9k73kK41mRCj03E2RdW5gN8cmcaJzMfMRV1ai4YH6GPSdEFdZxCuBO3OtfWn9N6d37UMoc8Hog0hJ0F4iXTZ9oD8Z4X2pmCn8WT0PlcUqekBGNlb98dbwsGiLj6vKB5VbfWSDPCocG4hpRgF2wtBjplIoiEQ787j+/4knY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574897; c=relaxed/simple;
	bh=pDej9qiEtSkG5xwS6uiPaMxwYSALQKyH9//LqwM3QB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5gdYob7ThKazYGwdwqZQQYi2rnUJ+oyVjfryMprLARY4LCHGCh9VdzJe/IPMNBihdcEpwYtutn8L17pq1Z1PAgpZ3An7SP3bKOWeKlEfrpXfbpH6D0xoaFk8BcDPEyp32TyCKdV7a5KoOpL3UjUJYg16/sn8WndNf2ri3A2RxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4t8zSZC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73231F00893;
	Thu,  4 Jun 2026 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780574894;
	bh=bttJQ/T7q6CE6YSIUvI5QDYmuQ1kkigPxkyJGMeflHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4t8zSZCCDHySIHsPFAfMBjpqeA0Riz3Cy0xX4bZ6I+9Pd4cVjiuoNe6biGxknlgs
	 D/Aa/YkibrAaISHdD0MDqsX+FT9PsjZPe7JY+54dsIyamR4JYDG5nuGBflslDwpfgA
	 7Qttnj60T5Ce/PyPBS1MrhxNezxDbEe8YsUyaRtZYHtcH66MhIUch8viAPS8SqRyeW
	 DxyUqY2f6w93J/Xr1KHCqnk0Xcnq/hf5hkeYgrSZYYASfQJ9waRC0Zl4I3/q6xEqvM
	 Z4V7uVyoXml/NQSgJKqI6fQ1DTq5Q4Oz3Ux9l1cV4urYPYyOW8gCN7623YjHp7l3AL
	 w/U/qFsyeAZbg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV6rs-0000000BcMy-3Crg;
	Thu, 04 Jun 2026 14:08:12 +0200
From: Johan Hovold <johan@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18.y] USB: serial: digi_acceleport: fix memory corruption with small endpoints
Date: Thu,  4 Jun 2026 14:07:58 +0200
Message-ID: <20260604120758.2769085-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060427-gossip-stony-dea7@gregkh>
References: <2026060427-gossip-stony-dea7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260472-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:johan@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9807B63FC44

commit cb3560e8eab1dfa1cac1ed52631adf8ec6ff2cd5 upstream.

Add the missing bulk-out buffer size sanity checks to avoid
out-of-bounds memory accesses or slab corruption should a malicious
device report smaller buffers than expected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Should apply also to older trees without kzalloc_obj().

Johan


 drivers/usb/serial/digi_acceleport.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index a06485965412..a876d6629b65 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1229,15 +1229,34 @@ static int digi_port_init(struct usb_serial_port *port, unsigned port_num)
 static int digi_startup(struct usb_serial *serial)
 {
 	struct digi_serial *serial_priv;
+	int oob_port_num;
 	int ret;
+	int i;
+
+	/*
+	 * The port bulk-out buffers must be large enough for header and
+	 * buffered data.
+	 */
+	for (i = 0; i < serial->type->num_ports; i++) {
+		if (serial->port[i]->bulk_out_size < DIGI_OUT_BUF_SIZE + 2)
+			return -EINVAL;
+	}
+
+	/*
+	 * The OOB port bulk-out buffer must be large enough for the two
+	 * commands in digi_set_modem_signals().
+	 */
+	oob_port_num = serial->type->num_ports;
+	if (serial->port[oob_port_num]->bulk_out_size < 8)
+		return -EINVAL;
 
 	serial_priv = kzalloc(sizeof(*serial_priv), GFP_KERNEL);
 	if (!serial_priv)
 		return -ENOMEM;
 
 	spin_lock_init(&serial_priv->ds_serial_lock);
-	serial_priv->ds_oob_port_num = serial->type->num_ports;
-	serial_priv->ds_oob_port = serial->port[serial_priv->ds_oob_port_num];
+	serial_priv->ds_oob_port_num = oob_port_num;
+	serial_priv->ds_oob_port = serial->port[oob_port_num];
 
 	ret = digi_port_init(serial_priv->ds_oob_port,
 						serial_priv->ds_oob_port_num);
-- 
2.53.0


