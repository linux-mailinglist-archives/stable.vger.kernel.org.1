Return-Path: <stable+bounces-56241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED6191E24C
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D011F261F1
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3C161314;
	Mon,  1 Jul 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dD74boSd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44598C1D
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843800; cv=none; b=fHCE+6XKNyJHj8djpzbJWKcDf9EITY5v2nLex8t8x0LqXJEK/Y+Og/03gZdVcm3ixzoCW420c7W7YUkI5ss38yTpCFpdG9rVoNObv+U8tbZHaI5HQaVonfVTk7qTEG0JqZHsFQD1KLqtHgXG+dUPO2DIXt6umSCL/ERex9ddfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843800; c=relaxed/simple;
	bh=J2UM06+dhQetqQwiOOzNRseBC6Nw+BUD9kvW9JULx0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iOXI0QIOTN3mmwwvu/KqhRq5nHw2qlTLp6ubgQ4TSwlZbTz44RzhRQ7xJt3LGc9dgxFZyRiu+0DtP/jyYo2fpxP8nynU7TWBUQCF3fFEOpmKNqZLE7AHQqyDafwD8pUk1DrRiJom95lLMe/IzD4YmrhC+bAK5gklLIscBxQwxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dD74boSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F130C116B1;
	Mon,  1 Jul 2024 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719843800;
	bh=J2UM06+dhQetqQwiOOzNRseBC6Nw+BUD9kvW9JULx0I=;
	h=Subject:To:Cc:From:Date:From;
	b=dD74boSdBai+CztjOMWrUZOy3Cf7kLiK2VtGSfv5Ls7oL9qyySvofIotmkl+BbZ21
	 5H4KxCjGpxrFuovomHx/DrSZ0wcbrpPFBOYiyid7glSKCLVyu8tqt+9fXKLs0fx8m9
	 rchVqWVWnqTNQ+nWbbslMump5tj4kg9gHA5SSVjc=
Subject: FAILED: patch "[PATCH] irqchip/loongson-eiointc: Use early_cpu_to_node() instead of" failed to apply to 6.1-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:23:17 +0200
Message-ID: <2024070117-entire-chaperone-b7a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2d64eaeeeda5659d52da1af79d237269ba3c2d2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070117-entire-chaperone-b7a4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

2d64eaeeeda5 ("irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()")
64cc451e45e1 ("irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent")
3d12938dbc04 ("irqchip/loongarch: Adjust acpi_cascade_irqdomain_init() and sub-routines")
a90335c2dfb4 ("irqchip/loongson-eiointc: Add suspend/resume support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2d64eaeeeda5659d52da1af79d237269ba3c2d2c Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 23 Jun 2024 11:41:13 +0800
Subject: [PATCH] irqchip/loongson-eiointc: Use early_cpu_to_node() instead of
 cpu_to_node()

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

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index c7ddebf312ad..b1f2080be2be 100644
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


