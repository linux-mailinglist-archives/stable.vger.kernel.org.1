Return-Path: <stable+bounces-9198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A596821DB2
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 025ADB21F6C
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057FB11189;
	Tue,  2 Jan 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lxOM8HPZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AE911708
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 14:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8306C433C7;
	Tue,  2 Jan 2024 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704205907;
	bh=AmZeEAIYhBr6Crr7PG0I+eKjnSfP0pNveIiGUxMAIwQ=;
	h=Subject:To:Cc:From:Date:From;
	b=lxOM8HPZ/21SI6sCZACG8n7p8Bj5QWcNUJBNhG1d82/lAYEv6hVLCez6vEsX76CPr
	 fKR7f2K6vkIczbWHiEA/25LG/4UNXO2mM8qjpe6yOkH/Ux3laFTE9uwUOwFrFHGks2
	 GPM7Loi/uKRg90vFp2UEb/heK+I8BPrAh6u8C/uk=
Subject: FAILED: patch "[PATCH] mm/memory-failure: pass the folio and the page to" failed to apply to 5.15-stable tree
To: willy@infradead.org,akpm@linux-foundation.org,dan.j.williams@intel.com,n-horiguchi@ah.jp.nec.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Jan 2024 15:31:39 +0100
Message-ID: <2024010239-cost-sweep-9b99@gregkh>
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
git cherry-pick -x 376907f3a0b34a17e80417825f8cc1c40fcba81b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024010239-cost-sweep-9b99@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

376907f3a0b3 ("mm/memory-failure: pass the folio and the page to collect_procs()")
91e79d22be75 ("mm: convert DAX lock/unlock page to lock/unlock folio")
4248d0083ec5 ("mm: ksm: support hwpoison for ksm page")
4f775086a6ee ("mm: memory-failure: refactor add_to_kill()")
5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
a46c9304b4bb ("mm/hwpoison: pass pfn to num_poisoned_pages_*()")
d027122d8363 ("mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c")
e591ef7d96d6 ("mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage")
0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
eba4d770efc8 ("mm/swap: comment all the ifdef in swapops.h")
36537a67d356 ("mm, hwpoison: avoid unneeded page_mapped_in_vma() overhead in collect_procs_anon()")
21c9e90ab9a4 ("mm, hwpoison: use num_poisoned_pages_sub() to decrease num_poisoned_pages")
6d751329e761 ("Merge branch 'mm-hotfixes-stable' into mm-stable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 376907f3a0b34a17e80417825f8cc1c40fcba81b Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Mon, 18 Dec 2023 13:58:35 +0000
Subject: [PATCH] mm/memory-failure: pass the folio and the page to
 collect_procs()

Patch series "Three memory-failure fixes".

I've been looking at the memory-failure code and I believe I have found
three bugs that need fixing -- one going all the way back to 2010!  I'll
have more patches later to use folios more extensively but didn't want
these bugfixes to get caught up in that.


This patch (of 3):

Both collect_procs_anon() and collect_procs_file() iterate over the VMA
interval trees looking for a single pgoff, so it is wrong to look for the
pgoff of the head page as is currently done.  However, it is also wrong to
look at page->mapping of the precise page as this is invalid for tail
pages.  Clear up the confusion by passing both the folio and the precise
page to collect_procs().

Link: https://lkml.kernel.org/r/20231218135837.3310403-1-willy@infradead.org
Link: https://lkml.kernel.org/r/20231218135837.3310403-2-willy@infradead.org
Fixes: 415c64c1453a ("mm/memory-failure: split thp earlier in memory error handling")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 660c21859118..6953bda11e6e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -595,10 +595,9 @@ struct task_struct *task_early_kill(struct task_struct *tsk, int force_early)
 /*
  * Collect processes when the error hit an anonymous page.
  */
-static void collect_procs_anon(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_anon(struct folio *folio, struct page *page,
+		struct list_head *to_kill, int force_early)
 {
-	struct folio *folio = page_folio(page);
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct anon_vma *av;
@@ -633,12 +632,12 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 /*
  * Collect processes when the error hit a file mapped page.
  */
-static void collect_procs_file(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_file(struct folio *folio, struct page *page,
+		struct list_head *to_kill, int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	pgoff_t pgoff;
 
 	i_mmap_lock_read(mapping);
@@ -704,17 +703,17 @@ static void collect_procs_fsdax(struct page *page,
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
-static void collect_procs(struct page *page, struct list_head *tokill,
-				int force_early)
+static void collect_procs(struct folio *folio, struct page *page,
+		struct list_head *tokill, int force_early)
 {
-	if (!page->mapping)
+	if (!folio->mapping)
 		return;
 	if (unlikely(PageKsm(page)))
 		collect_procs_ksm(page, tokill, force_early);
 	else if (PageAnon(page))
-		collect_procs_anon(page, tokill, force_early);
+		collect_procs_anon(folio, page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(folio, page, tokill, force_early);
 }
 
 struct hwpoison_walk {
@@ -1602,7 +1601,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * mapped in dirty form.  This has to be done before try_to_unmap,
 	 * because ttu takes the rmap data structures down.
 	 */
-	collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
+	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
 
 	if (PageHuge(hpage) && !PageAnon(hpage)) {
 		/*
@@ -1772,7 +1771,7 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(&folio->page, &to_kill, true);
+	collect_procs(folio, &folio->page, &to_kill, true);
 
 	unmap_and_kill(&to_kill, pfn, folio->mapping, folio->index, flags);
 unlock:


