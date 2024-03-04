Return-Path: <stable+bounces-25848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B5586FAF6
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C123F1F212E9
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD1414013;
	Mon,  4 Mar 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aire32FN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD313FFD
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537826; cv=none; b=d+GqIJa4LGySjOsntQsvgLOwCMg7vltNjml9JBw0Ss4OCRElCiYhprqiUjX88GcXwtPJvITK4vS8SD7psFL/HsH1UVg6f1NAH0NBpkM/lzMjpIFQpDt/hzeSIKpXZs18nYpy3HLmL8mIXZ+nQC72d0fAn1BxxokXXSPPem1e2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537826; c=relaxed/simple;
	bh=nkOZvo9tn0P5INlHVzfGZC3hgCJ5+o/Nu/Yk5TLWFRo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fUymtR/zxj9dq3MylT4//BdrfPYREilGaCR10+uwXo8YB57ahuulE2o22ESpKXGu//dkeI6jlTbflLKG7vUb5OZAd/NJiepdCapJkzklAcedHHrWl2HqjHKkmxZepoQcZB6Xte3ARWp9BURH8OFQkwsXoZb7mWhdoSgTG9NxVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aire32FN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F66C433F1;
	Mon,  4 Mar 2024 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709537826;
	bh=nkOZvo9tn0P5INlHVzfGZC3hgCJ5+o/Nu/Yk5TLWFRo=;
	h=Subject:To:Cc:From:Date:From;
	b=aire32FNcKoNmc1ixtX005R9yqIlcqz8PkWnWVby126Fluu+59eVB2QqsbrsgCC/r
	 B3u5nJXKh5KbA8nY/3Z+W53kJHs6FszZPObvliEM5rj2YRWYA2qoBzK6JpILr2Gf3+
	 LooUw+QPiQ5zbwX6oDmnVWP+uWowVmSW0bKMeSeU=
Subject: FAILED: patch "[PATCH] mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong" failed to apply to 5.15-stable tree
To: byungchul@sk.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,hannes@cmpxchg.org,hyeongtak.ji@sk.com,osalvador@suse.de,stable@vger.kernel.org,ying.huang@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 08:37:00 +0100
Message-ID: <2024030400-blooper-quaking-0f36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2774f256e7c0219e2b0a0894af1c76bdabc4f974
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030400-blooper-quaking-0f36@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")
2ac9e99f3b21 ("mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()")
f7f9c00dfaff ("mm: change to return bool for isolate_lru_page()")
be2d57563822 ("mm: change to return bool for folio_isolate_lru()")
4a64981dfee9 ("mm/mempolicy: convert migrate_page_add() to migrate_folio_add()")
3dae02bbd07f ("mm/mempolicy: convert queue_pages_pte_range() to queue_folios_pte_range()")
de1f5055523e ("mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()")
07bb1fbaa2bb ("mm/damon/paddr: convert damon_pa_*() to use a folio")
f70da5ee8fe1 ("mm/damon: convert damon_pa_mark_accessed_or_deactivate() to use folios")
07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range() to use folios")
18250e78f9c7 ("mm/damon/paddr: support DAMOS filters")
fd3b1bc3c86e ("mm/madvise: fix madvise_pageout for private file mappings")
7438899b0b8d ("folio-compat: remove try_to_release_page()")
64ab3195ea07 ("khugepage: replace try_to_release_page() with filemap_release_folio()")
ece62684dcfb ("hugetlbfs: convert hugetlb_delete_from_page_cache() to use folios")
241f68859656 ("mm/migrate_device.c: refactor migrate_vma and migrate_deivce_coherent_page()")
16ce101db85d ("mm/memory.c: fix race when faulting a device private page")
fa27759af4a6 ("hugetlb: clean up code checking for fault/truncation races")
c86272287bc6 ("hugetlb: create remove_inode_single_folio to remove single file folio")
7e1813d48dd3 ("hugetlb: rename remove_huge_page to hugetlb_delete_from_page_cache")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2774f256e7c0219e2b0a0894af1c76bdabc4f974 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Fri, 16 Feb 2024 20:15:02 +0900
Subject: [PATCH] mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong
 zone index

With numa balancing on, when a numa system is running where a numa node
doesn't have its local memory so it has no managed zones, the following
oops has been observed.  It's because wakeup_kswapd() is called with a
wrong zone index, -1.  Fixed it by checking the index before calling
wakeup_kswapd().

> BUG: unable to handle page fault for address: 00000000000033f3
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 2 PID: 895 Comm: masim Not tainted 6.6.0-dirty #255
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>    rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:wakeup_kswapd (./linux/mm/vmscan.c:7812)
> Code: (omitted)
> RSP: 0000:ffffc90004257d58 EFLAGS: 00010286
> RAX: ffffffffffffffff RBX: ffff88883fff0480 RCX: 0000000000000003
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88883fff0480
> RBP: ffffffffffffffff R08: ff0003ffffffffff R09: ffffffffffffffff
> R10: ffff888106c95540 R11: 0000000055555554 R12: 0000000000000003
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88883fff0940
> FS:  00007fc4b8124740(0000) GS:ffff888827c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000033f3 CR3: 000000026cc08004 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
> ? __die
> ? page_fault_oops
> ? __pte_offset_map_lock
> ? exc_page_fault
> ? asm_exc_page_fault
> ? wakeup_kswapd
> migrate_misplaced_page
> __handle_mm_fault
> handle_mm_fault
> do_user_addr_fault
> exc_page_fault
> asm_exc_page_fault
> RIP: 0033:0x55b897ba0808
> Code: (omitted)
> RSP: 002b:00007ffeefa821a0 EFLAGS: 00010287
> RAX: 000055b89983acd0 RBX: 00007ffeefa823f8 RCX: 000055b89983acd0
> RDX: 00007fc2f8122010 RSI: 0000000000020000 RDI: 000055b89983acd0
> RBP: 00007ffeefa821a0 R08: 0000000000000037 R09: 0000000000000075
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> R13: 00007ffeefa82410 R14: 000055b897ba5dd8 R15: 00007fc4b8340000
>  </TASK>

Link: https://lkml.kernel.org/r/20240216111502.79759-1-byungchul@sk.com
Signed-off-by: Byungchul Park <byungchul@sk.com>
Reported-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Fixes: c574bbe917036 ("NUMA balancing: optimize page placement for memory tiering system")
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/migrate.c b/mm/migrate.c
index cc9f2bcd73b4..c27b1f8097d4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2519,6 +2519,14 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
 			if (managed_zone(pgdat->node_zones + z))
 				break;
 		}
+
+		/*
+		 * If there are no managed zones, it should not proceed
+		 * further.
+		 */
+		if (z < 0)
+			return 0;
+
 		wakeup_kswapd(pgdat->node_zones + z, 0,
 			      folio_order(folio), ZONE_MOVABLE);
 		return 0;


