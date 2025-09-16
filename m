Return-Path: <stable+bounces-179676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB4B58C3F
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 05:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852E9485623
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83202566E2;
	Tue, 16 Sep 2025 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghnep31B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B12AD24;
	Tue, 16 Sep 2025 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757992553; cv=none; b=S8QdckW5aI+VrF5OFsUYnbsG6+FfQmYiZO2u8OCkKVkYkjvpriU6kqFUjuxd2B3PAabI6NQGoJgKb/woPpY9i19tu/5spbx7krZcIBmE6idCro5JX9AdAAArhKcHtDKRtMF/DrDWwtugR4N66pNUNw8pNZAeLMvuRBE/Eq8f9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757992553; c=relaxed/simple;
	bh=Q+ZVTVz4mEvUkB+hpSZhEe9TJff7bsWdkkhr92sx/0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qlVM8Tf1pEnwAqC/kS73IghoiTTKvBJKxhFg5VZ08/N9R2P4fl1cY+Ts1BB4K49fjuaqghhy4UHt9FwRUlgbFXDbqr5LBGebQknlxgphEZPQHzydNetj181HGKEfsLozkLoxSk13+/BwU/TFKkQDx3GeTAybCtuMvetD1rW79iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghnep31B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34A3C4CEEB;
	Tue, 16 Sep 2025 03:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757992552;
	bh=Q+ZVTVz4mEvUkB+hpSZhEe9TJff7bsWdkkhr92sx/0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=ghnep31BqKD/QI5//aXn+PGWVlVVqTd59xS+nluKGfAIZ2K3QjLcqmB32MYENgJ9D
	 Xg8c8wHroj1Bo5EpTAI/BnZPZlOlx6dCgy+1tEKeO4Ujcr2L+GAS2YwfRlYf1KbgzL
	 HEfe97qgyByZ+uwppvRb77tgTQRBewjDhMNTUqkP0z42fyZNj6NVoH6Ye6GHw16JVv
	 zgl9KdctOri1oNyLuPJzUj4foa1118dkP7vsLvXNPanvBnq1M/2/wgmd1WMaDdHKlT
	 QnsNQIlLALMy0G9nj+m4QK7RQ+2toIK1do3l/X83c30uWiy9pWkxHaYIquYelERVkV
	 46Myp3LxWK+sg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 11 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: [PATCH] mm/damon/lru_sort: use param_ctx for damon_attrs staging
Date: Mon, 15 Sep 2025 20:15:49 -0700
Message-Id: <20250916031549.115326-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_lru_sort_apply_parameters() allocates a new DAMON context, stages
user-specified DAMON parameters on it, and commits to running DAMON
context at once, using damon_commit_ctx().  The code is, however,
directly updating the monitoring attributes of the running context.  And
the attributes are over-written by later damon_commit_ctx() call.  This
means that the monitoring attributes parameters are not really working.
Fix the wrong use of the parameter context.

Fixes: a30969436428 ("mm/damon/lru_sort: use damon_commit_ctx()")
Cc: <stable@vger.kernel.org> # 6.11.x
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
This was a part of misc fixes and improvements for 6.18 [1], but Joshua
thankfully found this is fixing a real user visible bug.  So sending this
separately as a hotfix.

[1] https://lore.kernel.org/20250915015807.101505-4-sj@kernel.org

 mm/damon/lru_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 14d31009c09e..ab6173a646bd 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -219,7 +219,7 @@ static int damon_lru_sort_apply_parameters(void)
 		goto out;
 	}
 
-	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
+	err = damon_set_attrs(param_ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		goto out;
 

base-commit: ea93a9235c1c6e61cfa6e5612b7b6b3fc41e79e1
-- 
2.39.5

