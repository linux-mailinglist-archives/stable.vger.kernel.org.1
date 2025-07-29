Return-Path: <stable+bounces-165088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9130DB15003
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4912C5420D6
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60D1C2335;
	Tue, 29 Jul 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1rCrO5K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5B28643F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801776; cv=none; b=PVAgbChuTymNyuEym9pldR8TykgjHEw101UfQBgo/NC2U/gmHtq5+3j2/IFG0itKWnF0sd3GFkRjdOGQNY++heSNF/Mwpg71Z4QtW4nW+nPn+Z1JxvfVtijWTfPe7Wm6lgIjoD1ZqX7TDAQ8yFnrTYh3PZFQcKSmtYJ1iIbSXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801776; c=relaxed/simple;
	bh=KUWUQrI+8FWHdxXSTmyu9N2HSa7QPXqVWrgprJ1np3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jn/dTeM/+I74ThlvwetPYUiOmVzHT/hQOHYK12HS6KbVvdfwKtNNJ1HQwQ8EhE5H2ejW9gW9j0obgZ1ph1XoBZMLiyoRgdGtz6YeKKJohQiP5YQzSAxaRD1UlCU6/KDpDrZL6sBvLm5GEljcH9CF6sG74kIFCnYGT3SHLlePu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1rCrO5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F996C4CEF5;
	Tue, 29 Jul 2025 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753801775;
	bh=KUWUQrI+8FWHdxXSTmyu9N2HSa7QPXqVWrgprJ1np3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1rCrO5K1KrHGDgchM3gnwCnW92w9H4jL28DSJkOb7c/1y8rkvfkY8Cv5guXED+lA
	 Matjb9rttFCo22L7DvPThkXy+BpBJccX9+VYNkIjZe40pxoMcGphAdTCnpEsV4+Nwo
	 xz7BsWq+/HMWjBaQRYyRvRTE5ZmLfvKOTPmquQMJ8OFayvXpF6uBwvlLeuBtOfHskC
	 hkKKDA5KzvxTlNFKR+tE1P/FwdMCyhdD7D9ue2jIHOMpdCYZ5FZd1B2MG5cPS6SdDb
	 928m+Kts4yThBJP3iWLCiJVsvoxl5RZTBmBAW706b8Qwacy7USDR0zKWvgFWhia2rz
	 ajLq1PlTLJDgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n
Date: Tue, 29 Jul 2025 11:09:29 -0400
Message-Id: <20250729150929.2729341-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729150929.2729341-1-sashal@kernel.org>
References: <2025072810-footgear-grumpily-4fd5@gregkh>
 <20250729150929.2729341-1-sashal@kernel.org>
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
index 5f314ec2ff81..f5f80981ac98 100644
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


