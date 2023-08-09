Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591C8775B29
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjHILO4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjHILO4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52A10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F93062457
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF20BC433C7;
        Wed,  9 Aug 2023 11:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579694;
        bh=CscIbcQwl/dg5WtAjm6CyfoUPtpxM5xGWdLTKUK9pWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7qU6eRpjd/KqTt6zOjFkEfh8ar5E58SZbL5oM851EZPgLWkSpHvDjJrCANuwtQp4
         ESX0g//1h62/p2gxw5U0R+JuzctkwT1LQCF6QuQ7ixUNL9jAZ3zEcUmVByUoS9ffCc
         9BJpKDFdhZBbhYDUvgfQ3wiWOZ41wVEM1P0ZciPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/323] ARCv2: entry: rewrite to enable use of double load/stores LDD/STD
Date:   Wed,  9 Aug 2023 12:38:41 +0200
Message-ID: <20230809103701.917012417@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

[ Upstream commit a4880801a72ecc2dcdfa432f81a754f3e7438567 ]

 - the motivation was to be remove blatent copy-paste due to hasty support
   of CONFIG_ARC_IRQ_NO_AUTOSAVE support

 - but with refactoring we could use LDD/STD to greatly optimize the code

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Stable-dep-of: 92e2921eeafd ("ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/entry-arcv2.h | 297 ++++++++++++++---------------
 arch/arc/include/asm/linkage.h     |  18 ++
 arch/arc/kernel/asm-offsets.c      |   7 +
 arch/arc/kernel/entry-arcv2.S      |   4 +-
 4 files changed, 167 insertions(+), 159 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index beaf655666cbd..0733752ce7fe8 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -46,7 +46,8 @@
  */
 
 /*------------------------------------------------------------------------*/
-.macro INTERRUPT_PROLOGUE	called_from
+.macro INTERRUPT_PROLOGUE
+
 	; (A) Before jumping to Interrupt Vector, hardware micro-ops did following:
 	;   1. SP auto-switched to kernel mode stack
 	;   2. STATUS32.Z flag set if in U mode at time of interrupt (U:1,K:0)
@@ -57,39 +58,87 @@
 	; (B) Manually saved some regs: r12,r25,r30, sp,fp,gp, ACCL pair
 
 #ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
-.ifnc \called_from, exception
-	st.as	r9, [sp, -10]	; save r9 in it's final stack slot
-	sub	sp, sp, 12	; skip JLI, LDI, EI
-
-	PUSH	lp_count
-	PUSHAX	lp_start
-	PUSHAX	lp_end
-	PUSH	blink
-
-	PUSH	r11
-	PUSH	r10
-
-	sub	sp, sp, 4	; skip r9
-
-	PUSH	r8
-	PUSH	r7
-	PUSH	r6
-	PUSH	r5
-	PUSH	r4
-	PUSH	r3
-	PUSH	r2
-	PUSH	r1
-	PUSH	r0
-.endif
-#endif
+	; carve pt_regs on stack (case #3), PC/STAT32 already on stack
+	sub	sp, sp, SZ_PT_REGS - 8
 
-#ifdef CONFIG_ARC_HAS_ACCL_REGS
-	PUSH	r59
-	PUSH	r58
+	__SAVE_REGFILE_HARD
+#else
+	; carve pt_regs on stack (case #4), which grew partially already
+	sub	sp, sp, PT_r0
 #endif
 
-	PUSH	r30
-	PUSH	r12
+	__SAVE_REGFILE_SOFT
+.endm
+
+/*------------------------------------------------------------------------*/
+.macro EXCEPTION_PROLOGUE
+
+	; (A) Before jumping to Exception Vector, hardware micro-ops did following:
+	;   1. SP auto-switched to kernel mode stack
+	;   2. STATUS32.Z flag set if in U mode at time of exception (U:1,K:0)
+	;
+	; (B) Manually save the complete reg file below
+
+	sub	sp, sp, SZ_PT_REGS	; carve pt_regs
+
+	; _HARD saves r10 clobbered by _SOFT as scratch hence comes first
+
+	__SAVE_REGFILE_HARD
+	__SAVE_REGFILE_SOFT
+
+	st	r0, [sp]	; orig_r0
+
+	lr	r10, [eret]
+	lr	r11, [erstatus]
+	ST2	r10, r11, PT_ret
+
+	lr	r10, [ecr]
+	lr	r11, [erbta]
+	ST2	r10, r11, PT_event
+	mov	r9, r10
+
+	; OUTPUT: r9 has ECR
+.endm
+
+/*------------------------------------------------------------------------
+ * This macro saves the registers manually which would normally be autosaved
+ * by hardware on taken interrupts. It is used by
+ *   - exception handlers (which don't have autosave)
+ *   - interrupt autosave disabled due to CONFIG_ARC_IRQ_NO_AUTOSAVE
+ */
+.macro __SAVE_REGFILE_HARD
+
+	ST2	r0,  r1,  PT_r0
+	ST2	r2,  r3,  PT_r2
+	ST2	r4,  r5,  PT_r4
+	ST2	r6,  r7,  PT_r6
+	ST2	r8,  r9,  PT_r8
+	ST2	r10, r11, PT_r10
+
+	st	blink, [sp, PT_blink]
+
+	lr	r10, [lp_end]
+	lr	r11, [lp_start]
+	ST2	r10, r11, PT_lpe
+
+	st	lp_count, [sp, PT_lpc]
+
+	; skip JLI, LDI, EI for now
+.endm
+
+/*------------------------------------------------------------------------
+ * This macros saves a bunch of other registers which can't be autosaved for
+ * various reasons:
+ *   - r12: the last caller saved scratch reg since hardware saves in pairs so r0-r11
+ *   - r30: free reg, used by gcc as scratch
+ *   - ACCL/ACCH pair when they exist
+ */
+.macro __SAVE_REGFILE_SOFT
+
+	ST2	gp, fp, PT_r26		; gp (r26), fp (r27)
+
+	st	r12, [sp, PT_sp + 4]
+	st	r30, [sp, PT_sp + 8]
 
 	; Saving pt_regs->sp correctly requires some extra work due to the way
 	; Auto stack switch works
@@ -100,46 +149,32 @@
 	; 2. Upon entry SP is always saved (for any inspection, unwinding etc),
 	;    but on return, restored only if U mode
 
-	lr	r9, [AUX_USER_SP]			; U mode SP
+	lr	r10, [AUX_USER_SP]	; U mode SP
 
-	mov.nz	r9, sp
-	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4		; K mode SP
+	; ISA requires ADD.nz to have same dest and src reg operands
+	mov.nz	r10, sp
+	add.nz	r10, r10, SZ_PT_REGS	; K mode SP
 
-	PUSH	r9					; SP (pt_regs->sp)
-
-	PUSH	fp
-	PUSH	gp
+	st	r10, [sp, PT_sp]	; SP (pt_regs->sp)
 
 #ifdef CONFIG_ARC_CURR_IN_REG
-	PUSH	r25			; user_r25
+	st	r25, [sp, PT_user_r25]
 	GET_CURR_TASK_ON_CPU	r25
-#else
-	sub	sp, sp, 4
 #endif
 
-.ifnc \called_from, exception
-	sub	sp, sp, 12	; BTA/ECR/orig_r0 placeholder per pt_regs
-.endif
+#ifdef CONFIG_ARC_HAS_ACCL_REGS
+	ST2	r58, r59, PT_sp + 12
+#endif
 
 .endm
 
 /*------------------------------------------------------------------------*/
-.macro INTERRUPT_EPILOGUE	called_from
+.macro __RESTORE_REGFILE_SOFT
 
-	; INPUT: r0 has STAT32 of calling context
-	; INPUT: Z flag set if returning to K mode
-.ifnc \called_from, exception
-	add	sp, sp, 12	; skip BTA/ECR/orig_r0 placeholderss
-.endif
-
-#ifdef CONFIG_ARC_CURR_IN_REG
-	POP	r25
-#else
-	add	sp, sp, 4
-#endif
+	LD2	gp, fp, PT_r26		; gp (r26), fp (r27)
 
-	POP	gp
-	POP	fp
+	ld	r12, [sp, PT_sp + 4]
+	ld	r30, [sp, PT_sp + 8]
 
 	; Restore SP (into AUX_USER_SP) only if returning to U mode
 	;  - for K mode, it will be implicitly restored as stack is unwound
@@ -147,129 +182,77 @@
 	;    but that doesn't really matter
 	bz	1f
 
-	POPAX	AUX_USER_SP
+	ld	r10, [sp, PT_sp]	; SP (pt_regs->sp)
+	sr	r10, [AUX_USER_SP]
 1:
-	POP	r12
-	POP	r30
 
-#ifdef CONFIG_ARC_HAS_ACCL_REGS
-	POP	r58
-	POP	r59
+#ifdef CONFIG_ARC_CURR_IN_REG
+	ld	r25, [sp, PT_user_r25]
 #endif
 
-#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
-.ifnc \called_from, exception
-	POP	r0
-	POP	r1
-	POP	r2
-	POP	r3
-	POP	r4
-	POP	r5
-	POP	r6
-	POP	r7
-	POP	r8
-	POP	r9
-	POP	r10
-	POP	r11
-
-	POP	blink
-	POPAX	lp_end
-	POPAX	lp_start
-
-	POP	r9
-	mov	lp_count, r9
-
-	add	sp, sp, 12	; skip JLI, LDI, EI
-	ld.as	r9, [sp, -10]	; reload r9 which got clobbered
-.endif
+#ifdef CONFIG_ARC_HAS_ACCL_REGS
+	LD2	r58, r59, PT_sp + 12
 #endif
-
 .endm
 
 /*------------------------------------------------------------------------*/
-.macro EXCEPTION_PROLOGUE
+.macro __RESTORE_REGFILE_HARD
 
-	; (A) Before jumping to Exception Vector, hardware micro-ops did following:
-	;   1. SP auto-switched to kernel mode stack
-	;   2. STATUS32.Z flag set if in U mode at time of exception (U:1,K:0)
-	;
-	; (B) Manually save the complete reg file below
+	ld	blink, [sp, PT_blink]
 
-	PUSH	r9		; freeup a register: slot of erstatus
+	LD2	r10, r11, PT_lpe
+	sr	r10, [lp_end]
+	sr	r11, [lp_start]
 
-	PUSHAX	eret
-	sub	sp, sp, 12	; skip JLI, LDI, EI
-	PUSH	lp_count
-	PUSHAX	lp_start
-	PUSHAX	lp_end
-	PUSH	blink
+	ld	r10, [sp, PT_lpc]	; lp_count can't be target of LD
+	mov	lp_count, r10
 
-	PUSH	r11
-	PUSH	r10
+	LD2	r0,  r1,  PT_r0
+	LD2	r2,  r3,  PT_r2
+	LD2	r4,  r5,  PT_r4
+	LD2	r6,  r7,  PT_r6
+	LD2	r8,  r9,  PT_r8
+	LD2	r10, r11, PT_r10
+.endm
 
-	ld.as	r9,  [sp, 10]	; load stashed r9 (status32 stack slot)
-	lr	r10, [erstatus]
-	st.as	r10, [sp, 10]	; save status32 at it's right stack slot
 
-	PUSH	r9
-	PUSH	r8
-	PUSH	r7
-	PUSH	r6
-	PUSH	r5
-	PUSH	r4
-	PUSH	r3
-	PUSH	r2
-	PUSH	r1
-	PUSH	r0
+/*------------------------------------------------------------------------*/
+.macro INTERRUPT_EPILOGUE
 
-	; -- for interrupts, regs above are auto-saved by h/w in that order --
-	; Now do what ISR prologue does (manually save r12, sp, fp, gp, r25)
+	; INPUT: r0 has STAT32 of calling context
+	; INPUT: Z flag set if returning to K mode
 
-	INTERRUPT_PROLOGUE  exception
+	; _SOFT clobbers r10 restored by _HARD hence the order
 
-	PUSHAX	erbta
-	PUSHAX	ecr		; r9 contains ECR, expected by EV_Trap
+	__RESTORE_REGFILE_SOFT
+
+#ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
+	__RESTORE_REGFILE_HARD
+	add	sp, sp, SZ_PT_REGS - 8
+#else
+	add	sp, sp, PT_r0
+#endif
 
-	PUSH	r0		; orig_r0
-	; OUTPUT: r9 has ECR
 .endm
 
 /*------------------------------------------------------------------------*/
 .macro EXCEPTION_EPILOGUE
 
 	; INPUT: r0 has STAT32 of calling context
-	btst   r0, STATUS_U_BIT	; Z flag set if K, used in INTERRUPT_EPILOGUE
-
-	add	sp, sp, 8	; orig_r0/ECR don't need restoring
-	POPAX	erbta
-
-	INTERRUPT_EPILOGUE  exception
-
-	POP	r0
-	POP	r1
-	POP	r2
-	POP	r3
-	POP	r4
-	POP	r5
-	POP	r6
-	POP	r7
-	POP	r8
-	POP	r9
-	POP	r10
-	POP	r11
-
-	POP	blink
-	POPAX	lp_end
-	POPAX	lp_start
-
-	POP	r9
-	mov	lp_count, r9
-
-	add	sp, sp, 12	; skip JLI, LDI, EI
-	POPAX	eret
-	POPAX	erstatus
-
-	ld.as	r9, [sp, -12]	; reload r9 which got clobbered
+
+	btst	r0, STATUS_U_BIT	; Z flag set if K, used in restoring SP
+
+	ld	r10, [sp, PT_event + 4]
+	sr	r10, [erbta]
+
+	LD2	r10, r11, PT_ret
+	sr	r10, [eret]
+	sr	r11, [erstatus]
+
+	__RESTORE_REGFILE_SOFT
+	__RESTORE_REGFILE_HARD
+
+	add	sp, sp, SZ_PT_REGS
 .endm
 
 .macro FAKE_RET_FROM_EXCPN
diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index 07c8e1a6c56e2..f3d29d4840d58 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -13,6 +13,24 @@
 
 #ifdef __ASSEMBLY__
 
+.macro ST2 e, o, off
+#ifdef CONFIG_ARC_HAS_LL64
+	std	\e, [sp, \off]
+#else
+	st	\e, [sp, \off]
+	st	\o, [sp, \off+4]
+#endif
+.endm
+
+.macro LD2 e, o, off
+#ifdef CONFIG_ARC_HAS_LL64
+	ldd	\e, [sp, \off]
+#else
+	ld	\e, [sp, \off]
+	ld	\o, [sp, \off+4]
+#endif
+.endm
+
 #define ASM_NL		 `	/* use '`' to mark new line in macro */
 #define __ALIGN		.align 4
 #define __ALIGN_STR	__stringify(__ALIGN)
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index ecaf34e9235c2..e90dccecfd833 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -58,7 +58,14 @@ int main(void)
 	DEFINE(PT_r5, offsetof(struct pt_regs, r5));
 	DEFINE(PT_r6, offsetof(struct pt_regs, r6));
 	DEFINE(PT_r7, offsetof(struct pt_regs, r7));
+	DEFINE(PT_r8, offsetof(struct pt_regs, r8));
+	DEFINE(PT_r10, offsetof(struct pt_regs, r10));
+	DEFINE(PT_r26, offsetof(struct pt_regs, r26));
 	DEFINE(PT_ret, offsetof(struct pt_regs, ret));
+	DEFINE(PT_blink, offsetof(struct pt_regs, blink));
+	DEFINE(PT_lpe, offsetof(struct pt_regs, lp_end));
+	DEFINE(PT_lpc, offsetof(struct pt_regs, lp_count));
+	DEFINE(PT_user_r25, offsetof(struct pt_regs, user_r25));
 
 	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
 	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index 562089d62d9d6..6cbf0ee8a20a7 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -70,7 +70,7 @@ reserved:
 
 ENTRY(handle_interrupt)
 
-	INTERRUPT_PROLOGUE  irq
+	INTERRUPT_PROLOGUE
 
 	# irq control APIs local_irq_save/restore/disable/enable fiddle with
 	# global interrupt enable bits in STATUS32 (.IE for 1 prio, .E[] for 2 prio)
@@ -226,7 +226,7 @@ debug_marker_l1:
 	bset.nz	r11, r11, AUX_IRQ_ACT_BIT_U	; NZ means U
 	sr	r11, [AUX_IRQ_ACT]
 
-	INTERRUPT_EPILOGUE  irq
+	INTERRUPT_EPILOGUE
 	rtie
 
 ;####### Return from Exception / pure kernel mode #######
-- 
2.39.2



