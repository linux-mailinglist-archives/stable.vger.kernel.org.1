Return-Path: <stable+bounces-91725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D39BF7EF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 21:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1613028353A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977EA20C032;
	Wed,  6 Nov 2024 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eX3DvZ9h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2120A5CB;
	Wed,  6 Nov 2024 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924565; cv=none; b=ihoGUE09Sx8UYkffx9+YlR2ujYY23rJHEq/3Qa5LHKSUdYLxGCfp599WqoVaexyrtpnPzjxh+eVFUtmWGDMC4oPIwLXSKQW2x6t65oqvuToTFkh8gSGtEDS5GUHr/2+yPiMpaDv41xo2MkXwYPgGwrK0R8AvssmxHHIvxC8jhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924565; c=relaxed/simple;
	bh=loFtezzgK7wQHacz/t8Le8GXSKyyBX6qr0+hp8N/srY=;
	h=Date:To:From:Subject:Message-Id; b=RLuC0ucpwABYMT2LbafdY7dWCrX3iIcbqgjr5IbyJ/YnqX0WHtbdRfACObXXL0SGCSLFx2tAuFDbGS4VdXRI/fZrtz29j2815LXN2aZ1SM19R+kJxty+ar1XQPTIdXs1taneLDxWBrB9LO57RRZgulLcfLI7cu5UvwASehiPJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eX3DvZ9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD061C4CEC6;
	Wed,  6 Nov 2024 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730924564;
	bh=loFtezzgK7wQHacz/t8Le8GXSKyyBX6qr0+hp8N/srY=;
	h=Date:To:From:Subject:From;
	b=eX3DvZ9hNxjcMJYCl4BDggPnlOva2AB7SkC2WE8Bn720Bqp8NXVatXeK/5Obsb86O
	 sqRKOC+l4H877re0Tx8WVsi7XPIBsL+CKnF5KuS2W1XaJGOa34HNmViYVp0CvHWGfA
	 +JU4w87+oIbtha5WIZDawQ5vNyFC8rO5kTNbTRkQ=
Date: Wed, 06 Nov 2024 12:22:43 -0800
To: mm-commits@vger.kernel.org,willy@infradead.org,vbabka@suse.cz,stable@vger.kernel.org,seanjc@google.com,hughd@google.com,roman.gushchin@linux.dev,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-page_alloc-move-mlocked-flag-clearance-into-free_pages_prepare.patch added to mm-hotfixes-unstable branch
Message-Id: <20241106202244.CD061C4CEC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: page_alloc: move mlocked flag clearance into free_pages_prepare()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-page_alloc-move-mlocked-flag-clearance-into-free_pages_prepare.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-page_alloc-move-mlocked-flag-clearance-into-free_pages_prepare.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Roman Gushchin <roman.gushchin@linux.dev>
Subject: mm: page_alloc: move mlocked flag clearance into free_pages_prepare()
Date: Wed, 6 Nov 2024 19:53:54 +0000

Syzbot reported a bad page state problem caused by a page being freed
using free_page() still having a mlocked flag at free_pages_prepare()
stage:

  BUG: Bad page state in process syz.5.504  pfn:61f45
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x61f45
  flags: 0xfff00000080204(referenced|workingset|mlocked|node=0|zone=1|lastcpupid=0x7ff)
  raw: 00fff00000080204 0000000000000000 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
  page_owner tracks the page as allocated
  page last allocated via order 0, migratetype Unmovable, gfp_mask 0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 8443, tgid 8442 (syz.5.504), ts 201884660643, free_ts 201499827394
   set_page_owner include/linux/page_owner.h:32 [inline]
   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
   prep_new_page mm/page_alloc.c:1545 [inline]
   get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
   alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
   kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
   kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
   kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5488 [inline]
   kvm_dev_ioctl+0x12dc/0x2240 virt/kvm/kvm_main.c:5530
   __do_compat_sys_ioctl fs/ioctl.c:1007 [inline]
   __se_compat_sys_ioctl+0x510/0xc90 fs/ioctl.c:950
   do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
   __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
   do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
   entry_SYSENTER_compat_after_hwframe+0x84/0x8e
  page last free pid 8399 tgid 8399 stack trace:
   reset_page_owner include/linux/page_owner.h:25 [inline]
   free_pages_prepare mm/page_alloc.c:1108 [inline]
   free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
   folios_put_refs+0x76c/0x860 mm/swap.c:1007
   free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
   __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
   tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
   tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
   tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
   tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
   exit_mmap+0x496/0xc40 mm/mmap.c:1926
   __mmput+0x115/0x390 kernel/fork.c:1348
   exit_mm+0x220/0x310 kernel/exit.c:571
   do_exit+0x9b2/0x28e0 kernel/exit.c:926
   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
   __do_sys_exit_group kernel/exit.c:1099 [inline]
   __se_sys_exit_group kernel/exit.c:1097 [inline]
   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  Modules linked in:
  CPU: 0 UID: 0 PID: 8442 Comm: syz.5.504 Not tainted 6.12.0-rc6-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94 [inline]
   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
   bad_page+0x176/0x1d0 mm/page_alloc.c:501
   free_page_is_bad mm/page_alloc.c:918 [inline]
   free_pages_prepare mm/page_alloc.c:1100 [inline]
   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
   kvm_destroy_vm virt/kvm/kvm_main.c:1327 [inline]
   kvm_put_kvm+0xc75/0x1350 virt/kvm/kvm_main.c:1386
   kvm_vcpu_release+0x54/0x60 virt/kvm/kvm_main.c:4143
   __fput+0x23f/0x880 fs/file_table.c:431
   task_work_run+0x24f/0x310 kernel/task_work.c:239
   exit_task_work include/linux/task_work.h:43 [inline]
   do_exit+0xa2f/0x28e0 kernel/exit.c:939
   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
   __do_sys_exit_group kernel/exit.c:1099 [inline]
   __se_sys_exit_group kernel/exit.c:1097 [inline]
   __ia32_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
   ia32_sys_call+0x2624/0x2630 arch/x86/include/generated/asm/syscalls_32.h:253
   do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
   __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
   do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
   entry_SYSENTER_compat_after_hwframe+0x84/0x8e
  RIP: 0023:0xf745d579
  Code: Unable to access opcode bytes at 0xf745d54f.
  RSP: 002b:00000000f75afd6c EFLAGS: 00000206 ORIG_RAX: 00000000000000fc
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 00000000ffffff9c RDI: 00000000f744cff4
  RBP: 00000000f717ae61 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   </TASK>

The problem was originally introduced by commit b109b87050df ("mm/munlock:
replace clear_page_mlock() by final clearance"): it was focused on
handling pagecache and anonymous memory and wasn't suitable for lower
level get_page()/free_page() API's used for example by KVM, as with this
reproducer.

Fix it by moving the mlocked flag clearance down to free_page_prepare().

The bug itself if fairly old and harmless (aside from generating these
warnings), aside from a small memory leak - "bad" pages are stopped from
being allocated again.

Link: https://lkml.kernel.org/r/20241106195354.270757-1-roman.gushchin@linux.dev
Fixes: b109b87050df ("mm/munlock: replace clear_page_mlock() by final clearance")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Reported-by: syzbot+e985d3026c4fd041578e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6729f475.050a0220.701a.0019.GAE@google.com
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |   15 +++++++++++++++
 mm/swap.c       |   14 --------------
 2 files changed, 15 insertions(+), 14 deletions(-)

--- a/mm/page_alloc.c~mm-page_alloc-move-mlocked-flag-clearance-into-free_pages_prepare
+++ a/mm/page_alloc.c
@@ -1048,6 +1048,7 @@ __always_inline bool free_pages_prepare(
 	bool skip_kasan_poison = should_skip_kasan_poison(page);
 	bool init = want_init_on_free();
 	bool compound = PageCompound(page);
+	struct folio *folio = page_folio(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1057,6 +1058,20 @@ __always_inline bool free_pages_prepare(
 	if (memcg_kmem_online() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
 
+	/*
+	 * In rare cases, when truncation or holepunching raced with
+	 * munlock after VM_LOCKED was cleared, Mlocked may still be
+	 * found set here.  This does not indicate a problem, unless
+	 * "unevictable_pgs_cleared" appears worryingly large.
+	 */
+	if (unlikely(folio_test_mlocked(folio))) {
+		long nr_pages = folio_nr_pages(folio);
+
+		__folio_clear_mlocked(folio);
+		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
+		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
+	}
+
 	if (unlikely(PageHWPoison(page)) && !order) {
 		/* Do not let hwpoison pages hit pcplists/buddy */
 		reset_page_owner(page, order);
--- a/mm/swap.c~mm-page_alloc-move-mlocked-flag-clearance-into-free_pages_prepare
+++ a/mm/swap.c
@@ -78,20 +78,6 @@ static void __page_cache_release(struct
 		lruvec_del_folio(*lruvecp, folio);
 		__folio_clear_lru_flags(folio);
 	}
-
-	/*
-	 * In rare cases, when truncation or holepunching raced with
-	 * munlock after VM_LOCKED was cleared, Mlocked may still be
-	 * found set here.  This does not indicate a problem, unless
-	 * "unevictable_pgs_cleared" appears worryingly large.
-	 */
-	if (unlikely(folio_test_mlocked(folio))) {
-		long nr_pages = folio_nr_pages(folio);
-
-		__folio_clear_mlocked(folio);
-		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
-		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
-	}
 }
 
 /*
_

Patches currently in -mm which might be from roman.gushchin@linux.dev are

signal-restore-the-override_rlimit-logic.patch
mm-page_alloc-move-mlocked-flag-clearance-into-free_pages_prepare.patch


