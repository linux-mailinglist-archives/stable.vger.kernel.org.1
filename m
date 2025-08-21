Return-Path: <stable+bounces-172057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A4EB2FA1C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1253AF823
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6A3314D7;
	Thu, 21 Aug 2025 13:16:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34332A3F6;
	Thu, 21 Aug 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782187; cv=none; b=Qpfzhq3XrhVX7hvg4WvN8d7vW9eVkOqJ2Os0WEm50Y4jfqJ4yaO518YwvfJT6ACyGgX9ubXTBXvTdBQJ5FjLV/yz96WXB5chUXqv7XKHapcDDZTlx35RdUoFksLlQQ3OBPS2UV1TzbUACfDv65TX8o7mFLYXfrWVyHygRjsgs1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782187; c=relaxed/simple;
	bh=SWHnhHdv6dxqRnRz3lqrcSpVEQ9EyqXUky8Fm6GPR58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haDc1HGTdRWdB/Y2YfuKnY/BgS7pXq4toMvnF9Rn7PdKExXDlHpcBpTCcx89wa2VWNpVhzEiF92FDPkmZngieZPBasE9ob6tRBeoQZ7csM8th5mPvw2vHCycVSATVv/J+aznFsclc4UFB0uLHpxdLtrtidO/UxavOUsZNG5M1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c73js2tHJz14McY;
	Thu, 21 Aug 2025 21:16:17 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id B3555180B57;
	Thu, 21 Aug 2025 21:16:21 +0800 (CST)
Received: from huawei.com (10.67.174.55) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 21:16:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <prarit@redhat.com>,
	<rui.y.wang@intel.com>, <gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v6.6 2/2] x86/irq: Plug vector setup race
Date: Thu, 21 Aug 2025 13:12:28 +0000
Message-ID: <20250821131228.1094633-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821131228.1094633-1-ruanjinjie@huawei.com>
References: <20250821131228.1094633-1-ruanjinjie@huawei.com>
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
Cc: stable@vger.kernel.org#6.6.x
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
index 1f066268ec29..29d0fc94232e 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -242,24 +242,59 @@ static __always_inline void handle_irq(struct irq_desc *desc,
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
-		apic_eoi();
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
@@ -273,7 +308,9 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 	/* entry code tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
-	call_irq_handler(vector, regs);
+	if (unlikely(!call_irq_handler(vector, regs)))
+		apic_eoi();
+
 	set_irq_regs(old_regs);
 }
 
-- 
2.34.1


