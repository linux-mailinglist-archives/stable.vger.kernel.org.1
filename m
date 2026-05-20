Return-Path: <stable+bounces-252171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCuoLjb4DWqR5AUAu9opvQ
	(envelope-from <stable+bounces-252171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:06:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF3595502
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 081D6311B351
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4B3F4DD7;
	Wed, 20 May 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q3XTofTL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504D3FADF7;
	Wed, 20 May 2026 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299978; cv=none; b=JVwoC4A/xjCflrwFEe48lvWnl/AoXqDfLslB0cht/XO/e8RYi8RnL0FbCx2crvsB+BMXO7hO6MDrXvCm2dMGj5gL856ieZwnvnYYpjUT6TBSIhlErZ36no0Yhe9KsKh0xg80QkZb0EuJJrg519y6p4PqhBIGhJOX9HSWIOu06vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299978; c=relaxed/simple;
	bh=hDusOy1mYLD3CHe80Nsj83ojH3hujLlkQxgNXQMJH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUY2uiXxVSnAR1PDfNagRoVhyBIbSN+w4149k+NtRdnEq6qB9liR12SwdeaCPwi1Zkv+XaE3Hh9JGEiEU2zx7EmTwTbXyJNgTsngsFTgttOVdOVoXwACHCUtg+Y+zaB/b15mUL3fjtnd0HjRiWKPVvv1Gk2kUwnQsb/6UdywNwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q3XTofTL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91131F000E9;
	Wed, 20 May 2026 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299976;
	bh=peEJ33g11A2Xr896zi7jcOQFN6N7vVsmQZJLI9U6MJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q3XTofTL1T52dQXuhmtL5avHzCoEzlEEIDCkmfi+o0qyjcsfbAPHePZ2IE1BQz8X2
	 sRpfcrdxW5A3/fyXOtXqzE9+LftPr6nmONsSEpJtzDfjdQy4hTY6RaOsQYFEL8t2vw
	 y4tKcpwvgE+IZ46EKF2o38DYE5K3pgxGo7NAEG5Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 6.18 931/957] irqchip/gic-v5: Support range allocation for LPIs
Date: Wed, 20 May 2026 18:23:34 +0200
Message-ID: <20260520162154.778723911@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252171-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 4BEF3595502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -746,15 +746,14 @@ static void gicv5_irq_lpi_domain_free(st
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
@@ -762,32 +761,39 @@ static int gicv5_irq_lpi_domain_alloc(st
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
@@ -813,21 +819,21 @@ static int gicv5_irq_ipi_domain_alloc(st
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
@@ -847,8 +853,9 @@ static void gicv5_irq_ipi_domain_free(st
 
 		irq_set_handler(virq + i, NULL);
 		irq_domain_reset_irq_data(d);
-		irq_domain_free_irqs_parent(domain, virq + i, 1);
 	}
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
 static const struct irq_domain_ops gicv5_irq_ipi_domain_ops = {



