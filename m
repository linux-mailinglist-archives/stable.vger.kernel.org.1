Return-Path: <stable+bounces-23652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590AA867168
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D271F23BCB
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C495645F;
	Mon, 26 Feb 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GBvNAwuS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B081CD2B
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943434; cv=none; b=dPvhEyJ+QnAoFDwN0hsBV8w1I6TqgvhO+nPLeuXWy39IXpqaTeVUwdETN6mmlEFwz/3/lchhVbhWK6GOBHh88EXQpKzemwtDU/tjDfYkQ0O3wxDYgbGNlnxIySJ6l4LHxzdT0B7CZxcKJ2n5conyRf8clQ9ckQ8jOq1xPTtHly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943434; c=relaxed/simple;
	bh=6Hzz+FEajW6dWWK+NbGH7dy6sLNXqwLVFUK8587SG9c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fo2FXxmck+3tMcrguxpJRYMB5Jrj3xvinteFNWvTzfP1SE63CRphA4Dmc7AOzpsmNmXD+WSOZPUp1f9BSj7Sr7c2+a/aPBXhGmL8FrRbHjk1S2xurxkRIJ64veXtBy94xInxl4LMDqJf+nfy+oZEkjKeTUnKdPk19w8p9qUVOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GBvNAwuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE1BC433F1;
	Mon, 26 Feb 2024 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943434;
	bh=6Hzz+FEajW6dWWK+NbGH7dy6sLNXqwLVFUK8587SG9c=;
	h=Subject:To:Cc:From:Date:From;
	b=GBvNAwuSb9zOrbK6N/re+CRjA4bn+1e3Jeh1Q3vtPhTVjW+O1iqw22S4aYMdHps0b
	 rrVNMbLe85ZaXUvMhd/qUHPxN00ZCocAQaaYilWfqnR/IzgdDnnEc2hjJzWAE8e7zj
	 TOz5rXnhDd7iNYW39UHPQEnCTkr6VT/9/Ak2ixlE=
Subject: FAILED: patch "[PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled" failed to apply to 6.6-stable tree
To: zhouchengming@bytedance.com,akpm@linux-foundation.org,hannes@cmpxchg.org,nphamcs@gmail.com,stable@vger.kernel.org,yosryahmed@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:30:23 +0100
Message-ID: <2024022622-resent-ripeness-43f1@gregkh>
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
git cherry-pick -x 678e54d4bb9a4822f8ae99690ac131c5d490cdb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022622-resent-ripeness-43f1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

678e54d4bb9a ("mm/zswap: invalidate duplicate entry when !zswap_enabled")
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
667ffc31aa95 ("mm: huge_memory: use a folio in do_huge_pmd_numa_page()")
73eab3ca481e ("mm: migrate: convert migrate_misplaced_page() to migrate_misplaced_folio()")
2ac9e99f3b21 ("mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 678e54d4bb9a4822f8ae99690ac131c5d490cdb1 Mon Sep 17 00:00:00 2001
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Thu, 8 Feb 2024 02:32:54 +0000
Subject: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled

We have to invalidate any duplicate entry even when !zswap_enabled since
zswap can be disabled anytime.  If the folio store success before, then
got dirtied again but zswap disabled, we won't invalidate the old
duplicate entry in the zswap_store().  So later lru writeback may
overwrite the new data in swapfile.

Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
Fixes: 42c06a0e8ebe ("mm: kill frontswap")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index 36903d938c15..db4625af65fb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1518,7 +1518,7 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!zswap_enabled || !tree)
+	if (!tree)
 		return false;
 
 	/*
@@ -1533,6 +1533,10 @@ bool zswap_store(struct folio *folio)
 		zswap_invalidate_entry(tree, dupentry);
 	}
 	spin_unlock(&tree->lock);
+
+	if (!zswap_enabled)
+		return false;
+
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
 		memcg = get_mem_cgroup_from_objcg(objcg);


