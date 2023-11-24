Return-Path: <stable+bounces-2449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1EC7F8437
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D421C25399
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D87381D2;
	Fri, 24 Nov 2023 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tidZhIcy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7D35F1A;
	Fri, 24 Nov 2023 19:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B9EC433C7;
	Fri, 24 Nov 2023 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853910;
	bh=rS7gJLjEns6FeNQvQ2HvMKXRszYXePu92PLL+Uc/0iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tidZhIcy0HyTwCkdjzsOStV3Ea29mc2vdzX60xf3h2n8ko4lOvFIe4GU5NPs6hHvw
	 DeO4TJb+at1q1rO0TRJF7V5r5MWJtzIFrnF2SxQTOe9CyeRHPDL08YEMqgpUETK1tk
	 8PC6RfQa/3U/JexDUli9GtgIfYbW/wuZk9+vRJFc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.4 080/159] genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware
Date: Fri, 24 Nov 2023 17:54:57 +0000
Message-ID: <20231124171945.263717280@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit 5e7afb2eb7b2a7c81e9f608cbdf74a07606fd1b5 upstream.

irq_remove_generic_chip() calculates the Linux interrupt number for removing the
handler and interrupt chip based on gc::irq_base as a linear function of
the bit positions of set bits in the @msk argument.

When the generic chip is present in an irq domain, i.e. created with a call
to irq_alloc_domain_generic_chips(), gc::irq_base contains not the base
Linux interrupt number.  It contains the base hardware interrupt for this
chip. It is set to 0 for the first chip in the domain, 0 + N for the next
chip, where $N is the number of hardware interrupts per chip.

That means the Linux interrupt number cannot be calculated based on
gc::irq_base for irqdomain based chips without a domain map lookup, which
is currently missing.

Rework the code to take the irqdomain case into account and calculate the
Linux interrupt number by a irqdomain lookup of the domain specific
hardware interrupt number.

[ tglx: Massage changelog. Reshuffle the logic and add a proper comment. ]

Fixes: cfefd21e693d ("genirq: Add chip suspend and resume callbacks")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231024150335.322282-1-herve.codina@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/generic-chip.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -537,21 +537,34 @@ EXPORT_SYMBOL_GPL(irq_setup_alt_chip);
 void irq_remove_generic_chip(struct irq_chip_generic *gc, u32 msk,
 			     unsigned int clr, unsigned int set)
 {
-	unsigned int i = gc->irq_base;
+	unsigned int i, virq;
 
 	raw_spin_lock(&gc_lock);
 	list_del(&gc->list);
 	raw_spin_unlock(&gc_lock);
 
-	for (; msk; msk >>= 1, i++) {
+	for (i = 0; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))
 			continue;
 
+		/*
+		 * Interrupt domain based chips store the base hardware
+		 * interrupt number in gc::irq_base. Otherwise gc::irq_base
+		 * contains the base Linux interrupt number.
+		 */
+		if (gc->domain) {
+			virq = irq_find_mapping(gc->domain, gc->irq_base + i);
+			if (!virq)
+				continue;
+		} else {
+			virq = gc->irq_base + i;
+		}
+
 		/* Remove handler first. That will mask the irq line */
-		irq_set_handler(i, NULL);
-		irq_set_chip(i, &no_irq_chip);
-		irq_set_chip_data(i, NULL);
-		irq_modify_status(i, clr, set);
+		irq_set_handler(virq, NULL);
+		irq_set_chip(virq, &no_irq_chip);
+		irq_set_chip_data(virq, NULL);
+		irq_modify_status(virq, clr, set);
 	}
 }
 EXPORT_SYMBOL_GPL(irq_remove_generic_chip);



