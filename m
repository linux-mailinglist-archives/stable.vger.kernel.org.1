Return-Path: <stable+bounces-178042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC5FB47BE4
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9DB3BA759
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E226F29F;
	Sun,  7 Sep 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5WbdQWr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE31A0BD0
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757256991; cv=none; b=ANe4ziDe9+mhrNz8X3yn9iuw1p/Zqv2YydA7UTzWdnP7AV8908IKs5ytrqezT+4Rbd9CV/G7ZhHtgD9QhJXHYBsg+wn4xQ+CULv6JmMSCWKWvHT9/fYkAfk6qPTzgx+U4tdlUDpJSqNdN22l9Ilwi1r7KzNxQUy2QlokzNtMupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757256991; c=relaxed/simple;
	bh=FCNkxAzCLezaF3m8ARL4NpMRtxd5iSnRq10wVClobL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gegn2vFw7Ynd4XQhLaH4U8VVNbW3OeOCTSYWr88aBT8B9fMqdsfH4zU0TxyxImQscwdVwhRN7czGjvxFlSS9ftj20ofaq9+QPVyoVNCsUxcNj16k/2/8u2ppFTFsJEHkNDSP5wfrX+pLDP1FoGDLLivhiN4llKpHoJ2ahFNQWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5WbdQWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B259C4CEF0;
	Sun,  7 Sep 2025 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757256991;
	bh=FCNkxAzCLezaF3m8ARL4NpMRtxd5iSnRq10wVClobL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5WbdQWr15VfP11kW0dnWiCpnTRLSJ1zsteBVbPyjy1GKwfxt9JQVa9YaJDM2q4RG
	 q3lLriNpdG+AVsUiaw2LnIET1NLVdzvzPkEvDrNdAT0Onvx7kcoryov4OrxwjW2UbA
	 Ssa0EcRl/XTTpKAnYD0zSUji8a1oO4jZSwtTyFRmsb4S327jaqsBR5R21wJIumKr2C
	 YYAt1fT2MMiTcs/5hc5/pdgEFkOmH1vT1140JLjGIw8L3FD59/kl0PS3mLZpipJzGn
	 dAr707oYC0whVG6aCD+AJVHs5rTriAwh1NOAM4XgDXQZQzUH1QJaGDJ89YCmtbtszS
	 wIB4ww7eu75+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] slub: Reflow ___slab_alloc()
Date: Sun,  7 Sep 2025 10:56:27 -0400
Message-ID: <20250907145628.635865-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090634-predator-composite-c799@gregkh>
References: <2025090634-predator-composite-c799@gregkh>
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
index d2544c88a5c43..b7ee815d5d6cd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3223,8 +3223,21 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -3260,20 +3273,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
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


