Return-Path: <stable+bounces-54954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDDE913BFC
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B621283306
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE01822ED;
	Sun, 23 Jun 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fsZ3bkzI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKPmPj1J"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EC148847;
	Sun, 23 Jun 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155595; cv=none; b=cED6mtrWnJBJ2RCYCJrIRyKriMEH7iu/UcPFy3XLYkzqYr7sMi7Sojf0wg7YszyWCf9fI8hAa1U0QABhYYoIhTOQcPt5dXyZ/1LmuBhnnfp04ydIRUZPFt9ZxU8W95LevUILh3NimOjZbzNWiqH29AzX1zY9GucrFI4QCdq00rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155595; c=relaxed/simple;
	bh=vWw7+c6oWqBm+iDhw7A59n4dUbviPf9IG6wJGeOBWMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dPH5IVQZRgkqee+xf3+WmfXHYmZq+cruSkCEpttiqtriwoV4ewXaQlLaryjJHeqLT8Gj8xUkdgeobNcfmaI6ybsE90XSaLKkyDyNIT1pJVI9K6k0Pa37E55Bv0ysknTh3Rs9ztOoDLRBF23bIdbW2IwwRFoqswK3UH+m335JsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fsZ3bkzI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKPmPj1J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:13:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H+po3c7F5CM8aXqjsBE5Bx59LYkOWF7Y5U+YBWcDHY=;
	b=fsZ3bkzI1HBZHyloseDYN1YVWZ1Qlh/B5He0nbYeNfMHzBeSIUVBnnolu4LLFLvMeBnOps
	t3Ki8a6XTxeeZfxaVVPO8Txj4TtzKu0V2l3B5lwj+xJIXSQF88Sr7LtEKHbKwTY6nANHCA
	gtyHSDINGA2FWatm/9rGCCSznJS3i8cidFb3PB1NN/l/9yHYYSRqv/gBpCqsp3cyDrZiJX
	G62PYo1thOm8/tIP/NxortG9bzwBzn4vacXXfkAkH2u9dK7qnVPFwz+lfic2pmWDPIbxs0
	7Cr2d7FmxwejqkTT5zAV/zUwpohaaaFKpB7xPIVK7/N5l9x5UZglqfmZdpkvtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H+po3c7F5CM8aXqjsBE5Bx59LYkOWF7Y5U+YBWcDHY=;
	b=yKPmPj1J+dxjl0fhzxE1okXrLT5oiO05WUPPtfGZAhRx+joQ07WdnKVXY+TGOh8l1AM8im
	bUh4+v6RLWiI0rCg==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/loongson-eiointc: Use early_cpu_to_node()
 instead of cpu_to_node()
Cc: Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240623034113.1808727-1-chenhuacai@loongson.cn>
References: <20240623034113.1808727-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915559061.10875.15340919971108942475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     2d64eaeeeda5659d52da1af79d237269ba3c2d2c
Gitweb:        https://git.kernel.org/tip/2d64eaeeeda5659d52da1af79d237269ba3c2d2c
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Sun, 23 Jun 2024 11:41:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:09:26 +02:00

irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()

Multi-bridge machines required that all eiointc controllers in the system
are initialized, otherwise the system does not boot.

The initialization happens on the boot CPU during early boot and relies on
cpu_to_node() for identifying the individual nodes.

That works when the number of possible CPUs is large enough, but with a
command line limit, e.g. "nr_cpus=$N" for kdump, but fails when the CPUs
of the secondary nodes are not covered.

During early ACPI enumeration all CPU to node mappings are recorded up to
CONFIG_NR_CPUS. These are accessible via early_cpu_to_node() even in the
case that "nr_cpus=N" truncates the number of possible CPUs and only
provides the possible CPUs via cpu_to_node() translation.

Change the node lookup in the driver to use early_cpu_to_node() so that
even with a limitation on the number of possible CPUs all eointc instances
are initialized.

This can't obviously cure the case where CONFIG_NR_CPUS is too small.

[ tglx: Massaged changelog ]

Fixes: 64cc451e45e1 ("irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240623034113.1808727-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index c7ddebf..b1f2080 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -15,6 +15,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/kernel.h>
 #include <linux/syscore_ops.h>
+#include <asm/numa.h>
 
 #define EIOINTC_REG_NODEMAP	0x14a0
 #define EIOINTC_REG_IPMAP	0x14c0
@@ -339,7 +340,7 @@ static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 	int node;
 
 	if (cpu_has_flatmode)
-		node = cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
+		node = early_cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
 	else
 		node = eiointc_priv[nr_pics - 1]->node;
 
@@ -431,7 +432,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 		goto out_free_handle;
 
 	if (cpu_has_flatmode)
-		node = cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
+		node = early_cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
 	else
 		node = acpi_eiointc->node;
 	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);

