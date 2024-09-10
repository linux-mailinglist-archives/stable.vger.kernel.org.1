Return-Path: <stable+bounces-74498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC2972F96
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C851C247FF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384BC1891A0;
	Tue, 10 Sep 2024 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lJLYbwye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA712188CAD;
	Tue, 10 Sep 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961982; cv=none; b=P+f0LIx5YGfDM1Ny9i47q+aV1e1QpnBp/8HYnEQr5JYF2Xbzr43zJE4MRXvH/1ewd6VmA24y4lDOrtZXoROhpCnWNjdYv9/aMUB+z3NdQbmHiU2XJg+BjgqsEI3yAZTJJ2uRbCWBCCl1/qvIM74zGVRnSK2aY7Tjsnn1kkAfe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961982; c=relaxed/simple;
	bh=Ydcqkm5pO2pfBUhGvtjhPRCivg4wQAYUt7obMzaaCw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swc1t337oqtnIp/U5Ur7COuGln9lzTJFQPN3r2dnFAxWubi6cRS4hfaW/wgqu7Tsn+Iez6Ma80UajqkumsI3a438pYJRPaava9pXePevInV5YBbkt9jMCg8/amo8Zvuz/lZGBN54zhoZ5fdQPLhaawkzHxJX5Xf4B2XvqL7eOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lJLYbwye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7514BC4CEC3;
	Tue, 10 Sep 2024 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961981;
	bh=Ydcqkm5pO2pfBUhGvtjhPRCivg4wQAYUt7obMzaaCw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJLYbwyeRdv1pfJHhnZUBKCSGwHcKo82zWVZNkeUEFztXigHWJjvDucEGkvtR7Py7
	 kSJepWLhKhPW5/iKaYs3kRxG051+Wlx5P1IdcYPeSVHI3K782igPuNjCBqzKDo8kZX
	 et6zLoNhn4tXSvB4EwWU4/v3pnYylMZ2cd34VJ+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yicong Yang <yangyicong@hisilicon.com>,
	Barry Song <baohua@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 228/375] dma-mapping: benchmark: Dont starve others when doing the test
Date: Tue, 10 Sep 2024 11:30:25 +0200
Message-ID: <20240910092630.203834517@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit 54624acf8843375a6de3717ac18df3b5104c39c5 ]

The test thread will start N benchmark kthreads and then schedule out
until the test time finished and notify the benchmark kthreads to stop.
The benchmark kthreads will keep running until notified to stop.
There's a problem with current implementation when the benchmark
kthreads number is equal to the CPUs on a non-preemptible kernel:
since the scheduler will balance the kthreads across the CPUs and
when the test time's out the test thread won't get a chance to be
scheduled on any CPU then cannot notify the benchmark kthreads to stop.

This can be easily reproduced on a VM (simulated with 16 CPUs) with
PREEMPT_VOLUNTARY:
estuary:/mnt$ ./dma_map_benchmark -t 16 -s 1
 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:     10-...!: (5221 ticks this GP) idle=ed24/1/0x4000000000000000 softirq=142/142 fqs=0
 rcu:     (t=5254 jiffies g=-559 q=45 ncpus=16)
 rcu: rcu_sched kthread starved for 5255 jiffies! g-559 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=12
 rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
 rcu: RCU grace-period kthread stack dump:
 task:rcu_sched       state:R  running task     stack:0     pid:16    tgid:16    ppid:2      flags:0x00000008
 Call trace
  __switch_to+0xec/0x138
  __schedule+0x2f8/0x1080
  schedule+0x30/0x130
  schedule_timeout+0xa0/0x188
  rcu_gp_fqs_loop+0x128/0x528
  rcu_gp_kthread+0x1c8/0x208
  kthread+0xec/0xf8
  ret_from_fork+0x10/0x20
 Sending NMI from CPU 10 to CPUs 0:
 NMI backtrace for cpu 0
 CPU: 0 PID: 332 Comm: dma-map-benchma Not tainted 6.10.0-rc1-vanilla-LSE #8
 Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
 pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : arm_smmu_cmdq_issue_cmdlist+0x218/0x730
 lr : arm_smmu_cmdq_issue_cmdlist+0x488/0x730
 sp : ffff80008748b630
 x29: ffff80008748b630 x28: 0000000000000000 x27: ffff80008748b780
 x26: 0000000000000000 x25: 000000000000bc70 x24: 000000000001bc70
 x23: ffff0000c12af080 x22: 0000000000010000 x21: 000000000000ffff
 x20: ffff80008748b700 x19: ffff0000c12af0c0 x18: 0000000000010000
 x17: 0000000000000001 x16: 0000000000000040 x15: ffffffffffffffff
 x14: 0001ffffffffffff x13: 000000000000ffff x12: 00000000000002f1
 x11: 000000000001ffff x10: 0000000000000031 x9 : ffff800080b6b0b8
 x8 : ffff0000c2a48000 x7 : 000000000001bc71 x6 : 0001800000000000
 x5 : 00000000000002f1 x4 : 01ffffffffffffff x3 : 000000000009aaf1
 x2 : 0000000000000018 x1 : 000000000000000f x0 : ffff0000c12af18c
 Call trace:
  arm_smmu_cmdq_issue_cmdlist+0x218/0x730
  __arm_smmu_tlb_inv_range+0xe0/0x1a8
  arm_smmu_iotlb_sync+0xc0/0x128
  __iommu_dma_unmap+0x248/0x320
  iommu_dma_unmap_page+0x5c/0xe8
  dma_unmap_page_attrs+0x38/0x1d0
  map_benchmark_thread+0x118/0x2c0
  kthread+0xec/0xf8
  ret_from_fork+0x10/0x20

Solve this by adding scheduling point in the kthread loop,
so if there're other threads in the system they may have
a chance to run, especially the thread to notify the test
end. However this may degrade the test concurrency so it's
recommended to run this on an idle system.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/map_benchmark.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 4950e0b622b1..cc19a3efea89 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -89,6 +89,22 @@ static int map_benchmark_thread(void *data)
 		atomic64_add(map_sq, &map->sum_sq_map);
 		atomic64_add(unmap_sq, &map->sum_sq_unmap);
 		atomic64_inc(&map->loops);
+
+		/*
+		 * We may test for a long time so periodically check whether
+		 * we need to schedule to avoid starving the others. Otherwise
+		 * we may hangup the kernel in a non-preemptible kernel when
+		 * the test kthreads number >= CPU number, the test kthreads
+		 * will run endless on every CPU since the thread resposible
+		 * for notifying the kthread stop (in do_map_benchmark())
+		 * could not be scheduled.
+		 *
+		 * Note this may degrade the test concurrency since the test
+		 * threads may need to share the CPU time with other load
+		 * in the system. So it's recommended to run this benchmark
+		 * on an idle system.
+		 */
+		cond_resched();
 	}
 
 out:
-- 
2.43.0




