Return-Path: <stable+bounces-172052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3381B2FA0D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEDBAC7311
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002032A3F8;
	Thu, 21 Aug 2025 13:14:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4E3277A0;
	Thu, 21 Aug 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782092; cv=none; b=CLp7SUSCbaol5v7nRgvY2GtoRiuwPRBIMo7z7wsfhxx1ZzADkIZfnXMqUWAJ4WXY+DPJOXBHELzCKRAuawDrjui3+P7BMpd8wOBPHk2Szdsquf9HZUIbbwD4FYStopQYQOlRKCM3ByJQT/8ZoX+M9iOc3FN8V8Q8F5zjGrnuIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782092; c=relaxed/simple;
	bh=4P0wCkacEiqVKQdKnv8edZeyZyywuvr6nY6F8QUW9Ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDVWVy5Uq1cpHUH0AR76LlNVQHGrULLYO9/VOVw5EAtBJq4m7qc0YtrqAWpV4xtrHr2fvryLE3mYWrLNyLgta30Y/zLVuFvx/D4kc2DESrfKo81mIioxIl8C5RhTElbi70h050oDx8CYCIXxjmyPlYUy+0V8bnPmFE4gNTqSvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c73b444y5zdc7f;
	Thu, 21 Aug 2025 21:10:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BEE2140279;
	Thu, 21 Aug 2025 21:14:48 +0800 (CST)
Received: from huawei.com (10.67.174.55) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 21:14:47 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <prarit@redhat.com>,
	<rui.y.wang@intel.com>, <gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5.15 2/2] x86/irq: Plug vector setup race
Date: Thu, 21 Aug 2025 13:10:54 +0000
Message-ID: <20250821131054.1094506-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821131054.1094506-1-ruanjinjie@huawei.com>
References: <20250821131054.1094506-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

From: Thomas Gleixner <tglx@linutronix.de>

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
Cc: stable@vger.kernel.org#5.15.x
Cc: gregkh@linuxfoundation.org
Reported-by: Hogan Wang <hogan.wang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Hogan Wang <hogan.wang@huawei.com>
Link: https://lore.kernel.org/all/draft-87ikjhrhhh.ffs@tglx
[ Conflicts in arch/x86/kernel/irq.c because call_irq_handler() has been
  refactored to do apic_eoi() according to the return value.
  Conflincts in arch/x86/include/asm/hw_irq.h because (un)lock_vector_lock()
  are already controlled by CONFIG_X86_LOCAL_APIC. ]
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/irq.c | 65 +++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 11d7233397df..065251fa3e40 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -235,24 +235,59 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 		__handle_irq(desc, regs);
 }
 
-static __always_inline void call_irq_handler(int vector, struct pt_regs *regs)
+static struct irq_desc *reevaluate_vector(int vector)
 {
-	struct irq_desc *desc;
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
-		ack_APIC_irq();
-
-		if (desc == VECTOR_UNUSED) {
-			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
-					     __func__, smp_processor_id(),
-					     vector);
-		} else {
-			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
-		}
+		return true;
 	}
+
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
@@ -266,7 +301,9 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 	/* entry code tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
-	call_irq_handler(vector, regs);
+	if (unlikely(!call_irq_handler(vector, regs)))
+		ack_APIC_irq();
+
 	set_irq_regs(old_regs);
 }
 
-- 
2.34.1


