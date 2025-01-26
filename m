Return-Path: <stable+bounces-110495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC6A1C96B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EED31888653
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90EA1DE2A8;
	Sun, 26 Jan 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM9EeuMW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626641DDC3C;
	Sun, 26 Jan 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903059; cv=none; b=TE0Z78Dh+1Q4oh2OxvNSoUSXhEOD7PcdiUmgKRRf7sejG5vEtHP1r6fxcx7IBMLbBYt+3NH1snL5Ve77EF5I6MuR18djexPimTbHLF7fKMIXo8lzskKZvJRZ4QgnI+QcJ8DeXpQrwOHcpgOoGHt+NABIA3WJDSBrgp8pLjlHcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903059; c=relaxed/simple;
	bh=bgy6easxO5ItOol+2b01o6Rwh77tc0QSN+Cc5faLIyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C4aye5Gwm6H22VtEEJPfntq3m//sZlKOufH0C1ZaJORi/rh1gE7xt4NiWquQyHtBiomlT0s9DlDw+v3mck2WDjOFDYOiJ+Ad4FlLgESN62oPFJbLgYfMGA6fS8mKWdRDcf51T+Am+h2IfLmQoPtdd+YP17qEpMfKnDrFCZwxYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM9EeuMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5CFC4CED3;
	Sun, 26 Jan 2025 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903059;
	bh=bgy6easxO5ItOol+2b01o6Rwh77tc0QSN+Cc5faLIyA=;
	h=From:To:Cc:Subject:Date:From;
	b=bM9EeuMWXQj7ehZSD+WFwzaPBF/hNmEj23yBTymzoJWxuQpICpLmM6DVieuky7O42
	 A3MNNBf0nbMxopzo55fvcfcBND/Q4w07H4cgLJ31ewVtVtJ0gTyRxCGZMTBCIbElOu
	 jBUa5yezlN2+N1wnREb4kdzI80ALvYQqoxDPhKfTacBD0biIVXjeszSzeXqyybyh87
	 IC6mSA/ufotnz2r6U50PSXSnQ1m+E2zZBmUWSAVblXH4EZNH648ATwWpdEGW1otmGA
	 4XcOYu1BmFwq0XjxRQ/zfLBa5kPxkKOeBXgfB0fIQsUGwSmuEidCEn8ppdF6G1ev5O
	 PA9rXIAJpnjsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Suleiman Souhlal <suleiman@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 5.15 1/3] sched: Don't try to catch up excess steal time.
Date: Sun, 26 Jan 2025 09:50:54 -0500
Message-Id: <20250126145057.926069-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index ed92b75f7e024..691af58c156e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -642,13 +642,15 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
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


