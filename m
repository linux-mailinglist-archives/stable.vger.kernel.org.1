Return-Path: <stable+bounces-171815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED562B2C86B
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC8C188CC44
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D2285041;
	Tue, 19 Aug 2025 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTq+QWOu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099C2253FC
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617177; cv=none; b=A/kbL4QkNfYScsRsOuEg5ej4xG5m4MqIx4TVZCkgVG1ZmLmdi592k9BVv25Z8z0MxTi6czCdlNydM3B6H7CZsVX6BEwGXgVhKFuInA4D7/mPfA20NKdUaoheatCY6plVwrRSYuqKNNoe2zakfJiP/37IlrS54Vmg9JJpFAYL29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617177; c=relaxed/simple;
	bh=C8n0IVwazlA+gCvBMfVMpE7V0ggUn21Um1FsYbLE/dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1D5PtQ7eA9mfd+Uk3JN/b1h2i+D8PPmfe+KNayPVsC0JGiqqfgoqy/Je6bZ3Nr8lG1vpLLqHCkHo9jQnNfKukfp39x8cTt6brfhWL79aRkjeb8RBj5V6wOl8dvSOQVEdp93Sw3659Vh+Ad4D9BF/SPksmAug4WBs4ylcZ4s5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTq+QWOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF6AC113D0;
	Tue, 19 Aug 2025 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755617176;
	bh=C8n0IVwazlA+gCvBMfVMpE7V0ggUn21Um1FsYbLE/dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTq+QWOuRkJBjAQ59N8CP+R+uSN69jRfSd8Ydby98kvFdb74NUlQsili6P3cyKIpO
	 +piGurUyGpMKpOxFWVuIw4UHWPOJD2bwhaJkiqn9eyHyWR7yjMbKnAoSRvkhmVC6t6
	 DxlLClHp07C4B1cWS2aF0HK2p69J5n8PBCK1lZDFOTk9mzI7yiBRsVKvTn+Lf/tXVw
	 mlJ97QftnPDkdc79FPPwacmYYLo5y7CdmdKwiaoE5rV6PaVUPqCKW8i1AxOEdia1JL
	 dhyP2VHhlT0wbEYMeOKeS68o7hiIaotL+1Jc8BbjGnNXVHrQ3eM/CW4IvpIYXeONTi
	 7NwClzsFyT/8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] mm/kmemleak: avoid deadlock by moving pr_warn() outside kmemleak_lock
Date: Tue, 19 Aug 2025 11:26:13 -0400
Message-ID: <20250819152613.541716-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819152613.541716-1-sashal@kernel.org>
References: <2025081848-proximity-feline-dfea@gregkh>
 <20250819152613.541716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 47b0f6d8f0d2be4d311a49e13d2fd5f152f492b2 ]

When netpoll is enabled, calling pr_warn_once() while holding
kmemleak_lock in mem_pool_alloc() can cause a deadlock due to lock
inversion with the netconsole subsystem.  This occurs because
pr_warn_once() may trigger netpoll, which eventually leads to
__alloc_skb() and back into kmemleak code, attempting to reacquire
kmemleak_lock.

This is the path for the deadlock.

mem_pool_alloc()
  -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
      -> pr_warn_once()
          -> netconsole subsystem
	     -> netpoll
	         -> __alloc_skb
		   -> __create_object
		     -> raw_spin_lock_irqsave(&kmemleak_lock, flags);

Fix this by setting a flag and issuing the pr_warn_once() after
kmemleak_lock is released.

Link: https://lkml.kernel.org/r/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org
Fixes: c5665868183f ("mm: kmemleak: use the memory pool for early allocations")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 4ee0dde910fd..ba0cf87226a9 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -417,6 +417,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
+	bool warn = false;
 
 	/* try the slab allocator first */
 	if (object_cache) {
@@ -434,8 +435,10 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 	else if (mem_pool_free_count)
 		object = &mem_pool[--mem_pool_free_count];
 	else
-		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
+		warn = true;
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+	if (warn)
+		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
 
 	return object;
 }
-- 
2.50.1


