Return-Path: <stable+bounces-109927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759C4A18491
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADFA18827CD
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EA51F76BB;
	Tue, 21 Jan 2025 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZU+e32X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDC1F7574
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482843; cv=none; b=tGnL85dkuaE2by05aeAATNoDaaJ6YVktjHzI9XC2thKPNryTxkcvRCbIRbS6J9BIGM/RXNGYnybFQUWERBBClKkOg2msSr4LNc9w+gwSkdlrf0TZqFmvyFUB/psArw+l78DfL8tIsREZCBSfjpkdMN+O8DRFgv/rVm9oI/v13OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482843; c=relaxed/simple;
	bh=IyHg7X+QkwUdqUMVJBD1PeK6UL9Y4rVeMZ0OOoNAh6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p/nlX/N0pT5lPbMPC+oH6yPgtjgF7/wd1xdyHbLUrOZPiti1/452V2OgWtgiagELTovASMOWq5le2RyxFHpvKpCcBT5eMh5j5rOoFB3z/2IEzP2w/OZZbOxuU9IO25fq3SdJMNPoIh+2rVjbVkzUkKbO+apwq265eHTn1KT8Oqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZU+e32X; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so11069078a91.3
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737482841; x=1738087641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixE5bJ2VBGNpKnJDfDYxHIngEU7l3RP52SCVRnLO0ss=;
        b=LZU+e32XHdZAwNchFH1kDc5WVabpOnmoz6GBoeQSK7t1mPIE1d6SB7pz+Q8DpLNQw1
         b+XXZ7gs70PvVmUjaTGShVNpPVlcqEsEB0BymT875PxM9K3inKR9EPq0ZorKSA71U3EN
         oPY5XiEEGwYf70etZxlSrjkP8EyU6pgUfNE8IcRifme7VeIL0Sx6qwMrflwYC9XLXwiR
         KFFlbeDhPzIwlp0C+fGjqBqx1pLjxrc11RkkEDLx81B0BtfKhZDyUaGLHh8MNu/VFkdb
         j3/ou+4up/NVM0aE9XkK4uK03cBcpQkaB0JyEOHNKvqgN8aWYjsGLcnltNwSAEEa2y6K
         eS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482841; x=1738087641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixE5bJ2VBGNpKnJDfDYxHIngEU7l3RP52SCVRnLO0ss=;
        b=uCKnTIz0+WhYqSrlg4egZq0tY9v+iNdqVSq9U+9+QzIzDPfyILvK4JTgRS9cJ8hpEw
         S3wVFhquPhwlMqACHAhSutIeSLpcwswAQUgOeD7vuMsucQVaYcpbggyvHSEn8zXiy7d4
         vQeBqFbIzgMqCEYS+JkirDRP4uYiF2UFeWipA2HDxP165VmmgF5gNX+lBYHq9XIPodVT
         blANqUd8L4v0ZIs6aWgDO6N6bzfRXBKr3ZL2gzUsEGj4R95GpDTmB/A+CQrpQxRD6P2V
         Svgvu+DLU7mAR1kHzyLgFhtoeRfyT+dUxFWl9INMv21yA0t0lhxDI233TimQE+26orzX
         b9hQ==
X-Gm-Message-State: AOJu0Yy/8uBx1uau7yTJpBZeBgt9i/5/fzTIg41HO7/0lRDLeyryOEa/
	C1EsSkXcwrfkEOGtRucM5hU9f1nx6Mpt71WSOwvWfQBGSIjcLcjYsjqv1kxdQj1IGjTSPI/yF2M
	HWDFDy7JkvZI87X56qU++l1FxunVGlpz0LsbnrgAsXdFpKzlRUb3xbl88zrzhxyGlz41Bbn1LV+
	hX1uSdn974f2YdLPipx5/zOrbUcuXqZ9oNNDIhP1pGxLPYsuT9WhJ5wQ==
X-Google-Smtp-Source: AGHT+IEZHJFKNDfIrVW3lbenX+msigoipO84qsvIWekc+wDkUBFir/JADu2QB220/1mwUWFO7tY9W/emQqijJxrx
X-Received: from pfbay27.prod.google.com ([2002:a05:6a00:301b:b0:72d:261f:af23])
 (user=yosryahmed job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:13a0:b0:72d:9ec5:922 with SMTP id d2e1a72fcca58-72dafbf04f5mr25883261b3a.24.1737482841034;
 Tue, 21 Jan 2025 10:07:21 -0800 (PST)
Date: Tue, 21 Jan 2025 18:07:16 +0000
In-Reply-To: <20250121180716.3590378-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025012011-urgency-shredder-353e@gregkh> <20250121180716.3590378-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250121180716.3590378-2-yosryahmed@google.com>
Subject: [PATCH 6.12.y 2/2] mm: zswap: move allocations during CPU init
 outside the lock
From: Yosry Ahmed <yosryahmed@google.com>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

In zswap_cpu_comp_prepare(), allocations are made and assigned to various
members of acomp_ctx under acomp_ctx->mutex.  However, allocations may
recurse into zswap through reclaim, trying to acquire the same mutex and
deadlocking.

Move the allocations before the mutex critical section.  Only the
initialization of acomp_ctx needs to be done with the mutex held.

Link: https://lkml.kernel.org/r/20250113214458.2123410-1-yosryahmed@google.com
Fixes: 12dcb0ef5406 ("mm: zswap: properly synchronize freeing resources during CPU hotunplug")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 779b9955f64327c339a16f68055af98252fd3315)
---
 mm/zswap.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index db81fd7c3f1b2..7fefb2eb3fcd8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -815,15 +815,15 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
-	struct crypto_acomp *acomp;
-	struct acomp_req *req;
+	struct crypto_acomp *acomp = NULL;
+	struct acomp_req *req = NULL;
+	u8 *buffer = NULL;
 	int ret;
 
-	mutex_lock(&acomp_ctx->mutex);
-	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
-	if (!acomp_ctx->buffer) {
+	buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buffer) {
 		ret = -ENOMEM;
-		goto buffer_fail;
+		goto fail;
 	}
 
 	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
@@ -831,21 +831,25 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
 		ret = PTR_ERR(acomp);
-		goto acomp_fail;
+		goto fail;
 	}
-	acomp_ctx->acomp = acomp;
-	acomp_ctx->is_sleepable = acomp_is_async(acomp);
 
-	req = acomp_request_alloc(acomp_ctx->acomp);
+	req = acomp_request_alloc(acomp);
 	if (!req) {
 		pr_err("could not alloc crypto acomp_request %s\n",
 		       pool->tfm_name);
 		ret = -ENOMEM;
-		goto req_fail;
+		goto fail;
 	}
-	acomp_ctx->req = req;
 
+	/*
+	 * Only hold the mutex after completing allocations, otherwise we may
+	 * recurse into zswap through reclaim and attempt to hold the mutex
+	 * again resulting in a deadlock.
+	 */
+	mutex_lock(&acomp_ctx->mutex);
 	crypto_init_wait(&acomp_ctx->wait);
+
 	/*
 	 * if the backend of acomp is async zip, crypto_req_done() will wakeup
 	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
@@ -854,15 +858,17 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);
 
+	acomp_ctx->buffer = buffer;
+	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_sleepable = acomp_is_async(acomp);
+	acomp_ctx->req = req;
 	mutex_unlock(&acomp_ctx->mutex);
 	return 0;
 
-req_fail:
-	crypto_free_acomp(acomp_ctx->acomp);
-acomp_fail:
-	kfree(acomp_ctx->buffer);
-buffer_fail:
-	mutex_unlock(&acomp_ctx->mutex);
+fail:
+	if (acomp)
+		crypto_free_acomp(acomp);
+	kfree(buffer);
 	return ret;
 }
 
-- 
2.48.0.rc2.279.g1de40edade-goog


