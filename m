Return-Path: <stable+bounces-196878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F39C84726
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2BBF34F6F3
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBFF302170;
	Tue, 25 Nov 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bYE8U+9H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyppOwmR"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9EE2F12A0;
	Tue, 25 Nov 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066024; cv=none; b=nCJVMZTyv1cx8UeDS4r+tyBNYuP8qutzo6H+TX9j3OwNhS2bUYerSEWJa/fQO9QYP7OZA2VZsHArnRV0fK/q+S75likqQvESHSKWQK7hsyKGf79ZWrJcD6LF2We92Y1T6OqAURWevfOaafI1ikttIbccCRtDxvDsyLR7cfhfL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066024; c=relaxed/simple;
	bh=x3slilJPOuVDJRgPLoVKPtNTkD6lVokT73EPS5OWpEY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ILfQ/mClHVS+ocusK9sLiqI2HbOInu2uBrLBepschfTSlg14cxDjsvZecC9FfNqGyql/MxQFXxCCJ1Q1DF4ZPf5sqNF4L1dfwJ1BFUG4xCjgi4S0RyxkigUGh/NVvm/PiKGP6dfAUlkNelX7KNiYjb8pu/BZAcaLv/i3r1ISxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bYE8U+9H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyppOwmR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251125102000.636453530@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764066021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nh0WTmzh0DJjl8VxDftc+Gorf1cXtubgMwnD3nIZeIw=;
	b=bYE8U+9HZBALD6MMMmpzFs60HqShnU4+QSC3YHeR+sPeVNCq/VLkA1gBW4gVazTGww4Ti9
	pSHQh4ODQ1uC+OPc9tgAooZy7EU9Fua7oFcmiz16nsOJ6jb3LqBxn0NTo4F3oKe+B3z3Gx
	M2D/6svlB/Y6wzZCrQiFVnHraXgWwrGUe7R+veW4bjNui1jRg8K9wp3ljq+eFHOMXvb59/
	XSnfB4YM2gh4tepz30HycNCQ9pCCdcP4I6xAJ2mbUt5t9XZh9MnpwNebmtFuy3SXkJxav4
	+fGxdgVoV2r1FPqmwU+m75nzuaomWkvoWzaVrit72zR05x9BDqoNKjrEDLdxRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764066021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nh0WTmzh0DJjl8VxDftc+Gorf1cXtubgMwnD3nIZeIw=;
	b=yyppOwmRltVprVroZ7Wy77ea/km9vDqML4zXQx1TYxktS7zuATaSrgTVvxz6WZAL3v7bd5
	6CpHg1vPI1/+S6DA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Luigi Rizzo <lrizzo@google.com>,
 stable@vger.kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [patch 1/3] x86/msi: Make irq_retrigger() functional for posted MSI
References: <20251125101912.564125647@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 11:20:20 +0100 (CET)

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
Closes: https://lore.kernel.org/lkml/20251124104836.3685533-1-lrizzo@google.com
---
 arch/x86/include/asm/irq_remapping.h |    7 +++++++
 arch/x86/kernel/irq.c                |   23 +++++++++++++++++++++++
 drivers/iommu/intel/irq_remapping.c  |    8 ++++----
 3 files changed, 34 insertions(+), 4 deletions(-)



--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -87,4 +87,11 @@ static inline void panic_if_irq_remap(co
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
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -397,6 +397,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm
 
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
+	if (unlikely(!this_cpu_read(posted_msi_handler_active)))
+		apic_eoi();
+}
+
 static __always_inline bool handle_pending_pir(unsigned long *pir, struct pt_regs *regs)
 {
 	unsigned long pir_copy[NR_PIR_WORDS];
@@ -446,6 +466,8 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi
 
 	pid = this_cpu_ptr(&posted_msi_pi_desc);
 
+	/* Mark the handler active for intel_ack_posted_msi_irq() */
+	this_cpu_write(posted_msi_handler_active, true);
 	inc_irq_stat(posted_msi_notification_count);
 	irq_enter();
 
@@ -474,6 +496,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi
 
 	apic_eoi();
 	irq_exit();
+	this_cpu_write(posted_msi_handler_active, false);
 	set_irq_regs(old_regs);
 }
 #endif /* X86_POSTED_MSI */
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


