Return-Path: <stable+bounces-33807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54734892A07
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04B91F22226
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458CD533;
	Sat, 30 Mar 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kN4lo7kO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79ACA78
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711791009; cv=none; b=ZXNY4dhfMdVZtaNyLkz1ahB1P1Zx/4wEM7O9yTKwQLlaIWsvTX/A7LoZ9xenUXoUNgGbtJMTGNu6eJXwlM6dQhR6Io8i574TiI/crFjzbHR6wZjb6WfuWD/lN4hgzHnNFC8cKip22/GaMarLcl/kP3pAgctDbBxP9iiddgqyjw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711791009; c=relaxed/simple;
	bh=TppicMxGUPtyVdg49rTtMybmQZZ42tcypZTsFwofMXg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fn15Lf2B2Y9mCDLfBz0kmU2BWmsXuU9L6K1fY/pdxvgG1gn+OtndmJW0N68/ACCzHxJLbkXvXxsesJf1DVgFJQ04WVE9xtUV1Ni6SRpcEXZJ50fUtosIQp/PdJ+U3YDurVvPSsjL/G1DC3xP9PL+mksgZ30PXj1rhYBSf5BYoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kN4lo7kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82252C433C7;
	Sat, 30 Mar 2024 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711791009;
	bh=TppicMxGUPtyVdg49rTtMybmQZZ42tcypZTsFwofMXg=;
	h=Subject:To:Cc:From:Date:From;
	b=kN4lo7kOX2a/v5o8uLgNDPbrU+UVg39z0yrkYDmaDaW3Dk+l4sf3iguIN+gHc0XeW
	 7XvhR/wR94lCH02w/9vtelE00qXolr72XAO8eyodk32pBsQt9aWGt3FbShSR5Xyumy
	 Cyz8XKmgLpeOdjPWt/7bhvZ5t3jvrSnB5GNXOVFg=
Subject: FAILED: patch "[PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices" failed to apply to 6.8-stable tree
To: hannes@cmpxchg.org,akpm@linux-foundation.org,baohua@kernel.org,chengming.zhou@linux.dev,chrisl@kernel.org,hezhongkun.hzk@bytedance.com,nphamcs@gmail.com,stable@vger.kernel.org,yosryahmed@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 10:30:05 +0100
Message-ID: <2024033005-politely-marauding-110a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 25cd241408a2adc1ed0ebc90ae0793576c111880
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033005-politely-marauding-110a@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

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


