Return-Path: <stable+bounces-107773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6935BA0339A
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 00:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5A1164441
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217381E0E14;
	Mon,  6 Jan 2025 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rONJnj5m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661511DDC04
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207573; cv=none; b=cgOHkwIiprZ8WjivbZAvaI263VJhebIY6o5GpXiXp/HWUVF6jOywMFpF2vzYGPbPJkDcLPFbzBTeMhVIZU2JXae7oBMpudStEV6MU2++w14SGbKSf+UBZvYFYWiIRKagzEMB76wkdjtgT3NNz1pYKP8eskbx2roTCAeMUb/Sgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207573; c=relaxed/simple;
	bh=cefdfB1yGhxUINcQUilu5D19OlaisDnr306U1LVHeRU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nOmU9gSKryFlbqZ+kffKCv9suZtUk+hp80+rAU+/Da130XMZGpCWiRZW2HdOBRGTKmxo4ZW8P5tXqdxzMbPdHlNI9pr4uA+Ulvduc1rAqwU1piKy4dpSjBVf8JqDcW1jFxoR/qr/4lXBVQQUpSR9qIHrnsdh9PJnaTm0YMImIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rONJnj5m; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef114d8346so21007324a91.0
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 15:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736207572; x=1736812372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u7O8GUIoD1UZG/rG8KBOAiEwEk9YL8KfYsJ7/2RZcq0=;
        b=rONJnj5mRlkKaB0qKBntmvMgjw7kWcWnSeYGPOFaklZnFM3KDLZ5D+orab3/061sl5
         JnAuL1zImbOEU/N3U5Li+1WQbiZ76tMB0030aKQdYxYK+I8008cF39DCZK4Rr4/Y6Az0
         +Od1/G6mIor42r9gCNaZzZFsz1eyC6jChUgJPEhy76yk0nVmouPAw8r2g1kkMzTGmyGU
         /DgR5heXuFnY7yL4PNMGTz5fQTv2o3U+Hz+HDdk5kVEnPQjx4xgwKDPPZSZhaosMzQZy
         yjg5wMcZjw1xp7al5D0qZ8uHg0LAysvtnBqRLNe8TdzWhRxDut+R74FiYE1xwrTJXE+j
         tlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736207572; x=1736812372;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7O8GUIoD1UZG/rG8KBOAiEwEk9YL8KfYsJ7/2RZcq0=;
        b=XfPEd38HiiyzKAMoVTwGi3csoDLFivgGtqMsWPOmnwRfgbKuFKD+BTz6ejsk2FFWRK
         TvmO38tYDWmv5FoJGHnWfrEuG63i44xq9oJyZdbKDXvZCuIkWYVGJmV5w6HRGyn1gStM
         R7ZOjUNAvZk6/aMydLG1b99IXgAkygcMn12Mb6PwqfC2E62eF5PgAa2wl0W8MKVpeQal
         f25CBkBcuZMjsHPy+TcOo5Or3kw/Rip/HUDqqf9Z6k1P/JExo6WYjp/wOhn8Wqhgjczr
         /XqRTGrN0eoFsdhQf4t+r3/tqgk6sYCbdNl8Qq314ihHbTh7DKILtZHZUvxEBdckoWYD
         rqFw==
X-Forwarded-Encrypted: i=1; AJvYcCXpa4UOV15hU3cf9C6Mg6rC9ed78GDB/xdH+E+KxMBO7oBdevJhcg2P8oQYS5UZKetW+CDasIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vkIHLMDxQCZWyD3SWvwiHV1OIcacoNup/NDJMg+7p/1O/XYE
	vVAvZTCwoIG1VPSeb8ZcQk6dgtyfqoaXgGg1niW1u2rtvLES4UcI95Ek6ofFHZTNoT6ydlVr9F1
	ZEFFW8jSJ6Vmw7h96vQ==
X-Google-Smtp-Source: AGHT+IEuLrc6Y2QxDWJppEIUEse6ofoa305x2MBQtNxB8/VQXUzNW5wB0Z45mFMFJNRnuQnoIvYGpDktiR5T4yjm
X-Received: from pjh16.prod.google.com ([2002:a17:90b:3f90:b0:2ea:5c73:542c])
 (user=yosryahmed job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5347:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2f452ec37bamr89128041a91.24.1736207571666;
 Mon, 06 Jan 2025 15:52:51 -0800 (PST)
Date: Mon,  6 Jan 2025 23:52:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250106235248.1501064-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: fix race between [de]compression and CPU hotunplug
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
throughout. However, since neither preemption nor migration are
disabled, it is possible that the operation continues on a different
CPU.

If the original CPU is hotunplugged while the acomp_ctx is still in use,
we run into a UAF bug as the resources attached to the acomp_ctx are
freed during hotunplug in zswap_cpu_comp_dead().

The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
use crypto_acomp API for hardware acceleration") when the switch to the
crypto_acomp API was made. Prior to that, the per-CPU crypto_comp was
retrieved using get_cpu_ptr() which disables preemption and makes sure
the CPU cannot go away from under us. Preemption cannot be disabled with
the crypto_acomp API as a sleepable context is needed.

Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
per-acomp_ctx") increased the UAF surface area by making the per-CPU
buffers dynamic, adding yet another resource that can be freed from
under zswap compression/decompression by CPU hotunplug.

There are a few ways to fix this:
(a) Add a refcount for acomp_ctx.
(b) Disable migration while using the per-CPU acomp_ctx.
(c) Disable CPU hotunplug while using the per-CPU acomp_ctx by holding
the CPUs read lock.

Implement (c) since it's simpler than (a), and (b) involves using
migrate_disable() which is apparently undesired (see huge comment in
include/linux/preempt.h).

Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
Cc: <stable@vger.kernel.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb236..5a27af8d86ea9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+/* Prevent CPU hotplug from freeing up the per-CPU acomp_ctx resources */
+static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_ctx __percpu *acomp_ctx)
+{
+	cpus_read_lock();
+	return raw_cpu_ptr(acomp_ctx);
+}
+
+static void acomp_ctx_put_cpu(void)
+{
+	cpus_read_unlock();
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -893,8 +905,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	gfp_t gfp;
 	u8 *dst;
 
-	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
-
+	acomp_ctx = acomp_ctx_get_cpu(pool->acomp_ctx);
 	mutex_lock(&acomp_ctx->mutex);
 
 	dst = acomp_ctx->buffer;
@@ -950,6 +961,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 		zswap_reject_alloc_fail++;
 
 	mutex_unlock(&acomp_ctx->mutex);
+	acomp_ctx_put_cpu();
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -960,7 +972,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	acomp_ctx = acomp_ctx_get_cpu(entry->pool->acomp_ctx);
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
@@ -990,6 +1002,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+	acomp_ctx_put_cpu();
 }
 
 /*********************************
-- 
2.47.1.613.gc27f4b7a9f-goog


