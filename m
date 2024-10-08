Return-Path: <stable+bounces-83065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136CE9953F0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D75F1F23435
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116E21DF241;
	Tue,  8 Oct 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eS5Rh8Fh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PvX3x1z"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11442040;
	Tue,  8 Oct 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403235; cv=none; b=KBWe7ZQ/edMMrdcH2ah1sFS6yLPqSYM5RemtAoWwpaL4TY5jeCHSnVI1A5bOcDnov6JzxBO5FcdI7r7QhVeE9wszgCnWJxUr5KxMAePjN1Yqaiz06olnWVaRYWrw08v9TzxFZ4avNuQNvAc7qZpzwSxTALmyMQJXqIn5vAoX2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403235; c=relaxed/simple;
	bh=EHe+qHWiZeJKDtdvme+SoICmyhSuGm1KAYVwrxrOBak=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a5RdOURpvIYCsrk+H8C9eOJ1y8N5Rf1K+W3acINVLw7TtolkFS3/44klhleCNCbaDQ1KKtIGCgMKdeRH4LCb9hPrILTYoT67CPT/1yBPoi7JZovREdJEn3T7DT8tfjnBXvFWI1tQFuHFgWT7yvTm5TQDmxNzHyslX0k5IDaOyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eS5Rh8Fh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PvX3x1z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 16:00:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728403232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVFZSY/it/5yRpT48QavbslXbhdX6LTo6lZzonud1Dc=;
	b=eS5Rh8FhKo2lPKcs9RlNYV2h7v0qAxMwI5Irnbm5n7x1LhA9cgLyWBQz0bNqbNRFaLDQ2F
	t9FQ6IvRKJJl234lQi/1o4mUByJMNzMN8QnXb7vjDpPdXMTOw82OP1BD7v4gErktBUAjII
	dsWe9Z0XQK78JPlMrQoCH75M63LafG07B8RdiuxwLbTbCMCpmmAQ+f645PKf/kVZv0GkCG
	baCYZAh8sQaP5V6j7Fd06f3fl5CLv3WQPej1m9EjZWCl2rAR8pOy82vQ0PCL2+3J4IU4mf
	jpA0zY5oePDZQgylId2Z1T2fimbLaTmnobCItooCa8xoAglroysbZ19yu0FIYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728403232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVFZSY/it/5yRpT48QavbslXbhdX6LTo6lZzonud1Dc=;
	b=3PvX3x1zyk++cUYFqbmAfdC2mJOZnDSB+D0phTHkDGH/wX7SmVIqyjpJILeaP7H23pZTz9
	BvB+o5g34VVa1/AA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20241003084152.2422969-1-namcao@linutronix.de>
References: <20241003084152.2422969-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172840323152.1442.13111325496403210240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     6b1e0651e9ce8ce418ad4ff360e7b9925dc5da79
Gitweb:        https://git.kernel.org/tip/6b1e0651e9ce8ce418ad4ff360e7b9925dc5da79
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 03 Oct 2024 10:41:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 08 Oct 2024 17:49:21 +02:00

irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()

It is possible that an interrupt is disabled and masked at the same time.
When the interrupt is enabled again by enable_irq(), only plic_irq_enable()
is called, not plic_irq_unmask(). The interrupt remains masked and never
raises.

An example where interrupt is both disabled and masked is when
handle_fasteoi_irq() is the handler, and IRQS_ONESHOT is set. The interrupt
handler:

  1. Mask the interrupt
  2. Handle the interrupt
  3. Check if interrupt is still enabled, and unmask it (see
     cond_unmask_eoi_irq())

If another task disables the interrupt in the middle of the above steps,
the interrupt will not get unmasked, and will remain masked when it is
enabled in the future.

The problem is occasionally observed when PREEMPT_RT is enabled, because
PREEMPT_RT adds the IRQS_ONESHOT flag. But PREEMPT_RT only makes the problem
more likely to appear, the bug has been around since commit a1706a1c5062
("irqchip/sifive-plic: Separate the enable and mask operations").

Fix it by unmasking interrupt in plic_irq_enable().

Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241003084152.2422969-1-namcao@linutronix.de
---
 drivers/irqchip/irq-sifive-plic.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 0b730e3..36dbcf2 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -126,16 +126,6 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	}
 }
 
-static void plic_irq_enable(struct irq_data *d)
-{
-	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
-}
-
-static void plic_irq_disable(struct irq_data *d)
-{
-	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
-}
-
 static void plic_irq_unmask(struct irq_data *d)
 {
 	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
@@ -150,6 +140,17 @@ static void plic_irq_mask(struct irq_data *d)
 	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 }
 
+static void plic_irq_enable(struct irq_data *d)
+{
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
+	plic_irq_unmask(d);
+}
+
+static void plic_irq_disable(struct irq_data *d)
+{
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
+}
+
 static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);

