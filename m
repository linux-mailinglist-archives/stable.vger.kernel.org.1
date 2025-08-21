Return-Path: <stable+bounces-172047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B324DB2F9E4
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8D760846F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384ED322C79;
	Thu, 21 Aug 2025 13:11:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3E322752;
	Thu, 21 Aug 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781882; cv=none; b=ONNhTQ4Y+JMZ22E96uuEuAhQPqXDagblUCyCfHkdtyNMU0gNl33QTrrwreLMK2ztf0RgpCNP90NK9/RwbX89uWRqzbHDAsmu9OYJy8bF58+5KB0hDBrji6Qxi6ofxoFhiHc8BwreZOpOte6mGJxOx2fC/93hcYkPUg/mk04YQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781882; c=relaxed/simple;
	bh=hwO6FBn5msqCqgObVcxDtes3Rq0+JQ9SdQYanbSKim8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3ZBYY3Y+XfiwzbncJTepZBS1G4rpiw+udUF3er9SDSLXu9t6NPEMOgjEdEMfvwFHeXUCxHNnSf1zVTxXVUnfhHGpEns/NEGNWwshAawF6NO8z0vzkagIBCIRrtS2kde2lrh1P3OowxtufbdUsnzjGstKGZfjRbmdgAfpM+FNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c73dL3tzhz27jHB;
	Thu, 21 Aug 2025 21:12:22 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B6B31400CA;
	Thu, 21 Aug 2025 21:11:17 +0800 (CST)
Received: from huawei.com (10.67.174.55) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 21:11:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <prarit@redhat.com>,
	<rui.y.wang@intel.com>, <gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5.10 1/2] x86/irq: Factor out handler invocation from common_interrupt()
Date: Thu, 21 Aug 2025 13:07:15 +0000
Message-ID: <20250821130716.1094430-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821130716.1094430-1-ruanjinjie@huawei.com>
References: <20250821130716.1094430-1-ruanjinjie@huawei.com>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Prepare for calling external interrupt handlers directly from the posted
MSI demultiplexing loop. Extract the common code from common_interrupt() to
avoid code duplication.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-8-jacob.jun.pan@linux.intel.com
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/x86/kernel/irq.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 3e01b8086403..89e85664cb6d 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -234,18 +234,10 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 		__handle_irq(desc, regs);
 }
 
-/*
- * common_interrupt() handles all normal device IRQ's (the special SMP
- * cross-CPU interrupts have their own entry points).
- */
-DEFINE_IDTENTRY_IRQ(common_interrupt)
+static __always_inline void call_irq_handler(int vector, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
 
-	/* entry code tells RCU that we're not quiescent.  Check it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
-
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
@@ -260,7 +252,20 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
 	}
+}
+
+/*
+ * common_interrupt() handles all normal device IRQ's (the special SMP
+ * cross-CPU interrupts have their own entry points).
+ */
+DEFINE_IDTENTRY_IRQ(common_interrupt)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	/* entry code tells RCU that we're not quiescent.  Check it. */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
+	call_irq_handler(vector, regs);
 	set_irq_regs(old_regs);
 }
 
-- 
2.34.1


