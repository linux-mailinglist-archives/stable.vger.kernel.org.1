Return-Path: <stable+bounces-119739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC58A46A4A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D97A26AA
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB745236A99;
	Wed, 26 Feb 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YaNvZkTn"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6273236A74
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596204; cv=none; b=R4Z8ymfihpV2UtzZMKS4vxAwLlx0kSxeMuEABCu5Cxm4kEyRi7K+1qToCODKis0yxaKtH1OJVNvGZJM/X2W87dHufTePXvg//1ANbkYT2MRvWAf4YtegVXRIqV376qyLADDKhljnlFWS4pJpEt6ZxVC7FNWkg3GZzpPxcdpesnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596204; c=relaxed/simple;
	bh=BfvB7Ae2SjINcTkge75atqrzDzgDgJ2AfU3Icy8j8D0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qf6enloTOK3HcQ9LMWz0I2FSjGmVNDjzJZyEuk6bfVLCsfaql++qJQC/2qz0lA/Lt06S3bBBt9NzGDRpxzshkiJQqS2QOKJbSkbFMc1dN+9Xf6QgJdzzCdiYnesNvxCsKfT0p5ZSib7DmJZuKJqwJUtU993o625omYB0bBwwkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YaNvZkTn; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740596200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N8k5YcDw/4VVVoJt0g7ZtdcJRICdTIVq9GtV33GN43Q=;
	b=YaNvZkTnOHDLxyQIGgKvqM0HAojGOASBbcB6efdVyccFg/kHmuLMQSGnAfjxgT7154Nqss
	Gyq8YeI88LRUDOrnIYbtZGZGksf58O/nV3chzVwf2utfExIgizxXtT0eOVYUb2tGAAx4v/
	14L6ljsqjbvbLMdzmnP0hqDnEJvp+zg=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	syzbot+1a517ccfcbc6a7ab0f82@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: zswap: fix crypto_free_acomp() deadlock in zswap_cpu_comp_dead()
Date: Wed, 26 Feb 2025 18:56:25 +0000
Message-ID: <20250226185625.2672936-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, zswap_cpu_comp_dead() calls crypto_free_acomp() while holding
the per-CPU acomp_ctx mutex. crypto_free_acomp() then holds scomp_lock
(through crypto_exit_scomp_ops_async()).

On the other hand, crypto_alloc_acomp_node() holds the scomp_lock
(through crypto_scomp_init_tfm()), and then allocates memory.
If the allocation results in reclaim, we may attempt to hold the per-CPU
acomp_ctx mutex.

The above dependencies can cause an ABBA deadlock. For example in the
following scenario:

(1) Task A running on CPU #1:
    crypto_alloc_acomp_node()
      Holds scomp_lock
      Enters reclaim
      Reads per_cpu_ptr(pool->acomp_ctx, 1)

(2) Task A is descheduled

(3) CPU #1 goes offline
    zswap_cpu_comp_dead(CPU #1)
      Holds per_cpu_ptr(pool->acomp_ctx, 1))
      Calls crypto_free_acomp()
      Waits for scomp_lock

(4) Task A running on CPU #2:
      Waits for per_cpu_ptr(pool->acomp_ctx, 1) // Read on CPU #1
      DEADLOCK

Since there is no requirement to call crypto_free_acomp() with the
per-CPU acomp_ctx mutex held in zswap_cpu_comp_dead(), move it after the
mutex is unlocked. Also move the acomp_request_free() and kfree() calls
for consistency and to avoid any potential sublte locking dependencies
in the future.

With this, only setting acomp_ctx fields to NULL occurs with the mutex
held. This is similar to how zswap_cpu_comp_prepare() only initializes
acomp_ctx fields with the mutex held, after performing all allocations
before holding the mutex.

Opportunistically, move the NULL check on acomp_ctx so that it takes
place before the mutex dereference.

Fixes: 12dcb0ef5406 ("mm: zswap: properly synchronize freeing resources during CPU hotunplug")
Reported-by: syzbot+1a517ccfcbc6a7ab0f82@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67bcea51.050a0220.bbfd1.0096.GAE@google.com/
Cc: <stable@vger.kernel.org>
Co-developed-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---

v1 -> v2:
- Explained the problem more clearly in the commit message.
- Moved all freeing calls outside the lock critical section.
v1: https://lore.kernel.org/all/Z72FJnbA39zWh4zS@gondor.apana.org.au/

---
 mm/zswap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index ac9d299e7d0c1..adf745c66aa1d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -881,18 +881,32 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
+	struct acomp_req *req;
+	struct crypto_acomp *acomp;
+	u8 *buffer;
+
+	if (IS_ERR_OR_NULL(acomp_ctx))
+		return 0;
 
 	mutex_lock(&acomp_ctx->mutex);
-	if (!IS_ERR_OR_NULL(acomp_ctx)) {
-		if (!IS_ERR_OR_NULL(acomp_ctx->req))
-			acomp_request_free(acomp_ctx->req);
-		acomp_ctx->req = NULL;
-		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
-			crypto_free_acomp(acomp_ctx->acomp);
-		kfree(acomp_ctx->buffer);
-	}
+	req = acomp_ctx->req;
+	acomp = acomp_ctx->acomp;
+	buffer = acomp_ctx->buffer;
+	acomp_ctx->req = NULL;
+	acomp_ctx->acomp = NULL;
+	acomp_ctx->buffer = NULL;
 	mutex_unlock(&acomp_ctx->mutex);
 
+	/*
+	 * Do the actual freeing after releasing the mutex to avoid subtle
+	 * locking dependencies causing deadlocks.
+	 */
+	if (!IS_ERR_OR_NULL(req))
+		acomp_request_free(req);
+	if (!IS_ERR_OR_NULL(acomp))
+		crypto_free_acomp(acomp);
+	kfree(buffer);
+
 	return 0;
 }
 
-- 
2.48.1.658.g4767266eb4-goog


