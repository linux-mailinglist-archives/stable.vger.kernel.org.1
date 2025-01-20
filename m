Return-Path: <stable+bounces-109517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377FEA16D7E
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733BF168A65
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4DF1E1A1F;
	Mon, 20 Jan 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMuyYNRP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B01FC8
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380281; cv=none; b=cDX3iemnRCB6Ww1+q4diAKTg/WbLaSmBaKZ5XfaM+UW9M5/t1t/cTcQg9Jmg25RNQ0jLtfrLs84xqswq3rsnUEMVwSSd93rFNK9bDVK/5bW+ZGOMxjomQbn666I0+pc5AqmdTqD7vvUTN7Kw9jbWMjqtC6TAkNrLy/BV+12AkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380281; c=relaxed/simple;
	bh=EtelkOZ3qEH43PetRbMZWb7NFHSRVjZea0/LkUwq9VI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ewix5hnWNVqLT6ZEmhuvK/t2V8xw6oj+izPhF5yYF9YU2/X5O95MY4ZifPbZqSwEWCwxdCrporIqg5rlnavro4wD7renHGHlEdFaDUVfnqF3KY/EGDwB6lv2mP31sTbmeLiWxC7ETCchFnm07peKYEy1KPnjbtKajg3x88fkeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RMuyYNRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460CAC4CEDD;
	Mon, 20 Jan 2025 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737380280;
	bh=EtelkOZ3qEH43PetRbMZWb7NFHSRVjZea0/LkUwq9VI=;
	h=Subject:To:Cc:From:Date:From;
	b=RMuyYNRPyxlUHYnxhpOIV6CrEYGz0D++W0ayJ8vhCxybwphhVmvXpqTMLfU7vTt1q
	 iPZ0GyBwHdoM0dwyiBNtjnzAGuHT+odO8F5DmqtTJs3LPwes/yZfwsZwRa1oJ4vRrS
	 5ePGSyAgznx2QV58SRUtZFGbpwaPMVd52KUHppzg=
Subject: FAILED: patch "[PATCH] mm: zswap: move allocations during CPU init outside the lock" failed to apply to 6.12-stable tree
To: yosryahmed@google.com,akpm@linux-foundation.org,chengming.zhou@linux.dev,hannes@cmpxchg.org,nphamcs@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:37:58 +0100
Message-ID: <2025012057-carrousel-marbled-221b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 779b9955f64327c339a16f68055af98252fd3315
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012057-carrousel-marbled-221b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 779b9955f64327c339a16f68055af98252fd3315 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 13 Jan 2025 21:44:58 +0000
Subject: [PATCH] mm: zswap: move allocations during CPU init outside the lock

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

diff --git a/mm/zswap.c b/mm/zswap.c
index 30f5a27a6862..b84c20d889b1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -820,15 +820,15 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
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
@@ -836,21 +836,25 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
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
@@ -859,15 +863,17 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
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
 


