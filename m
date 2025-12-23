Return-Path: <stable+bounces-203327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBF7CDA422
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 19:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EAA7300204F
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A34221721;
	Tue, 23 Dec 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rij7zcR4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3C145348
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513995; cv=none; b=CfLyzvp7XmYOabPldTQumoS6/8gPPA3BYAxBoKO9PqG8kEgx9Btm1lA64HJWAsQ5joLg3NuwNI6ntXDnbJcHJvEjaCG1OM11moHCYmwN0D3WQArkU0EanleQL34g84bkl/sQ/HPvmqTvbATXNhWxGO/bqAO9XvuPVlroj4giwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513995; c=relaxed/simple;
	bh=C1xlggQx60kFAlKqI2jqhtUlHyJKUuhHzTbZ40oBxUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEoS041F9AmCkvBzMjdKkEYhOanfnxi6/MywBPZK7eLEs8SbuTPeYQiA6UY8XhdpWoVoVWsAeJgqq5eow3l5/octrNig3dJGlXOOonXVE7DbLRt/6zB7aAr3wOX/T9ejk2Qhh7QEEYPVk8qg21Z7iqAzOTMhPRIgesHaLvOVgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rij7zcR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C60C113D0;
	Tue, 23 Dec 2025 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766513995;
	bh=C1xlggQx60kFAlKqI2jqhtUlHyJKUuhHzTbZ40oBxUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rij7zcR4L46nOKi4Qirtm4PRfgVzJCf4x68ghnlLjv4s6H/FqXV1EzP9fi6PI5ff+
	 NUaIy6xYRbiMwXIhzjlh32W3Bjug56yVXtVDBgFXcRAML7CD39fujnUoQt7XE35nF5
	 tbgQxbBpbQBXmNlIb+ffgThhQ4kBTDQQAKQtTHsSiY6khtlymsGR/HydeV4MVA07Nh
	 8HdUwDxGkdc7cI3uK9kZyXZrcVbJovOAS/arLED5kdvV997fhoqVoGcFqtpUVdOARD
	 FccUzrHkbZDfnHu5hdT2xaXNjYQe2VyCimvu9NRstra7nyuClf8Ymg2DYD13i58TrR
	 z87eoznBl894g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Luigi Rizzo <lrizzo@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] x86/msi: Make irq_retrigger() functional for posted MSI
Date: Tue, 23 Dec 2025 13:19:53 -0500
Message-ID: <20251223181953.2946236-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122351-chip-causal-80ed@gregkh>
References: <2025122351-chip-causal-80ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 0edc78b82bea85e1b2165d8e870a5c3535919695 ]

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
[ DEFINE_PER_CPU_CACHE_HOT => DEFINE_PER_CPU ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/irq_remapping.h |  7 +++++++
 arch/x86/kernel/irq.c                | 23 +++++++++++++++++++++++
 drivers/iommu/intel/irq_remapping.c  |  8 ++++----
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 5036f13ab69f..e8415958bcb2 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -72,4 +72,11 @@ static inline void panic_if_irq_remap(const char *msg)
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
index 9400730e538e..16dd6b425101 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -391,6 +391,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 
 /* Posted Interrupt Descriptors for coalesced MSIs to be posted */
 DEFINE_PER_CPU_ALIGNED(struct pi_desc, posted_msi_pi_desc);
+static DEFINE_PER_CPU(bool, posted_msi_handler_active);
 
 void intel_posted_msi_init(void)
 {
@@ -408,6 +409,25 @@ void intel_posted_msi_init(void)
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
 /*
  * De-multiplexing posted interrupts is on the performance path, the code
  * below is written to optimize the cache performance based on the following
@@ -483,6 +503,8 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 
 	pid = this_cpu_ptr(&posted_msi_pi_desc);
 
+	/* Mark the handler active for intel_ack_posted_msi_irq() */
+	__this_cpu_write(posted_msi_handler_active, true);
 	inc_irq_stat(posted_msi_notification_count);
 	irq_enter();
 
@@ -511,6 +533,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 
 	apic_eoi();
 	irq_exit();
+	__this_cpu_write(posted_msi_handler_active, false);
 	set_irq_regs(old_regs);
 }
 #endif /* X86_POSTED_MSI */
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 71b3383b7115..066e4cd6eea5 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1309,17 +1309,17 @@ static struct irq_chip intel_ir_chip = {
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
@@ -1328,7 +1328,7 @@ static struct irq_chip intel_ir_chip = {
  */
 static struct irq_chip intel_ir_chip_post_msi = {
 	.name			= "INTEL-IR-POST",
-	.irq_ack		= irq_move_irq,
+	.irq_ack		= intel_ack_posted_msi_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
-- 
2.51.0


