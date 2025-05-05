Return-Path: <stable+bounces-141420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA8AAB709
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2EF3AA8DF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79F22D7BC;
	Tue,  6 May 2025 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhq3/I/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF7287519;
	Mon,  5 May 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486229; cv=none; b=piPKCN4Vc8fNx2c3Nuwjm4NccneV2xcH6Ebu8XyY6EibIXS4Vcdkk6JFCvo9YI8WDyCJRTmKIZd/uTkY2JeLu8wwyPR7529yottBn8ZpAhqLu6boKCecoNJz6IoiChVm9LQc8FwqPrinjaDFR+rylzUJsPSCUN2U5BW7ZdpQsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486229; c=relaxed/simple;
	bh=nUhJPQAzAYCk+aYvLGOs2YSzYmxWM9N3qBgyHew88IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YrrmEywHXdKiMryo1ExNfFv31XmBiL0IVvVWF1PSpwrXrSzEt/XraYGJI4YvtoPIegTyT5k99FJHrojPBPgifjCCz3Ry1nJGFXPKCQa5Fwg3ZKwwRBh5o4mX7WIXrRFAwTxmxY/+c/FTnR1VNcOVfTFlmYK2UzZKCJutTwub9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhq3/I/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB730C4CEEF;
	Mon,  5 May 2025 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486228;
	bh=nUhJPQAzAYCk+aYvLGOs2YSzYmxWM9N3qBgyHew88IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zhq3/I/re8iL5bpdC5NXwDtrGln0zdAg6XAdFsbBho+bHoN8UzDHYLs4j6tRJaKFT
	 hzFA7+h9qdeHReIEvc1wUwIUKXy1Y968dGou89cfUOhmjjr6UVH9w3bbBSvXmNP4n7
	 /27qMzNk42OuIo5bnmzKF5O5vnKX88Fpwc4kVdYDX8SG6S1SEkFpZraJsLVqGMRFzV
	 Y0HchsU4S+ZuAlCOVBZRYbsskMjWUXMGOLZqTGkOHpmYhViyVASJ9/UChOoXUSxtK8
	 GrB+zEXs8hUv6VFRUtMNitkK9fKFgzdpx0DyphXLxFDsLRbgAPp2YYgqHxIA1OM1TD
	 pzdjXegCfV5kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: zihan zhou <15645113830zzh@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com
Subject: [PATCH AUTOSEL 6.6 218/294] sched: Reduce the default slice to avoid tasks getting an extra tick
Date: Mon,  5 May 2025 18:55:18 -0400
Message-Id: <20250505225634.2688578-218-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 268e2a49b964e..6ce3028e6e852 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -73,10 +73,10 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
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
 
 /*
  * After fork, child runs first. If set to 0 (default) then
-- 
2.39.5


