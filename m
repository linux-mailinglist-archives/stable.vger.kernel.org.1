Return-Path: <stable+bounces-147549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6EAC5825
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712A11BC1BF6
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E025A627;
	Tue, 27 May 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7qivKEJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4342A9B;
	Tue, 27 May 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367685; cv=none; b=jEft9/Rpm9V48B1bMtuuLzUBc8NmXX+Hwoxxb5XCif0kR9paWhzDARj2rTy3UioWN4qhAOuLyah/ec0k74ZaWXaQqwsSEIutrjhbcpWcipGWMFQ6jNa2rkag/XpnBMe5cG0Z+E2pvv+32p1qu9i8BPlyLQ8lYYKPxeiwcIcHmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367685; c=relaxed/simple;
	bh=FZ8g/H+deOotERNIFNoIw/BYc3yspUK16OF5DO7sMfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6d2v8vyVc1R9tlYi6SIpVHhnWk2dSRUZS9Wq8Ys1mD3xJO7v7ELF9st6S7RoOJFQlUa5cYkWZcmGawBeMBRNc/OCdv5/JByIez/fS7aTqlifCmwXYdw+6zw8DqFJxCmOuWOR2gQ//UtJHHpoAHjPpbQ9DDWeFJqfIaVd+NrN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l7qivKEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1E3C4CEE9;
	Tue, 27 May 2025 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367685;
	bh=FZ8g/H+deOotERNIFNoIw/BYc3yspUK16OF5DO7sMfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7qivKEJvZerxBe+lNEFUraXnrfSeaK8MluSXMRzoOA1HYSHN4T95lKIabwsbRv3W
	 oXMHCGXm77JIFRtnYayV+2KV64csSd286bN6uu0nYL1F4vcmpobKtYNnv+9PrY0yJ3
	 q8P90eY4JOl1hLlbBKksvPWlDj3wkMztW4OqG06k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	zihan zhou <15645113830zzh@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 466/783] sched: Reduce the default slice to avoid tasks getting an extra tick
Date: Tue, 27 May 2025 18:24:23 +0200
Message-ID: <20250527162532.114422536@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 3d9b68a347b76..eb11650160f7e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -74,10 +74,10 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
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




