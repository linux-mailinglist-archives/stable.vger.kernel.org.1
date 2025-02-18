Return-Path: <stable+bounces-116836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88462A3A8E7
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B2189601A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B31DE8AD;
	Tue, 18 Feb 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DovbPsJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EC1DE8A7;
	Tue, 18 Feb 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910326; cv=none; b=HSyEeZfqLpG40inxw25zkhmO/Zu9oEDqD5Qpbks4XPmAIhRKMZBM/U8EsdJgXyA4oZEkropq3Vij53V+K3w5cWTnLdIebfLgYG5IxZ72EyFsDQrsN9STZtRGOHXoThyXUQcz5dhKG95ROM1CFnPm3BdZ/RZLAWV1MLUAp76QlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910326; c=relaxed/simple;
	bh=al7klatzUyw/rz/5PxycUjlHHgZB2p51sQV6StaucwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnbMNayRMTNWZ8/mJJGgvrNhQRBf1hiinzL6bVSLYCAKQo5NwmC0Fmh9GibDjVysbm9TvUsH6f4PtpV5UR3EG3eU/lMAoL9XEVIujL7TVmcUsGanSxr60VzXrzD2GTNBH8tyhItOTseMpjLzEogNmFIE6e+5d6RhT5ai4hajEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DovbPsJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629F3C4CEEC;
	Tue, 18 Feb 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910326;
	bh=al7klatzUyw/rz/5PxycUjlHHgZB2p51sQV6StaucwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DovbPsJzeJaw3aytBAGA12cfsxg2Wqxv2w+Vr3bO/V0xN1Oqdqv8NbLXUMWimEWSQ
	 nVEX/JQJJZJuZJftDk7a86hbGWLo2qlXLtMeVw7FDBd8iRBhUttBBRT1DSp5eB1jfx
	 /tkSwd2GFJMZZhMaZvbJU7Ge7s44Zy42dNUmBQOKMRqwMqvmKRNAbDBkL9gQf38kuL
	 NSbyemLzt7ShnHWZKWADHeqYBhzbWut0gJFimeuMLnzWXhVgZXVwsw5lKPmATFn0LL
	 YL48zk3rzZuPrAd+XDtIiW7UnkSWtmPPT/dQSh3XNH5PvaFOcTQutk0r7n+DDq1iva
	 dbNDsVlIfnWmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.13 14/31] sched: Clarify wake_up_q()'s write to task->wake_q.next
Date: Tue, 18 Feb 2025 15:24:34 -0500
Message-Id: <20250218202455.3592096-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
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
index ffceb5ff4c5c3..452203b205d96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1057,9 +1057,10 @@ void wake_up_q(struct wake_q_head *head)
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


