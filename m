Return-Path: <stable+bounces-260875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id elthC6cTJGrk2gEAu9opvQ
	(envelope-from <stable+bounces-260875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 14:33:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 787FB64D6CB
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 14:33:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AaKwC5jt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260875-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260875-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69CE301A384
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6F353EF3;
	Sat,  6 Jun 2026 12:32:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A616378D7D
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:32:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749127; cv=none; b=KasFmwgqiLVzGh7V4Moq6QIigsxL4lZjSK46AD8Qsb5jjzeniNrd3WdE7366cvHtXXOcZOUXpGXhZbbreTURj12OlU8yMUOu8vSorFi+Rv9J67yhVimDD69cA/OAwgvFrW4NJp3zYPwPsROjDJGiUn02JhzEfr3jYKQwW7J9Szg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749127; c=relaxed/simple;
	bh=0IVIWBTel9Iv+lBJjv0eDbqrB5DlEw2V7SGtMSwYzz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niiLLbunI/RpUmRmZ/TvSlNEzQF4pH3Xfu67S7DvPRVF3D9CS9NDAzhYS/0jXGbdX2UC6AmMzSiNscXkKm4rG7fu5Zq0rEED/LhCtruHBRXPcwHXTMRAGkxGXatKmnP/ZSAUu+abYJYBs/GNwP7NLnvz3KdAg5fJs5o7gPnIlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaKwC5jt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2431F00899;
	Sat,  6 Jun 2026 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749126;
	bh=A/3KUEAE/MSSVYNVeLTKsclQgO8u46k+og82/aG7dFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AaKwC5jtzHxka70DPjFOPtSvkTXvzIV+ybwRsIABSSIU6TMbyimCEO4CmZ1RINapG
	 t6WhFKAcTTqdSG+r5iC/0P4vNO7QoV3FVjChoY51q4gXWWDPhb+EK9BTDom/V/QVIE
	 NS150BeDTrcRzzPfFQuyAyY8rUpiUlNRzZ+/oh6a3o78A+pOwqlwPtSp9oXocQl+Xr
	 0eZ3SmanbLzwf1tbpImaoynbP29DsJ5WZYZmtnunaErH/LUBOWgeAXhA+9GYt2VlDR
	 7RE5kbA4vywXfwtmIjPZ5Y/6d8btnkLNIDlwTJhtTllpb6ICETTpdRTSirVdFAOEU/
	 L7aJM5m5JRGVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] serial: altera_jtaguart: Use platform_get_irq_optional() to get the interrupt
Date: Sat,  6 Jun 2026 08:32:03 -0400
Message-ID: <20260606123204.2861133-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060423-confiding-sandpit-f19a@gregkh>
References: <2026060423-confiding-sandpit-f19a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260875-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,linuxfoundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 787FB64D6CB

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 60302276caff50f907bc3391a364691ab4a21b43 ]

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211224142917.6966-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ea66be25f0e9 ("serial: altera_jtaguart: handle uart_add_one_port() failures")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/altera_jtaguart.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index d0ca9cf29b62ff..749f4eadff3435 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -420,8 +420,9 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct altera_jtaguart_platform_uart *platp =
 			dev_get_platdata(&pdev->dev);
 	struct uart_port *port;
-	struct resource *res_irq, *res_mem;
+	struct resource *res_mem;
 	int i = pdev->id;
+	int irq;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -440,9 +441,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res_irq)
-		port->irq = res_irq->start;
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+	if (irq > 0)
+		port->irq = irq;
 	else if (platp)
 		port->irq = platp->irq;
 	else
-- 
2.53.0


