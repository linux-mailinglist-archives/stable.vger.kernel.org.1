Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED13A7F1745
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 16:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjKTP2s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 10:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjKTP2r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 10:28:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE47DA7
        for <stable@vger.kernel.org>; Mon, 20 Nov 2023 07:28:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A29DC433C8;
        Mon, 20 Nov 2023 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700494123;
        bh=8Hqy4S6899ihYLuecYvW0lUlHGukpcYLkQryCrgRUiY=;
        h=Subject:To:Cc:From:Date:From;
        b=P1R/RXBom8n2x6TvsdrUvkqziTvlRgUXf4HGHkDkPUfRWrk3a3nTpmyf/gh6So+3M
         mXqTktwqGINhQENPiwQMmheRtVYXoOFZrXapCN1/mbMMn6Sx/WOkkuiWjQKHE7nyuA
         8sNE2nAHDEsYpnLsHNs4AG7OLf3swt8wnUVrv/uE=
Subject: FAILED: patch "[PATCH] x86/apic/msi: Fix misconfigured non-maskable MSI quirk" failed to apply to 6.1-stable tree
To:     den@valinux.co.jp, tglx@linutronix.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 20 Nov 2023 16:28:40 +0100
Message-ID: <2023112040-sudden-savanna-4847@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b56ebe7c896dc78b5865ec2c4b1dae3c93537517
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112040-sudden-savanna-4847@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI quirk")
9c15eeb5362c ("genirq: Allow fasteoi handler to resend interrupts on concurrent handling")
0cfb4a1af386 ("genirq: Use BIT() for the IRQD_* state flags")
b6d5fc3a5245 ("x86/apic/vector: Provide MSI parent domain")
2d958b02b04f ("genirq/msi: Rearrange MSI domain flags")
3dad5f9ad99b ("genirq/msi: Move IRQ_DOMAIN_MSI_NOMASK_QUIRK to MSI flags")
d474d92d7025 ("x86/apic: Remove X86_IRQ_ALLOC_CONTIGUOUS_VECTORS")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b56ebe7c896dc78b5865ec2c4b1dae3c93537517 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Thu, 26 Oct 2023 12:20:36 +0900
Subject: [PATCH] x86/apic/msi: Fix misconfigured non-maskable MSI quirk

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

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6b6b711678fe..d9651f15ae4f 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -55,14 +55,14 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
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
@@ -215,8 +215,6 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 		info->chip->irq_set_affinity = msi_set_affinity;
-		/* See msi_set_affinity() for the gory details */
-		info->flags |= MSI_FLAG_NOMASK_QUIRK;
 		break;
 	case DOMAIN_BUS_DMAR:
 	case DOMAIN_BUS_AMDVI:
diff --git a/include/linux/irq.h b/include/linux/irq.h
index d8a6fdce9373..90081afa10ce 100644
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
@@ -247,11 +245,10 @@ enum {
 	IRQD_SINGLE_TARGET		= BIT(24),
 	IRQD_DEFAULT_TRIGGER_SET	= BIT(25),
 	IRQD_CAN_RESERVE		= BIT(26),
-	IRQD_MSI_NOMASK_QUIRK		= BIT(27),
-	IRQD_HANDLE_ENFORCE_IRQCTX	= BIT(28),
-	IRQD_AFFINITY_ON_ACTIVATE	= BIT(29),
-	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(30),
-	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(31),
+	IRQD_HANDLE_ENFORCE_IRQCTX	= BIT(27),
+	IRQD_AFFINITY_ON_ACTIVATE	= BIT(28),
+	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(29),
+	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(30),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -426,21 +423,6 @@ static inline bool irqd_can_reserve(struct irq_data *d)
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
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a50ea79522f8..ddace8c34dcf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -547,12 +547,6 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 5),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 6),
-	/*
-	 * Quirk to handle MSI implementations which do not provide
-	 * masking. Currently known to affect x86, but has to be partially
-	 * handled in the core MSI code.
-	 */
-	MSI_FLAG_NOMASK_QUIRK		= (1 << 7),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 5971a66be034..aae0402507ed 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -121,7 +121,6 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_AFFINITY_ON_ACTIVATE),
 	BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
 	BIT_MASK_DESCR(IRQD_CAN_RESERVE),
-	BIT_MASK_DESCR(IRQD_MSI_NOMASK_QUIRK),
 
 	BIT_MASK_DESCR(IRQD_FORWARDED_TO_VCPU),
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b4c31a5c1147..79b4a58ba9c3 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1204,7 +1204,6 @@ static int msi_handle_pci_fail(struct irq_domain *domain, struct msi_desc *desc,
 
 #define VIRQ_CAN_RESERVE	0x01
 #define VIRQ_ACTIVATE		0x02
-#define VIRQ_NOMASK_QUIRK	0x04
 
 static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflags)
 {
@@ -1213,8 +1212,6 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 
 	if (!(vflags & VIRQ_CAN_RESERVE)) {
 		irqd_clr_can_reserve(irqd);
-		if (vflags & VIRQ_NOMASK_QUIRK)
-			irqd_set_msi_nomask_quirk(irqd);
 
 		/*
 		 * If the interrupt is managed but no CPU is available to
@@ -1275,15 +1272,8 @@ static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain
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
-		if (info->flags & MSI_FLAG_NOMASK_QUIRK)
-			vflags |= VIRQ_NOMASK_QUIRK;
-	}
 
 	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
 		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))

