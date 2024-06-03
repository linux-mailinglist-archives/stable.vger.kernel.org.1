Return-Path: <stable+bounces-47861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2668D81C9
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 14:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA7B1F2383B
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274A126F1D;
	Mon,  3 Jun 2024 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fOwEt4ot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ghOnvA8/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E7126F0A;
	Mon,  3 Jun 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415994; cv=none; b=tESEqAm9TEjm8CeNGmvT6RmBJHj1sp/iYKP35We0DB1HokXdbeQCCMhlR7KSi6uQNNVi+dLQeV+O8IZaaDI67kPGBJJeAYw4PPHHBYpskWbuad3gqz6UuZyAJdFP0cvWmF1CEUueDEbf6DrK/bxg1UEfrXOGGpNF9U4/9TYOK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415994; c=relaxed/simple;
	bh=TQRPL/Oo8rr3W7nHbR/xkncUh5R8NuI+ZeJCE71XecM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VxMQ5I8wXnjgo62sGKhQ7TfQ8z8afoD5vBYLY9qjz5UBGDeMeaFwmPDKSyfIEKh6zNXLkvIK44P+a9BsxaGoWf6z1TuZ0rI7HPY2PTqVX37X2PpiWcPqxQqKCWuhRhxvvolwSIJiplSXXPVSNNVs+a9McoN5J0K+QL3saVVwwl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fOwEt4ot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ghOnvA8/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 11:59:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717415990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su/G7s/uy3NDXOkalvjbUj5RE12/Nt5IBT4vLru/iXQ=;
	b=fOwEt4otIV9mT7RwDGug39OSHXkMc4csgRtLyhQbQ7nSRgW8YYr/qwVBTiqoISiVy9JsBq
	dkIwf0Tg+aoPRJ1m9AAYKUcuCvC59+saeH+/UMB1xVHbRfWDTGPLs/BhLNoBXz/HJxru6b
	hJvF03Rxv2iIuhREi6Xp85XusmSWgmi0e3ETJ7PtOb5Pa81KGsg+0hmgu81mh57syYtDlO
	9szNq0HiXNbGy2nUvNMco0jihvBKf2mlVvmkpQr+1BH7OQ3lZx8ZRBdvnB77EwbyMuvt1t
	8VoeSAIDgH9LFzQHn3Inuv02C49xJVHTapDUtxpH5+2LWn2dxLDEmobdjGXGQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717415990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su/G7s/uy3NDXOkalvjbUj5RE12/Nt5IBT4vLru/iXQ=;
	b=ghOnvA8/I+6qs3xv31dBpLfaMZtXZImsCP4gHOQ00KfsU3HXdY+k8Sxo6QCP60v9uRdYfT
	juM7Qz3orFuah4Bw==
From: "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sifive-plic: Chain to parent IRQ after
 handlers are ready
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Anup Patel <anup@brainfault.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240529215458.937817-1-samuel.holland@sifive.com>
References: <20240529215458.937817-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171741598986.10875.3452301673328892748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e306a894bd511804ba9db7c00ca9cc05b55df1f2
Gitweb:        https://git.kernel.org/tip/e306a894bd511804ba9db7c00ca9cc05b55df1f2
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Wed, 29 May 2024 14:54:56 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 13:53:12 +02:00

irqchip/sifive-plic: Chain to parent IRQ after handlers are ready

Now that the PLIC uses a platform driver, the driver is probed later in the
boot process, where interrupts from peripherals might already be pending.

As a result, plic_handle_irq() may be called as early as the call to
irq_set_chained_handler() completes. But this call happens before the
per-context handler is completely set up, so there is a window where
plic_handle_irq() can see incomplete per-context state and crash.

Avoid this by delaying the call to irq_set_chained_handler() until all
handlers from all PLICs are initialized.

Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240529215458.937817-1-samuel.holland@sifive.com
Closes: https://lore.kernel.org/r/CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm8H0KD-wBo+4A@mail.gmail.com/
---
 drivers/irqchip/irq-sifive-plic.c | 34 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 8fb183c..9e22f7e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -85,7 +85,7 @@ struct plic_handler {
 	struct plic_priv	*priv;
 };
 static int plic_parent_irq __ro_after_init;
-static bool plic_cpuhp_setup_done __ro_after_init;
+static bool plic_global_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
@@ -487,10 +487,8 @@ static int plic_probe(struct platform_device *pdev)
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
 	u32 nr_irqs, parent_hwirq;
-	struct irq_domain *domain;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
-	bool cpuhp_setup;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -549,14 +547,6 @@ static int plic_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		/* Find parent domain and register chained handler */
-		domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
-		if (!plic_parent_irq && domain) {
-			plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
-			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
-		}
-
 		/*
 		 * When running in M-mode we need to ignore the S-mode handler.
 		 * Here we assume it always comes later, but that might be a
@@ -597,25 +587,35 @@ done:
 		goto fail_cleanup_contexts;
 
 	/*
-	 * We can have multiple PLIC instances so setup cpuhp state
+	 * We can have multiple PLIC instances so setup global state
 	 * and register syscore operations only once after context
 	 * handlers of all online CPUs are initialized.
 	 */
-	if (!plic_cpuhp_setup_done) {
-		cpuhp_setup = true;
+	if (!plic_global_setup_done) {
+		struct irq_domain *domain;
+		bool global_setup = true;
+
 		for_each_online_cpu(cpu) {
 			handler = per_cpu_ptr(&plic_handlers, cpu);
 			if (!handler->present) {
-				cpuhp_setup = false;
+				global_setup = false;
 				break;
 			}
 		}
-		if (cpuhp_setup) {
+
+		if (global_setup) {
+			/* Find parent domain and register chained handler */
+			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
+			if (domain)
+				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+			if (plic_parent_irq)
+				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
+
 			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 					  "irqchip/sifive/plic:starting",
 					  plic_starting_cpu, plic_dying_cpu);
 			register_syscore_ops(&plic_irq_syscore_ops);
-			plic_cpuhp_setup_done = true;
+			plic_global_setup_done = true;
 		}
 	}
 

