Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F96742C40
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjF2Spm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjF2Spa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:45:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5C2D70
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8FAF615E8
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93ADC433C8;
        Thu, 29 Jun 2023 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064326;
        bh=VlFKy7kK01bMZ1iIprLaa1eWtOq6mm0WwNc6OGb/h84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzbMszJaq3MwfuLHpuZ6jyAflUPsGRFGWBjyV+P/DgLsVh27+Vi67OM4EwrrFkiX7
         3o8UhiugWU2rogbfFUyAXp1V47m1ymDvW4tO6q0NQoC830jfjPJ6Wtb95amDUb8W3G
         YWrZgiAMSQ6usXrJ8h3ZnWkv4OIOri4rZAYRFhXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 6.1 25/30] mm: always expand the stack with the mmap write lock held
Date:   Thu, 29 Jun 2023 20:43:44 +0200
Message-ID: <20230629184152.675640642@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
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

commit 8d7071af890768438c14db6172cc8f9f4d04e184 upstream

This finishes the job of always holding the mmap write lock when
extending the user stack vma, and removes the 'write_locked' argument
from the vm helper functions again.

For some cases, we just avoid expanding the stack at all: drivers and
page pinning really shouldn't be extending any stacks.  Let's see if any
strange users really wanted that.

It's worth noting that architectures that weren't converted to the new
lock_mm_and_find_vma() helper function are left using the legacy
"expand_stack()" function, but it has been changed to drop the mmap_lock
and take it for writing while expanding the vma.  This makes it fairly
straightforward to convert the remaining architectures.

As a result of dropping and re-taking the lock, the calling conventions
for this function have also changed, since the old vma may no longer be
valid.  So it will now return the new vma if successful, and NULL - and
the lock dropped - if the area could not be extended.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[6.1: Patch drivers/iommu/io-pgfault.c instead]
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/ia64/mm/fault.c         |   36 ++----------
 arch/m68k/mm/fault.c         |    9 ++-
 arch/microblaze/mm/fault.c   |    5 +
 arch/openrisc/mm/fault.c     |    5 +
 arch/parisc/mm/fault.c       |   23 +++-----
 arch/s390/mm/fault.c         |    5 +
 arch/sparc/mm/fault_64.c     |    8 +-
 arch/um/kernel/trap.c        |   11 ++-
 drivers/iommu/amd/iommu_v2.c |    4 -
 drivers/iommu/io-pgfault.c   |    2 
 fs/binfmt_elf.c              |    2 
 fs/exec.c                    |    4 -
 include/linux/mm.h           |   16 +----
 mm/gup.c                     |    6 +-
 mm/memory.c                  |   10 +++
 mm/mmap.c                    |  121 ++++++++++++++++++++++++++++++++++---------
 mm/nommu.c                   |   18 ++----
 17 files changed, 169 insertions(+), 116 deletions(-)

--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -110,10 +110,12 @@ retry:
          * register backing store that needs to expand upwards, in
          * this case vma will be null, but prev_vma will ne non-null
          */
-        if (( !vma && prev_vma ) || (address < vma->vm_start) )
-		goto check_expansion;
+        if (( !vma && prev_vma ) || (address < vma->vm_start) ) {
+		vma = expand_stack(mm, address);
+		if (!vma)
+			goto bad_area_nosemaphore;
+	}
 
-  good_area:
 	code = SEGV_ACCERR;
 
 	/* OK, we've got a good vm_area for this memory area.  Check the access permissions: */
@@ -174,35 +176,9 @@ retry:
 	mmap_read_unlock(mm);
 	return;
 
-  check_expansion:
-	if (!(prev_vma && (prev_vma->vm_flags & VM_GROWSUP) && (address == prev_vma->vm_end))) {
-		if (!vma)
-			goto bad_area;
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			goto bad_area;
-		if (REGION_NUMBER(address) != REGION_NUMBER(vma->vm_start)
-		    || REGION_OFFSET(address) >= RGN_MAP_LIMIT)
-			goto bad_area;
-		if (expand_stack(vma, address))
-			goto bad_area;
-	} else {
-		vma = prev_vma;
-		if (REGION_NUMBER(address) != REGION_NUMBER(vma->vm_start)
-		    || REGION_OFFSET(address) >= RGN_MAP_LIMIT)
-			goto bad_area;
-		/*
-		 * Since the register backing store is accessed sequentially,
-		 * we disallow growing it by more than a page at a time.
-		 */
-		if (address > vma->vm_end + PAGE_SIZE - sizeof(long))
-			goto bad_area;
-		if (expand_upwards(vma, address))
-			goto bad_area;
-	}
-	goto good_area;
-
   bad_area:
 	mmap_read_unlock(mm);
+  bad_area_nosemaphore:
 	if ((isr & IA64_ISR_SP)
 	    || ((isr & IA64_ISR_NA) && (isr & IA64_ISR_CODE_MASK) == IA64_ISR_CODE_LFETCH))
 	{
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -105,8 +105,9 @@ retry:
 		if (address + 256 < rdusp())
 			goto map_err;
 	}
-	if (expand_stack(vma, address))
-		goto map_err;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto map_err_nosemaphore;
 
 /*
  * Ok, we have a good vm_area for this memory access, so
@@ -193,10 +194,12 @@ bus_err:
 	goto send_sig;
 
 map_err:
+	mmap_read_unlock(mm);
+map_err_nosemaphore:
 	current->thread.signo = SIGSEGV;
 	current->thread.code = SEGV_MAPERR;
 	current->thread.faddr = address;
-	goto send_sig;
+	return send_fault_sig(regs);
 
 acc_err:
 	current->thread.signo = SIGSEGV;
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -192,8 +192,9 @@ retry:
 			&& (kernel_mode(regs) || !store_updates_sp(regs)))
 				goto bad_area;
 	}
-	if (expand_stack(vma, address))
-		goto bad_area;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto bad_area_nosemaphore;
 
 good_area:
 	code = SEGV_ACCERR;
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -127,8 +127,9 @@ retry:
 		if (address + PAGE_SIZE < regs->sp)
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
-		goto bad_area;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto bad_area_nosemaphore;
 
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -288,15 +288,19 @@ void do_page_fault(struct pt_regs *regs,
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma_prev(mm, address, &prev_vma);
-	if (!vma || address < vma->vm_start)
-		goto check_expansion;
+	if (!vma || address < vma->vm_start) {
+		if (!prev || !(prev->vm_flags & VM_GROWSUP))
+			goto bad_area;
+		vma = expand_stack(mm, address);
+		if (!vma)
+			goto bad_area_nosemaphore;
+	}
+
 /*
  * Ok, we have a good vm_area for this memory access. We still need to
  * check the access permissions.
  */
 
-good_area:
-
 	if ((vma->vm_flags & acc_type) != acc_type)
 		goto bad_area;
 
@@ -342,17 +346,13 @@ good_area:
 	mmap_read_unlock(mm);
 	return;
 
-check_expansion:
-	vma = prev_vma;
-	if (vma && (expand_stack(vma, address) == 0))
-		goto good_area;
-
 /*
  * Something tried to access memory that isn't in our memory map..
  */
 bad_area:
 	mmap_read_unlock(mm);
 
+bad_area_nosemaphore:
 	if (user_mode(regs)) {
 		int signo, si_code;
 
@@ -444,7 +444,7 @@ handle_nadtlb_fault(struct pt_regs *regs
 {
 	unsigned long insn = regs->iir;
 	int breg, treg, xreg, val = 0;
-	struct vm_area_struct *vma, *prev_vma;
+	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	unsigned long address;
@@ -480,7 +480,7 @@ handle_nadtlb_fault(struct pt_regs *regs
 				/* Search for VMA */
 				address = regs->ior;
 				mmap_read_lock(mm);
-				vma = find_vma_prev(mm, address, &prev_vma);
+				vma = vma_lookup(mm, address);
 				mmap_read_unlock(mm);
 
 				/*
@@ -489,7 +489,6 @@ handle_nadtlb_fault(struct pt_regs *regs
 				 */
 				acc_type = (insn & 0x40) ? VM_WRITE : VM_READ;
 				if (vma
-				    && address >= vma->vm_start
 				    && (vma->vm_flags & acc_type) == acc_type)
 					val = 1;
 			}
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -429,8 +429,9 @@ retry:
 	if (unlikely(vma->vm_start > address)) {
 		if (!(vma->vm_flags & VM_GROWSDOWN))
 			goto out_up;
-		if (expand_stack(vma, address))
-			goto out_up;
+		vma = expand_stack(mm, address);
+		if (!vma)
+			goto out;
 	}
 
 	/*
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -383,8 +383,9 @@ continue_fault:
 				goto bad_area;
 		}
 	}
-	if (expand_stack(vma, address))
-		goto bad_area;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto bad_area_nosemaphore;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
@@ -482,8 +483,9 @@ exit_exception:
 	 * Fix it, but check if it's kernel or user first..
 	 */
 bad_area:
-	insn = get_fault_insn(regs, insn);
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
+	insn = get_fault_insn(regs, insn);
 
 handle_kernel_fault:
 	do_kernel_fault(regs, si_code, fault_code, insn, address);
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -47,14 +47,15 @@ retry:
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto out;
-	else if (vma->vm_start <= address)
+	if (vma->vm_start <= address)
 		goto good_area;
-	else if (!(vma->vm_flags & VM_GROWSDOWN))
+	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto out;
-	else if (is_user && !ARCH_IS_STACKGROW(address))
-		goto out;
-	else if (expand_stack(vma, address))
+	if (is_user && !ARCH_IS_STACKGROW(address))
 		goto out;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto out_nosemaphore;
 
 good_area:
 	*code_out = SEGV_ACCERR;
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -485,8 +485,8 @@ static void do_fault(struct work_struct
 	flags |= FAULT_FLAG_REMOTE;
 
 	mmap_read_lock(mm);
-	vma = find_extend_vma(mm, address);
-	if (!vma || address < vma->vm_start)
+	vma = vma_lookup(mm, address);
+	if (!vma)
 		/* failed to get a vma in the right range */
 		goto out;
 
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -89,7 +89,7 @@ iopf_handle_single(struct iopf_fault *io
 
 	mmap_read_lock(mm);
 
-	vma = find_extend_vma(mm, prm->addr);
+	vma = vma_lookup(mm, prm->addr);
 	if (!vma)
 		/* Unmapped area */
 		goto out_put_mm;
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -317,7 +317,7 @@ create_elf_tables(struct linux_binprm *b
 	 */
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
-	vma = find_extend_vma_locked(mm, bprm->p, true);
+	vma = find_extend_vma_locked(mm, bprm->p);
 	mmap_write_unlock(mm);
 	if (!vma)
 		return -EFAULT;
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -209,7 +209,7 @@ static struct page *get_arg_page(struct
 	 */
 	if (write && pos < vma->vm_start) {
 		mmap_write_lock(mm);
-		ret = expand_downwards(vma, pos, true);
+		ret = expand_downwards(vma, pos);
 		if (unlikely(ret < 0)) {
 			mmap_write_unlock(mm);
 			return NULL;
@@ -860,7 +860,7 @@ int setup_arg_pages(struct linux_binprm
 		stack_base = vma->vm_start - stack_expand;
 #endif
 	current->mm->start_stack = bprm->p;
-	ret = expand_stack_locked(vma, stack_base, true);
+	ret = expand_stack_locked(vma, stack_base);
 	if (ret)
 		ret = -EFAULT;
 
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2810,18 +2810,11 @@ extern vm_fault_t filemap_page_mkwrite(s
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
-int expand_stack_locked(struct vm_area_struct *vma, unsigned long address,
-		bool write_locked);
-#define expand_stack(vma,addr) expand_stack_locked(vma,addr,false)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address);
+struct vm_area_struct *expand_stack(struct mm_struct * mm, unsigned long addr);
 
 /* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
-int expand_downwards(struct vm_area_struct *vma, unsigned long address,
-		bool write_locked);
-#if VM_GROWSUP
-extern int expand_upwards(struct vm_area_struct *vma, unsigned long address);
-#else
-  #define expand_upwards(vma, address) (0)
-#endif
+int expand_downwards(struct vm_area_struct *vma, unsigned long address);
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
@@ -2916,9 +2909,8 @@ unsigned long change_prot_numa(struct vm
 			unsigned long start, unsigned long end);
 #endif
 
-struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
-		unsigned long addr, bool write_locked);
+		unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1182,7 +1182,7 @@ static long __get_user_pages(struct mm_s
 
 		/* first iteration or cross vma bound */
 		if (!vma || start >= vma->vm_end) {
-			vma = find_extend_vma(mm, start);
+			vma = vma_lookup(mm, start);
 			if (!vma && in_gate_area(mm, start)) {
 				ret = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
@@ -1351,8 +1351,8 @@ int fixup_user_fault(struct mm_struct *m
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 retry:
-	vma = find_extend_vma(mm, address);
-	if (!vma || address < vma->vm_start)
+	vma = vma_lookup(mm, address);
+	if (!vma)
 		return -EFAULT;
 
 	if (!vma_permits_fault(vma, fault_flags))
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5364,7 +5364,7 @@ struct vm_area_struct *lock_mm_and_find_
 			goto fail;
 	}
 
-	if (expand_stack_locked(vma, addr, true))
+	if (expand_stack_locked(vma, addr))
 		goto fail;
 
 success:
@@ -5648,6 +5648,14 @@ int __access_remote_vm(struct mm_struct
 	if (mmap_read_lock_killable(mm))
 		return 0;
 
+	/* We might need to expand the stack to access it */
+	vma = vma_lookup(mm, addr);
+	if (!vma) {
+		vma = expand_stack(mm, addr);
+		if (!vma)
+			return 0;
+	}
+
 	/* ignore errors, just check how much was successfully transferred */
 	while (len) {
 		int bytes, ret, offset;
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1945,8 +1945,7 @@ static int acct_stack_growth(struct vm_a
  * PA-RISC uses this for its stack; IA64 for its Register Backing Store.
  * vma is the last one with address > vma->vm_end.  Have to extend vma.
  */
-int expand_upwards(struct vm_area_struct *vma, unsigned long address,
-		bool write_locked)
+static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *next;
@@ -1970,8 +1969,6 @@ int expand_upwards(struct vm_area_struct
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr = TASK_SIZE;
 
-	if (!write_locked)
-		return -EAGAIN;
 	next = find_vma_intersection(mm, vma->vm_end, gap_addr);
 	if (next && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
@@ -2039,15 +2036,18 @@ int expand_upwards(struct vm_area_struct
 
 /*
  * vma is the first one with address < vma->vm_start.  Have to extend vma.
+ * mmap_lock held for writing.
  */
-int expand_downwards(struct vm_area_struct *vma, unsigned long address,
-		bool write_locked)
+int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
 	struct vm_area_struct *prev;
 	int error = 0;
 
+	if (!(vma->vm_flags & VM_GROWSDOWN))
+		return -EFAULT;
+
 	address &= PAGE_MASK;
 	if (address < mmap_min_addr || address < FIRST_USER_ADDRESS)
 		return -EPERM;
@@ -2060,8 +2060,6 @@ int expand_downwards(struct vm_area_stru
 		    vma_is_accessible(prev) &&
 		    (address - prev->vm_end < stack_guard_gap))
 			return -ENOMEM;
-		if (!write_locked && (prev->vm_end == address))
-			return -EAGAIN;
 	}
 
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
@@ -2139,14 +2137,12 @@ static int __init cmdline_parse_stack_gu
 __setup("stack_guard_gap=", cmdline_parse_stack_guard_gap);
 
 #ifdef CONFIG_STACK_GROWSUP
-int expand_stack_locked(struct vm_area_struct *vma, unsigned long address,
-		bool write_locked)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
 {
-	return expand_upwards(vma, address, write_locked);
+	return expand_upwards(vma, address);
 }
 
-struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm,
-		unsigned long addr, bool write_locked)
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma, *prev;
 
@@ -2156,23 +2152,21 @@ struct vm_area_struct *find_extend_vma_l
 		return vma;
 	if (!prev)
 		return NULL;
-	if (expand_stack_locked(prev, addr, write_locked))
+	if (expand_stack_locked(prev, addr))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED)
 		populate_vma_page_range(prev, addr, prev->vm_end, NULL);
 	return prev;
 }
 #else
-int expand_stack_locked(struct vm_area_struct *vma, unsigned long address,
-		bool write_locked)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
 {
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
 		return -EINVAL;
-	return expand_downwards(vma, address, write_locked);
+	return expand_downwards(vma, address);
 }
 
-struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm,
-		unsigned long addr, bool write_locked)
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
 	unsigned long start;
@@ -2184,7 +2178,7 @@ struct vm_area_struct *find_extend_vma_l
 	if (vma->vm_start <= addr)
 		return vma;
 	start = vma->vm_start;
-	if (expand_stack_locked(vma, addr, write_locked))
+	if (expand_stack_locked(vma, addr))
 		return NULL;
 	if (vma->vm_flags & VM_LOCKED)
 		populate_vma_page_range(vma, addr, start, NULL);
@@ -2192,12 +2186,91 @@ struct vm_area_struct *find_extend_vma_l
 }
 #endif
 
-struct vm_area_struct *find_extend_vma(struct mm_struct *mm,
-		unsigned long addr)
+/*
+ * IA64 has some horrid mapping rules: it can expand both up and down,
+ * but with various special rules.
+ *
+ * We'll get rid of this architecture eventually, so the ugliness is
+ * temporary.
+ */
+#ifdef CONFIG_IA64
+static inline bool vma_expand_ok(struct vm_area_struct *vma, unsigned long addr)
+{
+	return REGION_NUMBER(addr) == REGION_NUMBER(vma->vm_start) &&
+		REGION_OFFSET(addr) < RGN_MAP_LIMIT;
+}
+
+/*
+ * IA64 stacks grow down, but there's a special register backing store
+ * that can grow up. Only sequentially, though, so the new address must
+ * match vm_end.
+ */
+static inline int vma_expand_up(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (!vma_expand_ok(vma, addr))
+		return -EFAULT;
+	if (vma->vm_end != (addr & PAGE_MASK))
+		return -EFAULT;
+	return expand_upwards(vma, addr);
+}
+
+static inline bool vma_expand_down(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (!vma_expand_ok(vma, addr))
+		return -EFAULT;
+	return expand_downwards(vma, addr);
+}
+
+#elif defined(CONFIG_STACK_GROWSUP)
+
+#define vma_expand_up(vma,addr) expand_upwards(vma, addr)
+#define vma_expand_down(vma, addr) (-EFAULT)
+
+#else
+
+#define vma_expand_up(vma,addr) (-EFAULT)
+#define vma_expand_down(vma, addr) expand_downwards(vma, addr)
+
+#endif
+
+/*
+ * expand_stack(): legacy interface for page faulting. Don't use unless
+ * you have to.
+ *
+ * This is called with the mm locked for reading, drops the lock, takes
+ * the lock for writing, tries to look up a vma again, expands it if
+ * necessary, and downgrades the lock to reading again.
+ *
+ * If no vma is found or it can't be expanded, it returns NULL and has
+ * dropped the lock.
+ */
+struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 {
-	return find_extend_vma_locked(mm, addr, false);
+	struct vm_area_struct *vma, *prev;
+
+	mmap_read_unlock(mm);
+	if (mmap_write_lock_killable(mm))
+		return NULL;
+
+	vma = find_vma_prev(mm, addr, &prev);
+	if (vma && vma->vm_start <= addr)
+		goto success;
+
+	if (prev && !vma_expand_up(prev, addr)) {
+		vma = prev;
+		goto success;
+	}
+
+	if (vma && !vma_expand_down(vma, addr))
+		goto success;
+
+	mmap_write_unlock(mm);
+	return NULL;
+
+success:
+	mmap_write_downgrade(mm);
+	return vma;
 }
-EXPORT_SYMBOL_GPL(find_extend_vma);
 
 /*
  * Ok - we have the memory areas we should free on a maple tree so release them,
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -682,24 +682,20 @@ struct vm_area_struct *find_vma(struct m
 EXPORT_SYMBOL(find_vma);
 
 /*
- * find a VMA
- * - we don't extend stack VMAs under NOMMU conditions
- */
-struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr)
-{
-	return find_vma(mm, addr);
-}
-
-/*
  * expand a stack to a given address
  * - not supported under NOMMU conditions
  */
-int expand_stack_locked(struct vm_area_struct *vma, unsigned long address,
-		bool write_locked)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long addr)
 {
 	return -ENOMEM;
 }
 
+struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
+{
+	mmap_read_unlock(mm);
+	return NULL;
+}
+
 /*
  * look up the first VMA exactly that exactly matches addr
  * - should be called with mm->mmap_lock at least held readlocked


