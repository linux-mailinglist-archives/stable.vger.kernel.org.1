Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49835787394
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjHXPEq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbjHXPEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1070DFD
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:04:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C396671DC
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E79C433C7;
        Thu, 24 Aug 2023 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889453;
        bh=HTDbOh9qiCKtGdxXgDpe2b7CKAMc8XR5LJJQWNPALSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cf3qVbebhDXoQNsKldlJUUrVhuSpk5jh84WSA45tCnidYxc+IKLoN8fiujdKHunEr
         9zt1x7MjIEGuXRA0j21b3xe1G1CPrDNWgTTbw7JhCSrrOgDiUQfA/cV0bf9YS+CMhO
         +eWf6QHrSAeesFxIHIlvkUZ/PbffSAAY4fXW4lcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.10 126/135] x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
Date:   Thu, 24 Aug 2023 16:51:09 +0200
Message-ID: <20230824145032.475675239@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
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

commit 42be649dd1f2eee6b1fb185f1a231b9494cf095f upstream.

For a more consistent namespace.

  [ bp: Fixup names in the doc too. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.976236447@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/hw-vuln/srso.rst |    4 ++--
 arch/x86/include/asm/nospec-branch.h       |    4 ++--
 arch/x86/kernel/vmlinux.lds.S              |    8 ++++----
 arch/x86/lib/retpoline.S                   |   26 +++++++++++++-------------
 4 files changed, 21 insertions(+), 21 deletions(-)

--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -124,8 +124,8 @@ sequence.
 To ensure the safety of this mitigation, the kernel must ensure that the
 safe return sequence is itself free from attacker interference.  In Zen3
 and Zen4, this is accomplished by creating a BTB alias between the
-untraining function srso_untrain_ret_alias() and the safe return
-function srso_safe_ret_alias() which results in evicting a potentially
+untraining function srso_alias_untrain_ret() and the safe return
+function srso_alias_safe_ret() which results in evicting a potentially
 poisoned BTB entry and using that safe one for all function returns.
 
 In older Zen1 and Zen2, this is accomplished using a reinterpretation
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,7 +183,7 @@
 
 #ifdef CONFIG_CPU_SRSO
 	ALTERNATIVE_2 "", "call srso_untrain_ret", X86_FEATURE_SRSO, \
-			  "call srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
+			  "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
 .endm
 
@@ -207,7 +207,7 @@ extern void srso_alias_return_thunk(void
 
 extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
-extern void srso_untrain_ret_alias(void);
+extern void srso_alias_untrain_ret(void);
 
 extern void entry_ibpb(void);
 
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -141,10 +141,10 @@ SECTIONS
 
 #ifdef CONFIG_CPU_SRSO
 		/*
-		 * See the comment above srso_untrain_ret_alias()'s
+		 * See the comment above srso_alias_untrain_ret()'s
 		 * definition.
 		 */
-		. = srso_untrain_ret_alias | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
+		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
 		*(.text.__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
@@ -527,8 +527,8 @@ INIT_PER_CPU(irq_stack_backing_store);
  * GNU ld cannot do XOR so do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((srso_untrain_ret_alias | srso_safe_ret_alias) -
-		(srso_untrain_ret_alias & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_alias_untrain_ret) | srso_alias_safe_ret) -
+		(ABSOLUTE(srso_alias_untrain_ret) & srso_alias_safe_ret)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -75,55 +75,55 @@ SYM_CODE_END(__x86_indirect_thunk_array)
 #ifdef CONFIG_RETHUNK
 
 /*
- * srso_untrain_ret_alias() and srso_safe_ret_alias() are placed at
+ * srso_alias_untrain_ret() and srso_alias_safe_ret() are placed at
  * special addresses:
  *
- * - srso_untrain_ret_alias() is 2M aligned
- * - srso_safe_ret_alias() is also in the same 2M page but bits 2, 8, 14
+ * - srso_alias_untrain_ret() is 2M aligned
+ * - srso_alias_safe_ret() is also in the same 2M page but bits 2, 8, 14
  * and 20 in its virtual address are set (while those bits in the
- * srso_untrain_ret_alias() function are cleared).
+ * srso_alias_untrain_ret() function are cleared).
  *
  * This guarantees that those two addresses will alias in the branch
  * target buffer of Zen3/4 generations, leading to any potential
  * poisoned entries at that BTB slot to get evicted.
  *
- * As a result, srso_safe_ret_alias() becomes a safe return.
+ * As a result, srso_alias_safe_ret() becomes a safe return.
  */
 #ifdef CONFIG_CPU_SRSO
 	.section .text.__x86.rethunk_untrain
 
-SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	UNWIND_HINT_FUNC
 	ASM_NOP2
 	lfence
 	jmp srso_alias_return_thunk
-SYM_FUNC_END(srso_untrain_ret_alias)
-__EXPORT_THUNK(srso_untrain_ret_alias)
+SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 
 	.section .text.__x86.rethunk_safe
 #else
 /* dummy definition for alternatives */
-SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_untrain_ret_alias)
+SYM_FUNC_END(srso_alias_untrain_ret)
 #endif
 
-SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	add $8, %_ASM_SP
 	UNWIND_HINT_FUNC
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_safe_ret_alias)
+SYM_FUNC_END(srso_alias_safe_ret)
 
 	.section .text.__x86.return_thunk
 
 SYM_CODE_START(srso_alias_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	call srso_safe_ret_alias
+	call srso_alias_safe_ret
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
 


