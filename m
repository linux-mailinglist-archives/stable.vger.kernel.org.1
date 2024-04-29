Return-Path: <stable+bounces-41641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D0B8B566B
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AFD284227
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6DC3FB9B;
	Mon, 29 Apr 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jbXuyGlJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0A3DB8E
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389841; cv=none; b=koipjUXVJy7WT0qw61CeqAzEbJWBplH09fDjJTgqSB57flCteBUFaeVh5pH78rvFvzjhxZ7atoiR1DPfv35jqtSMQDfViJSwxJX8BTOWnnrPsTBu+CHQ34wFApdzOS8MyLlAxh3LyoacFYrhR4MEbNMdkcWSDjImYeFKOs9gDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389841; c=relaxed/simple;
	bh=KadMZUm8+lWXsWH/TaHkEfg9+XmrP7GS0wC9SBosqTk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BzV7HqtsBLi0s+yzVT42U58YLDIvyNnEfjVi/tsBRf8Ax62r7kTqyvc6yNfBC70vw5sS1mWSU/yQEvA9oOu81pq2rwmSsUK1Ju46E5VLg2A8+OZJgZsJR1gPSIhzlH+K0OVBEjMi7BMAYe6ixvXrs6oT4CmbyhjLoZxHK7EpdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jbXuyGlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486B1C113CD;
	Mon, 29 Apr 2024 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389840;
	bh=KadMZUm8+lWXsWH/TaHkEfg9+XmrP7GS0wC9SBosqTk=;
	h=Subject:To:Cc:From:Date:From;
	b=jbXuyGlJyQ5UiDYVJP/Uw0fzGAgcM+99zXovphvr4+z7Hcy9EczEdn+4SXsdqrw6j
	 wJRXXgjDoMjLIaY5bqybXwzdnO4FMVmpnrRuV631qklWZPlyNjsY67mYah21H0nPMd
	 WyHXFaLS3eWPg43RCxJfTnsZHAKT/gm21/5kmwUw=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix missing hugetlb_lock for resv uncharge" failed to apply to 5.15-stable tree
To: peterx@redhat.com,akpm@linux-foundation.org,almasrymina@google.com,david@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:23:49 +0200
Message-ID: <2024042949-discolor-mop-d6e8@gregkh>
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
git cherry-pick -x b76b46902c2d0395488c8412e1116c2486cdfcb2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042949-discolor-mop-d6e8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b76b46902c2d ("mm/hugetlb: fix missing hugetlb_lock for resv uncharge")
d4ab0316cc33 ("mm/hugetlb_cgroup: convert hugetlb_cgroup_uncharge_page() to folios")
0356c4b96f68 ("mm/hugetlb: convert free_huge_page to folios")
78fbe906cc90 ("mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for PageAnon() pages")
c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
84d60fdd3733 ("mm: slightly clarify KSM logic in do_swap_page()")
5cbf9942c963 ("mm: generalize the pgmap based page_free infrastructure")
27674ef6c73f ("mm: remove the extra ZONE_DEVICE struct page refcount")
dc90f0846df4 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")
895749455f60 ("mm: simplify freeing of devmap managed pages")
75e55d8a107e ("mm: move free_devmap_managed_page to memremap.c")
730ff52194cd ("mm: remove pointless includes from <linux/hmm.h>")
f56caedaf94f ("Merge branch 'akpm' (patches from Andrew)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b76b46902c2d0395488c8412e1116c2486cdfcb2 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 17 Apr 2024 17:18:35 -0400
Subject: [PATCH] mm/hugetlb: fix missing hugetlb_lock for resv uncharge

There is a recent report on UFFDIO_COPY over hugetlb:

https://lore.kernel.org/all/000000000000ee06de0616177560@google.com/

350:	lockdep_assert_held(&hugetlb_lock);

Should be an issue in hugetlb but triggered in an userfault context, where
it goes into the unlikely path where two threads modifying the resv map
together.  Mike has a fix in that path for resv uncharge but it looks like
the locking criteria was overlooked: hugetlb_cgroup_uncharge_folio_rsvd()
will update the cgroup pointer, so it requires to be called with the lock
held.

Link: https://lkml.kernel.org/r/20240417211836.2742593-3-peterx@redhat.com
Fixes: 79aa925bf239 ("hugetlb_cgroup: fix reservation accounting")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reported-by: syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com
Reviewed-by: Mina Almasry <almasrymina@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 31d00eee028f..53e0ab5c0845 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3268,9 +3268,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
 		hugetlb_acct_memory(h, -rsv_adjust);
-		if (deferred_reserve)
+		if (deferred_reserve) {
+			spin_lock_irq(&hugetlb_lock);
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
+			spin_unlock_irq(&hugetlb_lock);
+		}
 	}
 
 	if (!memcg_charge_ret)


