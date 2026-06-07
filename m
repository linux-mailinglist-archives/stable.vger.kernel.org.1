Return-Path: <stable+bounces-261755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fV5gFfhPJWpWGwIAu9opvQ
	(envelope-from <stable+bounces-261755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:03:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DD65042A
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:03:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DuZexC0+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261755-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261755-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A28C230785DC
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EC832B111;
	Sun,  7 Jun 2026 10:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B04204E;
	Sun,  7 Jun 2026 10:55:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829722; cv=none; b=dvbnXbTYaCf6qzywnCRTVK1gVyil8AvIIDZ/77W7OzEwYE05jjDiqrpsDQCHQsAadNL4Z2Q74vmucKSribyu8tAUyjwv0rStj4m4BBm5kdGxTMVCOQOg95/gOJwlt9hMt7CGQ9gqZ8QNfAeBY5Iv5PAI+hjhcZrvzupoeoheUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829722; c=relaxed/simple;
	bh=pNtFatK/XX3YFT4gZth0i0RqWcGJINtLYgq0IoEG44I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djvxnhadEENpFUWzwtPFU03MCocMy7M9GpdfTDwqvFODYzuHqGvnB0iv5NiWkzJBT6WgLKT0o1uSCnbdlY+Q7RrN4BWd9v49bMl2hcA4IzLjc0+c2BcC+8KGCZezaBPZgUPLtBqVB6ShsK3NxvDU8pzYTDLOvluMpJJwScsQ06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DuZexC0+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392361F00898;
	Sun,  7 Jun 2026 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829721;
	bh=92eRY6Wr52GDtwRb3PETRLofxB8tF2zinut0a+yu6i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DuZexC0+Il9zKrmv5uifZYe7hrpZSWwiJrcbQF67d+bhe/ph5d5TY+9m8h5kQcura
	 X1022PTlTaiXJphN52tRMaqztShJomdcPols5qNEzy1MNuEBm3iK0ZnO8retr69Gl5
	 QCenxRPMmmhf4n2gZaOEqNnZLhNiNAdkqlrro3Vk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 6.18 273/315] serial: dz: Fix bootconsole message clobbering at chip reset
Date: Sun,  7 Jun 2026 12:01:00 +0200
Message-ID: <20260607095737.593358970@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-261755-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:macro@orcam.me.uk,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orcam.me.uk:email,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA0DD65042A

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@orcam.me.uk>

commit ca904f4b42355287bc5ce8b7550ebe909cda4c2c upstream.

In the DZ interface as implemented by the DC7085 gate array the serial
transmitters are double buffered, meaning that at the time a transmitter
is ready to accept the next character there is one in the transmit shift
register still being sent to the line.  Issuing a master clear at this
time causes this character to be lost, so wait an extra amount of time
sufficient for the transmit shift register to drain at 9600bps, which is
the baud rate setting used by the firmware console.

Mind the specified 1.4us TRDY recovery time in the course and continue
using iob() as the completion barrier, since the platforms involved use
a write buffer that can delay and combine writes, and reorder them with
respect to reads regardless of the MMIO locations accessed and we still
lack a platform-independent handler for that.

When called from dz_serial_console_init() this is too early for fsleep()
to work and even before lpj has been calculated and therefore the delay
is actually not sufficient for the transmitter to drain and is merely a
placeholder now.  This will be addressed in a follow-up change.

Fixes: e6ee512f5a77 ("dz.c: Resource management")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v2.6.25+
Link: https://patch.msgid.link/alpine.DEB.2.21.2605062259080.46195@angie.orcam.me.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/dz.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -542,10 +542,31 @@ static int dz_encode_baud_rate(unsigned
 static void dz_reset(struct dz_port *dport)
 {
 	struct dz_mux *mux = dport->mux;
+	unsigned short tcr;
+	int loops = 10000;
 
 	if (mux->initialised)
 		return;
 
+	tcr = dz_in(dport, DZ_TCR);
+
+	/* Do not disturb any ongoing transmissions.  */
+	if (dz_in(dport, DZ_CSR) & DZ_MSE) {
+		unsigned short csr, mask;
+
+		mask = tcr;
+		while ((mask & DZ_LNENB) && loops--) {
+			csr = dz_in(dport, DZ_CSR);
+			if (!(csr & DZ_TRDY))
+				continue;
+			mask &= ~(1 << ((csr & DZ_TLINE) >> 8));
+			dz_out(dport, DZ_TCR, mask);
+			iob();
+			udelay(2);		/* 1.4us TRDY recovery.  */
+		}
+		udelay(1200);			/* Transmitter drain.  */
+	}
+
 	dz_out(dport, DZ_CSR, DZ_CLR);
 	while (dz_in(dport, DZ_CSR) & DZ_CLR);
 	iob();



