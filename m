Return-Path: <stable+bounces-259827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RqInCOzaHmpaWQAAu9opvQ
	(envelope-from <stable+bounces-259827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:30:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE262E7F3
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:30:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XNII7hWK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259827-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259827-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59D85302D621
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B0F3E8C46;
	Tue,  2 Jun 2026 13:29:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCA3E835F;
	Tue,  2 Jun 2026 13:28:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406940; cv=none; b=pCUwmaAS2ZkkaYau4Cy8XZ9f9zXqmJCcWc86c3NS6Dzk8xU7UC6prrXGOI/3JCtvO4qqvl2XW52xYNzCqAbEcNEfY2jBtTdgM5kn8EVT9yeIzrRr3LC6AiDnenOFwwphV6Lpfsdw5Yy7JzFph1ErtTf0mE5mM1iQt1qb8u9yEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406940; c=relaxed/simple;
	bh=sJuC9Xkw6gSvyoP1DQwUIKxyM5R2tTCKV8RMXqIaWeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKG1bGmuZr6tOkti6KN7ZjGtJnd+4pGoOZqcyMFda54I2Tfdyu3T/gtQapKDxHCO+2PsxnBPx3Nva4vS6ZjnY82YJGyIGMq3GCl3HVHi9WOPbBwrb2xmQ5LhN1glM+Tok0nCwblYFwJjTUdmklsmonQgpNgV8faoa3/6E0uge6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNII7hWK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B151F00898;
	Tue,  2 Jun 2026 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406939;
	bh=7/ANmW8xMeqtj8v82T2dps0zvcqGIwe6OGsGwbvUozQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNII7hWKd+0edWhj4oLzEQ5fnh0lOaU1PIQ9pvQ3HOdRgOVDokYBmj2/zOjDzv+3J
	 pzXpbJU7KbU2jqaTmzhW4s7rEA8qN+LJ2b6SnbeHDNgN+I/LwP8E0gdaguDvYPGAv+
	 tuV6VgW218nuNdbY4aTaElZZaUPnGBW39w3rMq/HHAcPKn9tnuvZyEMF+TpJLdRPSg
	 uHlFMKVghSprn2MSs4hgHuDwk+yeLZbubrvq9FQYMr1JiU4ImmnHNeNUcw1BdcMCO5
	 Z2gDnV5Cl9uFVDwYeVx092F5A7YK3MNln5Ry8AbfEwV9Uv9oJt6QSFPiYC0573QpZP
	 3F+xnId/Q7A/Q==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 07/17] i3c: renesas: Do not attach devices if xfer failed
Date: Tue,  2 Jun 2026 16:28:14 +0300
Message-ID: <20260602132824.3541151-8-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-259827-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[claudiu.beznea@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:wsa+renesas@sang-engineering.com,m:tommaso.merciai.xr@bp.renesas.com,m:alexandre.belloni@bootlin.com,m:Frank.Li@nxp.com,m:p.zabel@pengutronix.de,m:claudiu.beznea@kernel.org,m:claudiu.beznea@tuxon.dev,m:linux-i3c@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:stable@vger.kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6AE262E7F3

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The controller may return an NRSPQP_ERROR_* error code while still
providing a valid cmd->rx_count. It has been observed that when the
transfer fails with NRSPQP_ERROR_ADDRESS_NACK, calling
i3c_master_add_i3c_dev_locked() may lead to crashes. Set newdevs to zero
if the transfer failed.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none, this patch is new

 drivers/i3c/master/renesas-i3c.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 695aae6ac263..de09f0cadb72 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -727,8 +727,13 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 
 	renesas_i3c_wait_xfer(i3c, xfer);
 
-	newdevs = GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
-	newdevs &= ~olddevs;
+	/* Skip attaching if there are failures on the xfer. */
+	if (xfer->ret) {
+		newdevs = 0;
+	} else {
+		newdevs = GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
+		newdevs &= ~olddevs;
+	}
 
 	for (pos = 0; pos < i3c->maxdevs; pos++) {
 		if (newdevs & BIT(pos))
-- 
2.43.0


