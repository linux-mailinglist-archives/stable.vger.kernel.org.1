Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E435742C23
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjF2Sp0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjF2SpH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817330DF
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270E361575
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392C4C433C8;
        Thu, 29 Jun 2023 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064305;
        bh=TLBGj4dqfLU3IcziBijSAv3P3ZcbkS9Q766oMjASvus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCHkP9fapYcPRrqyGK8k0RsJfWsZP/CGYpBwx+DbHpJ+n4ScAhd8nylkmXUqn2+d7
         /uwJiSx95Q32FPqoxWskNQw9nZORGgqpKUeSTYEwbPmWF1MBywDYbSLqw1xqcn1Q/R
         OU4nuQ0ZeY0JzJKekOCCXpF8F/GcN42L8l5ikYD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <ben@decadent.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 6.1 19/30] riscv/mm: Convert to using lock_mm_and_find_vma()
Date:   Thu, 29 Jun 2023 20:43:38 +0200
Message-ID: <20230629184152.447109443@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

commit 7267ef7b0b77f4ed23b7b3c87d8eca7bd9c2d007 upstream.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[6.1: Kconfig context]
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/Kconfig    |    1 +
 arch/riscv/mm/fault.c |   31 +++++++++++++------------------
 2 files changed, 14 insertions(+), 18 deletions(-)

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -114,6 +114,7 @@ config RISCV
 	select HAVE_RSEQ
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -83,13 +83,13 @@ static inline void mm_fault_error(struct
 	BUG();
 }
 
-static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
+static inline void
+bad_area_nosemaphore(struct pt_regs *regs, int code, unsigned long addr)
 {
 	/*
 	 * Something tried to access memory that isn't in our memory map.
 	 * Fix it, but check if it's kernel or user first.
 	 */
-	mmap_read_unlock(mm);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		do_trap(regs, SIGSEGV, code, addr);
@@ -99,6 +99,15 @@ static inline void bad_area(struct pt_re
 	no_context(regs, addr);
 }
 
+static inline void
+bad_area(struct pt_regs *regs, struct mm_struct *mm, int code,
+	 unsigned long addr)
+{
+	mmap_read_unlock(mm);
+
+	bad_area_nosemaphore(regs, code, addr);
+}
+
 static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
 {
 	pgd_t *pgd, *pgd_k;
@@ -281,23 +290,10 @@ asmlinkage void do_page_fault(struct pt_
 	else if (cause == EXC_INST_PAGE_FAULT)
 		flags |= FAULT_FLAG_INSTRUCTION;
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, addr);
+	vma = lock_mm_and_find_vma(mm, addr, regs);
 	if (unlikely(!vma)) {
 		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (likely(vma->vm_start <= addr))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (unlikely(expand_stack(vma, addr))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
+		bad_area_nosemaphore(regs, code, addr);
 		return;
 	}
 
@@ -305,7 +301,6 @@ retry:
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it.
 	 */
-good_area:
 	code = SEGV_ACCERR;
 
 	if (unlikely(access_error(cause, vma))) {


