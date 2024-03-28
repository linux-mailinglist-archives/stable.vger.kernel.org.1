Return-Path: <stable+bounces-26503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B90870EE4
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C842E1C2134B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064446BA0;
	Mon,  4 Mar 2024 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u+AnJhv4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B71EB5A;
	Mon,  4 Mar 2024 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588921; cv=none; b=jj4EbCtny0zD9M/cH6ekJOxTWtd4BLTa8RM8b0GMonX4IH4LOv+4F3ok5ZQWRfG9jbKnJqmSAbgZNwaRzU6ZYgMjff30MMLY9wnMcGpfIucaDwvB3BoXnE14Yn9BDzI5FpgvXh+FpdzGzJumyrAxr3WUt/azYGJt8jAiaA7QgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588921; c=relaxed/simple;
	bh=Yeo7rpshA2XOmrPvOu5ux0TrxL4plwmM2IRqA0wwvKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9aAr4CjGi38tcBmiVBBhstfPTQaTAizMKeLueJWDxt1r6XmCsaZGvZc/fPYdZ3Z5jWaBAlD3FucGIphToVy2Lbx8jXKlYgwE5LEr429SkvjEwbtUgXJv5x4NOhh1TKsNPRyfJeLK2Hunnc6Z6mx9ZmzPzfdrTlxKEa8KShYy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u+AnJhv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48634C433C7;
	Mon,  4 Mar 2024 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588921;
	bh=Yeo7rpshA2XOmrPvOu5ux0TrxL4plwmM2IRqA0wwvKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+AnJhv4JtwFTExfim+BVvswCbHJHup11OdNf/hXVFW5tsrpw+D0Zd5NqvZKUgjPt
	 rYxWd31EW8m8F5uhgANpzcuwVUcvIYUq2ttlJQUCyG03QpMAHDALPWxHL/IVdGpU+A
	 BtPv3+2srDY3k8XeAArTT5sK2eC8FSpsMz87yWyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 6.1 135/215] x86/decompressor: Call trampoline directly from C code
Date: Mon,  4 Mar 2024 21:23:18 +0000
Message-ID: <20240304211601.356424867@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

commit 64ef578b6b6866bec012544416946533444036c8 upstream.

Instead of returning to the asm calling code to invoke the trampoline,
call it straight from the C code that sets it up. That way, the struct
return type is no longer needed for returning two values, and the call
can be made conditional more cleanly in a subsequent patch.

This means that all callee save 64-bit registers need to be preserved
and restored, as their contents may not survive the legacy mode switch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20230807162720.545787-13-ardb@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/head_64.S    |   31 +++++++++++++------------------
 arch/x86/boot/compressed/pgtable_64.c |   32 +++++++++++++-------------------
 2 files changed, 26 insertions(+), 37 deletions(-)

--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -433,25 +433,14 @@ SYM_CODE_START(startup_64)
 #endif
 
 	/*
-	 * paging_prepare() sets up the trampoline and checks if we need to
-	 * enable 5-level paging.
-	 *
-	 * paging_prepare() returns a two-quadword structure which lands
-	 * into RDX:RAX:
-	 *   - Address of the trampoline is returned in RAX.
-	 *   - Non zero RDX means trampoline needs to enable 5-level
-	 *     paging.
+	 * configure_5level_paging() updates the number of paging levels using
+	 * a trampoline in 32-bit addressable memory if the current number does
+	 * not match the desired number.
 	 *
 	 * Pass the boot_params pointer as the first argument.
 	 */
 	movq	%r15, %rdi
-	call	paging_prepare
-
-	/* Pass the trampoline address and boolean flag as args #1 and #2 */
-	movq	%rax, %rdi
-	movq	%rdx, %rsi
-	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
-	call	*%rax
+	call	configure_5level_paging
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
@@ -561,11 +550,14 @@ SYM_FUNC_END(.Lrelocated)
 	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
 	/*
-	 * Preserve live 64-bit registers on the stack: this is necessary
-	 * because the architecture does not guarantee that GPRs will retain
-	 * their full 64-bit values across a 32-bit mode switch.
+	 * Preserve callee save 64-bit registers on the stack: this is
+	 * necessary because the architecture does not guarantee that GPRs will
+	 * retain their full 64-bit values across a 32-bit mode switch.
 	 */
 	pushq	%r15
+	pushq	%r14
+	pushq	%r13
+	pushq	%r12
 	pushq	%rbp
 	pushq	%rbx
 
@@ -592,6 +584,9 @@ SYM_CODE_START(trampoline_32bit_src)
 	/* Restore the preserved 64-bit registers */
 	popq	%rbx
 	popq	%rbp
+	popq	%r12
+	popq	%r13
+	popq	%r14
 	popq	%r15
 	retq
 
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -16,11 +16,6 @@ unsigned int __section(".data") pgdir_sh
 unsigned int __section(".data") ptrs_per_p4d = 1;
 #endif
 
-struct paging_config {
-	unsigned long trampoline_start;
-	unsigned long l5_required;
-};
-
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
@@ -29,7 +24,7 @@ static char trampoline_save[TRAMPOLINE_3
  * purposes.
  *
  * Avoid putting the pointer into .bss as it will be cleared between
- * paging_prepare() and extract_kernel().
+ * configure_5level_paging() and extract_kernel().
  */
 unsigned long *trampoline_32bit __section(".data");
 
@@ -106,13 +101,13 @@ static unsigned long find_trampoline_pla
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-struct paging_config paging_prepare(void *rmode)
+asmlinkage void configure_5level_paging(struct boot_params *bp)
 {
-	struct paging_config paging_config = {};
-	void *tramp_code;
+	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
+	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = rmode;
+	boot_params = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
@@ -130,7 +125,7 @@ struct paging_config paging_prepare(void
 			!cmdline_find_option_bool("no5lvl") &&
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
-		paging_config.l5_required = 1;
+		l5_required = true;
 
 		/* Initialize variables for 5-level paging */
 		__pgtable_l5_enabled = 1;
@@ -138,9 +133,7 @@ struct paging_config paging_prepare(void
 		ptrs_per_p4d = 512;
 	}
 
-	paging_config.trampoline_start = find_trampoline_placement();
-
-	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
+	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
 	/* Preserve trampoline memory */
 	memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
@@ -149,7 +142,7 @@ struct paging_config paging_prepare(void
 	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
 
 	/* Copy trampoline code in place */
-	tramp_code = memcpy(trampoline_32bit +
+	toggle_la57 = memcpy(trampoline_32bit +
 			TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
@@ -159,7 +152,8 @@ struct paging_config paging_prepare(void
 	 * immediate absolute address, which needs to be adjusted based on the
 	 * placement of the trampoline.
 	 */
-	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
+	*(u32 *)((u8 *)toggle_la57 + trampoline_ljmp_imm_offset) +=
+						(unsigned long)toggle_la57;
 
 	/*
 	 * The code below prepares page table in trampoline memory.
@@ -175,10 +169,10 @@ struct paging_config paging_prepare(void
 	 * We are not going to use the page table in trampoline memory if we
 	 * are already in the desired paging mode.
 	 */
-	if (paging_config.l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
 		goto out;
 
-	if (paging_config.l5_required) {
+	if (l5_required) {
 		/*
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
@@ -201,7 +195,7 @@ struct paging_config paging_prepare(void
 	}
 
 out:
-	return paging_config;
+	toggle_la57(trampoline_32bit, l5_required);
 }
 
 void cleanup_trampoline(void *pgtable)



