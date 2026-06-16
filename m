Return-Path: <stable+bounces-265445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X58FHHaKMWpemAUAu9opvQ
	(envelope-from <stable+bounces-265445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:40:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1E69358F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:40:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dDtrwRrB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265445-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265445-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40E43028078
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD38F47AF5D;
	Tue, 16 Jun 2026 17:33:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42144611CF;
	Tue, 16 Jun 2026 17:33:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631235; cv=none; b=ZZxQynp2OqzV2vYNAIh1rEbHtcaeK4CEJBj3SawAjO3AgdlR0PEK7rlMknsNJ0vz3zPDyztyemdw3+Y7WLreTSWcm+tWhIq8FHScZRpFEBo1wRXlWiDAVMsEfczl16i8NIvzhONa6VgUSb7GQoN0kFOdeenIf31YjjHB+K2lXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631235; c=relaxed/simple;
	bh=vWqEL+yO2ahv6ZgMcfR103WCRrp+4VW7OjbbZ6YjNH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRffQwxIc7/ELXWKe23y1Q3KerCpYjOA5jNQjCvJuFgz3bviiVBqbK95vHgsoRNcRY0h18qD1dIovsYfi85XgsygD2UiPRL6FDKAbUmASXNTyxm4YpbCOTtpXt8zhW/2xjz5gXWGGcScf+LRI181s5xsfIfWNoDIWp+0wonSbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDtrwRrB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4B41F000E9;
	Tue, 16 Jun 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631234;
	bh=z3pYI2puQbFYTIa/yKREeBBHlyVKGK0LDeMcotztVoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDtrwRrBwzdz5LZIuSgvlvR0Yr1RapFqSZr9Bk92Cpu+Lxwf/bt0TqwJeU7JhOmly
	 KSjTRTfvII+mvmQJ+SV+eqnFN4sb1CA3gufNa8OkU0d/ORJnAh57nLr3pXQ/0PKeJ9
	 RvbCeuPVjNAso3C12fncRWt8RGIQ+iU4f6xg6RuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 183/522] USB: serial: digi_acceleport: fix memory corruption with small endpoints
Date: Tue, 16 Jun 2026 20:25:30 +0530
Message-ID: <20260616145134.683667600@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johan@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26A1E69358F

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit cb3560e8eab1dfa1cac1ed52631adf8ec6ff2cd5 upstream.

Add the missing bulk-out buffer size sanity checks to avoid
out-of-bounds memory accesses or slab corruption should a malicious
device report smaller buffers than expected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 45d688e9b93f68..eb23f7bb41e728 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1230,15 +1230,34 @@ static int digi_port_init(struct usb_serial_port *port, unsigned port_num)
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




