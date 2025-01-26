Return-Path: <stable+bounces-110492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6047A1C967
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4871663D7
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15421DD894;
	Sun, 26 Jan 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMmKP+1P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7221DD0E7;
	Sun, 26 Jan 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903052; cv=none; b=hdW/U3cgdnM79cXQ+6LKW1aHbTXomxU0We6/U7BKPPRz1lZVp9taZQwSPLnTZSwyuXzWkVR7VOylInV/3aPNUXWpxXRIp7d6/dHy9OjyHRfdB+uaNkzsXvzmSDLx+DDoaOUacUKe7PF/WZ+Xwnuq6suNsefm9k3H8LM5inKEyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903052; c=relaxed/simple;
	bh=w7TU5D4OTbMsYZTOKK/SX/PTVy4niL9iHmCedxY9rco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEGM6HTy3PsApRguqUGBC1nTIWKyh0sIKxnc2IYmRAycEq4nXcdbgiOrVw5Cz40C94qZF0qpJn+f8oCLDAGkyLjVRm3uGn7o7xDwZWJ0lXUyuOjWJWP51yPbz2vmvUor4ja4r6H9Z5M6NAvlH1Zhj356pe03av31Jj9x4m9AMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMmKP+1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53386C4CEE4;
	Sun, 26 Jan 2025 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903052;
	bh=w7TU5D4OTbMsYZTOKK/SX/PTVy4niL9iHmCedxY9rco=;
	h=From:To:Cc:Subject:Date:From;
	b=CMmKP+1PbDnBzTR4DNvDcMzlvQ61Tbc43tFgPWtoO2Oqo0usoJZk0KEl3iRsdIzNZ
	 CTVP8KH+mWs5edKx2Ww91g3Je3hLuus74X5PW3VLL1JcK8P/LO1JbHC598G+sh+f44
	 BkdqzfIx3jO/cLnaYxG0v8O78YP7GoWqAMgRqb7sl5fFfuXR4Ysk3cBDcfm2CSSoF9
	 5/hHY4fTBPTcSzbHjPvHgKNBTUU392a/OUAUTWG28es/3lqE90qc7xJBeNdWrLNY9M
	 sKEnQwH9lp4L2EH7SYNxiWl3/v1l8sBlmmIWPRQHDzERLnvYK2KMtBfnNSOJEW/ar5
	 qoccT18adEyxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Suleiman Souhlal <suleiman@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.1 1/3] sched: Don't try to catch up excess steal time.
Date: Sun, 26 Jan 2025 09:50:47 -0500
Message-Id: <20250126145050.926016-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
Content-Transfer-Encoding: 8bit

From: Suleiman Souhlal <suleiman@google.com>

[ Upstream commit 108ad0999085df2366dd9ef437573955cb3f5586 ]

When steal time exceeds the measured delta when updating clock_task, we
currently try to catch up the excess in future updates.
However, this results in inaccurate run times for the future things using
clock_task, in some situations, as they end up getting additional steal
time that did not actually happen.
This is because there is a window between reading the elapsed time in
update_rq_clock() and sampling the steal time in update_rq_clock_task().
If the VCPU gets preempted between those two points, any additional
steal time is accounted to the outgoing task even though the calculated
delta did not actually contain any of that "stolen" time.
When this race happens, we can end up with steal time that exceeds the
calculated delta, and the previous code would try to catch up that excess
steal time in future clock updates, which is given to the next,
incoming task, even though it did not actually have any time stolen.

This behavior is particularly bad when steal time can be very long,
which we've seen when trying to extend steal time to contain the duration
that the host was suspended [0]. When this happens, clock_task stays
frozen, during which the running task stays running for the whole
duration, since its run time doesn't increase.
However the race can happen even under normal operation.

Ideally we would read the elapsed cpu time and the steal time atomically,
to prevent this race from happening in the first place, but doing so
is non-trivial.

Since the time between those two points isn't otherwise accounted anywhere,
neither to the outgoing task nor the incoming task (because the "end of
outgoing task" and "start of incoming task" timestamps are the same),
I would argue that the right thing to do is to simply drop any excess steal
time, in order to prevent these issues.

[0] https://lore.kernel.org/kvm/20240820043543.837914-1-suleiman@google.com/

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241118043745.1857272-1-suleiman@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 54af671e8d510..3927904984fd5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -704,13 +704,15 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
-		steal = paravirt_steal_clock(cpu_of(rq));
+		u64 prev_steal;
+
+		steal = prev_steal = paravirt_steal_clock(cpu_of(rq));
 		steal -= rq->prev_steal_time_rq;
 
 		if (unlikely(steal > delta))
 			steal = delta;
 
-		rq->prev_steal_time_rq += steal;
+		rq->prev_steal_time_rq = prev_steal;
 		delta -= steal;
 	}
 #endif
-- 
2.39.5


