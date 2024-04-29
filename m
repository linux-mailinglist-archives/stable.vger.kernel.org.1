Return-Path: <stable+bounces-41640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8868B566D
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91882B23ED4
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3444174A;
	Mon, 29 Apr 2024 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NYX2Q93j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC73FB84
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389832; cv=none; b=ink0rmivx4qihwDPoMqIbGaEAXMYTJGMu3Ku6lCYxKw0DbjKYwv63QBXVo6SaCqY39g0uwhlPBBsPQk4e634yFRHj0CNYPy/vc0Ck/HfxyL5YXtjTU4OMJratzzQEMMc2b53K6iDwPU84MjSaiAf5sfnEuhii1djju7xd2MYyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389832; c=relaxed/simple;
	bh=qtPz4TPPgdJIxdu+3/tWfxUdi5TCFqVXvpT1Mc3GJsY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PCu54FRANTrea6wx3FHQYeVBsjLGwonKRnL7I/wNGrV+CmUhh9Fz9OzTDq/SbjJ4JgdKaVLtwPk71ND+Lr/gf86yY63J44FNtxSpqE6+qU2whmB/QK2B3TngSDElsyZ2oVGVB9jeerbFqaRCzDjesWhZ+m8J/ntzr2NPzsJeoHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NYX2Q93j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F15C4AF19;
	Mon, 29 Apr 2024 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389831;
	bh=qtPz4TPPgdJIxdu+3/tWfxUdi5TCFqVXvpT1Mc3GJsY=;
	h=Subject:To:Cc:From:Date:From;
	b=NYX2Q93j25ffkidr1lHGs/xDM30hge6fButf2qQSP8qI/ZDX2XWfAsRugpljNoxjX
	 KSE7NBW9+95daXBZNHdkEpzJJUS/SEXzBlkX6mQXH9Yb/GvBMuYuKrRwvzDddk72Qv
	 oJeMqy+dbAkLM+9Ru6iCrtTEDnVk66C6e31MkjGE=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix missing hugetlb_lock for resv uncharge" failed to apply to 6.1-stable tree
To: peterx@redhat.com,akpm@linux-foundation.org,almasrymina@google.com,david@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:23:48 +0200
Message-ID: <2024042948-overstuff-untwist-805f@gregkh>
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
git cherry-pick -x b76b46902c2d0395488c8412e1116c2486cdfcb2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042948-overstuff-untwist-805f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b76b46902c2d ("mm/hugetlb: fix missing hugetlb_lock for resv uncharge")
d4ab0316cc33 ("mm/hugetlb_cgroup: convert hugetlb_cgroup_uncharge_page() to folios")
0356c4b96f68 ("mm/hugetlb: convert free_huge_page to folios")

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


