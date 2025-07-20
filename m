Return-Path: <stable+bounces-163469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28AB0B7D3
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 20:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0241788F0
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2912206B7;
	Sun, 20 Jul 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWJyWLpy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E043382;
	Sun, 20 Jul 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037907; cv=none; b=IrenaqEHHZ8FO56GrtOOqaOMzOEJuDVvl8VQcqbfywP1aI9dIsxKribFwtNE7y4+a14qR2Vj0D4vioePRy0ljZORdYfFJJHcHAwY28Rej5Lslw83PdWSg5rf2w87ytiVBkC1Y1c1HgVGHblGW6TFwp4FpgL9vxv+HhfdWNi7XeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037907; c=relaxed/simple;
	bh=Z4K/L8iVI8412mIfKRLloP1W+n/XlOZFFt9DKKoURFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BNmpT9CxMEf69sXiW8KwNeonTVLoiIRvV4Ew7xqyL1rqdklI0tFWWKR/Ei5Ag7a6MKCi2szbIFbSMUPQjeK76njTuzau9UFZnwWy9gsg/8nT76oIPfvhyf1p6m31PdYzZ70FtkWukVi/2cGT9+e5lD5G5pYPChD14rOcAxN1+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWJyWLpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0169AC4CEE7;
	Sun, 20 Jul 2025 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753037907;
	bh=Z4K/L8iVI8412mIfKRLloP1W+n/XlOZFFt9DKKoURFg=;
	h=From:To:Cc:Subject:Date:From;
	b=UWJyWLpyXtMe4KYH3Ztyry35J19Ro8R2rER8oyZh6JGgNMnlVXYl+OE2S7ggDWLg2
	 z6ZmJjf2j4FW2J2mv83Lgll2m8yB4EcoxaQLyDclqT8HZtboSXYoLbTCd6tz6w/Ioa
	 1qTLh0Fw9iRuYgVUlvCIEhW/U9IZy0cfWHgWCLCaXNLZa1gqS1nHd4qp0F2G9/2QJJ
	 wm7xmqpzIkKQsxfCczGpGdcYYiMdfuRD+nt+3ND8bAbzwNjE61tj6PUkZ0U6Z1YWND
	 4C7UYd5U5CE5qk1Jl0N/UkOA/bQnxhs+Tf7zr+R1Kst8YTKxP9QmACHFRER4PqR5cX
	 zy9aRfDiA+7+Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/ops-common: ignore migration request to invalid nodes
Date: Sun, 20 Jul 2025 11:58:22 -0700
Message-Id: <20250720185822.1451-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_migrate_pages() try migration even if the target node is invalid.
If users mistakenly make such invalid requests via
DAMOS_MIGRATE_{HOT,COLD} action, below kernel BUG can happen.

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
check is stolen from that of do_pages_move(), which is being used for
move_pages() system call.

Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion") # 6.11.x
Cc: stable@vger.kernel.org
Cc: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 6a9797d1d7ff..99321ff5cb92 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -383,6 +383,10 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 	if (list_empty(folio_list))
 		return nr_migrated;
 
+	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
+			!node_state(target_nid, N_MEMORY))
+		return nr_migrated;
+
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nid = folio_nid(lru_to_folio(folio_list));

base-commit: e2c90d41402c324ea81fa3d9c2c1d0f61906c161
-- 
2.39.5

