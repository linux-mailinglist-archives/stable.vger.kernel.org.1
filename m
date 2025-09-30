Return-Path: <stable+bounces-182002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB596BAAD05
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 02:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8575E16DC8B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 00:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F12317A31E;
	Tue, 30 Sep 2025 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFgJtw5A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E994A0A;
	Tue, 30 Sep 2025 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193057; cv=none; b=lzXNNvAK+agDgr2PrYpOH6hnMPK1d0aFpR+ReEABUpc69Lszdy0Hue3mGB7YN0Mi77RF+jPHib/0Z/CzdkIzIgzNvbjOKl93MWRQEEsacqUCcWBgS15yFCC7mJggnzBotRMWHUwxePqdUVeQhX+PFIjko9q9hm4Q+PKN4E+KrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193057; c=relaxed/simple;
	bh=UG8UCbAm0S/mQH2S995hl54PecX4r3H8TVBvdoOGWy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0wi2AtFoX5qM37kTlX3UWOadwGGzJfc895zv90mt9DItZDexmRazDrnKu8eMw5PMdvlqVMP6w5JyM/o5rnXTYKrpSnLzHFIQ4bf2iT0HTrfCW0BBTOVANyWVEECMm4URpyZoSR5sQlzQ21zGh909/XthvBAWPOe8MsY+yvczhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFgJtw5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7868BC4CEF4;
	Tue, 30 Sep 2025 00:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759193056;
	bh=UG8UCbAm0S/mQH2S995hl54PecX4r3H8TVBvdoOGWy0=;
	h=From:To:Cc:Subject:Date:From;
	b=WFgJtw5ACgIRAyKx3TKKMwbhW2WgSueANdrKKbBKdBndFiq7YY5atdMu2O22g8QN1
	 yu+15Uc2wTr8dJIc8VNZlP5mGQf6Q5zfJO2YWMgfzwZdgYrHg9absTE3yyFSk6iExz
	 j5bRLRcB1/XBqJOaDqwy81kYqxdKW/M0YRCDY2QYVRFAYw02zcyMPigm6BLoyHaVb8
	 BZ29MuEK9lvrWETT4xLxojgvwUWqgJr9r0V13dn3yWY0BOns/PvvyFbJXk0lLkO23U
	 wz0aXjFsmt7nrXiMJCwxlnoBUvWj6bgS4REbPqTpJ67KcRA9C2Z8cCLnSBfRno8VdM
	 zeAbiqY3mfOdA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 5 . x" <stable@vger.kernel.org>,
	Hugh Dickins <hughd@google.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Xinyu Zheng <zhengxinyu6@huawei.com>
Subject: [PATCH] mm/damon/vaddr: do not repeat pte_offset_map_lock() until success
Date: Mon, 29 Sep 2025 17:44:09 -0700
Message-Id: <20250930004410.55228-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON's virtual address space operation set implementation (vaddr) calls
pte_offset_map_lock() inside the page table walk callback function.
This is for reading and writing page table accessed bits.  If
pte_offset_map_lock() fails, it retries by returning the page table walk
callback function with ACTION_AGAIN.

pte_offset_map_lock() can continuously fail if the target is a pmd
migration entry, though.  Hence it could cause an infinite page table
walk if the migration cannot be done until the page table walk is
finished.  This indeed caused a soft lockup when CPU hotplugging and
DAMON were running in parallel.

Avoid the infinite loop by simply not retrying the page table walk.
DAMON is promising only a best-effort accuracy, so missing access to
such pages is no problem.

Reported-by: Xinyu Zheng <zhengxinyu6@huawei.com>
Closes: https://lore.kernel.org/20250918030029.2652607-1-zhengxinyu6@huawei.com
Fixes: 7780d04046a2 ("mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails")
Cc: <stable@vger.kernel.org> # 6.5.x
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 8c048f9b129e..7e834467b2d8 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -328,10 +328,8 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	}
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte) {
-		walk->action = ACTION_AGAIN;
+	if (!pte)
 		return 0;
-	}
 	if (!pte_present(ptep_get(pte)))
 		goto out;
 	damon_ptep_mkold(pte, walk->vma, addr);
@@ -481,10 +479,8 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte) {
-		walk->action = ACTION_AGAIN;
+	if (!pte)
 		return 0;
-	}
 	ptent = ptep_get(pte);
 	if (!pte_present(ptent))
 		goto out;

base-commit: 3169a901e935bc1f2d2eec0171abcf524b7747e4
-- 
2.39.5

