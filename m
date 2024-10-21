Return-Path: <stable+bounces-87611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7449A7120
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994F71F2302C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148271EBA02;
	Mon, 21 Oct 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nTb8Qi6P"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3204199239
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532122; cv=none; b=EngZXqnGTaZ83ZkGwkeUc1QJnmiX3qTNm8LXrM8GRlikl3++D3QwJxfC53X1mQopPrF5FAjvOCxnY+3fDs3HM3IrdSmQ8UUJX51IKFORMpUiR4Pl+2k9VRPnbbP762A9Y60QjhgMNKpeMw0W7IDMfl944EbGd6wHIP2JdTgpvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532122; c=relaxed/simple;
	bh=czQ9g0mFdvgWl9O8XJj/3MVzvE7/qQBGFDMz0c7CFFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=echDLD27/yPk0EFobyZ/+/pQVB4042D2zh/8CTbd4PhdXplckmDmZWjH5CNUIaoDsMhf/9D2JVlU33SXfMgAeaKATpIOwKGEWOyB+tyD+nmn2Gcd3njlUieVTcOk1stgTx9lqw3ceIfdJYl9MHgz02tFMGegPK28C/lvEbnlKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nTb8Qi6P; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729532116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ng2+tosjoBBu6IdGY0OAnCymCQLdInYE8eT0ciVoT6Q=;
	b=nTb8Qi6PWoiuOxAhB2TmVQyT041O2AFkafYBMJopBHfQOCTheY74oOCMxNH5WXHJi6XH8S
	wH1DrvZ7kX9K0x0Eyig4ZzFCWHsTH/Nodj4ftVlvHF7qEkNZtJA4itciPtPuj65L6Fc3N6
	aWIQ45xJ+gwJ3pbUhozwlm9h9TgMHBk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	stable@vger.kernel.org,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mm: page_alloc: move mlocked flag clearance into free_pages_prepare()
Date: Mon, 21 Oct 2024 17:34:55 +0000
Message-ID: <20241021173455.2691973-1-roman.gushchin@linux.dev>
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

  BUG: Bad page state in process syz.0.15  pfn:1137bb
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881137bb870 pfn:0x1137bb
  flags: 0x400000000080000(mlocked|node=0|zone=1)
  raw: 0400000000080000 0000000000000000 dead000000000122 0000000000000000
  raw: ffff8881137bb870 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
  page_owner tracks the page as allocated
  page last allocated via order 0, migratetype Unmovable, gfp_mask
  0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 3005, tgid
  3004 (syz.0.15), ts 61546  608067, free_ts 61390082085
   set_page_owner include/linux/page_owner.h:32 [inline]
   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
   prep_new_page mm/page_alloc.c:1545 [inline]
   get_page_from_freelist+0x3008/0x31f0 mm/page_alloc.c:3457
   __alloc_pages_noprof+0x292/0x7b0 mm/page_alloc.c:4733
   alloc_pages_mpol_noprof+0x3e8/0x630 mm/mempolicy.c:2265
   kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
   kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
   kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5500 [inline]
   kvm_dev_ioctl+0x13bb/0x2320 virt/kvm/kvm_main.c:5542
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:907 [inline]
   __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0x69/0x110 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  page last free pid 951 tgid 951 stack trace:
   reset_page_owner include/linux/page_owner.h:25 [inline]
   free_pages_prepare mm/page_alloc.c:1108 [inline]
   free_unref_page+0xcb1/0xf00 mm/page_alloc.c:2638
   vfree+0x181/0x2e0 mm/vmalloc.c:3361
   delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3282
   process_one_work kernel/workqueue.c:3229 [inline]
   process_scheduled_works+0xa5c/0x17a0 kernel/workqueue.c:3310
   worker_thread+0xa2b/0xf70 kernel/workqueue.c:3391
   kthread+0x2df/0x370 kernel/kthread.c:389
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

A reproducer is available here:
https://syzkaller.appspot.com/x/repro.c?x=1437939f980000

The problem was originally introduced by
commit b109b87050df ("mm/munlock: replace clear_page_mlock() by final
clearance"): it was handling focused on handling pagecache
and anonymous memory and wasn't suitable for lower level
get_page()/free_page() API's used for example by KVM, as with
this reproducer.

Fix it by moving the mlocked flag clearance down to
free_page_prepare().

The bug itself if fairly old and harmless (aside from generating these
warnings).

Closes: https://syzkaller.appspot.com/x/report.txt?x=169a47d0580000
Fixes: b109b87050df ("mm/munlock: replace clear_page_mlock() by final clearance")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 15 +++++++++++++++
 mm/swap.c       | 14 --------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc55d39eb372..7535d78862ab 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1044,6 +1044,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	bool skip_kasan_poison = should_skip_kasan_poison(page);
 	bool init = want_init_on_free();
 	bool compound = PageCompound(page);
+	struct folio *folio = page_folio(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1053,6 +1054,20 @@ __always_inline bool free_pages_prepare(struct page *page,
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
index 835bdf324b76..7cd0f4719423 100644
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
2.47.0.105.g07ac214952-goog


