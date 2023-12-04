Return-Path: <stable+bounces-3839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9F802DC7
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433411C209D2
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8506FFBF6;
	Mon,  4 Dec 2023 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j//CgpC7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5nDLT7H"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC8A8
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 01:06:03 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701680761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0RHPuylzjf2VY8WqL6+gEk3yXY54fNHKs28poMiXGQ=;
	b=j//CgpC7MK7zdwA/T4PHenWHV/07wFhIPAkJu0LjLoP9Pqa5gZLp8ZvF1SGd11tEw/1Stk
	/kzwMoktMFvq1H9/b/mLfiTgt5c5eblEH7R+Xtgo4zm32sZFAyBh2IkCGg3ZLqCUMKMfUS
	FEAIN10axkgRbJOJLoF2ocqTuuWxA058Ha4syY43bzn3di+kPdbW6t6Po2fWFQY7cKZW5r
	fMNcpb602n+xpsHqJq+EuvYQBA4VP9h95XpVKTt47WafuPpaWLYHStbpRY8pLQ/8o1CrGH
	jLzIZwr93V3UWgJz5iV/bdzrWQ2pv+0qldKh3yQt14X5cJLCpyb2RuMYn0I1aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701680761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0RHPuylzjf2VY8WqL6+gEk3yXY54fNHKs28poMiXGQ=;
	b=R5nDLT7HXxwu1uEDbBtJdK15wm24s/XwqyQd/PXlZIRtMomxTm8CbMYYWFw8nchSrVnWdL
	mbDTbtZXftTPAzBA==
To: gregkh@linuxfoundation.org, den@valinux.co.jp
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/apic/msi: Fix misconfigured
 non-maskable MSI quirk" failed to apply to 6.1-stable tree
In-Reply-To: <2023112040-sudden-savanna-4847@gregkh>
References: <2023112040-sudden-savanna-4847@gregkh>
Date: Mon, 04 Dec 2023 10:06:00 +0100
Message-ID: <878r6axrpj.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 20 2023 at 16:28, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

See below.

Thanks,

        tglx
---
From: Koichiro Den <den@valinux.co.jp>
Date: Thu Oct 26 12:20:36 2023 +0900
Subject: x86/apic/msi: Fix misconfigured non-maskable MSI quirk

commit b56ebe7c896dc78b5865ec2c4b1dae3c93537517 upstream.

commit ef8dd01538ea ("genirq/msi: Make interrupt allocation less
convoluted"), reworked the code so that the x86 specific quirk for affinity
setting of non-maskable PCI/MSI interrupts is not longer activated if
necessary.

This could be solved by restoring the original logic in the core MSI code,
but after a deeper analysis it turned out that the quirk flag is not
required at all.

The quirk is only required when the PCI/MSI device cannot mask the MSI
interrupts, which in turn also prevents reservation mode from being enabled
for the affected interrupt.

This allows ot remove the NOMASK quirk bit completely as msi_set_affinity()
can instead check whether reservation mode is enabled for the interrupt,
which gives exactly the same answer.

Even in the momentary non-existing case that the reservation mode would be
not set for a maskable MSI interrupt this would not cause any harm as it
just would cause msi_set_affinity() to go needlessly through the
functionaly equivalent slow path, which works perfectly fine with maskable
interrupts as well.

Rework msi_set_affinity() to query the reservation mode and remove all
NOMASK quirk logic from the core code.

[ tglx: Massaged changelog ]

Fixes: ef8dd01538ea ("genirq/msi: Make interrupt allocation less convoluted")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231026032036.2462428-1-den@valinux.co.jp
---
 arch/x86/kernel/apic/msi.c |    8 +++-----
 include/linux/irq.h        |   24 +++---------------------
 kernel/irq/debugfs.c       |    1 -
 kernel/irq/msi.c           |   12 +-----------
 4 files changed, 7 insertions(+), 38 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -55,14 +55,14 @@ msi_set_affinity(struct irq_data *irqd,
 	 * caused by the non-atomic update of the address/data pair.
 	 *
 	 * Direct update is possible when:
-	 * - The MSI is maskable (remapped MSI does not use this code path)).
-	 *   The quirk bit is not set in this case.
+	 * - The MSI is maskable (remapped MSI does not use this code path).
+	 *   The reservation mode bit is set in this case.
 	 * - The new vector is the same as the old vector
 	 * - The old vector is MANAGED_IRQ_SHUTDOWN_VECTOR (interrupt starts up)
 	 * - The interrupt is not yet started up
 	 * - The new destination CPU is the same as the old destination CPU
 	 */
-	if (!irqd_msi_nomask_quirk(irqd) ||
+	if (!irqd_can_reserve(irqd) ||
 	    cfg->vector == old_cfg.vector ||
 	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
 	    !irqd_is_started(irqd) ||
@@ -202,8 +202,6 @@ struct irq_domain * __init native_create
 	if (!d) {
 		irq_domain_free_fwnode(fn);
 		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
-	} else {
-		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 	}
 	return d;
 }
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -215,8 +215,6 @@ struct irq_data {
  * IRQD_SINGLE_TARGET		- IRQ allows only a single affinity target
  * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  * IRQD_CAN_RESERVE		- Can use reservation mode
- * IRQD_MSI_NOMASK_QUIRK	- Non-maskable MSI quirk for affinity change
- *				  required
  * IRQD_HANDLE_ENFORCE_IRQCTX	- Enforce that handle_irq_*() is only invoked
  *				  from actual interrupt context.
  * IRQD_AFFINITY_ON_ACTIVATE	- Affinity is set on activation. Don't call
@@ -245,10 +243,9 @@ enum {
 	IRQD_SINGLE_TARGET		= (1 << 24),
 	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
 	IRQD_CAN_RESERVE		= (1 << 26),
-	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
-	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
-	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
-	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
+	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 27),
+	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 28),
+	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 29),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -423,21 +420,6 @@ static inline bool irqd_can_reserve(stru
 	return __irqd_to_state(d) & IRQD_CAN_RESERVE;
 }
 
-static inline void irqd_set_msi_nomask_quirk(struct irq_data *d)
-{
-	__irqd_to_state(d) |= IRQD_MSI_NOMASK_QUIRK;
-}
-
-static inline void irqd_clr_msi_nomask_quirk(struct irq_data *d)
-{
-	__irqd_to_state(d) &= ~IRQD_MSI_NOMASK_QUIRK;
-}
-
-static inline bool irqd_msi_nomask_quirk(struct irq_data *d)
-{
-	return __irqd_to_state(d) & IRQD_MSI_NOMASK_QUIRK;
-}
-
 static inline void irqd_set_affinity_on_activate(struct irq_data *d)
 {
 	__irqd_to_state(d) |= IRQD_AFFINITY_ON_ACTIVATE;
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -121,7 +121,6 @@ static const struct irq_bit_descr irqdat
 	BIT_MASK_DESCR(IRQD_AFFINITY_ON_ACTIVATE),
 	BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
 	BIT_MASK_DESCR(IRQD_CAN_RESERVE),
-	BIT_MASK_DESCR(IRQD_MSI_NOMASK_QUIRK),
 
 	BIT_MASK_DESCR(IRQD_FORWARDED_TO_VCPU),
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -807,7 +807,6 @@ static int msi_handle_pci_fail(struct ir
 
 #define VIRQ_CAN_RESERVE	0x01
 #define VIRQ_ACTIVATE		0x02
-#define VIRQ_NOMASK_QUIRK	0x04
 
 static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflags)
 {
@@ -816,8 +815,6 @@ static int msi_init_virq(struct irq_doma
 
 	if (!(vflags & VIRQ_CAN_RESERVE)) {
 		irqd_clr_can_reserve(irqd);
-		if (vflags & VIRQ_NOMASK_QUIRK)
-			irqd_set_msi_nomask_quirk(irqd);
 
 		/*
 		 * If the interrupt is managed but no CPU is available to
@@ -877,15 +874,8 @@ int __msi_domain_alloc_irqs(struct irq_d
 	 * Interrupt can use a reserved vector and will not occupy
 	 * a real device vector until the interrupt is requested.
 	 */
-	if (msi_check_reservation_mode(domain, info, dev)) {
+	if (msi_check_reservation_mode(domain, info, dev))
 		vflags |= VIRQ_CAN_RESERVE;
-		/*
-		 * MSI affinity setting requires a special quirk (X86) when
-		 * reservation mode is active.
-		 */
-		if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
-			vflags |= VIRQ_NOMASK_QUIRK;
-	}
 
 	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
 		ops->set_desc(&arg, desc);

