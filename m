Return-Path: <stable+bounces-91724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B29BF7A4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 20:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C032BB2265D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360520820D;
	Wed,  6 Nov 2024 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FjzeKH8L"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC813A26F
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922857; cv=none; b=JslCbs8/Kh16NaTZ+ovP25kraQW3LqfOflE+GNcW6RpRfVcGfnw3hg5oY+MzAvoS/+L91Hb3SJak1urXlsCi7UhZvlGUkyYhD7x4EhT4L7RUNXisWBFs/aMHmMp+yheMnvjo7HYehjHRxMIQ8jH6OGqqQzkyJuvHTZl0CWUi5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922857; c=relaxed/simple;
	bh=6UqYyiZMzpE4tr9s0Vmuz+sUu7GfYlpzAYxMvxw0Rb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmnbkX/+Y19+dWdc4PxH7VPZ8JXYOUfmAHRlBoO1JgUK9wjFP9+ix0TDccp/eDpZelUT29iEIR/MCCR+kYMU8Q+4Ue31kKLlG+8SgeeD8gO11mddUZdR9K5xxAounlh/lbbUFZWlDpRZeoslArGdw7Ccl8qpR5a4x0ZpOeGyc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FjzeKH8L; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730922852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z0AJT81XUwusmlDp3ak4C1mJAolhBOfTLPwd7IOBvRo=;
	b=FjzeKH8LgarhOV5f64ku6FnTrsbb/weExEmp7D6ICjexrXjF22ZhGPKL1Ngj+vhBEfI0qS
	LBDRLv5+jGn26Bsc1HWTAkWxtylclKzU30TIqGrMbqi8g7eYMaUHM/RTHmGHNz0SGuR5k8
	Sn/+9Wmqq9V1pgBThNACrbklkFpoYBY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	syzbot+e985d3026c4fd041578e@syzkaller.appspotmail.com,
	Hugh Dickins <hughd@google.com>,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3] mm: page_alloc: move mlocked flag clearance into free_pages_prepare()
Date: Wed,  6 Nov 2024 19:53:54 +0000
Message-ID: <20241106195354.270757-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Syzbot reported a bad page state problem caused by a page
being freed using free_page() still having a mlocked flag at
free_pages_prepare() stage:

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

The problem was originally introduced by
commit b109b87050df ("mm/munlock: replace clear_page_mlock() by final
clearance"): it was handling focused on handling pagecache
and anonymous memory and wasn't suitable for lower level
get_page()/free_page() API's used for example by KVM, as with
this reproducer.

Fix it by moving the mlocked flag clearance down to
free_page_prepare().

The bug itself if fairly old and harmless (aside from generating these
warnings), aside from a small memory leak - "bad" pages are stopped from
being allocated again.

Reported-by: syzbot+e985d3026c4fd041578e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6729f475.050a0220.701a.0019.GAE@google.com
Fixes: b109b87050df ("mm/munlock: replace clear_page_mlock() by final clearance")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 15 +++++++++++++++
 mm/swap.c       | 14 --------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47048b39b8ca..371d1c6c1fc7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1048,6 +1048,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	bool skip_kasan_poison = should_skip_kasan_poison(page);
 	bool init = want_init_on_free();
 	bool compound = PageCompound(page);
+	struct folio *folio = page_folio(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1057,6 +1058,20 @@ __always_inline bool free_pages_prepare(struct page *page,
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
diff --git a/mm/swap.c b/mm/swap.c
index 638a3f001676..10decd9dffa1 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -78,20 +78,6 @@ static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
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
-- 
2.47.0.199.ga7371fff76-goog


