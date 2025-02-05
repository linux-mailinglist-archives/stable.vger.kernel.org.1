Return-Path: <stable+bounces-112553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034EAA28D6E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350AF3AAF5B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E872152E12;
	Wed,  5 Feb 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="thzfrdMK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4A14B080;
	Wed,  5 Feb 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763956; cv=none; b=qSmQRjsrKxi4EnsiA3eiKruKA7d78zGK1N8Y/Ux0a9oTEQXNh3vYDtIdRB28dqz/aHvbgDz86rIgjoTkFEOEA+namLJj/CJkEgsu6ctvU+uf7uB3ZrcWmzG5wtXeSK1n7fpjQBCaAWNOhp/FIJOaE4G0G/E9YXgjmtkg+ZKZ/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763956; c=relaxed/simple;
	bh=1H0avIqgvjCZtA/syDIm9d7PzIVGAjaAsW/VVlTnUEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaiPEE7OX6FzM/rxIhtnri6s3TLSOEQg17LUzJ4NoUTb4KrSwqB/gG6CE/XrFgSxQRGKubHrg/qyTParGADQFy10FsBW7iDV/icY8P6US3ly30iWW4OnNfdbvdrk3uy2SPqZiDWVyxLBrsv/rr1kQzJ+qcXI0vh+cHIBqZGiEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=thzfrdMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA6BC4CED1;
	Wed,  5 Feb 2025 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763956;
	bh=1H0avIqgvjCZtA/syDIm9d7PzIVGAjaAsW/VVlTnUEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thzfrdMKSSGdDiB7GZ5S+q1ckYVQieNau+doZqZnxJ9kIZ++WeiPfo/5jk4eq+HaL
	 Oo+v9wHSQFH2hB42eHi+xTwUOu75lITdrX/i63HwRDCGj8MHwKK+qHOt3NGHrwBees
	 h3xykp0zOrK8igAQgMAYzMd3ZbciI7Ls7zDqZy44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 033/623] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
Date: Wed,  5 Feb 2025 14:36:15 +0100
Message-ID: <20250205134457.494918832@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 2a77e4be12cb58bbf774e7c717c8bb80e128b7a4 ]

There are 3 sites using set_next_buddy() and only one is conditional
on NEXT_BUDDY, the other two sites are unconditional; to note:

  - yield_to_task()
  - cgroup dequeue / pick optimization

However, having NEXT_BUDDY control both the wakeup-preemption and the
picking side of things means its near useless.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241129101541.GA33464@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c     | 4 ++--
 kernel/sched/features.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 26958431deb7a..808010430a16e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5538,9 +5538,9 @@ static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	/*
-	 * Enabling NEXT_BUDDY will affect latency but not fairness.
+	 * Picking the ->next buddy will affect latency but not fairness.
 	 */
-	if (sched_feat(NEXT_BUDDY) &&
+	if (sched_feat(PICK_BUDDY) &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
 		/* ->next will never be delayed */
 		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a3d331dd2d8ff..3c12d9f93331d 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -31,6 +31,15 @@ SCHED_FEAT(PREEMPT_SHORT, true)
  */
 SCHED_FEAT(NEXT_BUDDY, false)
 
+/*
+ * Allow completely ignoring cfs_rq->next; which can be set from various
+ * places:
+ *   - NEXT_BUDDY (wakeup preemption)
+ *   - yield_to_task()
+ *   - cgroup dequeue / pick
+ */
+SCHED_FEAT(PICK_BUDDY, true)
+
 /*
  * Consider buddies to be cache hot, decreases the likeliness of a
  * cache buddy being migrated away, increases cache locality.
-- 
2.39.5




