Return-Path: <stable+bounces-57999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AAC926EEF
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 07:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C379C1F23078
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 05:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94558185E50;
	Thu,  4 Jul 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mSqMWTcX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BBFBF6;
	Thu,  4 Jul 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071719; cv=none; b=ooq+HYzwv3pHjymOR023tEJi3O+eW+3vVOQRNC00LvVNE03/rlUuz2o5EiAtiySwwoN1i+ya6+kKuAV7lchC42b8toUdtRsWMXynKhd8xotrVTYnTrcImyVW7IOUzp69YgzU3IO+K+3iGJetQ2Oj50i1GURMSrBVSmlf6ycnSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071719; c=relaxed/simple;
	bh=knRQK0qpQhNQla2FW7ex9IsfaJtkbkjIiTQvkIQyjo8=;
	h=Date:To:From:Subject:Message-Id; b=O5ZaNF3ZZ0TQDjifDqYIL5kxwQ3zXFXfhz3CBdjDohMfhr64DRxtDAbV2J1JwjN4EGeW/8+d1LmVQN/wVBcy68bcKUfpQt+aeUJ1sDfA+SnufMaleavvGZ3kbYrTvRlLJAUN3EOE52YOJ3rZP/0F9gVJLbra2owYjJMw9BJdu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mSqMWTcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2586C3277B;
	Thu,  4 Jul 2024 05:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720071718;
	bh=knRQK0qpQhNQla2FW7ex9IsfaJtkbkjIiTQvkIQyjo8=;
	h=Date:To:From:Subject:From;
	b=mSqMWTcXNAP4lJEtrhwJeta34JEDCnhGNeXVwnpGGo/C0wiZmX5Y6JNGo43fKy8iA
	 F51HccRFNEwZVDzUEjqW2qNZFZJBHQlm/lYl6V/aX1O/tgJK1hKsF64i0xmXs0LpX5
	 +I7bxzxE5zNDL623F37wY1qzuIY0KWyOneqRLseA=
Date: Wed, 03 Jul 2024 22:41:58 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,vivek.kasireddy@intel.com,stable@vger.kernel.org,riel@surriel.com,peterx@redhat.com,paulmck@kernel.org,oliver.sang@intel.com,david@redhat.com,cl@linux.com,yang@os.amperecomputing.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-page_ref-remove-folio_try_get_rcu.patch removed from -mm tree
Message-Id: <20240704054158.A2586C3277B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: page_ref: remove folio_try_get_rcu()
has been removed from the -mm tree.  Its filename was
     mm-page_ref-remove-folio_try_get_rcu.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Yang Shi <yang@os.amperecomputing.com>
Subject: mm: page_ref: remove folio_try_get_rcu()
Date: Tue, 25 Jun 2024 13:53:50 -0700

The below bug was reported on a non-SMP kernel:

[  275.267158][ T4335] ------------[ cut here ]------------
[  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
[  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
[  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
[  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[  275.272813][ T4335] RSP: 0018:ffffc90005dcf650 EFLAGS: 00010202
[  275.273346][ T4335] RAX: 0000000000000246 RBX: ffffea00066e0000 RCX: 0000000000000000
[  275.274032][ T4335] RDX: fffff94000cdc007 RSI: 0000000000000004 RDI: ffffea00066e0034
[  275.274719][ T4335] RBP: ffffea00066e0000 R08: 0000000000000000 R09: fffff94000cdc006
[  275.275404][ T4335] R10: ffffea00066e0037 R11: 0000000000000000 R12: 0000000000000136
[  275.276106][ T4335] R13: ffffea00066e0034 R14: dffffc0000000000 R15: ffffea00066e0008
[  275.276790][ T4335] FS:  00007fa2f9b61740(0000) GS:ffffffff89d0d000(0000) knlGS:0000000000000000
[  275.277570][ T4335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  275.278143][ T4335] CR2: 00007fa2f6c00000 CR3: 0000000134b04000 CR4: 00000000000406f0
[  275.278833][ T4335] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  275.279521][ T4335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  275.280201][ T4335] Call Trace:
[  275.280499][ T4335]  <TASK>
[ 275.280751][ T4335] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
[ 275.281087][ T4335] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153)
[ 275.281463][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.281884][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.282300][ T4335] ? do_error_trap (arch/x86/kernel/traps.c:174)
[ 275.282711][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.283129][ T4335] ? handle_invalid_op (arch/x86/kernel/traps.c:212)
[ 275.283561][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.283990][ T4335] ? exc_invalid_op (arch/x86/kernel/traps.c:264)
[ 275.284415][ T4335] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568)
[ 275.284859][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.285278][ T4335] try_grab_folio (mm/gup.c:148)
[ 275.285684][ T4335] __get_user_pages (mm/gup.c:1297 (discriminator 1))
[ 275.286111][ T4335] ? __pfx___get_user_pages (mm/gup.c:1188)
[ 275.286579][ T4335] ? __pfx_validate_chain (kernel/locking/lockdep.c:3825)
[ 275.287034][ T4335] ? mark_lock (kernel/locking/lockdep.c:4656 (discriminator 1))
[ 275.287416][ T4335] __gup_longterm_locked (mm/gup.c:1509 mm/gup.c:2209)
[ 275.288192][ T4335] ? __pfx___gup_longterm_locked (mm/gup.c:2204)
[ 275.288697][ T4335] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
[ 275.289135][ T4335] ? __pfx___might_resched (kernel/sched/core.c:10106)
[ 275.289595][ T4335] pin_user_pages_remote (mm/gup.c:3350)
[ 275.290041][ T4335] ? __pfx_pin_user_pages_remote (mm/gup.c:3350)
[ 275.290545][ T4335] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1))
[ 275.290961][ T4335] ? mm_access (kernel/fork.c:1573)
[ 275.291353][ T4335] process_vm_rw_single_vec+0x142/0x360
[ 275.291900][ T4335] ? __pfx_process_vm_rw_single_vec+0x10/0x10
[ 275.292471][ T4335] ? mm_access (kernel/fork.c:1573)
[ 275.292859][ T4335] process_vm_rw_core+0x272/0x4e0
[ 275.293384][ T4335] ? hlock_class (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228)
[ 275.293780][ T4335] ? __pfx_process_vm_rw_core+0x10/0x10
[ 275.294350][ T4335] process_vm_rw (mm/process_vm_access.c:284)
[ 275.294748][ T4335] ? __pfx_process_vm_rw (mm/process_vm_access.c:259)
[ 275.295197][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
[ 275.295634][ T4335] __x64_sys_process_vm_readv (mm/process_vm_access.c:291)
[ 275.296139][ T4335] ? syscall_enter_from_user_mode (kernel/entry/common.c:94 kernel/entry/common.c:112)
[ 275.296642][ T4335] do_syscall_64 (arch/x86/entry/common.c:51 (discriminator 1) arch/x86/entry/common.c:82 (discriminator 1))
[ 275.297032][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
[ 275.297470][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
[ 275.297988][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
[ 275.298389][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
[ 275.298906][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
[ 275.299304][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
[ 275.299703][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
[ 275.300115][ T4335] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)

This BUG is the VM_BUG_ON(!in_atomic() && !irqs_disabled()) assertion in
folio_ref_try_add_rcu() for non-SMP kernel.

The process_vm_readv() calls GUP to pin the THP. An optimization for
pinning THP instroduced by commit 57edfcfd3419 ("mm/gup: accelerate thp
gup even for "pages != NULL"") calls try_grab_folio() to pin the THP,
but try_grab_folio() is supposed to be called in atomic context for
non-SMP kernel, for example, irq disabled or preemption disabled, due to
the optimization introduced by commit e286781d5f2e ("mm: speculative
page references").

The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
boundaries") is not actually the root cause although it was bisected to.
It just makes the problem exposed more likely.

The follow up discussion suggested the optimization for non-SMP kernel
may be out-dated and not worth it anymore [1].  So removing the
optimization to silence the BUG.

However calling try_grab_folio() in GUP slow path actually is
unnecessary, so the following patch will clean this up.

[1] https://lore.kernel.org/linux-mm/821cf1d6-92b9-4ac4-bacc-d8f2364ac14f@paulmck-laptop/

Link: https://lkml.kernel.org/r/20240625205350.1777481-1-yang@os.amperecomputing.com
Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Tested-by: Oliver Sang <oliver.sang@intel.com>
Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/page_ref.h |   49 +------------------------------------
 mm/filemap.c             |   10 +++----
 mm/gup.c                 |    2 -
 3 files changed, 8 insertions(+), 53 deletions(-)

--- a/include/linux/page_ref.h~mm-page_ref-remove-folio_try_get_rcu
+++ a/include/linux/page_ref.h
@@ -258,54 +258,9 @@ static inline bool folio_try_get(struct
 	return folio_ref_add_unless(folio, 1, 0);
 }
 
-static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
+static inline bool folio_ref_try_add(struct folio *folio, int count)
 {
-#ifdef CONFIG_TINY_RCU
-	/*
-	 * The caller guarantees the folio will not be freed from interrupt
-	 * context, so (on !SMP) we only need preemption to be disabled
-	 * and TINY_RCU does that for us.
-	 */
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
-	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
-	folio_ref_add(folio, count);
-#else
-	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
-		/* Either the folio has been freed, or will be freed. */
-		return false;
-	}
-#endif
-	return true;
-}
-
-/**
- * folio_try_get_rcu - Attempt to increase the refcount on a folio.
- * @folio: The folio.
- *
- * This is a version of folio_try_get() optimised for non-SMP kernels.
- * If you are still holding the rcu_read_lock() after looking up the
- * page and know that the page cannot have its refcount decreased to
- * zero in interrupt context, you can use this instead of folio_try_get().
- *
- * Example users include get_user_pages_fast() (as pages are not unmapped
- * from interrupt context) and the page cache lookups (as pages are not
- * truncated from interrupt context).  We also know that pages are not
- * frozen in interrupt context for the purposes of splitting or migration.
- *
- * You can also use this function if you're holding a lock that prevents
- * pages being frozen & removed; eg the i_pages lock for the page cache
- * or the mmap_lock or page table lock for page tables.  In this case,
- * it will always succeed, and you could have used a plain folio_get(),
- * but it's sometimes more convenient to have a common function called
- * from both locked and RCU-protected contexts.
- *
- * Return: True if the reference count was successfully incremented.
- */
-static inline bool folio_try_get_rcu(struct folio *folio)
-{
-	return folio_ref_try_add_rcu(folio, 1);
+	return folio_ref_add_unless(folio, count, 0);
 }
 
 static inline int page_ref_freeze(struct page *page, int count)
--- a/mm/filemap.c~mm-page_ref-remove-folio_try_get_rcu
+++ a/mm/filemap.c
@@ -1847,7 +1847,7 @@ repeat:
 	if (!folio || xa_is_value(folio))
 		goto out;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto repeat;
 
 	if (unlikely(folio != xas_reload(&xas))) {
@@ -2001,7 +2001,7 @@ retry:
 	if (!folio || xa_is_value(folio))
 		return folio;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto reset;
 
 	if (unlikely(folio != xas_reload(xas))) {
@@ -2181,7 +2181,7 @@ unsigned filemap_get_folios_contig(struc
 		if (xa_is_value(folio))
 			goto update_start;
 
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -2313,7 +2313,7 @@ static void filemap_get_read_batch(struc
 			break;
 		if (xa_is_sibling(folio))
 			break;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -3472,7 +3472,7 @@ static struct folio *next_uptodate_folio
 			continue;
 		if (folio_test_locked(folio))
 			continue;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			continue;
 		/* Has the page moved or been split? */
 		if (unlikely(folio != xas_reload(xas)))
--- a/mm/gup.c~mm-page_ref-remove-folio_try_get_rcu
+++ a/mm/gup.c
@@ -76,7 +76,7 @@ retry:
 	folio = page_folio(page);
 	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
 		return NULL;
-	if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
+	if (unlikely(!folio_ref_try_add(folio, refs)))
 		return NULL;
 
 	/*
_

Patches currently in -mm which might be from yang@os.amperecomputing.com are

mm-gup-stop-abusing-try_grab_folio.patch


