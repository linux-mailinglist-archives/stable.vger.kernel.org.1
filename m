Return-Path: <stable+bounces-141216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF4AAB174
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8061BC2405
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168124035E6;
	Tue,  6 May 2025 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKCXehr9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4922D9033;
	Mon,  5 May 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485507; cv=none; b=V+SO126Cir0on1FmP20aH6vuvXtdLbWeXFFS/5aXL/z3mB5kki3l3JRXAskBXpO8HGK4gmbCt9+23Gcu9Fx/cpBIvWFoqc0Qz204vBvU3aRazRSpnPAvn6rPViq5jfCAo04O1dcTYVYgKYJYyVVVhGD/e84JvQzEpc73RL+a36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485507; c=relaxed/simple;
	bh=hShYuml63OkOA2pzS1iBOosLFm/RL26Rsn3KpQO4mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpiE0e2tVP/OGZMGbl8b/CklrIxWU5xkSgEnuf3NzCaIfDH4HGAWHqfJek45o+qteF72lLOZStySinvrarXgioSIpAmUXiL4a1pbaP916o5iN0lynBnLkUTIEe+2fHPjasUtrTicYOML1+5czAw9P5CKQBiyG03/nnDtm4Pmi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKCXehr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE0DC4CEED;
	Mon,  5 May 2025 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485507;
	bh=hShYuml63OkOA2pzS1iBOosLFm/RL26Rsn3KpQO4mG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKCXehr9524mKSGMjtIr+jLPm6KPdr34fwgK3LqinyP7ZvACKhrDnnVt/ZfB1x/vW
	 zLSuyWq6KHC6UHRe3T8jkmbj9ec1bI01M77UKjKSs+l0JJeWIIuBEmcV4CwmOeONDE
	 KF5QMhPV9Uwi20xMAroT2K2DlSVu1/JH/619hM/yIhtvdHl+nYo71NGcA/J2dmmOmZ
	 gNKvkhe0qcuKvQAOYZrAzEJW+BJGdNi+/YBQySJvimyiv7mIrb4up+N0SpB3deuUPt
	 lSEO8CaPKbH4zG6CeiJexAx3/OC4cXALhD2qV92yWsZia/p5UOlY0E5Ar67qhZ8UND
	 +nuDbV6PxVM3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: zihan zhou <15645113830zzh@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com
Subject: [PATCH AUTOSEL 6.12 351/486] sched: Reduce the default slice to avoid tasks getting an extra tick
Date: Mon,  5 May 2025 18:37:07 -0400
Message-Id: <20250505223922.2682012-351-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: zihan zhou <15645113830zzh@gmail.com>

[ Upstream commit 2ae891b826958b60919ea21c727f77bcd6ffcc2c ]

The old default value for slice is 0.75 msec * (1 + ilog(ncpus)) which
means that we have a default slice of:

  0.75 for 1 cpu
  1.50 up to 3 cpus
  2.25 up to 7 cpus
  3.00 for 8 cpus and above.

For HZ=250 and HZ=100, because of the tick accuracy, the runtime of
tasks is far higher than their slice.

For HZ=1000 with 8 cpus or more, the accuracy of tick is already
satisfactory, but there is still an issue that tasks will get an extra
tick because the tick often arrives a little faster than expected. In
this case, the task can only wait until the next tick to consider that it
has reached its deadline, and will run 1ms longer.

vruntime + sysctl_sched_base_slice =     deadline
        |-----------|-----------|-----------|-----------|
             1ms          1ms         1ms         1ms
                   ^           ^           ^           ^
                 tick1       tick2       tick3       tick4(nearly 4ms)

There are two reasons for tick error: clockevent precision and the
CONFIG_IRQ_TIME_ACCOUNTING/CONFIG_PARAVIRT_TIME_ACCOUNTING. with
CONFIG_IRQ_TIME_ACCOUNTING every tick will be less than 1ms, but even
without it, because of clockevent precision, tick still often less than
1ms.

In order to make scheduling more precise, we changed 0.75 to 0.70,
Using 0.70 instead of 0.75 should not change much for other configs
and would fix this issue:

  0.70 for 1 cpu
  1.40 up to 3 cpus
  2.10 up to 7 cpus
  2.8 for 8 cpus and above.

This does not guarantee that tasks can run the slice time accurately
every time, but occasionally running an extra tick has little impact.

Signed-off-by: zihan zhou <15645113830zzh@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20250208075322.13139-1-15645113830zzh@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ceb023629d48d..7a2c94e8f0b2c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -71,10 +71,10 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 /*
  * Minimal preemption granularity for CPU-bound tasks:
  *
- * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
+ * (default: 0.70 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_base_slice			= 750000ULL;
-static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
+unsigned int sysctl_sched_base_slice			= 700000ULL;
+static unsigned int normalized_sysctl_sched_base_slice	= 700000ULL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
-- 
2.39.5


