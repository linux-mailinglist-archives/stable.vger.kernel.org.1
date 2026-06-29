Return-Path: <stable+bounces-269751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VlbSJW5tQmq+6wkAu9opvQ
	(envelope-from <stable+bounces-269751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:04:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196876DAB96
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:04:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XH+tvkoq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269751-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269751-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1364131A3F8D
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB633FE66F;
	Mon, 29 Jun 2026 12:45:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C140D583;
	Mon, 29 Jun 2026 12:45:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737139; cv=none; b=RYIINvujoDLapewSlJMXpXMzuhP9KOFjyFQJw3aYcD42hOevK77CTDPCq2vDMbCWdGNRzQR/sLPekcK9AHwgJBJu1zptBCcMWzMZtHYyibKteiNOfcMUKnFrGgd6nsGOcKptH/795B/kHojYTOpW8FwRMauIpNOGmnqg0tSry+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737139; c=relaxed/simple;
	bh=JqnUCp9NHegTKtifIRvOmaNsg7jrJXmvZNcvYEDtA7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKHY/zgU+8Wr8hsUC96zFaduhYugwehSQr/dqJ9SoEdLXHlmhOe/N8YoVjEfb7xiOeu0ZATTGcIVGTkVKrlk3pAIdn31T80LUo6jDslRQSjMalKtFzSuxxCNchcXyz2YiGDioOAPy3lFuPVon/RUiN+UGLZ7OfV9BVfBLYhdO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH+tvkoq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DA11F000E9;
	Mon, 29 Jun 2026 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782737138;
	bh=ZXaaX3OylUoeKnjHd0RcDoqhdodV7vKZgIr4/0fW9Kw=;
	h=From:To:Cc:Subject:Date;
	b=XH+tvkoqXRZspX9JR9awHGs9a6A4qAXcKrxVEjJROb+2usi/vVIp3hp5nqrOd/j2g
	 syf92922kF7/eJX2HYmnQAq6upohawzsDmzPKEHRF9fzt7eq719OSxd38mVcy+JRko
	 NaAB99s4j+2L9ozDbtdI6hhjV0xDk7LPpQsVvABzv9bnBgJ4di0FcCl7wCdJrQJTb9
	 kDqkjzWqJP/dgIZeVjHc6kQ1OtPs7dCQ8HZm6P7zK3sDvkR4+02C/gKAar7nSzBrME
	 QbpiB2qU8JDAGprRb7og+xl+DrSt0CWatRRTF9AQimhLBIvu2w+U3PvEcoh35Bhk5W
	 312yscqztGICg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1weBMl-00000000Pbc-2G7D;
	Mon, 29 Jun 2026 14:45:35 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: keyspan_pda: fix information leak
Date: Mon, 29 Jun 2026 14:45:26 +0200
Message-ID: <20260629124526.98415-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269751-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-usb@vger.kernel.org,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:johan@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 196876DAB96

The write() callback is supposed to return the number of characters
accepted or a negative errno. Since the addition of write fifo support
the keyspan_pda implementation will however return the number characters
submitted to the device if the write urb is not already in use. If this
number is larger than the number of characters passed to write(), the
line discipline continues writing data from beyond the tty write buffer.

Fix the information leak by making sure that keyspan_pda_write_start()
returns zero on success as intended.

Fixes: 034e38e8f687 ("USB: serial: keyspan_pda: add write-fifo support")
Cc: stable@vger.kernel.org	# 5.11
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 3b99f9676c35..f05bcce60600 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -516,7 +516,7 @@ static int keyspan_pda_write_start(struct usb_serial_port *port)
 	if (count == room)
 		schedule_work(&priv->unthrottle_work);
 
-	return count;
+	return 0;
 }
 
 static void keyspan_pda_write_bulk_callback(struct urb *urb)
-- 
2.53.0


