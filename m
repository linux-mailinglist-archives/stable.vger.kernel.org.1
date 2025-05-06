Return-Path: <stable+bounces-139818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D00AAA03A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663CB1A82F87
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AA28EA62;
	Mon,  5 May 2025 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWobm5Or"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058D28EA52;
	Mon,  5 May 2025 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483410; cv=none; b=MoVy+8+JKqPxWuHF34fE3C8AeU3N2OIVtLQ1afzLtAms2RntIjSU5uDkPBxLMZQUj+cjuDVBPRNSeEnEAKRa6k599EQI4Xy2uneacY2C3aoTIGa/kje/95Qh0/qaSCFtB85od9TiZHlwl8NcpTLObNK3hPpj5AuthxPal6eMMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483410; c=relaxed/simple;
	bh=Pf0UDKi0u/W85Vxs0pnhVYiOyMeMAr4YGS6GScDUHRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRZuenUM5ilBAMeRWz+GwTPRid+MEuVNVfIT7mNGm0A5INOzXbjjridqgobjS6Xlwmh5TeybkppZK5KE7BIWDPpjhQdyodGMceqefjrpWq1KQf41vPqwvHenYP7EEsbQLP3F/focehfGUteyae4pHCSs/b4QXwvlQCD3XeyHd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWobm5Or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55397C4CEED;
	Mon,  5 May 2025 22:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483409;
	bh=Pf0UDKi0u/W85Vxs0pnhVYiOyMeMAr4YGS6GScDUHRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWobm5OrdMndW4R4LzPCXeueasPU5uDx/cEB34enGeHjIdayC3eryle1Lmn9Qwtnh
	 VhIZhEMjFDiOgqs+wGzy/P9degG3V2jp/xiEvwij2kek370VkjvGGuqLsgnXUkldiX
	 skm6nb5yRMMzpdSNjHuy6WoAMyx/UMYXavgIde0D5El0+bXPdunHbRIdrIyH/ogDBG
	 ujZLQmh3hrxibqZsT7JE2sVkDRObor/E2TqRpf+HaaJ9qOedwKdMdmeREwVb9ypOZG
	 R7QkRGNulaoePjD+DrLb5ZiBGkTjA2aGrKWi93Qtj5WBeCZ2i6TLx2RT5WgqQFYtwh
	 TvpwdiNzGxrpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 071/642] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Date: Mon,  5 May 2025 18:04:47 -0400
Message-Id: <20250505221419.2672473-71-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0efc297a3c4974dbd609ee36fc6345720b6ca735 ]

cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
iterating all possible cpus. It only drops the lock if there is
scheduler or spin lock contention. If neither, then interrupts can be
disabled for a long time. On large machines this can disable interrupts
for a long enough time to drop network packets. On 400+ CPU machines
I've seen interrupt disabled for over 40 msec.

Prevent rstat from disabling interrupts while processing all possible
cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
approach was previously discussed in
https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
though this was in the context of an non-irq rstat spin lock.

Benchmark this change with:
1) a single stat_reader process with 400 threads, each reading a test
   memcg's memory.stat repeatedly for 10 seconds.
2) 400 memory hog processes running in the test memcg and repeatedly
   charging memory until oom killed. Then they repeat charging and oom
   killing.

v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
interrupts are disabled by rstat for 45341 usec:
  #  => started at: _raw_spin_lock_irq
  #  => ended at:   cgroup_rstat_flush
  #
  #
  #                    _------=> CPU#
  #                   / _-----=> irqs-off/BH-disabled
  #                  | / _----=> need-resched
  #                  || / _---=> hardirq/softirq
  #                  ||| / _--=> preempt-depth
  #                  |||| / _-=> migrate-disable
  #                  ||||| /     delay
  #  cmd     pid     |||||| time  |   caller
  #     \   /        ||||||  \    |    /
  stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
  stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
  stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_flush
  stat_rea-96532    52d.... 45343us : <stack trace>
   => memcg1_stat_format
   => memory_stat_format
   => memory_stat_show
   => seq_read_iter
   => vfs_read
   => ksys_read
   => do_syscall_64
   => entry_SYSCALL_64_after_hwframe

With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
longest holder. The longest irqs-off holder has irqs disabled for
4142 usec, a huge reduction from previous 45341 usec rstat finding.

Running stat_reader memory.stat reader for 10 seconds:
- without memory hogs: 9.84M accesses => 12.7M accesses
-    with memory hogs: 9.46M accesses => 11.1M accesses
The throughput of memory.stat access improves.

The mode of memory.stat access latency after grouping by of 2 buckets:
- without memory hogs: 64 usec => 16 usec
-    with memory hogs: 64 usec =>  8 usec
The memory.stat latency improves.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Greg Thelen <gthelen@google.com>
Tested-by: Greg Thelen <gthelen@google.com>
Acked-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/rstat.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 3e01781aeb7bd..c4ce2f5a9745f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -323,13 +323,11 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 			rcu_read_unlock();
 		}
 
-		/* play nice and yield if necessary */
-		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-			__cgroup_rstat_unlock(cgrp, cpu);
-			if (!cond_resched())
-				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
-		}
+		/* play nice and avoid disabling interrupts for a long time */
+		__cgroup_rstat_unlock(cgrp, cpu);
+		if (!cond_resched())
+			cpu_relax();
+		__cgroup_rstat_lock(cgrp, cpu);
 	}
 }
 
-- 
2.39.5


