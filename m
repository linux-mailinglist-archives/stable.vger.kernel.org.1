Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3255B742C18
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjF2SpV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjF2SpA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCC02D62
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46FC2615E2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59999C433C8;
        Thu, 29 Jun 2023 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064296;
        bh=ftY2B0Lm3XkRVDXFZ36sxKwa9zZmnhLED56S4O4Wg8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCL8D30L7k31oD3lTFMRVnhQvoc/wzPOeSiJCYNQhWRB4nlrGzb1dldVs3k1xSuQe
         ikHPaIC0AQQrdWHO4Qm0HhKGjPgFa/CTf4pbu8eL4aFapnDCRJRB+RLebdGyPQrOck
         GQhnyAWqnfUtvNl/PMO4qgtkCWwcGBWF2ScRgmpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 6.1 16/30] arm64/mm: Convert to using lock_mm_and_find_vma()
Date:   Thu, 29 Jun 2023 20:43:35 +0200
Message-ID: <20230629184152.325743401@linuxfoundation.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

commit ae870a68b5d13d67cf4f18d47bb01ee3fee40acb upstream.

This converts arm64 to use the new page fault helper.  It was very
straightforward, but still needed a fix for the "obvious" conversion I
initially did.  Thanks to Suren for the fix and testing.

Fixed-and-tested-by: Suren Baghdasaryan <surenb@google.com>
Unnecessary-code-removal-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[6.1: Ignore CONFIG_PER_VMA_LOCK context]
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig    |    1 +
 arch/arm64/mm/fault.c |   46 +++++++++-------------------------------------
 2 files changed, 10 insertions(+), 37 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -211,6 +211,7 @@ config ARM64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -483,27 +483,14 @@ static void do_bad_area(unsigned long fa
 #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
 #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
-static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
+static vm_fault_t __do_page_fault(struct mm_struct *mm,
+				  struct vm_area_struct *vma, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
 				  struct pt_regs *regs)
 {
-	struct vm_area_struct *vma = find_vma(mm, addr);
-
-	if (unlikely(!vma))
-		return VM_FAULT_BADMAP;
-
 	/*
 	 * Ok, we have a good vm_area for this memory access, so we can handle
 	 * it.
-	 */
-	if (unlikely(vma->vm_start > addr)) {
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			return VM_FAULT_BADMAP;
-		if (expand_stack(vma, addr))
-			return VM_FAULT_BADMAP;
-	}
-
-	/*
 	 * Check that the permissions on the VMA allow for the fault which
 	 * occurred.
 	 */
@@ -535,6 +522,7 @@ static int __kprobes do_page_fault(unsig
 	unsigned long vm_flags;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
+	struct vm_area_struct *vma;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -585,31 +573,14 @@ static int __kprobes do_page_fault(unsig
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
-	/*
-	 * As per x86, we may deadlock here. However, since the kernel only
-	 * validly references user space from well defined areas of the code,
-	 * we can bug out early if this is from code which shouldn't.
-	 */
-	if (!mmap_read_trylock(mm)) {
-		if (!user_mode(regs) && !search_exception_tables(regs->pc))
-			goto no_context;
 retry:
-		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above mmap_read_trylock() might have succeeded in which
-		 * case, we'll have missed the might_sleep() from down_read().
-		 */
-		might_sleep();
-#ifdef CONFIG_DEBUG_VM
-		if (!user_mode(regs) && !search_exception_tables(regs->pc)) {
-			mmap_read_unlock(mm);
-			goto no_context;
-		}
-#endif
+	vma = lock_mm_and_find_vma(mm, addr, regs);
+	if (unlikely(!vma)) {
+		fault = VM_FAULT_BADMAP;
+		goto done;
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, regs);
+	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -628,6 +599,7 @@ retry:
 	}
 	mmap_read_unlock(mm);
 
+done:
 	/*
 	 * Handle the "normal" (no error) case first.
 	 */


