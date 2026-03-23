Return-Path: <stable+bounces-228446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFVoFPFMwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E83CD2F45CD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B2C93037ED1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2D23AF678;
	Mon, 23 Mar 2026 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rt9UoOHX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAA3AF66E;
	Mon, 23 Mar 2026 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275153; cv=none; b=b2+N216H9EuBIusolpFyWtwm1+DhFTU58/hHAGNMnL4KKo/ntGEC7fNVlU88heoCysIooLsMv2uBlaWQF4KAQVPPlnKTEYUVvLr5gOJoV/R9frMIX79NEoxYKdMCxcIW7tf121ajpOgUy8fgsNRD2TsQoIb5NOu3AzNbEjLJYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275153; c=relaxed/simple;
	bh=iapZiNxNGAiBDlPxnWl938qcD1LGUCBqJWwVQoiOYew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDQR27g21Raz30cAquPrRjqRxcC3UUsEOiq0UVS19AlmhsEKm+iNprH3Hmv/CzPx7sxQhXwf/tRG6DpVTzfKpOcl7sVwsjcCm77hL6EOX5W+PfXbMiyR35vllcyZISzuPlcwdaSAZ8RfJGbAWUT0iSJYOaScnWxEVjJ9x2uG44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rt9UoOHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E367DC2BCB3;
	Mon, 23 Mar 2026 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275153;
	bh=iapZiNxNGAiBDlPxnWl938qcD1LGUCBqJWwVQoiOYew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rt9UoOHXXq0nvLeYNhEzwW6qZazvRdFuqYFklOOdC5PpcOKRSFKQBUmKTrEcm12Z7
	 ayyDeQcFIMSLiy9lgTeMVwgMARaBx5gW8w0wZ030L614Fl5vsR+jWa39FOV7++PFMs
	 qsY7wwb6A49/oQhyWL07qc/ZGCQruuKYDBEsIe+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 004/481] irqchip/sifive-plic: Fix frozen interrupt due to affinity setting
Date: Mon, 23 Mar 2026 14:39:46 +0100
Message-ID: <20260323134525.366116269@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228446-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E83CD2F45CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nam Cao <namcao@linutronix.de>

[ Upstream commit 1072020685f4b81f6efad3b412cdae0bd62bb043 ]

PLIC ignores interrupt completion message for disabled interrupt, explained
by the specification:

    The PLIC signals it has completed executing an interrupt handler by
    writing the interrupt ID it received from the claim to the
    claim/complete register. The PLIC does not check whether the completion
    ID is the same as the last claim ID for that target. If the completion
    ID does not match an interrupt source that is currently enabled for
    the target, the completion is silently ignored.

This caused problems in the past, because an interrupt can be disabled
while still being handled and plic_irq_eoi() had no effect. That was fixed
by checking if the interrupt is disabled, and if so enable it, before
sending the completion message. That check is done with irqd_irq_disabled().

However, that is not sufficient because the enable bit for the handling
hart can be zero despite irqd_irq_disabled(d) being false. This can happen
when affinity setting is changed while a hart is still handling the
interrupt.

This problem is easily reproducible by dumping a large file to uart (which
generates lots of interrupts) and at the same time keep changing the uart
interrupt's affinity setting. The uart port becomes frozen almost
instantaneously.

Fix this by checking PLIC's enable bit instead of irqd_irq_disabled().

Fixes: cc9f04f9a84f ("irqchip/sifive-plic: Implement irq_set_affinity() for SMP host")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260212114125.3148067-1-namcao@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-sifive-plic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 36de764ee2b61..fb1dae22ab17f 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -144,8 +144,13 @@ static void plic_irq_disable(struct irq_data *d)
 static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	u32 __iomem *reg;
+	bool enabled;
 
-	if (unlikely(irqd_irq_disabled(d))) {
+	reg = handler->enable_base + (d->hwirq / 32) * sizeof(u32);
+	enabled = readl(reg) & BIT(d->hwirq % 32);
+
+	if (unlikely(!enabled)) {
 		plic_toggle(handler, d->hwirq, 1);
 		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
 		plic_toggle(handler, d->hwirq, 0);
-- 
2.51.0




