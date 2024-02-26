Return-Path: <stable+bounces-23650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBAE867160
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A31F1C24096
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84A55780;
	Mon, 26 Feb 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Du8fvrcO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FE55777
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943425; cv=none; b=MTB3rnrKDToAZ+/+JiJm/4GMTy747S+R8IVhJMYa154FzRFZG6l7aLxmUNIehhPWx+xU/etiNvpUw11qsIOkJ4SyJxmR9Pg4uMzTkei5vskH1dHaSeWfhbR+QkE4f72kVDDPsZSNfgNfenf20L9Hi7LaBrxPMTsv84rS6jKn3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943425; c=relaxed/simple;
	bh=AURuX8x2PoNW8HjUd6ZJe6EXrBf5fFt/TOjILRCvaAk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l4Zj2yfCCeAN2qQAA7gmathEj/uHu6qb+df56hBqQjJ1Dg9m0upMrEgFOaIr0swEjuPIA/akk0UCWxFOUHYixd99taX0Og9bgVMHok8iBzDaF8IG5iVFbp3A0jrS1rheGiWycaXZgTKV0fzS/Pb49U6zOZ8LpWKet3zoVDFcTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Du8fvrcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C6EC433F1;
	Mon, 26 Feb 2024 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943424;
	bh=AURuX8x2PoNW8HjUd6ZJe6EXrBf5fFt/TOjILRCvaAk=;
	h=Subject:To:Cc:From:Date:From;
	b=Du8fvrcOf7AWYWsKTRCy5AW8BvajkJ7b5y0RNo9sWe9hSTLKRcKM0LQtXYzVOeYLY
	 ogWGXMXUg8dSoihSghQJ108vlFH2R9vyVHu+foLdH6kZo7VD3n1J8Kp45U+/Ppyvhf
	 NtirnbzKGMgRP/AXsQxmtSi8GjVHA/SDpE4YV13I=
Subject: FAILED: patch "[PATCH] mm: zswap: fix missing folio cleanup in writeback race path" failed to apply to 6.1-stable tree
To: yosryahmed@google.com,akpm@linux-foundation.org,cerasuolodomenico@gmail.com,hannes@cmpxchg.org,nphamcs@gmail.com,stable@vger.kernel.org,zhouchengming@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:30:12 +0100
Message-ID: <2024022612-uncloak-pretext-f4a2@gregkh>
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
git cherry-pick -x e3b63e966cac0bf78aaa1efede1827a252815a1d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022612-uncloak-pretext-f4a2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e3b63e966cac ("mm: zswap: fix missing folio cleanup in writeback race path")
96c7b0b42239 ("mm: return the folio from __read_swap_cache_async()")
e947ba0bbf47 ("mm/zswap: cleanup zswap_writeback_entry()")
32acba4c0483 ("mm/zswap: refactor out __zswap_load()")
c75f5c1e0f1d ("mm/zswap: reuse dstmem when decompress")
b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
a65b0e7607cc ("zswap: make shrinking memcg-aware")
ddc1a5cbc05d ("mempolicy: alloc_pages_mpol() for NUMA policy without vma")
23e4883248f0 ("mm: add page_rmappable_folio() wrapper")
c36f6e6dff4d ("mempolicy trivia: slightly more consistent naming")
7f1ee4e20708 ("mempolicy trivia: delete those ancient pr_debug()s")
1cb5d11a370f ("mempolicy: fix migrate_pages(2) syscall return nr_failed")
3657fdc2451a ("mm: move vma_policy() and anon_vma_name() decls to mm_types.h")
3022fd7af960 ("shmem: _add_to_page_cache() before shmem_inode_acct_blocks()")
054a9f7ccd0a ("shmem: move memcg charge out of shmem_add_to_page_cache()")
4199f51a7eb2 ("shmem: shmem_acct_blocks() and shmem_inode_acct_blocks()")
e3e1a5067fd2 ("shmem: remove vma arg from shmem_get_folio_gfp()")
75c70128a673 ("mm: mempolicy: make mpol_misplaced() to take a folio")
cda6d93672ac ("mm: memory: make numa_migrate_prep() to take a folio")
6695cf68b15c ("mm: memory: use a folio in do_numa_page()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e3b63e966cac0bf78aaa1efede1827a252815a1d Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 25 Jan 2024 08:51:27 +0000
Subject: [PATCH] mm: zswap: fix missing folio cleanup in writeback race path

In zswap_writeback_entry(), after we get a folio from
__read_swap_cache_async(), we grab the tree lock again to check that the
swap entry was not invalidated and recycled.  If it was, we delete the
folio we just added to the swap cache and exit.

However, __read_swap_cache_async() returns the folio locked when it is
newly allocated, which is always true for this path, and the folio is
ref'd.  Make sure to unlock and put the folio before returning.

This was discovered by code inspection, probably because this path handles
a race condition that should not happen often, and the bug would not crash
the system, it will only strand the folio indefinitely.

Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index 350dd2fc8159..d2423247acfd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1440,6 +1440,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(folio);
+		folio_unlock(folio);
+		folio_put(folio);
 		return -ENOMEM;
 	}
 	spin_unlock(&tree->lock);


