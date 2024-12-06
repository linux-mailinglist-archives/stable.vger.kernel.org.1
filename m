Return-Path: <stable+bounces-99582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3A9E7257
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BF718862FB
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DF3153836;
	Fri,  6 Dec 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lt4Mho9Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F953A7;
	Fri,  6 Dec 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497666; cv=none; b=Wh+pbGs2ImZu5a3nucT6njgz9cIJa9SgPaSvMdhg3hEH0G9WlCmvxnXsMS+3QM+IEzbQQE1dbapowYkzGy+CvX7so/18rjgwuxB0Km6xINVEGPu6l0k/1xkX8PWu6JhWB0N8Rf4rVgn/ZsOn6RrqYRAQem9bo49GoZGqbUCtRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497666; c=relaxed/simple;
	bh=XQlOne5S20kuX2zHC3YnSV8nIQ0g1gmBsPg79LU1TlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvIW/DKKGHyE+v2YIkD2ftZOTz9kjFwapmZbQQ6IvGc+GWb+o7O9fZgqyKG7dq0uVaQKOOiSmfEMGOuJHeKXPySbdvC62m9dS5dxGOIlcRZsnvarD4ya/oArmL1254IAJMdQMgP/K0gqlw+Y182b57suU8Lurv3sVci1shlRxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lt4Mho9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3553CC4CED1;
	Fri,  6 Dec 2024 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497666;
	bh=XQlOne5S20kuX2zHC3YnSV8nIQ0g1gmBsPg79LU1TlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lt4Mho9ZEOroOASOYqTPMkkLR5cMLU3oM+FGjQ4tPIcOYYgLjxkvV9S2q2g8u6uSH
	 B2pqm3UArDTtGRJ4W9iKuZ/dysTgOiDpv5vbr6JqpU5Q7qZXtRXwig3R2SAoUy/sLt
	 QRE4aMNUVDwcj2qK2bmHsJhfmVVNyHaT+h7IiuGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 357/676] f2fs: fix to avoid use GC_AT when setting gc_mode as GC_URGENT_LOW or GC_URGENT_MID
Date: Fri,  6 Dec 2024 15:32:56 +0100
Message-ID: <20241206143707.293062974@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 296b8cb34e65fa93382cf919be5a056f719c9a26 ]

If gc_mode is set to GC_URGENT_LOW or GC_URGENT_MID, cost benefit GC
approach should be used, but if ATGC is enabled at the same time,
Age-threshold approach will be selected, which can only do amount of
GC and it is much less than the numbers of CB approach.

some traces:
  f2fs_gc-254:48-396     [007] ..... 2311600.684028: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1053, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
  f2fs_gc-254:48-396     [007] ..... 2311600.684527: f2fs_get_victim: dev = (254,48), type = No TYPE, policy = (Background GC, LFS-mode, Age-threshold), victim = 10, cost = 4294364975, ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 44898
  f2fs_gc-254:48-396     [007] ..... 2311600.714835: f2fs_gc_end: dev = (254,48), ret = 0, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
  f2fs_gc-254:48-396     [007] ..... 2311600.714843: f2fs_background_gc: dev = (254,48), wait_ms = 50, prefree = 0, free = 44898
  f2fs_gc-254:48-396     [007] ..... 2311600.771785: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:
  f2fs_gc-254:48-396     [007] ..... 2311600.772275: f2fs_gc_end: dev = (254,48), ret = -61, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0

Fixes: 0e5e81114de1 ("f2fs: add GC_URGENT_LOW mode in gc_urgent")
Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 7 +++++--
 fs/f2fs/gc.c                            | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 36c3cb5479013..33675e718a376 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -311,10 +311,13 @@ Description:	Do background GC aggressively when set. Set to 0 by default.
 		GC approach and turns SSR mode on.
 		gc urgent low(2): lowers the bar of checking I/O idling in
 		order to process outstanding discard commands and GC a
-		little bit aggressively. uses cost benefit GC approach.
+		little bit aggressively. always uses cost benefit GC approach,
+		and will override age-threshold GC approach if ATGC is enabled
+		at the same time.
 		gc urgent mid(3): does GC forcibly in a period of given
 		gc_urgent_sleep_time and executes a mid level of I/O idling check.
-		uses cost benefit GC approach.
+		always uses cost benefit GC approach, and will override
+		age-threshold GC approach if ATGC is enabled at the same time.
 
 What:		/sys/fs/f2fs/<disk>/gc_urgent_sleep_time
 Date:		August 2017
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 888c301ffe8f4..e990415824146 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -228,6 +228,8 @@ static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
 
 	switch (sbi->gc_mode) {
 	case GC_IDLE_CB:
+	case GC_URGENT_LOW:
+	case GC_URGENT_MID:
 		gc_mode = GC_CB;
 		break;
 	case GC_IDLE_GREEDY:
-- 
2.43.0




