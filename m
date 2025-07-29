Return-Path: <stable+bounces-165090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3794CB1500D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8083318A1C0D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14328643F;
	Tue, 29 Jul 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0uyKoES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F3881E
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802015; cv=none; b=pfbC1qbWy/m3kRz3to+g8g+Bv0HxfArORrKkbNXriRHC3H49XsolMS/+DYp6rhhVMxQH1Jb3Ln6m9VotBhkPEoMGQRk6JISAeDOkjJ6gi5ko94lzkiZE12S9wfNRv1Fv4YvqSUiXz2ab3BfPTyAIZQbGzSPmkTSAmsm7HY/ZA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802015; c=relaxed/simple;
	bh=W3C5bt7cvUmJ7xoY2jZlrkv8OsLvUiWNz8pD6WheB4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjvS9juz0msKnqlyBzt9T4aXPfyZoM5uBsvDWytKlU7Og6eVi+gTbm2oC95YgoeYbLbU5OB/RpEU5XO3tNjK0TVv7wBXlEhrGGY/RJRbnVXyNWqHdZ+RRgs9uFMoPKVoTk4GagdpyEelZgChPFyrJLKWsHjkIj9llE8rgiv4ap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0uyKoES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E8CC4CEF9;
	Tue, 29 Jul 2025 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753802013;
	bh=W3C5bt7cvUmJ7xoY2jZlrkv8OsLvUiWNz8pD6WheB4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0uyKoESnI2V7VeAwDgq+EeynKz4uZNQd+orsvE8+EZvIUN6pAzmiW3H59dF1ChNE
	 3KmucIkTkrMMq68VgL5ABjzKC/4mOhdEfkJ/zSqK/YXGxtQ/NGrUbXb8k5x2s3R+T7
	 SQx0MWCMRTDCVlLnykJbpUqq5SfvTyJgLaeGJPpINHapsRkFFZOgmEIH4GzNaPRm6q
	 Rp+NOM+V2SkwdZum+HuKcgwNGckmyF1Ftg0b5rbNgHo4+BtHGelKfwNT3RXwgPfR5C
	 mWMz/rpaLX2y2eh+b+b16FyAHsAY5fv7PHalOBiEV8EdSuDf5ovyhzW03vUC7cR+sB
	 rVWWHoywDw1SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n
Date: Tue, 29 Jul 2025 11:13:26 -0400
Message-Id: <20250729151326.2730116-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729151326.2730116-1-sashal@kernel.org>
References: <2025072811-ethanol-arbitrary-a664@gregkh>
 <20250729151326.2730116-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harry Yoo <harry.yoo@oracle.com>

[ Upstream commit 694d6b99923eb05a8fd188be44e26077d19f0e21 ]

Commit 48b4800a1c6a ("zsmalloc: page migration support") added support for
migrating zsmalloc pages using the movable_operations migration framework.
However, the commit did not take into account that zsmalloc supports
migration only when CONFIG_COMPACTION is enabled.  Tracing shows that
zsmalloc was still passing the __GFP_MOVABLE flag even when compaction is
not supported.

This can result in unmovable pages being allocated from movable page
blocks (even without stealing page blocks), ZONE_MOVABLE and CMA area.

Possible user visible effects:
- Some ZONE_MOVABLE memory can be not actually movable
- CMA allocation can fail because of this
- Increased memory fragmentation due to ignoring the page mobility
  grouping feature
I'm not really sure who uses kernels without compaction support, though :(

To fix this, clear the __GFP_MOVABLE flag when
!IS_ENABLED(CONFIG_COMPACTION).

Link: https://lkml.kernel.org/r/20250704103053.6913-1-harry.yoo@oracle.com
Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index eae16c6b6fc6..b379deb0a10c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1067,6 +1067,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!zspage)
 		return NULL;
 
+	if (!IS_ENABLED(CONFIG_COMPACTION))
+		gfp &= ~__GFP_MOVABLE;
+
 	zspage->magic = ZSPAGE_MAGIC;
 	migrate_lock_init(zspage);
 
-- 
2.39.5


