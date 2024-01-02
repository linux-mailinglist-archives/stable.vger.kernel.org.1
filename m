Return-Path: <stable+bounces-9196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4606D821DAF
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 15:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF7C1F22AFE
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EED9440;
	Tue,  2 Jan 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DiuOEPjY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179814A92
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 14:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CAFC433C8;
	Tue,  2 Jan 2024 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704205900;
	bh=ZLqj6ee2I8227UOIu1U3+7dv18LP1SxPI5yKaiE/2aU=;
	h=Subject:To:Cc:From:Date:From;
	b=DiuOEPjYh2xQfrZbBuInt2f4o31e1aZWeQUWfvfkbsOoPCZRc6qGTNHz9mbQNHaHY
	 Lm1pTMthboplTIFiNkFXbTZj9GW79PNzVqBSjVrmGbi8R6Uvl3P8wEnZ1VZiuRprrh
	 WXdWOqsek6QbfXiIJj7HKX4S28qomW9B3VFSH6S8=
Subject: FAILED: patch "[PATCH] mm/memory-failure: pass the folio and the page to" failed to apply to 6.6-stable tree
To: willy@infradead.org,akpm@linux-foundation.org,dan.j.williams@intel.com,n-horiguchi@ah.jp.nec.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Jan 2024 15:31:37 +0100
Message-ID: <2024010237-scrutiny-repost-e68e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 376907f3a0b34a17e80417825f8cc1c40fcba81b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024010237-scrutiny-repost-e68e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

376907f3a0b3 ("mm/memory-failure: pass the folio and the page to collect_procs()")
91e79d22be75 ("mm: convert DAX lock/unlock page to lock/unlock folio")

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


