Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4A79B2EE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358181AbjIKWIE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbjIKNxC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:53:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A75FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:52:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00F5C433CA;
        Mon, 11 Sep 2023 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440377;
        bh=ilZCwAvPOfOn1lBO1hgtl/m3+pNzJHqeVBmc4+yUISU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8j8Fndz4YWoe6Nfd8tHDHXytO5xirhOv82Z207+kTiJO6m8P698TNwLLoBTrk2Nm
         P9wSuUeQqvFCblz4JMMpr68LmA+YAAqHDrl6VCosSABoQBNkqQnskzCrx7Yu2muLyw
         0OfTNNX9mRjK7qQF57MB9Cussk3SWBZ+Mpfjozsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 039/739] x86/decompressor: Dont rely on upper 32 bits of GPRs being preserved
Date:   Mon, 11 Sep 2023 15:37:18 +0200
Message-ID: <20230911134652.194374204@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 264b82fdb4989cf6a44a2bcd0c6ea05e8026b2ac ]

The 4-to-5 level mode switch trampoline disables long mode and paging in
order to be able to flick the LA57 bit. According to section 3.4.1.1 of
the x86 architecture manual [0], 64-bit GPRs might not retain the upper
32 bits of their contents across such a mode switch.

Given that RBP, RBX and RSI are live at this point, preserve them on the
stack, along with the return address that might be above 4G as well.

[0] Intel® 64 and IA-32 Architectures Software Developer’s Manual, Volume 1: Basic Architecture

  "Because the upper 32 bits of 64-bit general-purpose registers are
   undefined in 32-bit modes, the upper 32 bits of any general-purpose
   register are not preserved when switching from 64-bit mode to a 32-bit
   mode (to protected mode or compatibility mode). Software must not
   depend on these bits to maintain a value after a 64-bit to 32-bit
   mode switch."

Fixes: 194a9749c73d650c ("x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-2-ardb@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 03c4328a88cbd..f732426d3b483 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -459,11 +459,25 @@ SYM_CODE_START(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
+	/* Set up 32-bit addressable stack */
+	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
+
+	/*
+	 * Preserve live 64-bit registers on the stack: this is necessary
+	 * because the architecture does not guarantee that GPRs will retain
+	 * their full 64-bit values across a 32-bit mode switch.
+	 */
+	pushq	%rbp
+	pushq	%rbx
+	pushq	%rsi
+
 	/*
-	 * Load the address of trampoline_return() into RDI.
-	 * It will be used by the trampoline to return to the main code.
+	 * Push the 64-bit address of trampoline_return() onto the new stack.
+	 * It will be used by the trampoline to return to the main code. Due to
+	 * the 32-bit mode switch, it cannot be kept it in a register either.
 	 */
 	leaq	trampoline_return(%rip), %rdi
+	pushq	%rdi
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
@@ -471,6 +485,11 @@ SYM_CODE_START(startup_64)
 	pushq	%rax
 	lretq
 trampoline_return:
+	/* Restore live 64-bit registers */
+	popq	%rsi
+	popq	%rbx
+	popq	%rbp
+
 	/* Restore the stack, the 32-bit trampoline uses its own stack */
 	leaq	rva(boot_stack_end)(%rbx), %rsp
 
@@ -582,7 +601,7 @@ SYM_FUNC_END(.Lrelocated)
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
  *
- * RDI contains the return address (might be above 4G).
+ * Return address is at the top of the stack (might be above 4G).
  * ECX contains the base address of the trampoline memory.
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
@@ -592,9 +611,6 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %ds
 	movl	%eax, %ss
 
-	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -671,7 +687,7 @@ SYM_CODE_END(trampoline_32bit_src)
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
-	jmp	*%rdi
+	retq
 SYM_FUNC_END(.Lpaging_enabled)
 
 	/*
-- 
2.40.1



