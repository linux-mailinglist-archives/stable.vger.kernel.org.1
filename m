Return-Path: <stable+bounces-165087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A8B15002
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE573AF66D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74C2857DE;
	Tue, 29 Jul 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoIFqOfa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBCC1F30A4
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801775; cv=none; b=g0beRkhg/5vwqPpvmhQowEXkSLo3aY1Sycr/dcHjE4TbDRexYHNhutXaPbCbCVspE2zikp6zRTmzi1D+ii0WQANPWUuOK70DjUo05CWys1BQyZeorN4GdybrUQBOFiowiT15xNqH/WJSCcZkUKY3pPGC+vJMLkDvsePYkEceSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801775; c=relaxed/simple;
	bh=98P6IJpyzAAt1v2NuERK4BMtgJTCzEIVZeLUvgjLpHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVfsSaqUo1VkQY2DcRrJQW7ZOc0F0bPGe1igNPHhc0EIybH7PZmenY4dQ4Un6962YCQQ8o+JOrLDav4cFaQjk/pMP4RnXlR4M93gqCpNgSDTC+3qUOTqndqLZHg5J7a4WI3+tljMQp7OXJJ8KC4GujZAJL+9zA3Pm6uB8N3fiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoIFqOfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD09CC4CEEF;
	Tue, 29 Jul 2025 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753801774;
	bh=98P6IJpyzAAt1v2NuERK4BMtgJTCzEIVZeLUvgjLpHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OoIFqOfafH1WXAsX3aMi8c3Vtzfgt4Jx1rZZsS7S/khuK14vJJpM6+DOP5dk0YBtW
	 EHSiux/h7CY3APVKX4oIXPlnQR/QzKHw6bpbWQOv5EA7709pnHUfTWHn/ZkD1oNuXZ
	 bclBNyK4LIMHEA7tfkBjxkF6vybm7vczxuvy3+4VBKiH+AnE3YekNB4TlJUpEN1+Mr
	 yUcryUF93kTp5iMc1KDHrn7rFkvMkqnX2aIpuEe2KPrtSmTt9i1h1RaBgLr9h1kmX9
	 jhDH4XOcbO1rxVYmuNvruh6AfWzzCIP7fOBJCMqrQ7GLgKBQwBGoOnwkuiUeOkdBAT
	 OWiL/EK9tr4Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mm/zsmalloc.c: convert to use kmem_cache_zalloc in cache_alloc_zspage()
Date: Tue, 29 Jul 2025 11:09:28 -0400
Message-Id: <20250729150929.2729341-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072810-footgear-grumpily-4fd5@gregkh>
References: <2025072810-footgear-grumpily-4fd5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit f0231305acd53375c6cf736971bf5711105dd6bb ]

We always memset the zspage allocated via cache_alloc_zspage.  So it's
more convenient to use kmem_cache_zalloc in cache_alloc_zspage than caller
do it manually.

Link: https://lkml.kernel.org/r/20210114120032.25885-1-linmiaohe@huawei.com
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 694d6b99923e ("mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c18dc8e61d35..5f314ec2ff81 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -357,7 +357,7 @@ static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
 
 static struct zspage *cache_alloc_zspage(struct zs_pool *pool, gfp_t flags)
 {
-	return kmem_cache_alloc(pool->zspage_cachep,
+	return kmem_cache_zalloc(pool->zspage_cachep,
 			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
 }
 
@@ -1067,7 +1067,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!zspage)
 		return NULL;
 
-	memset(zspage, 0, sizeof(struct zspage));
 	zspage->magic = ZSPAGE_MAGIC;
 	migrate_lock_init(zspage);
 
-- 
2.39.5


