Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86162783282
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjHUT6f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjHUT6e (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE87E129
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 752E4646C3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CEAC433C7;
        Mon, 21 Aug 2023 19:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647911;
        bh=3135AucRp8HDUEViMDZIo4HxElcW+T/JS/MJul3oUKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmA7xTVCm6TN6c3G8pj7M5oDpJd/RqMEWT8iYVInQpvKny1CQVPLiGm4XQ8Xv4Q4U
         v9KgY1ZTQcet5OxeGOC9oseXOPvNjLokMJdyQrrVKOMrVX8X7kPsysvM7oh6VmxyzK
         zLwFeoklD5Qi9rWWGWvNOzJcXX2jd7xw//zn8mJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Srikanth Aithal <sraithal@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 182/194] x86/retpoline: Dont clobber RFLAGS during srso_safe_ret()
Date:   Mon, 21 Aug 2023 21:42:41 +0200
Message-ID: <20230821194130.716426200@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
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

From: Sean Christopherson <seanjc@google.com>

commit ba5ca5e5e6a1d55923e88b4a83da452166f5560e upstream.

Use LEA instead of ADD when adjusting %rsp in srso_safe_ret{,_alias}()
so as to avoid clobbering flags.  Drop one of the INT3 instructions to
account for the LEA consuming one more byte than the ADD.

KVM's emulator makes indirect calls into a jump table of sorts, where
the destination of each call is a small blob of code that performs fast
emulation by executing the target instruction with fixed operands.

E.g. to emulate ADC, fastop() invokes adcb_al_dl():

  adcb_al_dl:
    <+0>:  adc    %dl,%al
    <+2>:  jmp    <__x86_return_thunk>

A major motivation for doing fast emulation is to leverage the CPU to
handle consumption and manipulation of arithmetic flags, i.e. RFLAGS is
both an input and output to the target of the call.  fastop() collects
the RFLAGS result by pushing RFLAGS onto the stack and popping them back
into a variable (held in %rdi in this case):

  asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"

  <+71>: mov    0xc0(%r8),%rdx
  <+78>: mov    0x100(%r8),%rcx
  <+85>: push   %rdi
  <+86>: popf
  <+87>: call   *%rsi
  <+89>: nop
  <+90>: nop
  <+91>: nop
  <+92>: pushf
  <+93>: pop    %rdi

and then propagating the arithmetic flags into the vCPU's emulator state:

  ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);

  <+64>:  and    $0xfffffffffffff72a,%r9
  <+94>:  and    $0x8d5,%edi
  <+109>: or     %rdi,%r9
  <+122>: mov    %r9,0x10(%r8)

The failures can be most easily reproduced by running the "emulator"
test in KVM-Unit-Tests.

If you're feeling a bit of deja vu, see commit b63f20a778c8
("x86/retpoline: Don't clobber RFLAGS during CALL_NOSPEC on i386").

In addition, this breaks booting of clang-compiled guest on
a gcc-compiled host where the host contains the %rsp-modifying SRSO
mitigations.

  [ bp: Massage commit message, extend, remove addresses. ]

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Closes: https://lore.kernel.org/all/de474347-122d-54cd-eabf-9dcc95ab9eae@amd.com
Reported-by: Srikanth Aithal <sraithal@amd.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20230810013334.GA5354@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/r/20230811155255.250835-1-seanjc@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/retpoline.S |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -113,7 +113,7 @@ SYM_FUNC_END(srso_alias_untrain_ret)
 #endif
 
 SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
-	add $8, %_ASM_SP
+	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
 	ANNOTATE_UNRET_SAFE
 	ret
@@ -213,7 +213,7 @@ __EXPORT_THUNK(retbleed_untrain_ret)
  * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
  *
- * movabs $0xccccccc308c48348,%rax
+ * movabs $0xccccc30824648d48,%rax
  *
  * and when the return thunk executes the inner label srso_safe_ret()
  * later, it is a stack manipulation and a RET which is mispredicted and
@@ -232,11 +232,10 @@ SYM_START(srso_untrain_ret, SYM_L_GLOBAL
  * the stack.
  */
 SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
-	add $8, %_ASM_SP
+	lea 8(%_ASM_SP), %_ASM_SP
 	ret
 	int3
 	int3
-	int3
 	/* end of movabs */
 	lfence
 	call srso_safe_ret


