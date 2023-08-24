Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218CA7872D3
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbjHXO5T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbjHXO5M (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C969519AA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FBA866EDF
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED74C433C7;
        Thu, 24 Aug 2023 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889028;
        bh=IsW8V9Ytk/xcOIw3khDyWLS3enOMkknbwabh82RAvqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVHTc10RXkxvGshwBUUDqdLmWWDVqseYVQwVpe0eMznm7Ss9z7eUh2OUvJ+mSTp1c
         718/8RNT+TXIN9uqQ9BI7Pu3vHsWKCXzkYUHtjIUT0gsvK6TtheGkOZU9aNnCLFeKE
         y6OAfM2jiovvB8PC566dF9Y1zoWSC+1KuPajeSdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 128/139] x86/cpu: Clean up SRSO return thunk mess
Date:   Thu, 24 Aug 2023 16:50:51 +0200
Message-ID: <20230824145029.025119492@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit d43490d0ab824023e11d0b57d0aeec17a6e0ca13 upstream.

Use the existing configurable return thunk. There is absolute no
justification for having created this __x86_return_thunk alternative.

To clarify, the whole thing looks like:

Zen3/4 does:

  srso_alias_untrain_ret:
	  nop2
	  lfence
	  jmp srso_alias_return_thunk
	  int3

  srso_alias_safe_ret: // aliasses srso_alias_untrain_ret just so
	  add $8, %rsp
	  ret
	  int3

  srso_alias_return_thunk:
	  call srso_alias_safe_ret
	  ud2

While Zen1/2 does:

  srso_untrain_ret:
	  movabs $foo, %rax
	  lfence
	  call srso_safe_ret           (jmp srso_return_thunk ?)
	  int3

  srso_safe_ret: // embedded in movabs instruction
	  add $8,%rsp
          ret
          int3

  srso_return_thunk:
	  call srso_safe_ret
	  ud2

While retbleed does:

  zen_untrain_ret:
	  test $0xcc, %bl
	  lfence
	  jmp zen_return_thunk
          int3

  zen_return_thunk: // embedded in the test instruction
	  ret
          int3

Where Zen1/2 flush the BTB entry using the instruction decoder trick
(test,movabs) Zen3/4 use BTB aliasing. SRSO adds a return sequence
(srso_safe_ret()) which forces the function return instruction to
speculate into a trap (UD2).  This RET will then mispredict and
execution will continue at the return site read from the top of the
stack.

Pick one of three options at boot (evey function can only ever return
once).

  [ bp: Fixup commit message uarch details and add them in a comment in
    the code too. Add a comment about the srso_select_mitigation()
    dependency on retbleed_select_mitigation(). Add moar ifdeffery for
    32-bit builds. Add a dummy srso_untrain_ret_alias() definition for
    32-bit alternatives needing the symbol. ]

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.842775684@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    5 +++
 arch/x86/kernel/cpu/bugs.c           |   17 ++++++++--
 arch/x86/kernel/vmlinux.lds.S        |    4 +-
 arch/x86/lib/retpoline.S             |   58 +++++++++++++++++++++++++----------
 tools/objtool/arch/x86/decode.c      |    2 -
 5 files changed, 64 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -201,9 +201,14 @@ extern void __x86_return_thunk(void);
 static inline void __x86_return_thunk(void) {}
 #endif
 
+extern void zen_return_thunk(void);
+extern void srso_return_thunk(void);
+extern void srso_alias_return_thunk(void);
+
 extern void zen_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_untrain_ret_alias(void);
+
 extern void entry_ibpb(void);
 
 #ifdef CONFIG_RETPOLINE
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -166,8 +166,13 @@ void __init cpu_select_mitigations(void)
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
-	gds_select_mitigation();
+
+	/*
+	 * srso_select_mitigation() depends and must run after
+	 * retbleed_select_mitigation().
+	 */
 	srso_select_mitigation();
+	gds_select_mitigation();
 }
 
 /*
@@ -1015,6 +1020,9 @@ do_cmd_auto:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
+		if (IS_ENABLED(CONFIG_RETHUNK))
+			x86_return_thunk = zen_return_thunk;
+
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 			pr_err(RETBLEED_UNTRAIN_MSG);
@@ -2422,10 +2430,13 @@ static void __init srso_select_mitigatio
 			 */
 			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 
-			if (boot_cpu_data.x86 == 0x19)
+			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-			else
+				x86_return_thunk = srso_alias_return_thunk;
+			} else {
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
+				x86_return_thunk = srso_return_thunk;
+			}
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -511,8 +511,8 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
- #ifdef CONFIG_RETHUNK
-. = ASSERT((__ret & 0x3f) == 0, "__ret not cacheline-aligned");
+#ifdef CONFIG_RETHUNK
+. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -93,21 +93,26 @@ SYM_CODE_END(__x86_indirect_thunk_array)
 	.section .text.__x86.rethunk_untrain
 
 SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+	UNWIND_HINT_FUNC
 	ASM_NOP2
 	lfence
-	jmp __x86_return_thunk
+	jmp srso_alias_return_thunk
 SYM_FUNC_END(srso_untrain_ret_alias)
 __EXPORT_THUNK(srso_untrain_ret_alias)
 
 	.section .text.__x86.rethunk_safe
+#else
+/* dummy definition for alternatives */
+SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(srso_untrain_ret_alias)
 #endif
 
-/* Needs a definition for the __x86_return_thunk alternative below. */
 SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
-#ifdef CONFIG_CPU_SRSO
 	add $8, %_ASM_SP
 	UNWIND_HINT_FUNC
-#endif
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -115,9 +120,16 @@ SYM_FUNC_END(srso_safe_ret_alias)
 
 	.section .text.__x86.return_thunk
 
+SYM_CODE_START(srso_alias_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_safe_ret_alias
+	ud2
+SYM_CODE_END(srso_alias_return_thunk)
+
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
- * 1) The RET at __x86_return_thunk must be on a 64 byte boundary, for
+ * 1) The RET at zen_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
  * 2) The instruction at zen_untrain_ret must contain, and not
  *    end with, the 0xc3 byte of the RET.
@@ -125,7 +137,7 @@ SYM_FUNC_END(srso_safe_ret_alias)
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (__ret - zen_untrain_ret), 0xcc
+	.skip 64 - (zen_return_thunk - zen_untrain_ret), 0xcc
 SYM_FUNC_START_NOALIGN(zen_untrain_ret);
 
 	/*
@@ -133,16 +145,16 @@ SYM_FUNC_START_NOALIGN(zen_untrain_ret);
 	 *
 	 *   TEST $0xcc, %bl
 	 *   LFENCE
-	 *   JMP __x86_return_thunk
+	 *   JMP zen_return_thunk
 	 *
 	 * Executing the TEST instruction has a side effect of evicting any BTB
 	 * prediction (potentially attacker controlled) attached to the RET, as
-	 * __x86_return_thunk + 1 isn't an instruction boundary at the moment.
+	 * zen_return_thunk + 1 isn't an instruction boundary at the moment.
 	 */
 	.byte	0xf6
 
 	/*
-	 * As executed from __x86_return_thunk, this is a plain RET.
+	 * As executed from zen_return_thunk, this is a plain RET.
 	 *
 	 * As part of the TEST above, RET is the ModRM byte, and INT3 the imm8.
 	 *
@@ -154,13 +166,13 @@ SYM_FUNC_START_NOALIGN(zen_untrain_ret);
 	 * With SMT enabled and STIBP active, a sibling thread cannot poison
 	 * RET's prediction to a type of its choice, but can evict the
 	 * prediction due to competitive sharing. If the prediction is
-	 * evicted, __x86_return_thunk will suffer Straight Line Speculation
+	 * evicted, zen_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(__ret, SYM_L_GLOBAL)
+SYM_INNER_LABEL(zen_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(__ret)
+SYM_CODE_END(zen_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -171,7 +183,7 @@ SYM_CODE_END(__ret)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp __ret
+	jmp zen_return_thunk
 	int3
 SYM_FUNC_END(zen_untrain_ret)
 __EXPORT_THUNK(zen_untrain_ret)
@@ -191,12 +203,19 @@ __EXPORT_THUNK(zen_untrain_ret)
 SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	.byte 0x48, 0xb8
 
+/*
+ * This forces the function return instruction to speculate into a trap
+ * (UD2 in srso_return_thunk() below).  This RET will then mispredict
+ * and execution will continue at the return site read from the top of
+ * the stack.
+ */
 SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
 	add $8, %_ASM_SP
 	ret
 	int3
 	int3
 	int3
+	/* end of movabs */
 	lfence
 	call srso_safe_ret
 	ud2
@@ -204,12 +223,19 @@ SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_CODE_START(__x86_return_thunk)
+SYM_CODE_START(srso_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
-			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
+	call srso_safe_ret
 	ud2
+SYM_CODE_END(srso_return_thunk)
+
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -728,5 +728,5 @@ bool arch_is_rethunk(struct symbol *sym)
 	return !strcmp(sym->name, "__x86_return_thunk") ||
 	       !strcmp(sym->name, "srso_untrain_ret") ||
 	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "__ret");
+	       !strcmp(sym->name, "zen_return_thunk");
 }


