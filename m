Return-Path: <stable+bounces-67479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE59503E3
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 13:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AAEB24C7B
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D71990D3;
	Tue, 13 Aug 2024 11:39:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA25198E90;
	Tue, 13 Aug 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549166; cv=none; b=Vwjvp8y90ZMhIM+sAc6BSRjK6SpH1QHeDvb5djNmYWmRyevv608NFdOVidr3RyU2IED6Xk3080h6mRx5IVJCdCvgny8FhvonerBne8ak/jOB+IfGbUlkqd6lHfXQDCk0sY5MRWw9Dz7kMffLYZNV3OmOoCA+c9twER4E/H868dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549166; c=relaxed/simple;
	bh=bzgXjRt3to7NhobX2QldsNIECOTnccwcSivMjM9fC9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H1x5NRn8Ayp5F5HuUJRu6i5RLbkVxbJfO8W0VanWvFQ0BC3cY0sfdEKxyCVyyTEQtfr5D+vsMuC1AEyLN363MsXyVEpKGbC0SsIs7g/gooiC1FKJq67tV4bmk7FpfQipM7B3Hr1gslnqirOZVsL6DCuNkWHS9QB+7Ah5P00K0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WjqBf5nYjzncyc;
	Tue, 13 Aug 2024 19:38:02 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1757C140135;
	Tue, 13 Aug 2024 19:39:22 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 13 Aug
 2024 19:39:21 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
	<mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
	<christophe.leroy@csgroup.eu>, <mahesh@linux.ibm.com>,
	<gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5.15 RESEND] powerpc: Avoid nmi_enter/nmi_exit in real mode interrupt.
Date: Tue, 13 Aug 2024 11:37:05 +0000
Message-ID: <20240813113705.1837673-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

From: Mahesh Salgaonkar <mahesh@linux.ibm.com>

[ Upstream commit 0db880fc865ffb522141ced4bfa66c12ab1fbb70 ]

nmi_enter()/nmi_exit() touches per cpu variables which can lead to kernel
crash when invoked during real mode interrupt handling (e.g. early HMI/MCE
interrupt handler) if percpu allocation comes from vmalloc area.

Early HMI/MCE handlers are called through DEFINE_INTERRUPT_HANDLER_NMI()
wrapper which invokes nmi_enter/nmi_exit calls. We don't see any issue when
percpu allocation is from the embedded first chunk. However with
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there are chances where percpu
allocation can come from the vmalloc area.

With kernel command line "percpu_alloc=page" we can force percpu allocation
to come from vmalloc area and can see kernel crash in machine_check_early:

[    1.215714] NIP [c000000000e49eb4] rcu_nmi_enter+0x24/0x110
[    1.215717] LR [c0000000000461a0] machine_check_early+0xf0/0x2c0
[    1.215719] --- interrupt: 200
[    1.215720] [c000000fffd73180] [0000000000000000] 0x0 (unreliable)
[    1.215722] [c000000fffd731b0] [0000000000000000] 0x0
[    1.215724] [c000000fffd73210] [c000000000008364] machine_check_early_common+0x134/0x1f8

Fix this by avoiding use of nmi_enter()/nmi_exit() in real mode if percpu
first chunk is not embedded.

CVE-2024-42126
Cc: stable@vger.kernel.org#5.15.x
Cc: gregkh@linuxfoundation.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Shirisha Ganta <shirisha@linux.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240410043006.81577-1-mahesh@linux.ibm.com
[ Conflicts in arch/powerpc/include/asm/interrupt.h
  because interrupt_nmi_enter_prepare() and interrupt_nmi_exit_prepare()
  has been refactored. ]
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/include/asm/interrupt.h | 14 ++++++++++----
 arch/powerpc/include/asm/percpu.h    | 10 ++++++++++
 arch/powerpc/kernel/setup_64.c       |  2 ++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index e592e65e7665..49285b147afe 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -285,18 +285,24 @@ static inline void interrupt_nmi_enter_prepare(struct pt_regs *regs, struct inte
 	/*
 	 * Do not use nmi_enter() for pseries hash guest taking a real-mode
 	 * NMI because not everything it touches is within the RMA limit.
+	 *
+	 * Likewise, do not use it in real mode if percpu first chunk is not
+	 * embedded. With CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there
+	 * are chances where percpu allocation can come from vmalloc area.
 	 */
-	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
+	if ((!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
 			!firmware_has_feature(FW_FEATURE_LPAR) ||
-			radix_enabled() || (mfmsr() & MSR_DR))
+			radix_enabled() || (mfmsr() & MSR_DR)) &&
+			!percpu_first_chunk_is_paged)
 		nmi_enter();
 }
 
 static inline void interrupt_nmi_exit_prepare(struct pt_regs *regs, struct interrupt_nmi_state *state)
 {
-	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
+	if ((!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
 			!firmware_has_feature(FW_FEATURE_LPAR) ||
-			radix_enabled() || (mfmsr() & MSR_DR))
+			radix_enabled() || (mfmsr() & MSR_DR)) &&
+			!percpu_first_chunk_is_paged)
 		nmi_exit();
 
 	/*
diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index 8e5b7d0b851c..634970ce13c6 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -15,6 +15,16 @@
 #endif /* CONFIG_SMP */
 #endif /* __powerpc64__ */
 
+#if defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK) && defined(CONFIG_SMP)
+#include <linux/jump_label.h>
+DECLARE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
+
+#define percpu_first_chunk_is_paged	\
+		(static_key_enabled(&__percpu_first_chunk_is_paged.key))
+#else
+#define percpu_first_chunk_is_paged	false
+#endif /* CONFIG_PPC64 && CONFIG_SMP */
+
 #include <asm-generic/percpu.h>
 
 #include <asm/paca.h>
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index eaa79a0996d1..37d5683ab298 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -825,6 +825,7 @@ static int pcpu_cpu_distance(unsigned int from, unsigned int to)
 
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
+DEFINE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
 
 static void __init pcpu_populate_pte(unsigned long addr)
 {
@@ -904,6 +905,7 @@ void __init setup_per_cpu_areas(void)
 	if (rc < 0)
 		panic("cannot initialize percpu area (err=%d)", rc);
 
+	static_key_enable(&__percpu_first_chunk_is_paged.key);
 	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
 	for_each_possible_cpu(cpu) {
                 __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
-- 
2.34.1


