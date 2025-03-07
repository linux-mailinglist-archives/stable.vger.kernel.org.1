Return-Path: <stable+bounces-121412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B191A56D8F
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C70F1899721
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F268A23BCF9;
	Fri,  7 Mar 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XgX0FuMf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1023BCF3;
	Fri,  7 Mar 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364661; cv=none; b=VNTD0wN2VLT4c+6BsUF/RbR81P3bc7wGAYX0TFuissUujDPhhII/cq84S5GQQ8aCDG7MOyjRPT0uYN4gYyjPm2HV4MxbPd948l35404DIYzuXW+mwDxNjXu60mEqkrvepBmmRK+tCvjyhub58Fj8UMJdVkAL4yuOIjVeWFRR2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364661; c=relaxed/simple;
	bh=02W72FK7qZvHe2C749PXHafa0emkLWn1DdtSUI3vb/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/ejn/eK2etdkItvlStYBDoyGWVUj3RBHsg7qaKiKCUBQkaRrPMzz36rZSLoJqez5eiGqx86xj9MrmTIuQw6/i8ci8Swiy4roAZzv4HVNX78q9F0iSgZHeMYrmBodlXwYcaoz/GYP8vdHLbJX0ruShNpy5Bcu3rkYH7rTZ8VD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XgX0FuMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD03C4CEE7;
	Fri,  7 Mar 2025 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741364660;
	bh=02W72FK7qZvHe2C749PXHafa0emkLWn1DdtSUI3vb/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgX0FuMfyWudw1qIv+WdKXNBn74+iX8iMklOyFvEsYPFeZfM+t2h1QZBBG5zPBC8t
	 c+8lswVQobfm8Q103UjmQSFs2qaTWHyf7ophBeOnLK7hGoyBGZNycA09lX/SLtm89I
	 jXAI5XpwkRumxQ7K/JkBYBaFCgsfhaygkWzyRssY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.130
Date: Fri,  7 Mar 2025 17:24:07 +0100
Message-ID: <2025030707-promenade-crudely-d478@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025030707-coaster-deferred-2234@gregkh>
References: <2025030707-coaster-deferred-2234@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
index b18416f4500f..7995ce2b9676 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -113,6 +113,12 @@ pages:
 This also leads to limitations: there are only 31-10==21 bits available for a
 counter that increments 10 bits at a time.
 
+* Because of that limitation, special handling is applied to the zero pages
+  when using FOLL_PIN.  We only pretend to pin a zero page - we don't alter its
+  refcount or pincount at all (it is permanent, so there's no need).  The
+  unpinning functions also don't do anything to a zero page.  This is
+  transparent to the caller.
+
 * Callers must specifically request "dma-pinned tracking of pages". In other
   words, just calling get_user_pages() will not suffice; a new set of functions,
   pin_user_page() and related, must be used.
diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 6cab1f74ae05..7f623d1db72a 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -112,7 +112,7 @@ Functions
 Callbacks
 =========
 
-There are six callbacks:
+There are seven callbacks:
 
     ::
 
@@ -182,6 +182,13 @@ There are six callbacks:
     the length of the message. skb->len - offset may be greater
     then full_len since strparser does not trim the skb.
 
+    ::
+
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+                     sk_read_actor_t recv_actor);
+
+    The read_sock callback is used by strparser instead of
+    sock->ops->read_sock, if provided.
     ::
 
 	int (*read_sock_done)(struct strparser *strp, int err);
diff --git a/Makefile b/Makefile
index 2c81c91c0ac2..a4b58d8abc83 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 129
+SUBLEVEL = 130
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 2147e152683b..fe4632744f6e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1753,6 +1753,7 @@ dsi0: dsi@14014000 {
 			resets = <&mmsys MT8183_MMSYS_SW0_RST_B_DISP_DSI0>;
 			phys = <&mipi_tx0>;
 			phy-names = "dphy";
+			status = "disabled";
 		};
 
 		mutex: mutex@14016000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 956237489bc4..5a4972afc977 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2226,7 +2226,7 @@ compute-cb@3 {
 
 		cdsp: remoteproc@98900000 {
 			compatible = "qcom,sm8350-cdsp-pas";
-			reg = <0 0x098900000 0 0x1400000>;
+			reg = <0 0x98900000 0 0x1400000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 3f79aea64446..9420857871b1 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2093,7 +2093,7 @@ compute-cb@3 {
 
 		remoteproc_adsp: remoteproc@30000000 {
 			compatible = "qcom,sm8450-adsp-pas";
-			reg = <0 0x030000000 0 0x100>;
+			reg = <0 0x30000000 0 0x100>;
 
 			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
@@ -2159,7 +2159,7 @@ compute-cb@5 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8450-cdsp-pas";
-			reg = <0 0x032300000 0 0x1400000>;
+			reg = <0 0x32300000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index ef35c52aabd6..101771c60d80 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -31,9 +31,12 @@ static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() &&
-	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
-		return VM_MTE_ALLOWED;
+	if (system_supports_mte()) {
+		if ((flags & MAP_ANONYMOUS) && !(flags & MAP_HUGETLB))
+			return VM_MTE_ALLOWED;
+		if (shmem_file(file))
+			return VM_MTE_ALLOWED;
+	}
 
 	return 0;
 }
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 428b9f1cf1de..4a2b40ce39e0 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -155,6 +155,8 @@ static inline long regs_return_value(struct pt_regs *regs)
 }
 
 #define instruction_pointer(regs) ((regs)->cp0_epc)
+extern unsigned long exception_ip(struct pt_regs *regs);
+#define exception_ip(regs) exception_ip(regs)
 #define profile_pc(regs) instruction_pointer(regs)
 
 extern asmlinkage long syscall_trace_enter(struct pt_regs *regs);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index a8e569830ec8..fdcaad9fba1d 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/seccomp.h>
 #include <linux/ftrace.h>
 
+#include <asm/branch.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
@@ -48,6 +49,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+unsigned long exception_ip(struct pt_regs *regs)
+{
+	return exception_epc(regs);
+}
+EXPORT_SYMBOL(exception_ip);
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index b6ac4f86c87b..433d164374cb 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -89,6 +89,34 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
 }
 #endif
 
+/*
+ * With 4K page size the real_pte machinery is all nops.
+ */
+static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep, int offset)
+{
+	return (real_pte_t){pte};
+}
+
+#define __rpte_to_pte(r)	((r).pte)
+
+static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
+{
+	return pte_val(__rpte_to_pte(rpte)) >> H_PAGE_F_GIX_SHIFT;
+}
+
+#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
+	do {							         \
+		index = 0;					         \
+		shift = mmu_psize_defs[psize].shift;		         \
+
+#define pte_iterate_hashed_end() } while(0)
+
+/*
+ * We expect this to be called only for user addresses or kernel virtual
+ * addresses other than the linear mapping.
+ */
+#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
+
 /*
  * 4K PTE format is different from 64K PTE format. Saving the hash_slot is just
  * a matter of returning the PTE bits that need to be modified. On 64K PTE,
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c436d8422654..fdbe0b381f3a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -318,32 +318,6 @@ extern unsigned long pci_io_base;
 
 #ifndef __ASSEMBLY__
 
-/*
- * This is the default implementation of various PTE accessors, it's
- * used in all cases except Book3S with 64K pages where we have a
- * concept of sub-pages
- */
-#ifndef __real_pte
-
-#define __real_pte(e, p, o)		((real_pte_t){(e)})
-#define __rpte_to_pte(r)	((r).pte)
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> H_PAGE_F_GIX_SHIFT)
-
-#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
-	do {							         \
-		index = 0;					         \
-		shift = mmu_psize_defs[psize].shift;		         \
-
-#define pte_iterate_hashed_end() } while(0)
-
-/*
- * We expect this to be called only for user addresses or kernel virtual
- * addresses other than the linear mapping.
- */
-#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
-
-#endif /* __real_pte */
-
 static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep, unsigned long clr,
 				       unsigned long set, int huge)
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index ad0cf3108dd0..65353cf2b0a8 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -53,7 +53,7 @@ static int text_area_cpu_up(unsigned int cpu)
 	unsigned long addr;
 	int err;
 
-	area = get_vm_area(PAGE_SIZE, VM_ALLOC);
+	area = get_vm_area(PAGE_SIZE, 0);
 	if (!area) {
 		WARN_ONCE(1, "Failed to create text area for cpu %d\n",
 			cpu);
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index fc8130f995c1..6907c456ac8c 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -93,7 +93,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %[r])	\
 		_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %[r])	\
 	: [r] "+r" (ret), [v] "=&r" (val), [u] "+m" (*uaddr), [t] "=&r" (tmp)
-	: [ov] "Jr" (oldval), [nv] "Jr" (newval)
+	: [ov] "Jr" ((long)(int)oldval), [nv] "Jr" (newval)
 	: "memory");
 	__disable_user_access();
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 49cea5b81649..ca8dd7e5585f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2506,7 +2506,8 @@ config CPU_IBPB_ENTRY
 	depends on CPU_SUP_AMD && X86_64
 	default y
 	help
-	  Compile the kernel with support for the retbleed=ibpb mitigation.
+	  Compile the kernel with support for the retbleed=ibpb and
+	  spec_rstack_overflow={ibpb,ibpb-vmexit} mitigations.
 
 config CPU_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 39f86188be54..fa0744732444 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -623,7 +623,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
 
-	if (event->attr.sample_period && x86_pmu.limit_period) {
+	if (!event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fa2045ad408a..03221a060ae7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1092,6 +1092,8 @@ static void __init retbleed_select_mitigation(void)
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		mitigate_smt = true;
 
 		/*
 		 * IBPB on entry already obviates the need for
@@ -1101,8 +1103,6 @@ static void __init retbleed_select_mitigation(void)
 		setup_clear_cpu_cap(X86_FEATURE_UNRET);
 		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 
-		mitigate_smt = true;
-
 		/*
 		 * There is no need for RSB filling: entry_ibpb() ensures
 		 * all predictions, including the RSB, are invalidated,
@@ -2607,6 +2607,7 @@ static void __init srso_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
 
 				/*
@@ -2616,6 +2617,13 @@ static void __init srso_select_mitigation(void)
 				 */
 				setup_clear_cpu_cap(X86_FEATURE_UNRET);
 				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+
+				/*
+				 * There is no need for RSB filling: entry_ibpb() ensures
+				 * all predictions, including the RSB, are invalidated,
+				 * regardless of IBPB implementation.
+				 */
+				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
@@ -2624,8 +2632,8 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
+		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 
@@ -2637,9 +2645,9 @@ static void __init srso_select_mitigation(void)
 				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
-			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
+			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
 			goto pred_cmd;
-                }
+		}
 		break;
 
 	default:
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 9651275aecd1..dfec2c61e354 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -153,8 +153,8 @@ static void geode_configure(void)
 	u8 ccr3;
 	local_irq_save(flags);
 
-	/* Suspend on halt power saving and enable #SUSP pin */
-	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
+	/* Suspend on halt power saving */
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x08);
 
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable MAPEN */
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 60b4299bec8e..5d202b775beb 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -704,6 +704,46 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	bfq_put_queue(bfqq);
 }
 
+static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
+			       struct bfq_queue *sync_bfqq,
+			       struct bfq_io_cq *bic,
+			       struct bfq_group *bfqg,
+			       unsigned int act_idx)
+{
+	struct bfq_queue *bfqq;
+
+	if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
+		/* We are the only user of this bfqq, just move it */
+		if (sync_bfqq->entity.sched_data != &bfqg->sched_data)
+			bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
+		return;
+	}
+
+	/*
+	 * The queue was merged to a different queue. Check
+	 * that the merge chain still belongs to the same
+	 * cgroup.
+	 */
+	for (bfqq = sync_bfqq; bfqq; bfqq = bfqq->new_bfqq)
+		if (bfqq->entity.sched_data != &bfqg->sched_data)
+			break;
+	if (bfqq) {
+		/*
+		 * Some queue changed cgroup so the merge is not valid
+		 * anymore. We cannot easily just cancel the merge (by
+		 * clearing new_bfqq) as there may be other processes
+		 * using this queue and holding refs to all queues
+		 * below sync_bfqq->new_bfqq. Similarly if the merge
+		 * already happened, we need to detach from bfqq now
+		 * so that we cannot merge bio to a request from the
+		 * old cgroup.
+		 */
+		bfq_put_cooperator(sync_bfqq);
+		bfq_release_process_ref(bfqd, sync_bfqq);
+		bic_set_bfqq(bic, NULL, true, act_idx);
+	}
+}
+
 /**
  * __bfq_bic_change_cgroup - move @bic to @bfqg.
  * @bfqd: the queue descriptor.
@@ -714,60 +754,25 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * sure that the reference to cgroup is valid across the call (see
  * comments in bfq_bic_update_cgroup on this issue)
  */
-static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
+static void __bfq_bic_change_cgroup(struct bfq_data *bfqd,
 				     struct bfq_io_cq *bic,
 				     struct bfq_group *bfqg)
 {
-	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, false);
-	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, true);
-	struct bfq_entity *entity;
+	unsigned int act_idx;
 
-	if (async_bfqq) {
-		entity = &async_bfqq->entity;
+	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
+		struct bfq_queue *async_bfqq = bic_to_bfqq(bic, false, act_idx);
+		struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, true, act_idx);
 
-		if (entity->sched_data != &bfqg->sched_data) {
-			bic_set_bfqq(bic, NULL, false);
+		if (async_bfqq &&
+		    async_bfqq->entity.sched_data != &bfqg->sched_data) {
+			bic_set_bfqq(bic, NULL, false, act_idx);
 			bfq_release_process_ref(bfqd, async_bfqq);
 		}
-	}
 
-	if (sync_bfqq) {
-		if (!sync_bfqq->new_bfqq && !bfq_bfqq_coop(sync_bfqq)) {
-			/* We are the only user of this bfqq, just move it */
-			if (sync_bfqq->entity.sched_data != &bfqg->sched_data)
-				bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
-		} else {
-			struct bfq_queue *bfqq;
-
-			/*
-			 * The queue was merged to a different queue. Check
-			 * that the merge chain still belongs to the same
-			 * cgroup.
-			 */
-			for (bfqq = sync_bfqq; bfqq; bfqq = bfqq->new_bfqq)
-				if (bfqq->entity.sched_data !=
-				    &bfqg->sched_data)
-					break;
-			if (bfqq) {
-				/*
-				 * Some queue changed cgroup so the merge is
-				 * not valid anymore. We cannot easily just
-				 * cancel the merge (by clearing new_bfqq) as
-				 * there may be other processes using this
-				 * queue and holding refs to all queues below
-				 * sync_bfqq->new_bfqq. Similarly if the merge
-				 * already happened, we need to detach from
-				 * bfqq now so that we cannot merge bio to a
-				 * request from the old cgroup.
-				 */
-				bfq_put_cooperator(sync_bfqq);
-				bic_set_bfqq(bic, NULL, true);
-				bfq_release_process_ref(bfqd, sync_bfqq);
-			}
-		}
+		if (sync_bfqq)
+			bfq_sync_bfqq_move(bfqd, sync_bfqq, bic, bfqg, act_idx);
 	}
-
-	return bfqg;
 }
 
 void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f75945764653..d1c62a4e8c35 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -377,16 +377,23 @@ static const unsigned long bfq_late_stable_merging = 600;
 #define RQ_BIC(rq)		((struct bfq_io_cq *)((rq)->elv.priv[0]))
 #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
 
-struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
+struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync,
+			      unsigned int actuator_idx)
 {
-	return bic->bfqq[is_sync];
+	if (is_sync)
+		return bic->bfqq[1][actuator_idx];
+
+	return bic->bfqq[0][actuator_idx];
 }
 
 static void bfq_put_stable_ref(struct bfq_queue *bfqq);
 
-void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync)
+void bic_set_bfqq(struct bfq_io_cq *bic,
+		  struct bfq_queue *bfqq,
+		  bool is_sync,
+		  unsigned int actuator_idx)
 {
-	struct bfq_queue *old_bfqq = bic->bfqq[is_sync];
+	struct bfq_queue *old_bfqq = bic->bfqq[is_sync][actuator_idx];
 
 	/* Clear bic pointer if bfqq is detached from this bic */
 	if (old_bfqq && old_bfqq->bic == bic)
@@ -405,7 +412,10 @@ void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync)
 	 * we cancel the stable merge if
 	 * bic->stable_merge_bfqq == bfqq.
 	 */
-	bic->bfqq[is_sync] = bfqq;
+	if (is_sync)
+		bic->bfqq[1][actuator_idx] = bfqq;
+	else
+		bic->bfqq[0][actuator_idx] = bfqq;
 
 	if (bfqq && bic->stable_merge_bfqq == bfqq) {
 		/*
@@ -571,23 +581,31 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
 #define BFQ_LIMIT_INLINE_DEPTH 16
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+static bool bfqq_request_over_limit(struct bfq_data *bfqd,
+				    struct bfq_io_cq *bic, blk_opf_t opf,
+				    unsigned int act_idx, int limit)
 {
-	struct bfq_data *bfqd = bfqq->bfqd;
-	struct bfq_entity *entity = &bfqq->entity;
 	struct bfq_entity *inline_entities[BFQ_LIMIT_INLINE_DEPTH];
 	struct bfq_entity **entities = inline_entities;
-	int depth, level, alloc_depth = BFQ_LIMIT_INLINE_DEPTH;
-	int class_idx = bfqq->ioprio_class - 1;
+	int alloc_depth = BFQ_LIMIT_INLINE_DEPTH;
 	struct bfq_sched_data *sched_data;
+	struct bfq_entity *entity;
+	struct bfq_queue *bfqq;
 	unsigned long wsum;
 	bool ret = false;
-
-	if (!entity->on_st_or_in_serv)
-		return false;
+	int depth;
+	int level;
 
 retry:
 	spin_lock_irq(&bfqd->lock);
+	bfqq = bic_to_bfqq(bic, op_is_sync(opf), act_idx);
+	if (!bfqq)
+		goto out;
+
+	entity = &bfqq->entity;
+	if (!entity->on_st_or_in_serv)
+		goto out;
+
 	/* +1 for bfqq entity, root cgroup not included */
 	depth = bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup->level + 1;
 	if (depth > alloc_depth) {
@@ -632,7 +650,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 			 * class.
 			 */
 			wsum = 0;
-			for (i = 0; i <= class_idx; i++) {
+			for (i = 0; i <= bfqq->ioprio_class - 1; i++) {
 				wsum = wsum * IOPRIO_BE_NR +
 					sched_data->service_tree[i].wsum;
 			}
@@ -655,7 +673,9 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 	return ret;
 }
 #else
-static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+static bool bfqq_request_over_limit(struct bfq_data *bfqd,
+				    struct bfq_io_cq *bic, blk_opf_t opf,
+				    unsigned int act_idx, int limit)
 {
 	return false;
 }
@@ -680,9 +700,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
 	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
-	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(opf)) : NULL;
 	int depth;
 	unsigned limit = data->q->nr_requests;
+	unsigned int act_idx;
 
 	/* Sync reads have full depth available */
 	if (op_is_sync(opf) && !op_is_write(opf)) {
@@ -692,14 +712,22 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
 		limit = (limit * depth) >> bfqd->full_depth_shift;
 	}
 
-	/*
-	 * Does queue (or any parent entity) exceed number of requests that
-	 * should be available to it? Heavily limit depth so that it cannot
-	 * consume more available requests and thus starve other entities.
-	 */
-	if (bfqq && bfqq_request_over_limit(bfqq, limit))
-		depth = 1;
+	for (act_idx = 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
+		/* Fast path to check if bfqq is already allocated. */
+		if (!bic_to_bfqq(bic, op_is_sync(opf), act_idx))
+			continue;
 
+		/*
+		 * Does queue (or any parent entity) exceed number of
+		 * requests that should be available to it? Heavily
+		 * limit depth so that it cannot consume more
+		 * available requests and thus starve other entities.
+		 */
+		if (bfqq_request_over_limit(bfqd, bic, opf, act_idx, limit)) {
+			depth = 1;
+			break;
+		}
+	}
 	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
 		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
 	if (depth)
@@ -1820,6 +1848,18 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
 	return bfqq_weight > in_serv_weight;
 }
 
+/*
+ * Get the index of the actuator that will serve bio.
+ */
+static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
+{
+	/*
+	 * Multi-actuator support not complete yet, so always return 0
+	 * for the moment (to keep incomplete mechanisms off).
+	 */
+	return 0;
+}
+
 static bool bfq_better_to_idle(struct bfq_queue *bfqq);
 
 static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
@@ -2150,7 +2190,7 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * We reset waker detection logic also if too much time has passed
  	 * since the first detection. If wakeups are rare, pointless idling
 	 * doesn't hurt throughput that much. The condition below makes sure
-	 * we do not uselessly idle blocking waker in more than 1/64 cases. 
+	 * we do not uselessly idle blocking waker in more than 1/64 cases.
 	 */
 	if (bfqd->last_completed_rq_bfqq !=
 	    bfqq->tentative_waker_bfqq ||
@@ -2486,7 +2526,8 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 		 */
 		bfq_bic_update_cgroup(bic, bio);
 
-		bfqd->bio_bfqq = bic_to_bfqq(bic, op_is_sync(bio->bi_opf));
+		bfqd->bio_bfqq = bic_to_bfqq(bic, op_is_sync(bio->bi_opf),
+					     bfq_actuator_index(bfqd, bio));
 	} else {
 		bfqd->bio_bfqq = NULL;
 	}
@@ -3188,7 +3229,7 @@ static struct bfq_queue *bfq_merge_bfqqs(struct bfq_data *bfqd,
 	/*
 	 * Merge queues (that is, let bic redirect its requests to new_bfqq)
 	 */
-	bic_set_bfqq(bic, new_bfqq, true);
+	bic_set_bfqq(bic, new_bfqq, true, bfqq->actuator_idx);
 	bfq_mark_bfqq_coop(new_bfqq);
 	/*
 	 * new_bfqq now belongs to at least two bics (it is a shared queue):
@@ -4818,11 +4859,8 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	 */
 	if (bfq_bfqq_wait_request(bfqq) ||
 	    (bfqq->dispatched != 0 && bfq_better_to_idle(bfqq))) {
-		struct bfq_queue *async_bfqq =
-			bfqq->bic && bfqq->bic->bfqq[0] &&
-			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
-			bfqq->bic->bfqq[0]->next_rq ?
-			bfqq->bic->bfqq[0] : NULL;
+		unsigned int act_idx = bfqq->actuator_idx;
+		struct bfq_queue *async_bfqq = NULL;
 		struct bfq_queue *blocked_bfqq =
 			!hlist_empty(&bfqq->woken_list) ?
 			container_of(bfqq->woken_list.first,
@@ -4830,6 +4868,10 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 				     woken_list_node)
 			: NULL;
 
+		if (bfqq->bic && bfqq->bic->bfqq[0][act_idx] &&
+		    bfq_bfqq_busy(bfqq->bic->bfqq[0][act_idx]) &&
+		    bfqq->bic->bfqq[0][act_idx]->next_rq)
+			async_bfqq = bfqq->bic->bfqq[0][act_idx];
 		/*
 		 * The next four mutually-exclusive ifs decide
 		 * whether to try injection, and choose the queue to
@@ -4914,7 +4956,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		    icq_to_bic(async_bfqq->next_rq->elv.icq) == bfqq->bic &&
 		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=
 		    bfq_bfqq_budget_left(async_bfqq))
-			bfqq = bfqq->bic->bfqq[0];
+			bfqq = bfqq->bic->bfqq[0][act_idx];
 		else if (bfqq->waker_bfqq &&
 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
 			   bfqq->waker_bfqq->next_rq &&
@@ -5375,48 +5417,54 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_release_process_ref(bfqd, bfqq);
 }
 
-static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
+static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
+			      unsigned int actuator_idx)
 {
-	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync);
+	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, actuator_idx);
 	struct bfq_data *bfqd;
 
 	if (bfqq)
 		bfqd = bfqq->bfqd; /* NULL if scheduler already exited */
 
 	if (bfqq && bfqd) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&bfqd->lock, flags);
-		bic_set_bfqq(bic, NULL, is_sync);
+		bic_set_bfqq(bic, NULL, is_sync, actuator_idx);
 		bfq_exit_bfqq(bfqd, bfqq);
-		spin_unlock_irqrestore(&bfqd->lock, flags);
 	}
 }
 
 static void bfq_exit_icq(struct io_cq *icq)
 {
 	struct bfq_io_cq *bic = icq_to_bic(icq);
+	struct bfq_data *bfqd = bic_to_bfqd(bic);
+	unsigned long flags;
+	unsigned int act_idx;
+	/*
+	 * If bfqd and thus bfqd->num_actuators is not available any
+	 * longer, then cycle over all possible per-actuator bfqqs in
+	 * next loop. We rely on bic being zeroed on creation, and
+	 * therefore on its unused per-actuator fields being NULL.
+	 */
+	unsigned int num_actuators = BFQ_MAX_ACTUATORS;
 
-	if (bic->stable_merge_bfqq) {
-		struct bfq_data *bfqd = bic->stable_merge_bfqq->bfqd;
+	/*
+	 * bfqd is NULL if scheduler already exited, and in that case
+	 * this is the last time these queues are accessed.
+	 */
+	if (bfqd) {
+		spin_lock_irqsave(&bfqd->lock, flags);
+		num_actuators = bfqd->num_actuators;
+	}
 
-		/*
-		 * bfqd is NULL if scheduler already exited, and in
-		 * that case this is the last time bfqq is accessed.
-		 */
-		if (bfqd) {
-			unsigned long flags;
+	if (bic->stable_merge_bfqq)
+		bfq_put_stable_ref(bic->stable_merge_bfqq);
 
-			spin_lock_irqsave(&bfqd->lock, flags);
-			bfq_put_stable_ref(bic->stable_merge_bfqq);
-			spin_unlock_irqrestore(&bfqd->lock, flags);
-		} else {
-			bfq_put_stable_ref(bic->stable_merge_bfqq);
-		}
+	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
+		bfq_exit_icq_bfqq(bic, true, act_idx);
+		bfq_exit_icq_bfqq(bic, false, act_idx);
 	}
 
-	bfq_exit_icq_bfqq(bic, true);
-	bfq_exit_icq_bfqq(bic, false);
+	if (bfqd)
+		spin_unlock_irqrestore(&bfqd->lock, flags);
 }
 
 /*
@@ -5493,25 +5541,27 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 
 	bic->ioprio = ioprio;
 
-	bfqq = bic_to_bfqq(bic, false);
+	bfqq = bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
 	if (bfqq) {
 		struct bfq_queue *old_bfqq = bfqq;
 
 		bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
-		bic_set_bfqq(bic, bfqq, false);
+		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
 		bfq_release_process_ref(bfqd, old_bfqq);
 	}
 
-	bfqq = bic_to_bfqq(bic, true);
+	bfqq = bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
 	if (bfqq)
 		bfq_set_next_ioprio_data(bfqq, bic);
 }
 
 static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
+			  struct bfq_io_cq *bic, pid_t pid, int is_sync,
+			  unsigned int act_idx)
 {
 	u64 now_ns = ktime_get_ns();
 
+	bfqq->actuator_idx = act_idx;
 	RB_CLEAR_NODE(&bfqq->entity.rb_node);
 	INIT_LIST_HEAD(&bfqq->fifo);
 	INIT_HLIST_NODE(&bfqq->burst_list_node);
@@ -5762,7 +5812,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 
 	if (bfqq) {
 		bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
-			      is_sync);
+			      is_sync, bfq_actuator_index(bfqd, bio));
 		bfq_init_entity(&bfqq->entity, bfqg);
 		bfq_log_bfqq(bfqd, bfqq, "allocated");
 	} else {
@@ -6078,7 +6128,8 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		 * then complete the merge and redirect it to
 		 * new_bfqq.
 		 */
-		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq) {
+		if (bic_to_bfqq(RQ_BIC(rq), true,
+				bfq_actuator_index(bfqd, rq->bio)) == bfqq) {
 			while (bfqq != new_bfqq)
 				bfqq = bfq_merge_bfqqs(bfqd, RQ_BIC(rq), bfqq);
 		}
@@ -6632,7 +6683,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 		return bfqq;
 	}
 
-	bic_set_bfqq(bic, NULL, true);
+	bic_set_bfqq(bic, NULL, true, bfqq->actuator_idx);
 
 	bfq_put_cooperator(bfqq);
 
@@ -6646,7 +6697,8 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 						   bool split, bool is_sync,
 						   bool *new_queue)
 {
-	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync);
+	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
+	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
 
 	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
 		return bfqq;
@@ -6658,7 +6710,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
 		bfq_put_queue(bfqq);
 	bfqq = bfq_get_queue(bfqd, bio, is_sync, bic, split);
 
-	bic_set_bfqq(bic, bfqq, is_sync);
+	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
 	if (split && is_sync) {
 		if ((bic->was_in_burst_list && bfqd->large_burst) ||
 		    bic->saved_in_large_burst)
@@ -7139,8 +7191,10 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
 	 * Grab a permanent reference to it, so that the normal code flow
 	 * will not attempt to free it.
+	 * Set zero as actuator index: we will pretend that
+	 * all I/O requests are for the same actuator.
 	 */
-	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
+	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0, 0);
 	bfqd->oom_bfqq.ref++;
 	bfqd->oom_bfqq.new_ioprio = BFQ_DEFAULT_QUEUE_IOPRIO;
 	bfqd->oom_bfqq.new_ioprio_class = IOPRIO_CLASS_BE;
@@ -7159,6 +7213,13 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
+	/*
+	 * Multi-actuator support not complete yet, unconditionally
+	 * set to only one actuator for the moment (to keep incomplete
+	 * mechanisms off).
+	 */
+	bfqd->num_actuators = 1;
+
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
 	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 71f721670ab6..2b413ddffbb9 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -33,6 +33,14 @@
  */
 #define BFQ_SOFTRT_WEIGHT_FACTOR	100
 
+/*
+ * Maximum number of actuators supported. This constant is used simply
+ * to define the size of the static array that will contain
+ * per-actuator data. The current value is hopefully a good upper
+ * bound to the possible number of actuators of any actual drive.
+ */
+#define BFQ_MAX_ACTUATORS 8
+
 struct bfq_entity;
 
 /**
@@ -225,12 +233,14 @@ struct bfq_ttime {
  * struct bfq_queue - leaf schedulable entity.
  *
  * A bfq_queue is a leaf request queue; it can be associated with an
- * io_context or more, if it  is  async or shared  between  cooperating
- * processes. @cgroup holds a reference to the cgroup, to be sure that it
- * does not disappear while a bfqq still references it (mostly to avoid
- * races between request issuing and task migration followed by cgroup
- * destruction).
- * All the fields are protected by the queue lock of the containing bfqd.
+ * io_context or more, if it is async or shared between cooperating
+ * processes. Besides, it contains I/O requests for only one actuator
+ * (an io_context is associated with a different bfq_queue for each
+ * actuator it generates I/O for). @cgroup holds a reference to the
+ * cgroup, to be sure that it does not disappear while a bfqq still
+ * references it (mostly to avoid races between request issuing and
+ * task migration followed by cgroup destruction).  All the fields are
+ * protected by the queue lock of the containing bfqd.
  */
 struct bfq_queue {
 	/* reference counter */
@@ -395,6 +405,9 @@ struct bfq_queue {
 	 * the woken queues when this queue exits.
 	 */
 	struct hlist_head woken_list;
+
+	/* index of the actuator this queue is associated with */
+	unsigned int actuator_idx;
 };
 
 /**
@@ -403,8 +416,17 @@ struct bfq_queue {
 struct bfq_io_cq {
 	/* associated io_cq structure */
 	struct io_cq icq; /* must be the first member */
-	/* array of two process queues, the sync and the async */
-	struct bfq_queue *bfqq[2];
+	/*
+	 * Matrix of associated process queues: first row for async
+	 * queues, second row sync queues. Each row contains one
+	 * column for each actuator. An I/O request generated by the
+	 * process is inserted into the queue pointed by bfqq[i][j] if
+	 * the request is to be served by the j-th actuator of the
+	 * drive, where i==0 or i==1, depending on whether the request
+	 * is async or sync. So there is a distinct queue for each
+	 * actuator.
+	 */
+	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
 	/* per (request_queue, blkcg) ioprio */
 	int ioprio;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
@@ -768,6 +790,13 @@ struct bfq_data {
 	 */
 	unsigned int word_depths[2][2];
 	unsigned int full_depth_shift;
+
+	/*
+	 * Number of independent actuators. This is equal to 1 in
+	 * case of single-actuator drives.
+	 */
+	unsigned int num_actuators;
+
 };
 
 enum bfqq_state_flags {
@@ -964,8 +993,10 @@ struct bfq_group {
 
 extern const int bfq_timeout;
 
-struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
-void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
+struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync,
+				unsigned int actuator_idx);
+void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync,
+				unsigned int actuator_idx);
 struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
 void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 35fb26cbf229..892e2540f008 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -289,6 +289,39 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
 
+static bool qca_filename_has_extension(const char *filename)
+{
+	const char *suffix = strrchr(filename, '.');
+
+	/* File extensions require a dot, but not as the first or last character */
+	if (!suffix || suffix == filename || *(suffix + 1) == '\0')
+		return 0;
+
+	/* Avoid matching directories with names that look like files with extensions */
+	return !strchr(suffix, '/');
+}
+
+static bool qca_get_alt_nvm_file(char *filename, size_t max_size)
+{
+	char fwname[64];
+	const char *suffix;
+
+	/* nvm file name has an extension, replace with .bin */
+	if (qca_filename_has_extension(filename)) {
+		suffix = strrchr(filename, '.');
+		strscpy(fwname, filename, suffix - filename + 1);
+		snprintf(fwname + (suffix - filename),
+		       sizeof(fwname) - (suffix - filename), ".bin");
+		/* If nvm file is already the default one, return false to skip the retry. */
+		if (strcmp(fwname, filename) == 0)
+			return false;
+
+		snprintf(filename, max_size, "%s", fwname);
+		return true;
+	}
+	return false;
+}
+
 static int qca_tlv_check_data(struct hci_dev *hdev,
 			       struct qca_fw_config *config,
 			       u8 *fw_data, size_t fw_size,
@@ -586,6 +619,19 @@ static int qca_download_firmware(struct hci_dev *hdev,
 					   config->fwname, ret);
 				return ret;
 			}
+		}
+		/* If the board-specific file is missing, try loading the default
+		 * one, unless that was attempted already.
+		 */
+		else if (config->type == TLV_TYPE_NVM &&
+			 qca_get_alt_nvm_file(config->fwname, sizeof(config->fwname))) {
+			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
+			ret = request_firmware(&fw, config->fwname, &hdev->dev);
+			if (ret) {
+				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+					   config->fwname, ret);
+				return ret;
+			}
 		} else {
 			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
 				   config->fwname, ret);
@@ -722,21 +768,38 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	return 0;
 }
 
-static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
+static void qca_get_nvm_name_by_board(char *fwname, size_t max_size,
+		const char *stem, enum qca_btsoc_type soc_type,
 		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
 {
 	const char *variant;
+	const char *prefix;
 
-	/* hsp gf chip */
-	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
-		variant = "g";
-	else
-		variant = "";
+	/* Set the default value to variant and prefix */
+	variant = "";
+	prefix = "b";
 
-	if (bid == 0x0)
-		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
-	else
-		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
+	if (soc_type == QCA_QCA2066)
+		prefix = "";
+
+	if (soc_type == QCA_WCN6855 || soc_type == QCA_QCA2066) {
+		/* If the chip is manufactured by GlobalFoundries */
+		if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
+			variant = "g";
+	}
+
+	if (rom_ver != 0) {
+		if (bid == 0x0 || bid == 0xffff)
+			snprintf(fwname, max_size, "qca/%s%02x%s.bin", stem, rom_ver, variant);
+		else
+			snprintf(fwname, max_size, "qca/%s%02x%s.%s%02x", stem, rom_ver,
+						variant, prefix, bid);
+	} else {
+		if (bid == 0x0 || bid == 0xffff)
+			snprintf(fwname, max_size, "qca/%s%s.bin", stem, variant);
+		else
+			snprintf(fwname, max_size, "qca/%s%s.%s%02x", stem, variant, prefix, bid);
+	}
 }
 
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
@@ -819,14 +882,20 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
-	if (soc_type == QCA_QCA2066)
+	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
 		qca_read_fw_board_id(hdev, &boardid);
 
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (firmware_name) {
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/%s", firmware_name);
+		/* The firmware name has an extension, use it directly */
+		if (qca_filename_has_extension(firmware_name)) {
+			snprintf(config.fwname, sizeof(config.fwname), "qca/%s", firmware_name);
+		} else {
+			qca_read_fw_board_id(hdev, &boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+				 firmware_name, soc_type, ver, 0, boardid);
+		}
 	} else {
 		switch (soc_type) {
 		case QCA_WCN3990:
@@ -845,8 +914,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/apnv%02x.bin", rom_ver);
 			break;
 		case QCA_QCA2066:
-			qca_generate_hsp_nvm_name(config.fwname,
-				sizeof(config.fwname), ver, rom_ver, boardid);
+			qca_get_nvm_name_by_board(config.fwname,
+				sizeof(config.fwname), "hpnv", soc_type, ver,
+				rom_ver, boardid);
 			break;
 		case QCA_QCA6390:
 			snprintf(config.fwname, sizeof(config.fwname),
@@ -857,14 +927,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/msnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN6855:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpnv%02x.bin", rom_ver);
+			qca_read_fw_board_id(hdev, &boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+						  "hpnv", soc_type, ver, rom_ver, boardid);
 			break;
 		case QCA_WCN7850:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hmtnv%02x.bin", rom_ver);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+				 "hmtnv", soc_type, ver, rom_ver, boardid);
 			break;
-
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/nvm_%08x.bin", soc_ver);
diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index cd266021d010..1a5644051d31 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -14,6 +14,7 @@
  * Access to the event log extended by the TCG BIOS of PC platform
  */
 
+#include <linux/device.h>
 #include <linux/seq_file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
@@ -62,6 +63,11 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
 	return n == 0;
 }
 
+static void tpm_bios_log_free(void *data)
+{
+	kvfree(data);
+}
+
 /* read binary bios log */
 int tpm_read_log_acpi(struct tpm_chip *chip)
 {
@@ -135,7 +141,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmalloc(len, GFP_KERNEL);
+	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
@@ -161,10 +167,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		goto err;
 	}
 
+	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
+	if (ret) {
+		log->bios_event_log = NULL;
+		goto err;
+	}
+
 	return format;
 
 err:
-	kfree(log->bios_event_log);
+	tpm_bios_log_free(log->bios_event_log);
 	log->bios_event_log = NULL;
 	return ret;
 }
diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index e6cb9d525e30..4e9d7c2bf32e 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -6,6 +6,7 @@
  *      Thiebaud Weksteen <tweek@google.com>
  */
 
+#include <linux/device.h>
 #include <linux/efi.h>
 #include <linux/tpm_eventlog.h>
 
@@ -55,7 +56,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
+	log->bios_event_log = devm_kmemdup(&chip->dev, log_tbl->log, log_size, GFP_KERNEL);
 	if (!log->bios_event_log) {
 		ret = -ENOMEM;
 		goto out;
@@ -76,7 +77,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 			     MEMREMAP_WB);
 	if (!final_tbl) {
 		pr_err("Could not map UEFI TPM final log\n");
-		kfree(log->bios_event_log);
+		devm_kfree(&chip->dev, log->bios_event_log);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -91,11 +92,11 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	 * Allocate memory for the 'combined log' where we will append the
 	 * 'final events log' to.
 	 */
-	tmp = krealloc(log->bios_event_log,
-		       log_size + final_events_log_size,
-		       GFP_KERNEL);
+	tmp = devm_krealloc(&chip->dev, log->bios_event_log,
+			    log_size + final_events_log_size,
+			    GFP_KERNEL);
 	if (!tmp) {
-		kfree(log->bios_event_log);
+		devm_kfree(&chip->dev, log->bios_event_log);
 		ret = -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index a9ce66d09a75..741ab2204b11 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -10,6 +10,7 @@
  * Read the event log created by the firmware on PPC64
  */
 
+#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/tpm_eventlog.h>
@@ -65,7 +66,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
+	log->bios_event_log = devm_kmemdup(&chip->dev, __va(base), size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index c0759d49fd14..916ee815b140 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -267,7 +267,6 @@ static void tpm_dev_release(struct device *dev)
 	idr_remove(&dev_nums_idr, chip->dev_num);
 	mutex_unlock(&idr_lock);
 
-	kfree(chip->log.bios_event_log);
 	kfree(chip->work_space.context_buf);
 	kfree(chip->work_space.session_buf);
 	kfree(chip->allocated_banks);
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index b0f057207945..d2647ea58ae2 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -31,6 +31,7 @@ static const struct mtk_gate_regs bdp1_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &bdp1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate bdp_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "bdp_dummy"),
 	GATE_BDP0(CLK_BDP_BRG_BA, "brg_baclk", "mm_sel", 0),
 	GATE_BDP0(CLK_BDP_BRG_DRAM, "brg_dram", "mm_sel", 1),
 	GATE_BDP0(CLK_BDP_LARB_DRAM, "larb_dram", "mm_sel", 2),
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index eb172473f075..569b6d3607dd 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -22,6 +22,7 @@ static const struct mtk_gate_regs img_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "img_dummy"),
 	GATE_IMG(CLK_IMG_SMI_COMM, "img_smi_comm", "mm_sel", 0),
 	GATE_IMG(CLK_IMG_RESZ, "img_resz", "mm_sel", 1),
 	GATE_IMG(CLK_IMG_JPGDEC_SMI, "img_jpgdec_smi", "mm_sel", 5),
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index 0f07c5d731df..fdd2645c167f 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -31,6 +31,7 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "vdec_dummy"),
 	GATE_VDEC0(CLK_VDEC_CKGEN, "vdec_cken", "vdec_sel", 0),
 	GATE_VDEC1(CLK_VDEC_LARB, "vdec_larb_cken", "mm_sel", 0),
 };
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9dbfc11d5c59..7b1ad73309b1 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -21,6 +21,22 @@
 #include "clk-gate.h"
 #include "clk-mux.h"
 
+const struct mtk_gate_regs cg_regs_dummy = { 0, 0, 0 };
+EXPORT_SYMBOL_GPL(cg_regs_dummy);
+
+static int mtk_clk_dummy_enable(struct clk_hw *hw)
+{
+	return 0;
+}
+
+static void mtk_clk_dummy_disable(struct clk_hw *hw) { }
+
+const struct clk_ops mtk_clk_dummy_ops = {
+	.enable		= mtk_clk_dummy_enable,
+	.disable	= mtk_clk_dummy_disable,
+};
+EXPORT_SYMBOL_GPL(mtk_clk_dummy_ops);
+
 static void mtk_init_clk_data(struct clk_hw_onecell_data *clk_data,
 			      unsigned int clk_num)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 65c24ab6c947..04f371730ee3 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -22,6 +22,25 @@
 
 struct platform_device;
 
+/*
+ * We need the clock IDs to start from zero but to maintain devicetree
+ * backwards compatibility we can't change bindings to start from zero.
+ * Only a few platforms are affected, so we solve issues given by the
+ * commonized MTK clocks probe function(s) by adding a dummy clock at
+ * the beginning where needed.
+ */
+#define CLK_DUMMY		0
+
+extern const struct clk_ops mtk_clk_dummy_ops;
+extern const struct mtk_gate_regs cg_regs_dummy;
+
+#define GATE_DUMMY(_id, _name) {				\
+		.id = _id,					\
+		.name = _name,					\
+		.regs = &cg_regs_dummy,				\
+		.ops = &mtk_clk_dummy_ops,			\
+	}
+
 struct mtk_fixed_clk {
 	int id;
 	const char *name;
diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 518092d7eaf7..303d0871184a 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -95,7 +95,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 	 * Configure interrupt enable registers such that Tag, Data RAM related
 	 * interrupts are propagated to interrupt controller for servicing
 	 */
-	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
 				 TRP0_INTERRUPT_ENABLE,
 				 TRP0_INTERRUPT_ENABLE);
 	if (ret)
@@ -113,7 +113,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
 				 DRP0_INTERRUPT_ENABLE,
 				 DRP0_INTERRUPT_ENABLE);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 19f543ba7205..56e24b050eec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -885,6 +885,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int i;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -906,6 +907,12 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	/* Update reference counts for HPDs */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
+		if (amdgpu_irq_get(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
+			drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n", i);
+	}
 }
 
 /**
@@ -921,6 +928,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int i;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -941,4 +949,10 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	/* Update reference counts for HPDs */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
+		if (amdgpu_irq_put(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
+			drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n", i);
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 3eb8794807d2..cb4b17c3b694 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -51,7 +51,8 @@ static bool link_supports_psrsu(struct dc_link *link)
 	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
 		return false;
 
-	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
+	/* Temporarily disable PSR-SU to avoid glitches */
+	return false;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 4d2590964a20..75e44d8a7b40 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1862,19 +1862,21 @@ static enum bp_result get_firmware_info_v3_2(
 		/* Vega12 */
 		smu_info_v3_2 = GET_IMAGE(struct atom_smu_info_v3_2,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
 		if (!smu_info_v3_2)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_2->bootup_dcefclk_10khz * 10;
 	} else if (revision.minor == 3) {
 		/* Vega20 */
 		smu_info_v3_3 = GET_IMAGE(struct atom_smu_info_v3_3,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
 		if (!smu_info_v3_3)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_3->bootup_dcefclk_10khz * 10;
 	}
 
@@ -2439,10 +2441,11 @@ static enum bp_result get_integrated_info_v11(
 	info_v11 = GET_IMAGE(struct atom_integrated_system_info_v1_11,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
 	if (info_v11 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v11->gpucapinfo);
 	/*
@@ -2654,11 +2657,12 @@ static enum bp_result get_integrated_info_v2_1(
 
 	info_v2_1 = GET_IMAGE(struct atom_integrated_system_info_v2_1,
 					DATA_TABLES(integratedsysteminfo));
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
 
 	if (info_v2_1 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_1->gpucapinfo);
 	/*
@@ -2816,11 +2820,11 @@ static enum bp_result get_integrated_info_v2_2(
 	info_v2_2 = GET_IMAGE(struct atom_integrated_system_info_v2_2,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
-
 	if (info_v2_2 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_2->gpucapinfo);
 	/*
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index a24f3b35ae91..a75c04d510fd 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3056,6 +3056,7 @@ static int kv_dpm_hw_init(void *handle)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	kv_dpm_setup_asic(adev);
 	ret = kv_dpm_enable(adev);
 	if (ret)
@@ -3063,6 +3064,8 @@ static int kv_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -3080,32 +3083,42 @@ static int kv_dpm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_work_sync(&adev->pm.dpm.thermal.work);
+
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		kv_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
 	return 0;
 }
 
 static int kv_dpm_resume(void *handle)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
 		/* asic init will reset to the boot state */
 		kv_dpm_setup_asic(adev);
 		ret = kv_dpm_enable(adev);
-		if (ret)
+		if (ret) {
 			adev->pm.dpm_enabled = false;
-		else
+		} else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+	return ret;
 }
 
 static bool kv_dpm_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 291223ea7ba7..2fd97f5cf8f6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1018,9 +1018,12 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
 	int temp, size = sizeof(temp);
 
-	if (!adev->pm.dpm_enabled)
-		return;
+	mutex_lock(&adev->pm.mutex);
 
+	if (!adev->pm.dpm_enabled) {
+		mutex_unlock(&adev->pm.mutex);
+		return;
+	}
 	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
 				   AMDGPU_PP_SENSOR_GPU_TEMP,
 				   (void *)&temp,
@@ -1042,4 +1045,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	adev->pm.dpm.state = dpm_state;
 
 	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index ff1032de4f76..52e4397d4a2a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7796,6 +7796,7 @@ static int si_dpm_hw_init(void *handle)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	si_dpm_setup_asic(adev);
 	ret = si_dpm_enable(adev);
 	if (ret)
@@ -7803,6 +7804,7 @@ static int si_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
 	return ret;
 }
 
@@ -7820,32 +7822,44 @@ static int si_dpm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_work_sync(&adev->pm.dpm.thermal.work);
+
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		si_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
+
 	return 0;
 }
 
 static int si_dpm_resume(void *handle)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
+		mutex_lock(&adev->pm.mutex);
 		si_dpm_setup_asic(adev);
 		ret = si_dpm_enable(adev);
-		if (ret)
+		if (ret) {
 			adev->pm.dpm_enabled = false;
-		else
+		} else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+
+	return ret;
 }
 
 static bool si_dpm_is_idle(void *handle)
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index fb8d1d63407a..4b5bf23f2336 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6691,12 +6691,30 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
 static int intel_bigjoiner_add_affected_crtcs(struct intel_atomic_state *state)
 {
 	struct drm_i915_private *i915 = to_i915(state->base.dev);
+	const struct intel_plane_state *plane_state;
 	struct intel_crtc_state *crtc_state;
+	struct intel_plane *plane;
 	struct intel_crtc *crtc;
 	u8 affected_pipes = 0;
 	u8 modeset_pipes = 0;
 	int i;
 
+	/*
+	 * Any plane which is in use by the joiner needs its crtc.
+	 * Pull those in first as this will not have happened yet
+	 * if the plane remains disabled according to uapi.
+	 */
+	for_each_new_intel_plane_in_state(state, plane, plane_state, i) {
+		crtc = to_intel_crtc(plane_state->hw.crtc);
+		if (!crtc)
+			continue;
+
+		crtc_state = intel_atomic_get_crtc_state(&state->base, crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+	}
+
+	/* Now pull in all joined crtcs */
 	for_each_new_intel_crtc_in_state(state, crtc, crtc_state, i) {
 		affected_pipes |= crtc_state->bigjoiner_pipes;
 		if (intel_crtc_needs_modeset(crtc_state))
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index ba8f2ba04629..5f8345016ffe 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2059,6 +2059,9 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 		}
 	}
 
+	if (phys_enc->hw_pp && phys_enc->hw_pp->ops.setup_dither)
+		phys_enc->hw_pp->ops.setup_dither(phys_enc->hw_pp, NULL);
+
 	/* reset the merge 3D HW block */
 	if (phys_enc->hw_pp && phys_enc->hw_pp->merge_3d) {
 		phys_enc->hw_pp->merge_3d->ops.setup_3d_mode(phys_enc->hw_pp->merge_3d,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
index c8f14555834a..70a6dfe94faa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
@@ -46,6 +46,7 @@ static void dpu_hw_dsc_config(struct dpu_hw_dsc *hw_dsc,
 	u32 slice_last_group_size;
 	u32 det_thresh_flatness;
 	bool is_cmd_mode = !(mode & DSC_MODE_VIDEO);
+	bool input_10_bits = dsc->bits_per_component == 10;
 
 	DPU_REG_WRITE(c, DSC_COMMON_MODE, mode);
 
@@ -62,7 +63,7 @@ static void dpu_hw_dsc_config(struct dpu_hw_dsc *hw_dsc,
 	data |= (dsc->line_buf_depth << 3);
 	data |= (dsc->simple_422 << 2);
 	data |= (dsc->convert_rgb << 1);
-	data |= dsc->bits_per_component;
+	data |= input_10_bits;
 
 	DPU_REG_WRITE(c, DSC_ENC, data);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index be6674fb1af7..d0bff13ac758 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -592,6 +592,7 @@ static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
 	unsigned long timeout =
 		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	struct mm_struct *mm = svmm->notifier.mm;
+	struct folio *folio;
 	struct page *page;
 	unsigned long start = args->p.addr;
 	unsigned long notifier_seq;
@@ -618,12 +619,16 @@ static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
 			ret = -EINVAL;
 			goto out;
 		}
+		folio = page_folio(page);
 
 		mutex_lock(&svmm->mutex);
 		if (!mmu_interval_read_retry(&notifier->notifier,
 					     notifier_seq))
 			break;
 		mutex_unlock(&svmm->mutex);
+
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	/* Map the page on the GPU. */
@@ -639,8 +644,8 @@ static int nouveau_atomic_range_fault(struct nouveau_svmm *svmm,
 	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, size, NULL);
 	mutex_unlock(&svmm->mutex);
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 out:
 	mmu_interval_notifier_remove(&notifier->notifier);
diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
index a7f2b7f66a17..9ec9c43971df 100644
--- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
@@ -396,7 +396,7 @@ static int rcar_mipi_dsi_startup(struct rcar_mipi_dsi *dsi,
 	for (timeout = 10; timeout > 0; --timeout) {
 		if ((rcar_mipi_dsi_read(dsi, PPICLSR) & PPICLSR_STPST) &&
 		    (rcar_mipi_dsi_read(dsi, PPIDLSR) & PPIDLSR_STPST) &&
-		    (rcar_mipi_dsi_read(dsi, CLOCKSET1) & CLOCKSET1_LOCK))
+		    (rcar_mipi_dsi_read(dsi, CLOCKSET1) & CLOCKSET1_LOCK_PHY))
 			break;
 
 		usleep_range(1000, 2000);
diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
index 2eaca54636f3..1f1eb46c721f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h
@@ -141,7 +141,6 @@
 
 #define CLOCKSET1			0x101c
 #define CLOCKSET1_LOCK_PHY		(1 << 17)
-#define CLOCKSET1_LOCK			(1 << 16)
 #define CLOCKSET1_CLKSEL		(1 << 8)
 #define CLOCKSET1_CLKINSEL_EXTAL	(0 << 2)
 #define CLOCKSET1_CLKINSEL_DIG		(1 << 2)
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c986d432af50..38b2ae0d7ec1 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2655,14 +2655,32 @@ static void dispc_init_errata(struct dispc_device *dispc)
 	}
 }
 
+/*
+ * K2G display controller does not support soft reset, so we do a basic manual
+ * reset here: make sure the IRQs are masked and VPs are disabled.
+ */
+static void dispc_softreset_k2g(struct dispc_device *dispc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dispc->tidss->wait_lock, flags);
+	dispc_set_irqenable(dispc, 0);
+	dispc_read_and_clear_irqstatus(dispc);
+	spin_unlock_irqrestore(&dispc->tidss->wait_lock, flags);
+
+	for (unsigned int vp_idx = 0; vp_idx < dispc->feat->num_vps; ++vp_idx)
+		VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0, 0, 0);
+}
+
 static int dispc_softreset(struct dispc_device *dispc)
 {
 	u32 val;
 	int ret = 0;
 
-	/* K2G display controller does not support soft reset */
-	if (dispc->feat->subrev == DISPC_K2G)
+	if (dispc->feat->subrev == DISPC_K2G) {
+		dispc_softreset_k2g(dispc);
 		return 0;
+	}
 
 	/* Soft reset */
 	REG_FLD_MOD(dispc, DSS_SYSCONFIG, 1, 1, 1);
diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
index 0c681c7600bc..f13c7e434f8e 100644
--- a/drivers/gpu/drm/tidss/tidss_irq.c
+++ b/drivers/gpu/drm/tidss/tidss_irq.c
@@ -60,7 +60,9 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg)
 	unsigned int id;
 	dispc_irq_t irqstatus;
 
+	spin_lock(&tidss->wait_lock);
 	irqstatus = dispc_read_and_clear_irqstatus(tidss->dispc);
+	spin_unlock(&tidss->wait_lock);
 
 	for (id = 0; id < tidss->num_crtcs; id++) {
 		struct drm_crtc *crtc = tidss->crtcs[id];
diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index 767dd15b3c88..0947e3d155c5 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2335,6 +2335,13 @@ static int npcm_i2c_probe_bus(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	/*
+	 * Disable the interrupt to avoid the interrupt handler being triggered
+	 * incorrectly by the asynchronous interrupt status since the machine
+	 * might do a warm reset during the last smbus/i2c transfer session.
+	 */
+	npcm_i2c_int_enable(bus, false);
+
 	ret = devm_request_irq(bus->dev, irq, npcm_i2c_bus_irq, 0,
 			       dev_name(bus->dev), bus);
 	if (ret)
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index bb3d10099ba4..5d7bbccb52b5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/tsc.h>
 #include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -1583,6 +1584,9 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		if (intel_idle_state_needs_timer_stop(state))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
+		if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in idle");
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 3e1272695d99..9915504ad1e1 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -444,6 +444,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 				   struct ib_qp *qp)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	bool new = false;
 	int err;
 
 	if (!counter->id) {
@@ -458,6 +459,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 			return err;
 		counter->id =
 			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
+		new = true;
 	}
 
 	err = mlx5_ib_qp_set_counter(qp, counter);
@@ -467,8 +469,10 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 	return 0;
 
 fail_set_counter:
-	mlx5_ib_counter_dealloc(counter);
-	counter->id = 0;
+	if (new) {
+		mlx5_ib_counter_dealloc(counter);
+		counter->id = 0;
+	}
 
 	return err;
 }
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8d132b726c64..d782a494abcd 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4466,6 +4466,8 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 		set_id = mlx5_ib_get_counters_id(dev, attr->port_num - 1);
 		MLX5_SET(dctc, dctc, counter_set_id, set_id);
+
+		qp->port = attr->port_num;
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		struct mlx5_ib_modify_qp_resp resp = {};
 		u32 out[MLX5_ST_SZ_DW(create_dct_out)] = {};
@@ -4955,7 +4957,7 @@ static int mlx5_ib_dct_query_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *mqp,
 	}
 
 	if (qp_attr_mask & IB_QP_PORT)
-		qp_attr->port_num = MLX5_GET(dctc, dctc, port);
+		qp_attr->port_num = mqp->port;
 	if (qp_attr_mask & IB_QP_MIN_RNR_TIMER)
 		qp_attr->min_rnr_timer = MLX5_GET(dctc, dctc, min_rnr_nak);
 	if (qp_attr_mask & IB_QP_AV) {
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 9d8ac04c2346..e18e21b24210 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2022,33 +2022,29 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
 }
 EXPORT_SYMBOL_GPL(md_bitmap_copy_from_slot);
 
-
-void md_bitmap_status(struct seq_file *seq, struct bitmap *bitmap)
+int md_bitmap_get_stats(struct bitmap *bitmap, struct md_bitmap_stats *stats)
 {
-	unsigned long chunk_kb;
 	struct bitmap_counts *counts;
+	bitmap_super_t *sb;
 
 	if (!bitmap)
-		return;
+		return -ENOENT;
+	if (bitmap->mddev->bitmap_info.external)
+		return -ENOENT;
+	if (!bitmap->storage.sb_page) /* no superblock */
+		return -EINVAL;
+	sb = kmap_local_page(bitmap->storage.sb_page);
+	stats->sync_size = le64_to_cpu(sb->sync_size);
+	kunmap_local(sb);
 
 	counts = &bitmap->counts;
+	stats->missing_pages = counts->missing_pages;
+	stats->pages = counts->pages;
+	stats->file = bitmap->storage.file;
 
-	chunk_kb = bitmap->mddev->bitmap_info.chunksize >> 10;
-	seq_printf(seq, "bitmap: %lu/%lu pages [%luKB], "
-		   "%lu%s chunk",
-		   counts->pages - counts->missing_pages,
-		   counts->pages,
-		   (counts->pages - counts->missing_pages)
-		   << (PAGE_SHIFT - 10),
-		   chunk_kb ? chunk_kb : bitmap->mddev->bitmap_info.chunksize,
-		   chunk_kb ? "KB" : "B");
-	if (bitmap->storage.file) {
-		seq_printf(seq, ", file: ");
-		seq_file_path(seq, bitmap->storage.file, " \t\n");
-	}
-
-	seq_printf(seq, "\n");
+	return 0;
 }
+EXPORT_SYMBOL_GPL(md_bitmap_get_stats);
 
 int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		  int chunksize, int init)
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 3a4750952b3a..7b7a701f74be 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -233,6 +233,13 @@ struct bitmap {
 	int cluster_slot;		/* Slot offset for clustered env */
 };
 
+struct md_bitmap_stats {
+	unsigned long	missing_pages;
+	unsigned long	sync_size;
+	unsigned long	pages;
+	struct file	*file;
+};
+
 /* the bitmap API */
 
 /* these are used only by md/bitmap */
@@ -243,7 +250,7 @@ void md_bitmap_destroy(struct mddev *mddev);
 
 void md_bitmap_print_sb(struct bitmap *bitmap);
 void md_bitmap_update_sb(struct bitmap *bitmap);
-void md_bitmap_status(struct seq_file *seq, struct bitmap *bitmap);
+int md_bitmap_get_stats(struct bitmap *bitmap, struct md_bitmap_stats *stats);
 
 int  md_bitmap_setallbits(struct bitmap *bitmap);
 void md_bitmap_write_all(struct bitmap *bitmap);
diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 10e0c5381d01..7484bb83171a 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1185,18 +1185,21 @@ static int resize_bitmaps(struct mddev *mddev, sector_t newsize, sector_t oldsiz
  */
 static int cluster_check_sync_size(struct mddev *mddev)
 {
-	int i, rv;
-	bitmap_super_t *sb;
-	unsigned long my_sync_size, sync_size = 0;
-	int node_num = mddev->bitmap_info.nodes;
 	int current_slot = md_cluster_ops->slot_number(mddev);
+	int node_num = mddev->bitmap_info.nodes;
 	struct bitmap *bitmap = mddev->bitmap;
-	char str[64];
 	struct dlm_lock_resource *bm_lockres;
+	struct md_bitmap_stats stats;
+	unsigned long sync_size = 0;
+	unsigned long my_sync_size;
+	char str[64];
+	int i, rv;
 
-	sb = kmap_atomic(bitmap->storage.sb_page);
-	my_sync_size = sb->sync_size;
-	kunmap_atomic(sb);
+	rv = md_bitmap_get_stats(bitmap, &stats);
+	if (rv)
+		return rv;
+
+	my_sync_size = stats.sync_size;
 
 	for (i = 0; i < node_num; i++) {
 		if (i == current_slot)
@@ -1225,15 +1228,18 @@ static int cluster_check_sync_size(struct mddev *mddev)
 			md_bitmap_update_sb(bitmap);
 		lockres_free(bm_lockres);
 
-		sb = kmap_atomic(bitmap->storage.sb_page);
-		if (sync_size == 0)
-			sync_size = sb->sync_size;
-		else if (sync_size != sb->sync_size) {
-			kunmap_atomic(sb);
+		rv = md_bitmap_get_stats(bitmap, &stats);
+		if (rv) {
+			md_bitmap_free(bitmap);
+			return rv;
+		}
+
+		if (sync_size == 0) {
+			sync_size = stats.sync_size;
+		} else if (sync_size != stats.sync_size) {
 			md_bitmap_free(bitmap);
 			return -1;
 		}
-		kunmap_atomic(sb);
 		md_bitmap_free(bitmap);
 	}
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 297c86f5c70b..5e2751d42f64 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8318,6 +8318,33 @@ static void md_seq_stop(struct seq_file *seq, void *v)
 		mddev_put(mddev);
 }
 
+static void md_bitmap_status(struct seq_file *seq, struct mddev *mddev)
+{
+	struct md_bitmap_stats stats;
+	unsigned long used_pages;
+	unsigned long chunk_kb;
+	int err;
+
+	err = md_bitmap_get_stats(mddev->bitmap, &stats);
+	if (err)
+		return;
+
+	chunk_kb = mddev->bitmap_info.chunksize >> 10;
+	used_pages = stats.pages - stats.missing_pages;
+
+	seq_printf(seq, "bitmap: %lu/%lu pages [%luKB], %lu%s chunk",
+		   used_pages, stats.pages, used_pages << (PAGE_SHIFT - 10),
+		   chunk_kb ? chunk_kb : mddev->bitmap_info.chunksize,
+		   chunk_kb ? "KB" : "B");
+
+	if (stats.file) {
+		seq_puts(seq, ", file: ");
+		seq_file_path(seq, stats.file, " \t\n");
+	}
+
+	seq_putc(seq, '\n');
+}
+
 static int md_seq_show(struct seq_file *seq, void *v)
 {
 	struct mddev *mddev = v;
@@ -8341,6 +8368,9 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		return 0;
 	}
 
+	/* prevent bitmap to be freed after checking */
+	mutex_lock(&mddev->bitmap_info.mutex);
+
 	spin_lock(&mddev->lock);
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
 		seq_printf(seq, "%s : %sactive", mdname(mddev),
@@ -8406,11 +8436,12 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		} else
 			seq_printf(seq, "\n       ");
 
-		md_bitmap_status(seq, mddev->bitmap);
+		md_bitmap_status(seq, mddev);
 
 		seq_printf(seq, "\n");
 	}
 	spin_unlock(&mddev->lock);
+	mutex_unlock(&mddev->bitmap_info.mutex);
 
 	return 0;
 }
diff --git a/drivers/media/cec/platform/stm32/stm32-cec.c b/drivers/media/cec/platform/stm32/stm32-cec.c
index 40db7911b437..7b2db46a5722 100644
--- a/drivers/media/cec/platform/stm32/stm32-cec.c
+++ b/drivers/media/cec/platform/stm32/stm32-cec.c
@@ -288,12 +288,9 @@ static int stm32_cec_probe(struct platform_device *pdev)
 		return ret;
 
 	cec->clk_cec = devm_clk_get(&pdev->dev, "cec");
-	if (IS_ERR(cec->clk_cec)) {
-		if (PTR_ERR(cec->clk_cec) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Cannot get cec clock\n");
-
-		return PTR_ERR(cec->clk_cec);
-	}
+	if (IS_ERR(cec->clk_cec))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cec->clk_cec),
+				     "Cannot get cec clock\n");
 
 	ret = clk_prepare(cec->clk_cec);
 	if (ret) {
diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 088c29c4e252..56d22d02a0d9 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -301,21 +301,15 @@ static int ad5820_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	coil->vana = devm_regulator_get(&client->dev, "VANA");
-	if (IS_ERR(coil->vana)) {
-		ret = PTR_ERR(coil->vana);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&client->dev, "could not get regulator for vana\n");
-		return ret;
-	}
+	if (IS_ERR(coil->vana))
+		return dev_err_probe(&client->dev, PTR_ERR(coil->vana),
+				     "could not get regulator for vana\n");
 
 	coil->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
 						    GPIOD_OUT_LOW);
-	if (IS_ERR(coil->enable_gpio)) {
-		ret = PTR_ERR(coil->enable_gpio);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&client->dev, "could not get enable gpio\n");
-		return ret;
-	}
+	if (IS_ERR(coil->enable_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(coil->enable_gpio),
+				     "could not get enable gpio\n");
 
 	mutex_init(&coil->power_lock);
 
diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index a00761b1e18c..9219f3c9594b 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -2060,9 +2060,8 @@ static int imx274_probe(struct i2c_client *client)
 	imx274->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						     GPIOD_OUT_HIGH);
 	if (IS_ERR(imx274->reset_gpio)) {
-		if (PTR_ERR(imx274->reset_gpio) != -EPROBE_DEFER)
-			dev_err(dev, "Reset GPIO not setup in DT");
-		ret = PTR_ERR(imx274->reset_gpio);
+		ret = dev_err_probe(dev, PTR_ERR(imx274->reset_gpio),
+				    "Reset GPIO not setup in DT\n");
 		goto err_me;
 	}
 
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 45dd91d1cd81..2c8189e04a13 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -1891,12 +1891,9 @@ static int tc358743_probe_of(struct tc358743_state *state)
 	int ret;
 
 	refclk = devm_clk_get(dev, "refclk");
-	if (IS_ERR(refclk)) {
-		if (PTR_ERR(refclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get refclk: %ld\n",
-				PTR_ERR(refclk));
-		return PTR_ERR(refclk);
-	}
+	if (IS_ERR(refclk))
+		return dev_err_probe(dev, PTR_ERR(refclk),
+				     "failed to get refclk\n");
 
 	ep = of_graph_get_next_endpoint(dev->of_node, NULL);
 	if (!ep) {
diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c b/drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c
index 1e3833f1c9ae..ad5fab2d8bfa 100644
--- a/drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c
@@ -52,9 +52,8 @@ int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		comp->clk[i] = of_clk_get(node, i);
 		if (IS_ERR(comp->clk[i])) {
-			if (PTR_ERR(comp->clk[i]) != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get clock\n");
-			ret = PTR_ERR(comp->clk[i]);
+			ret = dev_err_probe(dev, PTR_ERR(comp->clk[i]),
+					    "Failed to get clock\n");
 			goto put_dev;
 		}
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
index d8e66b645bd8..27f08b1d34d1 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
@@ -65,6 +65,8 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
 	}
 
 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw)
+		return ERR_PTR(-ENOMEM);
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 999ce7ee5fdc..6952875ca183 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -729,11 +729,16 @@ static int vdec_h264_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs
 		return vpu_dec_reset(vpu);
 
 	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
+	if (!fb) {
+		mtk_vcodec_err(inst, "fb buffer is NULL");
+		return -ENOMEM;
+	}
+
 	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
 	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
 
-	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
-	c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
+	y_fb_dma = fb->base_y.dma_addr;
+	c_fb_dma = fb->base_c.dma_addr;
 	mtk_vcodec_debug(inst, "[h264-dec] [%d] y_dma=%llx c_dma=%llx",
 			 inst->ctx->decoded_frame_cnt, y_fb_dma, c_fb_dma);
 
diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
index 2f3071acb9c9..98a60f01129d 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -1471,9 +1471,7 @@ static int fimc_md_probe(struct platform_device *pdev)
 
 	pinctrl = devm_pinctrl_get(dev);
 	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get pinctrl: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(pinctrl), "Failed to get pinctrl\n");
 		goto err_clk;
 	}
 
diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index 37458d4d9564..06be28b361f1 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -1946,12 +1946,9 @@ static int dcmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dcmi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(dcmi->rstc)) {
-		if (PTR_ERR(dcmi->rstc) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get reset control\n");
-
-		return PTR_ERR(dcmi->rstc);
-	}
+	if (IS_ERR(dcmi->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dcmi->rstc),
+				     "Could not get reset control\n");
 
 	/* Get bus characteristics from devicetree */
 	np = of_graph_get_next_endpoint(np, NULL);
@@ -2003,20 +2000,14 @@ static int dcmi_probe(struct platform_device *pdev)
 	}
 
 	mclk = devm_clk_get(&pdev->dev, "mclk");
-	if (IS_ERR(mclk)) {
-		if (PTR_ERR(mclk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Unable to get mclk\n");
-		return PTR_ERR(mclk);
-	}
+	if (IS_ERR(mclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(mclk),
+				     "Unable to get mclk\n");
 
 	chan = dma_request_chan(&pdev->dev, "tx");
-	if (IS_ERR(chan)) {
-		ret = PTR_ERR(chan);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"Failed to request DMA channel: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(chan))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chan),
+				     "Failed to request DMA channel\n");
 
 	dcmi->dma_max_burst = UINT_MAX;
 	ret = dma_get_slave_caps(chan, &caps);
diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index 11ae479ee89c..e7327e38482d 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -1884,8 +1884,7 @@ static int isp_initialize_modules(struct isp_device *isp)
 
 	ret = omap3isp_ccp2_init(isp);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(isp->dev, "CCP2 initialization failed\n");
+		dev_err_probe(isp->dev, ret, "CCP2 initialization failed\n");
 		goto error_ccp2;
 	}
 
diff --git a/drivers/media/platform/xilinx/xilinx-csi2rxss.c b/drivers/media/platform/xilinx/xilinx-csi2rxss.c
index 29b53febc2e7..d8a23f18cfbc 100644
--- a/drivers/media/platform/xilinx/xilinx-csi2rxss.c
+++ b/drivers/media/platform/xilinx/xilinx-csi2rxss.c
@@ -976,11 +976,9 @@ static int xcsi2rxss_probe(struct platform_device *pdev)
 	/* Reset GPIO */
 	xcsi2rxss->rst_gpio = devm_gpiod_get_optional(dev, "video-reset",
 						      GPIOD_OUT_HIGH);
-	if (IS_ERR(xcsi2rxss->rst_gpio)) {
-		if (PTR_ERR(xcsi2rxss->rst_gpio) != -EPROBE_DEFER)
-			dev_err(dev, "Video Reset GPIO not setup in DT");
-		return PTR_ERR(xcsi2rxss->rst_gpio);
-	}
+	if (IS_ERR(xcsi2rxss->rst_gpio))
+		return dev_err_probe(dev, PTR_ERR(xcsi2rxss->rst_gpio),
+				     "Video Reset GPIO not setup in DT\n");
 
 	ret = xcsi2rxss_parse_of(xcsi2rxss);
 	if (ret < 0)
diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index 16795e07dc10..41ef8cdba28c 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -74,13 +74,9 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gpio_dev->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
-	if (IS_ERR(gpio_dev->gpiod)) {
-		rc = PTR_ERR(gpio_dev->gpiod);
-		/* Just try again if this happens */
-		if (rc != -EPROBE_DEFER)
-			dev_err(dev, "error getting gpio (%d)\n", rc);
-		return rc;
-	}
+	if (IS_ERR(gpio_dev->gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpio_dev->gpiod),
+				     "error getting gpio\n");
 	gpio_dev->irq = gpiod_to_irq(gpio_dev->gpiod);
 	if (gpio_dev->irq < 0)
 		return gpio_dev->irq;
diff --git a/drivers/media/rc/gpio-ir-tx.c b/drivers/media/rc/gpio-ir-tx.c
index d3063ddb472e..2b829c146db1 100644
--- a/drivers/media/rc/gpio-ir-tx.c
+++ b/drivers/media/rc/gpio-ir-tx.c
@@ -174,12 +174,9 @@ static int gpio_ir_tx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gpio_ir->gpio = devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(gpio_ir->gpio)) {
-		if (PTR_ERR(gpio_ir->gpio) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get gpio (%ld)\n",
-				PTR_ERR(gpio_ir->gpio));
-		return PTR_ERR(gpio_ir->gpio);
-	}
+	if (IS_ERR(gpio_ir->gpio))
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpio_ir->gpio),
+				     "Failed to get gpio\n");
 
 	rcdev->priv = gpio_ir;
 	rcdev->driver_name = DRIVER_NAME;
diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index a3b145183260..85080c3d2053 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -231,13 +231,8 @@ static int ir_rx51_probe(struct platform_device *dev)
 	struct rc_dev *rcdev;
 
 	pwm = pwm_get(&dev->dev, NULL);
-	if (IS_ERR(pwm)) {
-		int err = PTR_ERR(pwm);
-
-		if (err != -EPROBE_DEFER)
-			dev_err(&dev->dev, "pwm_get failed: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(pwm))
+		return dev_err_probe(&dev->dev, PTR_ERR(pwm), "pwm_get failed\n");
 
 	/* Use default, in case userspace does not set the carrier */
 	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm), NSEC_PER_SEC);
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 1bad64f4499a..69f9f451ab40 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1470,6 +1470,40 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
 	uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
 }
 
+static void uvc_ctrl_set_handle(struct uvc_fh *handle, struct uvc_control *ctrl,
+				struct uvc_fh *new_handle)
+{
+	lockdep_assert_held(&handle->chain->ctrl_mutex);
+
+	if (new_handle) {
+		if (ctrl->handle)
+			dev_warn_ratelimited(&handle->stream->dev->udev->dev,
+					     "UVC non compliance: Setting an async control with a pending operation.");
+
+		if (new_handle == ctrl->handle)
+			return;
+
+		if (ctrl->handle) {
+			WARN_ON(!ctrl->handle->pending_async_ctrls);
+			if (ctrl->handle->pending_async_ctrls)
+				ctrl->handle->pending_async_ctrls--;
+		}
+
+		ctrl->handle = new_handle;
+		handle->pending_async_ctrls++;
+		return;
+	}
+
+	/* Cannot clear the handle for a control not owned by us.*/
+	if (WARN_ON(ctrl->handle != handle))
+		return;
+
+	ctrl->handle = NULL;
+	if (WARN_ON(!handle->pending_async_ctrls))
+		return;
+	handle->pending_async_ctrls--;
+}
+
 void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 			   struct uvc_control *ctrl, const u8 *data)
 {
@@ -1480,7 +1514,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	mutex_lock(&chain->ctrl_mutex);
 
 	handle = ctrl->handle;
-	ctrl->handle = NULL;
+	if (handle)
+		uvc_ctrl_set_handle(handle, ctrl, NULL);
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value = __uvc_ctrl_get_value(mapping, data);
@@ -1700,7 +1735,10 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 }
 
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
-	struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
+				  struct uvc_fh *handle,
+				  struct uvc_entity *entity,
+				  int rollback,
+				  struct uvc_control **err_ctrl)
 {
 	struct uvc_control *ctrl;
 	unsigned int i;
@@ -1748,6 +1786,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				*err_ctrl = ctrl;
 			return ret;
 		}
+
+		if (!rollback && handle &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
 	return 0;
@@ -1784,18 +1826,20 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
-					     &err_ctrl);
-		if (ret < 0)
+		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
+					     rollback, &err_ctrl);
+		if (ret < 0) {
+			if (ctrls)
+				ctrls->error_idx =
+					uvc_ctrl_find_ctrl_idx(entity, ctrls,
+							       err_ctrl);
 			goto done;
+		}
 	}
 
 	if (!rollback)
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 done:
-	if (ret < 0 && ctrls)
-		ctrls->error_idx = uvc_ctrl_find_ctrl_idx(entity, ctrls,
-							  err_ctrl);
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
 }
@@ -1925,9 +1969,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-		ctrl->handle = handle;
-
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
 	return 0;
@@ -2100,7 +2141,7 @@ static int uvc_ctrl_init_xu_ctrl(struct uvc_device *dev,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 	struct uvc_xu_control_query *xqry)
 {
-	struct uvc_entity *entity;
+	struct uvc_entity *entity, *iter;
 	struct uvc_control *ctrl;
 	unsigned int i;
 	bool found;
@@ -2110,16 +2151,16 @@ int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 	int ret;
 
 	/* Find the extension unit. */
-	found = false;
-	list_for_each_entry(entity, &chain->entities, chain) {
-		if (UVC_ENTITY_TYPE(entity) == UVC_VC_EXTENSION_UNIT &&
-		    entity->id == xqry->unit) {
-			found = true;
+	entity = NULL;
+	list_for_each_entry(iter, &chain->entities, chain) {
+		if (UVC_ENTITY_TYPE(iter) == UVC_VC_EXTENSION_UNIT &&
+		    iter->id == xqry->unit) {
+			entity = iter;
 			break;
 		}
 	}
 
-	if (!found) {
+	if (!entity) {
 		uvc_dbg(chain->dev, CONTROL, "Extension unit %u not found\n",
 			xqry->unit);
 		return -ENOENT;
@@ -2256,7 +2297,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
+		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
 		if (ret < 0)
 			return ret;
 	}
@@ -2660,6 +2701,26 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
 	return 0;
 }
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
+{
+	struct uvc_entity *entity;
+
+	guard(mutex)(&handle->chain->ctrl_mutex);
+
+	if (!handle->pending_async_ctrls)
+		return;
+
+	list_for_each_entry(entity, &handle->chain->dev->entities, list) {
+		for (unsigned int i = 0; i < entity->ncontrols; ++i) {
+			if (entity->controls[i].handle != handle)
+				continue;
+			uvc_ctrl_set_handle(handle, &entity->controls[i], NULL);
+		}
+	}
+
+	WARN_ON(handle->pending_async_ctrls);
+}
+
 /*
  * Cleanup device controls.
  */
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c8e72079b427..47a6cedd5578 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1247,18 +1247,15 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 	struct gpio_desc *gpio_privacy;
 	int irq;
 
-	gpio_privacy = devm_gpiod_get_optional(&dev->udev->dev, "privacy",
+	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
 					       GPIOD_IN);
 	if (IS_ERR_OR_NULL(gpio_privacy))
 		return PTR_ERR_OR_ZERO(gpio_privacy);
 
 	irq = gpiod_to_irq(gpio_privacy);
-	if (irq < 0) {
-		if (irq != EPROBE_DEFER)
-			dev_err(&dev->udev->dev,
-				"No IRQ for privacy GPIO (%d)\n", irq);
-		return irq;
-	}
+	if (irq < 0)
+		return dev_err_probe(&dev->intf->dev, irq,
+				     "No IRQ for privacy GPIO\n");
 
 	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
 	if (!unit)
@@ -1283,15 +1280,27 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 static int uvc_gpio_init_irq(struct uvc_device *dev)
 {
 	struct uvc_entity *unit = dev->gpio_unit;
+	int ret;
 
 	if (!unit || unit->gpio.irq < 0)
 		return 0;
 
-	return devm_request_threaded_irq(&dev->udev->dev, unit->gpio.irq, NULL,
-					 uvc_gpio_irq,
-					 IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
-					 IRQF_TRIGGER_RISING,
-					 "uvc_privacy_gpio", dev);
+	ret = request_threaded_irq(unit->gpio.irq, NULL, uvc_gpio_irq,
+				   IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
+				   IRQF_TRIGGER_RISING,
+				   "uvc_privacy_gpio", dev);
+
+	unit->gpio.initialized = !ret;
+
+	return ret;
+}
+
+static void uvc_gpio_deinit(struct uvc_device *dev)
+{
+	if (!dev->gpio_unit || !dev->gpio_unit->gpio.initialized)
+		return;
+
+	free_irq(dev->gpio_unit->gpio.irq, dev);
 }
 
 /* ------------------------------------------------------------------------
@@ -1885,6 +1894,8 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
+	uvc_gpio_deinit(dev);
+
 	list_for_each_entry(stream, &dev->streams, list) {
 		/* Nothing to do here, continue. */
 		if (!video_is_registered(&stream->vdev))
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 950b42d78a10..bd4677a6e653 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -607,6 +607,8 @@ static int uvc_v4l2_release(struct file *file)
 
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
 
+	uvc_ctrl_cleanup_fh(handle);
+
 	/* Only free resources if this is a privileged handle. */
 	if (uvc_has_privileges(handle))
 		uvc_queue_release(&stream->queue);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 33e7475d4e64..45caa8523426 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -227,6 +227,7 @@ struct uvc_entity {
 			u8  *bmControls;
 			struct gpio_desc *gpio_privacy;
 			int irq;
+			bool initialized;
 		} gpio;
 	};
 
@@ -330,7 +331,11 @@ struct uvc_video_chain {
 	struct uvc_entity *processing;		/* Processing unit */
 	struct uvc_entity *selector;		/* Selector unit */
 
-	struct mutex ctrl_mutex;		/* Protects ctrl.info */
+	struct mutex ctrl_mutex;		/*
+						 * Protects ctrl.info,
+						 * ctrl.handle and
+						 * uvc_fh.pending_async_ctrls
+						 */
 
 	struct v4l2_prio_state prio;		/* V4L2 priority state */
 	u32 caps;				/* V4L2 chain-wide caps */
@@ -584,6 +589,7 @@ struct uvc_fh {
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
+	unsigned int pending_async_ctrls;
 };
 
 struct uvc_driver {
@@ -768,6 +774,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);
diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 9dac3ca69d57..7d686a96d44c 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -469,6 +469,8 @@ struct cdns_nand_ctrl {
 	struct {
 		void __iomem *virt;
 		dma_addr_t dma;
+		dma_addr_t iova_dma;
+		u32 size;
 	} io;
 
 	int irq;
@@ -1830,11 +1832,11 @@ static int cadence_nand_slave_dma_transfer(struct cdns_nand_ctrl *cdns_ctrl,
 	}
 
 	if (dir == DMA_FROM_DEVICE) {
-		src_dma = cdns_ctrl->io.dma;
+		src_dma = cdns_ctrl->io.iova_dma;
 		dst_dma = buf_dma;
 	} else {
 		src_dma = buf_dma;
-		dst_dma = cdns_ctrl->io.dma;
+		dst_dma = cdns_ctrl->io.iova_dma;
 	}
 
 	tx = dmaengine_prep_dma_memcpy(cdns_ctrl->dmac, dst_dma, src_dma, len,
@@ -1856,12 +1858,12 @@ static int cadence_nand_slave_dma_transfer(struct cdns_nand_ctrl *cdns_ctrl,
 	dma_async_issue_pending(cdns_ctrl->dmac);
 	wait_for_completion(&finished);
 
-	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
+	dma_unmap_single(dma_dev->dev, buf_dma, len, dir);
 
 	return 0;
 
 err_unmap:
-	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
+	dma_unmap_single(dma_dev->dev, buf_dma, len, dir);
 
 err:
 	dev_dbg(cdns_ctrl->dev, "Fall back to CPU I/O\n");
@@ -2828,6 +2830,7 @@ cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_ctrl *cdns_ctrl)
 static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	dma_cap_mask_t mask;
+	struct dma_device *dma_dev = cdns_ctrl->dmac->device;
 	int ret;
 
 	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
@@ -2863,15 +2866,24 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	dma_cap_set(DMA_MEMCPY, mask);
 
 	if (cdns_ctrl->caps1->has_dma) {
-		cdns_ctrl->dmac = dma_request_channel(mask, NULL, NULL);
-		if (!cdns_ctrl->dmac) {
-			dev_err(cdns_ctrl->dev,
-				"Unable to get a DMA channel\n");
-			ret = -EBUSY;
+		cdns_ctrl->dmac = dma_request_chan_by_mask(&mask);
+		if (IS_ERR(cdns_ctrl->dmac)) {
+			ret = dev_err_probe(cdns_ctrl->dev, PTR_ERR(cdns_ctrl->dmac),
+					    "%d: Failed to get a DMA channel\n", ret);
 			goto disable_irq;
 		}
 	}
 
+	cdns_ctrl->io.iova_dma = dma_map_resource(dma_dev->dev, cdns_ctrl->io.dma,
+						  cdns_ctrl->io.size,
+						  DMA_BIDIRECTIONAL, 0);
+
+	ret = dma_mapping_error(dma_dev->dev, cdns_ctrl->io.iova_dma);
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "Failed to map I/O resource to DMA\n");
+		goto dma_release_chnl;
+	}
+
 	nand_controller_init(&cdns_ctrl->controller);
 	INIT_LIST_HEAD(&cdns_ctrl->chips);
 
@@ -2882,18 +2894,22 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	if (ret) {
 		dev_err(cdns_ctrl->dev, "Failed to register MTD: %d\n",
 			ret);
-		goto dma_release_chnl;
+		goto unmap_dma_resource;
 	}
 
 	kfree(cdns_ctrl->buf);
 	cdns_ctrl->buf = kzalloc(cdns_ctrl->buf_size, GFP_KERNEL);
 	if (!cdns_ctrl->buf) {
 		ret = -ENOMEM;
-		goto dma_release_chnl;
+		goto unmap_dma_resource;
 	}
 
 	return 0;
 
+unmap_dma_resource:
+	dma_unmap_resource(dma_dev->dev, cdns_ctrl->io.iova_dma,
+			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
+
 dma_release_chnl:
 	if (cdns_ctrl->dmac)
 		dma_release_channel(cdns_ctrl->dmac);
@@ -2915,6 +2931,8 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 static void cadence_nand_remove(struct cdns_nand_ctrl *cdns_ctrl)
 {
 	cadence_nand_chips_cleanup(cdns_ctrl);
+	dma_unmap_resource(cdns_ctrl->dmac->device->dev, cdns_ctrl->io.iova_dma,
+			   cdns_ctrl->io.size, DMA_BIDIRECTIONAL, 0);
 	cadence_nand_irq_cleanup(cdns_ctrl->irq, cdns_ctrl);
 	kfree(cdns_ctrl->buf);
 	dma_free_coherent(cdns_ctrl->dev, sizeof(struct cadence_nand_cdma_desc),
@@ -2983,7 +3001,9 @@ static int cadence_nand_dt_probe(struct platform_device *ofdev)
 	cdns_ctrl->io.virt = devm_platform_get_and_ioremap_resource(ofdev, 1, &res);
 	if (IS_ERR(cdns_ctrl->io.virt))
 		return PTR_ERR(cdns_ctrl->io.virt);
+
 	cdns_ctrl->io.dma = res->start;
+	cdns_ctrl->io.size = resource_size(res);
 
 	dt->clk = devm_clk_get(cdns_ctrl->dev, "nf_clk");
 	if (IS_ERR(dt->clk))
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 1aa578c1ca4a..8d66de71ea60 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1271,6 +1271,8 @@ struct macb {
 	struct clk		*rx_clk;
 	struct clk		*tsu_clk;
 	struct net_device	*dev;
+	/* Protects hw_stats and ethtool_stats */
+	spinlock_t		stats_lock;
 	union {
 		struct macb_stats	macb;
 		struct gem_stats	gem;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d44d53d69762..fc3342944dbc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1936,10 +1936,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 		if (status & MACB_BIT(ISR_ROVR)) {
 			/* We missed at least one packet */
+			spin_lock(&bp->stats_lock);
 			if (macb_is_gem(bp))
 				bp->hw_stats.gem.rx_overruns++;
 			else
 				bp->hw_stats.macb.rx_overruns++;
+			spin_unlock(&bp->stats_lock);
 
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
@@ -2999,6 +3001,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	if (!netif_running(bp->dev))
 		return nstat;
 
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 
 	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
@@ -3028,6 +3031,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	nstat->tx_aborted_errors = hwstat->tx_excessive_collisions;
 	nstat->tx_carrier_errors = hwstat->tx_carrier_sense_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underrun;
+	spin_unlock_irq(&bp->stats_lock);
 
 	return nstat;
 }
@@ -3035,12 +3039,13 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 static void gem_get_ethtool_stats(struct net_device *dev,
 				  struct ethtool_stats *stats, u64 *data)
 {
-	struct macb *bp;
+	struct macb *bp = netdev_priv(dev);
 
-	bp = netdev_priv(dev);
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
 			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static int gem_get_sset_count(struct net_device *dev, int sset)
@@ -3090,6 +3095,7 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 		return gem_get_stats(bp);
 
 	/* read stats from hardware */
+	spin_lock_irq(&bp->stats_lock);
 	macb_update_stats(bp);
 
 	/* Convert HW stats into netdevice stats */
@@ -3123,6 +3129,7 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 	nstat->tx_carrier_errors = hwstat->tx_carrier_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underruns;
 	/* Don't know about heartbeat or window errors... */
+	spin_unlock_irq(&bp->stats_lock);
 
 	return nstat;
 }
@@ -4949,6 +4956,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->usrio = macb_config->usrio;
 
 	spin_lock_init(&bp->lock);
+	spin_lock_init(&bp->stats_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 19edb1ba6d66..230b317d93da 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -123,6 +123,24 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+/**
+ * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer Tx frame
+ * @tx_ring: Pointer to the Tx ring on which the buffer descriptors are located
+ * @count: Number of Tx buffer descriptors which need to be unmapped
+ * @i: Index of the last successfully mapped Tx buffer descriptor
+ */
+static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
+{
+	while (count--) {
+		struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
+
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	}
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -213,9 +231,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u32 lo, hi, val;
-			u64 sec, nsec;
+			__be32 new_sec_l, new_nsec;
+			u32 lo, hi, nsec, val;
+			__be16 new_sec_h;
 			u8 *data;
+			u64 sec;
 
 			lo = enetc_rd_hot(hw, ENETC_SICTR0);
 			hi = enetc_rd_hot(hw, ENETC_SICTR1);
@@ -229,13 +249,38 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			/* Update originTimestamp field of Sync packet
 			 * - 48 bits seconds field
 			 * - 32 bits nanseconds field
+			 *
+			 * In addition, the UDP checksum needs to be updated
+			 * by software after updating originTimestamp field,
+			 * otherwise the hardware will calculate the wrong
+			 * checksum when updating the correction field and
+			 * update it to the packet.
 			 */
 			data = skb_mac_header(skb);
-			*(__be16 *)(data + offset2) =
-				htons((sec >> 32) & 0xffff);
-			*(__be32 *)(data + offset2 + 2) =
-				htonl(sec & 0xffffffff);
-			*(__be32 *)(data + offset2 + 6) = htonl(nsec);
+			new_sec_h = htons((sec >> 32) & 0xffff);
+			new_sec_l = htonl(sec & 0xffffffff);
+			new_nsec = htonl(nsec);
+			if (udp) {
+				struct udphdr *uh = udp_hdr(skb);
+				__be32 old_sec_l, old_nsec;
+				__be16 old_sec_h;
+
+				old_sec_h = *(__be16 *)(data + offset2);
+				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+							 new_sec_h, false);
+
+				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+							 new_sec_l, false);
+
+				old_nsec = *(__be32 *)(data + offset2 + 6);
+				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+							 new_nsec, false);
+			}
+
+			*(__be16 *)(data + offset2) = new_sec_h;
+			*(__be32 *)(data + offset2 + 2) = new_sec_l;
+			*(__be32 *)(data + offset2 + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
@@ -306,25 +351,20 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 dma_err:
 	dev_err(tx_ring->dev, "DMA map error");
 
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (count--);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }
 
-static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
-				 struct enetc_tx_swbd *tx_swbd,
-				 union enetc_tx_bd *txbd, int *i, int hdr_len,
-				 int data_len)
+static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+				struct enetc_tx_swbd *tx_swbd,
+				union enetc_tx_bd *txbd, int *i, int hdr_len,
+				int data_len)
 {
 	union enetc_tx_bd txbd_tmp;
 	u8 flags = 0, e_flags = 0;
 	dma_addr_t addr;
+	int count = 1;
 
 	enetc_clear_tx_bd(&txbd_tmp);
 	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
@@ -367,7 +407,10 @@ static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 		/* Write the BD */
 		txbd_tmp.ext.e_flags = e_flags;
 		*txbd = txbd_tmp;
+		count++;
 	}
+
+	return count;
 }
 
 static int enetc_map_tx_tso_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
@@ -499,9 +542,9 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 
 		/* compute the csum over the L4 header */
 		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
-		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len, data_len);
+		count += enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd,
+					      &i, hdr_len, data_len);
 		bd_data_num = 0;
-		count++;
 
 		while (data_len > 0) {
 			int size;
@@ -525,8 +568,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			err = enetc_map_tx_tso_data(tx_ring, skb, tx_swbd, txbd,
 						    tso.data, size,
 						    size == data_len);
-			if (err)
+			if (err) {
+				if (i == 0)
+					i = tx_ring->bd_count;
+				i--;
+
 				goto err_map_data;
+			}
 
 			data_len -= size;
 			count++;
@@ -555,13 +603,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 	dev_err(tx_ring->dev, "DMA map error");
 
 err_chained_bd:
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (count--);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }
@@ -1581,7 +1623,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				tx_ring->stats.xdp_tx_drops++;
 			} else {
-				tx_ring->stats.xdp_tx += xdp_tx_bd_cnt;
+				tx_ring->stats.xdp_tx++;
 				rx_ring->xdp.xdp_tx_in_flight += xdp_tx_bd_cnt;
 				xdp_tx_frm_cnt++;
 				/* The XDP_TX enqueue was successful, so we
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 6d17738c1c53..44991cae9404 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -116,6 +116,7 @@ static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb);
 static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter);
 static void flush_reset_queue(struct ibmvnic_adapter *adapter);
+static void print_subcrq_error(struct device *dev, int rc, const char *func);
 
 struct ibmvnic_stat {
 	char name[ETH_GSTRING_LEN];
@@ -2135,7 +2136,7 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 		tx_buff = &tx_pool->tx_buff[index];
 		adapter->netdev->stats.tx_packets--;
 		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
-		adapter->tx_stats_buffers[queue_num].packets--;
+		adapter->tx_stats_buffers[queue_num].batched_packets--;
 		adapter->tx_stats_buffers[queue_num].bytes -=
 						tx_buff->skb->len;
 		dev_kfree_skb_any(tx_buff->skb);
@@ -2160,8 +2161,29 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 	}
 }
 
+static int send_subcrq_direct(struct ibmvnic_adapter *adapter,
+			      u64 remote_handle, u64 *entry)
+{
+	unsigned int ua = adapter->vdev->unit_address;
+	struct device *dev = &adapter->vdev->dev;
+	int rc;
+
+	/* Make sure the hypervisor sees the complete request */
+	dma_wmb();
+	rc = plpar_hcall_norets(H_SEND_SUB_CRQ, ua,
+				cpu_to_be64(remote_handle),
+				cpu_to_be64(entry[0]), cpu_to_be64(entry[1]),
+				cpu_to_be64(entry[2]), cpu_to_be64(entry[3]));
+
+	if (rc)
+		print_subcrq_error(dev, rc, __func__);
+
+	return rc;
+}
+
 static int ibmvnic_tx_scrq_flush(struct ibmvnic_adapter *adapter,
-				 struct ibmvnic_sub_crq_queue *tx_scrq)
+				 struct ibmvnic_sub_crq_queue *tx_scrq,
+				 bool indirect)
 {
 	struct ibmvnic_ind_xmit_queue *ind_bufp;
 	u64 dma_addr;
@@ -2176,12 +2198,18 @@ static int ibmvnic_tx_scrq_flush(struct ibmvnic_adapter *adapter,
 
 	if (!entries)
 		return 0;
-	rc = send_subcrq_indirect(adapter, handle, dma_addr, entries);
+
+	if (indirect)
+		rc = send_subcrq_indirect(adapter, handle, dma_addr, entries);
+	else
+		rc = send_subcrq_direct(adapter, handle,
+					(u64 *)ind_bufp->indir_arr);
+
 	if (rc)
 		ibmvnic_tx_scrq_clean_buffer(adapter, tx_scrq);
 	else
 		ind_bufp->index = 0;
-	return 0;
+	return rc;
 }
 
 static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
@@ -2200,11 +2228,13 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	unsigned int tx_map_failed = 0;
 	union sub_crq indir_arr[16];
 	unsigned int tx_dropped = 0;
-	unsigned int tx_packets = 0;
+	unsigned int tx_dpackets = 0;
+	unsigned int tx_bpackets = 0;
 	unsigned int tx_bytes = 0;
 	dma_addr_t data_dma_addr;
 	struct netdev_queue *txq;
 	unsigned long lpar_rc;
+	unsigned int skblen;
 	union sub_crq tx_crq;
 	unsigned int offset;
 	int num_entries = 1;
@@ -2234,7 +2264,9 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_dropped++;
 		tx_send_failed++;
 		ret = NETDEV_TX_OK;
-		ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
+		if (lpar_rc != H_SUCCESS)
+			goto tx_err;
 		goto out;
 	}
 
@@ -2249,8 +2281,10 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		dev_kfree_skb_any(skb);
 		tx_send_failed++;
 		tx_dropped++;
-		ibmvnic_tx_scrq_flush(adapter, tx_scrq);
 		ret = NETDEV_TX_OK;
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
+		if (lpar_rc != H_SUCCESS)
+			goto tx_err;
 		goto out;
 	}
 
@@ -2303,6 +2337,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->skb = skb;
 	tx_buff->index = bufidx;
 	tx_buff->pool_index = queue_num;
+	skblen = skb->len;
 
 	memset(&tx_crq, 0, sizeof(tx_crq));
 	tx_crq.v1.first = IBMVNIC_CRQ_CMD;
@@ -2346,6 +2381,17 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_crq.v1.flags1 |= IBMVNIC_TX_LSO;
 		tx_crq.v1.mss = cpu_to_be16(skb_shinfo(skb)->gso_size);
 		hdrs += 2;
+	} else if (!ind_bufp->index && !netdev_xmit_more()) {
+		ind_bufp->indir_arr[0] = tx_crq;
+		ind_bufp->index = 1;
+		tx_buff->num_entries = 1;
+		netdev_tx_sent_queue(txq, skb->len);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, false);
+		if (lpar_rc != H_SUCCESS)
+			goto tx_err;
+
+		tx_dpackets++;
+		goto early_exit;
 	}
 
 	if ((*hdrs >> 7) & 1)
@@ -2355,7 +2401,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->num_entries = num_entries;
 	/* flush buffer if current entry can not fit */
 	if (num_entries + ind_bufp->index > IBMVNIC_MAX_IND_DESCS) {
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_flush_err;
 	}
@@ -2363,23 +2409,26 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	indir_arr[0] = tx_crq;
 	memcpy(&ind_bufp->indir_arr[ind_bufp->index], &indir_arr[0],
 	       num_entries * sizeof(struct ibmvnic_generic_scrq));
+
 	ind_bufp->index += num_entries;
 	if (__netdev_tx_sent_queue(txq, skb->len,
 				   netdev_xmit_more() &&
 				   ind_bufp->index < IBMVNIC_MAX_IND_DESCS)) {
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 	}
 
+	tx_bpackets++;
+
+early_exit:
 	if (atomic_add_return(num_entries, &tx_scrq->used)
 					>= adapter->req_tx_entries_per_subcrq) {
 		netdev_dbg(netdev, "Stopping queue %d\n", queue_num);
 		netif_stop_subqueue(netdev, queue_num);
 	}
 
-	tx_packets++;
-	tx_bytes += skb->len;
+	tx_bytes += skblen;
 	txq_trans_cond_update(txq);
 	ret = NETDEV_TX_OK;
 	goto out;
@@ -2408,10 +2457,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	rcu_read_unlock();
 	netdev->stats.tx_dropped += tx_dropped;
 	netdev->stats.tx_bytes += tx_bytes;
-	netdev->stats.tx_packets += tx_packets;
+	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
 	adapter->tx_send_failed += tx_send_failed;
 	adapter->tx_map_failed += tx_map_failed;
-	adapter->tx_stats_buffers[queue_num].packets += tx_packets;
+	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
+	adapter->tx_stats_buffers[queue_num].direct_packets += tx_dpackets;
 	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
 	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
 
@@ -3577,7 +3627,10 @@ static void ibmvnic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 		memcpy(data, ibmvnic_stats[i].name, ETH_GSTRING_LEN);
 
 	for (i = 0; i < adapter->req_tx_queues; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "tx%d_packets", i);
+		snprintf(data, ETH_GSTRING_LEN, "tx%d_batched_packets", i);
+		data += ETH_GSTRING_LEN;
+
+		snprintf(data, ETH_GSTRING_LEN, "tx%d_direct_packets", i);
 		data += ETH_GSTRING_LEN;
 
 		snprintf(data, ETH_GSTRING_LEN, "tx%d_bytes", i);
@@ -3642,7 +3695,9 @@ static void ibmvnic_get_ethtool_stats(struct net_device *dev,
 				      (adapter, ibmvnic_stats[i].offset));
 
 	for (j = 0; j < adapter->req_tx_queues; j++) {
-		data[i] = adapter->tx_stats_buffers[j].packets;
+		data[i] = adapter->tx_stats_buffers[j].batched_packets;
+		i++;
+		data[i] = adapter->tx_stats_buffers[j].direct_packets;
 		i++;
 		data[i] = adapter->tx_stats_buffers[j].bytes;
 		i++;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index e5c6ff3d0c47..f923cdab03f5 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -213,7 +213,8 @@ struct ibmvnic_statistics {
 
 #define NUM_TX_STATS 3
 struct ibmvnic_tx_queue_stats {
-	u64 packets;
+	u64 batched_packets;
+	u64 direct_packets;
 	u64 bytes;
 	u64 dropped_packets;
 };
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 40aeaa7bd739..d2757cc11613 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -324,7 +324,7 @@ static const struct mvpp2_cls_flow cls_flows[MVPP2_N_PRS_FLOWS] = {
 		       MVPP2_PRS_RI_VLAN_MASK),
 	/* Non IP flow, with vlan tag */
 	MVPP2_DEF_FLOW(MVPP22_FLOW_ETHERNET, MVPP2_FL_NON_IP_TAG,
-		       MVPP22_CLS_HEK_OPT_VLAN,
+		       MVPP22_CLS_HEK_TAGGED,
 		       0, 0),
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index a6d3fc96e168..10b9dc2aaf06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -513,7 +513,7 @@ irq_pool_alloc(struct mlx5_core_dev *dev, int start, int size, char *name,
 	pool->min_threshold = min_threshold * MLX5_EQ_REFS_PER_IRQ;
 	pool->max_threshold = max_threshold * MLX5_EQ_REFS_PER_IRQ;
 	mlx5_core_dbg(dev, "pool->name = %s, pool->size = %d, pool->start = %d",
-		      name, size, start);
+		      name ? name : "mlx5_pcif_pool", size, start);
 	return pool;
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
index 2ec62c8d86e1..59486fe2ad18 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/cmsg.c
@@ -20,6 +20,8 @@ nfp_bpf_cmsg_alloc(struct nfp_app_bpf *bpf, unsigned int size)
 	struct sk_buff *skb;
 
 	skb = nfp_app_ctrl_msg_alloc(bpf->app, size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
 	skb_put(skb, size);
 
 	return skb;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index a95772158176..f227ed8e9934 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2159,6 +2159,7 @@ static int axienet_probe(struct platform_device *pdev)
 
 	lp->phylink_config.dev = &ndev->dev;
 	lp->phylink_config.type = PHYLINK_NETDEV;
+	lp->phylink_config.mac_managed_pm = true;
 	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 		MAC_10FD | MAC_100FD | MAC_1000FD;
 
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 27b570678c9f..3dd5c69b05cb 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1965,21 +1965,9 @@ static void geneve_destroy_tunnels(struct net *net, struct list_head *head)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_dev *geneve, *next;
-	struct net_device *dev, *aux;
 
-	/* gather any geneve devices that were moved into this ns */
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == &geneve_link_ops)
-			unregister_netdevice_queue(dev, head);
-
-	/* now gather any other geneve devices that were created in this ns */
-	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next) {
-		/* If geneve->dev is in the same netns, it was already added
-		 * to the list by the previous loop.
-		 */
-		if (!net_eq(dev_net(geneve->dev), net))
-			unregister_netdevice_queue(geneve->dev, head);
-	}
+	list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
+		geneve_dellink(geneve->dev, head);
 }
 
 static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 0de3dcd07cb7..797886f10868 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1894,11 +1894,6 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
 		struct gtp_dev *gtp, *gtp_next;
-		struct net_device *dev;
-
-		for_each_netdev(net, dev)
-			if (dev->rtnl_link_ops == &gtp_link_ops)
-				gtp_dellink(dev, dev_to_kill);
 
 		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 1d49771d07f4..eea81a733405 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -2,6 +2,9 @@
 /* Copyright (c) 2014 Mahesh Bandewar <maheshb@google.com>
  */
 
+#include <net/inet_dscp.h>
+#include <net/ip.h>
+
 #include "ipvlan.h"
 
 static u32 ipvlan_jhash_secret __read_mostly;
@@ -413,20 +416,25 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 
 static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 {
-	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net_device *dev = skb->dev;
 	struct net *net = dev_net(dev);
-	struct rtable *rt;
 	int err, ret = NET_XMIT_DROP;
+	const struct iphdr *ip4h;
+	struct rtable *rt;
 	struct flowi4 fl4 = {
 		.flowi4_oif = dev->ifindex,
-		.flowi4_tos = RT_TOS(ip4h->tos),
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
 		.flowi4_mark = skb->mark,
-		.daddr = ip4h->daddr,
-		.saddr = ip4h->saddr,
 	};
 
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		goto err;
+
+	ip4h = ip_hdr(skb);
+	fl4.daddr = ip4h->daddr;
+	fl4.saddr = ip4h->saddr;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h));
+
 	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
 		goto err;
@@ -485,6 +493,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int err, ret = NET_XMIT_DROP;
 
+	if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr))) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return ret;
+	}
+
 	err = ipvlan_route_v6_outbound(dev, skb);
 	if (unlikely(err)) {
 		DEV_STATS_INC(dev, tx_errors);
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 2e9742952c4e..b213397672d2 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -246,8 +246,22 @@ static netdev_tx_t blackhole_netdev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int blackhole_neigh_output(struct neighbour *n, struct sk_buff *skb)
+{
+	kfree_skb(skb);
+	return 0;
+}
+
+static int blackhole_neigh_construct(struct net_device *dev,
+				     struct neighbour *n)
+{
+	n->output = blackhole_neigh_output;
+	return 0;
+}
+
 static const struct net_device_ops blackhole_netdev_ops = {
 	.ndo_start_xmit = blackhole_netdev_xmit,
+	.ndo_neigh_construct = blackhole_neigh_construct,
 };
 
 /* This is a dst-dummy device used specifically for invalidated
diff --git a/drivers/net/usb/gl620a.c b/drivers/net/usb/gl620a.c
index 46af78caf457..0bfa37c14059 100644
--- a/drivers/net/usb/gl620a.c
+++ b/drivers/net/usb/gl620a.c
@@ -179,9 +179,7 @@ static int genelink_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	dev->hard_mtu = GL_RCV_BUF_SIZE;
 	dev->net->hard_header_len += 4;
-	dev->in = usb_rcvbulkpipe(dev->udev, dev->driver_info->in);
-	dev->out = usb_sndbulkpipe(dev->udev, dev->driver_info->out);
-	return 0;
+	return usbnet_get_endpoints(dev, intf);
 }
 
 static const struct driver_info	genelink_info = {
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a02873792890..acf73a91e87e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -262,8 +262,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 {
 	if (ns && nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u)"
-			"of namespace\n",
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
 			current->comm, nsid, ns->head->ns_id);
 		return false;
 	}
diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index d97a7164c496..2c73cc8dd1ed 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -299,7 +299,10 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
 
 	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
 
-	priv->phy_rst = devm_reset_control_get(dev, "phy");
+	priv->phy_rst = devm_reset_control_get_exclusive(dev, "phy");
+	/* fallback to old behaviour */
+	if (PTR_ERR(priv->phy_rst) == -ENOENT)
+		priv->phy_rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(priv->phy_rst))
 		return dev_err_probe(dev, PTR_ERR(priv->phy_rst), "failed to get phy reset\n");
 
diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index ee0848fe8432..ca6101ef6076 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -288,9 +288,9 @@ exynos5_usbdrd_pipe3_set_refclk(struct phy_usb_instance *inst)
 	reg |=	PHYCLKRST_REFCLKSEL_EXT_REFCLK;
 
 	/* FSEL settings corresponding to reference clock */
-	reg &= ~PHYCLKRST_FSEL_PIPE_MASK |
-		PHYCLKRST_MPLL_MULTIPLIER_MASK |
-		PHYCLKRST_SSC_REFCLKSEL_MASK;
+	reg &= ~(PHYCLKRST_FSEL_PIPE_MASK |
+		 PHYCLKRST_MPLL_MULTIPLIER_MASK |
+		 PHYCLKRST_SSC_REFCLKSEL_MASK);
 	switch (phy_drd->extrefclk) {
 	case EXYNOS5_FSEL_50MHZ:
 		reg |= (PHYCLKRST_MPLL_MULTIPLIER_50M_REF |
@@ -332,9 +332,9 @@ exynos5_usbdrd_utmi_set_refclk(struct phy_usb_instance *inst)
 	reg &= ~PHYCLKRST_REFCLKSEL_MASK;
 	reg |=	PHYCLKRST_REFCLKSEL_EXT_REFCLK;
 
-	reg &= ~PHYCLKRST_FSEL_UTMI_MASK |
-		PHYCLKRST_MPLL_MULTIPLIER_MASK |
-		PHYCLKRST_SSC_REFCLKSEL_MASK;
+	reg &= ~(PHYCLKRST_FSEL_UTMI_MASK |
+		 PHYCLKRST_MPLL_MULTIPLIER_MASK |
+		 PHYCLKRST_SSC_REFCLKSEL_MASK);
 	reg |= PHYCLKRST_FSEL(phy_drd->extrefclk);
 
 	return reg;
diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 0996ede63387..0556a57f3ddf 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -900,6 +900,7 @@ static int tegra186_utmi_phy_exit(struct phy *phy)
 	unsigned int index = lane->index;
 	struct device *dev = padctl->dev;
 	int err;
+	u32 reg;
 
 	port = tegra_xusb_find_usb2_port(padctl, index);
 	if (!port) {
@@ -907,6 +908,16 @@ static int tegra186_utmi_phy_exit(struct phy *phy)
 		return -ENODEV;
 	}
 
+	if (port->mode == USB_DR_MODE_OTG ||
+	    port->mode == USB_DR_MODE_PERIPHERAL) {
+		/* reset VBUS&ID OVERRIDE */
+		reg = padctl_readl(padctl, USB2_VBUS_ID);
+		reg &= ~VBUS_OVERRIDE;
+		reg &= ~ID_OVERRIDE(~0);
+		reg |= ID_OVERRIDE_FLOATING;
+		padctl_writel(padctl, reg, USB2_VBUS_ID);
+	}
+
 	if (port->supply && port->mode == USB_DR_MODE_HOST) {
 		err = regulator_disable(port->supply);
 		if (err) {
diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 8c5e2c49d6c1..9d0a6ab698f5 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -248,9 +248,9 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
 				      DA9150_QIF_SD_GAIN_SIZE);
 	da9150_fg_read_sync_end(fg);
 
-	div = (u64) (sd_gain * shunt_val * 65536ULL);
+	div = 65536ULL * sd_gain * shunt_val;
 	do_div(div, 1000000);
-	res = (u64) (iavg * 1000000ULL);
+	res = 1000000ULL * iavg;
 	do_div(res, div);
 
 	val->intval = (int) res;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5c5954b78585..8e75eb1b6eab 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -782,12 +782,18 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 				case 0x1a: /* start stop unit in progress */
 				case 0x1b: /* sanitize in progress */
 				case 0x1d: /* configuration in progress */
-				case 0x24: /* depopulation in progress */
 					action = ACTION_DELAYED_RETRY;
 					break;
 				case 0x0a: /* ALUA state transition */
 					action = ACTION_DELAYED_REPREP;
 					break;
+				/*
+				 * Depopulation might take many hours,
+				 * thus it is not worthwhile to retry.
+				 */
+				case 0x24: /* depopulation in progress */
+				case 0x25: /* depopulation restore in progress */
+					fallthrough;
 				default:
 					action = ACTION_FAIL;
 					break;
@@ -1573,13 +1579,6 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 	if (in_flight)
 		__set_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 
-	/*
-	 * Only clear the driver-private command data if the LLD does not supply
-	 * a function to initialize that data.
-	 */
-	if (!shost->hostt->init_cmd_priv)
-		memset(cmd + 1, 0, shost->hostt->cmd_size);
-
 	cmd->prot_op = SCSI_PROT_NORMAL;
 	if (blk_rq_bytes(req))
 		cmd->sc_data_direction = rq_dma_dir(req);
@@ -1741,6 +1740,13 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!scsi_host_queue_ready(q, shost, sdev, cmd))
 		goto out_dec_target_busy;
 
+	/*
+	 * Only clear the driver-private command data if the LLD does not supply
+	 * a function to initialize that data.
+	 */
+	if (shost->hostt->cmd_size && !shost->hostt->init_cmd_priv)
+		memset(cmd + 1, 0, shost->hostt->cmd_size);
+
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		ret = scsi_prepare_cmd(req);
 		if (ret != BLK_STS_OK)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b35ef52d9c63..c3006524eb03 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2191,6 +2191,10 @@ sd_spinup_disk(struct scsi_disk *sdkp)
 				break;	/* unavailable */
 			if (sshdr.asc == 4 && sshdr.ascq == 0x1b)
 				break;	/* sanitize in progress */
+			if (sshdr.asc == 4 && sshdr.ascq == 0x24)
+				break;	/* depopulation in progress */
+			if (sshdr.asc == 4 && sshdr.ascq == 0x25)
+				break;	/* depopulation restoration in progress */
 			/*
 			 * Issue command to spin up drive when not ready
 			 */
diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index fc13334db1b1..7269ab8d29b6 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -273,44 +273,44 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	devapc_irq = irq_of_parse_and_map(node, 0);
-	if (!devapc_irq)
-		return -EINVAL;
-
-	ctx->infra_clk = devm_clk_get(&pdev->dev, "devapc-infra-clock");
-	if (IS_ERR(ctx->infra_clk))
-		return -EINVAL;
+	if (!devapc_irq) {
+		ret = -EINVAL;
+		goto err;
+	}
 
-	if (clk_prepare_enable(ctx->infra_clk))
-		return -EINVAL;
+	ctx->infra_clk = devm_clk_get_enabled(&pdev->dev, "devapc-infra-clock");
+	if (IS_ERR(ctx->infra_clk)) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = devm_request_irq(&pdev->dev, devapc_irq, devapc_violation_irq,
 			       IRQF_TRIGGER_NONE, "devapc", ctx);
-	if (ret) {
-		clk_disable_unprepare(ctx->infra_clk);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	platform_set_drvdata(pdev, ctx);
 
 	start_devapc(ctx);
 
 	return 0;
+
+err:
+	iounmap(ctx->infra_base);
+	return ret;
 }
 
-static int mtk_devapc_remove(struct platform_device *pdev)
+static void mtk_devapc_remove(struct platform_device *pdev)
 {
 	struct mtk_devapc_context *ctx = platform_get_drvdata(pdev);
 
 	stop_devapc(ctx);
-
-	clk_disable_unprepare(ctx->infra_clk);
-
-	return 0;
+	iounmap(ctx->infra_base);
 }
 
 static struct platform_driver mtk_devapc_driver = {
 	.probe = mtk_devapc_probe,
-	.remove = mtk_devapc_remove,
+	.remove_new = mtk_devapc_remove,
 	.driver = {
 		.name = "mtk-devapc",
 		.of_match_table = mtk_devapc_dt_match,
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index b5afe5790b1d..8540fcdf3b42 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -138,11 +138,15 @@
 #define QSPI_WPSR_WPVSRC_MASK           GENMASK(15, 8)
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
 
+#define ATMEL_QSPI_TIMEOUT		1000	/* ms */
+
 struct atmel_qspi_caps {
 	bool has_qspick;
 	bool has_ricr;
 };
 
+struct atmel_qspi_ops;
+
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
@@ -150,13 +154,22 @@ struct atmel_qspi {
 	struct clk		*qspick;
 	struct platform_device	*pdev;
 	const struct atmel_qspi_caps *caps;
+	const struct atmel_qspi_ops *ops;
 	resource_size_t		mmap_size;
 	u32			pending;
+	u32			irq_mask;
 	u32			mr;
 	u32			scr;
 	struct completion	cmd_completion;
 };
 
+struct atmel_qspi_ops {
+	int (*set_cfg)(struct atmel_qspi *aq, const struct spi_mem_op *op,
+		       u32 *offset);
+	int (*transfer)(struct spi_mem *mem, const struct spi_mem_op *op,
+			u32 offset);
+};
+
 struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -375,9 +388,9 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	 * If the QSPI controller is set in regular SPI mode, set it in
 	 * Serial Memory Mode (SMM).
 	 */
-	if (aq->mr != QSPI_MR_SMM) {
-		atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
-		aq->mr = QSPI_MR_SMM;
+	if (!(aq->mr & QSPI_MR_SMM)) {
+		aq->mr |= QSPI_MR_SMM;
+		atmel_qspi_write(aq->mr, aq, QSPI_MR);
 	}
 
 	/* Clear pending interrupts */
@@ -404,10 +417,67 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	return 0;
 }
 
+static int atmel_qspi_wait_for_completion(struct atmel_qspi *aq, u32 irq_mask)
+{
+	int err = 0;
+	u32 sr;
+
+	/* Poll INSTRuction End status */
+	sr = atmel_qspi_read(aq, QSPI_SR);
+	if ((sr & irq_mask) == irq_mask)
+		return 0;
+
+	/* Wait for INSTRuction End interrupt */
+	reinit_completion(&aq->cmd_completion);
+	aq->pending = sr & irq_mask;
+	aq->irq_mask = irq_mask;
+	atmel_qspi_write(irq_mask, aq, QSPI_IER);
+	if (!wait_for_completion_timeout(&aq->cmd_completion,
+					 msecs_to_jiffies(ATMEL_QSPI_TIMEOUT)))
+		err = -ETIMEDOUT;
+	atmel_qspi_write(irq_mask, aq, QSPI_IDR);
+
+	return err;
+}
+
+static int atmel_qspi_transfer(struct spi_mem *mem,
+			       const struct spi_mem_op *op, u32 offset)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->controller);
+
+	/* Skip to the final steps if there is no data */
+	if (!op->data.nbytes)
+		return atmel_qspi_wait_for_completion(aq,
+						      QSPI_SR_CMD_COMPLETED);
+
+	/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
+	(void)atmel_qspi_read(aq, QSPI_IFR);
+
+	/* Send/Receive data */
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		memcpy_fromio(op->data.buf.in, aq->mem + offset,
+			      op->data.nbytes);
+
+		/* Synchronize AHB and APB accesses again */
+		rmb();
+	} else {
+		memcpy_toio(aq->mem + offset, op->data.buf.out,
+			    op->data.nbytes);
+
+		/* Synchronize AHB and APB accesses again */
+		wmb();
+	}
+
+	/* Release the chip-select */
+	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
+
+	return atmel_qspi_wait_for_completion(aq, QSPI_SR_CMD_COMPLETED);
+}
+
 static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
-	u32 sr, offset;
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->controller);
+	u32 offset;
 	int err;
 
 	/*
@@ -416,46 +486,20 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 * when the flash memories overrun the controller's memory space.
 	 */
 	if (op->addr.val + op->data.nbytes > aq->mmap_size)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
+
+	if (op->addr.nbytes > 4)
+		return -EOPNOTSUPP;
 
 	err = pm_runtime_resume_and_get(&aq->pdev->dev);
 	if (err < 0)
 		return err;
 
-	err = atmel_qspi_set_cfg(aq, op, &offset);
+	err = aq->ops->set_cfg(aq, op, &offset);
 	if (err)
 		goto pm_runtime_put;
 
-	/* Skip to the final steps if there is no data */
-	if (op->data.nbytes) {
-		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)atmel_qspi_read(aq, QSPI_IFR);
-
-		/* Send/Receive data */
-		if (op->data.dir == SPI_MEM_DATA_IN)
-			memcpy_fromio(op->data.buf.in, aq->mem + offset,
-				      op->data.nbytes);
-		else
-			memcpy_toio(aq->mem + offset, op->data.buf.out,
-				    op->data.nbytes);
-
-		/* Release the chip-select */
-		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
-	}
-
-	/* Poll INSTRuction End status */
-	sr = atmel_qspi_read(aq, QSPI_SR);
-	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
-		goto pm_runtime_put;
-
-	/* Wait for INSTRuction End interrupt */
-	reinit_completion(&aq->cmd_completion);
-	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
-	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IER);
-	if (!wait_for_completion_timeout(&aq->cmd_completion,
-					 msecs_to_jiffies(1000)))
-		err = -ETIMEDOUT;
-	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IDR);
+	err = aq->ops->transfer(mem, op, offset);
 
 pm_runtime_put:
 	pm_runtime_mark_last_busy(&aq->pdev->dev);
@@ -476,7 +520,7 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
 
 static int atmel_qspi_setup(struct spi_device *spi)
 {
-	struct spi_controller *ctrl = spi->master;
+	struct spi_controller *ctrl = spi->controller;
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	unsigned long src_rate;
 	u32 scbr;
@@ -501,7 +545,42 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	aq->scr = QSPI_SCR_SCBR(scbr);
+	aq->scr &= ~QSPI_SCR_SCBR_MASK;
+	aq->scr |= QSPI_SCR_SCBR(scbr);
+	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
+
+	pm_runtime_mark_last_busy(ctrl->dev.parent);
+	pm_runtime_put_autosuspend(ctrl->dev.parent);
+
+	return 0;
+}
+
+static int atmel_qspi_set_cs_timing(struct spi_device *spi)
+{
+	struct spi_controller *ctrl = spi->controller;
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	unsigned long clk_rate;
+	u32 cs_setup;
+	int delay;
+	int ret;
+
+	delay = spi_delay_to_ns(&spi->cs_setup, NULL);
+	if (delay <= 0)
+		return delay;
+
+	clk_rate = clk_get_rate(aq->pclk);
+	if (!clk_rate)
+		return -EINVAL;
+
+	cs_setup = DIV_ROUND_UP((delay * DIV_ROUND_UP(clk_rate, 1000000)),
+				1000);
+
+	ret = pm_runtime_resume_and_get(ctrl->dev.parent);
+	if (ret < 0)
+		return ret;
+
+	aq->scr &= ~QSPI_SCR_DLYBS_MASK;
+	aq->scr |= QSPI_SCR_DLYBS(cs_setup);
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
 	pm_runtime_mark_last_busy(ctrl->dev.parent);
@@ -516,8 +595,8 @@ static void atmel_qspi_init(struct atmel_qspi *aq)
 	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
-	aq->mr = QSPI_MR_SMM;
+	aq->mr |= QSPI_MR_SMM;
+	atmel_qspi_write(aq->mr, aq, QSPI_MR);
 
 	/* Enable the QSPI controller */
 	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
@@ -536,12 +615,17 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	aq->pending |= pending;
-	if ((aq->pending & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
+	if ((aq->pending & aq->irq_mask) == aq->irq_mask)
 		complete(&aq->cmd_completion);
 
 	return IRQ_HANDLED;
 }
 
+static const struct atmel_qspi_ops atmel_qspi_ops = {
+	.set_cfg = atmel_qspi_set_cfg,
+	.transfer = atmel_qspi_transfer,
+};
+
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
@@ -549,12 +633,13 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq, err = 0;
 
-	ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(*aq));
+	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*aq));
 	if (!ctrl)
 		return -ENOMEM;
 
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
 	ctrl->setup = atmel_qspi_setup;
+	ctrl->set_cs_timing = atmel_qspi_set_cs_timing;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &atmel_qspi_mem_ops;
 	ctrl->num_chipselect = 1;
@@ -565,6 +650,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	init_completion(&aq->cmd_completion);
 	aq->pdev = pdev;
+	aq->ops = &atmel_qspi_ops;
 
 	/* Map the registers */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..d0f397c90242 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -80,7 +80,6 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req;
-	bool interruptable;
 	u32 ret;
 
 	/*
@@ -111,36 +110,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	/*
 	 * Wait for supplicant to process and return result, once we've
 	 * returned from wait_for_completion(&req->c) successfully we have
-	 * exclusive access again.
+	 * exclusive access again. Allow the wait to be killable such that
+	 * the wait doesn't turn into an indefinite state if the supplicant
+	 * gets hung for some reason.
 	 */
-	while (wait_for_completion_interruptible(&req->c)) {
+	if (wait_for_completion_killable(&req->c)) {
 		mutex_lock(&supp->mutex);
-		interruptable = !supp->ctx;
-		if (interruptable) {
-			/*
-			 * There's no supplicant available and since the
-			 * supp->mutex currently is held none can
-			 * become available until the mutex released
-			 * again.
-			 *
-			 * Interrupting an RPC to supplicant is only
-			 * allowed as a way of slightly improving the user
-			 * experience in case the supplicant hasn't been
-			 * started yet. During normal operation the supplicant
-			 * will serve all requests in a timely manner and
-			 * interrupting then wouldn't make sense.
-			 */
-			if (req->in_queue) {
-				list_del(&req->link);
-				req->in_queue = false;
-			}
+		if (req->in_queue) {
+			list_del(&req->link);
+			req->in_queue = false;
 		}
 		mutex_unlock(&supp->mutex);
-
-		if (interruptable) {
-			req->ret = TEEC_ERROR_COMMUNICATION;
-			break;
-		}
+		req->ret = TEEC_ERROR_COMMUNICATION;
 	}
 
 	ret = req->ret;
diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 1d8521103b66..dd1cfeeffb67 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -282,7 +282,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
 			/* Our transmit completed. See if there's more to go.
 			 * f_midi_transmit eats req, don't queue it again. */
 			req->length = 0;
-			f_midi_transmit(midi);
+			queue_work(system_highpri_wq, &midi->work);
 			return;
 		}
 		break;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 6d7f8e98ba2a..5adb6e831126 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1419,8 +1419,16 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	if (ret)
 		goto err_free_id;
 
+	ret = sysfs_create_link(&udc->dev.kobj,
+				&gadget->dev.kobj, "gadget");
+	if (ret)
+		goto err_del_gadget;
+
 	return 0;
 
+ err_del_gadget:
+	device_del(&gadget->dev);
+
  err_free_id:
 	ida_free(&gadget_id_numbers, gadget->id_number);
 
@@ -1529,8 +1537,9 @@ void usb_del_gadget(struct usb_gadget *gadget)
 	mutex_unlock(&udc_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
-	flush_work(&gadget->work);
+	sysfs_remove_link(&udc->dev.kobj, "gadget");
 	device_del(&gadget->dev);
+	flush_work(&gadget->work);
 	ida_free(&gadget_id_numbers, gadget->id_number);
 	cancel_work_sync(&udc->vbus_work);
 	device_unregister(&udc->dev);
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 926cb1188eba..7c0dce8eecad 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -161,6 +161,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	refcount_set(&cell->ref, 1);
 	atomic_set(&cell->active, 0);
 	INIT_WORK(&cell->manager, afs_manage_cell_work);
+	spin_lock_init(&cell->vs_lock);
 	cell->volumes = RB_ROOT;
 	INIT_HLIST_HEAD(&cell->proc_volumes);
 	seqlock_init(&cell->volume_lock);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 097d5a5f07b1..fd4310272ccc 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -378,6 +378,7 @@ struct afs_cell {
 	unsigned int		debug_id;
 
 	/* The volumes belonging to this cell */
+	spinlock_t		vs_lock;	/* Lock for server->volumes */
 	struct rb_root		volumes;	/* Tree of volumes on this server */
 	struct hlist_head	proc_volumes;	/* procfs volume list */
 	seqlock_t		volume_lock;	/* For volumes */
@@ -501,6 +502,7 @@ struct afs_server {
 	struct hlist_node	addr4_link;	/* Link in net->fs_addresses4 */
 	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
+	struct list_head	volumes;	/* RCU list of afs_server_entry objects */
 	struct work_struct	initcb_work;	/* Work for CB.InitCallBackState* */
 	struct afs_server	*gc_next;	/* Next server in manager's list */
 	time64_t		unuse_time;	/* Time at which last unused */
@@ -549,12 +551,14 @@ struct afs_server {
  */
 struct afs_server_entry {
 	struct afs_server	*server;
+	struct afs_volume	*volume;
+	struct list_head	slink;		/* Link in server->volumes */
 };
 
 struct afs_server_list {
 	struct rcu_head		rcu;
-	afs_volid_t		vids[AFS_MAXTYPES]; /* Volume IDs */
 	refcount_t		usage;
+	bool			attached;	/* T if attached to servers */
 	unsigned char		nr_servers;
 	unsigned char		preferred;	/* Preferred server */
 	unsigned short		vnovol_mask;	/* Servers to be skipped due to VNOVOL */
@@ -567,10 +571,9 @@ struct afs_server_list {
  * Live AFS volume management.
  */
 struct afs_volume {
-	union {
-		struct rcu_head	rcu;
-		afs_volid_t	vid;		/* volume ID */
-	};
+	struct rcu_head	rcu;
+	afs_volid_t		vid;		/* The volume ID of this volume */
+	afs_volid_t		vids[AFS_MAXTYPES]; /* All associated volume IDs */
 	refcount_t		ref;
 	time64_t		update_at;	/* Time at which to next update */
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
@@ -1450,10 +1453,14 @@ static inline struct afs_server_list *afs_get_serverlist(struct afs_server_list
 }
 
 extern void afs_put_serverlist(struct afs_net *, struct afs_server_list *);
-extern struct afs_server_list *afs_alloc_server_list(struct afs_cell *, struct key *,
-						     struct afs_vldb_entry *,
-						     u8);
+struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
+					      struct key *key,
+					      struct afs_vldb_entry *vldb);
 extern bool afs_annotate_server_list(struct afs_server_list *, struct afs_server_list *);
+void afs_attach_volume_to_servers(struct afs_volume *volume, struct afs_server_list *slist);
+void afs_reattach_volume_to_servers(struct afs_volume *volume, struct afs_server_list *slist,
+				    struct afs_server_list *old);
+void afs_detach_volume_from_servers(struct afs_volume *volume, struct afs_server_list *slist);
 
 /*
  * super.c
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 0bd2f5ba6900..87381c2ffe37 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -236,6 +236,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	server->addr_version = alist->version;
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
+	INIT_LIST_HEAD(&server->volumes);
 	INIT_WORK(&server->initcb_work, afs_server_init_callback_work);
 	init_waitqueue_head(&server->probe_wq);
 	INIT_LIST_HEAD(&server->probe_link);
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index b59896b1de0a..89c75d934f79 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -24,13 +24,13 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 /*
  * Build a server list from a VLDB record.
  */
-struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
+struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 					      struct key *key,
-					      struct afs_vldb_entry *vldb,
-					      u8 type_mask)
+					      struct afs_vldb_entry *vldb)
 {
 	struct afs_server_list *slist;
 	struct afs_server *server;
+	unsigned int type_mask = 1 << volume->type;
 	int ret = -ENOMEM, nr_servers = 0, i, j;
 
 	for (i = 0; i < vldb->nr_servers; i++)
@@ -44,15 +44,12 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 	refcount_set(&slist->usage, 1);
 	rwlock_init(&slist->lock);
 
-	for (i = 0; i < AFS_MAXTYPES; i++)
-		slist->vids[i] = vldb->vid[i];
-
 	/* Make sure a records exists for each server in the list. */
 	for (i = 0; i < vldb->nr_servers; i++) {
 		if (!(vldb->fs_mask[i] & type_mask))
 			continue;
 
-		server = afs_lookup_server(cell, key, &vldb->fs_server[i],
+		server = afs_lookup_server(volume->cell, key, &vldb->fs_server[i],
 					   vldb->addr_version[i]);
 		if (IS_ERR(server)) {
 			ret = PTR_ERR(server);
@@ -70,8 +67,8 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 				break;
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {
-				afs_put_server(cell->net, server,
-					       afs_server_trace_put_slist_isort);
+				afs_unuse_server(volume->cell->net, server,
+						 afs_server_trace_put_slist_isort);
 				continue;
 			}
 
@@ -81,6 +78,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 		}
 
 		slist->servers[j].server = server;
+		slist->servers[j].volume = volume;
 		slist->nr_servers++;
 	}
 
@@ -92,7 +90,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 	return slist;
 
 error_2:
-	afs_put_serverlist(cell->net, slist);
+	afs_put_serverlist(volume->cell->net, slist);
 error:
 	return ERR_PTR(ret);
 }
@@ -127,3 +125,99 @@ bool afs_annotate_server_list(struct afs_server_list *new,
 
 	return true;
 }
+
+/*
+ * Attach a volume to the servers it is going to use.
+ */
+void afs_attach_volume_to_servers(struct afs_volume *volume, struct afs_server_list *slist)
+{
+	struct afs_server_entry *se, *pe;
+	struct afs_server *server;
+	struct list_head *p;
+	unsigned int i;
+
+	spin_lock(&volume->cell->vs_lock);
+
+	for (i = 0; i < slist->nr_servers; i++) {
+		se = &slist->servers[i];
+		server = se->server;
+
+		list_for_each(p, &server->volumes) {
+			pe = list_entry(p, struct afs_server_entry, slink);
+			if (volume->vid <= pe->volume->vid)
+				break;
+		}
+		list_add_tail_rcu(&se->slink, p);
+	}
+
+	slist->attached = true;
+	spin_unlock(&volume->cell->vs_lock);
+}
+
+/*
+ * Reattach a volume to the servers it is going to use when server list is
+ * replaced.  We try to switch the attachment points to avoid rewalking the
+ * lists.
+ */
+void afs_reattach_volume_to_servers(struct afs_volume *volume, struct afs_server_list *new,
+				    struct afs_server_list *old)
+{
+	unsigned int n = 0, o = 0;
+
+	spin_lock(&volume->cell->vs_lock);
+
+	while (n < new->nr_servers || o < old->nr_servers) {
+		struct afs_server_entry *pn = n < new->nr_servers ? &new->servers[n] : NULL;
+		struct afs_server_entry *po = o < old->nr_servers ? &old->servers[o] : NULL;
+		struct afs_server_entry *s;
+		struct list_head *p;
+		int diff;
+
+		if (pn && po && pn->server == po->server) {
+			list_replace_rcu(&po->slink, &pn->slink);
+			n++;
+			o++;
+			continue;
+		}
+
+		if (pn && po)
+			diff = memcmp(&pn->server->uuid, &po->server->uuid,
+				      sizeof(pn->server->uuid));
+		else
+			diff = pn ? -1 : 1;
+
+		if (diff < 0) {
+			list_for_each(p, &pn->server->volumes) {
+				s = list_entry(p, struct afs_server_entry, slink);
+				if (volume->vid <= s->volume->vid)
+					break;
+			}
+			list_add_tail_rcu(&pn->slink, p);
+			n++;
+		} else {
+			list_del_rcu(&po->slink);
+			o++;
+		}
+	}
+
+	spin_unlock(&volume->cell->vs_lock);
+}
+
+/*
+ * Detach a volume from the servers it has been using.
+ */
+void afs_detach_volume_from_servers(struct afs_volume *volume, struct afs_server_list *slist)
+{
+	unsigned int i;
+
+	if (!slist->attached)
+		return;
+
+	spin_lock(&volume->cell->vs_lock);
+
+	for (i = 0; i < slist->nr_servers; i++)
+		list_del_rcu(&slist->servers[i].slink);
+
+	slist->attached = false;
+	spin_unlock(&volume->cell->vs_lock);
+}
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 83cf1bfbe343..b2cc10df9530 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -126,7 +126,7 @@ static int afs_compare_volume_slists(const struct afs_volume *vol_a,
 	lb = rcu_dereference(vol_b->servers);
 
 	for (i = 0; i < AFS_MAXTYPES; i++)
-		if (la->vids[i] != lb->vids[i])
+		if (vol_a->vids[i] != vol_b->vids[i])
 			return 0;
 
 	while (a < la->nr_servers && b < lb->nr_servers) {
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index a146d70efa65..0f64b9758127 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -72,15 +72,11 @@ static void afs_remove_volume_from_cell(struct afs_volume *volume)
  */
 static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 					   struct afs_vldb_entry *vldb,
-					   unsigned long type_mask)
+					   struct afs_server_list **_slist)
 {
 	struct afs_server_list *slist;
 	struct afs_volume *volume;
-	int ret = -ENOMEM, nr_servers = 0, i;
-
-	for (i = 0; i < vldb->nr_servers; i++)
-		if (vldb->fs_mask[i] & type_mask)
-			nr_servers++;
+	int ret = -ENOMEM, i;
 
 	volume = kzalloc(sizeof(struct afs_volume), GFP_KERNEL);
 	if (!volume)
@@ -99,13 +95,16 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	rwlock_init(&volume->cb_v_break_lock);
 	memcpy(volume->name, vldb->name, vldb->name_len + 1);
 
-	slist = afs_alloc_server_list(params->cell, params->key, vldb, type_mask);
+	for (i = 0; i < AFS_MAXTYPES; i++)
+		volume->vids[i] = vldb->vid[i];
+
+	slist = afs_alloc_server_list(volume, params->key, vldb);
 	if (IS_ERR(slist)) {
 		ret = PTR_ERR(slist);
 		goto error_1;
 	}
 
-	refcount_set(&slist->usage, 1);
+	*_slist = slist;
 	rcu_assign_pointer(volume->servers, slist);
 	trace_afs_volume(volume->vid, 1, afs_volume_trace_alloc);
 	return volume;
@@ -121,17 +120,19 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
  * Look up or allocate a volume record.
  */
 static struct afs_volume *afs_lookup_volume(struct afs_fs_context *params,
-					    struct afs_vldb_entry *vldb,
-					    unsigned long type_mask)
+					    struct afs_vldb_entry *vldb)
 {
+	struct afs_server_list *slist;
 	struct afs_volume *candidate, *volume;
 
-	candidate = afs_alloc_volume(params, vldb, type_mask);
+	candidate = afs_alloc_volume(params, vldb, &slist);
 	if (IS_ERR(candidate))
 		return candidate;
 
 	volume = afs_insert_volume_into_cell(params->cell, candidate);
-	if (volume != candidate)
+	if (volume == candidate)
+		afs_attach_volume_to_servers(volume, slist);
+	else
 		afs_put_volume(params->net, candidate, afs_volume_trace_put_cell_dup);
 	return volume;
 }
@@ -212,8 +213,7 @@ struct afs_volume *afs_create_volume(struct afs_fs_context *params)
 		goto error;
 	}
 
-	type_mask = 1UL << params->type;
-	volume = afs_lookup_volume(params, vldb, type_mask);
+	volume = afs_lookup_volume(params, vldb);
 
 error:
 	kfree(vldb);
@@ -225,14 +225,17 @@ struct afs_volume *afs_create_volume(struct afs_fs_context *params)
  */
 static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
 {
+	struct afs_server_list *slist = rcu_access_pointer(volume->servers);
+
 	_enter("%p", volume);
 
 #ifdef CONFIG_AFS_FSCACHE
 	ASSERTCMP(volume->cache, ==, NULL);
 #endif
 
+	afs_detach_volume_from_servers(volume, slist);
 	afs_remove_volume_from_cell(volume);
-	afs_put_serverlist(net, rcu_access_pointer(volume->servers));
+	afs_put_serverlist(net, slist);
 	afs_put_cell(volume->cell, afs_cell_trace_put_vol);
 	trace_afs_volume(volume->vid, refcount_read(&volume->ref),
 			 afs_volume_trace_free);
@@ -366,8 +369,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	}
 
 	/* See if the volume's server list got updated. */
-	new = afs_alloc_server_list(volume->cell, key,
-				    vldb, (1 << volume->type));
+	new = afs_alloc_server_list(volume, key, vldb);
 	if (IS_ERR(new)) {
 		ret = PTR_ERR(new);
 		goto error_vldb;
@@ -388,9 +390,11 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 
 	volume->update_at = ktime_get_real_seconds() + afs_volume_record_life;
 	write_unlock(&volume->servers_lock);
-	ret = 0;
 
+	if (discard == old)
+		afs_reattach_volume_to_servers(volume, new, old);
 	afs_put_serverlist(volume->cell->net, discard);
+	ret = 0;
 error_vldb:
 	kfree(vldb);
 error:
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 86d4b6975dbc..203b88293f6b 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -532,7 +532,6 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, ovl_dentry_upper(c->dentry), udir, upper);
-		dput(upper);
 
 		if (!err) {
 			/* Restore timestamps on parent (best effort) */
@@ -540,6 +539,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 			ovl_dentry_set_upper_alias(c->dentry);
 			ovl_dentry_update_reval(c->dentry, upper);
 		}
+		dput(upper);
 	}
 	inode_unlock(udir);
 	if (err)
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 5af8bf391d87..a62f3e5a7689 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5158,6 +5158,10 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			next_buffer = (char *)cifs_buf_get();
 		else
 			next_buffer = (char *)cifs_small_buf_get();
+		if (!next_buffer) {
+			cifs_server_dbg(VFS, "No memory for (large) SMB response\n");
+			return -1;
+		}
 		memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd);
 	}
 
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index f31649080a88..95a9ff9e2399 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -48,6 +48,10 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	gid_t i_gid;
 	int err;
 
+	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
+	if (inode->i_ino == 0)
+		return -EINVAL;
+
 	err = squashfs_get_id(sb, le16_to_cpu(sqsh_ino->uid), &i_uid);
 	if (err)
 		return err;
@@ -58,7 +62,6 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 
 	i_uid_write(inode, i_uid);
 	i_gid_write(inode, i_gid);
-	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
 	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
 	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
 	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e7539dc02498..20219e1301da 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -461,7 +461,7 @@
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
-		*(.rodata) *(.rodata.*)					\
+		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 971186f0b7b0..03357c196e0b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1610,6 +1610,28 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 	return page_maybe_dma_pinned(page);
 }
 
+/**
+ * is_zero_page - Query if a page is a zero page
+ * @page: The page to query
+ *
+ * This returns true if @page is one of the permanent zero pages.
+ */
+static inline bool is_zero_page(const struct page *page)
+{
+	return is_zero_pfn(page_to_pfn(page));
+}
+
+/**
+ * is_zero_folio - Query if a folio is a zero page
+ * @folio: The folio to query
+ *
+ * This returns true if @folio is one of the permanent zero pages.
+ */
+static inline bool is_zero_folio(const struct folio *folio)
+{
+	return is_zero_page(&folio->page);
+}
+
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 #ifdef CONFIG_MIGRATION
 static inline bool is_longterm_pinnable_page(struct page *page)
@@ -1620,8 +1642,8 @@ static inline bool is_longterm_pinnable_page(struct page *page)
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
-	/* The zero page may always be pinned */
-	if (is_zero_pfn(page_to_pfn(page)))
+	/* The zero page can be "pinned" but gets special handling. */
+	if (is_zero_page(page))
 		return true;
 
 	/* Coherent device memory must always allow eviction. */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d0b4920dee73..f44701b82ea8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3011,6 +3011,8 @@ static inline struct net_device *first_net_device_rcu(struct net *net)
 }
 
 int netdev_boot_setup_check(struct net_device *dev);
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *hwaddr);
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *hwaddr);
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type);
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index c952c5ba8fab..135a3d9140a0 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -402,6 +402,10 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define current_user_stack_pointer() user_stack_pointer(current_pt_regs())
 #endif
 
+#ifndef exception_ip
+#define exception_ip(x) instruction_pointer(x)
+#endif
+
 extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 6ccfd9236387..32bbebf5b71e 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -87,6 +87,8 @@ struct sk_psock {
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	struct strparser		strp;
+	u32				copied_seq;
+	u32				ingress_bytes;
 #endif
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 8f9bee0e21c3..a220b28904ca 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -140,13 +140,14 @@ struct rpc_task_setup {
 #define RPC_WAS_SENT(t)		((t)->tk_flags & RPC_TASK_SENT)
 #define RPC_IS_MOVEABLE(t)	((t)->tk_flags & RPC_TASK_MOVEABLE)
 
-#define RPC_TASK_RUNNING	0
-#define RPC_TASK_QUEUED		1
-#define RPC_TASK_ACTIVE		2
-#define RPC_TASK_NEED_XMIT	3
-#define RPC_TASK_NEED_RECV	4
-#define RPC_TASK_MSG_PIN_WAIT	5
-#define RPC_TASK_SIGNALLED	6
+enum {
+	RPC_TASK_RUNNING,
+	RPC_TASK_QUEUED,
+	RPC_TASK_ACTIVE,
+	RPC_TASK_NEED_XMIT,
+	RPC_TASK_NEED_RECV,
+	RPC_TASK_MSG_PIN_WAIT,
+};
 
 #define rpc_test_and_set_running(t) \
 				test_and_set_bit(RPC_TASK_RUNNING, &(t)->tk_runstate)
@@ -158,7 +159,7 @@ struct rpc_task_setup {
 
 #define RPC_IS_ACTIVATED(t)	test_bit(RPC_TASK_ACTIVE, &(t)->tk_runstate)
 
-#define RPC_SIGNALLED(t)	test_bit(RPC_TASK_SIGNALLED, &(t)->tk_runstate)
+#define RPC_SIGNALLED(t)	(READ_ONCE(task->tk_rpc_status) == -ERESTARTSYS)
 
 /*
  * Task priorities.
diff --git a/include/net/dst.h b/include/net/dst.h
index d67fda89cd0f..3a1a6f94a809 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -434,6 +434,15 @@ static inline void dst_set_expires(struct dst_entry *dst, int timeout)
 		dst->expires = expires;
 }
 
+static inline unsigned int dst_dev_overhead(struct dst_entry *dst,
+					    struct sk_buff *skb)
+{
+	if (likely(dst))
+		return LL_RESERVED_SPACE(dst->dev);
+
+	return skb->mac_len;
+}
+
 INDIRECT_CALLABLE_DECLARE(int ip6_output(struct net *, struct sock *,
 					 struct sk_buff *));
 INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
diff --git a/include/net/ip.h b/include/net/ip.h
index 9d754c4a5300..4ee23eb0814a 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -409,6 +409,11 @@ int ip_decrease_ttl(struct iphdr *iph)
 	return --iph->ttl;
 }
 
+static inline dscp_t ip4h_dscp(const struct iphdr *ip4h)
+{
+	return inet_dsfield_to_dscp(ip4h->tos);
+}
+
 static inline int ip_mtu_locked(const struct dst_entry *dst)
 {
 	const struct rtable *rt = (const struct rtable *)dst;
diff --git a/include/net/netfilter/nf_conntrack_expect.h b/include/net/netfilter/nf_conntrack_expect.h
index 0855b60fba17..f642a87ea330 100644
--- a/include/net/netfilter/nf_conntrack_expect.h
+++ b/include/net/netfilter/nf_conntrack_expect.h
@@ -100,7 +100,7 @@ nf_ct_expect_find_get(struct net *net,
 struct nf_conntrack_expect *
 nf_ct_find_expectation(struct net *net,
 		       const struct nf_conntrack_zone *zone,
-		       const struct nf_conntrack_tuple *tuple);
+		       const struct nf_conntrack_tuple *tuple, bool unlink);
 
 void nf_ct_unlink_expect_report(struct nf_conntrack_expect *exp,
 				u32 portid, int report);
diff --git a/include/net/route.h b/include/net/route.h
index f39617602237..4185e6da9ef8 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -203,12 +203,13 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
 		      const struct sk_buff *hint);
 
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
-				 u8 tos, struct net_device *devin)
+				 dscp_t dscp, struct net_device *devin)
 {
 	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_noref(skb, dst, src, tos, devin);
+	err = ip_route_input_noref(skb, dst, src, inet_dscp_to_dsfield(dscp),
+				   devin);
 	if (!err) {
 		skb_dst_force(skb);
 		if (!skb_dst(skb))
diff --git a/include/net/strparser.h b/include/net/strparser.h
index 41e2ce9e9e10..0a83010b3a64 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -43,6 +43,8 @@ struct strparser;
 struct strp_callbacks {
 	int (*parse_msg)(struct strparser *strp, struct sk_buff *skb);
 	void (*rcv_msg)(struct strparser *strp, struct sk_buff *skb);
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
 	int (*read_sock_done)(struct strparser *strp, int err);
 	void (*abort_parser)(struct strparser *strp, int err);
 	void (*lock)(struct strparser *strp);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index a770210fda9b..83e0362e3b72 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -40,6 +40,7 @@
 #include <net/inet_ecn.h>
 #include <net/dst.h>
 #include <net/mptcp.h>
+#include <net/xfrm.h>
 
 #include <linux/seq_file.h>
 #include <linux/memcontrol.h>
@@ -640,6 +641,19 @@ void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
 void tcp_sack_compress_send_ack(struct sock *sk);
 
+static inline void tcp_cleanup_skb(struct sk_buff *skb)
+{
+	skb_dst_drop(skb);
+	secpath_reset(skb);
+}
+
+static inline void tcp_add_receive_queue(struct sock *sk, struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+	DEBUG_NET_WARN_ON_ONCE(secpath_exists(skb));
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+}
+
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
 static inline void tcp_clear_xmit_timers(struct sock *sk)
@@ -686,6 +700,9 @@ void tcp_get_info(struct sock *, struct tcp_info *);
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		  sk_read_actor_t recv_actor);
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq);
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off);
 void tcp_read_done(struct sock *sk, size_t len);
@@ -2337,6 +2354,11 @@ struct sk_psock;
 struct proto *tcp_bpf_get_proto(struct sock *sk, struct sk_psock *psock);
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
+#ifdef CONFIG_BPF_STREAM_PARSER
+struct strparser;
+int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor);
+#endif /* CONFIG_BPF_STREAM_PARSER */
 #endif /* CONFIG_BPF_SYSCALL */
 
 #ifdef CONFIG_INET
diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
new file mode 100644
index 000000000000..31559796949a
--- /dev/null
+++ b/include/trace/events/icmp.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM icmp
+
+#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ICMP_H
+
+#include <linux/icmp.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(icmp_send,
+
+		TP_PROTO(const struct sk_buff *skb, int type, int code),
+
+		TP_ARGS(skb, type, code),
+
+		TP_STRUCT__entry(
+			__field(const void *, skbaddr)
+			__field(int, type)
+			__field(int, code)
+			__array(__u8, saddr, 4)
+			__array(__u8, daddr, 4)
+			__field(__u16, sport)
+			__field(__u16, dport)
+			__field(unsigned short, ulen)
+		),
+
+		TP_fast_assign(
+			struct iphdr *iph = ip_hdr(skb);
+			struct udphdr *uh = udp_hdr(skb);
+			int proto_4 = iph->protocol;
+			__be32 *p32;
+
+			__entry->skbaddr = skb;
+			__entry->type = type;
+			__entry->code = code;
+
+			if (proto_4 != IPPROTO_UDP || (u8 *)uh < skb->head ||
+				(u8 *)uh + sizeof(struct udphdr)
+				> skb_tail_pointer(skb)) {
+				__entry->sport = 0;
+				__entry->dport = 0;
+				__entry->ulen = 0;
+			} else {
+				__entry->sport = ntohs(uh->source);
+				__entry->dport = ntohs(uh->dest);
+				__entry->ulen = ntohs(uh->len);
+			}
+
+			p32 = (__be32 *) __entry->saddr;
+			*p32 = iph->saddr;
+
+			p32 = (__be32 *) __entry->daddr;
+			*p32 = iph->daddr;
+		),
+
+		TP_printk("icmp_send: type=%d, code=%d. From %pI4:%u to %pI4:%u ulen=%d skbaddr=%p",
+			__entry->type, __entry->code,
+			__entry->saddr, __entry->sport, __entry->daddr,
+			__entry->dport, __entry->ulen, __entry->skbaddr)
+);
+
+#endif /* _TRACE_ICMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
+
diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 26a11e4a2c36..b799f3bcba82 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -7,6 +7,8 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+#define PG_COUNT_TO_KB(x) ((x) << (PAGE_SHIFT - 10))
+
 TRACE_EVENT(oom_score_adj_update,
 
 	TP_PROTO(struct task_struct *task),
@@ -72,19 +74,45 @@ TRACE_EVENT(reclaim_retry_zone,
 );
 
 TRACE_EVENT(mark_victim,
-	TP_PROTO(int pid),
+	TP_PROTO(struct task_struct *task, uid_t uid),
 
-	TP_ARGS(pid),
+	TP_ARGS(task, uid),
 
 	TP_STRUCT__entry(
 		__field(int, pid)
+		__string(comm, task->comm)
+		__field(unsigned long, total_vm)
+		__field(unsigned long, anon_rss)
+		__field(unsigned long, file_rss)
+		__field(unsigned long, shmem_rss)
+		__field(uid_t, uid)
+		__field(unsigned long, pgtables)
+		__field(short, oom_score_adj)
 	),
 
 	TP_fast_assign(
-		__entry->pid = pid;
+		__entry->pid = task->pid;
+		__assign_str(comm, task->comm);
+		__entry->total_vm = PG_COUNT_TO_KB(task->mm->total_vm);
+		__entry->anon_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_ANONPAGES));
+		__entry->file_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_FILEPAGES));
+		__entry->shmem_rss = PG_COUNT_TO_KB(get_mm_counter(task->mm, MM_SHMEMPAGES));
+		__entry->uid = uid;
+		__entry->pgtables = mm_pgtables_bytes(task->mm) >> 10;
+		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
-	TP_printk("pid=%d", __entry->pid)
+	TP_printk("pid=%d comm=%s total-vm=%lukB anon-rss=%lukB file-rss:%lukB shmem-rss:%lukB uid=%u pgtables=%lukB oom_score_adj=%hd",
+		__entry->pid,
+		__get_str(comm),
+		__entry->total_vm,
+		__entry->anon_rss,
+		__entry->file_rss,
+		__entry->shmem_rss,
+		__entry->uid,
+		__entry->pgtables,
+		__entry->oom_score_adj
+	)
 );
 
 TRACE_EVENT(wake_reaper,
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ffe2679a13ce..b70f47a57bf6 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -328,8 +328,7 @@ TRACE_EVENT(rpc_request,
 		{ (1UL << RPC_TASK_ACTIVE), "ACTIVE" },			\
 		{ (1UL << RPC_TASK_NEED_XMIT), "NEED_XMIT" },		\
 		{ (1UL << RPC_TASK_NEED_RECV), "NEED_RECV" },		\
-		{ (1UL << RPC_TASK_MSG_PIN_WAIT), "MSG_PIN_WAIT" },	\
-		{ (1UL << RPC_TASK_SIGNALLED), "SIGNALLED" })
+		{ (1UL << RPC_TASK_MSG_PIN_WAIT), "MSG_PIN_WAIT" })
 
 DECLARE_EVENT_CLASS(rpc_task_running,
 
diff --git a/io_uring/net.c b/io_uring/net.c
index dc7c1e44ec47..d56e8a47e50f 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -282,7 +282,9 @@ static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 		if (unlikely(ret))
 			return ret;
 
-		return __get_compat_msghdr(&iomsg->msg, &cmsg, NULL);
+		ret = __get_compat_msghdr(&iomsg->msg, &cmsg, NULL);
+		sr->msg_control = iomsg->msg.msg_control_user;
+		return ret;
 	}
 #endif
 
diff --git a/kernel/acct.c b/kernel/acct.c
index 034a26daabb2..889fe13b24f6 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -104,48 +104,50 @@ struct bsd_acct_struct {
 	atomic_long_t		count;
 	struct rcu_head		rcu;
 	struct mutex		lock;
-	int			active;
+	bool			active;
+	bool			check_space;
 	unsigned long		needcheck;
 	struct file		*file;
 	struct pid_namespace	*ns;
 	struct work_struct	work;
 	struct completion	done;
+	acct_t			ac;
 };
 
-static void do_acct_process(struct bsd_acct_struct *acct);
+static void fill_ac(struct bsd_acct_struct *acct);
+static void acct_write_process(struct bsd_acct_struct *acct);
 
 /*
  * Check the amount of free space and suspend/resume accordingly.
  */
-static int check_free_space(struct bsd_acct_struct *acct)
+static bool check_free_space(struct bsd_acct_struct *acct)
 {
 	struct kstatfs sbuf;
 
-	if (time_is_after_jiffies(acct->needcheck))
-		goto out;
+	if (!acct->check_space)
+		return acct->active;
 
 	/* May block */
 	if (vfs_statfs(&acct->file->f_path, &sbuf))
-		goto out;
+		return acct->active;
 
 	if (acct->active) {
 		u64 suspend = sbuf.f_blocks * SUSPEND;
 		do_div(suspend, 100);
 		if (sbuf.f_bavail <= suspend) {
-			acct->active = 0;
+			acct->active = false;
 			pr_info("Process accounting paused\n");
 		}
 	} else {
 		u64 resume = sbuf.f_blocks * RESUME;
 		do_div(resume, 100);
 		if (sbuf.f_bavail >= resume) {
-			acct->active = 1;
+			acct->active = true;
 			pr_info("Process accounting resumed\n");
 		}
 	}
 
 	acct->needcheck = jiffies + ACCT_TIMEOUT*HZ;
-out:
 	return acct->active;
 }
 
@@ -190,7 +192,11 @@ static void acct_pin_kill(struct fs_pin *pin)
 {
 	struct bsd_acct_struct *acct = to_acct(pin);
 	mutex_lock(&acct->lock);
-	do_acct_process(acct);
+	/*
+	 * Fill the accounting struct with the exiting task's info
+	 * before punting to the workqueue.
+	 */
+	fill_ac(acct);
 	schedule_work(&acct->work);
 	wait_for_completion(&acct->done);
 	cmpxchg(&acct->ns->bacct, pin, NULL);
@@ -203,6 +209,9 @@ static void close_work(struct work_struct *work)
 {
 	struct bsd_acct_struct *acct = container_of(work, struct bsd_acct_struct, work);
 	struct file *file = acct->file;
+
+	/* We were fired by acct_pin_kill() which holds acct->lock. */
+	acct_write_process(acct);
 	if (file->f_op->flush)
 		file->f_op->flush(file, NULL);
 	__fput_sync(file);
@@ -235,6 +244,20 @@ static int acct_on(struct filename *pathname)
 		return -EACCES;
 	}
 
+	/* Exclude kernel kernel internal filesystems. */
+	if (file_inode(file)->i_sb->s_flags & (SB_NOUSER | SB_KERNMOUNT)) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
+	/* Exclude procfs and sysfs. */
+	if (file_inode(file)->i_sb->s_iflags & SB_I_USERNS_VISIBLE) {
+		kfree(acct);
+		filp_close(file, NULL);
+		return -EINVAL;
+	}
+
 	if (!(file->f_mode & FMODE_CAN_WRITE)) {
 		kfree(acct);
 		filp_close(file, NULL);
@@ -431,13 +454,27 @@ static u32 encode_float(u64 value)
  *  do_exit() or when switching to a different output file.
  */
 
-static void fill_ac(acct_t *ac)
+static void fill_ac(struct bsd_acct_struct *acct)
 {
 	struct pacct_struct *pacct = &current->signal->pacct;
+	struct file *file = acct->file;
+	acct_t *ac = &acct->ac;
 	u64 elapsed, run_time;
 	time64_t btime;
 	struct tty_struct *tty;
 
+	lockdep_assert_held(&acct->lock);
+
+	if (time_is_after_jiffies(acct->needcheck)) {
+		acct->check_space = false;
+
+		/* Don't fill in @ac if nothing will be written. */
+		if (!acct->active)
+			return;
+	} else {
+		acct->check_space = true;
+	}
+
 	/*
 	 * Fill the accounting struct with the needed info as recorded
 	 * by the different kernel functions.
@@ -485,64 +522,61 @@ static void fill_ac(acct_t *ac)
 	ac->ac_majflt = encode_comp_t(pacct->ac_majflt);
 	ac->ac_exitcode = pacct->ac_exitcode;
 	spin_unlock_irq(&current->sighand->siglock);
-}
-/*
- *  do_acct_process does all actual work. Caller holds the reference to file.
- */
-static void do_acct_process(struct bsd_acct_struct *acct)
-{
-	acct_t ac;
-	unsigned long flim;
-	const struct cred *orig_cred;
-	struct file *file = acct->file;
 
-	/*
-	 * Accounting records are not subject to resource limits.
-	 */
-	flim = rlimit(RLIMIT_FSIZE);
-	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
-	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds(file->f_cred);
-
-	/*
-	 * First check to see if there is enough free_space to continue
-	 * the process accounting system.
-	 */
-	if (!check_free_space(acct))
-		goto out;
-
-	fill_ac(&ac);
 	/* we really need to bite the bullet and change layout */
-	ac.ac_uid = from_kuid_munged(file->f_cred->user_ns, orig_cred->uid);
-	ac.ac_gid = from_kgid_munged(file->f_cred->user_ns, orig_cred->gid);
+	ac->ac_uid = from_kuid_munged(file->f_cred->user_ns, current_uid());
+	ac->ac_gid = from_kgid_munged(file->f_cred->user_ns, current_gid());
 #if ACCT_VERSION == 1 || ACCT_VERSION == 2
 	/* backward-compatible 16 bit fields */
-	ac.ac_uid16 = ac.ac_uid;
-	ac.ac_gid16 = ac.ac_gid;
+	ac->ac_uid16 = ac->ac_uid;
+	ac->ac_gid16 = ac->ac_gid;
 #elif ACCT_VERSION == 3
 	{
 		struct pid_namespace *ns = acct->ns;
 
-		ac.ac_pid = task_tgid_nr_ns(current, ns);
+		ac->ac_pid = task_tgid_nr_ns(current, ns);
 		rcu_read_lock();
-		ac.ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent),
-					     ns);
+		ac->ac_ppid = task_tgid_nr_ns(rcu_dereference(current->real_parent), ns);
 		rcu_read_unlock();
 	}
 #endif
+}
+
+static void acct_write_process(struct bsd_acct_struct *acct)
+{
+	struct file *file = acct->file;
+	const struct cred *cred;
+	acct_t *ac = &acct->ac;
+
+	/* Perform file operations on behalf of whoever enabled accounting */
+	cred = override_creds(file->f_cred);
+
 	/*
-	 * Get freeze protection. If the fs is frozen, just skip the write
-	 * as we could deadlock the system otherwise.
+	 * First check to see if there is enough free_space to continue
+	 * the process accounting system. Then get freeze protection. If
+	 * the fs is frozen, just skip the write as we could deadlock
+	 * the system otherwise.
 	 */
-	if (file_start_write_trylock(file)) {
+	if (check_free_space(acct) && file_start_write_trylock(file)) {
 		/* it's been opened O_APPEND, so position is irrelevant */
 		loff_t pos = 0;
-		__kernel_write(file, &ac, sizeof(acct_t), &pos);
+		__kernel_write(file, ac, sizeof(acct_t), &pos);
 		file_end_write(file);
 	}
-out:
+
+	revert_creds(cred);
+}
+
+static void do_acct_process(struct bsd_acct_struct *acct)
+{
+	unsigned long flim;
+
+	/* Accounting records are not subject to resource limits. */
+	flim = rlimit(RLIMIT_FSIZE);
+	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
+	fill_ac(acct);
+	acct_write_process(acct);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	revert_creds(orig_cred);
 }
 
 /**
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cfb361f4b00e..7a4004f09bae 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1713,8 +1713,6 @@ int generic_map_update_batch(struct bpf_map *map,
 	return err;
 }
 
-#define MAP_LOOKUP_RETRIES 3
-
 int generic_map_lookup_batch(struct bpf_map *map,
 				    const union bpf_attr *attr,
 				    union bpf_attr __user *uattr)
@@ -1724,8 +1722,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
-	int err, retry = MAP_LOOKUP_RETRIES;
 	u32 value_size, cp, max_count;
+	int err;
 
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
 		return -EINVAL;
@@ -1771,14 +1769,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		err = bpf_map_copy_value(map, key, value,
 					 attr->batch.elem_flags);
 
-		if (err == -ENOENT) {
-			if (retry) {
-				retry--;
-				continue;
-			}
-			err = -EINTR;
-			break;
-		}
+		if (err == -ENOENT)
+			goto next_key;
 
 		if (err)
 			goto free_buf;
@@ -1793,12 +1785,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
 			goto free_buf;
 		}
 
+		cp++;
+next_key:
 		if (!prev_key)
 			prev_key = buf_prevkey;
 
 		swap(prev_key, key);
-		retry = MAP_LOOKUP_RETRIES;
-		cp++;
 		cond_resched();
 	}
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4995eb68b78b..8fc2bc5646ee 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5679,14 +5679,15 @@ static int _perf_event_period(struct perf_event *event, u64 value)
 	if (!value)
 		return -EINVAL;
 
-	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
-		return -EINVAL;
-
-	if (perf_event_check_period(event, value))
-		return -EINVAL;
-
-	if (!event->attr.freq && (value & (1ULL << 63)))
-		return -EINVAL;
+	if (event->attr.freq) {
+		if (value > sysctl_perf_event_sample_rate)
+			return -EINVAL;
+	} else {
+		if (perf_event_check_period(event, value))
+			return -EINVAL;
+		if (value & (1ULL << 63))
+			return -EINVAL;
+	}
 
 	event_function_call(event, __perf_event_period, &value);
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 9ee25351ceca..7a22db17f3b5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -484,6 +484,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret <= 0)
 		goto put_old;
 
+	if (is_zero_page(old_page)) {
+		ret = -EINVAL;
+		goto put_old;
+	}
+
 	if (WARN(!is_register && PageCompound(old_page),
 		 "uprobe unregister should never work on compound page\n")) {
 		ret = -EINVAL;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2f7519022c01..0a483fd9f5de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8369,7 +8369,7 @@ SYSCALL_DEFINE0(sched_yield)
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 int __sched __cond_resched(void)
 {
-	if (should_resched(0)) {
+	if (should_resched(0) && !irqs_disabled()) {
 		preempt_schedule_common();
 		return 1;
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 55cc0e67a02e..ce8a8eae7e83 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -507,6 +507,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 	static struct trace_seq s;
 	unsigned long long avg;
 	unsigned long long stddev;
+	unsigned long long stddev_denom;
 #endif
 	mutex_lock(&ftrace_profile_lock);
 
@@ -528,23 +529,19 @@ static int function_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_puts(m, "    ");
 
-	/* Sample standard deviation (s^2) */
-	if (rec->counter <= 1)
-		stddev = 0;
-	else {
-		/*
-		 * Apply Welford's method:
-		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
-		 */
+	/*
+	 * Variance formula:
+	 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
+	 * Maybe Welford's method is better here?
+	 * Divide only by 1000 for ns^2 -> us^2 conversion.
+	 * trace_print_graph_duration will divide by 1000 again.
+	 */
+	stddev = 0;
+	stddev_denom = rec->counter * (rec->counter - 1) * 1000;
+	if (stddev_denom) {
 		stddev = rec->counter * rec->time_squared -
 			 rec->time * rec->time;
-
-		/*
-		 * Divide only 1000 for ns^2 -> us^2 conversion.
-		 * trace_print_graph_duration will divide 1000 again.
-		 */
-		stddev = div64_ul(stddev,
-				  rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev, stddev_denom);
 	}
 
 	trace_seq_init(&s);
@@ -5108,6 +5105,9 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 			return -ENOENT;
 		free_hash_entry(hash, entry);
 		return 0;
+	} else if (__ftrace_lookup_ip(hash, ip) != NULL) {
+		/* Already exists */
+		return 0;
 	}
 
 	return add_hash_entry(hash, ip);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 3b0da1bddf63..a11392596a36 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6551,27 +6551,27 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (existing_hist_update_only(glob, trigger_data, file))
 		goto out_free;
 
-	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
-	if (ret < 0)
-		goto out_free;
+	if (!get_named_trigger_data(trigger_data)) {
 
-	if (get_named_trigger_data(trigger_data))
-		goto enable;
+		ret = create_actions(hist_data);
+		if (ret)
+			goto out_free;
 
-	ret = create_actions(hist_data);
-	if (ret)
-		goto out_unreg;
+		if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+			ret = save_hist_vars(hist_data);
+			if (ret)
+				goto out_free;
+		}
 
-	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		ret = save_hist_vars(hist_data);
+		ret = tracing_map_init(hist_data->map);
 		if (ret)
-			goto out_unreg;
+			goto out_free;
 	}
 
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto out_unreg;
-enable:
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret < 0)
+		goto out_free;
+
 	ret = hist_trigger_enable(trigger_data, file);
 	if (ret)
 		goto out_unreg;
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 9f1bfbe105e8..69e92c7359fb 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -185,7 +185,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	trace_ctx = tracing_gen_ctx();
+	trace_ctx = tracing_gen_ctx_dec();
 
 	cpu = smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
@@ -285,7 +285,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
-	unsigned long flags;
 	int bit;
 	int cpu;
 
@@ -312,8 +311,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (is_repeat_check(tr, last_info, ip, parent_ip))
 		goto out;
 
-	local_save_flags(flags);
-	trace_ctx = tracing_gen_ctx_flags(flags);
+	trace_ctx = tracing_gen_ctx_dec();
 	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
 
 	trace_function(tr, ip, parent_ip, trace_ctx);
diff --git a/mm/gup.c b/mm/gup.c
index e31d00443c4e..b1daaa9d89aa 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -51,7 +51,8 @@ static inline void sanity_check_pinned_pages(struct page **pages,
 		struct page *page = *pages;
 		struct folio *folio = page_folio(page);
 
-		if (!folio_test_anon(folio))
+		if (is_zero_page(page) ||
+		    !folio_test_anon(folio))
 			continue;
 		if (!folio_test_large(folio) || folio_test_hugetlb(folio))
 			VM_BUG_ON_PAGE(!PageAnonExclusive(&folio->page), page);
@@ -128,6 +129,13 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	else if (flags & FOLL_PIN) {
 		struct folio *folio;
 
+		/*
+		 * Don't take a pin on the zero page - it's not going anywhere
+		 * and it is used in a *lot* of places.
+		 */
+		if (is_zero_page(page))
+			return page_folio(page);
+
 		/*
 		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
 		 * right zone, so fail and let the caller fall back to the slow
@@ -177,6 +185,8 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
+		if (is_zero_folio(folio))
+			return;
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
 		if (folio_test_large(folio))
 			atomic_sub(refs, folio_pincount_ptr(folio));
@@ -217,6 +227,13 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 	if (flags & FOLL_GET)
 		folio_ref_inc(folio);
 	else if (flags & FOLL_PIN) {
+		/*
+		 * Don't take a pin on the zero page - it's not going anywhere
+		 * and it is used in a *lot* of places.
+		 */
+		if (is_zero_page(page))
+			return 0;
+
 		/*
 		 * Similar to try_grab_folio(): be sure to *also*
 		 * increment the normal page refcount field at least once,
@@ -3149,6 +3166,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
  * see Documentation/core-api/pin_user_pages.rst for further details.
+ *
+ * Note that if a zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page() will not remove pins from it.
  */
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
@@ -3225,6 +3245,9 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
  * see Documentation/core-api/pin_user_pages.rst for details.
+ *
+ * Note that if a zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page*() will not remove pins from it.
  */
 long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
@@ -3260,6 +3283,9 @@ EXPORT_SYMBOL(pin_user_pages_remote);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
  * see Documentation/core-api/pin_user_pages.rst for details.
+ *
+ * Note that if a zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page*() will not remove pins from it.
  */
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
@@ -3282,6 +3308,9 @@ EXPORT_SYMBOL(pin_user_pages);
  * pin_user_pages_unlocked() is the FOLL_PIN variant of
  * get_user_pages_unlocked(). Behavior is the same, except that this one sets
  * FOLL_PIN and rejects FOLL_GET.
+ *
+ * Note that if a zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page*() will not remove pins from it.
  */
 long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 			     struct page **pages, unsigned int gup_flags)
diff --git a/mm/madvise.c b/mm/madvise.c
index 5973399b2f9b..e1993e18afee 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -879,7 +879,16 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			end = vma->vm_end;
 		}
-		VM_WARN_ON(start >= end);
+		/*
+		 * If the memory region between start and end was
+		 * originally backed by 4kB pages and then remapped to
+		 * be backed by hugepages while mmap_lock was dropped,
+		 * the adjustment for hugetlb vma above may have rounded
+		 * end down to the start address.
+		 */
+		if (start == end)
+			return 0;
+		VM_WARN_ON(start > end);
 	}
 
 	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 280bb6969c0b..3f7cab196eb6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1242,6 +1242,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
+	int i = 0;
 
 	BUG_ON(memcg == root_mem_cgroup);
 
@@ -1250,8 +1251,12 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 		struct task_struct *task;
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
-		while (!ret && (task = css_task_iter_next(&it)))
+		while (!ret && (task = css_task_iter_next(&it))) {
+			/* Avoid potential softlockup warning */
+			if ((++i & 1023) == 0)
+				cond_resched();
 			ret = fn(task, arg);
+		}
 		css_task_iter_end(&it);
 		if (ret) {
 			mem_cgroup_iter_break(memcg, iter);
diff --git a/mm/memory.c b/mm/memory.c
index da9fed5e6025..680d864d52eb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5323,7 +5323,7 @@ static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs
 	}
 
 	if (regs && !user_mode(regs)) {
-		unsigned long ip = instruction_pointer(regs);
+		unsigned long ip = exception_ip(regs);
 		if (!search_exception_tables(ip))
 			return false;
 	}
@@ -5348,7 +5348,7 @@ static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_r
 {
 	mmap_read_unlock(mm);
 	if (regs && !user_mode(regs)) {
-		unsigned long ip = instruction_pointer(regs);
+		unsigned long ip = exception_ip(regs);
 		if (!search_exception_tables(ip))
 			return false;
 	}
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1276e49b31b0..f4c8ef863ea7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -44,6 +44,8 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/cred.h>
+#include <linux/nmi.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -429,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
 		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
 	else {
 		struct task_struct *p;
+		int i = 0;
 
 		rcu_read_lock();
-		for_each_process(p)
+		for_each_process(p) {
+			/* Avoid potential softlockup warning */
+			if ((++i & 1023) == 0)
+				touch_softlockup_watchdog();
 			dump_task(p, oc);
+		}
 		rcu_read_unlock();
 	}
 }
@@ -757,6 +764,7 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
  */
 static void mark_oom_victim(struct task_struct *tsk)
 {
+	const struct cred *cred;
 	struct mm_struct *mm = tsk->mm;
 
 	WARN_ON(oom_killer_disabled);
@@ -776,7 +784,9 @@ static void mark_oom_victim(struct task_struct *tsk)
 	 */
 	__thaw_task(tsk);
 	atomic_inc(&oom_victims);
-	trace_mark_victim(tsk->pid);
+	cred = get_task_cred(tsk);
+	trace_mark_victim(tsk, cred->uid.val);
+	put_cred(cred);
 }
 
 /**
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2a8051fae08c..36d6122f2e12 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -656,7 +656,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
 		hci_conn_hold(conn->hcon);
 
-	list_add(&chan->list, &conn->chan_l);
+	/* Append to the list since the order matters for ECRED */
+	list_add_tail(&chan->list, &conn->chan_l);
 }
 
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
@@ -3995,7 +3996,11 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_ecred_rsp_data *rsp = data;
 
-	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+	/* Check if channel for outgoing connection or if it wasn't deferred
+	 * since in those cases it must be skipped.
+	 */
+	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags) ||
+	    !test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
 		return;
 
 	/* Reset ident so only one response is sent */
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 64be562f0fe3..77b386b76d46 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -768,12 +768,9 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 	void *data;
 
-	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
+	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
-	if (user_size > size)
-		return ERR_PTR(-EMSGSIZE);
-
 	size = SKB_DATA_ALIGN(size);
 	data = kzalloc(size + headroom + tailroom, GFP_USER);
 	if (!data)
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 5c6ed1d49b92..b4d661fe7886 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -366,9 +366,9 @@ br_nf_ipv4_daddr_was_changed(const struct sk_buff *skb,
  */
 static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb->dev, *br_indev;
-	struct iphdr *iph = ip_hdr(skb);
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
+	struct net_device *dev = skb->dev, *br_indev;
+	const struct iphdr *iph = ip_hdr(skb);
 	struct rtable *rt;
 	int err;
 
@@ -386,7 +386,9 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	}
 	nf_bridge->in_prerouting = 0;
 	if (br_nf_ipv4_daddr_was_changed(skb, nf_bridge)) {
-		if ((err = ip_route_input(skb, iph->daddr, iph->saddr, iph->tos, dev))) {
+		err = ip_route_input(skb, iph->daddr, iph->saddr,
+				     ip4h_dscp(iph), dev);
+		if (err) {
 			struct in_device *in_dev = __in_dev_get_rcu(dev);
 
 			/* If err equals -EHOSTUNREACH the error is due to a
diff --git a/net/core/dev.c b/net/core/dev.c
index 90559cb66803..212a909b4840 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -921,6 +921,12 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 	return ret;
 }
 
+static bool dev_addr_cmp(struct net_device *dev, unsigned short type,
+			 const char *ha)
+{
+	return dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len);
+}
+
 /**
  *	dev_getbyhwaddr_rcu - find a device by its hardware address
  *	@net: the applicable net namespace
@@ -929,7 +935,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *
  *	Search for an interface by MAC address. Returns NULL if the device
  *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
+ *	The caller must hold RCU.
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
@@ -941,14 +947,39 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 	struct net_device *dev;
 
 	for_each_netdev_rcu(net, dev)
-		if (dev->type == type &&
-		    !memcmp(dev->dev_addr, ha, dev->addr_len))
+		if (dev_addr_cmp(dev, type, ha))
 			return dev;
 
 	return NULL;
 }
 EXPORT_SYMBOL(dev_getbyhwaddr_rcu);
 
+/**
+ * dev_getbyhwaddr() - find a device by its hardware address
+ * @net: the applicable net namespace
+ * @type: media type of device
+ * @ha: hardware address
+ *
+ * Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
+ * rtnl_lock.
+ *
+ * Context: rtnl_lock() must be held.
+ * Return: pointer to the net_device, or NULL if not found
+ */
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *ha)
+{
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+	for_each_netdev(net, dev)
+		if (dev_addr_cmp(dev, type, ha))
+			return dev;
+
+	return NULL;
+}
+EXPORT_SYMBOL(dev_getbyhwaddr);
+
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 {
 	struct net_device *dev, *ret = NULL;
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 522657b597d9..fef94f3b03de 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1716,30 +1716,30 @@ static int __init init_net_drop_monitor(void)
 		return -ENOSPC;
 	}
 
-	rc = genl_register_family(&net_drop_monitor_family);
-	if (rc) {
-		pr_err("Could not create drop monitor netlink family\n");
-		return rc;
+	for_each_possible_cpu(cpu) {
+		net_dm_cpu_data_init(cpu);
+		net_dm_hw_cpu_data_init(cpu);
 	}
-	WARN_ON(net_drop_monitor_family.mcgrp_offset != NET_DM_GRP_ALERT);
 
 	rc = register_netdevice_notifier(&dropmon_net_notifier);
 	if (rc < 0) {
 		pr_crit("Failed to register netdevice notifier\n");
+		return rc;
+	}
+
+	rc = genl_register_family(&net_drop_monitor_family);
+	if (rc) {
+		pr_err("Could not create drop monitor netlink family\n");
 		goto out_unreg;
 	}
+	WARN_ON(net_drop_monitor_family.mcgrp_offset != NET_DM_GRP_ALERT);
 
 	rc = 0;
 
-	for_each_possible_cpu(cpu) {
-		net_dm_cpu_data_init(cpu);
-		net_dm_hw_cpu_data_init(cpu);
-	}
-
 	goto out;
 
 out_unreg:
-	genl_unregister_family(&net_drop_monitor_family);
+	WARN_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 out:
 	return rc;
 }
@@ -1748,19 +1748,18 @@ static void exit_net_drop_monitor(void)
 {
 	int cpu;
 
-	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
-
 	/*
 	 * Because of the module_get/put we do in the trace state change path
 	 * we are guaranteed not to have any current users when we get here
 	 */
+	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
+
+	BUG_ON(unregister_netdevice_notifier(&dropmon_net_notifier));
 
 	for_each_possible_cpu(cpu) {
 		net_dm_hw_cpu_data_fini(cpu);
 		net_dm_cpu_data_fini(cpu);
 	}
-
-	BUG_ON(genl_unregister_family(&net_drop_monitor_family));
 }
 
 module_init(init_net_drop_monitor);
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index de17f1323238..5f50e182acd5 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -751,23 +751,30 @@ __skb_flow_dissect_ports(const struct sk_buff *skb,
 			 void *target_container, const void *data,
 			 int nhoff, u8 ip_proto, int hlen)
 {
-	enum flow_dissector_key_id dissector_ports = FLOW_DISSECTOR_KEY_MAX;
-	struct flow_dissector_key_ports *key_ports;
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
+	struct flow_dissector_key_ports *key_ports = NULL;
+	__be32 ports;
 
 	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS;
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		dissector_ports = FLOW_DISSECTOR_KEY_PORTS_RANGE;
+		key_ports = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_PORTS,
+						      target_container);
 
-	if (dissector_ports == FLOW_DISSECTOR_KEY_MAX)
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS_RANGE))
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+
+	if (!key_ports && !key_ports_range)
 		return;
 
-	key_ports = skb_flow_dissector_target(flow_dissector,
-					      dissector_ports,
-					      target_container);
-	key_ports->ports = __skb_flow_get_ports(skb, nhoff, ip_proto,
-						data, hlen);
+	ports = __skb_flow_get_ports(skb, nhoff, ip_proto, data, hlen);
+
+	if (key_ports)
+		key_ports->ports = ports;
+
+	if (key_ports_range)
+		key_ports_range->tp.ports = ports;
 }
 
 static void
@@ -822,6 +829,7 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 				     struct flow_dissector *flow_dissector,
 				     void *target_container)
 {
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
 	struct flow_dissector_key_ports *key_ports = NULL;
 	struct flow_dissector_key_control *key_control;
 	struct flow_dissector_key_basic *key_basic;
@@ -866,20 +874,21 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 		key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 	}
 
-	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS)) {
 		key_ports = skb_flow_dissector_target(flow_dissector,
 						      FLOW_DISSECTOR_KEY_PORTS,
 						      target_container);
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		key_ports = skb_flow_dissector_target(flow_dissector,
-						      FLOW_DISSECTOR_KEY_PORTS_RANGE,
-						      target_container);
-
-	if (key_ports) {
 		key_ports->src = flow_keys->sport;
 		key_ports->dst = flow_keys->dport;
 	}
+	if (dissector_uses_key(flow_dissector,
+			       FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+		key_ports_range->tp.src = flow_keys->sport;
+		key_ports_range->tp.dst = flow_keys->dport;
+	}
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
diff --git a/net/core/gro.c b/net/core/gro.c
index 47118e97ecfd..c4cbf398c5f7 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -679,6 +679,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 	skb->pkt_type = PACKET_HOST;
 
 	skb->encapsulation = 0;
+	skb->ip_summed = CHECKSUM_NONE;
 	skb_shinfo(skb)->gso_type = 0;
 	skb_shinfo(skb)->gso_size = 0;
 	if (unlikely(skb->slow_gro)) {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 768b8d65a5ba..d8a3ada886ff 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5556,11 +5556,11 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->offload_fwd_mark = 0;
 	skb->offload_l3_fwd_mark = 0;
 #endif
+	ipvs_reset(skb);
 
 	if (!xnet)
 		return;
 
-	ipvs_reset(skb);
 	skb->mark = 0;
 	skb_clear_tstamp(skb);
 }
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 65764952bc68..5a790cd1121b 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -547,6 +547,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 			return num_sge;
 	}
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	psock->ingress_bytes += len;
+#endif
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
@@ -1140,6 +1143,10 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 	if (!ret)
 		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
 
+	if (sk_is_tcp(sk)) {
+		psock->strp.cb.read_sock = tcp_bpf_strp_read_sock;
+		psock->copied_seq = tcp_sk(sk)->copied_seq;
+	}
 	return ret;
 }
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 47ca6d3ddbb5..75efc712bb9b 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -30,6 +30,7 @@ static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
 static int max_skb_frags = MAX_SKB_FRAGS;
 static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
+static int netdev_budget_usecs_min = 2 * USEC_PER_SEC / HZ;
 
 static int net_msg_warn;	/* Unused, but still a sysctl */
 
@@ -554,7 +555,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.extra1		= &netdev_budget_usecs_min,
 	},
 	{
 		.procname	= "fb_tunnels_only_for_init_net",
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 8f9b5568f1dc..50e2b4939d8e 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1030,7 +1030,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	if (mask && mask != htonl(0xFFFFFFFF))
 		return -EINVAL;
 	if (!dev && (r->arp_flags & ATF_COM)) {
-		dev = dev_getbyhwaddr_rcu(net, r->arp_ha.sa_family,
+		dev = dev_getbyhwaddr(net, r->arp_ha.sa_family,
 				      r->arp_ha.sa_data);
 		if (!dev)
 			return -ENODEV;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index a21d32b3ae6c..94501bb30c43 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -93,6 +93,9 @@
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
 #include <net/addrconf.h>
+#include <net/inet_dscp.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/icmp.h>
 
 /*
  *	Build xmit assembly blocks
@@ -481,13 +484,11 @@ static struct net_device *icmp_get_route_lookup_dev(struct sk_buff *skb)
 	return route_lookup_dev;
 }
 
-static struct rtable *icmp_route_lookup(struct net *net,
-					struct flowi4 *fl4,
+static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 					struct sk_buff *skb_in,
-					const struct iphdr *iph,
-					__be32 saddr, u8 tos, u32 mark,
-					int type, int code,
-					struct icmp_bxm *param)
+					const struct iphdr *iph, __be32 saddr,
+					dscp_t dscp, u32 mark, int type,
+					int code, struct icmp_bxm *param)
 {
 	struct net_device *route_lookup_dev;
 	struct rtable *rt, *rt2;
@@ -500,7 +501,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	fl4->saddr = saddr;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_uid = sock_net_uid(net, NULL);
-	fl4->flowi4_tos = RT_TOS(tos);
+	fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
 	fl4->flowi4_proto = IPPROTO_ICMP;
 	fl4->fl4_icmp_type = type;
 	fl4->fl4_icmp_code = code;
@@ -548,7 +549,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 		orefdst = skb_in->_skb_refdst; /* save old refdst */
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     RT_TOS(tos), rt2->dst.dev);
+				     dscp, rt2->dst.dev);
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
@@ -744,8 +745,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	ipc.opt = &icmp_param.replyopts.opt;
 	ipc.sockc.mark = mark;
 
-	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr, tos, mark,
-			       type, code, &icmp_param);
+	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
+			       inet_dsfield_to_dscp(tos), mark, type, code,
+			       &icmp_param);
 	if (IS_ERR(rt))
 		goto out_unlock;
 
@@ -778,6 +780,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	if (!fl4.saddr)
 		fl4.saddr = htonl(INADDR_DUMMY);
 
+	trace_icmp_send(skb_in, type, code);
+
 	icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
 ende:
 	ip_rt_put(rt);
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index a9e22a098872..b4c59708fc09 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -617,7 +617,8 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 
 		orefdst = skb->_skb_refdst;
 		skb_dst_set(skb, NULL);
-		err = ip_route_input(skb, nexthop, iph->saddr, iph->tos, dev);
+		err = ip_route_input(skb, nexthop, iph->saddr, ip4h_dscp(iph),
+				     dev);
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e27a9a9bb162..7d591a0cf0c7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1699,12 +1699,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
  *	  or for 'peeking' the socket using this routine
  *	  (although both would be easy to implement).
  */
-int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
-		  sk_read_actor_t recv_actor)
+static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor, bool noack,
+			   u32 *copied_seq)
 {
 	struct sk_buff *skb;
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 seq = tp->copied_seq;
+	u32 seq = *copied_seq;
 	u32 offset;
 	int copied = 0;
 
@@ -1758,9 +1759,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_eat_recv_skb(sk, skb);
 		if (!desc->count)
 			break;
-		WRITE_ONCE(tp->copied_seq, seq);
+		WRITE_ONCE(*copied_seq, seq);
 	}
-	WRITE_ONCE(tp->copied_seq, seq);
+	WRITE_ONCE(*copied_seq, seq);
+
+	if (noack)
+		goto out;
 
 	tcp_rcv_space_adjust(sk);
 
@@ -1769,10 +1773,25 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_recv_skb(sk, seq, &offset);
 		tcp_cleanup_rbuf(sk, copied);
 	}
+out:
 	return copied;
 }
+
+int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+		  sk_read_actor_t recv_actor)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, false,
+			       &tcp_sk(sk)->copied_seq);
+}
 EXPORT_SYMBOL(tcp_read_sock);
 
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, noack, copied_seq);
+}
+
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a8db010e9e61..bf10fa3c37b7 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -691,6 +691,42 @@ static int tcp_bpf_assert_proto_ops(struct proto *ops)
 	       ops->sendpage == tcp_sendpage ? 0 : -ENOTSUPP;
 }
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct sock *sk = strp->sk;
+	struct sk_psock *psock;
+	struct tcp_sock *tp;
+	int copied = 0;
+
+	tp = tcp_sk(sk);
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (WARN_ON_ONCE(!psock)) {
+		desc->error = -EINVAL;
+		goto out;
+	}
+
+	psock->ingress_bytes = 0;
+	copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
+				     &psock->copied_seq);
+	if (copied < 0)
+		goto out;
+	/* recv_actor may redirect skb to another socket (SK_REDIRECT) or
+	 * just put skb into ingress queue of current socket (SK_PASS).
+	 * For SK_REDIRECT, we need to ack the frame immediately but for
+	 * SK_PASS, we want to delay the ack until tcp_bpf_recvmsg_parser().
+	 */
+	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
+	tcp_rcv_space_adjust(sk);
+	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
+out:
+	rcu_read_unlock();
+	return copied;
+}
+#endif /* CONFIG_BPF_STREAM_PARSER */
+
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
 	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index d0b7ded591bd..cb01c770d8cf 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -178,7 +178,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	if (!skb)
 		return;
 
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 	/* segs_in has been initialized to 1 in tcp_create_openreq_child().
 	 * Hence, reset segs_in to 0 before calling tcp_segs_in()
 	 * to avoid double counting.  Also, tcp_segs_in() expects
@@ -195,7 +195,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
 
 	/* u64_stats_update_begin(&tp->syncp) not needed here,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2379ee551164..3b81f6df829f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4836,7 +4836,7 @@ static void tcp_ofo_queue(struct sock *sk)
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
 		fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 		if (!eaten)
-			__skb_queue_tail(&sk->sk_receive_queue, skb);
+			tcp_add_receive_queue(sk, skb);
 		else
 			kfree_skb_partial(skb, fragstolen);
 
@@ -5027,7 +5027,7 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 				  skb, fragstolen)) ? 1 : 0;
 	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
 	if (!eaten) {
-		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		tcp_add_receive_queue(sk, skb);
 		skb_set_owner_r(skb, sk);
 	}
 	return eaten;
@@ -5110,7 +5110,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		__kfree_skb(skb);
 		return;
 	}
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -6041,7 +6041,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPHITS);
 
 			/* Bulk data transfer: receiver */
-			skb_dst_drop(skb);
+			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 805b1a9eca1c..7647f1ec0584 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1791,7 +1791,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	 */
 	skb_condense(skb);
 
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 
 	if (unlikely(tcp_checksum_complete(skb))) {
 		bh_unlock_sock(sk);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index c562cb965e74..bc94df0140bf 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -735,12 +735,6 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* In sequence, PAWS is OK. */
 
-	/* TODO: We probably should defer ts_recent change once
-	 * we take ownership of @req.
-	 */
-	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
-		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
-
 	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
 		/* Truncate SYN, it is out of window starting
 		   at tcp_rsk(req)->rcv_isn + 1. */
@@ -789,6 +783,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!child)
 		goto listen_overflow;
 
+	if (own_req && tmp_opt.saw_tstamp &&
+	    !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
+		tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
+
 	if (own_req && rsk_drop_req(req)) {
 		reqsk_queue_removed(&inet_csk(req->rsk_listener)->icsk_accept_queue, req);
 		inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index f3324f2a4046..a82d382193e4 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -628,8 +628,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		}
 		skb_dst_set(skb2, &rt->dst);
 	} else {
-		if (ip_route_input(skb2, eiph->daddr, eiph->saddr, eiph->tos,
-				   skb2->dev) ||
+		if (ip_route_input(skb2, eiph->daddr, eiph->saddr,
+				   ip4h_dscp(eiph), skb2->dev) ||
 		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index c1d0f947a7c8..862ac1e2e191 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -125,7 +125,8 @@ static void rpl_destroy_state(struct lwtunnel_state *lwt)
 }
 
 static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
-			     const struct ipv6_rpl_sr_hdr *srh)
+			     const struct ipv6_rpl_sr_hdr *srh,
+			     struct dst_entry *cache_dst)
 {
 	struct ipv6_rpl_sr_hdr *isrh, *csrh;
 	const struct ipv6hdr *oldhdr;
@@ -153,7 +154,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 
 	hdrlen = ((csrh->hdrlen + 1) << 3);
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err)) {
 		kfree(buf);
 		return err;
@@ -186,7 +187,8 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 	return 0;
 }
 
-static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
+static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt,
+		      struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct rpl_iptunnel_encap *tinfo;
@@ -196,7 +198,7 @@ static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
 
 	tinfo = rpl_encap_lwtunnel(dst->lwtstate);
 
-	return rpl_do_srh_inline(skb, rlwt, tinfo->srh);
+	return rpl_do_srh_inline(skb, rlwt, tinfo->srh, cache_dst);
 }
 
 static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
@@ -208,14 +210,14 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
 
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
-
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
 	local_bh_enable();
 
+	err = rpl_do_srh(skb, rlwt, dst);
+	if (unlikely(err))
+		goto drop;
+
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -237,15 +239,15 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		local_bh_disable();
 		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
 		local_bh_enable();
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	}
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
-
 	return dst_output(net, sk, skb);
 
 drop:
@@ -257,35 +259,47 @@ static int rpl_input(struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct rpl_lwt *rlwt;
 	int err;
 
-	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
+	/* We cannot dereference "orig_dst" once ip6_route_input() or
+	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
+	 * need the address of its lwtstate. So, save the address of lwtstate
+	 * now and use it later as a comparison.
+	 */
+	lwtst = orig_dst->lwtstate;
 
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
+	rlwt = rpl_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
+	local_bh_enable();
+
+	err = rpl_do_srh(skb, rlwt, dst);
+	if (unlikely(err))
+		goto drop;
 
 	skb_dst_drop(skb);
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
-		if (!dst->error) {
+
+		/* cache only if we don't create a dst reference loop */
+		if (!dst->error && lwtst != dst->lwtstate) {
+			local_bh_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
+			local_bh_enable();
 		}
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	} else {
 		skb_dst_set(skb, dst);
 	}
-	local_bh_enable();
-
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
 
 	return dst_input(skb);
 
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index ae5299c277bc..b186d85ec5b3 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -124,8 +124,8 @@ static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
 	return flowlabel;
 }
 
-/* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
-int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
+static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
+			       int proto, struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct net *net = dev_net(dst->dev);
@@ -137,7 +137,7 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	hdrlen = (osrh->hdrlen + 1) << 3;
 	tot_len = hdrlen + sizeof(*hdr);
 
-	err = skb_cow_head(skb, tot_len + skb->mac_len);
+	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -197,11 +197,18 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 
 	return 0;
 }
+
+/* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
+int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
+{
+	return __seg6_do_srh_encap(skb, osrh, proto, NULL);
+}
 EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
 
 /* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
 static int seg6_do_srh_encap_red(struct sk_buff *skb,
-				 struct ipv6_sr_hdr *osrh, int proto)
+				 struct ipv6_sr_hdr *osrh, int proto,
+				 struct dst_entry *cache_dst)
 {
 	__u8 first_seg = osrh->first_segment;
 	struct dst_entry *dst = skb_dst(skb);
@@ -230,7 +237,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 	tot_len = red_hdrlen + sizeof(struct ipv6hdr);
 
-	err = skb_cow_head(skb, tot_len + skb->mac_len);
+	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -317,8 +324,8 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 	return 0;
 }
 
-/* insert an SRH within an IPv6 packet, just after the IPv6 header */
-int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
+static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
+				struct dst_entry *cache_dst)
 {
 	struct ipv6hdr *hdr, *oldhdr;
 	struct ipv6_sr_hdr *isrh;
@@ -326,7 +333,7 @@ int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
 
 	hdrlen = (osrh->hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -369,9 +376,8 @@ int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(seg6_do_srh_inline);
 
-static int seg6_do_srh(struct sk_buff *skb)
+static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct seg6_iptunnel_encap *tinfo;
@@ -384,7 +390,7 @@ static int seg6_do_srh(struct sk_buff *skb)
 		if (skb->protocol != htons(ETH_P_IPV6))
 			return -EINVAL;
 
-		err = seg6_do_srh_inline(skb, tinfo->srh);
+		err = __seg6_do_srh_inline(skb, tinfo->srh, cache_dst);
 		if (err)
 			return err;
 		break;
@@ -402,9 +408,11 @@ static int seg6_do_srh(struct sk_buff *skb)
 			return -EINVAL;
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_ENCAP)
-			err = seg6_do_srh_encap(skb, tinfo->srh, proto);
+			err = __seg6_do_srh_encap(skb, tinfo->srh,
+						  proto, cache_dst);
 		else
-			err = seg6_do_srh_encap_red(skb, tinfo->srh, proto);
+			err = seg6_do_srh_encap_red(skb, tinfo->srh,
+						    proto, cache_dst);
 
 		if (err)
 			return err;
@@ -425,11 +433,13 @@ static int seg6_do_srh(struct sk_buff *skb)
 		skb_push(skb, skb->mac_len);
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
-			err = seg6_do_srh_encap(skb, tinfo->srh,
-						IPPROTO_ETHERNET);
+			err = __seg6_do_srh_encap(skb, tinfo->srh,
+						  IPPROTO_ETHERNET,
+						  cache_dst);
 		else
 			err = seg6_do_srh_encap_red(skb, tinfo->srh,
-						    IPPROTO_ETHERNET);
+						    IPPROTO_ETHERNET,
+						    cache_dst);
 
 		if (err)
 			return err;
@@ -444,6 +454,13 @@ static int seg6_do_srh(struct sk_buff *skb)
 	return 0;
 }
 
+/* insert an SRH within an IPv6 packet, just after the IPv6 header */
+int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
+{
+	return __seg6_do_srh_inline(skb, osrh, NULL);
+}
+EXPORT_SYMBOL_GPL(seg6_do_srh_inline);
+
 static int seg6_input_finish(struct net *net, struct sock *sk,
 			     struct sk_buff *skb)
 {
@@ -455,35 +472,47 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
+	struct lwtunnel_state *lwtst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	err = seg6_do_srh(skb);
-	if (unlikely(err))
-		goto drop;
+	/* We cannot dereference "orig_dst" once ip6_route_input() or
+	 * skb_dst_drop() is called. However, in order to detect a dst loop, we
+	 * need the address of its lwtstate. So, save the address of lwtstate
+	 * now and use it later as a comparison.
+	 */
+	lwtst = orig_dst->lwtstate;
 
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_lwt_lwtunnel(lwtst);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
+	local_bh_enable();
+
+	err = seg6_do_srh(skb, dst);
+	if (unlikely(err))
+		goto drop;
 
 	skb_dst_drop(skb);
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
-		if (!dst->error) {
+
+		/* cache only if we don't create a dst reference loop */
+		if (!dst->error && lwtst != dst->lwtstate) {
+			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
+			local_bh_enable();
 		}
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	} else {
 		skb_dst_set(skb, dst);
 	}
-	local_bh_enable();
-
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -529,16 +558,16 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 	struct seg6_lwt *slwt;
 	int err;
 
-	err = seg6_do_srh(skb);
-	if (unlikely(err))
-		goto drop;
-
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
 	local_bh_enable();
 
+	err = seg6_do_srh(skb, dst);
+	if (unlikely(err))
+		goto drop;
+
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -560,15 +589,15 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		local_bh_disable();
 		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
 		local_bh_enable();
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	}
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
-
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
 			       NULL, skb_dst(skb)->dev, dst_output);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ddbc352f8420..fef7bb2a08d8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1554,11 +1554,6 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		if (mptcp_pm_is_userspace(msk))
 			goto next;
 
-		if (list_empty(&msk->conn_list)) {
-			mptcp_pm_remove_anno_addr(msk, addr, false);
-			goto next;
-		}
-
 		lock_sock(sk);
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 884abe3cde53..c3e0ad7beb57 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1020,7 +1020,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (data_len == 0) {
 		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
 	}
 
@@ -1162,18 +1161,6 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
-{
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-
-	if (subflow->mp_join)
-		return false;
-	else if (READ_ONCE(msk->csum_enabled))
-		return !subflow->valid_csum_seen;
-	else
-		return READ_ONCE(msk->allow_infinite_fallback);
-}
-
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1277,7 +1264,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!subflow_can_fallback(subflow) && subflow->map_data_len) {
+		if (!READ_ONCE(msk->allow_infinite_fallback)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index b7b2ed05ac50..ec4c39641089 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1770,7 +1770,7 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
 	cnet = nf_ct_pernet(net);
 	if (cnet->expect_count) {
 		spin_lock_bh(&nf_conntrack_expect_lock);
-		exp = nf_ct_find_expectation(net, zone, tuple);
+		exp = nf_ct_find_expectation(net, zone, tuple, !tmpl || nf_ct_is_confirmed(tmpl));
 		if (exp) {
 			pr_debug("expectation arrives ct=%p exp=%p\n",
 				 ct, exp);
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 96948e98ec53..81ca348915c9 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -171,7 +171,7 @@ EXPORT_SYMBOL_GPL(nf_ct_expect_find_get);
 struct nf_conntrack_expect *
 nf_ct_find_expectation(struct net *net,
 		       const struct nf_conntrack_zone *zone,
-		       const struct nf_conntrack_tuple *tuple)
+		       const struct nf_conntrack_tuple *tuple, bool unlink)
 {
 	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
 	struct nf_conntrack_expect *i, *exp = NULL;
@@ -211,7 +211,7 @@ nf_ct_find_expectation(struct net *net,
 		     !refcount_inc_not_zero(&exp->master->ct_general.use)))
 		return NULL;
 
-	if (exp->flags & NF_CT_EXPECT_PERMANENT) {
+	if (exp->flags & NF_CT_EXPECT_PERMANENT || !unlink) {
 		refcount_inc(&exp->use);
 		return exp;
 	} else if (del_timer(&exp->timeout)) {
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 2bfe3cdfbd58..6157f8b4a3ce 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -272,6 +272,7 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 			regs->verdict.code = NF_DROP;
 			return;
 		}
+		__set_bit(IPS_CONFIRMED_BIT, &ct->status);
 	}
 
 	nf_ct_set(skb, ct, IP_CT_NEW);
@@ -378,6 +379,7 @@ static bool nft_ct_tmpl_alloc_pcpu(void)
 			return false;
 		}
 
+		__set_bit(IPS_CONFIRMED_BIT, &tmp->status);
 		per_cpu(nft_ct_pcpu_template, cpu) = tmp;
 	}
 
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index e1040421b797..af5f2ab69b8d 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -39,6 +39,9 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	unsigned int prev_backlog;
 
+	if (unlikely(READ_ONCE(sch->limit) == 0))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < sch->limit))
 		return qdisc_enqueue_tail(skb, sch);
 
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 8299ceb3e373..95696f42647e 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -347,7 +347,10 @@ static int strp_read_sock(struct strparser *strp)
 	struct socket *sock = strp->sk->sk_socket;
 	read_descriptor_t desc;
 
-	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
+	if (unlikely(!sock || !sock->ops))
+		return -EBUSY;
+
+	if (unlikely(!strp->cb.read_sock && !sock->ops->read_sock))
 		return -EBUSY;
 
 	desc.arg.data = strp;
@@ -355,7 +358,10 @@ static int strp_read_sock(struct strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	sock->ops->read_sock(strp->sk, &desc, strp_recv);
+	if (strp->cb.read_sock)
+		strp->cb.read_sock(strp, &desc, strp_recv);
+	else
+		sock->ops->read_sock(strp->sk, &desc, strp_recv);
 
 	desc.error = strp->cb.read_sock_done(strp, desc.error);
 
@@ -468,6 +474,7 @@ int strp_init(struct strparser *strp, struct sock *sk,
 	strp->cb.unlock = cb->unlock ? : strp_sock_unlock;
 	strp->cb.rcv_msg = cb->rcv_msg;
 	strp->cb.parse_msg = cb->parse_msg;
+	strp->cb.read_sock = cb->read_sock;
 	strp->cb.read_sock_done = cb->read_sock_done ? : default_read_sock_done;
 	strp->cb.abort_parser = cb->abort_parser ? : strp_abort_strp;
 
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 94889df659f0..7ac4648c7da7 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1675,12 +1675,14 @@ static void remove_cache_proc_entries(struct cache_detail *cd)
 	}
 }
 
-#ifdef CONFIG_PROC_FS
 static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 {
 	struct proc_dir_entry *p;
 	struct sunrpc_net *sn;
 
+	if (!IS_ENABLED(CONFIG_PROC_FS))
+		return 0;
+
 	sn = net_generic(net, sunrpc_net_id);
 	cd->procfs = proc_mkdir(cd->name, sn->proc_net_rpc);
 	if (cd->procfs == NULL)
@@ -1708,12 +1710,6 @@ static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 	remove_cache_proc_entries(cd);
 	return -ENOMEM;
 }
-#else /* CONFIG_PROC_FS */
-static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
-{
-	return 0;
-}
-#endif
 
 void __init cache_initialize(void)
 {
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index cef623ea1506..9b45fbdc90ca 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -864,8 +864,6 @@ void rpc_signal_task(struct rpc_task *task)
 	if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
 		return;
 	trace_rpc_task_signalled(task, task->tk_action);
-	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
-	smp_mb__after_atomic();
 	queue = READ_ONCE(task->tk_waitqueue);
 	if (queue)
 		rpc_wake_up_queued_task(queue, task);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index bd19f92aeeec..9d7d99b584fe 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2465,7 +2465,9 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 				break;
 			id = kctl->id;
 			id.index = spdif_index;
-			snd_ctl_rename_id(codec->card, &kctl->id, &id);
+			err = snd_ctl_rename_id(codec->card, &kctl->id, &id);
+			if (err < 0)
+				return err;
 		}
 		bus->primary_dig_out_type = HDA_PCM_TYPE_HDMI;
 	}
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7edb029f08a3..a3d68b83ebd5 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1098,6 +1098,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index b288874e401e..b2e1856ab891 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -121,7 +121,7 @@ static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
-	{ CS42L42_HP_CTL, 0x03 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIC_DET_CTL1, 0xB6 },
 	{ CS42L42_TIPSENSE_CTL, 0xC2 },
 	{ CS42L42_HS_CLAMP_DISABLE, 0x01 },
@@ -315,7 +315,7 @@ static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
 	{ CS42L42_ASP_TX_SZ_EN, 0x01 },
 	{ CS42L42_PWR_CTL1, 0x0A },
 	{ CS42L42_PWR_CTL2, 0x84 },
-	{ CS42L42_HP_CTL, 0x03 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
@@ -371,7 +371,7 @@ static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
 	{ CS42L42_ASP_TX_SZ_EN, 0x00 },
 	{ CS42L42_PWR_CTL1, 0x0E },
 	{ CS42L42_PWR_CTL2, 0x84 },
-	{ CS42L42_HP_CTL, 0x01 },
+	{ CS42L42_HP_CTL, 0x0D },
 	{ CS42L42_MIXER_CHA_VOL, 0x3F },
 	{ CS42L42_MIXER_CHB_VOL, 0x3F },
 	{ CS42L42_MIXER_ADC_VOL, 0x3f },
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 892223d9e64a..b003ac1990ba 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -876,7 +876,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 		{ CS42L42_DET_INT_STATUS2, 0x00 },
 		{ CS42L42_TSRS_PLUG_STATUS, 0x00 },
 	};
-	int fsv_old, fsv_new;
+	unsigned int fsv;
 
 	/* Bring CS42L42 out of Reset */
 	spec->gpio_data = snd_hda_codec_read(codec, CS8409_PIN_AFG, 0, AC_VERB_GET_GPIO_DATA, 0);
@@ -893,13 +893,15 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
 
-	fsv_old = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
-	if (cs42l42->full_scale_vol == CS42L42_FULL_SCALE_VOL_0DB)
-		fsv_new = fsv_old & ~CS42L42_FULL_SCALE_VOL_MASK;
-	else
-		fsv_new = fsv_old & CS42L42_FULL_SCALE_VOL_MASK;
-	if (fsv_new != fsv_old)
-		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv_new);
+	fsv = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
+	if (cs42l42->full_scale_vol) {
+		// Set the full scale volume bit
+		fsv |= CS42L42_FULL_SCALE_VOL_MASK;
+		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv);
+	}
+	// Unmute analog channels A and B
+	fsv = (fsv & ~CS42L42_ANA_MUTE_AB);
+	cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv);
 
 	/* we have to explicitly allow unsol event handling even during the
 	 * resume phase so that the jack event is processed properly
@@ -921,7 +923,7 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 		{ CS42L42_MIXER_CHA_VOL, 0x3F },
 		{ CS42L42_MIXER_ADC_VOL, 0x3F },
 		{ CS42L42_MIXER_CHB_VOL, 0x3F },
-		{ CS42L42_HP_CTL, 0x0F },
+		{ CS42L42_HP_CTL, 0x0D },
 		{ CS42L42_ASP_RX_DAI0_EN, 0x00 },
 		{ CS42L42_ASP_CLK_CFG, 0x00 },
 		{ CS42L42_PWR_CTL1, 0xFE },
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 937e9387abdc..bca81d49f201 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -230,9 +230,10 @@ enum cs8409_coefficient_index_registers {
 #define CS42L42_PDN_TIMEOUT_US			(250000)
 #define CS42L42_PDN_SLEEP_US			(2000)
 #define CS42L42_INIT_TIMEOUT_MS			(45)
+#define CS42L42_ANA_MUTE_AB			(0x0C)
 #define CS42L42_FULL_SCALE_VOL_MASK		(2)
-#define CS42L42_FULL_SCALE_VOL_0DB		(1)
-#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(0)
+#define CS42L42_FULL_SCALE_VOL_0DB		(0)
+#define CS42L42_FULL_SCALE_VOL_MINUS6DB		(1)
 
 /* Dell BULLSEYE / WARLOCK / CYBORG Specific Definitions */
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 183c8a587acf..96725b6599ec 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3776,6 +3776,7 @@ static void alc225_init(struct hda_codec *codec)
 				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 
 		msleep(75);
+		alc_update_coef_idx(codec, 0x4a, 3 << 10, 0);
 		alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
 	}
 }
diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 160adc706cc6..8182e9b37c03 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -234,7 +234,6 @@ static const struct snd_kcontrol_new es8328_right_line_controls =
 
 /* Left Mixer */
 static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL17, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL17, 6, 1, 0),
 	SOC_DAPM_SINGLE("Right Playback Switch", ES8328_DACCONTROL18, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL18, 6, 1, 0),
@@ -244,7 +243,6 @@ static const struct snd_kcontrol_new es8328_left_mixer_controls[] = {
 static const struct snd_kcontrol_new es8328_right_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left Playback Switch", ES8328_DACCONTROL19, 7, 1, 0),
 	SOC_DAPM_SINGLE("Left Bypass Switch", ES8328_DACCONTROL19, 6, 1, 0),
-	SOC_DAPM_SINGLE("Playback Switch", ES8328_DACCONTROL20, 7, 1, 0),
 	SOC_DAPM_SINGLE("Right Bypass Switch", ES8328_DACCONTROL20, 6, 1, 0),
 };
 
@@ -337,10 +335,10 @@ static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", ES8328_DACPOWER,
 			ES8328_DACPOWER_LDAC_OFF, 1),
 
-	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("Left Mixer", ES8328_DACCONTROL17, 7, 0,
 		&es8328_left_mixer_controls[0],
 		ARRAY_SIZE(es8328_left_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_MIXER("Right Mixer", ES8328_DACCONTROL20, 7, 0,
 		&es8328_right_mixer_controls[0],
 		ARRAY_SIZE(es8328_right_mixer_controls)),
 
@@ -419,19 +417,14 @@ static const struct snd_soc_dapm_route es8328_dapm_routes[] = {
 	{ "Right Line Mux", "PGA", "Right PGA Mux" },
 	{ "Right Line Mux", "Differential", "Differential Mux" },
 
-	{ "Left Out 1", NULL, "Left DAC" },
-	{ "Right Out 1", NULL, "Right DAC" },
-	{ "Left Out 2", NULL, "Left DAC" },
-	{ "Right Out 2", NULL, "Right DAC" },
-
-	{ "Left Mixer", "Playback Switch", "Left DAC" },
+	{ "Left Mixer", NULL, "Left DAC" },
 	{ "Left Mixer", "Left Bypass Switch", "Left Line Mux" },
 	{ "Left Mixer", "Right Playback Switch", "Right DAC" },
 	{ "Left Mixer", "Right Bypass Switch", "Right Line Mux" },
 
 	{ "Right Mixer", "Left Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Left Bypass Switch", "Left Line Mux" },
-	{ "Right Mixer", "Playback Switch", "Right DAC" },
+	{ "Right Mixer", NULL, "Right DAC" },
 	{ "Right Mixer", "Right Bypass Switch", "Right Line Mux" },
 
 	{ "DAC DIG", NULL, "DAC STM" },
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 6fa900302aa8..8ee6f41563ea 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -123,6 +123,8 @@ static int micfil_set_quality(struct fsl_micfil *micfil)
 	case QUALITY_VLOW2:
 		qsel = MICFIL_QSEL_VLOW2_QUALITY;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index d20438cf8fc4..ff743ba0a944 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -453,11 +453,11 @@ static int rockchip_i2s_tdm_set_fmt(struct snd_soc_dai *cpu_dai,
 			break;
 		case SND_SOC_DAIFMT_DSP_A:
 			val = I2S_TXCR_TFS_TDM_PCM;
-			tdm_val = TDM_SHIFT_CTRL(0);
+			tdm_val = TDM_SHIFT_CTRL(2);
 			break;
 		case SND_SOC_DAIFMT_DSP_B:
 			val = I2S_TXCR_TFS_TDM_PCM;
-			tdm_val = TDM_SHIFT_CTRL(2);
+			tdm_val = TDM_SHIFT_CTRL(4);
 			break;
 		default:
 			ret = -EINVAL;
diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 468050467bb3..12e063c29a2a 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -483,6 +483,8 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	sample_space = strm->fifo_sample_size;
 	ssifsr = rz_ssi_reg_readl(ssi, SSIFSR);
 	sample_space -= (ssifsr >> SSIFSR_TDC_SHIFT) & SSIFSR_TDC_MASK;
+	if (sample_space < 0)
+		return -EINVAL;
 
 	/* Only add full frames at a time */
 	while (frames_left && (sample_space >= runtime->channels)) {
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 2839f6b6f09b..eed71369c7af 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1145,7 +1145,7 @@ static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct usbmidi_out_port *port = substream->runtime->private_data;
 
-	cancel_work_sync(&port->ep->work);
+	flush_work(&port->ep->work);
 	return substream_open(substream, 0, 0);
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e08e1b998044..42302c7812c7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1773,6 +1773,7 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x534d, 0x2109): /* MacroSilicon MS2109 */
 		subs->stream_offset_adj = 2;
 		break;
+	case USB_ID(0x2b73, 0x000a): /* Pioneer DJM-900NXS2 */
 	case USB_ID(0x2b73, 0x0013): /* Pioneer DJM-450 */
 		pioneer_djm_set_format_quirk(subs, 0x0082);
 		break;

