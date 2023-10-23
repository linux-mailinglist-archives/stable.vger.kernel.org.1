Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14847D343A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjJWLhu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjJWLhu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:37:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DBAE4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:37:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8B6C433C7;
        Mon, 23 Oct 2023 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061067;
        bh=EHwu5IiuC53e//L7V1CtAdt4cRPA9Unv0HHAa9vuMX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TPxJWZCikl/GXPsIsYlH/sq1qiED62Wugx8hFsz/vq3GLDPzX0rqeyP9Fco8aC5t
         PYxaEQ4GoDNUXeniIeVWEVQy5gqGoVwggpjz+MzNTnB0L7sdPDsNePw+x0ELicOAk2
         ld/d9duG+qr8JW6dWIR9P1x+WCMSRHSm3UZqoA8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 062/137] powerpc/32s: Do kuep_lock() and kuep_unlock() in assembly
Date:   Mon, 23 Oct 2023 12:56:59 +0200
Message-ID: <20231023104823.061280715@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 526d4a4c77aedf1b7df1133e5cced29c70232e6e ]

When interrupt and syscall entries where converted to C, KUEP locking
and unlocking was also converted. It improved performance by unrolling
the loop, and allowed easily implementing boot time deactivation of
KUEP.

However, null_syscall selftest shows that KUEP is still heavy
(361 cycles with KUEP, 212 cycles without).

A way to improve more is to group 'mtsr's together, instead of
repeating 'addi' + 'mtsr' several times.

In order to do that, more registers need to be available. In C, GCC
will always be able to provide the requested number of registers, but
at the cost of saving some data on the stack, which is counter
performant here.

So let's do it in assembly, when we have full control of which
register can be used. It also has the advantage of locking earlier
and unlocking later and it helps GCC generating less tricky code.
The only drawback is to make boot time deactivation less straight
forward and require 'hand' instruction patching.

Group 'mtsr's by 4.

With this change, null_syscall selftest reports 336 cycles. Without
the change it was 361 cycles, that's a 7% reduction.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/115cb279e9b9948dfd93a065e047081c59e3a2a6.1634627931.git.christophe.leroy@csgroup.eu
Stable-dep-of: f0eee815babe ("powerpc/47x: Fix 47x syscall return crash")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/book3s/32/kup.h      | 34 --------
 arch/powerpc/include/asm/book3s/32/mmu-hash.h | 77 ++++++++++++++++++-
 arch/powerpc/include/asm/interrupt.h          |  6 +-
 arch/powerpc/include/asm/kup.h                |  5 --
 arch/powerpc/kernel/entry_32.S                | 31 ++++++++
 arch/powerpc/kernel/head_32.h                 |  6 ++
 arch/powerpc/kernel/head_book3s_32.S          |  4 +
 arch/powerpc/kernel/interrupt.c               |  3 -
 arch/powerpc/mm/book3s32/kuep.c               |  2 -
 9 files changed, 119 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index fb6c39225dd19..e3db5ed4b255e 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -23,40 +23,6 @@ static __always_inline bool kuep_is_disabled(void)
 	return !IS_ENABLED(CONFIG_PPC_KUEP);
 }
 
-static inline void kuep_lock(void)
-{
-	if (kuep_is_disabled())
-		return;
-
-	update_user_segments(mfsr(0) | SR_NX);
-	/*
-	 * This isync() shouldn't be necessary as the kernel is not excepted to
-	 * run any instruction in userspace soon after the update of segments,
-	 * but hash based cores (at least G3) seem to exhibit a random
-	 * behaviour when the 'isync' is not there. 603 cores don't have this
-	 * behaviour so don't do the 'isync' as it saves several CPU cycles.
-	 */
-	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		isync();	/* Context sync required after mtsr() */
-}
-
-static inline void kuep_unlock(void)
-{
-	if (kuep_is_disabled())
-		return;
-
-	update_user_segments(mfsr(0) & ~SR_NX);
-	/*
-	 * This isync() shouldn't be necessary as a 'rfi' will soon be executed
-	 * to return to userspace, but hash based cores (at least G3) seem to
-	 * exhibit a random behaviour when the 'isync' is not there. 603 cores
-	 * don't have this behaviour so don't do the 'isync' as it saves several
-	 * CPU cycles.
-	 */
-	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		isync();	/* Context sync required after mtsr() */
-}
-
 #ifdef CONFIG_PPC_KUAP
 
 #include <linux/sched.h>
diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 94ad7acfd0565..d4bf2a67396be 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -64,7 +64,82 @@ struct ppc_bat {
 #define SR_KP	0x20000000	/* User key */
 #define SR_KS	0x40000000	/* Supervisor key */
 
-#ifndef __ASSEMBLY__
+#ifdef __ASSEMBLY__
+
+#include <asm/asm-offsets.h>
+
+.macro uus_addi sr reg1 reg2 imm
+	.if NUM_USER_SEGMENTS > \sr
+	addi	\reg1,\reg2,\imm
+	.endif
+.endm
+
+.macro uus_mtsr sr reg1
+	.if NUM_USER_SEGMENTS > \sr
+	mtsr	\sr, \reg1
+	.endif
+.endm
+
+/*
+ * This isync() shouldn't be necessary as the kernel is not excepted to run
+ * any instruction in userspace soon after the update of segments and 'rfi'
+ * instruction is used to return to userspace, but hash based cores
+ * (at least G3) seem to exhibit a random behaviour when the 'isync' is not
+ * there. 603 cores don't have this behaviour so don't do the 'isync' as it
+ * saves several CPU cycles.
+ */
+.macro uus_isync
+#ifdef CONFIG_PPC_BOOK3S_604
+BEGIN_MMU_FTR_SECTION
+	isync
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
+#endif
+.endm
+
+.macro update_user_segments_by_4 tmp1 tmp2 tmp3 tmp4
+	uus_addi	1, \tmp2, \tmp1, 0x111
+	uus_addi	2, \tmp3, \tmp1, 0x222
+	uus_addi	3, \tmp4, \tmp1, 0x333
+
+	uus_mtsr	0, \tmp1
+	uus_mtsr	1, \tmp2
+	uus_mtsr	2, \tmp3
+	uus_mtsr	3, \tmp4
+
+	uus_addi	4, \tmp1, \tmp1, 0x444
+	uus_addi	5, \tmp2, \tmp2, 0x444
+	uus_addi	6, \tmp3, \tmp3, 0x444
+	uus_addi	7, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	4, \tmp1
+	uus_mtsr	5, \tmp2
+	uus_mtsr	6, \tmp3
+	uus_mtsr	7, \tmp4
+
+	uus_addi	8, \tmp1, \tmp1, 0x444
+	uus_addi	9, \tmp2, \tmp2, 0x444
+	uus_addi	10, \tmp3, \tmp3, 0x444
+	uus_addi	11, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	8, \tmp1
+	uus_mtsr	9, \tmp2
+	uus_mtsr	10, \tmp3
+	uus_mtsr	11, \tmp4
+
+	uus_addi	12, \tmp1, \tmp1, 0x444
+	uus_addi	13, \tmp2, \tmp2, 0x444
+	uus_addi	14, \tmp3, \tmp3, 0x444
+	uus_addi	15, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	12, \tmp1
+	uus_mtsr	13, \tmp2
+	uus_mtsr	14, \tmp3
+	uus_mtsr	15, \tmp4
+
+	uus_isync
+.endm
+
+#else
 
 /*
  * This macro defines the mapping from contexts to VSIDs (virtual
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index a07960066b5fa..e592e65e7665c 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -139,12 +139,10 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 	if (!arch_irq_disabled_regs(regs))
 		trace_hardirqs_off();
 
-	if (user_mode(regs)) {
-		kuep_lock();
+	if (user_mode(regs))
 		account_cpu_user_entry();
-	} else {
+	else
 		kuap_save_and_lock(regs);
-	}
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 1df763002726a..34ff86e3686ea 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -38,11 +38,6 @@ void setup_kuep(bool disabled);
 static inline void setup_kuep(bool disabled) { }
 #endif /* CONFIG_PPC_KUEP */
 
-#ifndef CONFIG_PPC_BOOK3S_32
-static inline void kuep_lock(void) { }
-static inline void kuep_unlock(void) { }
-#endif
-
 #ifdef CONFIG_PPC_KUAP
 void setup_kuap(bool disabled);
 #else
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index c62dd98159653..0756829b2f7fa 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -73,6 +73,34 @@ prepare_transfer_to_handler:
 _ASM_NOKPROBE_SYMBOL(prepare_transfer_to_handler)
 #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
 
+#if defined(CONFIG_PPC_KUEP) && defined(CONFIG_PPC_BOOK3S_32)
+	.globl	__kuep_lock
+__kuep_lock:
+	mfsr    r9,0
+	rlwinm  r9,r9,0,8,3
+	oris    r9,r9,SR_NX@h
+	update_user_segments_by_4 r9, r10, r11, r12
+	blr
+
+__kuep_unlock:
+	mfsr    r9,0
+	rlwinm  r9,r9,0,8,2
+	update_user_segments_by_4 r9, r10, r11, r12
+	blr
+
+.macro	kuep_lock
+	bl	__kuep_lock
+.endm
+.macro	kuep_unlock
+	bl	__kuep_unlock
+.endm
+#else
+.macro	kuep_lock
+.endm
+.macro	kuep_unlock
+.endm
+#endif
+
 	.globl	transfer_to_syscall
 transfer_to_syscall:
 	stw	r11, GPR1(r1)
@@ -93,6 +121,7 @@ transfer_to_syscall:
 	SAVE_GPRS(3, 8, r1)
 	addi	r2,r10,-THREAD
 	SAVE_NVGPRS(r1)
+	kuep_lock
 
 	/* Calling convention has r9 = orig r0, r10 = regs */
 	addi	r10,r1,STACK_FRAME_OVERHEAD
@@ -109,6 +138,7 @@ ret_from_syscall:
 	cmplwi	cr0,r5,0
 	bne-	2f
 #endif /* CONFIG_PPC_47x */
+	kuep_unlock
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
 	mtlr	r4
@@ -272,6 +302,7 @@ interrupt_return:
 	beq	.Lkernel_interrupt_return
 	bl	interrupt_exit_user_prepare
 	cmpwi	r3,0
+	kuep_unlock
 	bne-	.Lrestore_nvgprs
 
 .Lfast_user_interrupt_return:
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 261c79bdbe53f..c3286260a7d1c 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -135,6 +135,12 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 	andi.	r12,r9,MSR_PR
 	bne	777f
 	bl	prepare_transfer_to_handler
+#ifdef CONFIG_PPC_KUEP
+	b	778f
+777:
+	bl	__kuep_lock
+778:
+#endif
 777:
 #endif
 .endm
diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 68e5c0a7e99d1..fa84744d6b248 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -931,7 +931,11 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 _GLOBAL(load_segment_registers)
 	li	r0, NUM_USER_SEGMENTS /* load up user segment register values */
 	mtctr	r0		/* for context 0 */
+#ifdef CONFIG_PPC_KUEP
+	lis	r3, SR_NX@h	/* Kp = 0, Ks = 0, VSID = 0 */
+#else
 	li	r3, 0		/* Kp = 0, Ks = 0, VSID = 0 */
+#endif
 	li	r4, 0
 3:	mtsrin	r3, r4
 	addi	r3, r3, 0x111	/* increment VSID */
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index e93f67c3af76b..c53725a598e5b 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -83,8 +83,6 @@ notrace long system_call_exception(long r3, long r4, long r5,
 {
 	syscall_fn f;
 
-	kuep_lock();
-
 	regs->orig_gpr3 = r3;
 
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
@@ -408,7 +406,6 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
-	kuep_unlock();
 
 	return ret;
 }
diff --git a/arch/powerpc/mm/book3s32/kuep.c b/arch/powerpc/mm/book3s32/kuep.c
index 8474edce3df9a..bac1420d028b6 100644
--- a/arch/powerpc/mm/book3s32/kuep.c
+++ b/arch/powerpc/mm/book3s32/kuep.c
@@ -5,8 +5,6 @@
 
 void setup_kuep(bool disabled)
 {
-	kuep_lock();
-
 	if (smp_processor_id() != boot_cpuid)
 		return;
 
-- 
2.40.1



