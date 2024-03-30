Return-Path: <stable+bounces-33809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3202892A0B
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E2B1C2129C
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE1D533;
	Sat, 30 Mar 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="heE3Ad2a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C2BA4B
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711791021; cv=none; b=ofZll5kg6SqgNaZuub3nATF+O799pONq+St5qioesOJWX2vqS7KmR3MaIxAhViCxfwRdPxfmW01+n77EzgoVthgOcPXu6pK1tROJy3YwSVdV4H/JENtv4bUuSrsGu2LlJvR6+R7ouQEw6f7Kh+Kg9XT1ms0+lW+aYc7QPjXwiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711791021; c=relaxed/simple;
	bh=BmzGcei/hzQiKJ9vVyFISpggxXPy8p1wolyTA731bs4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FVnbH8hdh0K4ZhvImEvxGvIaIqROYGbOK2MLy7AUyq+gxtL00/KnvhsNtvx4b3BWYALRZaByn2ZXgvkedLy2toxMzppRsoTftKJDD2xMjSo6XIP7x8BBVNVqGp1/f/gtkJJwtbNJQH2PMLZUC9vhG+fRJRHSeJCV2mKH2zWt+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=heE3Ad2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB62AC433F1;
	Sat, 30 Mar 2024 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711791021;
	bh=BmzGcei/hzQiKJ9vVyFISpggxXPy8p1wolyTA731bs4=;
	h=Subject:To:Cc:From:Date:From;
	b=heE3Ad2a6Yp5/VMd8RL6Y3FppEYgOxucmACefVVQAbSg/9r0/Hn8lkRfvv66hdZsT
	 pzAGT/sMHlp4a0J0UNV8DLxFhD4bj7CNx3BYzdeZw1XIhCKq+4kpusd0h6wmJ/Ff/g
	 f4okSaRPY9p3NR5+RROIm7v+CUDAjrxcEc6OK68I=
Subject: FAILED: patch "[PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices" failed to apply to 6.6-stable tree
To: hannes@cmpxchg.org,akpm@linux-foundation.org,baohua@kernel.org,chengming.zhou@linux.dev,chrisl@kernel.org,hezhongkun.hzk@bytedance.com,nphamcs@gmail.com,stable@vger.kernel.org,yosryahmed@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 10:30:08 +0100
Message-ID: <2024033007-filth-paver-678f@gregkh>
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
git cherry-pick -x 25cd241408a2adc1ed0ebc90ae0793576c111880
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033007-filth-paver-678f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

25cd241408a2 ("mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices")
a230c20e63ef ("mm/zswap: zswap entry doesn't need refcount anymore")
c2e2ba770200 ("mm/zswap: only support zswap_exclusive_loads_enabled")
9986d35d4ceb ("mm: zswap: function ordering: writeback")
f91e81d31c1e ("mm: zswap: function ordering: compress & decompress functions")
36034bf6fcdb ("mm: zswap: function ordering: move entry section out of tree section")
5182661a11ba ("mm: zswap: function ordering: move entry sections out of LRU section")
506a86c5e221 ("mm: zswap: function ordering: public lru api")
abca07c04aa5 ("mm: zswap: function ordering: pool params")
c1a0ecb82bdc ("mm: zswap: function ordering: zswap_pools")
39f3ec8eaa60 ("mm: zswap: function ordering: pool refcounting")
a984649b5c1f ("mm: zswap: function ordering: pool alloc & free")
fa9ad6e21003 ("mm: zswap: break out zwap_compress()")
ff2972aa1b5d ("mm: zswap: rename __zswap_load() to zswap_decompress()")
dab7711fac6d ("mm: zswap: clean up zswap_entry_put()")
e477559ca602 ("mm: zswap: warn when referencing a dead entry")
7dd1f7f0fc1c ("mm: zswap: move zswap_invalidate_entry() to related functions")
5b297f70bb26 ("mm: zswap: inline and remove zswap_entry_find_get()")
42398be2adb1 ("mm: zswap: rename zswap_free_entry to zswap_entry_free")
5878303c5353 ("mm/zswap: fix race between lru writeback and swapoff")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 25cd241408a2adc1ed0ebc90ae0793576c111880 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Sun, 24 Mar 2024 17:04:47 -0400
Subject: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices

Zhongkun He reports data corruption when combining zswap with zram.

The issue is the exclusive loads we're doing in zswap. They assume
that all reads are going into the swapcache, which can assume
authoritative ownership of the data and so the zswap copy can go.

However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try to
bypass the swapcache.  This results in an optimistic read of the swap data
into a page that will be dismissed if the fault fails due to races.  In
this case, zswap mustn't drop its authoritative copy.

Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=zV9P691B9bVq33erwOXNTmEaUbi9DrDeJzw@mail.gmail.com/
Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
Link: https://lkml.kernel.org/r/20240324210447.956973-1-hannes@cmpxchg.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Barry Song <baohua@kernel.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Chris Li <chrisl@kernel.org>
Cc: <stable@vger.kernel.org>	[6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index 36612f34b5d7..caed028945b0 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1636,6 +1636,7 @@ bool zswap_load(struct folio *folio)
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
+	bool swapcache = folio_test_swapcache(folio);
 	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 	u8 *dst;
@@ -1648,7 +1649,20 @@ bool zswap_load(struct folio *folio)
 		spin_unlock(&tree->lock);
 		return false;
 	}
-	zswap_rb_erase(&tree->rbroot, entry);
+	/*
+	 * When reading into the swapcache, invalidate our entry. The
+	 * swapcache can be the authoritative owner of the page and
+	 * its mappings, and the pressure that results from having two
+	 * in-memory copies outweighs any benefits of caching the
+	 * compression work.
+	 *
+	 * (Most swapins go through the swapcache. The notable
+	 * exception is the singleton fault on SWP_SYNCHRONOUS_IO
+	 * files, which reads into a private page and may free it if
+	 * the fault fails. We remain the primary owner of the entry.)
+	 */
+	if (swapcache)
+		zswap_rb_erase(&tree->rbroot, entry);
 	spin_unlock(&tree->lock);
 
 	if (entry->length)
@@ -1663,9 +1677,10 @@ bool zswap_load(struct folio *folio)
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPIN);
 
-	zswap_entry_free(entry);
-
-	folio_mark_dirty(folio);
+	if (swapcache) {
+		zswap_entry_free(entry);
+		folio_mark_dirty(folio);
+	}
 
 	return true;
 }


