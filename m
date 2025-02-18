Return-Path: <stable+bounces-116867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208D3A3A950
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAAE165603
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62E1DDA17;
	Tue, 18 Feb 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tL5RoO+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC71FECB0;
	Tue, 18 Feb 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910413; cv=none; b=MJ/oN1cg9hEnoaWrRaKkXpYPRlX0tXWsCan9+kEpYrxH+PCKJ8/0T+8oZEDiE607ho2ZF0WerObo8X5eQwKQ0wAxzsYKbrCpKjpCLQu4ErUmG3bwgi46PAJtnoCWkEV0yVFoWpiG+dZ6MIBeoHJsaLBTKwil52Hh2xa9lsUx2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910413; c=relaxed/simple;
	bh=JoHbUI3wYylTBCDntg/Qj04muZmjtBnwcE77Tw7bE7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrjOUTidNqTIQLxtbPvfa6mBGZMPHtVjn0DcTZhvUX+0lxw4AdEnh4PH1E4aYK/gpe6PBWq721Pp10QMDzvUJtL8l8nelDDxq9TlJsV320dGce2QJTZ/ZptjIzFBgcDErOZD2oy/RS8+8qnDHBvQw3p3b8LMWIGsvcWAKD4CV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tL5RoO+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2945C4CEEA;
	Tue, 18 Feb 2025 20:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910411;
	bh=JoHbUI3wYylTBCDntg/Qj04muZmjtBnwcE77Tw7bE7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tL5RoO+JYpqfRnBUJ3Ngm37tdiE3nFm1E/6I3K2H+ZkGqqIIGkPCl3gw/pj1Sgpk0
	 xqu7RxPCYHsRJE2BKddLoRTSwYUe6hiR7NIYqIDOjS2YwBdteUJcYxnSc6bokfOwBF
	 1FHW01724bGq8lu9ritp9ygefD/Bto40cLqzLM/vgCEs5yYMsZKnwT4Sk/KRNu74Vt
	 2vaUsR+8SKvLh0yZycwOViTNI5WHJBN1x6TMr5mZmNccPExoy1nwMrne95nEMPnhh4
	 KNqtodgDU1mVbo7PHfqaxXumPxWHkgKTZrg2mNF+dzyS99UuFuUDoLWDmCeFbQkGdn
	 65QPweQ6iO1BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.12 14/31] sched: Clarify wake_up_q()'s write to task->wake_q.next
Date: Tue, 18 Feb 2025 15:26:00 -0500
Message-Id: <20250218202619.3592630-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
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
index 5d67f41d05d40..c684d6044b1f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1058,9 +1058,10 @@ void wake_up_q(struct wake_q_head *head)
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


