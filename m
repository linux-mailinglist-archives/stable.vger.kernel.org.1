Return-Path: <stable+bounces-107811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E7A03900
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFF07A236F
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8B1EA90;
	Tue,  7 Jan 2025 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0aXvPUXN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9A1DE2A0
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736236066; cv=none; b=mEo319yJSOwmOHQHFOC1vAiARLEr+DY39aaeT+2ShjN/iObllSYit3LNnCwbYHnZNrQzTGVV1BQy0j9Ax0rCafm8TFbB3pRqyebcdBUC2+9vnO0lslraSmM7AEevQcq2dKmnNQ0v973A8XhzuTIl/k3sAuZb/P+YjBVEfefc15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736236066; c=relaxed/simple;
	bh=jnRJScDwwMarsX/y69N9k6Jt+lLQ6ZIrZq9cDw1FHgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MskOryLzfXsFbF2NN5ucYrU5oAbkPoXVclP2TRTwaVFFYQkQwnoiXE7OTnSwyidJvd7r10h4IFPz1vBWGBw0nff5oMOdCW6HHm1Dz7Uw65uFmtiyTgTzv+kMefbKJ+gR5vRt9IuIehbvT7c1uhC4HQQBox75HeiMGBdhux0MIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0aXvPUXN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so33271929a91.2
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 23:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736236062; x=1736840862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgkmCWVczOKXI/I991UVFS0Ip8/4HV0rkcV91lhH2tc=;
        b=0aXvPUXNjjDBui8tSywGUinfZWN8SdH93knMs6oF3gtACDVdg/PTUgNUyrn6HbbxY3
         yLaqGGTkWS1WnLi+7TFzlaA8ljtJi0ILaSCHSdYkWLJ/k2l86WoTuocFFqoTwSEtaxRP
         zSso9mFoOz960h9uB9mNNlvWAYW2UHPCw+F77NjXiYty5DipdIOQx3yrA489Q3oq5EPw
         8BeWaR0tU2GkvwpKRO8B8iBD8FJpXtfhCCjORqn865uwmP1UZoTYIU2Zbf9lxlkd0xVP
         vOd6L5pDFXYaa27DSrP7k1SJ96XAppURVad00uICtY0Wp/gR+hvs/j9BHEqamNbY4ETj
         WFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736236062; x=1736840862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgkmCWVczOKXI/I991UVFS0Ip8/4HV0rkcV91lhH2tc=;
        b=VRbTYcCx4fn2HKW7Jvyezg6gfhZ/ZT0JZ1+2XMI0TCXF68lcoPkveG/Y8r3Z698uou
         +cvLDVsS5PD/BkhDh/QQc5PFGRvGUaCpRVtT0Yl+VEMmftSo2Sr1NpI4jxqaJc1K7XXw
         ZMWJKbec5M71ZF5sACEioTvse7TcgfGRKSi0Ee6oHPFTu9Ly7dFjcUh03T8WkVUbv879
         KBXWZUJUka5oJ/oH+3fZZok3IS1OfePX1Vb0lM0OI+EOaenNYOy0aWWNxVgZSTf0NFWU
         uDAOEI5T13FtEo8uALd5Vf07kUcJmr3LHiIoLrm6drc+eOO7jmtSa3CiYc5G+u0K2tvY
         JrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVZHFqMmhUJaFH5GuvuTi3YNtdyiM50m88KBBVOkVxXtdykj7CPZPBUy59aqYy4WW8XH5b//E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSJhPG6tNIJCP13Eih2g+f3N7N2ChYE6bF4wU/K2gdlspS9A1
	xoyAIxJNJ2yD/4hQlNL3yGtVlCHk0R6HDgT/5ctM/H6oX1GYROzRmdjAGBlGLsoAb5EKpd8axbo
	DVtLhQhax5FR3tADWUA==
X-Google-Smtp-Source: AGHT+IHQ7AZqxFj9pAZrCsvqiHbUVAdUbqvqSZXExiCCJxdWdkFbZ6wGHRFwryywnMMfUT9qvbfOq0nZYKQovlUN
X-Received: from pjbee7.prod.google.com ([2002:a17:90a:fc47:b0:2ef:8d43:14d8])
 (user=yosryahmed job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:6cb:b0:2ee:863e:9fff with SMTP id 98e67ed59e1d1-2f452e22560mr94099372a91.10.1736236062518;
 Mon, 06 Jan 2025 23:47:42 -0800 (PST)
Date: Tue,  7 Jan 2025 07:47:24 +0000
In-Reply-To: <20250107074724.1756696-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107074724.1756696-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107074724.1756696-2-yosryahmed@google.com>
Subject: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU hotunplug
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
current CPU at the beginning of the operation is retrieved and used
throughout.  However, since neither preemption nor migration are disabled,
it is possible that the operation continues on a different CPU.

If the original CPU is hotunplugged while the acomp_ctx is still in use,
we run into a UAF bug as the resources attached to the acomp_ctx are freed
during hotunplug in zswap_cpu_comp_dead().

The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to use
crypto_acomp API for hardware acceleration") when the switch to the
crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
retrieved using get_cpu_ptr() which disables preemption and makes sure the
CPU cannot go away from under us.  Preemption cannot be disabled with the
crypto_acomp API as a sleepable context is needed.

Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
per-acomp_ctx") increased the UAF surface area by making the per-CPU
buffers dynamic, adding yet another resource that can be freed from under
zswap compression/decompression by CPU hotunplug.

There are a few ways to fix this:
(a) Add a refcount for acomp_ctx.
(b) Disable migration while using the per-CPU acomp_ctx.
(c) Use SRCU to wait for other CPUs using the acomp_ctx of the CPU being
hotunplugged. Normal RCU cannot be used as a sleepable context is
required.

Implement (c) since it's simpler than (a), and (b) involves using
migrate_disable() which is apparently undesired (see huge comment in
include/linux/preempt.h).

Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
---
 mm/zswap.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb236..add1406d693b8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -864,12 +864,22 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	return ret;
 }
 
+DEFINE_STATIC_SRCU(acomp_srcu);
+
 static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
 
 	if (!IS_ERR_OR_NULL(acomp_ctx)) {
+		/*
+		 * Even though the acomp_ctx should not be currently in use on
+		 * @cpu, it may still be used by compress/decompress operations
+		 * that started on @cpu and migrated to a different CPU. Wait
+		 * for such usages to complete, any news usages would be a bug.
+		 */
+		synchronize_srcu(&acomp_srcu);
+
 		if (!IS_ERR_OR_NULL(acomp_ctx->req))
 			acomp_request_free(acomp_ctx->req);
 		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
@@ -880,6 +890,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_ctx __percpu *acomp_ctx,
+						  int *srcu_idx)
+{
+	*srcu_idx = srcu_read_lock(&acomp_srcu);
+	return raw_cpu_ptr(acomp_ctx);
+}
+
+static void acomp_ctx_put_cpu(int srcu_idx)
+{
+	srcu_read_unlock(&acomp_srcu, srcu_idx);
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -889,12 +911,12 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle;
 	struct zpool *zpool;
+	int srcu_idx;
 	char *buf;
 	gfp_t gfp;
 	u8 *dst;
 
-	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
-
+	acomp_ctx = acomp_ctx_get_cpu(pool->acomp_ctx, &srcu_idx);
 	mutex_lock(&acomp_ctx->mutex);
 
 	dst = acomp_ctx->buffer;
@@ -950,6 +972,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 		zswap_reject_alloc_fail++;
 
 	mutex_unlock(&acomp_ctx->mutex);
+	acomp_ctx_put_cpu(srcu_idx);
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -958,9 +981,10 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	int srcu_idx;
 	u8 *src;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	acomp_ctx = acomp_ctx_get_cpu(entry->pool->acomp_ctx, &srcu_idx);
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
@@ -990,6 +1014,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+	acomp_ctx_put_cpu(srcu_idx);
 }
 
 /*********************************
-- 
2.47.1.613.gc27f4b7a9f-goog


