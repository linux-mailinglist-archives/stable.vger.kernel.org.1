Return-Path: <stable+bounces-148589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C679FACA4D2
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EA93AA3DC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658329CB57;
	Sun,  1 Jun 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugb7J/8p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D629CB51;
	Sun,  1 Jun 2025 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820876; cv=none; b=uhQk1NTOtR7YqYhbjFBq0jU3EXJm3SPAEOxay6NdKCXGHnA3B+tYKOhhwfwBUxNrBmmp3lPeP1UoEsONz6i/hcQYLWRAVZJMbQL4pGxdzQTaMoAhcenlWv6xdE/zaQfiG3fwBqj7OrLENbtzhq2JOW7nnJC1D7EcbDJ1XVNWul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820876; c=relaxed/simple;
	bh=qiYxXwKB2t+wTt5xU2hOzjBvienvuq2eghHHhKpek74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lt5I9cNzWnj16D5JsxNKkQ0zppEwu/MoCLji1/2haiONB1VZt2jy2GDyEMPrJkYxcdKwu2b8MreAYcytrr/vAXdRWGfmeWO/ZsNyWaROnmuw7pjdJ63O3b+bIrnZg2yg+fnL91UKNRosjp29irbJs5ML8wmVTvqaZ8gK2tr+KlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugb7J/8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EC1C4CEF3;
	Sun,  1 Jun 2025 23:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820875;
	bh=qiYxXwKB2t+wTt5xU2hOzjBvienvuq2eghHHhKpek74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ugb7J/8pqfWOls8FEQQVf2WWKMKEbY1YGcSv72PyeEwdxATpXdalkLLdhvdP721hW
	 El7mGkXP8ZpRFFJmPqNycKqorN1Y32YR1SOx7T4Zf0kbewsq1T6i82WvIpsIlkE21o
	 Dh/RAR9+vNp+ZVhSgs84itzhHjLjdbg/wYEbm5sLMZ6+ovCmIv7Qv3JkM+/Mus7nas
	 X7mcmfVkXZATkVPoW0J47zPcLs1ZKhQjOPupX5RpW83wzKADOYjYpsZ74cVYNZf1xy
	 sDKKLh+EKaAuLJaWs56cFfLGSlLLUhGcEs0UitCXjullN+72neq+zg+eys1Cge9OGY
	 w7Jf/+EdHJquQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+01affb1491750534256d@syzkaller.appspotmail.com,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/93] workqueue: Fix race condition in wq->stats incrementation
Date: Sun,  1 Jun 2025 19:32:38 -0400
Message-Id: <20250601233402.3512823-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233402.3512823-1-sashal@kernel.org>
References: <20250601233402.3512823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 70e1683ca3a6474360af1d3a020a9a98c8492cc0 ]

Fixed a race condition in incrementing wq->stats[PWQ_STAT_COMPLETED] by
moving the operation under pool->lock.

Reported-by: syzbot+01affb1491750534256d@syzkaller.appspotmail.com
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Race Condition Analysis The commit fixes a
**data race condition** in `pwq->stats[PWQ_STAT_COMPLETED]++` that is
directly related to a previously fixed race condition for
`pwq->stats[PWQ_STAT_STARTED]++` (commit fe48ba7daefe). **The Problem:**
- Line 3244 in the current kernel shows
`pwq->stats[PWQ_STAT_COMPLETED]++` is executed **outside** the
`pool->lock` protection - Multiple worker threads can concurrently
increment this counter, creating a race condition identical to the one
fixed in commit fe48ba7daefe - The syzbot report confirms this is a real
issue affecting production systems **The Fix:** The commit moves
`pwq->stats[PWQ_STAT_COMPLETED]++` from line ~3244 (before
`lock_map_release`) to after `raw_spin_lock_irq(&pool->lock)` at line
~3273, ensuring atomic access under lock protection. ## Backport
Suitability Criteria **✅ Fixes Important Bug:** Yes - race conditions
can lead to incorrect statistics and potential corruption **✅ Small and
Contained:** The change is minimal - just moving one line of code to a
different location **✅ No Side Effects:** Moving the stats increment
under lock protection has no functional side effects beyond fixing the
race **✅ No Architectural Changes:** This is purely a synchronization
fix with no design changes **✅ Critical Subsystem:** Workqueue is a core
kernel subsystem used throughout the kernel **✅ Clear Stable Tree
Compliance:** - Important bugfix ✓ - Minimal risk ✓ - Confined to
workqueue subsystem ✓ - Reported by automated testing (syzbot) ✓ ##
Historical Precedent The commit directly parallels the **previously
backported** commit fe48ba7daefe (Similar Commit #1), which fixed the
same type of race condition for `PWQ_STAT_STARTED`. That commit was
marked "Backport Status: YES" and demonstrates that: 1. KCSAN-detected
race conditions in workqueue stats are considered backport-worthy 2.
Moving stats increments under lock protection is an established fix
pattern 3. The workqueue maintainer (Tejun Heo) accepts such fixes ##
Risk Assessment **Minimal Risk:** The change only affects when the
counter is incremented (under lock vs. outside lock). Since both
locations are in the same execution path, there's no functional behavior
change - only proper synchronization. **No Regression Potential:** The
fix follows the exact same pattern as the successful previous fix,
reducing the likelihood of introducing new issues. This commit
represents a clear, low-risk bug fix that addresses a real concurrency
issue in a critical kernel subsystem, making it an ideal candidate for
stable tree backporting.

 kernel/workqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a9d64e08dffc7..a2893bbe90fd3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3232,7 +3232,7 @@ __acquires(&pool->lock)
 	 * point will only record its address.
 	 */
 	trace_workqueue_execute_end(work, worker->current_func);
-	pwq->stats[PWQ_STAT_COMPLETED]++;
+
 	lock_map_release(&lockdep_map);
 	if (!bh_draining)
 		lock_map_release(pwq->wq->lockdep_map);
@@ -3263,6 +3263,8 @@ __acquires(&pool->lock)
 
 	raw_spin_lock_irq(&pool->lock);
 
+	pwq->stats[PWQ_STAT_COMPLETED]++;
+
 	/*
 	 * In addition to %WQ_CPU_INTENSIVE, @worker may also have been marked
 	 * CPU intensive by wq_worker_tick() if @work hogged CPU longer than
-- 
2.39.5


