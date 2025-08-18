Return-Path: <stable+bounces-171633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D23B2AF6A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 19:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05897A1793
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE400284880;
	Mon, 18 Aug 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFHKJyBj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AAA32C33A;
	Mon, 18 Aug 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538262; cv=none; b=DxqhXf3z7ySQyhO3vJ1Dg2Ir5vYarEc6doEyFCURuynZudZnoRW6yY4uyCqajkHt3imQ/hDSvEznrkuTUJy/3sPYhS+xl/wm05MlpvTkb7ZvYCFM40qh72CTL3ICIklMk+jhj7dy2P7EuHl/Ki3tE7+h/qnMKbkdp45E6QHnfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538262; c=relaxed/simple;
	bh=4Pjd9TNGOPRxXeRTGonj96aAUJIdna38eyaQvAHKeAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YA3/HLyxwU3ATojByqRMYsVQkdRrStkBVOBx9PqR7YFnKA8/rwoLtCJATKR0Y28Q2iH4cfaoCOVdpc/WN7h1uyW9r1N0mHp7+jJ1Jhwm0u0+eaWeSuvE09A+18gCUXJEnv82CUmg1CYk8EG/qrawBYhxM24SxmQRnlMQIR1gOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFHKJyBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB986C116C6;
	Mon, 18 Aug 2025 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538262;
	bh=4Pjd9TNGOPRxXeRTGonj96aAUJIdna38eyaQvAHKeAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFHKJyBjzeGrFzoLouOQOIgQCDBLjhjv844s3Vhx1jnWsPMTBNqqyoGzu+F6CUzBk
	 htBQ3ZDDJ7BwU4PTDNEuVAfzkBtcdqkxoL0Z/t0kEAlMK+O1gMGxzpcFbIQy91ODKs
	 NtcwZ+LDG0qGwPrA5u8/3vTF7EIvQ3aXWEYwFvDoJLy0+AVNGFU8dk10TIJlhgSgqf
	 fsoKAS+0Qu4yuT4BRFHt2Uf1grsROGgYAbiuWuDAshzZCMnBYHerRNnGhaSJbLpSWt
	 Bv4KpVvfMvQipqBVn89oU/0e4WlFgjq2bDMwvAbETUY56yjrZc0XDUAweTvGiqiS1z
	 cgZQHVv4PQB2Q==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.15.y] mm/damon/ops-common: ignore migration request to invalid nodes
Date: Mon, 18 Aug 2025 10:30:58 -0700
Message-Id: <20250818173058.56921-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081832-splendor-carve-f25b@gregkh>
References: <2025081832-splendor-carve-f25b@gregkh>
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
index 1b70d3f36046..32ee3739f1d2 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -476,6 +476,10 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
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


