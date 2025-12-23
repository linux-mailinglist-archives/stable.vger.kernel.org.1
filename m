Return-Path: <stable+bounces-203318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034CCD9F7D
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 074713018C59
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9129F24A046;
	Tue, 23 Dec 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X90mTihI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E22356D9
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507455; cv=none; b=XhmkbvF/+7I4Nt24qohny8XioKT1RitdR4kYnFUQHqEIWQ4BrK/t8iuvV1vZFhTxyiP/mKYk/CT7ZO1KB5avBhn0hT9p3iKsgzzAlntc/PRhPu5ih1jb9qulfnqDWoIili8A8iAnfLhiwBIAA58XGAoAgVGYZNKO+iUb0YKrwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507455; c=relaxed/simple;
	bh=3WG6d3XvXvMho5lOJsnGQzuLOGQOkVDUm7oyIu9cI7Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qc0MriCxlINvigkITteUdBBUAPiiUyPYsxvJuWq6zSdFCheJqBRy2OJiqE42dax/hQFnfPNBHmQbzt7/CvJVKZxK4YBhyaFDa+vbj46+y+H28rvWxgGIQ2Qwo4blvMSb66w/7NMaZ+bgyMm+LDVREz80RvykrS40RNxNsE5HjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X90mTihI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F011C113D0;
	Tue, 23 Dec 2025 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766507454;
	bh=3WG6d3XvXvMho5lOJsnGQzuLOGQOkVDUm7oyIu9cI7Y=;
	h=Subject:To:Cc:From:Date:From;
	b=X90mTihIY4crt1iY6ixPI3bNjB8rJiO61w+LpopZ9mbpZdF+KwHLnitiYZLQrRva2
	 LeiJwPsT5P/v1PxN6lBCu3H06OChOi2zM/be7NJZEBXza66cp3wWg5VSXuUAXKRatD
	 9JJ0GEm6ezTZCidSxhXewqIFL2FNo4r4UrKCDjQw=
Subject: FAILED: patch "[PATCH] x86/msi: Make irq_retrigger() functional for posted MSI" failed to apply to 6.12-stable tree
To: tglx@linutronix.de,lrizzo@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Dec 2025 17:30:51 +0100
Message-ID: <2025122351-chip-causal-80ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0edc78b82bea85e1b2165d8e870a5c3535919695
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122351-chip-causal-80ed@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0edc78b82bea85e1b2165d8e870a5c3535919695 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 25 Nov 2025 22:50:45 +0100
Subject: [PATCH] x86/msi: Make irq_retrigger() functional for posted MSI

Luigi reported that retriggering a posted MSI interrupt does not work
correctly.

The reason is that the retrigger happens at the vector domain by sending an
IPI to the actual vector on the target CPU. That works correctly exactly
once because the posted MSI interrupt chip does not issue an EOI as that's
only required for the posted MSI notification vector itself.

As a consequence the vector becomes stale in the ISR, which not only
affects this vector but also any lower priority vector in the affected
APIC because the ISR bit is not cleared.

Luigi proposed to set the vector in the remap PIR bitmap and raise the
posted MSI notification vector. That works, but that still does not cure a
related problem:

  If there is ever a stray interrupt on such a vector, then the related
  APIC ISR bit becomes stale due to the lack of EOI as described above.
  Unlikely to happen, but if it happens it's not debuggable at all.

So instead of playing games with the PIR, this can be actually solved
for both cases by:

 1) Keeping track of the posted interrupt vector handler state

 2) Implementing a posted MSI specific irq_ack() callback which checks that
    state. If the posted vector handler is inactive it issues an EOI,
    otherwise it delegates that to the posted handler.

This is correct versus affinity changes and concurrent events on the posted
vector as the actual handler invocation is serialized through the interrupt
descriptor lock.

Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
Reported-by: Luigi Rizzo <lrizzo@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Luigi Rizzo <lrizzo@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251125214631.044440658@linutronix.de
Closes: https://lore.kernel.org/lkml/20251124104836.3685533-1-lrizzo@google.com

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 5a0d42464d44..4e55d1755846 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -87,4 +87,11 @@ static inline void panic_if_irq_remap(const char *msg)
 }
 
 #endif /* CONFIG_IRQ_REMAP */
+
+#ifdef CONFIG_X86_POSTED_MSI
+void intel_ack_posted_msi_irq(struct irq_data *irqd);
+#else
+#define intel_ack_posted_msi_irq	NULL
+#endif
+
 #endif /* __X86_IRQ_REMAPPING_H */
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 86f4e574de02..b2fe6181960c 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -397,6 +397,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 
 /* Posted Interrupt Descriptors for coalesced MSIs to be posted */
 DEFINE_PER_CPU_ALIGNED(struct pi_desc, posted_msi_pi_desc);
+static DEFINE_PER_CPU_CACHE_HOT(bool, posted_msi_handler_active);
 
 void intel_posted_msi_init(void)
 {
@@ -414,6 +415,25 @@ void intel_posted_msi_init(void)
 	this_cpu_write(posted_msi_pi_desc.ndst, destination);
 }
 
+void intel_ack_posted_msi_irq(struct irq_data *irqd)
+{
+	irq_move_irq(irqd);
+
+	/*
+	 * Handle the rare case that irq_retrigger() raised the actual
+	 * assigned vector on the target CPU, which means that it was not
+	 * invoked via the posted MSI handler below. In that case APIC EOI
+	 * is required as otherwise the ISR entry becomes stale and lower
+	 * priority interrupts are never going to be delivered after that.
+	 *
+	 * If the posted handler invoked the device interrupt handler then
+	 * the EOI would be premature because it would acknowledge the
+	 * posted vector.
+	 */
+	if (unlikely(!__this_cpu_read(posted_msi_handler_active)))
+		apic_eoi();
+}
+
 static __always_inline bool handle_pending_pir(unsigned long *pir, struct pt_regs *regs)
 {
 	unsigned long pir_copy[NR_PIR_WORDS];
@@ -446,6 +466,8 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 
 	pid = this_cpu_ptr(&posted_msi_pi_desc);
 
+	/* Mark the handler active for intel_ack_posted_msi_irq() */
+	__this_cpu_write(posted_msi_handler_active, true);
 	inc_irq_stat(posted_msi_notification_count);
 	irq_enter();
 
@@ -474,6 +496,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 
 	apic_eoi();
 	irq_exit();
+	__this_cpu_write(posted_msi_handler_active, false);
 	set_irq_regs(old_regs);
 }
 #endif /* X86_POSTED_MSI */
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 4f9b01dc91e8..8bcbfe3d9c72 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1303,17 +1303,17 @@ static struct irq_chip intel_ir_chip = {
  *	irq_enter();
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				irq_move_irq(); // No EOI
+ *				intel_ack_posted_msi_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				irq_move_irq(); // No EOI
+ *				intel_ack_posted_msi_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *		handle_edge_irq()
  *			irq_chip_ack_parent()
- *				irq_move_irq(); // No EOI
+ *				intel_ack_posted_msi_irq(); // No EOI
  *			handle_irq_event()
  *				driver_handler()
  *	apic_eoi()
@@ -1322,7 +1322,7 @@ static struct irq_chip intel_ir_chip = {
  */
 static struct irq_chip intel_ir_chip_post_msi = {
 	.name			= "INTEL-IR-POST",
-	.irq_ack		= irq_move_irq,
+	.irq_ack		= intel_ack_posted_msi_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,


