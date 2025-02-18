Return-Path: <stable+bounces-116893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7B5A3A97D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2227A3B61
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D721773D;
	Tue, 18 Feb 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0CNZ6Sf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF2217715;
	Tue, 18 Feb 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910483; cv=none; b=DSQUdZ59BZ0RJk67SXfn6q2F5FDxYJDO3qUTISeOBULkoecej+HGBvtZtB6SX+2x807ENPTmRPzZjJayCgPlRjFtfuWD6cpKVfcJgsmG5wlNsg5N0KIjqn1XyO5O5l8Xy926uvcboAQi4NiOIUlm7C4lAEtFYTs41o11H14KGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910483; c=relaxed/simple;
	bh=siZtmyeohjy0M7dh3zAFN17XoLrbmqH/HvLVr/ye33U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxDqwF5QEjg6n/ddSN7U93wLKWJ2XxU8A6caJLCK9myWB3MF6fr7+oidbu1ilmEuo0GtM6z1UhFahjmIBvRuwCx7Fc96zNNP70HGAyTYonLAGrLaH4NajQWIud+RFqbix85LJzyiXMjB/6kbH219MnqavtWXWXyJt199KeIW1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0CNZ6Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5981BC4CEE9;
	Tue, 18 Feb 2025 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910483;
	bh=siZtmyeohjy0M7dh3zAFN17XoLrbmqH/HvLVr/ye33U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0CNZ6SfG8jnSY0wtFUFM8xLS2L48s8/hgSCZkfArQZU4n1Cq/l+yWc68u2o7J2oF
	 Brypw+K9X+nzn/ha/PxHr9VfKFlE50CUwVOANY1JqNZ3INTjhaw3hVT+MO1OtQZ4O2
	 2tHR6CmgvB6QhZzpUlbnPbyi3/hQWo5rZDfC0A/kkce9htwLXcQ7LI/FjSpzJSdpex
	 LkHlYZveqP69CNJteZYJBvgliynBpoVF0MMzk4PIdzmiieigYCUDL8g7MBNWcxcEG0
	 F48XS5j30uu86D/w2hJEk/cB3kSEDqoLBjJku9dF0xiQ7OfPxMvS0XPg68eQtIBPvf
	 J5wCm6tJDtnpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.6 09/17] sched: Clarify wake_up_q()'s write to task->wake_q.next
Date: Tue, 18 Feb 2025 15:27:33 -0500
Message-Id: <20250218202743.3593296-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202743.3593296-1-sashal@kernel.org>
References: <20250218202743.3593296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.78
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit bcc6244e13b4d4903511a1ea84368abf925031c0 ]

Clarify that wake_up_q() does an atomic write to task->wake_q.next, after
which a concurrent __wake_q_add() can immediately overwrite
task->wake_q.next again.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250129-sched-wakeup-prettier-v1-1-2f51f5f663fa@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c686d826a91cf..e29746cd11afe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1019,9 +1019,10 @@ void wake_up_q(struct wake_q_head *head)
 		struct task_struct *task;
 
 		task = container_of(node, struct task_struct, wake_q);
-		/* Task can safely be re-inserted now: */
 		node = node->next;
-		task->wake_q.next = NULL;
+		/* pairs with cmpxchg_relaxed() in __wake_q_add() */
+		WRITE_ONCE(task->wake_q.next, NULL);
+		/* Task can safely be re-inserted now. */
 
 		/*
 		 * wake_up_process() executes a full barrier, which pairs with
-- 
2.39.5


