Return-Path: <stable+bounces-65469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADE9489E1
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 09:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6371F24289
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD9E166F1F;
	Tue,  6 Aug 2024 07:18:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAFBA53;
	Tue,  6 Aug 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928728; cv=none; b=E4/Ehem8+/DOSAvEPheLCvz9erlTqw0MTaGUsIJFFdoYXr/LHKHJ+xl9e67CY9MEjtFvL0vgrE1aiHVWOEXxgXldq7K2WYO5iAkikZ0f1JeQG9PongmPf4nthRuakPcAjVtLYAuF7D3ISnGXFPve223CGgtOPkvSyQ70VSYTsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928728; c=relaxed/simple;
	bh=y9+kEBGrMzk+TKK3/t5Gg0IJdmbU11DUVR0TmBjqAXw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cBoeXkziZC02am+IBRE8HowsZtZST68thrxMaS2XnPfJCF8CYYNRSBCB4VXJ1JJ2cfVHxs3z0rczckoQ2qUILSjNCFpt701Hllzm8fbQ6xdn1ZcGFqA6n3bdHX+NyoFMi8EQP4Q52KzFDRJJ12T/2NRoRXdbFDy06nsI9+lYCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WdPlJ26SfzpStY;
	Tue,  6 Aug 2024 15:17:32 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A35AE180105;
	Tue,  6 Aug 2024 15:18:40 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 6 Aug
 2024 15:18:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
	<mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
	<christophe.leroy@csgroup.eu>, <mahesh@linux.ibm.com>,
	<gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5.10 v2] powerpc: Avoid nmi_enter/nmi_exit in real mode interrupt.
Date: Tue, 6 Aug 2024 07:16:16 +0000
Message-ID: <20240806071616.1671691-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
Cc: stable@vger.kernel.org#5.10.x
Cc: gregkh@linuxfoundation.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Shirisha Ganta <shirisha@linux.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240410043006.81577-1-mahesh@linux.ibm.com
[ Conflicts in arch/powerpc/include/asm/interrupt.h
  because machine_check_early() and machine_check_exception()
  has been refactored. ]
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Also fix for CONFIG_PPC_BOOK3S_64 not enabled.
- Add Upstream.
- Cc stable@vger.kernel.org.
---
 arch/powerpc/include/asm/percpu.h | 10 ++++++++++
 arch/powerpc/kernel/mce.c         | 14 +++++++++++---
 arch/powerpc/kernel/setup_64.c    |  2 ++
 arch/powerpc/kernel/traps.c       |  8 +++++++-
 4 files changed, 30 insertions(+), 4 deletions(-)

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
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 63702c0badb9..259343040e1b 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -594,8 +594,15 @@ long notrace machine_check_early(struct pt_regs *regs)
 	u8 ftrace_enabled = this_cpu_get_ftrace_enabled();
 
 	this_cpu_set_ftrace_enabled(0);
-	/* Do not use nmi_enter/exit for pseries hpte guest */
-	if (radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR))
+	/*
+	 * Do not use nmi_enter/exit for pseries hpte guest
+	 *
+	 * Likewise, do not use it in real mode if percpu first chunk is not
+	 * embedded. With CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there
+	 * are chances where percpu allocation can come from vmalloc area.
+	 */
+	if ((radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR)) &&
+	    !percpu_first_chunk_is_paged)
 		nmi_enter();
 
 	hv_nmi_check_nonrecoverable(regs);
@@ -606,7 +613,8 @@ long notrace machine_check_early(struct pt_regs *regs)
 	if (ppc_md.machine_check_early)
 		handled = ppc_md.machine_check_early(regs);
 
-	if (radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR))
+	if ((radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR)) &&
+	    !percpu_first_chunk_is_paged)
 		nmi_exit();
 
 	this_cpu_set_ftrace_enabled(ftrace_enabled);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3f8426bccd16..899d87de0165 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -824,6 +824,7 @@ static int pcpu_cpu_distance(unsigned int from, unsigned int to)
 
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
+DEFINE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
 
 static void __init pcpu_populate_pte(unsigned long addr)
 {
@@ -903,6 +904,7 @@ void __init setup_per_cpu_areas(void)
 	if (rc < 0)
 		panic("cannot initialize percpu area (err=%d)", rc);
 
+	static_key_enable(&__percpu_first_chunk_is_paged.key);
 	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
 	for_each_possible_cpu(cpu) {
                 __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b0e87dce2b9a..b4d108bef814 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -835,8 +835,14 @@ void machine_check_exception(struct pt_regs *regs)
 	 * This is silly. The BOOK3S_64 should just call a different function
 	 * rather than expecting semantics to magically change. Something
 	 * like 'non_nmi_machine_check_exception()', perhaps?
+	 *
+	 * Do not use nmi_enter/exit in real mode if percpu first chunk is
+	 * not embedded. With CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled
+	 * there are chances where percpu allocation can come from
+	 * vmalloc area.
 	 */
-	const bool nmi = !IS_ENABLED(CONFIG_PPC_BOOK3S_64);
+	const bool nmi = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&
+			 !percpu_first_chunk_is_paged;
 
 	if (nmi) nmi_enter();
 
-- 
2.34.1


