Return-Path: <stable+bounces-116917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE41DA3A9FB
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA143A3DD5
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148D1DF72E;
	Tue, 18 Feb 2025 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqEEFCD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAE27FE80;
	Tue, 18 Feb 2025 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910536; cv=none; b=RnQurTEBrnZDsCkFI5u8jabhAqhFxYhn3pmCB1yLaAWNFUlT1lxaSuauy+OMDlYfZ8lFWPM1yu+d8VyXTQskvhKfnFxVuooOgrQzSH8iL0aDMENoUZ/gtX1Tab6U/YFEgo/HVormeekEJCOeycUqYIJix8GF7nkiIh1OvrI5ULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910536; c=relaxed/simple;
	bh=a87rZdPEARenF3+fqrfFtBkmAqq/vfWtNdwo4OzzrAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAIrhJ5NtHA6h7hmFuPgc7iAmRZMbPl+P637vnSa49T2NiKxSkohAd4rwbBVn+QN2MZK45a1qQ8JGzoVJ+admgyjP2VAOUD24LiD2oof3E4gjvVDDpxF7CO1GmFH/t9aZ6wAPPcKBzjK3Mcbsll8/qUVuUc61xbY4SUB19+gWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqEEFCD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090C8C4CEE4;
	Tue, 18 Feb 2025 20:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910535;
	bh=a87rZdPEARenF3+fqrfFtBkmAqq/vfWtNdwo4OzzrAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqEEFCD56OKIZ+kKbimQG/TcHO47Tv/48eg5yYMHgMh1IeBUr9l5jd8XTs3miKMSA
	 ioYS3Y5zsDTaIA2CnRvuvRJJp1j4JpgPC8ZNpu2En2BhZImo/O0CFQ4/7rBkXylZ/J
	 dj4qf9jkMWo1YSj9vQz7Ay0XBszvQZz2z6lbMNULcJRmreVFTx9S4dNRlY0uqupRNT
	 kpUCfQ9HFi63AGUtRzlho8k+qs+9cWoFa8Z9HwT3PtmlptkVuG6ijtkO/NpbqMvOcu
	 PSzafrkBpa/UPE9gmhQkxdpqHQ5t4VAqjY0MOfqURz5vliXKo+LitLSj5uMsBqdTCh
	 iuttpS/ClyxzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 5.15 3/6] sched: Clarify wake_up_q()'s write to task->wake_q.next
Date: Tue, 18 Feb 2025 15:28:44 -0500
Message-Id: <20250218202848.3593863-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202848.3593863-1-sashal@kernel.org>
References: <20250218202848.3593863-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index ed92b75f7e024..fcdf8aaaa37cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -939,9 +939,10 @@ void wake_up_q(struct wake_q_head *head)
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


