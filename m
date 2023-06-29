Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBA742C56
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjF2SrF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjF2Sqt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0112D70
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA83761575
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC647C433C8;
        Thu, 29 Jun 2023 18:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064407;
        bh=rGQvXK/m0yEhe8v0Y0MoWfTOpz8IiB1JbgfWAhPYCnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjN1PxIH7KetNsAPTuTX6S0WFMgKCx1u5q9OnyNhPvYhJ4WagKUqCRh6LMv7X4X9c
         BWzmPQ4ixSenD0kBHCCG3asypYxQcDmOjO36i7tXwWZjxS6ea7vmlqbpV6AF+aEV1Q
         OVzexWhSy4qo9PlltI7OkOIFoSe/YjKHuT6b1B9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.3 21/29] mm: make find_extend_vma() fail if write lock not held
Date:   Thu, 29 Jun 2023 20:43:51 +0200
Message-ID: <20230629184152.582908898@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
References: <20230629184151.705870770@linuxfoundation.org>
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

From: Liam R. Howlett <Liam.Howlett@oracle.com>

commit f440fa1ac955e2898893f9301568435eb5cdfc4b upstream.

Make calls to extend_vma() and find_extend_vma() fail if the write lock
is required.

To avoid making this a flag-day event, this still allows the old
read-locking case for the trivial situations, and passes in a flag to
say "is it write-locked".  That way write-lockers can say "yes, I'm
being careful", and legacy users will continue to work in all the common
cases until they have been fully converted to the new world order.

Co-Developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/binfmt_elf.c    |    6 +++---
 fs/exec.c          |    5 +++--
 include/linux/mm.h |   10 +++++++---
 mm/memory.c        |    2 +-
 mm/mmap.c          |   50 +++++++++++++++++++++++++++++++++-----------------
 mm/nommu.c         |    3 ++-
 6 files changed, 49 insertions(+), 27 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -320,10 +320,10 @@ create_elf_tables(struct linux_binprm *b
 	 * Grow the stack manually; some architectures have a limit on how
 	 * far ahead a user-space access may be in order to grow the stack.
 	 */
-	if (mmap_read_lock_killable(mm))
+	if (mmap_write_lock_killable(mm))
 		return -EINTR;
-	vma = find_extend_vma(mm, bprm->p);
-	mmap_read_unlock(mm);
+	vma = find_extend_vma_locked(mm, bprm->p, true);
+	mmap_write_unlock(mm);
 	if (!vma)
 		return -EFAULT;
 
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -204,7 +204,8 @@ static struct page *get_arg_page(struct
 
 #ifdef CONFIG_STACK_GROWSUP
 	if (write) {
-		ret = expand_downwards(bprm->vma, pos);
+		/* We claim to hold the lock - nobody to race with */
+		ret = expand_downwards(bprm->vma, pos, true);
 		if (ret < 0)
 			return NULL;
 	}
@@ -852,7 +853,7 @@ int setup_arg_pages(struct linux_binprm
 	stack_base = vma->vm_end - stack_expand;
 #endif
 	current->mm->start_stack = bprm->p;
-	ret = expand_stack(vma, stack_base);
+	ret = expand_stack_locked(vma, stack_base, true);
 	if (ret)
 		ret = -EFAULT;
 
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3065,11 +3065,13 @@ extern vm_fault_t filemap_page_mkwrite(s
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
-extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address,
+		bool write_locked);
+#define expand_stack(vma,addr) expand_stack_locked(vma,addr,false)
 
 /* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
-extern int expand_downwards(struct vm_area_struct *vma,
-		unsigned long address);
+int expand_downwards(struct vm_area_struct *vma, unsigned long address,
+		bool write_locked);
 #if VM_GROWSUP
 extern int expand_upwards(struct vm_area_struct *vma, unsigned long address);
 #else
@@ -3170,6 +3172,8 @@ unsigned long change_prot_numa(struct vm
 #endif
 
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
+		unsigned long addr, bool write_locked);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5336,7 +5336,7 @@ struct vm_area_struct *lock_mm_and_find_
 			goto fail;
 	}
 
-	if (expand_stack(vma, addr))
+	if (expand_stack_locked(vma, addr, true))
 		goto fail;
 
 success:
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1898,7 +1898,8 @@ static int acct_stack_growth(struct vm_a
  * PA-RISC uses this for its stack; IA64 for its Register Backing Store.
  * vma is the last one with address > vma->vm_end.  Have to extend vma.
  */
-int expand_upwards(struct vm_area_struct *vma, unsigned long address)
+int expand_upwards(struct vm_area_struct *vma, unsigned long address,
+		bool write_locked)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *next;
@@ -1922,6 +1923,8 @@ int expand_upwards(struct vm_area_struct
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr = TASK_SIZE;
 
+	if (!write_locked)
+		return -EAGAIN;
 	next = find_vma_intersection(mm, vma->vm_end, gap_addr);
 	if (next && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
@@ -1991,7 +1994,8 @@ int expand_upwards(struct vm_area_struct
 /*
  * vma is the first one with address < vma->vm_start.  Have to extend vma.
  */
-int expand_downwards(struct vm_area_struct *vma, unsigned long address)
+int expand_downwards(struct vm_area_struct *vma, unsigned long address,
+		bool write_locked)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
@@ -2005,10 +2009,13 @@ int expand_downwards(struct vm_area_stru
 	/* Enforce stack_guard_gap */
 	prev = mas_prev(&mas, 0);
 	/* Check that both stack segments have the same anon_vma? */
-	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
-			vma_is_accessible(prev)) {
-		if (address - prev->vm_end < stack_guard_gap)
+	if (prev) {
+		if (!(prev->vm_flags & VM_GROWSDOWN) &&
+		    vma_is_accessible(prev) &&
+		    (address - prev->vm_end < stack_guard_gap))
 			return -ENOMEM;
+		if (!write_locked && (prev->vm_end == address))
+			return -EAGAIN;
 	}
 
 	if (mas_preallocate(&mas, GFP_KERNEL))
@@ -2087,13 +2094,14 @@ static int __init cmdline_parse_stack_gu
 __setup("stack_guard_gap=", cmdline_parse_stack_guard_gap);
 
 #ifdef CONFIG_STACK_GROWSUP
-int expand_stack(struct vm_area_struct *vma, unsigned long address)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address,
+		bool write_locked)
 {
-	return expand_upwards(vma, address);
+	return expand_upwards(vma, address, write_locked);
 }
 
-struct vm_area_struct *
-find_extend_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm,
+		unsigned long addr, bool write_locked)
 {
 	struct vm_area_struct *vma, *prev;
 
@@ -2101,20 +2109,25 @@ find_extend_vma(struct mm_struct *mm, un
 	vma = find_vma_prev(mm, addr, &prev);
 	if (vma && (vma->vm_start <= addr))
 		return vma;
-	if (!prev || expand_stack(prev, addr))
+	if (!prev)
+		return NULL;
+	if (expand_stack_locked(prev, addr, write_locked))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED)
 		populate_vma_page_range(prev, addr, prev->vm_end, NULL);
 	return prev;
 }
 #else
-int expand_stack(struct vm_area_struct *vma, unsigned long address)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address,
+		bool write_locked)
 {
-	return expand_downwards(vma, address);
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
+		return -EINVAL;
+	return expand_downwards(vma, address, write_locked);
 }
 
-struct vm_area_struct *
-find_extend_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm,
+		unsigned long addr, bool write_locked)
 {
 	struct vm_area_struct *vma;
 	unsigned long start;
@@ -2125,10 +2138,8 @@ find_extend_vma(struct mm_struct *mm, un
 		return NULL;
 	if (vma->vm_start <= addr)
 		return vma;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		return NULL;
 	start = vma->vm_start;
-	if (expand_stack(vma, addr))
+	if (expand_stack_locked(vma, addr, write_locked))
 		return NULL;
 	if (vma->vm_flags & VM_LOCKED)
 		populate_vma_page_range(vma, addr, start, NULL);
@@ -2136,6 +2147,11 @@ find_extend_vma(struct mm_struct *mm, un
 }
 #endif
 
+struct vm_area_struct *find_extend_vma(struct mm_struct *mm,
+		unsigned long addr)
+{
+	return find_extend_vma_locked(mm, addr, false);
+}
 EXPORT_SYMBOL_GPL(find_extend_vma);
 
 /*
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -643,7 +643,8 @@ struct vm_area_struct *find_extend_vma(s
  * expand a stack to a given address
  * - not supported under NOMMU conditions
  */
-int expand_stack(struct vm_area_struct *vma, unsigned long address)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address,
+		bool write_locked)
 {
 	return -ENOMEM;
 }


