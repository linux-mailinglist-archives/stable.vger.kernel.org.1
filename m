Return-Path: <stable+bounces-246724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGJCIkjsA2ruAgIAu9opvQ
	(envelope-from <stable+bounces-246724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:13:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0152CACB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52843020D4C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E80F3921FB;
	Wed, 13 May 2026 03:13:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81383314D9;
	Wed, 13 May 2026 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641986; cv=none; b=nscUtMp3nlnV5hJLPITZzoBle67wl+0xX3zOXMQFa8HajQKEuOTt8T28N1zHlb+hTbi1hAcMd2TP1eLW7it8sxDYU1C4jid2PMaGcZ91rECiHAZsa9UGE/lGLewOcxA9Yd9eMKFU5t3sSN1ijeouNHrIXzzSWk+90r93tc9gpLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641986; c=relaxed/simple;
	bh=Y4Yrac6ZPe/TgKOOj4TCF7k9yx2DhqGjFqPUAK0TEUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ecRvBbnYrsiArhPFRgrEtBjEmcipStsD28QMEcBTM26U6CAjx49hv3x9QEqqAdWGP3jNfjGclXHYso53R0TlBoA+ojVxcZuH1rrzope8wogQqnOziVl1Iu4kJSNtUk1Wum1Yw630vAkQHbDB2PLdmg1T1BvkeoJtrwJz7eouajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.59])
	by gateway (Coremail) with SMTP id _____8DxFOg87ANqjl4JAA--.22618S3;
	Wed, 13 May 2026 11:13:00 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.59])
	by front1 (Coremail) with SMTP id qMiowJAxlsA37ANq7M6AAA--.48424S2;
	Wed, 13 May 2026 11:12:59 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>
Cc: Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xianglai Li <lixianglai@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH for 6.18] LoongArch: KVM: Compile switch.S directly into the kernel
Date: Wed, 13 May 2026 11:12:49 +0800
Message-ID: <20260513031249.2122316-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxlsA37ANq7M6AAA--.48424S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF45Ar48ZrW3JF17Cr18CrX_yoWfXF13pa
	sxArs5tF4rGFn3XryDJ3WDXr98Xw4vgr1I9Fy2y3yrCr129ry5ZF1ktrWDXFy0kw4kJF4F
	vFyrXwnavFyDJabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wNVDUUUUU==
X-Rspamd-Queue-Id: E0D0152CACB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246724-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.929];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,loongson.cn:mid]
X-Rspamd-Action: no action

From: Xianglai Li <lixianglai@loongson.cn>

commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.

If we directly compile the switch.S file into the kernel, the address of
the kvm_exc_entry function will definitely be within the DMW memory area.
Therefore, we will no longer need to perform a copy relocation of the
kvm_exc_entry.

So this patch compiles switch.S directly into the kernel, and then remove
the copy relocation execution logic for the kvm_exc_entry function.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kbuild                       |  2 +-
 arch/loongarch/include/asm/asm-prototypes.h | 20 ++++++++++++
 arch/loongarch/include/asm/kvm_host.h       |  3 --
 arch/loongarch/kvm/Makefile                 |  3 +-
 arch/loongarch/kvm/main.c                   | 35 ++-------------------
 arch/loongarch/kvm/switch.S                 | 20 +++++++++---
 6 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
index beb8499dd8ed..1c7a0dbe5e72 100644
--- a/arch/loongarch/Kbuild
+++ b/arch/loongarch/Kbuild
@@ -3,7 +3,7 @@ obj-y += mm/
 obj-y += net/
 obj-y += vdso/
 
-obj-$(CONFIG_KVM) += kvm/
+obj-$(subst m,y,$(CONFIG_KVM)) += kvm/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch/include/asm/asm-prototypes.h
index 704066b4f736..de0c17f3f49c 100644
--- a/arch/loongarch/include/asm/asm-prototypes.h
+++ b/arch/loongarch/include/asm/asm-prototypes.h
@@ -20,3 +20,23 @@ asmlinkage void noinstr __no_stack_protector ret_from_kernel_thread(struct task_
 								    struct pt_regs *regs,
 								    int (*fn)(void *),
 								    void *fn_arg);
+
+struct kvm_run;
+struct kvm_vcpu;
+struct loongarch_fpu;
+
+void kvm_exc_entry(void);
+int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
+
+void kvm_save_fpu(struct loongarch_fpu *fpu);
+void kvm_restore_fpu(struct loongarch_fpu *fpu);
+
+#ifdef CONFIG_CPU_HAS_LSX
+void kvm_save_lsx(struct loongarch_fpu *fpu);
+void kvm_restore_lsx(struct loongarch_fpu *fpu);
+#endif
+
+#ifdef CONFIG_CPU_HAS_LASX
+void kvm_save_lasx(struct loongarch_fpu *fpu);
+void kvm_restore_lasx(struct loongarch_fpu *fpu);
+#endif
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 130cedbb6b39..776bc487a705 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -87,7 +87,6 @@ struct kvm_context {
 struct kvm_world_switch {
 	int (*exc_entry)(void);
 	int (*enter_guest)(struct kvm_run *run, struct kvm_vcpu *vcpu);
-	unsigned long page_order;
 };
 
 #define MAX_PGTABLE_LEVELS	4
@@ -359,8 +358,6 @@ void kvm_exc_entry(void);
 int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
 
 extern unsigned long vpid_mask;
-extern const unsigned long kvm_exception_size;
-extern const unsigned long kvm_enter_guest_size;
 extern struct kvm_world_switch *kvm_loongarch_ops;
 
 #define SW_GCSR		(1 << 0)
diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
index ae469edec99c..a4d044da3aa7 100644
--- a/arch/loongarch/kvm/Makefile
+++ b/arch/loongarch/kvm/Makefile
@@ -7,11 +7,12 @@ include $(srctree)/virt/kvm/Makefile.kvm
 
 obj-$(CONFIG_KVM) += kvm.o
 
+obj-y += switch.o
+
 kvm-y += exit.o
 kvm-y += interrupt.o
 kvm-y += main.o
 kvm-y += mmu.o
-kvm-y += switch.o
 kvm-y += timer.o
 kvm-y += tlb.o
 kvm-y += vcpu.o
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index a75c9b9e53ff..24553fe34979 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -348,8 +348,7 @@ void kvm_arch_disable_virtualization_cpu(void)
 
 static int kvm_loongarch_env_init(void)
 {
-	int cpu, order, ret;
-	void *addr;
+	int cpu, ret;
 	struct kvm_context *context;
 
 	vmcs = alloc_percpu(struct kvm_context);
@@ -365,30 +364,8 @@ static int kvm_loongarch_env_init(void)
 		return -ENOMEM;
 	}
 
-	/*
-	 * PGD register is shared between root kernel and kvm hypervisor.
-	 * So world switch entry should be in DMW area rather than TLB area
-	 * to avoid page fault reenter.
-	 *
-	 * In future if hardware pagetable walking is supported, we won't
-	 * need to copy world switch code to DMW area.
-	 */
-	order = get_order(kvm_exception_size + kvm_enter_guest_size);
-	addr = (void *)__get_free_pages(GFP_KERNEL, order);
-	if (!addr) {
-		free_percpu(vmcs);
-		vmcs = NULL;
-		kfree(kvm_loongarch_ops);
-		kvm_loongarch_ops = NULL;
-		return -ENOMEM;
-	}
-
-	memcpy(addr, kvm_exc_entry, kvm_exception_size);
-	memcpy(addr + kvm_exception_size, kvm_enter_guest, kvm_enter_guest_size);
-	flush_icache_range((unsigned long)addr, (unsigned long)addr + kvm_exception_size + kvm_enter_guest_size);
-	kvm_loongarch_ops->exc_entry = addr;
-	kvm_loongarch_ops->enter_guest = addr + kvm_exception_size;
-	kvm_loongarch_ops->page_order = order;
+	kvm_loongarch_ops->exc_entry = (void *)kvm_exc_entry;
+	kvm_loongarch_ops->enter_guest = (void *)kvm_enter_guest;
 
 	vpid_mask = read_csr_gstat();
 	vpid_mask = (vpid_mask & CSR_GSTAT_GIDBIT) >> CSR_GSTAT_GIDBIT_SHIFT;
@@ -428,16 +405,10 @@ static int kvm_loongarch_env_init(void)
 
 static void kvm_loongarch_env_exit(void)
 {
-	unsigned long addr;
-
 	if (vmcs)
 		free_percpu(vmcs);
 
 	if (kvm_loongarch_ops) {
-		if (kvm_loongarch_ops->exc_entry) {
-			addr = (unsigned long)kvm_loongarch_ops->exc_entry;
-			free_pages(addr, kvm_loongarch_ops->page_order);
-		}
 		kfree(kvm_loongarch_ops);
 	}
 
diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
index f1768b7a6194..6fa5928b3ca6 100644
--- a/arch/loongarch/kvm/switch.S
+++ b/arch/loongarch/kvm/switch.S
@@ -4,9 +4,11 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/kvm_types.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/loongarch.h>
+#include <asm/page.h>
 #include <asm/regdef.h>
 #include <asm/unwind_hints.h>
 
@@ -100,8 +102,13 @@
 	 *  -        is still in guest mode, such as pgd table/vmid registers etc,
 	 *  -        will fix with hw page walk enabled in future
 	 * load kvm_vcpu from reserved CSR KVM_VCPU_KS, and save a2 to KVM_TEMP_KS
+	 *
+	 * PGD register is shared between root kernel and kvm hypervisor.
+	 * So world switch entry should be in DMW area rather than TLB area
+	 * to avoid page fault re-enter.
 	 */
 	.text
+	.p2align PAGE_SHIFT
 	.cfi_sections	.debug_frame
 SYM_CODE_START(kvm_exc_entry)
 	UNWIND_HINT_UNDEFINED
@@ -190,8 +197,8 @@ ret_to_host:
 	kvm_restore_host_gpr    a2
 	jr      ra
 
-SYM_INNER_LABEL(kvm_exc_entry_end, SYM_L_LOCAL)
 SYM_CODE_END(kvm_exc_entry)
+EXPORT_SYMBOL_GPL(kvm_exc_entry)
 
 /*
  * int kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu)
@@ -215,8 +222,8 @@ SYM_FUNC_START(kvm_enter_guest)
 	/* Save kvm_vcpu to kscratch */
 	csrwr	a1, KVM_VCPU_KS
 	kvm_switch_to_guest
-SYM_INNER_LABEL(kvm_enter_guest_end, SYM_L_LOCAL)
 SYM_FUNC_END(kvm_enter_guest)
+EXPORT_SYMBOL_GPL(kvm_enter_guest)
 
 SYM_FUNC_START(kvm_save_fpu)
 	fpu_save_csr	a0 t1
@@ -224,6 +231,7 @@ SYM_FUNC_START(kvm_save_fpu)
 	fpu_save_cc	a0 t1 t2
 	jr              ra
 SYM_FUNC_END(kvm_save_fpu)
+EXPORT_SYMBOL_GPL(kvm_save_fpu)
 
 SYM_FUNC_START(kvm_restore_fpu)
 	fpu_restore_double a0 t1
@@ -231,6 +239,7 @@ SYM_FUNC_START(kvm_restore_fpu)
 	fpu_restore_cc	   a0 t1 t2
 	jr                 ra
 SYM_FUNC_END(kvm_restore_fpu)
+EXPORT_SYMBOL_GPL(kvm_restore_fpu)
 
 #ifdef CONFIG_CPU_HAS_LSX
 SYM_FUNC_START(kvm_save_lsx)
@@ -239,6 +248,7 @@ SYM_FUNC_START(kvm_save_lsx)
 	lsx_save_data   a0 t1
 	jr              ra
 SYM_FUNC_END(kvm_save_lsx)
+EXPORT_SYMBOL_GPL(kvm_save_lsx)
 
 SYM_FUNC_START(kvm_restore_lsx)
 	lsx_restore_data a0 t1
@@ -246,6 +256,7 @@ SYM_FUNC_START(kvm_restore_lsx)
 	fpu_restore_csr  a0 t1 t2
 	jr               ra
 SYM_FUNC_END(kvm_restore_lsx)
+EXPORT_SYMBOL_GPL(kvm_restore_lsx)
 #endif
 
 #ifdef CONFIG_CPU_HAS_LASX
@@ -255,6 +266,7 @@ SYM_FUNC_START(kvm_save_lasx)
 	lasx_save_data  a0 t1
 	jr              ra
 SYM_FUNC_END(kvm_save_lasx)
+EXPORT_SYMBOL_GPL(kvm_save_lasx)
 
 SYM_FUNC_START(kvm_restore_lasx)
 	lasx_restore_data a0 t1
@@ -262,10 +274,8 @@ SYM_FUNC_START(kvm_restore_lasx)
 	fpu_restore_csr   a0 t1 t2
 	jr                ra
 SYM_FUNC_END(kvm_restore_lasx)
+EXPORT_SYMBOL_GPL(kvm_restore_lasx)
 #endif
-	.section ".rodata"
-SYM_DATA(kvm_exception_size, .quad kvm_exc_entry_end - kvm_exc_entry)
-SYM_DATA(kvm_enter_guest_size, .quad kvm_enter_guest_end - kvm_enter_guest)
 
 #ifdef CONFIG_CPU_HAS_LBT
 STACK_FRAME_NON_STANDARD kvm_restore_fpu
-- 
2.52.0


