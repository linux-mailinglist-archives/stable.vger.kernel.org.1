Return-Path: <stable+bounces-266265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PGWTEhGaMWronwUAu9opvQ
	(envelope-from <stable+bounces-266265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:46:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C8694759
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:46:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bMidImxY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266265-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266265-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0064E31E6BB9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93447B425;
	Tue, 16 Jun 2026 18:45:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6E47A0B2;
	Tue, 16 Jun 2026 18:45:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635521; cv=none; b=l04hvcMm7CHwvz90omQFXnujFf/4+1eO1KrACKmOT+D/HOmncjIB7B7PBbKkBvYetg/uEHmlRiUzSRk3y22d5EvsOc4Y3KT1ReCn3yK0bWw/D66QoSZ4taWDze9hj4Ak5mF0xSb7yKkKzxxZLrcjTC+/7djZzRpbpp2fi0R6hn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635521; c=relaxed/simple;
	bh=n6IVmpO3C12nGPas1+5QHhzRD35mam9QRVWKRMKRP/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr/MNb+dxXE4BclndLCJrL4zBzRxfwwOVWKdhkF8qQiP2KnwtD1qs/aP2s+I2KO4N4evWjMx7EE+K16+lLFHHVCF33Mg5jh0CHfcmZJ4jZo+yh1IdtjR3G4QacGbSo/teXQr7B935jZSfU1uLxfbUjlCTkvZcYFhu0CLvTx1wGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bMidImxY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C611F00A3F;
	Tue, 16 Jun 2026 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635520;
	bh=6c6kSel2loR9PVLcXo06/P4JlHazOxYpMKndBwFqbcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMidImxYDmJl+pIdR2r/VpdP0ww0Izx+fiolbj/otPmLgsCHLDzxFVbimLXrgmeVP
	 6gAyFn+5xSq4cwuuDfIn1spMkOaEe7IXY/f+0VjkK6sxBoZkb8xlq4QS/Au4JXoZrK
	 KQaLfgHfArr1YaDB3QioWFvJFBo8Rm/l9XH7seLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.10 065/342] USB: serial: omninet: fix memory corruption with small endpoint
Date: Tue, 16 Jun 2026 20:26:01 +0530
Message-ID: <20260616145051.282625503@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266265-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johan@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D47C8694759

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 60df93d30f9bdd27db17c4d80ed80ef718d7226b upstream.

Make sure that the bulk-out buffers are at least as large as the
hardcoded transfer size to avoid user-controlled slab corruption should
a malicious device report a smaller endpoint max packet size than
expected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/omninet.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -30,6 +30,10 @@
 /* This one seems to be a re-branded ZyXEL device */
 #define BT_IGNITIONPRO_ID	0x2000
 
+#define OMNINET_HEADERLEN	4
+#define OMNINET_BULKOUTSIZE	64
+#define OMNINET_PAYLOADSIZE	(OMNINET_BULKOUTSIZE - OMNINET_HEADERLEN)
+
 /* function prototypes */
 static void omninet_process_read_urb(struct urb *urb);
 static int omninet_prepare_write_buffer(struct usb_serial_port *port,
@@ -55,6 +59,7 @@ static struct usb_serial_driver zyxel_om
 	.description =		"ZyXEL - omni.net lcd plus usb",
 	.id_table =		id_table,
 	.num_bulk_out =		2,
+	.bulk_out_size =	OMNINET_BULKOUTSIZE,
 	.calc_num_ports =	omninet_calc_num_ports,
 	.port_probe =		omninet_port_probe,
 	.port_remove =		omninet_port_remove,
@@ -133,10 +138,6 @@ static int omninet_port_remove(struct us
 	return 0;
 }
 
-#define OMNINET_HEADERLEN	4
-#define OMNINET_BULKOUTSIZE	64
-#define OMNINET_PAYLOADSIZE	(OMNINET_BULKOUTSIZE - OMNINET_HEADERLEN)
-
 static void omninet_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;



