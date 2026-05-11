Return-Path: <stable+bounces-245199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIt4JS/VAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:10:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D835750E9C4
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AC693032977
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003A3A3813;
	Mon, 11 May 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eCyF6UEt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+QtHzhz"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D63D47A8;
	Mon, 11 May 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504413; cv=none; b=MXv+kJgECvP1L780M+qQdVbOINdcuIc4Cg6axj5kfF8zke5xcMwoiHoIfSlaVxiG/qKRygVnNUt694M8zICvv7agm6/+noFg4r065LLXoViJulNJnUgzT+IMj9rc/RlM8rGafvtcU8/Xmm50JpDiNgvntKA6PrIfagxhWQkoQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504413; c=relaxed/simple;
	bh=XF6y6GAPaXWQOqj+0Wf/OUhunqV1kpSUwF3ptdItXDc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DgGLzw+LA6fnxAB0N/x8Exx5Qm2dYU/WwD5xIvZsTdCwaQyDwPH1/hZRv9LOuQcHRtISR247B7feD+PBF1XCx2nLSP7zx+AO+Enw/b+zJIUkGpl9TWY904t7EY2Ge7v7BSe5RROXlFkoCOy6rOuhzmnVaAYM+r+FR5c/EaTeKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eCyF6UEt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+QtHzhz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 May 2026 13:00:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778504410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0u+fv4YY8QPyGfQ1kj6nEGUufge+kfJ4sGuaoQ/uXs=;
	b=eCyF6UEtxTS9HxMD49OQoOjB/PFHUw/y/zGsa1E4veCF8lyYtD2o5WaGb2CQOzutZ/A5K1
	WBsRyvvoDv1ccAO6n1JtrWZUftA4pioGc1O6bVKfA7fE+7P7HvbnadmN2svqCigWbndKBI
	p+LtmKhpj+hG4GNAbWPnKXDXlE6Rda08j8SzEqxbrK0eeNaPpBCwAH8o5zX+4z28Vi7tuR
	RfvSflqSfVd61P3Me1NIbH8LHPnma6dxvy2Fg4R/fzVKLAhkbzuVWiHassHFad71PYuIbg
	UpXYAmfqE1FnkZdcJ9uACHjLUTBKcMZZHzo/JBE24OQ1GEhcaYJTG0FpA46fKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778504410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0u+fv4YY8QPyGfQ1kj6nEGUufge+kfJ4sGuaoQ/uXs=;
	b=U+QtHzhzywsX4ZEse0Iv2WUy7rgHULA6AgP1bVVc8Uh0zjcZKh9BrXBCsgVunSGbInMahx
	t1K8hqhf229gSiDg==
From: "tip-bot2 for Sascha Bischoff" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v5: Support range allocation for LPIs
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260506093634.382062-3-sascha.bischoff@arm.com>
References: <20260506093634.382062-3-sascha.bischoff@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177850440932.188840.17920711162795586763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D835750E9C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245199-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,msgid.link:url,vger.kernel.org:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim]
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     eb6f6d523813ead9dc2799194a2839d42c049734
Gitweb:        https://git.kernel.org/tip/eb6f6d523813ead9dc2799194a2839d42c0=
49734
Author:        Sascha Bischoff <Sascha.Bischoff@arm.com>
AuthorDate:    Wed, 06 May 2026 09:37:23=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 11 May 2026 14:56:04 +02:00

irqchip/gic-v5: Support range allocation for LPIs

The per-IPI parent allocation loop returns immediately on failure and leaks
any parent interrupts allocated by earlier iterations.

The GICv5 LPI domain now owns LPI allocation and teardown internally,
but its irq_domain callbacks still reject requests where nr_irqs is
greater than one. This forces child domains to allocate and free LPIs
one at a time even when the interrupt core requests a contiguous
range.

Handle multi-interrupt allocation and teardown in the LPI domain by
iterating over the requested range and unwinding any partially
allocated state on failure.

Allocate the parent LPIs for the IPI domain with a single range
request as well, which cures the leakage problem.

Fixes: 0f0101325876 ("irqchip/gic-v5: Add GICv5 LPI/IPI support")
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260506093634.382062-3-sascha.bischoff@arm.com
---
 drivers/irqchip/irq-gic-v5.c | 77 +++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 15a2a04..c1af070 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -801,15 +801,14 @@ static void gicv5_irq_lpi_domain_free(struct irq_domain=
 *domain, unsigned int vi
 {
 	struct irq_data *d;
=20
-	if (WARN_ON_ONCE(nr_irqs !=3D 1))
-		return;
-
-	d =3D irq_domain_get_irq_data(domain, virq);
+	for (unsigned int i =3D 0; i < nr_irqs; i++, virq++) {
+		d =3D irq_domain_get_irq_data(domain, virq);
=20
-	release_lpi(d->hwirq);
+		release_lpi(d->hwirq);
=20
-	irq_set_handler(virq, NULL);
-	irq_domain_reset_irq_data(d);
+		irq_set_handler(virq, NULL);
+		irq_domain_reset_irq_data(d);
+	}
 }
=20
 static int gicv5_irq_lpi_domain_alloc(struct irq_domain *domain, unsigned in=
t virq,
@@ -817,32 +816,39 @@ static int gicv5_irq_lpi_domain_alloc(struct irq_domain=
 *domain, unsigned int vi
 {
 	irq_hw_number_t hwirq;
 	struct irq_data *irqd;
+	unsigned int i;
 	int ret;
=20
-	if (WARN_ON_ONCE(nr_irqs !=3D 1))
-		return -EINVAL;
-
-	ret =3D alloc_lpi();
-	if (ret < 0)
-		return ret;
-	hwirq =3D ret;
+	for (i =3D 0; i < nr_irqs; i++) {
+		ret =3D alloc_lpi();
+		if (ret < 0)
+			goto out_free_lpis;
+		hwirq =3D ret;
+
+		ret =3D gicv5_irs_iste_alloc(hwirq);
+		if (ret < 0) {
+			/* Undo partial state first, then clean up the rest */
+			release_lpi(hwirq);
+			goto out_free_lpis;
+		}
=20
-	irqd =3D irq_domain_get_irq_data(domain, virq);
+		irqd =3D irq_domain_get_irq_data(domain, virq + i);
=20
-	irq_domain_set_info(domain, virq, hwirq, &gicv5_lpi_irq_chip, NULL,
-			    handle_fasteoi_irq, NULL, NULL);
-	irqd_set_single_target(irqd);
+		irq_domain_set_info(domain, virq + i, hwirq, &gicv5_lpi_irq_chip,
+				    NULL, handle_fasteoi_irq, NULL, NULL);
+		irqd_set_single_target(irqd);
=20
-	ret =3D gicv5_irs_iste_alloc(hwirq);
-	if (ret < 0) {
-		release_lpi(hwirq);
-		return ret;
+		gicv5_hwirq_init(hwirq, GICV5_IRQ_PRI_MI, GICV5_HWIRQ_TYPE_LPI);
+		gicv5_lpi_config_reset(irqd);
 	}
=20
-	gicv5_hwirq_init(hwirq, GICV5_IRQ_PRI_MI, GICV5_HWIRQ_TYPE_LPI);
-	gicv5_lpi_config_reset(irqd);
-
 	return 0;
+
+out_free_lpis:
+	if (i)
+		gicv5_irq_lpi_domain_free(domain, virq, i);
+
+	return ret;
 }
=20
 static const struct irq_domain_ops gicv5_irq_lpi_domain_ops =3D {
@@ -868,21 +874,21 @@ static int gicv5_irq_ipi_domain_alloc(struct irq_domain=
 *domain, unsigned int vi
 				      unsigned int nr_irqs, void *arg)
 {
 	struct irq_data *irqd;
-	int ret, i;
+	int ret;
=20
-	for (i =3D 0; i < nr_irqs; i++) {
-		ret =3D irq_domain_alloc_irqs_parent(domain, virq + i, 1, NULL);
-		if (ret)
-			return ret;
+	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret)
+		return ret;
=20
-		irqd =3D irq_domain_get_irq_data(domain, virq + i);
+	for (unsigned int i =3D 0; i < nr_irqs; i++, virq++) {
+		irqd =3D irq_domain_get_irq_data(domain, virq);
=20
-		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
-				&gicv5_ipi_irq_chip, NULL);
+		irq_domain_set_hwirq_and_chip(domain, virq, i,
+					      &gicv5_ipi_irq_chip, NULL);
=20
 		irqd_set_single_target(irqd);
=20
-		irq_set_handler(virq + i, handle_percpu_irq);
+		irq_set_handler(virq, handle_percpu_irq);
 	}
=20
 	return 0;
@@ -902,8 +908,9 @@ static void gicv5_irq_ipi_domain_free(struct irq_domain *=
domain, unsigned int vi
=20
 		irq_set_handler(virq + i, NULL);
 		irq_domain_reset_irq_data(d);
-		irq_domain_free_irqs_parent(domain, virq + i, 1);
 	}
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
=20
 static const struct irq_domain_ops gicv5_irq_ipi_domain_ops =3D {

