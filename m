Return-Path: <stable+bounces-251163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH44FasVDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:12:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F68A599431
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1F031A419B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371DD3F44C9;
	Wed, 20 May 2026 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F+xrWLpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C263F44CD;
	Wed, 20 May 2026 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297264; cv=none; b=Uwx3TL9ys8hLrwOiAfWSZ7Q9YHTLpuSlRzs4/lLSgs9urGZTRklB4u/Lg/WCZFrvrLaxdGc8h1FxSgzedyBow4AMedJbjnjLJUQI3gDOVODN/BClWRjSOEO2EG/+cOI92pOGB9VLHvVd36af10HNXYHEPPSPuKuyu4omhxtW1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297264; c=relaxed/simple;
	bh=R0QsV5Lm/F3PW5CSI5UVzETlMLhEs0sfy8sHzUhG3pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1p5F4QHrSx0L7hdN2LB9M3sFNhaoa6K8OlujWQzWmxl3u+dFLObuRAP7AHkR+qBLDE7v126IexJ2H+6ON3Vq1r7gB10OUpTvBqANd7gUxrloUqkQjJeJBU//24XSqemg6NuDYRZ09CVt4SEn5xzyFdEB4xu5IClJuiXYrstdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F+xrWLpz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55F21F000E9;
	Wed, 20 May 2026 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297262;
	bh=bxHQnnKzRzNA5V6GTH8duCGYrmhi3bW2X4SqflXMCss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+xrWLpzVdJ//dT21E105AWRYXYDUdiUyssR/1W5w0/bRRtwYqYU43nedFaRS0PxE
	 c/1qBGG9LHCutmwfzj0sM/HPrcKRlEu0QPUTAvp6EDdSN1xGjuOCMHWwLcJ1EmUG/j
	 b5tVfuoXpsiD5jBmzEoevo091m4/Qu6wndQGvHGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 7.0 1112/1146] irqchip/gic-v5: Support range allocation for LPIs
Date: Wed, 20 May 2026 18:22:42 +0200
Message-ID: <20260520162213.411382716@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251163-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 6F68A599431
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sascha Bischoff <Sascha.Bischoff@arm.com>

commit eb6f6d523813ead9dc2799194a2839d42c049734 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v5.c |   77 +++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -783,15 +783,14 @@ static void gicv5_irq_lpi_domain_free(st
 {
 	struct irq_data *d;
 
-	if (WARN_ON_ONCE(nr_irqs != 1))
-		return;
+	for (unsigned int i = 0; i < nr_irqs; i++, virq++) {
+		d = irq_domain_get_irq_data(domain, virq);
 
-	d = irq_domain_get_irq_data(domain, virq);
+		release_lpi(d->hwirq);
 
-	release_lpi(d->hwirq);
-
-	irq_set_handler(virq, NULL);
-	irq_domain_reset_irq_data(d);
+		irq_set_handler(virq, NULL);
+		irq_domain_reset_irq_data(d);
+	}
 }
 
 static int gicv5_irq_lpi_domain_alloc(struct irq_domain *domain, unsigned int virq,
@@ -799,32 +798,39 @@ static int gicv5_irq_lpi_domain_alloc(st
 {
 	irq_hw_number_t hwirq;
 	struct irq_data *irqd;
+	unsigned int i;
 	int ret;
 
-	if (WARN_ON_ONCE(nr_irqs != 1))
-		return -EINVAL;
-
-	ret = alloc_lpi();
-	if (ret < 0)
-		return ret;
-	hwirq = ret;
+	for (i = 0; i < nr_irqs; i++) {
+		ret = alloc_lpi();
+		if (ret < 0)
+			goto out_free_lpis;
+		hwirq = ret;
+
+		ret = gicv5_irs_iste_alloc(hwirq);
+		if (ret < 0) {
+			/* Undo partial state first, then clean up the rest */
+			release_lpi(hwirq);
+			goto out_free_lpis;
+		}
 
-	irqd = irq_domain_get_irq_data(domain, virq);
+		irqd = irq_domain_get_irq_data(domain, virq + i);
 
-	irq_domain_set_info(domain, virq, hwirq, &gicv5_lpi_irq_chip, NULL,
-			    handle_fasteoi_irq, NULL, NULL);
-	irqd_set_single_target(irqd);
+		irq_domain_set_info(domain, virq + i, hwirq, &gicv5_lpi_irq_chip,
+				    NULL, handle_fasteoi_irq, NULL, NULL);
+		irqd_set_single_target(irqd);
 
-	ret = gicv5_irs_iste_alloc(hwirq);
-	if (ret < 0) {
-		release_lpi(hwirq);
-		return ret;
+		gicv5_hwirq_init(hwirq, GICV5_IRQ_PRI_MI, GICV5_HWIRQ_TYPE_LPI);
+		gicv5_lpi_config_reset(irqd);
 	}
 
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
 
 static const struct irq_domain_ops gicv5_irq_lpi_domain_ops = {
@@ -850,21 +856,21 @@ static int gicv5_irq_ipi_domain_alloc(st
 				      unsigned int nr_irqs, void *arg)
 {
 	struct irq_data *irqd;
-	int ret, i;
+	int ret;
 
-	for (i = 0; i < nr_irqs; i++) {
-		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1, NULL);
-		if (ret)
-			return ret;
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret)
+		return ret;
 
-		irqd = irq_domain_get_irq_data(domain, virq + i);
+	for (unsigned int i = 0; i < nr_irqs; i++, virq++) {
+		irqd = irq_domain_get_irq_data(domain, virq);
 
-		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
-				&gicv5_ipi_irq_chip, NULL);
+		irq_domain_set_hwirq_and_chip(domain, virq, i,
+					      &gicv5_ipi_irq_chip, NULL);
 
 		irqd_set_single_target(irqd);
 
-		irq_set_handler(virq + i, handle_percpu_irq);
+		irq_set_handler(virq, handle_percpu_irq);
 	}
 
 	return 0;
@@ -884,8 +890,9 @@ static void gicv5_irq_ipi_domain_free(st
 
 		irq_set_handler(virq + i, NULL);
 		irq_domain_reset_irq_data(d);
-		irq_domain_free_irqs_parent(domain, virq + i, 1);
 	}
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
 static const struct irq_domain_ops gicv5_irq_ipi_domain_ops = {



