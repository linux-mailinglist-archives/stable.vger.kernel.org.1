Return-Path: <stable+bounces-245200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKpAL17VAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:10:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE450E9EB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A13F302C3BD
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82613A1A2F;
	Mon, 11 May 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHI5669w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKXv+LpN"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E43DBD4E;
	Mon, 11 May 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504415; cv=none; b=QgxhW6PpPxoQ1PfoR78k2/PzRRGPVIF30tV0hjC1l+ip2Dv9RCMcmEcoklOlxKBbtNneKkfbHnNN6DLTC8Hm7eUal8ITJDrtI/ykuM3+dxCrSEKlATBccdtvGc1FoGrwXhlqpRwE5zVvcBhy18RZV511cUYB8s9lXE3wWNtxgPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504415; c=relaxed/simple;
	bh=Aa2CKi3/THsJStxW37gqX9zQkAnz5I2nPgN0TiIzXfw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=duKdruJ/wYdFFCOvo93xH6BTToQNIeQvUEYXP9oz0corKLw8nLKVC8Ed/+hXdQZVMEWob6LssZtL7gr6t/WJcDhV+SIAGut0U4XaGK9fjZChkoysgPLqCXyGsXEZNmfKnBM9ImJQkzMtEpTx7i9x7J+vvsohfaEM36X15Dk36+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHI5669w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKXv+LpN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 May 2026 13:00:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778504412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SRmEWIxYvPl3W7Tq4waedY5PfU2g2Jv0vhuAvZgi3Q=;
	b=YHI5669wRRBwhYs8NzUZYvS2+Qf3yti2tX/NsgqJ/yW1qroItL7F1lOiGJ2nIzBzlHwT1/
	IMxksechayj2nehnOtetOWpvJKGw0P1QdqAL9xFYt9/CfsI69x+VlK5HcX35vg+SWokeGL
	OgDw/DXBtpy7wNyqye9g7CtCbkHF/gYYwwE+N+qV4MHIAjqLrm46Fduthd5zCn6ZoyV/WP
	OKCDH/RgEie68yynER9EtNgs5fZ8J4pBOf4nj/RuMnQL2xp5zUu3s+wSLt72SiiFlUlIPF
	KhLNK7bTxDtBVpsFymzUbtAZqANNDqE7kWmRt9qBkwnzFF70XV+Q9szMtJaGLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778504412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SRmEWIxYvPl3W7Tq4waedY5PfU2g2Jv0vhuAvZgi3Q=;
	b=wKXv+LpNDxOLXhpHc3TsHQj7KsfOqq3Z6R3OVTxbN3Tc9LjRNB4KzKhqtADZWvcTE8DM6A
	cKDlZlG46GLhnRBg==
From: "tip-bot2 for Sascha Bischoff" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/gic-v5: Move LPI allocation into the LPI domain
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260506093634.382062-2-sascha.bischoff@arm.com>
References: <20260506093634.382062-2-sascha.bischoff@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177850441070.188840.1550627692643881893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C1EE450E9EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245200-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,arm.com:email,vger.kernel.org:replyto]
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     dec85d2fbd20de3711a71e65397dfdb40c3fa953
Gitweb:        https://git.kernel.org/tip/dec85d2fbd20de3711a71e65397dfdb40c3=
fa953
Author:        Sascha Bischoff <Sascha.Bischoff@arm.com>
AuthorDate:    Wed, 06 May 2026 09:37:02=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 11 May 2026 14:56:03 +02:00

irqchip/gic-v5: Move LPI allocation into the LPI domain

The IPI and ITS MSI domains currently allocate and release LPIs
directly, then pass the selected LPI ID to the parent LPI domain. This
leaks the LPI domain's allocation policy into its child domains and
forces each child to duplicate part of the parent domain's teardown.

Make the LPI domain allocate LPIs in its .alloc() callback and release
them in a matching .free() callback. Child domains can then request a
parent interrupt without passing an implementation-specific LPI ID,
and the LPI lifetime is tied to the domain that owns the LPI
namespace.

Remove the gicv5_alloc_lpi() and gicv5_free_lpi() wrappers now that no
external caller needs to manage LPIs directly.

This is a preparatory change for an actual leakage problem in the
allocation code and therefore tagged with the same Fixes tag.

Fixes: 0f0101325876 ("irqchip/gic-v5: Add GICv5 LPI/IPI support")
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260506093634.382062-2-sascha.bischoff@arm.com
---
 drivers/irqchip/irq-gic-v5-its.c   | 14 +-------
 drivers/irqchip/irq-gic-v5.c       | 53 ++++++++++++++---------------
 include/linux/irqchip/arm-gic-v5.h |  3 +--
 3 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 36a8d13..36d03f8 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -929,8 +929,8 @@ static void gicv5_its_free_eventid(struct gicv5_its_dev *=
its_dev, u32 event_id_b
 static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned in=
t virq,
 				      unsigned int nr_irqs, void *arg)
 {
-	u32 device_id, event_id_base, lpi;
 	struct gicv5_its_dev *its_dev;
+	u32 device_id, event_id_base;
 	msi_alloc_info_t *info =3D arg;
 	irq_hw_number_t hwirq;
 	struct irq_data *irqd;
@@ -949,16 +949,8 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain =
*domain, unsigned int vi
 	device_id =3D its_dev->device_id;
=20
 	for (i =3D 0; i < nr_irqs; i++) {
-		ret =3D gicv5_alloc_lpi();
-		if (ret < 0) {
-			pr_debug("Failed to find free LPI!\n");
-			goto out_free_irqs;
-		}
-		lpi =3D ret;
-
-		ret =3D irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
+		ret =3D irq_domain_alloc_irqs_parent(domain, virq + i, 1, NULL);
 		if (ret) {
-			gicv5_free_lpi(lpi);
 			goto out_free_irqs;
 		}
=20
@@ -983,7 +975,6 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *=
domain, unsigned int vi
 out_free_irqs:
 	while (--i >=3D 0) {
 		irqd =3D irq_domain_get_irq_data(domain, virq + i);
-		gicv5_free_lpi(irqd->parent_data->hwirq);
 		irq_domain_reset_irq_data(irqd);
 		irq_domain_free_irqs_parent(domain, virq + i, 1);
 	}
@@ -1013,7 +1004,6 @@ static void gicv5_its_irq_domain_free(struct irq_domain=
 *domain, unsigned int vi
 	for (i =3D 0; i < nr_irqs; i++) {
 		d =3D irq_domain_get_irq_data(domain, virq + i);
=20
-		gicv5_free_lpi(d->parent_data->hwirq);
 		irq_domain_reset_irq_data(d);
 		irq_domain_free_irqs_parent(domain, virq + i, 1);
 	}
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 6b0903b..15a2a04 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -59,16 +59,6 @@ static void release_lpi(u32 lpi)
 	ida_free(&lpi_ida, lpi);
 }
=20
-int gicv5_alloc_lpi(void)
-{
-	return alloc_lpi();
-}
-
-void gicv5_free_lpi(u32 lpi)
-{
-	release_lpi(lpi);
-}
-
 static void gicv5_ppi_priority_init(void)
 {
 	write_sysreg_s(REPEAT_BYTE(GICV5_IRQ_PRI_MI), SYS_ICC_PPI_PRIORITYR0_EL1);
@@ -806,18 +796,36 @@ static void gicv5_lpi_config_reset(struct irq_data *d)
 	gicv5_lpi_irq_write_pending_state(d, false);
 }
=20
+static void gicv5_irq_lpi_domain_free(struct irq_domain *domain, unsigned in=
t virq,
+				      unsigned int nr_irqs)
+{
+	struct irq_data *d;
+
+	if (WARN_ON_ONCE(nr_irqs !=3D 1))
+		return;
+
+	d =3D irq_domain_get_irq_data(domain, virq);
+
+	release_lpi(d->hwirq);
+
+	irq_set_handler(virq, NULL);
+	irq_domain_reset_irq_data(d);
+}
+
 static int gicv5_irq_lpi_domain_alloc(struct irq_domain *domain, unsigned in=
t virq,
 				      unsigned int nr_irqs, void *arg)
 {
 	irq_hw_number_t hwirq;
 	struct irq_data *irqd;
-	u32 *lpi =3D arg;
 	int ret;
=20
 	if (WARN_ON_ONCE(nr_irqs !=3D 1))
 		return -EINVAL;
=20
-	hwirq =3D *lpi;
+	ret =3D alloc_lpi();
+	if (ret < 0)
+		return ret;
+	hwirq =3D ret;
=20
 	irqd =3D irq_domain_get_irq_data(domain, virq);
=20
@@ -826,8 +834,10 @@ static int gicv5_irq_lpi_domain_alloc(struct irq_domain =
*domain, unsigned int vi
 	irqd_set_single_target(irqd);
=20
 	ret =3D gicv5_irs_iste_alloc(hwirq);
-	if (ret < 0)
+	if (ret < 0) {
+		release_lpi(hwirq);
 		return ret;
+	}
=20
 	gicv5_hwirq_init(hwirq, GICV5_IRQ_PRI_MI, GICV5_HWIRQ_TYPE_LPI);
 	gicv5_lpi_config_reset(irqd);
@@ -837,7 +847,7 @@ static int gicv5_irq_lpi_domain_alloc(struct irq_domain *=
domain, unsigned int vi
=20
 static const struct irq_domain_ops gicv5_irq_lpi_domain_ops =3D {
 	.alloc	=3D gicv5_irq_lpi_domain_alloc,
-	.free	=3D gicv5_irq_domain_free,
+	.free	=3D gicv5_irq_lpi_domain_free,
 };
=20
 void __init gicv5_init_lpi_domain(void)
@@ -859,21 +869,12 @@ static int gicv5_irq_ipi_domain_alloc(struct irq_domain=
 *domain, unsigned int vi
 {
 	struct irq_data *irqd;
 	int ret, i;
-	u32 lpi;
=20
 	for (i =3D 0; i < nr_irqs; i++) {
-		ret =3D gicv5_alloc_lpi();
-		if (ret < 0)
+		ret =3D irq_domain_alloc_irqs_parent(domain, virq + i, 1, NULL);
+		if (ret)
 			return ret;
=20
-		lpi =3D ret;
-
-		ret =3D irq_domain_alloc_irqs_parent(domain, virq + i, 1, &lpi);
-		if (ret) {
-			gicv5_free_lpi(lpi);
-			return ret;
-		}
-
 		irqd =3D irq_domain_get_irq_data(domain, virq + i);
=20
 		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
@@ -899,8 +900,6 @@ static void gicv5_irq_ipi_domain_free(struct irq_domain *=
domain, unsigned int vi
 		if (!d)
 			return;
=20
-		gicv5_free_lpi(d->parent_data->hwirq);
-
 		irq_set_handler(virq + i, NULL);
 		irq_domain_reset_irq_data(d);
 		irq_domain_free_irqs_parent(domain, virq + i, 1);
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-g=
ic-v5.h
index 40d2fce..f78787e 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -425,9 +425,6 @@ struct gicv5_its_itt_cfg {
 void gicv5_init_lpis(u32 max);
 void gicv5_deinit_lpis(void);
=20
-int gicv5_alloc_lpi(void);
-void gicv5_free_lpi(u32 lpi);
-
 void __init gicv5_its_of_probe(struct device_node *parent);
 void __init gicv5_its_acpi_probe(void);
 #endif

