Return-Path: <stable+bounces-169951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4EB29E53
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB48D166B9B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFD330E84C;
	Mon, 18 Aug 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JxEp9c6v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCFB244684
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510455; cv=none; b=Ge1haszu51iN023qNe9pFRP3CbIj0rIG/z4Yde5A2zJ3zWLpvyb6MBxHbqOpX62kAklAA35sRQGzFXspLs8Ec/qqge7i/bO32v5BWZhnqOC3PlytIGq16uIRPXiStsnWvt28UJOMC99VTftpRihUjH3nesB78Z+rRtl5RDsilrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510455; c=relaxed/simple;
	bh=FfzooKJy4vcRSZi2//YEbRtDU09SCxyRTJ95U4xaxgU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dtD2QtNmNRXdZ2v/X6FM3sxosH7Ig9HZVtIVOHywWLA7a4VkdKUGYMniHNW82q0AX2qzDNgjc9TLQO1brpfwdaKmBIEMo5SmQDZ/DSGFVzHmV0brH5GfoKdfzwI5QROkrN3S2QYcPM7hRYvuN5YK14kUxsAkkMYJwhh0dPAYKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JxEp9c6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30238C4CEEB;
	Mon, 18 Aug 2025 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755510454;
	bh=FfzooKJy4vcRSZi2//YEbRtDU09SCxyRTJ95U4xaxgU=;
	h=Subject:To:Cc:From:Date:From;
	b=JxEp9c6vyVHZ8u6UlilwjNmSEAM8R+HQLzAWj3G6cp6UAhhzs1Rs5OWsfCbvlbEb/
	 yKdHw5wY14hDI+pdR7BpgG2xU2HaTSlX32h8WoTGmrnKslkoYcybGPlUcQME1NUJq9
	 LZwfGUG+wBrjnLvPdr9Sw9msUkMPCn+fQBsUFX0w=
Subject: FAILED: patch "[PATCH] mm/damon/ops-common: ignore migration request to invalid" failed to apply to 6.16-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,honggyu.kim@sk.com,hyeongtak.ji@sk.com,joshua.hahnjy@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 11:47:31 +0200
Message-ID: <2025081831-singular-geologist-93a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 7e6c3130690a01076efdf45aa02ba5d5c16849a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081831-singular-geologist-93a6@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e6c3130690a01076efdf45aa02ba5d5c16849a0 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sun, 20 Jul 2025 11:58:22 -0700
Subject: [PATCH] mm/damon/ops-common: ignore migration request to invalid
 nodes

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


