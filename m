Return-Path: <stable+bounces-107911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D80A04C2A
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F421662DF
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 22:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A691AA1F4;
	Tue,  7 Jan 2025 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUS7KRgF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC431A3035
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288563; cv=none; b=ZvngEWUActUhTMG6OE8mdYPP+38RgXrkdhYDSYA3t9bA4bP7yFrxdzUwaUtl6LZogaq9o0IXP4oBYBCghiQFmXGK79YtROWildIsX7yuNM+api+SjGQi8BzZnCVXn7IAz54ArWMyVunln8TnAMxK/yfpzuDmmTD6C/DOrrJo3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288563; c=relaxed/simple;
	bh=d3eL0PqnjhoB8ATjnEX2YRriKh37QttkW2G0gPI/das=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m6MyE1l1JwSigSOB1ulcdDvEM7/2+QO6dnEkevkFA0KfGlExmUmVvV8MMIHhLbh0zwHRnOyNwodUS6++5VX+MecqechRLhbsVZBCi9lvUz+GRN6HqZD3fAMe61a3wr38xhgGOxULtpVVIyKsLxDKtdHhxRPPcTIY4Ra1lPRx3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUS7KRgF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21648ddd461so290172915ad.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 14:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736288561; x=1736893361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8OEPHYADGiebrrUIJmwP++YfNdezEkFFL7taBOiv4vY=;
        b=sUS7KRgFM5D/TCEhpFLvtkPkJWvH464Y36pTV72Vpc0P6G7uH08iZGBXuQtP2xqr0d
         2+6f37VshYe8wn//D7WfoI78myMq7pJU9JrnekUWbnGXs9v1f1CKBGvWQK7ALMc2rrTH
         AcS0/c5KKO3+vXZK8Am6p6I5tM7e1XQqjTa18Cbuf0sneuMNQclf7RkvW+xMHO0aL/yW
         J38pWvqVR5qd8K1dOOKWjVZ7K8LCMNtJCP/GUjkNbrIWFKX0hxGmHR+lofPZ7B7pPwf1
         64DjNNI2ntpNVC56GTEvRr3tHiBOcl6HzCIFeLwlTGBoq+G7OBNzLeMIjMywAs9fTn2X
         mWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736288561; x=1736893361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OEPHYADGiebrrUIJmwP++YfNdezEkFFL7taBOiv4vY=;
        b=qGwAL0Vy7Rlc7sAhA+b3myxwu7nFEAapnFOBljP1M8bjEXx2PX/FUuV4+TAt7Eftg5
         GnFuvagJ2hXRuzlTYFo2PMhL+cqsdhaf3TKTdnl/qr2y9h5fp+iezYximd/nl4FVcuNh
         qi+zzVw7lEDoT4EYfaDGBZJDdyU8xg1da490jC868AposDiuIkEtqADntx5Ks8sbSw+w
         gX7AUAqiJA7xpfvco7Dt9e3Nzsx1sjXWM1NJax513lhFm3VMYiws566YijtXlZVNeWe5
         QsaqW0my/+wUeQto4g/LaVXDOdtHUSOHAbqeZ4UqmF/oK6Rxb7HZ97t52B+C3vi9CSdQ
         SNyw==
X-Forwarded-Encrypted: i=1; AJvYcCWKZsYpIEmL3aliNcb02wD7Cd5xhGDJayi1XhsUoASDdsw1Ex7LxT27ywV7kKZmBOPW76bNk4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYAbjU396trE70Ov/+EF9CiWqN3TsoLj+oaHaO9XMdsqyXvpW
	3w7yAN6tql1cuUgEP+A4lbjjS3a5s4p2ILVaVJagUVmdIQpHrqSAdaoMFgxOPY6SFrVlkpvBKRR
	/cpQoOXMu36CRi1NOTQ==
X-Google-Smtp-Source: AGHT+IEgs5IL10xqkJJftn7yhmclPLhI6k7/GpQT4G68VnNLJlk+dMe1GT3gZ8d2wJgSYVs0Bs7gZdOCLhcukz9L
X-Received: from pfwo11.prod.google.com ([2002:a05:6a00:1bcb:b0:725:f045:4714])
 (user=yosryahmed job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c681:b0:1e6:44b4:78ab with SMTP id adf61e73a8af0-1e88d0edb56mr1529448637.8.1736288560944;
 Tue, 07 Jan 2025 14:22:40 -0800 (PST)
Date: Tue,  7 Jan 2025 22:22:35 +0000
In-Reply-To: <20250107222236.2715883-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107222236.2715883-2-yosryahmed@google.com>
Subject: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-mm@kvack.org, 
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

This cannot be fixed by holding cpus_read_lock(), as it is possible for
code already holding the lock to fall into reclaim and enter zswap
(causing a deadlock). It also cannot be fixed by wrapping the usage of
acomp_ctx in an SRCU critical section and using synchronize_srcu() in
zswap_cpu_comp_dead(), because synchronize_srcu() is not allowed in
CPU-hotplug notifiers (see
Documentation/RCU/Design/Requirements/Requirements.rst).

This can be fixed by refcounting the acomp_ctx, but it involves
complexity in handling the race between the refcount dropping to zero in
zswap_[de]compress() and the refcount being re-initialized when the CPU
is onlined.

Keep things simple for now and just disable migration while using the
per-CPU acomp_ctx to block CPU hotunplug until the usage is over.

Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
---
 mm/zswap.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb236..ecd86153e8a32 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+/* Remain on the CPU while using its acomp_ctx to stop it from going offline */
+static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_ctx __percpu *acomp_ctx)
+{
+	migrate_disable();
+	return raw_cpu_ptr(acomp_ctx);
+}
+
+static void acomp_ctx_put_cpu(void)
+{
+	migrate_enable();
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


