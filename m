Return-Path: <stable+bounces-171634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD764B2AF80
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 19:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E8617AC60
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8BF2773C8;
	Mon, 18 Aug 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSYYOSKl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A42773C6;
	Mon, 18 Aug 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538438; cv=none; b=IcjArv//83cdgIV7qmIq7wHz5jhxVcY4LXTud5eDQ9Klu2L1Udix+yl0BuLFC4FIXfqJzdzUhlbEs+qW2W3jplUSrfOf2xJ3gtceeXpaYJQY3qNZ2NkdRCGGAa13scl09LdFQvXZW7lmn86LLifXdq6TSoA+ACKnMI9j9O1ZJpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538438; c=relaxed/simple;
	bh=vqyBLna+nZ7Qa7M4Vfzib09tCSisDgnoTvkKrxSb3SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEk1dEuqEyvTEKu9/USj5Sz7G8f0IEe6QSniJAM5+5poukMjH/UpXGiQDXA2poSRB3Mii/UwosPW9Vu5VsdZUZMrzJeDDx254O3a4qDm5/gIZCH/hEOyfy3bTgLqEXIM5LYqDxT+R3lbkC6pgsdvw01Wk9sWPfMyHSqJQl1ajTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSYYOSKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461F1C4CEEB;
	Mon, 18 Aug 2025 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538437;
	bh=vqyBLna+nZ7Qa7M4Vfzib09tCSisDgnoTvkKrxSb3SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSYYOSKlyRBfaQc34OVGF1HY/AecIGK/P71o1BWWIg+SeH21eOjPZ0VQnZtaie+og
	 URGuRI5iyoSN/CHlKhnDYwDgEz7oXxojQFsLxNWkSayZtBihVXMPNZ9BIsEZC+Xuw4
	 ik4k2A0D+tUDd83Yb2D1Sc1GV3V1OhLDJxmIL4V4kQkIz47ECCX5ALHafXcZxC8m6C
	 SZs4t5uo+BFRvIt/llpuPbsnACL2hU0spsHL966UMOJ93P6zRWRDpfIHKUNkvJzC4Z
	 lrxeshyN9Bf42BDdIpIUgimpwJTz7qqsEfumkoGw3A4qVC9U65Dz3awdchjPNkJxNy
	 06iW3jkJpaPfg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/ops-common: ignore migration request to invalid nodes
Date: Mon, 18 Aug 2025 10:33:54 -0700
Message-Id: <20250818173354.59050-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081833-booting-yelling-d0fa@gregkh>
References: <2025081833-booting-yelling-d0fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_migrate_pages() tries migration even if the target node is invalid.
If users mistakenly make such invalid requests via
DAMOS_MIGRATE_{HOT,COLD} action, the below kernel BUG can happen.

    [ 7831.883495] BUG: unable to handle page fault for address: 0000000000001f48
    [ 7831.884160] #PF: supervisor read access in kernel mode
    [ 7831.884681] #PF: error_code(0x0000) - not-present page
    [ 7831.885203] PGD 0 P4D 0
    [ 7831.885468] Oops: Oops: 0000 [#1] SMP PTI
    [ 7831.885852] CPU: 31 UID: 0 PID: 94202 Comm: kdamond.0 Not tainted 6.16.0-rc5-mm-new-damon+ #93 PREEMPT(voluntary)
    [ 7831.886913] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.el9 04/01/2014
    [ 7831.887777] RIP: 0010:__alloc_frozen_pages_noprof (include/linux/mmzone.h:1724 include/linux/mmzone.h:1750 mm/page_alloc.c:4936 mm/page_alloc.c:5137)
    [...]
    [ 7831.895953] Call Trace:
    [ 7831.896195]  <TASK>
    [ 7831.896397] __folio_alloc_noprof (mm/page_alloc.c:5183 mm/page_alloc.c:5192)
    [ 7831.896787] migrate_pages_batch (mm/migrate.c:1189 mm/migrate.c:1851)
    [ 7831.897228] ? __pfx_alloc_migration_target (mm/migrate.c:2137)
    [ 7831.897735] migrate_pages (mm/migrate.c:2078)
    [ 7831.898141] ? __pfx_alloc_migration_target (mm/migrate.c:2137)
    [ 7831.898664] damon_migrate_folio_list (mm/damon/ops-common.c:321 mm/damon/ops-common.c:354)
    [ 7831.899140] damon_migrate_pages (mm/damon/ops-common.c:405)
    [...]

Add a target node validity check in damon_migrate_pages().  The validity
check is stolen from that of do_pages_move(), which is being used for the
move_pages() system call.

Link: https://lkml.kernel.org/r/20250720185822.1451-1-sj@kernel.org
Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion")	[6.11.x]
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Honggyu Kim <honggyu.kim@sk.com>
Cc: Hyeongtak Ji <hyeongtak.ji@sk.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7e6c3130690a01076efdf45aa02ba5d5c16849a0)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 8813038abc6f..4120a73f4933 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -431,6 +431,10 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 	if (list_empty(folio_list))
 		return nr_migrated;
 
+	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
+			!node_state(target_nid, N_MEMORY))
+		return nr_migrated;
+
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nid = folio_nid(lru_to_folio(folio_list));
-- 
2.39.5


