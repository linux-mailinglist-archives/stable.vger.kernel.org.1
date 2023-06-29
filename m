Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E811742C3D
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjF2Sqv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjF2Sqm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43130C5
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6426615E2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AE7C433C0;
        Thu, 29 Jun 2023 18:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064398;
        bh=w47RZTGQd++Z25Yjwne8Rt5O4Q0+1xPz55Nx4wJ0Yvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3Ou5yGBLx/YqvCymAnClcTwJhmzR1yhCWBepjbZzpTOb0aQgxn9ueCsQ+6aewJa1
         NOVbop03h/CL/GxXGwtatGuaox27qpXNmj6KSS80NPDQUvtGxUzR6OdjyJ7MKThOZ8
         HWC8HMSzZaD8zE+g+iVbiitdOTEnY495ATJq1RZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.3 19/29] mm/fault: convert remaining simple cases to lock_mm_and_find_vma()
Date:   Thu, 29 Jun 2023 20:43:49 +0200
Message-ID: <20230629184152.503617955@linuxfoundation.org>
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

commit a050ba1e7422f2cc60ff8bfde3f96d34d00cb585 upstream.

This does the simple pattern conversion of alpha, arc, csky, hexagon,
loongarch, nios2, sh, sparc32, and xtensa to the lock_mm_and_find_vma()
helper.  They all have the regular fault handling pattern without odd
special cases.

The remaining architectures all have something that keeps us from a
straightforward conversion: ia64 and parisc have stacks that can grow
both up as well as down (and ia64 has special address region checks).

And m68k, microblaze, openrisc, sparc64, and um end up having extra
rules about only expanding the stack down a limited amount below the
user space stack pointer.  That is something that x86 used to do too
(long long ago), and it probably could just be skipped, but it still
makes the conversion less than trivial.

Note that this conversion was done manually and with the exception of
alpha without any build testing, because I have a fairly limited cross-
building environment.  The cases are all simple, and I went through the
changes several times, but...

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/alpha/Kconfig         |    1 +
 arch/alpha/mm/fault.c      |   13 +++----------
 arch/arc/Kconfig           |    1 +
 arch/arc/mm/fault.c        |   11 +++--------
 arch/csky/Kconfig          |    1 +
 arch/csky/mm/fault.c       |   22 +++++-----------------
 arch/hexagon/Kconfig       |    1 +
 arch/hexagon/mm/vm_fault.c |   18 ++++--------------
 arch/loongarch/Kconfig     |    1 +
 arch/loongarch/mm/fault.c  |   16 ++++++----------
 arch/nios2/Kconfig         |    1 +
 arch/nios2/mm/fault.c      |   17 ++---------------
 arch/sh/Kconfig            |    1 +
 arch/sh/mm/fault.c         |   17 ++---------------
 arch/sparc/Kconfig         |    1 +
 arch/sparc/mm/fault_32.c   |   32 ++++++++------------------------
 arch/xtensa/Kconfig        |    1 +
 arch/xtensa/mm/fault.c     |   14 +++-----------
 18 files changed, 45 insertions(+), 124 deletions(-)

--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -29,6 +29,7 @@ config ALPHA
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_MOD_ARCH_SPECIFIC
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -119,20 +119,12 @@ do_page_fault(unsigned long address, uns
 		flags |= FAULT_FLAG_USER;
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 
 	/* Ok, we have a good vm_area for this memory access, so
 	   we can handle it.  */
- good_area:
 	si_code = SEGV_ACCERR;
 	if (cause < 0) {
 		if (!(vma->vm_flags & VM_EXEC))
@@ -192,6 +184,7 @@ retry:
  bad_area:
 	mmap_read_unlock(mm);
 
+ bad_area_nosemaphore:
 	if (user_mode(regs))
 		goto do_sigsegv;
 
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -41,6 +41,7 @@ config ARC
 	select HAVE_PERF_EVENTS
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -113,15 +113,9 @@ void do_page_fault(unsigned long address
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (unlikely(address < vma->vm_start)) {
-		if (!(vma->vm_flags & VM_GROWSDOWN) || expand_stack(vma, address))
-			goto bad_area;
-	}
+		goto bad_area_nosemaphore;
 
 	/*
 	 * vm_area is good, now check permissions for this memory access
@@ -161,6 +155,7 @@ retry:
 bad_area:
 	mmap_read_unlock(mm);
 
+bad_area_nosemaphore:
 	/*
 	 * Major/minor page fault accounting
 	 * (in case of retry we only land here once)
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -96,6 +96,7 @@ config CSKY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select LOCK_MM_AND_FIND_VMA
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -97,13 +97,12 @@ static inline void mm_fault_error(struct
 	BUG();
 }
 
-static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
+static inline void bad_area_nosemaphore(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
 {
 	/*
 	 * Something tried to access memory that isn't in our memory map.
 	 * Fix it, but check if it's kernel or user first.
 	 */
-	mmap_read_unlock(mm);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		do_trap(regs, SIGSEGV, code, addr);
@@ -238,20 +237,9 @@ asmlinkage void do_page_fault(struct pt_
 	if (is_write(regs))
 		flags |= FAULT_FLAG_WRITE;
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, addr);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma)) {
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (likely(vma->vm_start <= addr))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (unlikely(expand_stack(vma, addr))) {
-		bad_area(regs, mm, code, addr);
+		bad_area_nosemaphore(regs, mm, code, addr);
 		return;
 	}
 
@@ -259,11 +247,11 @@ retry:
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it.
 	 */
-good_area:
 	code = SEGV_ACCERR;
 
 	if (unlikely(access_error(regs, vma))) {
-		bad_area(regs, mm, code, addr);
+		mmap_read_unlock(mm);
+		bad_area_nosemaphore(regs, mm, code, addr);
 		return;
 	}
 
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -28,6 +28,7 @@ config HEXAGON
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
 	select ARCH_WANT_LD_ORPHAN_WARN
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -57,21 +57,10 @@ void do_page_fault(unsigned long address
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto bad_area;
+	vma = lock_mm_and_find_vma(mm, address, regs);
+	if (unlikely(!vma))
+		goto bad_area_nosemaphore;
 
-	if (vma->vm_start <= address)
-		goto good_area;
-
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-
-	if (expand_stack(vma, address))
-		goto bad_area;
-
-good_area:
 	/* Address space is OK.  Now check access rights. */
 	si_code = SEGV_ACCERR;
 
@@ -143,6 +132,7 @@ good_area:
 bad_area:
 	mmap_read_unlock(mm);
 
+bad_area_nosemaphore:
 	if (user_mode(regs)) {
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 		return;
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -125,6 +125,7 @@ config LOONGARCH
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
+	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_MERGE_VMAS if MMU
 	select MODULES_USE_ELF_RELA if MODULES
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -169,22 +169,18 @@ static void __kprobes __do_page_fault(st
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (!expand_stack(vma, address))
-		goto good_area;
+	vma = lock_mm_and_find_vma(mm, address, regs);
+	if (unlikely(!vma))
+		goto bad_area_nosemaphore;
+	goto good_area;
+
 /*
  * Something tried to access memory that isn't in our memory map..
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
 	do_sigsegv(regs, write, address, si_code);
 	return;
 
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -16,6 +16,7 @@ config NIOS2
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_KGDB
 	select IRQ_DOMAIN
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -86,27 +86,14 @@ asmlinkage void do_page_fault(struct pt_
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (!mmap_read_trylock(mm)) {
-		if (!user_mode(regs) && !search_exception_tables(regs->ea))
-			goto bad_area_nosemaphore;
 retry:
-		mmap_read_lock(mm);
-	}
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 /*
  * Ok, we have a good vm_area for this memory access, so
  * we can handle it..
  */
-good_area:
 	code = SEGV_ACCERR;
 
 	switch (cause) {
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -56,6 +56,7 @@ config SUPERH
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_FORCED_THREADING
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
 	select NO_DMA if !MMU && !DMA_COHERENT
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -439,21 +439,9 @@ asmlinkage void __kprobes do_page_fault(
 	}
 
 retry:
-	mmap_read_lock(mm);
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
 
@@ -461,7 +449,6 @@ retry:
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
-good_area:
 	if (unlikely(access_error(error_code, vma))) {
 		bad_area_access_error(regs, error_code, address);
 		return;
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -56,6 +56,7 @@ config SPARC32
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
+	select LOCK_MM_AND_FIND_VMA
 	select OLD_SIGACTION
 	select ZONE_DMA
 
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -143,28 +143,19 @@ asmlinkage void do_sparc_fault(struct pt
 	if (pagefault_disabled() || !mm)
 		goto no_context;
 
+	if (!from_user && address >= PAGE_OFFSET)
+		goto no_context;
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 retry:
-	mmap_read_lock(mm);
-
-	if (!from_user && address >= PAGE_OFFSET)
-		goto bad_area;
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
-good_area:
 	code = SEGV_ACCERR;
 	if (write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -321,17 +312,9 @@ static void force_user_fault(unsigned lo
 
 	code = SEGV_MAPERR;
 
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
-good_area:
+		goto bad_area_nosemaphore;
 	code = SEGV_ACCERR;
 	if (write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -350,6 +333,7 @@ good_area:
 	return;
 bad_area:
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
 	__do_fault_siginfo(code, SIGSEGV, tsk->thread.kregs, address);
 	return;
 
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -49,6 +49,7 @@ config XTENSA
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_DOMAIN
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
 	select TRACE_IRQFLAGS_SUPPORT
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -130,23 +130,14 @@ void do_page_fault(struct pt_regs *regs)
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 
 	/* Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
 
-good_area:
 	code = SEGV_ACCERR;
 
 	if (is_write) {
@@ -205,6 +196,7 @@ good_area:
 	 */
 bad_area:
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
 	if (user_mode(regs)) {
 		force_sig_fault(SIGSEGV, code, (void *) address);
 		return;


