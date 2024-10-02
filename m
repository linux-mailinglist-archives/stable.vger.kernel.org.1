Return-Path: <stable+bounces-79709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C3B98D9D2
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A222891C9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C5419409E;
	Wed,  2 Oct 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PrkyyfxG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E741CFEC0;
	Wed,  2 Oct 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878245; cv=none; b=ZrlhjKckdjePmgygZ7jFaJk8CZTUhnvx0vSwTyyfKaZbRgCheiTZks3bU1Zm5cIMNJW24PjGA15av3Wy/6UcPnwVFmbJjUhtSGS3TdI35UVPY8XNqbtctL3GBZGjLvQ6hToMRQ95JozG9ruBYZVtq2zed2IXc+xjnLRE0hLrv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878245; c=relaxed/simple;
	bh=Lol2Jsm44RFA+G6Sxu6LY7Llay5OnMn4d+OmNZ6SDGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsYEr/yMDELSlC0/CKX+BWKEqklCX/e7fhvD98aDCseb2lm3s1vwmfyLEyUxlipnShikUcCZQeh/MBojtDamcJm444cnp7jv32XUpzDiprJb9J4LlmlZg65xc/gDVBAPT/N9pS85w9me3lVNa2J8s89qb9ymmHUWZt2j9nXhsB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PrkyyfxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4565AC4CEC2;
	Wed,  2 Oct 2024 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878244;
	bh=Lol2Jsm44RFA+G6Sxu6LY7Llay5OnMn4d+OmNZ6SDGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PrkyyfxGhTS6i883kOLvxRHxVOcP6HOvQhokbZ5akYrhxrGRBsEWmERLDhrBvLIs+
	 uJ8GEdpbQw2v0B/S+AAi4zF/r+rQvJY4ago+p5CjxUqn3iz7WsJ10VOqv8FNBsUlRh
	 OT5106xL1+6obtEF+HJBqrNReI47HCM5rUzYIN/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 348/634] RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency
Date: Wed,  2 Oct 2024 14:57:28 +0200
Message-ID: <20241002125824.835707227@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit 86dfdd8288907f03c18b7fb462e0e232c4f98d89 ]

In the commit aee2424246f9 ("RDMA/iwcm: Fix a use-after-free related to
destroying CM IDs"), the function flush_workqueue is invoked to flush the
work queue iwcm_wq.

But at that time, the work queue iwcm_wq was created via the function
alloc_ordered_workqueue without the flag WQ_MEM_RECLAIM.

Because the current process is trying to flush the whole iwcm_wq, if
iwcm_wq doesn't have the flag WQ_MEM_RECLAIM, verify that the current
process is not reclaiming memory or running on a workqueue which doesn't
have the flag WQ_MEM_RECLAIM as that can break forward-progress guarantee
leading to a deadlock.

The call trace is as below:

[  125.350876][ T1430] Call Trace:
[  125.356281][ T1430]  <TASK>
[ 125.361285][ T1430] ? __warn (kernel/panic.c:693)
[ 125.367640][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9))
[ 125.375689][ T1430] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[ 125.382505][ T1430] ? handle_bug (arch/x86/kernel/traps.c:239)
[ 125.388987][ T1430] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
[ 125.395831][ T1430] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
[ 125.403125][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9))
[ 125.410984][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9))
[ 125.418764][ T1430] __flush_workqueue (kernel/workqueue.c:3970)
[ 125.426021][ T1430] ? __pfx___might_resched (kernel/sched/core.c:10151)
[ 125.433431][ T1430] ? destroy_cm_id (drivers/infiniband/core/iwcm.c:375) iw_cm
[ 125.441209][ T1430] ? __pfx___flush_workqueue (kernel/workqueue.c:3910)
[ 125.473900][ T1430] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[ 125.473909][ T1430] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161)
[ 125.482537][ T1430] _destroy_id (drivers/infiniband/core/cma.c:2044) rdma_cm
[ 125.495072][ T1430] nvme_rdma_free_queue (drivers/nvme/host/rdma.c:656 drivers/nvme/host/rdma.c:650) nvme_rdma
[ 125.505827][ T1430] nvme_rdma_reset_ctrl_work (drivers/nvme/host/rdma.c:2180) nvme_rdma
[ 125.505831][ T1430] process_one_work (kernel/workqueue.c:3231)
[ 125.515122][ T1430] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3393)
[ 125.515127][ T1430] ? __pfx_worker_thread (kernel/workqueue.c:3339)
[ 125.531837][ T1430] kthread (kernel/kthread.c:389)
[ 125.539864][ T1430] ? __pfx_kthread (kernel/kthread.c:342)
[ 125.550628][ T1430] ret_from_fork (arch/x86/kernel/process.c:147)
[ 125.558840][ T1430] ? __pfx_kthread (kernel/kthread.c:342)
[ 125.558844][ T1430] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
[  125.566487][ T1430]  </TASK>
[  125.566488][ T1430] ---[ end trace 0000000000000000 ]---

Fixes: aee2424246f9 ("RDMA/iwcm: Fix a use-after-free related to destroying CM IDs")
Link: https://patch.msgid.link/r/20240820113336.19860-1-yanjun.zhu@linux.dev
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408151633.fc01893c-oliver.sang@intel.com
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/iwcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index bf3265e678651..7d85fe4100424 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1190,7 +1190,7 @@ static int __init iw_cm_init(void)
 	if (ret)
 		return ret;
 
-	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
+	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", WQ_MEM_RECLAIM);
 	if (!iwcm_wq)
 		goto err_alloc;
 
-- 
2.43.0




