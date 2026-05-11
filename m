Return-Path: <stable+bounces-245198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAEGLAfVAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:09:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB20F50E991
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9950F3029448
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C663D75C9;
	Mon, 11 May 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yy6X5iiA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VIr9Q2HK"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B43A1A2F;
	Mon, 11 May 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504412; cv=none; b=ZsF54iNOvq9AQ7kZf/zDKm5qadDkxPhHAwohxWMEd2TXyI/j98mdJqJXPdq8pYsGt4MX14jvYV5k6kE/Q40A/QcZ3CF4QOpKMtp68A58wegmx74PjhI5+1VyRRKc4vmGN/5sTBV07pQzgm+rCP+QammZRex90+3fenE9/QgXcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504412; c=relaxed/simple;
	bh=E22K32CGAnPu8NZQ2xj1llMmlRlbr5u3bB/hXdHzz2M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MALDW7qdenJSIAh+GpHE7mR4n5I10iu4ZrRqTncc780ot4zi+tDF0K18VyEAAphA2OaXNcdKVFaqZJcXLfAovaNpqa/PayM9PgdLmeXmTSouJMQPKrCHf2Z5c4OAeec31NFbYcnq/T/xAuWs/2uDcDCSGiVxMBh6WOx7D82PbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yy6X5iiA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VIr9Q2HK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 May 2026 13:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778504409;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CChJ4dxFg1orCIOhafG1TVwMlcSDWgqOL32pkORQyU=;
	b=Yy6X5iiAbDGhWI1S1XfkHTtEZgCfQqWeXW6f7QkA2nQc/g9c15Nkk+m7vhspMov532ne7P
	7cbiG63MR53DtRyJ3iH0NeAnAJdIwliqXs5vi52hRFzYYBi5l4gJx5X2iPrgi4tFLUpG1D
	cvdGPCJavRt9GcwOsOj2fWaCCO8nmbWKit7AC/gCKTGxfD6L3Ey82KYEJrGbgtP8jRcVEW
	3faSxUgNGWUNjDvDbb8QXKTV0NXnZsFn2J2tz0YKmlCxlJrMo55QNnKBbROL78ajDXy1HI
	56iD3kAFaAlczErylyCVYIoAMKw+A5j8YRlzxSmuqR8H1UHuMSYWy6zi0NhKUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778504409;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CChJ4dxFg1orCIOhafG1TVwMlcSDWgqOL32pkORQyU=;
	b=VIr9Q2HKk5dS0NwjcXbvaelFxx32skfpcP8nb0JlfXoBdwVWtTDjWivxRZgg1S1omfZ8M3
	+oB07k7QjrbwcOAw==
From: "tip-bot2 for Sascha Bischoff" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v5: Allocate ITS parent LPIs as a range
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260506093634.382062-4-sascha.bischoff@arm.com>
References: <20260506093634.382062-4-sascha.bischoff@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177850440785.188840.12841305612405622836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EB20F50E991
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
	TAGGED_FROM(0.00)[bounces-245198-lists,stable=lfdr.de];
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

Commit-ID:     a7c7e42654b6a8676610ee09d22901432c4851af
Gitweb:        https://git.kernel.org/tip/a7c7e42654b6a8676610ee09d22901432c4=
851af
Author:        Sascha Bischoff <Sascha.Bischoff@arm.com>
AuthorDate:    Wed, 06 May 2026 09:37:43=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 11 May 2026 14:56:04 +02:00

irqchip/gic-v5: Allocate ITS parent LPIs as a range

The ITS MSI domain no longer manages LPI allocation directly. LPIs are
allocated and freed by the parent LPI domain, which can now handle a
full range of interrupts and unwind partial allocations internally.

Make the ITS domain request and release the parent IRQs as a single
range instead of iterating over each interrupt. The ITS allocation
path then only needs to reserve EventIDs, allocate the parent range,
and fill in the ITS irq_data for each MSI. Since no operation in the
per-MSI loop can fail, the partial parent-free unwind becomes
unnecessary.

On teardown, reset the ITS irq_data for the range and then release the
parent range in one call, leaving LPI teardown to the LPI domain.

Fixes: 0f0101325876 ("irqchip/gic-v5: Add GICv5 LPI/IPI support")
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260506093634.382062-4-sascha.bischoff@arm.com
---
 drivers/irqchip/irq-gic-v5-its.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 36d03f8..28e39b0 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -937,6 +937,7 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *=
domain, unsigned int vi
 	int ret, i;
=20
 	its_dev =3D info->scratchpad[0].ptr;
+	device_id =3D its_dev->device_id;
=20
 	ret =3D gicv5_its_alloc_eventid(its_dev, info, nr_irqs, &event_id_base);
 	if (ret)
@@ -946,14 +947,11 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain=
 *domain, unsigned int vi
 	if (ret)
 		goto out_eventid;
=20
-	device_id =3D its_dev->device_id;
+	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, NULL);
+	if (ret)
+		goto out_eventid;
=20
 	for (i =3D 0; i < nr_irqs; i++) {
-		ret =3D irq_domain_alloc_irqs_parent(domain, virq + i, 1, NULL);
-		if (ret) {
-			goto out_free_irqs;
-		}
-
 		/*
 		 * Store eventid and deviceid into the hwirq for later use.
 		 *
@@ -972,12 +970,6 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain =
*domain, unsigned int vi
=20
 	return 0;
=20
-out_free_irqs:
-	while (--i >=3D 0) {
-		irqd =3D irq_domain_get_irq_data(domain, virq + i);
-		irq_domain_reset_irq_data(irqd);
-		irq_domain_free_irqs_parent(domain, virq + i, 1);
-	}
 out_eventid:
 	gicv5_its_free_eventid(its_dev, event_id_base, nr_irqs);
 	return ret;
@@ -1000,14 +992,14 @@ static void gicv5_its_irq_domain_free(struct irq_domai=
n *domain, unsigned int vi
 	bitmap_release_region(its_dev->event_map, event_id_base,
 			      get_count_order(nr_irqs));
=20
-	/*  Hierarchically free irq data */
 	for (i =3D 0; i < nr_irqs; i++) {
 		d =3D irq_domain_get_irq_data(domain, virq + i);
-
 		irq_domain_reset_irq_data(d);
-		irq_domain_free_irqs_parent(domain, virq + i, 1);
 	}
=20
+	/*  Hierarchically free irq data */
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+
 	gicv5_its_syncr(its, its_dev);
 	gicv5_irs_syncr();
 }

