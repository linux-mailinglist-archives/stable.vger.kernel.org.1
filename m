Return-Path: <stable+bounces-165089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FEB1500C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCCD3A2DF4
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A527F005;
	Tue, 29 Jul 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1xz1eRe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755A881E
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802012; cv=none; b=E163yJq5x9ILQyCnZz+BVAvQN/vYT1yJ0cE/ez7vlqJMyTPsAy48QvuW9Vl8miGnKF4ZciD+3FsGURUS5VvgbbyIIbtvBuqnrh9t02G2/YzIfezUPHblbfx0OfcC1qpiCvtpVPQkYkjkvRLgMEBoZPrm73eV/WHu44qMx1/HrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802012; c=relaxed/simple;
	bh=AVUlBVI8SZOlQyDUSn8aRq8LQ4NgfWQyRUjfVAwiMHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4PuWGLw3IEFag4ViPUy6Ls+7YB5aSVak9IZpnmL1udaLdkmQv/Rxu9H2uNtB9ruwhpplKrMp0s7dWnEPAwxPSChI1OIlX5VyEg6L1cNpKJrwRUdJ+L+3Ut92lrGlNwgU/n2jCFfr7fYS6MKIcaHARDxVyfTImc1/QwAqfyxmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1xz1eRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF03C4CEF4;
	Tue, 29 Jul 2025 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753802011;
	bh=AVUlBVI8SZOlQyDUSn8aRq8LQ4NgfWQyRUjfVAwiMHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1xz1eReSm+uawIYd/KnVCpwpgQR1a6jFDNHM2LkVVEglKEnB9pm8GkHNBpgBWtaI
	 heDDzBpcwRtjInjiw5ogWQDPdnkt/z6OxfZX1Ivgxk5SAPhMCw+zC+Cs+ITIdiUybH
	 edw9GNQ8TzEEM8eLzWc+XLK7FudRpqoi95Om6zjuXxcBVDEVmWuD0c3EKOZXneJOmx
	 jFilXCwnsadESaAbL78Du4iy8OssxPK33a51VZh2D7NaWixVEwIvjabTU0M2ji4Q4C
	 kVYVPlz7IJ+eZsc16Ubpb+ojNxklsTTWP19JaiFmLV/000FF9rywGPJxRFZU8O5hzY
	 rmHhQcYV7g5Xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] mm/zsmalloc.c: convert to use kmem_cache_zalloc in cache_alloc_zspage()
Date: Tue, 29 Jul 2025 11:13:25 -0400
Message-Id: <20250729151326.2730116-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072811-ethanol-arbitrary-a664@gregkh>
References: <2025072811-ethanol-arbitrary-a664@gregkh>
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
index 6b100f02ee43..eae16c6b6fc6 100644
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


