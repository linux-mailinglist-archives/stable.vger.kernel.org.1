Return-Path: <stable+bounces-69728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09589958A3B
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70FAFB214A7
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC18F48;
	Tue, 20 Aug 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bCZXTTBb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nnMCdK8Z"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3346191F89;
	Tue, 20 Aug 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165676; cv=none; b=YkHHE/sHX1d/eYtFjyhiOpeH1Oo9E7HmT+4uUmf8ENndqmJ02iMS2inBXI9LPqiDpyeav75bLbNuxrlCTLJG9+dI7ePPOPe2OeMkofIvZ42k7OUV8he/t7yYHKA6GyWlYfyatLAce4WBPqiHVp4M3RBysKrkOfCPi5al1/xreVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165676; c=relaxed/simple;
	bh=igLHxAa+rJVh4KC/6DDQmCSZFQ4OZ+ZUoe9DbzPHTAk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ax99Rl5lmUbsFrSmbHLBKfCVqxMVf/d8nANt9wXCwz4h0FfMFzWmRG1qumtWks/cWkwpxXYu3Rb1pRaKjn5+liHPIIJTnPGb/OWuvQf3eBuRz5+kKMCp5XaDYw+5ZUhCSV3zfY6lVjXYx3LVYQtvsV6b8jVzNJuYCEQ+jq+/Crg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bCZXTTBb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nnMCdK8Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Aug 2024 14:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724165672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIA/OQxse/9HKaQBEsedEJ8y/J74hdcei3i79bJ+0h8=;
	b=bCZXTTBbVLDjcjbZDYMsrT93NROJAXoI/akDqai3AQ72AEFcYEO67872SqujehqhmDJYU8
	tDyQb3FP1DHMVg4Nrf1Hf110X0ANfKo5XkB3nyET7tyfqX6GI95dAgaWFVRPxG/aNMV27H
	8xHBVPs9nI4JES/EJWs6CWyW6sZs2ddeLK9C1UdvzhxwzzHucs0ZV/Euz/iaMZmOyivKW3
	lHtTBrt3si/ON0gVvu7/83oq72y3ggQcpB991tbgSw4rcgcnjN8az9stTyF70WhC/HR/Vn
	mFJv999Bc0RZAq+OzmoBwKbRJVcMriEJytnBi+7Xn3WydN5Jz1dObgTdiIgz8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724165672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIA/OQxse/9HKaQBEsedEJ8y/J74hdcei3i79bJ+0h8=;
	b=nnMCdK8ZwIHs7DPsMaEKTgNJ1dgcVpsZx/rkRXKJAuSw+PaU2o79QkaS92Ec/zFLIOw3IO
	k9CjthLITqnc2qAQ==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sifive-plic: Probe plic driver early for
 Allwinner D1 platform
Cc: Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Charlie Jenkins <charlie@rivosinc.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240820034850.3189912-1-apatel@ventanamicro.com>
References: <20240820034850.3189912-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172416567231.2215.161052933321300291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4d936f10ff80274841537a26d1fbfe9984de0ef9
Gitweb:        https://git.kernel.org/tip/4d936f10ff80274841537a26d1fbfe9984de0ef9
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Tue, 20 Aug 2024 09:18:50 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2024 16:45:20 +02:00

irqchip/sifive-plic: Probe plic driver early for Allwinner D1 platform

The latest Linux RISC-V no longer boots on the Allwinner D1 platform
because the sun4i_timer driver fails to get an interrupt from PLIC due to
the recent conversion of the PLIC to a platform driver. Converting the
sun4i timer to a platform driver does not work either because the D1 does
not have a SBI timer available so early boot hangs. See the 'Closes:'
link for deeper analysis.

The real fix requires enabling the SBI time extension in the platform
firmware (OpenSBI) and convert sun4i_timer into platform driver.
Unfortunately, the real fix involves changing multiple places and can't be
achieved in a short duration and aside of that requires users to update
firmware.

As a work-around, retrofit PLIC probing such that the PLIC is probed early
only for the Allwinner D1 platform and probed as a regular platform driver
for rest of the RISC-V platforms. In the process, partially revert some of
the previous changes because the PLIC device pointer is not available in
all probing paths.

Fixes: e306a894bd51 ("irqchip/sifive-plic: Chain to parent IRQ after handlers are ready")
Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a platform driver")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240820034850.3189912-1-apatel@ventanamicro.com
Closes: https://lore.kernel.org/lkml/20240814145642.344485-1-emil.renner.berthing@canonical.com/
---
 drivers/irqchip/irq-sifive-plic.c | 115 +++++++++++++++++------------
 1 file changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e..4d9ea71 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#define pr_fmt(fmt) "riscv-plic: " fmt
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -63,7 +64,7 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
 
 struct plic_priv {
-	struct device *dev;
+	struct fwnode_handle *fwnode;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -378,8 +379,8 @@ static void plic_handle_irq(struct irq_desc *desc)
 		int err = generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
 		if (unlikely(err)) {
-			dev_warn_ratelimited(handler->priv->dev,
-					     "can't find mapping for hwirq %lu\n", hwirq);
+			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
+					    handler->priv->fwnode, hwirq);
 		}
 	}
 
@@ -408,7 +409,8 @@ static int plic_starting_cpu(unsigned int cpu)
 		enable_percpu_irq(plic_parent_irq,
 				  irq_get_trigger_type(plic_parent_irq));
 	else
-		dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
+		pr_warn("%pfwP: cpu%d: parent irq not available\n",
+			handler->priv->fwnode, cpu);
 	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
 
 	return 0;
@@ -424,38 +426,36 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
-static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
+static int plic_parse_nr_irqs_and_contexts(struct fwnode_handle *fwnode,
 					   u32 *nr_irqs, u32 *nr_contexts)
 {
-	struct device *dev = &pdev->dev;
 	int rc;
 
 	/*
 	 * Currently, only OF fwnode is supported so extend this
 	 * function for ACPI support.
 	 */
-	if (!is_of_node(dev->fwnode))
+	if (!is_of_node(fwnode))
 		return -EINVAL;
 
-	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,ndev", nr_irqs);
 	if (rc) {
-		dev_err(dev, "riscv,ndev property not available\n");
+		pr_err("%pfwP: riscv,ndev property not available\n", fwnode);
 		return rc;
 	}
 
-	*nr_contexts = of_irq_count(to_of_node(dev->fwnode));
+	*nr_contexts = of_irq_count(to_of_node(fwnode));
 	if (WARN_ON(!(*nr_contexts))) {
-		dev_err(dev, "no PLIC context available\n");
+		pr_err("%pfwP: no PLIC context available\n", fwnode);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
+static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32 context,
 				     u32 *parent_hwirq, int *parent_cpu)
 {
-	struct device *dev = &pdev->dev;
 	struct of_phandle_args parent;
 	unsigned long hartid;
 	int rc;
@@ -464,10 +464,10 @@ static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
 	 * Currently, only OF fwnode is supported so extend this
 	 * function for ACPI support.
 	 */
-	if (!is_of_node(dev->fwnode))
+	if (!is_of_node(fwnode))
 		return -EINVAL;
 
-	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
+	rc = of_irq_parse_one(to_of_node(fwnode), context, &parent);
 	if (rc)
 		return rc;
 
@@ -480,48 +480,55 @@ static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
 	return 0;
 }
 
-static int plic_probe(struct platform_device *pdev)
+static int plic_probe(struct fwnode_handle *fwnode)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
-	struct device *dev = &pdev->dev;
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
 	u32 nr_irqs, parent_hwirq;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
+	void __iomem *regs;
 
-	if (is_of_node(dev->fwnode)) {
+	if (is_of_node(fwnode)) {
 		const struct of_device_id *id;
 
-		id = of_match_node(plic_match, to_of_node(dev->fwnode));
+		id = of_match_node(plic_match, to_of_node(fwnode));
 		if (id)
 			plic_quirks = (unsigned long)id->data;
+
+		regs = of_iomap(to_of_node(fwnode), 0);
+		if (!regs)
+			return -ENOMEM;
+	} else {
+		return -ENODEV;
 	}
 
-	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	error = plic_parse_nr_irqs_and_contexts(fwnode, &nr_irqs, &nr_contexts);
 	if (error)
-		return error;
+		goto fail_free_regs;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		error = -ENOMEM;
+		goto fail_free_regs;
+	}
 
-	priv->dev = dev;
+	priv->fwnode = fwnode;
 	priv->plic_quirks = plic_quirks;
 	priv->nr_irqs = nr_irqs;
+	priv->regs = regs;
 
-	priv->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(!priv->regs))
-		return -EIO;
-
-	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
-	if (!priv->prio_save)
-		return -ENOMEM;
+	priv->prio_save = bitmap_zalloc(nr_irqs, GFP_KERNEL);
+	if (!priv->prio_save) {
+		error = -ENOMEM;
+		goto fail_free_priv;
+	}
 
 	for (i = 0; i < nr_contexts; i++) {
-		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		error = plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu);
 		if (error) {
-			dev_warn(dev, "hwirq for context%d not found\n", i);
+			pr_warn("%pfwP: hwirq for context%d not found\n", fwnode, i);
 			continue;
 		}
 
@@ -543,7 +550,7 @@ static int plic_probe(struct platform_device *pdev)
 		}
 
 		if (cpu < 0) {
-			dev_warn(dev, "Invalid cpuid for context %d\n", i);
+			pr_warn("%pfwP: Invalid cpuid for context %d\n", fwnode, i);
 			continue;
 		}
 
@@ -554,7 +561,7 @@ static int plic_probe(struct platform_device *pdev)
 		 */
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			dev_warn(dev, "handler already present for context %d.\n", i);
+			pr_warn("%pfwP: handler already present for context %d.\n", fwnode, i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -568,8 +575,8 @@ static int plic_probe(struct platform_device *pdev)
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
-		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
-						    sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
+					       sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
 			goto fail_cleanup_contexts;
 done:
@@ -581,7 +588,7 @@ done:
 		nr_handlers++;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
+	priv->irqdomain = irq_domain_add_linear(to_of_node(fwnode), nr_irqs + 1,
 						&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto fail_cleanup_contexts;
@@ -619,13 +626,13 @@ done:
 		}
 	}
 
-	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
-		 nr_irqs, nr_handlers, nr_contexts);
+	pr_info("%pfwP: mapped %d interrupts with %d handlers for %d contexts.\n",
+		fwnode, nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 fail_cleanup_contexts:
 	for (i = 0; i < nr_contexts; i++) {
-		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+		if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu))
 			continue;
 		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
 			continue;
@@ -634,17 +641,37 @@ fail_cleanup_contexts:
 		handler->present = false;
 		handler->hart_base = NULL;
 		handler->enable_base = NULL;
+		kfree(handler->enable_save);
 		handler->enable_save = NULL;
 		handler->priv = NULL;
 	}
-	return -ENOMEM;
+	bitmap_free(priv->prio_save);
+fail_free_priv:
+	kfree(priv);
+fail_free_regs:
+	iounmap(regs);
+	return error;
+}
+
+static int plic_platform_probe(struct platform_device *pdev)
+{
+	return plic_probe(pdev->dev.fwnode);
 }
 
 static struct platform_driver plic_driver = {
 	.driver = {
 		.name		= "riscv-plic",
 		.of_match_table	= plic_match,
+		.suppress_bind_attrs = true,
 	},
-	.probe = plic_probe,
+	.probe = plic_platform_probe,
 };
 builtin_platform_driver(plic_driver);
+
+static int __init plic_early_probe(struct device_node *node,
+				   struct device_node *parent)
+{
+	return plic_probe(&node->fwnode);
+}
+
+IRQCHIP_DECLARE(riscv, "allwinner,sun20i-d1-plic", plic_early_probe);

