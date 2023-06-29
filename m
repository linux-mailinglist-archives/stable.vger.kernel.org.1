Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6826742C3E
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjF2Sqc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjF2Sq2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:46:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02882D56
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15242615C8
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262C4C433C0;
        Thu, 29 Jun 2023 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064383;
        bh=MsjhHz4/eAjk3gF0r5SBQso/up9q5yV/ZfeE+Pf3iIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFNwM27lUveZjr7IO7c/ZWY8P7O3MmCITF/5bRxyDr6VAGJBE2MBYefEaNm7Twt8i
         BSg1Nw77m/TpKpDVZuCE0ICg6hsC/EsLhYqsXnd3+0cneTuNFAfmHKNJ70q/2JXz1h
         pRX1n35OQvxY/dAAm3HL/1RuEAu8ltsrUsgUQSnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 6.3 14/29] arm64/mm: Convert to using lock_mm_and_find_vma()
Date:   Thu, 29 Jun 2023 20:43:44 +0200
Message-ID: <20230629184152.316913697@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
References: <20230629184151.705870770@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig    |    1 +
 arch/arm64/mm/fault.c |   44 +++++++-------------------------------------
 2 files changed, 8 insertions(+), 37 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -219,6 +219,7 @@ config ARM64
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
@@ -585,31 +572,14 @@ static int __kprobes do_page_fault(unsig
 
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


