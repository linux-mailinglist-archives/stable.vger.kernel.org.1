Return-Path: <stable+bounces-270016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 194gJCb0Q2pNmAoAu9opvQ
	(envelope-from <stable+bounces-270016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:51:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E06E6A17
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:51:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=gtEChR3R;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=dXzKovoz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270016-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270016-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA936304A999
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95623D8918;
	Tue, 30 Jun 2026 16:51:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484443D75D1;
	Tue, 30 Jun 2026 16:51:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838307; cv=none; b=JGdH2sKbYQ0IAvNAJzGC3iLJY1PP7jTd6/SkZMkqqPJdBk4p0/LRRVpbsWmNr7/sFakxbgyKKyFtjHmCSIbcj7LXcjKAYJP2inGQnkATVC6AHDEe5ntO54TXWzR8ZXfcKtbVtGko3RhMj2P3SxoH7/sIrT+KbYDuIadK4ZoHohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838307; c=relaxed/simple;
	bh=QU0uN8hQiSXf074bddrC7cQZ0ZcDxXavvyeQCJtMUsI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jmsZ2jlE18TaJIhfIeULadsln6wmqt06Bkf101nwuCnZQtpQeK4f7E0T2HjjQxP/LYheeWlPzyiM3XQsCOQji2pCuCxRX85X5qbLsY+etvKKXh69hzCfpUnBc7YmblzlNXW91qag3g3yu8PknrW33t1kATziH1TX3lXvHExpFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtEChR3R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dXzKovoz; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 30 Jun 2026 16:51:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782838304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b201IaT277mzb3hbPC6lM2Oa1Y3JRC8revqZfZBNB84=;
	b=gtEChR3Rw5XAY2r4gdZk7PLNh9gIrmIHjRIfSSMnOdjS+u2NXu2gz+RKlVH001Q3eDkkJ6
	EqDa5T+lySU3XnTFvKNC781iJ7Z+pO4HCEG0N01MyeINjQB3pm6knejqZX/J2mxuWrYz9B
	/t0Turl5SAGVMao5IwXTvPqd2K1ogwxrafha01yNed9q3A2J5uSrI1BYHBLQ5XHqfOUs3i
	N8t1jXo9cbXoXH6RlVdBKZyyJR///k0scW8OY0IbgOmoWZtgRWly4mnEEn5p9NvkYTm76+
	sDbNBgETpyZk3HCwPPBrn6fhSNKH1Q7B4TM7d5pJudNTsuthm0zL2RzglSlt9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782838304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b201IaT277mzb3hbPC6lM2Oa1Y3JRC8revqZfZBNB84=;
	b=dXzKovozo5jl18TwhhEFMyc30LIPKkapOtqxjJXpHIcxerr5P22dYuOLM8fXo6gBXuzcRx
	YppWj+ReYC+JpCDQ==
From: "tip-bot2 for Haoxiang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-riscv-imsic-early: Fix fwnode leak on
 state setup failure
Cc: Haoxiang Li <haoxiang_li2024@163.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20260623073744.2009137-1-haoxiang_li2024@163.com>
References: <20260623073744.2009137-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178283830314.3843924.11638746215515181404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-tip-commits@vger.kernel.org,m:haoxiang_li2024@163.com,m:tglx@kernel.org,m:stable@vger.kernel.org,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:maz@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270016-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[163.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:replyto,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:from_mime,tip-bot2:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 326E06E6A17

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     1358126fbed104e5657955d3ba029b283687ba02
Gitweb:        https://git.kernel.org/tip/1358126fbed104e5657955d3ba029b28368=
7ba02
Author:        Haoxiang Li <haoxiang_li2024@163.com>
AuthorDate:    Tue, 23 Jun 2026 15:37:44 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 30 Jun 2026 18:49:48 +02:00

irqchip/irq-riscv-imsic-early: Fix fwnode leak on state setup failure

imsic_early_acpi_init() allocates a firmware node before setting up the
IMSIC state. If imsic_setup_state() fails, the function returns without
freeing the allocated fwnode.

Free the fwnode and clear the global pointer on this error path, matching
the cleanup already done when imsic_early_probe() fails.

[ tglx: Use a common cleanup path instead of copying code around ]

Fixes: fbe826b1c106 ("irqchip/riscv-imsic: Add ACPI support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260623073744.2009137-1-haoxiang_li2024@163.c=
om
---
 drivers/irqchip/irq-riscv-imsic-early.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-ri=
scv-imsic-early.c
index a7a1852..12efd24 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -272,16 +272,13 @@ static int __init imsic_early_acpi_init(union acpi_subt=
able_headers *header,
 	rc =3D imsic_setup_state(imsic_acpi_fwnode, imsic);
 	if (rc) {
 		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
-		return rc;
+		goto cleanup;
 	}
=20
 	/* Do early setup of IMSIC state and IPIs */
 	rc =3D imsic_early_probe(imsic_acpi_fwnode);
-	if (rc) {
-		irq_domain_free_fwnode(imsic_acpi_fwnode);
-		imsic_acpi_fwnode =3D NULL;
-		return rc;
-	}
+	if (rc)
+		goto cleanup;
=20
 	rc =3D imsic_platform_acpi_probe(imsic_acpi_fwnode);
=20
@@ -300,8 +297,12 @@ static int __init imsic_early_acpi_init(union acpi_subta=
ble_headers *header,
 	 * DT where IPI works but MSI probe fails for some reason.
 	 */
 	return 0;
-}
=20
+cleanup:
+	irq_domain_free_fwnode(imsic_acpi_fwnode);
+	imsic_acpi_fwnode =3D NULL;
+	return rc;
+}
 IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
 		     1, imsic_early_acpi_init);
 #endif

