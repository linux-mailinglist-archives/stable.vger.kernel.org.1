Return-Path: <stable+bounces-125928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0355EA6DED1
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A791886E3F
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3F25E446;
	Mon, 24 Mar 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmxA0HnF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E87481DD
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830406; cv=none; b=CbGRiWCu3i7tUqLG9xPctj2FqoiJS7NuI3tnpdLZVmxqmp8Z8ryeHgi0n2UPMlP7KxXjeyTzxtGNTFAQwcwQG9x9A9S8TIMZu333tJqgA0aMkDyPyrcv21Nq9gbjefhVqapaR8ZA9B4bCHpoGdQKr3l503g24XM3N1iU+y/cUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830406; c=relaxed/simple;
	bh=9zlFC0PmvebAuZL/vPD9OhRwaXvtia+p9Cvs3Ij0V7M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=anfzSxBLHs7C/GMAr5TwOZClX5WTe6AHALcE1saN++Hf1QYH+4hEHvpZvoVEih6uE3wPy1hmKflmKKHCBIBf1vaLiKbI2hZdPPdQDGiaOfg19GcAb6qmF6YHuDNotObBtvOnV1TCE5x6De+PK3aqC6YZQUtItJ1myXXVrhn4Q+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmxA0HnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE592C4CEDD;
	Mon, 24 Mar 2025 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830406;
	bh=9zlFC0PmvebAuZL/vPD9OhRwaXvtia+p9Cvs3Ij0V7M=;
	h=Subject:To:Cc:From:Date:From;
	b=CmxA0HnFK3zmlVdNvd/yonBR18nKsJXrJf/kYU0HpUdP02T/J5v+Kk10+surj20jp
	 ssYYoGi/5Arah7P5oOykaTE/NKmteO9AVP1ffgq70Arup8nL1Pi/yoojkU76CwEVF7
	 r7i8O1bi4rgQARW5/FM3cAWXJuVBDObM4GQVQNzg=
Subject: FAILED: patch "[PATCH] mm/migrate: fix shmem xarray update during migration" failed to apply to 6.1-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@redhat.com,hughd@google.com,ioworker0@gmail.com,liushixin2@huawei.com,quic_charante@quicinc.com,ryan.roberts@arm.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:32:03 -0700
Message-ID: <2025032403-craziness-tactics-91af@gregkh>
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
git cherry-pick -x 60cf233b585cdf1f3c5e52d1225606b86acd08b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032403-craziness-tactics-91af@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60cf233b585cdf1f3c5e52d1225606b86acd08b0 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Wed, 5 Mar 2025 15:04:03 -0500
Subject: [PATCH] mm/migrate: fix shmem xarray update during migration

A shmem folio can be either in page cache or in swap cache, but not at the
same time.  Namely, once it is in swap cache, folio->mapping should be
NULL, and the folio is no longer in a shmem mapping.

In __folio_migrate_mapping(), to determine the number of xarray entries to
update, folio_test_swapbacked() is used, but that conflates shmem in page
cache case and shmem in swap cache case.  It leads to xarray multi-index
entry corruption, since it turns a sibling entry to a normal entry during
xas_store() (see [1] for a userspace reproduction).  Fix it by only using
folio_test_swapcache() to determine whether xarray is storing swap cache
entries or not to choose the right number of xarray entries to update.

[1] https://lore.kernel.org/linux-mm/Z8idPCkaJW1IChjT@casper.infradead.org/

Note:
In __split_huge_page(), folio_test_anon() && folio_test_swapcache() is
used to get swap_cache address space, but that ignores the shmem folio in
swap cache case.  It could lead to NULL pointer dereferencing when a
in-swap-cache shmem folio is split at __xa_store(), since
!folio_test_anon() is true and folio->mapping is NULL.  But fortunately,
its caller split_huge_page_to_list_to_order() bails out early with EBUSY
when folio->mapping is NULL.  So no need to take care of it here.

Link: https://lkml.kernel.org/r/20250305200403.2822855-1-ziy@nvidia.com
Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Liu Shixin <liushixin2@huawei.com>
Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
Suggested-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c8..97f0edf0c032 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -518,15 +518,13 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_anon(folio) && folio_test_large(folio))
 		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
-	if (folio_test_swapbacked(folio)) {
+	if (folio_test_swapbacked(folio))
 		__folio_set_swapbacked(newfolio);
-		if (folio_test_swapcache(folio)) {
-			folio_set_swapcache(newfolio);
-			newfolio->private = folio_get_private(folio);
-		}
+	if (folio_test_swapcache(folio)) {
+		folio_set_swapcache(newfolio);
+		newfolio->private = folio_get_private(folio);
 		entries = nr;
 	} else {
-		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 		entries = 1;
 	}
 


