Return-Path: <stable+bounces-155107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7ACAE191D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4B27AC140
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E49254AE1;
	Fri, 20 Jun 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVuTiMfi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C172459E6
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415832; cv=none; b=LoPm0Kandkm1m56srLsjhdPdxBj25qZw24txXWqbkJk176pM8QbOyUdDcMn3EQut/MWo1wpZa14fR/tPd67ADgDvNanGXvRcfLHCfFIa/VpYHcBSC/HgPED32f/p9WrD34wYOLMyZ/wZ/uOeMaFqZfF+xwmpOPj50PN6gjC8OAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415832; c=relaxed/simple;
	bh=7drgHWoUcvK/1GLAPrZggdEHBF0IMIuE/brWCTPD18g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rGRe9Goz9nZrhoWwio4mYAi3/+2MjjVchHdatSHgX+TnpKIEgM5Fim2aHRqV5FpFUwsToqymEUZRgBrILAMb6WNx1+AJONkvJD/b3UikDA62d6s8KMrmPbF0UJBX84Cv+3RslKOuGgEw3o4oWNvbNCtPpfkQO0LIWOdZN+nHie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVuTiMfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACAFC4CEE3;
	Fri, 20 Jun 2025 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750415832;
	bh=7drgHWoUcvK/1GLAPrZggdEHBF0IMIuE/brWCTPD18g=;
	h=Subject:To:Cc:From:Date:From;
	b=bVuTiMfi8pboXYT7ArqLLDVkox/NCzQrc+mWgg8wMe2ALHhEP13vI/0uvFONShZ4I
	 a5RT6fVupT5Git2XoXdQtY6+QgCGbtVvLd2Z0wxldA8yMplkEks6a0Qad4UI6A5759
	 4cSatcRnQizYFMFoYwJlsluPhbJKch0GOpDKzOeQ=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race" failed to apply to 5.15-stable tree
To: jannh@google.com,akpm@linux-foundation.org,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 12:36:55 +0200
Message-ID: <2025062055-pettiness-snowshoe-2310@gregkh>
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
git cherry-pick -x 1013af4f585fccc4d3e5c5824d174de2257f7d6d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062055-pettiness-snowshoe-2310@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1013af4f585fccc4d3e5c5824d174de2257f7d6d Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Tue, 27 May 2025 23:23:54 +0200
Subject: [PATCH] mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race

huge_pmd_unshare() drops a reference on a page table that may have
previously been shared across processes, potentially turning it into a
normal page table used in another process in which unrelated VMAs can
afterwards be installed.

If this happens in the middle of a concurrent gup_fast(), gup_fast() could
end up walking the page tables of another process.  While I don't see any
way in which that immediately leads to kernel memory corruption, it is
really weird and unexpected.

Fix it with an explicit broadcast IPI through tlb_remove_table_sync_one(),
just like we do in khugepaged when removing page tables for a THP
collapse.

Link: https://lkml.kernel.org/r/20250528-hugetlb-fixes-splitrace-v2-2-1329349bad1a@google.com
Link: https://lkml.kernel.org/r/20250527-hugetlb-fixes-splitrace-v1-2-f4136f5ec58a@google.com
Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7ba020d489d4..8746ed2fec13 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7629,6 +7629,13 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 		return 0;
 
 	pud_clear(pud);
+	/*
+	 * Once our caller drops the rmap lock, some other process might be
+	 * using this page table as a normal, non-hugetlb page table.
+	 * Wait for pending gup_fast() in other threads to finish before letting
+	 * that happen.
+	 */
+	tlb_remove_table_sync_one();
 	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
 	mm_dec_nr_pmds(mm);
 	return 1;


