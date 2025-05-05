Return-Path: <stable+bounces-140149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B9AAA579
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1483716C955
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC7313CA2;
	Mon,  5 May 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrRhodmq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151F28D820;
	Mon,  5 May 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484236; cv=none; b=ry8hsOEHovvBj6/hmjvOz4vJKnUCe0C/PggXaqmu7AYz1AM6F8ayVPhUzyVAaQk8hCSabNDl29rJgMxP4Zq9Ll1MDiaY/PxHxm6hwq3mTyNIUKvZLDSRQoSUUdEV4qG/1cfgpmh5JMAt089Jl0dQJGa1VwKVxBT5wQ4xLcHbb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484236; c=relaxed/simple;
	bh=/e1FRwRL5IpG30nWceoBMBxGLMLwLLEKNG6MLc6HJRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppcLh4hIXwAxmd3pdQ1sbB34AtUeRtQYADqOmQEx1zVfzFf68Yc1aXAgv5EFvV+1NQDNlvB1gY7TW8zOULjC1M5bM+EQ9VfnXOJUZ5GvA8JJbyIFYRXzLOQDABDGRA2T6uvkSJd2MZDxiF6QjrNBGSjECo5gE1R2irl1dN+r1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrRhodmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D49C4CEE4;
	Mon,  5 May 2025 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484235;
	bh=/e1FRwRL5IpG30nWceoBMBxGLMLwLLEKNG6MLc6HJRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrRhodmqpBjx2KKRPcXuQY56/WKw2rqPHnPo29+RdmzdkIoUGRR9gsLcuxSAPBK9m
	 X9wqmfpC336DxnnGT4XlWNIJji4lLCn5gGcbYOqkS96hdl3eF13mJBkjjguhXN2g/2
	 7CRoT9JhKNLBPKcRZLe7hyloBequOqO649/cP/28m6QNY1lI9HA5W7sqeHCiHgWUUp
	 qPSslg8E0DUBGKrutl4MYqPtBFz14xGe0OW9glMem+BQzayDUUrQoKTeWWGN4DwRtK
	 3kiPs+KkwDnXlSl139o1tcKjXldyHBGdfitiKgxWaEFnpbsR7JTHQ10J1g2vUV195L
	 4RUosRV5uOUgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Segall <bsegall@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de,
	frederic@kernel.org
Subject: [PATCH AUTOSEL 6.14 402/642] posix-timers: Invoke cond_resched() during exit_itimers()
Date: Mon,  5 May 2025 18:10:18 -0400
Message-Id: <20250505221419.2672473-402-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Benjamin Segall <bsegall@google.com>

[ Upstream commit f99c5bb396b8d1424ed229d1ffa6f596e3b9c36b ]

exit_itimers() loops through every timer in the process to delete it.  This
requires taking the system-wide hash_lock for each of these timers, and
contends with other processes trying to create or delete timers.

When a process creates hundreds of thousands of timers, and then exits
while other processes contend with it, this can trigger softlockups on
CONFIG_PREEMPT=n.

Add a cond_resched() invocation into the loop to allow the system to make
progress.

Signed-off-by: Ben Segall <bsegall@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/xm2634gg2n23.fsf@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 15ed343693101..43b08a04898a8 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1107,8 +1107,10 @@ void exit_itimers(struct task_struct *tsk)
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	/* The timers are not longer accessible via tsk::signal */
-	while (!hlist_empty(&timers))
+	while (!hlist_empty(&timers)) {
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+		cond_resched();
+	}
 
 	/*
 	 * There should be no timers on the ignored list. itimer_delete() has
-- 
2.39.5


