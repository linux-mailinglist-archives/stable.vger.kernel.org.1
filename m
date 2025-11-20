Return-Path: <stable+bounces-195324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB6C75567
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8B8F4F2874
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85311376BEC;
	Thu, 20 Nov 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="abDSvyWA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265D27A462
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655120; cv=none; b=K2NC19fUBFzsvy7dotgSBCjEhN+/KI5jnm0irqAWxjtrh6Dde4t4MSq1jPvbo9In98D+QLE6TDalZfyUHJaCqXSXq6RQnZKbtFMtXA/8+g2n6oGDw5TBDCdR+9AwVK2DAfxsx2w5qcJgF239ThUzJNeNOkrSI7wak1R18vghcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655120; c=relaxed/simple;
	bh=7Lv7ow9pRtOjX3w8eQD6xseKcqtvEs5Xzob6CInUW1U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G9wgEpB3BRiHlO8R5gO5tXIaDtnLVTGrQIIAaCYmbZ34O3HBB+5TPt1hK6JAGf61RsSa0Y+OB2j7QUBidTWNhK9HOY/kCznlRiqSVl1fuBfHubsrjnvpqU9m0AdM92HGceQsfS1thWPnnSR/SD6AHtoLF26odVVAv9qxWSVzY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=abDSvyWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A50AC4CEF1;
	Thu, 20 Nov 2025 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655119;
	bh=7Lv7ow9pRtOjX3w8eQD6xseKcqtvEs5Xzob6CInUW1U=;
	h=Subject:To:Cc:From:Date:From;
	b=abDSvyWAYyrUig4k0U5QF/tO1WTwfO19oD4DLOOYRGHIkqiIAiHP8lbk7+kvVFCtg
	 k4SwHlZchrg50spkt5tKlYZQ7anhDqcVYGDYzM6xsMxNszXGAICjUTj97C2UwYP9ma
	 DXugkAn7iTHIdS4X5aw7nmrh/fCya3NFJslOXv4U=
Subject: FAILED: patch "[PATCH] mm/huge_memory: preserve PG_has_hwpoisoned if a folio is" failed to apply to 6.12-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@redhat.com,dev.jain@arm.com,jane.chu@oracle.com,kernel@pankajraghav.com,lance.yang@linux.dev,liam.howlett@oracle.com,linmiaohe@huawei.com,lorenzo.stoakes@oracle.com,mcgrof@kernel.org,nao.horiguchi@gmail.com,npache@redhat.com,richard.weiyang@gmail.com,ryan.roberts@arm.com,stable@vger.kernel.org,willy@infradead.org,yang@os.amperecomputing.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:11:56 +0100
Message-ID: <2025112056-isolating-punisher-7be9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fa5a061700364bc28ee1cb1095372f8033645dcb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112056-isolating-punisher-7be9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa5a061700364bc28ee1cb1095372f8033645dcb Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Wed, 22 Oct 2025 23:05:21 -0400
Subject: [PATCH] mm/huge_memory: preserve PG_has_hwpoisoned if a folio is
 split to >0 order

folio split clears PG_has_hwpoisoned, but the flag should be preserved in
after-split folios containing pages with PG_hwpoisoned flag if the folio
is split to >0 order folios.  Scan all pages in a to-be-split folio to
determine which after-split folios need the flag.

An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
avoid the scan and set it on all after-split folios, but resulting false
positive has undesirable negative impact.  To remove false positive,
caller of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page()
needs to do the scan.  That might be causing a hassle for current and
future callers and more costly than doing the scan in the split code.
More details are discussed in [1].

This issue can be exposed via:
1. splitting a has_hwpoisoned folio to >0 order from debugfs interface;
2. truncating part of a has_hwpoisoned folio in
   truncate_inode_partial_folio().

And later accesses to a hwpoisoned page could be possible due to the
missing has_hwpoisoned folio flag.  This will lead to MCE errors.

Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
Link: https://lkml.kernel.org/r/20251023030521.473097-1-ziy@nvidia.com
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index feac4aef7dfb..b4ff49d96501 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3263,6 +3263,14 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 					caller_pins;
 }
 
+static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
+{
+	for (; nr_pages; page++, nr_pages--)
+		if (PageHWPoison(page))
+			return true;
+	return false;
+}
+
 /*
  * It splits @folio into @new_order folios and copies the @folio metadata to
  * all the resulting folios.
@@ -3270,17 +3278,24 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 static void __split_folio_to_order(struct folio *folio, int old_order,
 		int new_order)
 {
+	/* Scan poisoned pages when split a poisoned folio to large folios */
+	const bool handle_hwpoison = folio_test_has_hwpoisoned(folio) && new_order;
 	long new_nr_pages = 1 << new_order;
 	long nr_pages = 1 << old_order;
 	long i;
 
+	folio_clear_has_hwpoisoned(folio);
+
+	/* Check first new_nr_pages since the loop below skips them */
+	if (handle_hwpoison &&
+	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages))
+		folio_set_has_hwpoisoned(folio);
 	/*
 	 * Skip the first new_nr_pages, since the new folio from them have all
 	 * the flags from the original folio.
 	 */
 	for (i = new_nr_pages; i < nr_pages; i += new_nr_pages) {
 		struct page *new_head = &folio->page + i;
-
 		/*
 		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
 		 * Don't pass it around before clear_compound_head().
@@ -3322,6 +3337,10 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 				 (1L << PG_dirty) |
 				 LRU_GEN_MASK | LRU_REFS_MASK));
 
+		if (handle_hwpoison &&
+		    page_range_has_hwpoisoned(new_head, new_nr_pages))
+			folio_set_has_hwpoisoned(new_folio);
+
 		new_folio->mapping = folio->mapping;
 		new_folio->index = folio->index + i;
 
@@ -3422,8 +3441,6 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	if (folio_test_anon(folio))
 		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
 
-	folio_clear_has_hwpoisoned(folio);
-
 	/*
 	 * split to new_order one order at a time. For uniform split,
 	 * folio is split to new_order directly.


