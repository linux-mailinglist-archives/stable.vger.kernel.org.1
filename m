Return-Path: <stable+bounces-116907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A7A3A9A5
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1357A533D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668622A815;
	Tue, 18 Feb 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a324VSi7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4022A805;
	Tue, 18 Feb 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910514; cv=none; b=V3WLUc3CXae8YFrs+D+9Cckb5egYPHd4NlGk4e+xPznKUNkOwvLxBSmgyvJRP1chkaKIhgcoV6JoSjtsQW9xplprizoWcOmS4g2KiUY94aeDa3n5PGaCFS1/t/e1v1jt/wFIJQQiqpqVZAeuVpDcgzJiHe74cP6UcxorhueTojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910514; c=relaxed/simple;
	bh=G647sp4ARJlDgB5GswPaejJMTJPmTJIkpQpdVMHafHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfB+4XczKL8m59uKQBsJloL0osw2tg83hqwcuQpX60LVKZF0V21oUJofaVLbyEeukFaKBX34RjIvyxqyPmuwgh8qtJb4FgPrtUlZ0dFt2WyzF1TLe/VscZVad6ZKbOwKz/UpnUoVAzxGDSyWkvgKxzccDttgNNPs9oId9iSVIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a324VSi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A293DC4CEE4;
	Tue, 18 Feb 2025 20:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910513;
	bh=G647sp4ARJlDgB5GswPaejJMTJPmTJIkpQpdVMHafHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a324VSi7w/cmLdPH2Dauvxtb9a2PYob8Vao1zLCgQmiPUVQWDPuo90gOUEnOC680k
	 0CnaccSKiJT8JK5fI8uLK+kdFccqzCbi78MzWTqOPaApQnx9wVayL/Z8HNciQ7GZOY
	 niqeJQVs2e62Md6LAvgLnXZer+JZZHunDgQ60V7Dpn5NAFjZTVpbFQdyhMIqoQ5Yda
	 U5xXOmG692oYH1zxEtQbfgxfbo+G/oLA1aASEjFhWprUGGxwKQ01by922+j+HCOUvU
	 tmO3MwbCoUa/cRIC3uXTRtvFu1sHKZaruSXxz9KaPw5xQifcn0MsqSofQ5MX08U3v2
	 +S0Xj3YKTmgpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.1 06/13] sched: Clarify wake_up_q()'s write to task->wake_q.next
Date: Tue, 18 Feb 2025 15:28:10 -0500
Message-Id: <20250218202819.3593598-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202819.3593598-1-sashal@kernel.org>
References: <20250218202819.3593598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
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
index 54af671e8d510..83a29609d478d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -995,9 +995,10 @@ void wake_up_q(struct wake_q_head *head)
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


