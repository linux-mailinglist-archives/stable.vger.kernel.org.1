Return-Path: <stable+bounces-170260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6BBB2A31D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DA03A8620
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E13318144;
	Mon, 18 Aug 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIGMIrMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB712DDA1;
	Mon, 18 Aug 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522059; cv=none; b=Z98BYudbLIJR9TBpuQ1A01XI1/cXS+paN1BoIXKrvDteblnML8ucfa/RcrDalt+86WHeDDJo45Pn5S8nOiLWkHC/gfTKVdKY5W639neo2eYQXIHiYjYFWIfiCRojc1Xkg41RL2KeMKYNpn6d7cqnMsaRe5j2W+b5WTW0yUl2VZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522059; c=relaxed/simple;
	bh=gGYQxuBor/9Sav/5spXqDo++qfUsDVFMZZmFqM4gEvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHP6SupCDpMDH2CcxS6rEZbadbJAkVNSLUkvAEnQm9jw1hcxRvwCUv0bsOg63UjAbo8AXmY9r3CHyj9lxEYX3W/jscQ8lv6Cmz2FHoi8eXGcPai57i/9GioAtIRGqD0qVa7NWYvwCFZhjvixObOVGGtSZcdq0nTWK2bxqffRLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIGMIrMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4E9C4CEEB;
	Mon, 18 Aug 2025 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522059;
	bh=gGYQxuBor/9Sav/5spXqDo++qfUsDVFMZZmFqM4gEvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIGMIrMnrEetGzfa1h5njtW/fR9oOSMhYmObukBgA+zXaHJ/46zn1Nk7v66Rz3uhH
	 oqmXuHskpkaIJq22zF7kMLeUIArn3Ee42nSjvLUhQx6/bCAwaMhi0Yt8y9kvKWWinV
	 4S0e3n4bbSylYWaRW9o8xa5lmRQzIHWXwelsi7Lo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Mason <clm@fb.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 202/444] sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails
Date: Mon, 18 Aug 2025 14:43:48 +0200
Message-ID: <20250818124456.434747042@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Mason <clm@fb.com>

[ Upstream commit 155213a2aed42c85361bf4f5c817f5cb68951c3b ]

schbench (https://github.com/masoncl/schbench.git) is showing a
regression from previous production kernels that bisected down to:

sched/fair: Remove sysctl_sched_migration_cost condition (c5b0a7eefc)

The schbench command line was:

schbench -L -m 4 -M auto -t 256 -n 0 -r 0 -s 0

This creates 4 message threads pinned to CPUs 0-3, and 256x4 worker
threads spread across the rest of the CPUs.  Neither the worker threads
or the message threads do any work, they just wake each other up and go
back to sleep as soon as possible.

The end result is the first 4 CPUs are pegged waking up those 1024
workers, and the rest of the CPUs are constantly banging in and out of
idle.  If I take a v6.9 Linus kernel and revert that one commit,
performance goes from 3.4M RPS to 5.4M RPS.

schedstat shows there are ~100x  more new idle balance operations, and
profiling shows the worker threads are spending ~20% of their CPU time
on new idle balance.  schedstats also shows that almost all of these new
idle balance attemps are failing to find busy groups.

The fix used here is to crank up the cost of the newidle balance whenever it
fails.  Since we don't want sd->max_newidle_lb_cost to grow out of
control, this also changes update_newidle_cost() to use
sysctl_sched_migration_cost as the upper limit on max_newidle_lb_cost.

Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20250626144017.1510594-2-clm@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7280ed04c96c..af61769b1d50 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12220,8 +12220,14 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
+		 *
+		 * sched_balance_newidle() bumps the cost whenever newidle
+		 * balance fails, and we don't want things to grow out of
+		 * control.  Use the sysctl_sched_migration_cost as the upper
+		 * limit, plus a litle extra to avoid off by ones.
 		 */
-		sd->max_newidle_lb_cost = cost;
+		sd->max_newidle_lb_cost =
+			min(cost, sysctl_sched_migration_cost + 200);
 		sd->last_decay_max_lb_cost = jiffies;
 	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
 		/*
@@ -12926,10 +12932,17 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			update_newidle_cost(sd, domain_cost);
-
 			curr_cost += domain_cost;
 			t0 = t1;
+
+			/*
+			 * Failing newidle means it is not effective;
+			 * bump the cost so we end up doing less of it.
+			 */
+			if (!pulled_task)
+				domain_cost = (3 * sd->max_newidle_lb_cost) / 2;
+
+			update_newidle_cost(sd, domain_cost);
 		}
 
 		/*
-- 
2.39.5




