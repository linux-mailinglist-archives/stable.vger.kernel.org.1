Return-Path: <stable+bounces-123310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906AFA5C4D6
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9397F3B7897
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862A925E81A;
	Tue, 11 Mar 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ym5gyqXZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B225DAFF;
	Tue, 11 Mar 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705582; cv=none; b=RsJgAyb4PC+uJiWCGpaoUhPilWhETdrUOPlz780Z0uMQ+pBc/L61vxhCVPVymqg1fAvjkOMhz1RStzl9DVc0KkSX1BrnNRjrZWDxmfrnBXzjEY1LGpJIVN216/aX/kyQraZ/RFy4UYva+NPZ5LnVOAikq6dqYICXjvXklFQBX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705582; c=relaxed/simple;
	bh=Ac+z4whFiZnsmJOw7pIBMoG9ilzM2Qz1fDG729L4Wmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf6aMtTHAib3U9eJa2kPfOffO/MaBmO4NZEtYSVNx+jr9PQoRppqK6pXPwUflc5S58R/gfGvMl/p3AUIONCZQKG8W2oU1NDJJg/UbTy4Di8yH+l5dgDYi5YTAOEBwKlHAT9usyELlYnqgpGOvBHuspsredaliu+GqpTbTv/q9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ym5gyqXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB9DC4CEF1;
	Tue, 11 Mar 2025 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705582;
	bh=Ac+z4whFiZnsmJOw7pIBMoG9ilzM2Qz1fDG729L4Wmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ym5gyqXZCh4jsdvakzOpTpLhfSyGNnMFb8sVtcxoBYcCk1pcCpYgnEA0eZdQDcuu2
	 yqEf/Pd75Uilb+YbKYEwtoMmd5xX3Jh9ztsuIlkDFQdxdCQhlqyIt6bL92gAW2r2ML
	 1RwkjhzMKfKKlaYrTVK0oZQKU3ZDJ041NNhOv8eQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suleiman Souhlal <suleiman@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 085/328] sched: Dont try to catch up excess steal time.
Date: Tue, 11 Mar 2025 15:57:35 +0100
Message-ID: <20250311145718.265810913@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 51ac62637e4ed..39ce8a3d8c573 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -176,13 +176,15 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
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




