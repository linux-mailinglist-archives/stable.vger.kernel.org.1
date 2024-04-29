Return-Path: <stable+bounces-41648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F518B5676
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5898F1F22F89
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194F3FB9B;
	Mon, 29 Apr 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5j1qLDz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CE2837A
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389926; cv=none; b=PUEM2WRlCq6v5PQYm0LaAWILoRk0AB08VhhutoLf+MVKPq1biX567Sr2e6BVFlYhKcUR0bMqtEUgvpujlzumrxyLhB//snggpFz/YPFPMnZ4H44+D6Dw12xQhzJvS7QCgTCmsRUNnRcedeqK1yy9LwOgONJkMbYcob97Fvxgm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389926; c=relaxed/simple;
	bh=d4rJkKK4+vGBLY0/ZK2u+6NfukO6CrFKVprM24Tbm84=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gI86gAxyxhl9Vpix+UYJOyqz8prjBgOmFApRPBJkwxVuGsFfTKQN7iJCm2X3sLr8pJyvaTHTKJXjbiqnR5djnrwk9huhoZEhcbm+jdzoizYCffmwWSsXUlYuYkK06Fp8HyfdiqZSJZOyRMHMfsQ9Tr5WQ3pKTqfiweUO4F7qXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5j1qLDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB85BC113CD;
	Mon, 29 Apr 2024 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389926;
	bh=d4rJkKK4+vGBLY0/ZK2u+6NfukO6CrFKVprM24Tbm84=;
	h=Subject:To:Cc:From:Date:From;
	b=y5j1qLDz3xwOSN/nAYVQPqChUyIHdblHI6ZJIIp9xAE3z1c4bzagasSVF8s5hCm2S
	 PZIBmULKj86JAvtTDgrRDozmidIQbGD47S9M6YfVuJ+DjURaV1gbY7L3p7fwe7tnAb
	 il+KQ2OzN5A787g+fD8sR2tnncOZF+MtS0BxWkbU=
Subject: FAILED: patch "[PATCH] mm: zswap: fix shrinker NULL crash with cgroup_disable=memory" failed to apply to 6.8-stable tree
To: hannes@cmpxchg.org,akpm@linux-foundation.org,chengming.zhou@linux.dev,christian@heusel.eu,ddstreet@ieee.org,nphamcs@gmail.com,rjones@redhat.com,sjenning@redhat.com,stable@vger.kernel.org,vitaly.wool@konsulko.com,yosryahmed@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:25:23 +0200
Message-ID: <2024042923-monday-hamlet-26ca@gregkh>
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
git cherry-pick -x 682886ec69d22363819a83ddddd5d66cb5c791e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042923-monday-hamlet-26ca@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

682886ec69d2 ("mm: zswap: fix shrinker NULL crash with cgroup_disable=memory")
30fb6a8d9e33 ("mm: zswap: fix writeback shinker GFP_NOIO/GFP_NOFS recursion")
e35606e4167d ("mm/zswap: global lru and shrinker shared by all zswap_pools fix")
bf9b7df23cb3 ("mm/zswap: global lru and shrinker shared by all zswap_pools")
5182661a11ba ("mm: zswap: function ordering: move entry sections out of LRU section")
506a86c5e221 ("mm: zswap: function ordering: public lru api")
abca07c04aa5 ("mm: zswap: function ordering: pool params")
c1a0ecb82bdc ("mm: zswap: function ordering: zswap_pools")
39f3ec8eaa60 ("mm: zswap: function ordering: pool refcounting")
a984649b5c1f ("mm: zswap: function ordering: pool alloc & free")
be7fc97c5283 ("mm: zswap: further cleanup zswap_store()")
fa9ad6e21003 ("mm: zswap: break out zwap_compress()")
ff2972aa1b5d ("mm: zswap: rename __zswap_load() to zswap_decompress()")
7dd1f7f0fc1c ("mm: zswap: move zswap_invalidate_entry() to related functions")
5b297f70bb26 ("mm: zswap: inline and remove zswap_entry_find_get()")
5878303c5353 ("mm/zswap: fix race between lru writeback and swapoff")
db128f5fdee9 ("mm: zswap: remove unused tree argument in zswap_entry_put()")
44c7c734a513 ("mm/zswap: split zswap rb-tree")
bb29fd7760ae ("mm/zswap: make sure each swapfile always have zswap rb-tree")
8409a385a6b4 ("mm/zswap: improve with alloc_workqueue() call")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 682886ec69d22363819a83ddddd5d66cb5c791e1 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 18 Apr 2024 08:26:28 -0400
Subject: [PATCH] mm: zswap: fix shrinker NULL crash with cgroup_disable=memory

Christian reports a NULL deref in zswap that he bisected down to the zswap
shrinker.  The issue also cropped up in the bug trackers of libguestfs [1]
and the Red Hat bugzilla [2].

The problem is that when memcg is disabled with the boot time flag, the
zswap shrinker might get called with sc->memcg == NULL.  This is okay in
many places, like the lruvec operations.  But it crashes in
memcg_page_state() - which is only used due to the non-node accounting of
cgroup's the zswap memory to begin with.

Nhat spotted that the memcg can be NULL in the memcg-disabled case, and I
was then able to reproduce the crash locally as well.

[1] https://github.com/libguestfs/libguestfs/issues/139
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2275252

Link: https://lkml.kernel.org/r/20240418124043.GC1055428@cmpxchg.org
Link: https://lkml.kernel.org/r/20240417143324.GA1055428@cmpxchg.org
Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Christian Heusel <christian@heusel.eu>
Debugged-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Tested-by: Christian Heusel <christian@heusel.eu>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: <stable@vger.kernel.org>	[v6.8]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index caed028945b0..6f8850c44b61 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1331,15 +1331,22 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!gfp_has_io_fs(sc->gfp_mask))
 		return 0;
 
-#ifdef CONFIG_MEMCG_KMEM
-	mem_cgroup_flush_stats(memcg);
-	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
-	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
-#else
-	/* use pool stats instead of memcg stats */
-	nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
-	nr_stored = atomic_read(&zswap_nr_stored);
-#endif
+	/*
+	 * For memcg, use the cgroup-wide ZSWAP stats since we don't
+	 * have them per-node and thus per-lruvec. Careful if memcg is
+	 * runtime-disabled: we can get sc->memcg == NULL, which is ok
+	 * for the lruvec, but not for memcg_page_state().
+	 *
+	 * Without memcg, use the zswap pool-wide metrics.
+	 */
+	if (!mem_cgroup_disabled()) {
+		mem_cgroup_flush_stats(memcg);
+		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
+		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
+	} else {
+		nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
+		nr_stored = atomic_read(&zswap_nr_stored);
+	}
 
 	if (!nr_stored)
 		return 0;


