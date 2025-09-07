Return-Path: <stable+bounces-178050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B417B47BF5
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F73189E7C5
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC727AC54;
	Sun,  7 Sep 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBqqwOle"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E11991C9
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757258011; cv=none; b=Ksdh5lsLERg0Mu5bKcCea3d0qq89xrxwRyB6vpGS68fBGn/399uAJ5jouCzjedHsz3eV4oIYD8rScV39ikv5M/Wtxn7s4DqQFTRHpqkXq1unoj6Vzblazbqx+bI/ijLAJHPcj2I3QB4pZp0EYC845+DkZG7yNcKOsy/JZs6Gdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757258011; c=relaxed/simple;
	bh=/detLDT2oZFV7aOSqs0AxhBV7Ho2KMVyhxqY6+5Rbb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG6aEhB5QkDBQ3cN7GOBc/fQttgm4u3tNLpRtXv5liKYvcZLfWuwGvXKo4P/QoEhgpMQZaYFEoKi3aPoo6s1zTk1TaQMVYkA5BswifDkWnvzzpxPuVUL+vMXBSOJZULHz/Vh6DiU5uZ/shGODjkbJO7zWcUm7NqxboERPyjMsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBqqwOle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A58C4CEF8;
	Sun,  7 Sep 2025 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757258010;
	bh=/detLDT2oZFV7aOSqs0AxhBV7Ho2KMVyhxqY6+5Rbb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBqqwOle2capF9UpsUJ4F5G4agsRhUlbAhiOlmorPtkFx7SE8v0plbeRssc3blvNh
	 Q5tKx6kUNWJJjIgiY59DqZej5a9e7lHWOtkjZl/riUriVA0yEL7CNsz9sbzmwKXmIl
	 JmT1qg5FuXEUfjCLHsNCt1E2wxGiEPtLWTlWi6EmOHrtK4xYO3w4IK+QONk5kmM5O/
	 oisx6pYtrAIyJwGlxoGCwUrDya/n/p+EtxuyGLH45HdikDOPW/eemkOopNp1yk3QkR
	 0gj6WNTR5K0V4I3zahAn5LOlo+lFwyLV1jKeWnFlAskEj87B6f+1uT6qbvLlNmb5ot
	 8dHHZFAN33LZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] slub: Reflow ___slab_alloc()
Date: Sun,  7 Sep 2025 11:13:26 -0400
Message-ID: <20250907151327.641468-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907151327.641468-1-sashal@kernel.org>
References: <2025090635-affluent-reputable-419b@gregkh>
 <20250907151327.641468-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit 24c6a097b5a270e05c6e99a99da66b91be81fd7d ]

The get_partial() interface used in ___slab_alloc() may return a single
object in the "kmem_cache_debug(s)" case, in which we will just return
the "freelist" object.

Move this handling up to prepare for later changes.

And the "pfmemalloc_match()" part is not needed for node partial slab,
since we already check this in the get_partial_node().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Stable-dep-of: 850470a8413a ("mm: slub: avoid wake up kswapd in set_track_prepare")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4190125deceb6..42923473cf7f3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3124,8 +3124,21 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	pc.slab = &slab;
 	pc.orig_size = orig_size;
 	freelist = get_partial(s, node, &pc);
-	if (freelist)
-		goto check_new_slab;
+	if (freelist) {
+		if (kmem_cache_debug(s)) {
+			/*
+			 * For debug caches here we had to go through
+			 * alloc_single_from_partial() so just store the
+			 * tracking info and return the object.
+			 */
+			if (s->flags & SLAB_STORE_USER)
+				set_track(s, freelist, TRACK_ALLOC, addr);
+
+			return freelist;
+		}
+
+		goto retry_load_slab;
+	}
 
 	slub_put_cpu_ptr(s->cpu_slab);
 	slab = new_slab(s, gfpflags, node);
@@ -3161,20 +3174,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	inc_slabs_node(s, slab_nid(slab), slab->objects);
 
-check_new_slab:
-
-	if (kmem_cache_debug(s)) {
-		/*
-		 * For debug caches here we had to go through
-		 * alloc_single_from_partial() so just store the tracking info
-		 * and return the object
-		 */
-		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
-
-		return freelist;
-	}
-
 	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
 		/*
 		 * For !pfmemalloc_match() case we don't load freelist so that
-- 
2.51.0


