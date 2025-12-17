Return-Path: <stable+bounces-202884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84851CC9259
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 18:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94F57303D90C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 17:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC935770A;
	Wed, 17 Dec 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iF8Jupky";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xn2pRAbp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC63557E5;
	Wed, 17 Dec 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993705; cv=none; b=PbmgDqx6Fe2by2bnSNoBnw1cUOl0Z9lHbyBwUyt6XuRcK4v01/arjwllg8hqj/TlZJB1Jsgasl+B/jS6BPsvINzukcIhxpdcDCUUnTcYqR4KCtrqclXtFw+Qrkhf5caO9I0llcPCvRlYe6Uh3EQ5TyvxB555i4BNEm6XamhwxLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993705; c=relaxed/simple;
	bh=+TgBuZQldoFETNPAwYyBWb6nX7TwPSaNgkrTf4I9yz0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HN0K9a/jYQCZ5zpt5gfgS4kH/D8oIJiu9v9bOYhAMAnEn9pww+iz7efnLOWrBHojnZUhyBJ6XFeyJuWkQ7QcFoGn/0jsG+XastEiqeVpRUWo8ihzcI5986/Dkoyt0+oKMtU2R/kDicK/c6BVuROlxQYItqWhaoVL9KAq7am8c6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iF8Jupky; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xn2pRAbp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 17:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765993701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKrYI5V1Txlu8ZRrXHwxIDFud1TV3uqnviQa/5G67YA=;
	b=iF8JupkyvEwoVhZcfQrLy5W6Z5gd812NQY5/7BDOo0+H5G12s3oGCYYpYjZjbgryyCFqER
	2OStokOPWZpo9qIBWdsoOJyOs9PqENbY8En5/ywtnfZnq9CUGA4yilM/YdOvEFaJRjlXGm
	KpUBHAbVGO0BuErzOtfANChKSOhAqRgvrcZ3YzVSYwykY3T+qNdA+FLqQGQ1KrYzl7a7n6
	Ya11brUcYeiAniODsfba8IDbhQB460bfLvWprt759CMwF4igoVOSfqunHqEu/p5dZNqHWB
	XCxHPuB7CVxbAmWpBHruJuqIBygwbh83DHERK2XQVaB43nsYA2OuWWbo447/nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765993701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKrYI5V1Txlu8ZRrXHwxIDFud1TV3uqnviQa/5G67YA=;
	b=xn2pRAbpon8pErb9AG1Nhai/5N9JNadHk21WYcb5z5Lb9890VbSyaEyV0ARNPRNhQgtSvu
	pZbvwHAPxzNsxrBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/msi: Make irq_retrigger() functional for posted MSI
Cc: Luigi Rizzo <lrizzo@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251125214631.044440658@linutronix.de>
References: <20251125214631.044440658@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176599370039.510.13219226926587996527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0edc78b82bea85e1b2165d8e870a5c3535919695
Gitweb:        https://git.kernel.org/tip/0edc78b82bea85e1b2165d8e870a5c35359=
19695
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Nov 2025 22:50:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Dec 2025 18:41:52 +01:00

x86/msi: Make irq_retrigger() functional for posted MSI

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
Closes: https://lore.kernel.org/lkml/20251124104836.3685533-1-lrizzo@google.c=
om
---
 arch/x86/include/asm/irq_remapping.h |  7 +++++++
 arch/x86/kernel/irq.c                | 23 +++++++++++++++++++++++
 drivers/iommu/intel/irq_remapping.c  |  8 ++++----
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_=
remapping.h
index 5a0d424..4e55d17 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -87,4 +87,11 @@ static inline void panic_if_irq_remap(const char *msg)
 }
=20
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
index 86f4e57..b2fe618 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -397,6 +397,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nest=
ed_ipi)
=20
 /* Posted Interrupt Descriptors for coalesced MSIs to be posted */
 DEFINE_PER_CPU_ALIGNED(struct pi_desc, posted_msi_pi_desc);
+static DEFINE_PER_CPU_CACHE_HOT(bool, posted_msi_handler_active);
=20
 void intel_posted_msi_init(void)
 {
@@ -414,6 +415,25 @@ void intel_posted_msi_init(void)
 	this_cpu_write(posted_msi_pi_desc.ndst, destination);
 }
=20
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
 static __always_inline bool handle_pending_pir(unsigned long *pir, struct pt=
_regs *regs)
 {
 	unsigned long pir_copy[NR_PIR_WORDS];
@@ -446,6 +466,8 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
=20
 	pid =3D this_cpu_ptr(&posted_msi_pi_desc);
=20
+	/* Mark the handler active for intel_ack_posted_msi_irq() */
+	__this_cpu_write(posted_msi_handler_active, true);
 	inc_irq_stat(posted_msi_notification_count);
 	irq_enter();
=20
@@ -474,6 +496,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
=20
 	apic_eoi();
 	irq_exit();
+	__this_cpu_write(posted_msi_handler_active, false);
 	set_irq_regs(old_regs);
 }
 #endif /* X86_POSTED_MSI */
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_re=
mapping.c
index 4f9b01d..8bcbfe3 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1303,17 +1303,17 @@ static struct irq_chip intel_ir_chip =3D {
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
@@ -1322,7 +1322,7 @@ static struct irq_chip intel_ir_chip =3D {
  */
 static struct irq_chip intel_ir_chip_post_msi =3D {
 	.name			=3D "INTEL-IR-POST",
-	.irq_ack		=3D irq_move_irq,
+	.irq_ack		=3D intel_ack_posted_msi_irq,
 	.irq_set_affinity	=3D intel_ir_set_affinity,
 	.irq_compose_msi_msg	=3D intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	=3D intel_ir_set_vcpu_affinity,

