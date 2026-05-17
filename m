Return-Path: <stable+bounces-249070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPZSIM2ICWrteQQAu9opvQ
	(envelope-from <stable+bounces-249070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 11:22:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D1D560399
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F12300EAB4
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FB337B99;
	Sun, 17 May 2026 09:19:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5E305E32;
	Sun, 17 May 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779009565; cv=none; b=QpI0PhSDpV/n1uMVum1r+iMfV1GucwEzNYr93ayOMo2E17SDAMyB2+evzz3tn5BhFHThQWOdUeQ3jWQxxepK/hD0FuE1yE0nl3iDQNuj9w65m1z/JZWiRAKAQtr8Ys9OqVcI3mXeRsb0qiTIKIquYT5RjYbLltZmbtwMeje+zls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779009565; c=relaxed/simple;
	bh=XdVTY/9XFgbzjBF6D5pa0+i20r/PfCzmDqoFSTWiFDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vD6vGEeYeWM3uza5Egk7wr47UVrcuGbRCMw6OMLAgpgoVwoEK+AT2k9QGU5vNSWhPvqzQAm63GFoQZHDJXA0Kxyp0ZHU1hXNdwCVZW10AhBtJg89FVWVAY7nbawB3sF7ZjEgJrQ/cwr+eSn+XMLW3xRCNQiF7CjfvxV1H/iWkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.59])
	by gateway (Coremail) with SMTP id _____8Bxt3gQiAlqRIUKAA--.6876S3;
	Sun, 17 May 2026 17:19:13 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.59])
	by front1 (Coremail) with SMTP id qMiowJAx18AHiAlqJUGFAA--.54367S2;
	Sun, 17 May 2026 17:19:07 +0800 (CST)
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
Subject: [PATCH V2 for 6.12] LoongArch: KVM: Compile switch.S directly into the kernel
Date: Sun, 17 May 2026 17:18:55 +0800
Message-ID: <20260517091855.1023223-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx18AHiAlqJUGFAA--.54367S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFy5XFyrXFyUJFy8Zr15WrX_yoWfXrW8pa
	sxArs5tF48GFn3XryDJ3WDXr98Xw4vgr1I9F12yayrCr129ry5ZF1vyrWqqFy0kw4kJFyF
	vFyrJwnavFyUA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2G-eUUUUU
X-Rspamd-Queue-Id: C8D1D560399
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249070-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,loongson.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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
V2: Adjust context for 6.12.89

 arch/loongarch/Kbuild                       |  2 +-
 arch/loongarch/include/asm/asm-prototypes.h | 20 ++++++++++++
 arch/loongarch/include/asm/kvm_host.h       |  3 --
 arch/loongarch/kvm/Makefile                 |  3 +-
 arch/loongarch/kvm/main.c                   | 35 ++-------------------
 arch/loongarch/kvm/switch.S                 | 19 ++++++++---
 6 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
index bfa21465d83a..604adaff2623 100644
--- a/arch/loongarch/Kbuild
+++ b/arch/loongarch/Kbuild
@@ -3,7 +3,7 @@ obj-y += mm/
 obj-y += net/
 obj-y += vdso/
 
-obj-$(CONFIG_KVM) += kvm/
+obj-$(subst m,y,$(CONFIG_KVM)) += kvm/
 obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
 
 # for cleaning
diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch/include/asm/asm-prototypes.h
index 51f224bcfc65..50c66b2a817a 100644
--- a/arch/loongarch/include/asm/asm-prototypes.h
+++ b/arch/loongarch/include/asm/asm-prototypes.h
@@ -12,3 +12,23 @@ __int128_t __ashlti3(__int128_t a, int b);
 __int128_t __ashrti3(__int128_t a, int b);
 __int128_t __lshrti3(__int128_t a, int b);
 #endif
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
index 4955e7c7d4c3..de141b3af23d 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -87,7 +87,6 @@ struct kvm_context {
 struct kvm_world_switch {
 	int (*exc_entry)(void);
 	int (*enter_guest)(struct kvm_run *run, struct kvm_vcpu *vcpu);
-	unsigned long page_order;
 };
 
 #define MAX_PGTABLE_LEVELS	4
@@ -360,8 +359,6 @@ void kvm_exc_entry(void);
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
-	int cpu, order;
-	void *addr;
+	int cpu;
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
 }
diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
index 9eaad5dbed91..f11fe06866c8 100644
--- a/arch/loongarch/kvm/switch.S
+++ b/arch/loongarch/kvm/switch.S
@@ -7,6 +7,7 @@
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/loongarch.h>
+#include <asm/page.h>
 #include <asm/regdef.h>
 #include <asm/unwind_hints.h>
 
@@ -100,8 +101,13 @@
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
 	UNWIND_HINT_END_OF_STACK
@@ -190,8 +196,8 @@ ret_to_host:
 	kvm_restore_host_gpr    a2
 	jr      ra
 
-SYM_INNER_LABEL(kvm_exc_entry_end, SYM_L_LOCAL)
 SYM_CODE_END(kvm_exc_entry)
+EXPORT_SYMBOL_GPL(kvm_exc_entry)
 
 /*
  * int kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu)
@@ -215,8 +221,8 @@ SYM_FUNC_START(kvm_enter_guest)
 	/* Save kvm_vcpu to kscratch */
 	csrwr	a1, KVM_VCPU_KS
 	kvm_switch_to_guest
-SYM_INNER_LABEL(kvm_enter_guest_end, SYM_L_LOCAL)
 SYM_FUNC_END(kvm_enter_guest)
+EXPORT_SYMBOL_GPL(kvm_enter_guest)
 
 SYM_FUNC_START(kvm_save_fpu)
 	fpu_save_csr	a0 t1
@@ -224,6 +230,7 @@ SYM_FUNC_START(kvm_save_fpu)
 	fpu_save_cc	a0 t1 t2
 	jr              ra
 SYM_FUNC_END(kvm_save_fpu)
+EXPORT_SYMBOL_GPL(kvm_save_fpu)
 
 SYM_FUNC_START(kvm_restore_fpu)
 	fpu_restore_double a0 t1
@@ -231,6 +238,7 @@ SYM_FUNC_START(kvm_restore_fpu)
 	fpu_restore_cc	   a0 t1 t2
 	jr                 ra
 SYM_FUNC_END(kvm_restore_fpu)
+EXPORT_SYMBOL_GPL(kvm_restore_fpu)
 
 #ifdef CONFIG_CPU_HAS_LSX
 SYM_FUNC_START(kvm_save_lsx)
@@ -239,6 +247,7 @@ SYM_FUNC_START(kvm_save_lsx)
 	lsx_save_data   a0 t1
 	jr              ra
 SYM_FUNC_END(kvm_save_lsx)
+EXPORT_SYMBOL_GPL(kvm_save_lsx)
 
 SYM_FUNC_START(kvm_restore_lsx)
 	lsx_restore_data a0 t1
@@ -246,6 +255,7 @@ SYM_FUNC_START(kvm_restore_lsx)
 	fpu_restore_csr  a0 t1 t2
 	jr               ra
 SYM_FUNC_END(kvm_restore_lsx)
+EXPORT_SYMBOL_GPL(kvm_restore_lsx)
 #endif
 
 #ifdef CONFIG_CPU_HAS_LASX
@@ -255,6 +265,7 @@ SYM_FUNC_START(kvm_save_lasx)
 	lasx_save_data  a0 t1
 	jr              ra
 SYM_FUNC_END(kvm_save_lasx)
+EXPORT_SYMBOL_GPL(kvm_save_lasx)
 
 SYM_FUNC_START(kvm_restore_lasx)
 	lasx_restore_data a0 t1
@@ -262,10 +273,8 @@ SYM_FUNC_START(kvm_restore_lasx)
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


