Return-Path: <stable+bounces-59341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9ED93132F
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B47FB22308
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB5E189F57;
	Mon, 15 Jul 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QrpavxBs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83A189F53
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043427; cv=none; b=K9QipGipfixtyezwD3i+dKNN9xWNlkm+1+W2ZHS9K3Os0WhKXnXWPThkPoAMxIkiVKwbrY2bV6Nw67G+PIKdo0ntKGLQwluxYcz/edxS6kELzuP26WjtM7uAis4xVowne8ocKbizkfBswuWCqHVGRobNjH/O0KWcDFZDh4Wn8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043427; c=relaxed/simple;
	bh=tGY7kJjsKLqKLzjQsI70HuwtIaDeHyStj3Kvfookbow=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DJ1eIhcxp75YoXjttIRPAu5F/bwiPrNvvDdP8Y/c7XTG7wz7OMAc1YEuGyWsMaF1XwsoPTbbJx97l24MIlKmPNSc5qKWw452tObn6NkGwNZh0bXW5DzDmL3N1PepdM288kFqKutmQOgSqI8oBcz0sYNgcgiRWg6cO0ILBH7EcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QrpavxBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157DBC32782;
	Mon, 15 Jul 2024 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721043427;
	bh=tGY7kJjsKLqKLzjQsI70HuwtIaDeHyStj3Kvfookbow=;
	h=Subject:To:Cc:From:Date:From;
	b=QrpavxBsBRaEpbGv5nDqKldyjUZ0HMGll9PQfG0c7nCRtMQsommrGhkl3Ur/OLWSq
	 mhjttwpYet+SctsR2JSw126TYgHlHBwHJDdYc8TPbgfOTV5IAid1pFMTBSctsUwqag
	 KliyplPOd3dIpFo8Hfo0kHfEbF5TtcdwQn0bC6oA=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix potential race in" failed to apply to 6.1-stable tree
To: linmiaohe@huawei.com,akpm@linux-foundation.org,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 13:37:00 +0200
Message-ID: <2024071559-reptilian-chaffing-a991@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5596d9e8b553dacb0ac34bcf873cbbfb16c3ba3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071559-reptilian-chaffing-a991@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5596d9e8b553 ("mm/hugetlb: fix potential race in __update_and_free_hugetlb_folio()")
bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
51718e25c53f ("mm: convert arch_clear_hugepage_flags to take a folio")
831bc31a5e82 ("mm: hugetlb: improve the handling of hugetlb allocation failure for freed or in-use hugetlb")
ebc20dcac4ce ("mm: hugetlb_vmemmap: convert page to folio")
c5ad3233ead5 ("hugetlb_vmemmap: use folio argument for hugetlb_vmemmap_* functions")
c24f188b2289 ("hugetlb: batch TLB flushes when restoring vmemmap")
f13b83fdd996 ("hugetlb: batch TLB flushes when freeing vmemmap")
f4b7e3efaddb ("hugetlb: batch PMD split for bulk vmemmap dedup")
91f386bf0772 ("hugetlb: batch freeing of vmemmap pages")
cfb8c75099db ("hugetlb: perform vmemmap restoration on a list of pages")
79359d6d24df ("hugetlb: perform vmemmap optimization on a list of pages")
d67e32f26713 ("hugetlb: restructure pool allocations")
d2cf88c27f51 ("hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles")
30a89adf872d ("hugetlb: check for hugetlb folio before vmemmap_restore")
d5b43e9683ec ("hugetlb: convert remove_pool_huge_page() to remove_pool_hugetlb_folio()")
04bbfd844b99 ("hugetlb: remove a few calls to page_folio()")
fde1c4ecf916 ("mm: hugetlb: skip initialization of gigantic tail struct pages if freed by HVO")
3ee0aa9f0675 ("mm: move some shrinker-related function declarations to mm/internal.h")
d8f5f7e445f0 ("hugetlb: set hugetlb page flag before optimizing vmemmap")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5596d9e8b553dacb0ac34bcf873cbbfb16c3ba3e Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Mon, 8 Jul 2024 10:51:27 +0800
Subject: [PATCH] mm/hugetlb: fix potential race in
 __update_and_free_hugetlb_folio()

There is a potential race between __update_and_free_hugetlb_folio() and
try_memory_failure_hugetlb():

 CPU1					CPU2
 __update_and_free_hugetlb_folio	try_memory_failure_hugetlb
					 folio_test_hugetlb
					  -- It's still hugetlb folio.
  folio_clear_hugetlb_hwpoison
  					  spin_lock_irq(&hugetlb_lock);
					   __get_huge_page_for_hwpoison
					    folio_set_hugetlb_hwpoison
					  spin_unlock_irq(&hugetlb_lock);
  spin_lock_irq(&hugetlb_lock);
  __folio_clear_hugetlb(folio);
   -- Hugetlb flag is cleared but too late.
  spin_unlock_irq(&hugetlb_lock);

When the above race occurs, raw error page info will be leaked.  Even
worse, raw error pages won't have hwpoisoned flag set and hit
pcplists/buddy.  Fix this issue by deferring
folio_clear_hugetlb_hwpoison() until __folio_clear_hugetlb() is done.  So
all raw error pages will have hwpoisoned flag set.

Link: https://lkml.kernel.org/r/20240708025127.107713-1-linmiaohe@huawei.com
Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2afb70171b76..fe44324d6383 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1725,13 +1725,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		return;
 	}
 
-	/*
-	 * Move PageHWPoison flag from head page to the raw error pages,
-	 * which makes any healthy subpages reusable.
-	 */
-	if (unlikely(folio_test_hwpoison(folio)))
-		folio_clear_hugetlb_hwpoison(folio);
-
 	/*
 	 * If vmemmap pages were allocated above, then we need to clear the
 	 * hugetlb flag under the hugetlb lock.
@@ -1742,6 +1735,13 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
+	/*
+	 * Move PageHWPoison flag from head page to the raw error pages,
+	 * which makes any healthy subpages reusable.
+	 */
+	if (unlikely(folio_test_hwpoison(folio)))
+		folio_clear_hugetlb_hwpoison(folio);
+
 	folio_ref_unfreeze(folio, 1);
 
 	/*


