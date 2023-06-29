Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D439742C47
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjF2SsA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjF2Srl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC303594
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85DB8615F7
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6EDC433CD;
        Thu, 29 Jun 2023 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064458;
        bh=SwuNQZpge7H7XD2ruE6K0HClj47xUdPEXjMT/6GEp/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yqaRsXjBNwsLxhDLVojgpfwm03zoi+Uyxc88RUGKWL4nPV3bcWgdIoTEw5zZoNc2S
         EXGu7x0I0iK8wr8p8O1hGgK0UqS6IhT8jbkbXGT1/Fpa66gXY8H1utgjkNDZuUEfPj
         LLdfwgdkkROS5+093/1SQtwt3fM3fIELLJ1TzmF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.4 10/28] mm: introduce new lock_mm_and_find_vma() page fault helper
Date:   Thu, 29 Jun 2023 20:43:58 +0200
Message-ID: <20230629184152.286783570@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.888604958@linuxfoundation.org>
References: <20230629184151.888604958@linuxfoundation.org>
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

commit c2508ec5a58db67093f4fb8bf89a9a7c53a109e9 upstream.

.. and make x86 use it.

This basically extracts the existing x86 "find and expand faulting vma"
code, but extends it to also take the mmap lock for writing in case we
actually do need to expand the vma.

We've historically short-circuited that case, and have some rather ugly
special logic to serialize the stack segment expansion (since we only
hold the mmap lock for reading) that doesn't match the normal VM
locking.

That slight violation of locking worked well, right up until it didn't:
the maple tree code really does want proper locking even for simple
extension of an existing vma.

So extract the code for "look up the vma of the fault" from x86, fix it
up to do the necessary write locking, and make it available as a helper
function for other architectures that can use the common helper.

Note: I say "common helper", but it really only handles the normal
stack-grows-down case.  Which is all architectures except for PA-RISC
and IA64.  So some rare architectures can't use the helper, but if they
care they'll just need to open-code this logic.

It's also worth pointing out that this code really would like to have an
optimistic "mmap_upgrade_trylock()" to make it quicker to go from a
read-lock (for the common case) to taking the write lock (for having to
extend the vma) in the normal single-threaded situation where there is
no other locking activity.

But that _is_ all the very uncommon special case, so while it would be
nice to have such an operation, it probably doesn't matter in reality.
I did put in the skeleton code for such a possible future expansion,
even if it only acts as pseudo-documentation for what we're doing.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Kconfig    |    1 
 arch/x86/mm/fault.c |   52 ----------------------
 include/linux/mm.h  |    2 
 mm/Kconfig          |    4 +
 mm/memory.c         |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+), 50 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -276,6 +276,7 @@ config X86
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
+	select LOCK_MM_AND_FIND_VMA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
 	select NEED_SG_DMA_LENGTH
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -880,12 +880,6 @@ __bad_area(struct pt_regs *regs, unsigne
 	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
 }
 
-static noinline void
-bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
-{
-	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
-}
-
 static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 		struct vm_area_struct *vma)
 {
@@ -1366,51 +1360,10 @@ void do_user_addr_fault(struct pt_regs *
 lock_mmap:
 #endif /* CONFIG_PER_VMA_LOCK */
 
-	/*
-	 * Kernel-mode access to the user address space should only occur
-	 * on well-defined single instructions listed in the exception
-	 * tables.  But, an erroneous kernel fault occurring outside one of
-	 * those areas which also holds mmap_lock might deadlock attempting
-	 * to validate the fault against the address space.
-	 *
-	 * Only do the expensive exception table search when we might be at
-	 * risk of a deadlock.  This happens if we
-	 * 1. Failed to acquire mmap_lock, and
-	 * 2. The access did not originate in userspace.
-	 */
-	if (unlikely(!mmap_read_trylock(mm))) {
-		if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
-			/*
-			 * Fault from code in kernel from
-			 * which we do not expect faults.
-			 */
-			bad_area_nosemaphore(regs, error_code, address);
-			return;
-		}
 retry:
-		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above down_read_trylock() might have succeeded in
-		 * which case we'll have missed the might_sleep() from
-		 * down_read():
-		 */
-		might_sleep();
-	}
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma)) {
-		bad_area(regs, error_code, address);
-		return;
-	}
-	if (likely(vma->vm_start <= address))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, error_code, address);
-		return;
-	}
-	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, error_code, address);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1418,7 +1371,6 @@ retry:
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
-good_area:
 	if (unlikely(access_error(error_code, vma))) {
 		bad_area_access_error(regs, error_code, address, vma);
 		return;
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2325,6 +2325,8 @@ void unmap_mapping_pages(struct address_
 		pgoff_t start, pgoff_t nr, bool even_cows);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
+struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
+		unsigned long address, struct pt_regs *regs);
 #else
 static inline vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 					 unsigned long address, unsigned int flags,
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1206,6 +1206,10 @@ config PER_VMA_LOCK
 	  This feature allows locking each virtual memory area separately when
 	  handling page faults instead of taking mmap_lock.
 
+config LOCK_MM_AND_FIND_VMA
+	bool
+	depends on !STACK_GROWSUP
+
 source "mm/damon/Kconfig"
 
 endmenu
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5262,6 +5262,127 @@ out:
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
 
+#ifdef CONFIG_LOCK_MM_AND_FIND_VMA
+#include <linux/extable.h>
+
+static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
+{
+	/* Even if this succeeds, make it clear we *might* have slept */
+	if (likely(mmap_read_trylock(mm))) {
+		might_sleep();
+		return true;
+	}
+
+	if (regs && !user_mode(regs)) {
+		unsigned long ip = instruction_pointer(regs);
+		if (!search_exception_tables(ip))
+			return false;
+	}
+
+	mmap_read_lock(mm);
+	return true;
+}
+
+static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
+{
+	/*
+	 * We don't have this operation yet.
+	 *
+	 * It should be easy enough to do: it's basically a
+	 *    atomic_long_try_cmpxchg_acquire()
+	 * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
+	 * it also needs the proper lockdep magic etc.
+	 */
+	return false;
+}
+
+static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
+{
+	mmap_read_unlock(mm);
+	if (regs && !user_mode(regs)) {
+		unsigned long ip = instruction_pointer(regs);
+		if (!search_exception_tables(ip))
+			return false;
+	}
+	mmap_write_lock(mm);
+	return true;
+}
+
+/*
+ * Helper for page fault handling.
+ *
+ * This is kind of equivalend to "mmap_read_lock()" followed
+ * by "find_extend_vma()", except it's a lot more careful about
+ * the locking (and will drop the lock on failure).
+ *
+ * For example, if we have a kernel bug that causes a page
+ * fault, we don't want to just use mmap_read_lock() to get
+ * the mm lock, because that would deadlock if the bug were
+ * to happen while we're holding the mm lock for writing.
+ *
+ * So this checks the exception tables on kernel faults in
+ * order to only do this all for instructions that are actually
+ * expected to fault.
+ *
+ * We can also actually take the mm lock for writing if we
+ * need to extend the vma, which helps the VM layer a lot.
+ */
+struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
+			unsigned long addr, struct pt_regs *regs)
+{
+	struct vm_area_struct *vma;
+
+	if (!get_mmap_lock_carefully(mm, regs))
+		return NULL;
+
+	vma = find_vma(mm, addr);
+	if (likely(vma && (vma->vm_start <= addr)))
+		return vma;
+
+	/*
+	 * Well, dang. We might still be successful, but only
+	 * if we can extend a vma to do so.
+	 */
+	if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+
+	/*
+	 * We can try to upgrade the mmap lock atomically,
+	 * in which case we can continue to use the vma
+	 * we already looked up.
+	 *
+	 * Otherwise we'll have to drop the mmap lock and
+	 * re-take it, and also look up the vma again,
+	 * re-checking it.
+	 */
+	if (!mmap_upgrade_trylock(mm)) {
+		if (!upgrade_mmap_lock_carefully(mm, regs))
+			return NULL;
+
+		vma = find_vma(mm, addr);
+		if (!vma)
+			goto fail;
+		if (vma->vm_start <= addr)
+			goto success;
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			goto fail;
+	}
+
+	if (expand_stack(vma, addr))
+		goto fail;
+
+success:
+	mmap_write_downgrade(mm);
+	return vma;
+
+fail:
+	mmap_write_unlock(mm);
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_PER_VMA_LOCK
 /*
  * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be


