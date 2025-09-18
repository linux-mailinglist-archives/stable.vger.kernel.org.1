Return-Path: <stable+bounces-168071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B85B23330
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7091775F1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A682DFA3E;
	Tue, 12 Aug 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VArWYTUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BF1EBFE0;
	Tue, 12 Aug 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022940; cv=none; b=aZyEO3hX4YJ1rR8Lbp1bEwJNwbils4WzNJr+KUybg4m9VlLMK0ra2sDRi9cg0XM1tbk5nVxOAYmSpo85oQSx9pciwxruYZ8nnmocF7Ah0QWAh7Bq5gOEAOsSYHbTa+mlULkgRo5NkzrDVaoeHz9iOmFvCCiCH6tPT/hV12ohW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022940; c=relaxed/simple;
	bh=l5PEFLqZABTvPwPnB5Ke9bjvvmx4uREpI8CiYE3b+Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPZxmOeRi6mMxJH7Pq4HJlfJ+KP/rPrNCRRuJ0MsiUyVXGhzzwPHcc/aaplnieirZ6WiMjbqgbZqfYcC2kUX9j+nV4HQp2skLW6RpbLbx9WFeKNfH6OwhEoQa0G+wG4Uaq6lUo4RnxCqQPk/Ljmju1h5w8NXbI6SsQ6UQGg3RT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VArWYTUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A19C4CEF0;
	Tue, 12 Aug 2025 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022940;
	bh=l5PEFLqZABTvPwPnB5Ke9bjvvmx4uREpI8CiYE3b+Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VArWYTUYw3BiEkill6iBhvTKQkT/hUfYlyGBGBo0IYCxb0sMagiR9EyClnECiG4A4
	 f+0nAT/6XVr7suPZBwqPB5U5aHdCCzNjmTr4BRGrD65TJ0wP4qwQS+2mg+6LSkYcuK
	 cUxd6euYSftBAR89LE4N89XBt+XtQoVflV0+Igy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hogan Wang <hogan.wang@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 304/369] x86/irq: Plug vector setup race
Date: Tue, 12 Aug 2025 19:30:01 +0200
Message-ID: <20250812173028.167851479@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit ce0b5eedcb753697d43f61dd2e27d68eb5d3150f ]

Hogan reported a vector setup race, which overwrites the interrupt
descriptor in the per CPU vector array resulting in a disfunctional device.

CPU0				CPU1
				interrupt is raised in APIC IRR
				but not handled
  free_irq()
    per_cpu(vector_irq, CPU1)[vector] = VECTOR_SHUTDOWN;

  request_irq()			common_interrupt()
  				  d = this_cpu_read(vector_irq[vector]);

    per_cpu(vector_irq, CPU1)[vector] = desc;

    				  if (d == VECTOR_SHUTDOWN)
				    this_cpu_write(vector_irq[vector], VECTOR_UNUSED);

free_irq() cannot observe the pending vector in the CPU1 APIC as there is
no way to query the remote CPUs APIC IRR.

This requires that request_irq() uses the same vector/CPU as the one which
was freed, but this also can be triggered by a spurious interrupt.

Interestingly enough this problem managed to be hidden for more than a
decade.

Prevent this by reevaluating vector_irq under the vector lock, which is
held by the interrupt activation code when vector_irq is updated.

To avoid ifdeffery or IS_ENABLED() nonsense, move the
[un]lock_vector_lock() declarations out under the
CONFIG_IRQ_DOMAIN_HIERARCHY guard as it's only provided when
CONFIG_X86_LOCAL_APIC=y.

The current CONFIG_IRQ_DOMAIN_HIERARCHY guard is selected by
CONFIG_X86_LOCAL_APIC, but can also be selected by other parts of the
Kconfig system, which makes 32-bit UP builds with CONFIG_X86_LOCAL_APIC=n
fail.

Can we just get rid of this !APIC nonsense once and forever?

Fixes: 9345005f4eed ("x86/irq: Fix do_IRQ() interrupt warning for cpu hotplug retriggered irqs")
Reported-by: Hogan Wang <hogan.wang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Hogan Wang <hogan.wang@huawei.com>
Link: https://lore.kernel.org/all/draft-87ikjhrhhh.ffs@tglx
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/hw_irq.h | 12 ++++---
 arch/x86/kernel/irq.c         | 63 ++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index edebf1020e04..6bb3d9a86abe 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -92,8 +92,6 @@ struct irq_cfg {
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
 extern struct irq_cfg *irqd_cfg(struct irq_data *irq_data);
-extern void lock_vector_lock(void);
-extern void unlock_vector_lock(void);
 #ifdef CONFIG_SMP
 extern void vector_schedule_cleanup(struct irq_cfg *);
 extern void irq_complete_move(struct irq_cfg *cfg);
@@ -101,12 +99,16 @@ extern void irq_complete_move(struct irq_cfg *cfg);
 static inline void vector_schedule_cleanup(struct irq_cfg *c) { }
 static inline void irq_complete_move(struct irq_cfg *c) { }
 #endif
-
 extern void apic_ack_edge(struct irq_data *data);
-#else	/*  CONFIG_IRQ_DOMAIN_HIERARCHY */
+#endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
+
+#ifdef CONFIG_X86_LOCAL_APIC
+extern void lock_vector_lock(void);
+extern void unlock_vector_lock(void);
+#else
 static inline void lock_vector_lock(void) {}
 static inline void unlock_vector_lock(void) {}
-#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
+#endif
 
 /* Statistics */
 extern atomic_t irq_err_count;
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 85fa2db38dc4..9400730e538e 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -251,26 +251,59 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 		__handle_irq(desc, regs);
 }
 
-static __always_inline int call_irq_handler(int vector, struct pt_regs *regs)
+static struct irq_desc *reevaluate_vector(int vector)
 {
-	struct irq_desc *desc;
-	int ret = 0;
+	struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
+
+	if (!IS_ERR_OR_NULL(desc))
+		return desc;
+
+	if (desc == VECTOR_UNUSED)
+		pr_emerg_ratelimited("No irq handler for %d.%u\n", smp_processor_id(), vector);
+	else
+		__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+	return NULL;
+}
+
+static __always_inline bool call_irq_handler(int vector, struct pt_regs *regs)
+{
+	struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
 
-	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
-	} else {
-		ret = -EINVAL;
-		if (desc == VECTOR_UNUSED) {
-			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
-					     __func__, smp_processor_id(),
-					     vector);
-		} else {
-			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
-		}
+		return true;
 	}
 
-	return ret;
+	/*
+	 * Reevaluate with vector_lock held to prevent a race against
+	 * request_irq() setting up the vector:
+	 *
+	 * CPU0				CPU1
+	 *				interrupt is raised in APIC IRR
+	 *				but not handled
+	 * free_irq()
+	 *   per_cpu(vector_irq, CPU1)[vector] = VECTOR_SHUTDOWN;
+	 *
+	 * request_irq()		common_interrupt()
+	 *				  d = this_cpu_read(vector_irq[vector]);
+	 *
+	 * per_cpu(vector_irq, CPU1)[vector] = desc;
+	 *
+	 *				  if (d == VECTOR_SHUTDOWN)
+	 *				    this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
+	 *
+	 * This requires that the same vector on the same target CPU is
+	 * handed out or that a spurious interrupt hits that CPU/vector.
+	 */
+	lock_vector_lock();
+	desc = reevaluate_vector(vector);
+	unlock_vector_lock();
+
+	if (!desc)
+		return false;
+
+	handle_irq(desc, regs);
+	return true;
 }
 
 /*
@@ -284,7 +317,7 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 	/* entry code tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
-	if (unlikely(call_irq_handler(vector, regs)))
+	if (unlikely(!call_irq_handler(vector, regs)))
 		apic_eoi();
 
 	set_irq_regs(old_regs);
-- 
2.39.5




