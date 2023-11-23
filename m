Return-Path: <stable+bounces-52-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 672197F5EA7
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988201C20F8F
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C480241E4;
	Thu, 23 Nov 2023 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xl6Mpsbi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5D241F7
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA6EC433C7;
	Thu, 23 Nov 2023 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700741019;
	bh=MvXo/o23VJFxKHUsrla+cJUgVYdWUE+MZlJG+7D6ziE=;
	h=Subject:To:Cc:From:Date:From;
	b=Xl6Mpsbioj2yuuEjqdncARI7uXf6D4oqunA6X7gFR5CUTPULxt49WdHgrzc8BfbGH
	 vNaNVCbXJR1GKFYQis4z35mnnzuIEkXer0+vQDe4cNN6rkLAmvxqLOiWHNRpPyfoh4
	 zl4tJk28rcJEHQG1R4NH+AY3HAYbCPSEiSVz73z0=
Subject: FAILED: patch "[PATCH] mm/hugetlb: use nth_page() in place of direct struct page" failed to apply to 6.5-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,david@redhat.com,mike.kravetz@oracle.com,rppt@kernel.org,songmuchun@bytedance.com,stable@vger.kernel.org,tsbogend@alpha.franken.de,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 12:03:32 +0000
Message-ID: <2023112332-cackle-possum-a2e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 426056efe835cf4864ccf4c328fe3af9146fc539
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112332-cackle-possum-a2e1@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

426056efe835 ("mm/hugetlb: use nth_page() in place of direct struct page manipulation")
458568c92953 ("mm/hugetlb: prepare hugetlb_follow_page_mask() for FOLL_PIN")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 426056efe835cf4864ccf4c328fe3af9146fc539 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Wed, 13 Sep 2023 16:12:45 -0400
Subject: [PATCH] mm/hugetlb: use nth_page() in place of direct struct page
 manipulation

When dealing with hugetlb pages, manipulating struct page pointers
directly can get to wrong struct page, since struct page is not guaranteed
to be contiguous on SPARSEMEM without VMEMMAP.  Use nth_page() to handle
it properly.

A wrong or non-existing page might be tried to be grabbed, either
leading to a non freeable page or kernel memory access errors.  No bug
is reported.  It comes from code inspection.

Link: https://lkml.kernel.org/r/20230913201248.452081-3-zi.yan@sent.com
Fixes: 57a196a58421 ("hugetlb: simplify hugetlb handling in follow_page_mask")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c90c43574a6..a945efe2858a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6493,7 +6493,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 			}
 		}
 
-		page += ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+		page = nth_page(page, ((address & ~huge_page_mask(h)) >> PAGE_SHIFT));
 
 		/*
 		 * Note that page may be a sub-page, and with vmemmap


