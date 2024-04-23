Return-Path: <stable+bounces-40684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D428AE76B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D091C235DF
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A30D1332B0;
	Tue, 23 Apr 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mMUSiXPL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A300745E2
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877671; cv=none; b=MMvieuXByficuvDTAo8SR4c30YGwgjycsDIyjVnmBFXw4VdfbPOqqILiSyZlNqStGhpT70yUblvyaczERuZsb7gb8Ol6kNpSgf4Mcii1r2fSgK0/+6qLRhThUUHkFNmVUSKYEP/H8B+EooNFatv1BPHLyLCnWY12e8di/hHyF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877671; c=relaxed/simple;
	bh=kZOirn8HW16/XzoxAtMLg1pHJiTMUNDHBKMRoHBhOy4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LgrzrQUPNgYxBvSY/idOxnvjx5Aqx6PWRXCWWNqS+Ugw3UKtCuIa2q90LOAKAj5rF8bn1D+sD11KylnkD5rmQiGP+FXO1SZfHjirFN5npukueN4ZtY1/QgYTtvlZJLe0gbMSZaTLc9dUZYjUE6Or6uxrOLdxTpfJ0yCcLE76nFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMUSiXPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A51C3277B;
	Tue, 23 Apr 2024 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877670;
	bh=kZOirn8HW16/XzoxAtMLg1pHJiTMUNDHBKMRoHBhOy4=;
	h=Subject:To:Cc:From:Date:From;
	b=mMUSiXPLIPNiZvUErzy5r72Tdoqvik7gAN2x9cevrHzZUk+ONJu4HDb90npx80/Ga
	 ylxcEd3tMJ0svvCvx7Fq9592OCcZBZ7YJ066/Y7LzCOAXJTtkuu/OYeqXrMwjF1zUa
	 lq0oQFaS9WA6nMpSXDhrhFTcH5yrgFoUki8nRvec=
Subject: FAILED: patch "[PATCH] drm/ttm: stop pooling cached NUMA pages v2" failed to apply to 6.6-stable tree
To: ckoenig.leichtzumerken@gmail.com,christian.koenig@amd.com,felix.kuehling@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:07:41 -0700
Message-ID: <2024042340-laborious-overact-587b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b6976f323a8687cc0d55bc92c2086fd934324ed5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042340-laborious-overact-587b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

b6976f323a86 ("drm/ttm: stop pooling cached NUMA pages v2")
fd37721803c6 ("mm, treewide: introduce NR_PAGE_ORDERS")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b6976f323a8687cc0d55bc92c2086fd934324ed5 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Date: Mon, 15 Apr 2024 15:48:21 +0200
Subject: [PATCH] drm/ttm: stop pooling cached NUMA pages v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We only pool write combined and uncached allocations because they
require extra overhead on allocation and release.

If we also pool cached NUMA it not only means some extra unnecessary
overhead, but also that under memory pressure it can happen that
pages from the wrong NUMA node enters the pool and are re-used
over and over again.

This can lead to performance reduction after running into memory
pressure.

v2: restructure and cleanup the code a bit from the internal hack to
    test this.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 4482d3c94d7f ("drm/ttm: add NUMA node id to the pool")
CC: stable@vger.kernel.org
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240415134821.1919-1-christian.koenig@amd.com

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 112438d965ff..6e1fd6985ffc 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -288,17 +288,23 @@ static struct ttm_pool_type *ttm_pool_select_type(struct ttm_pool *pool,
 						  enum ttm_caching caching,
 						  unsigned int order)
 {
-	if (pool->use_dma_alloc || pool->nid != NUMA_NO_NODE)
+	if (pool->use_dma_alloc)
 		return &pool->caching[caching].orders[order];
 
 #ifdef CONFIG_X86
 	switch (caching) {
 	case ttm_write_combined:
+		if (pool->nid != NUMA_NO_NODE)
+			return &pool->caching[caching].orders[order];
+
 		if (pool->use_dma32)
 			return &global_dma32_write_combined[order];
 
 		return &global_write_combined[order];
 	case ttm_uncached:
+		if (pool->nid != NUMA_NO_NODE)
+			return &pool->caching[caching].orders[order];
+
 		if (pool->use_dma32)
 			return &global_dma32_uncached[order];
 
@@ -566,11 +572,17 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 	pool->use_dma_alloc = use_dma_alloc;
 	pool->use_dma32 = use_dma32;
 
-	if (use_dma_alloc || nid != NUMA_NO_NODE) {
-		for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i)
-			for (j = 0; j < NR_PAGE_ORDERS; ++j)
-				ttm_pool_type_init(&pool->caching[i].orders[j],
-						   pool, i, j);
+	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+		for (j = 0; j < NR_PAGE_ORDERS; ++j) {
+			struct ttm_pool_type *pt;
+
+			/* Initialize only pool types which are actually used */
+			pt = ttm_pool_select_type(pool, i, j);
+			if (pt != &pool->caching[i].orders[j])
+				continue;
+
+			ttm_pool_type_init(pt, pool, i, j);
+		}
 	}
 }
 EXPORT_SYMBOL(ttm_pool_init);
@@ -599,10 +611,16 @@ void ttm_pool_fini(struct ttm_pool *pool)
 {
 	unsigned int i, j;
 
-	if (pool->use_dma_alloc || pool->nid != NUMA_NO_NODE) {
-		for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i)
-			for (j = 0; j < NR_PAGE_ORDERS; ++j)
-				ttm_pool_type_fini(&pool->caching[i].orders[j]);
+	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+		for (j = 0; j < NR_PAGE_ORDERS; ++j) {
+			struct ttm_pool_type *pt;
+
+			pt = ttm_pool_select_type(pool, i, j);
+			if (pt != &pool->caching[i].orders[j])
+				continue;
+
+			ttm_pool_type_fini(pt);
+		}
 	}
 
 	/* We removed the pool types from the LRU, but we need to also make sure


