Return-Path: <stable+bounces-89244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA789B52AB
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 20:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA0DB2214C
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36D207203;
	Tue, 29 Oct 2024 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UGPIBqd6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA8206979;
	Tue, 29 Oct 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229847; cv=none; b=tnjzDmpDZwJi0z6mWy9ZoErxByEDfZnDj0sidfVOQZo9xkFMETDrQ2qD7J2v37+zYOTh7jrVp8R4Zl/bgDZX7TOOmlXfJb26P8md8/CtcsoGY2StF7q6pK2/2KQ+CYLhMk1PWh1gJ1B+XXxvwOqFWlFMwIKjv8uE7l8gq5PL8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229847; c=relaxed/simple;
	bh=f3cOzCpl+bEiEbPyFz5C9ypl5Aa+vG78EgHMN/Ja6pU=;
	h=Date:To:From:Subject:Message-Id; b=GNLal++uvsa0bKa86mgM+ptYfTc6CxwFXnblLe4h9KGLyRXvW+xo0xZmrM3gPYRleXW3f0TCLNBq0dDnnJUEWK550s35CIKXSCOXRcVepsvIhjxy6ipJS7m4RmYyCkwBLQxaSstFj6PnqMRAO+WUcfu7xfsVlKBzAANRcLV6bVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UGPIBqd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B0EC4CECD;
	Tue, 29 Oct 2024 19:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730229847;
	bh=f3cOzCpl+bEiEbPyFz5C9ypl5Aa+vG78EgHMN/Ja6pU=;
	h=Date:To:From:Subject:From;
	b=UGPIBqd6drDkdh5i4EopmcmAKlljUSY+TcIL0eVxzhmION5UlMWJdDQinp5kwSRCM
	 BHf53Dvv8dGhRJfEgso77HoPtWFMoehishCCSqddXLp5lgRCYOqwVqf+aLLHYrBpbU
	 opylY6wUfrwo8FpuaFU4pCG+JiS7wKSUMDgdMzFg=
Date: Tue, 29 Oct 2024 12:24:06 -0700
To: mm-commits@vger.kernel.org,vschneid@redhat.com,vincent.guittot@linaro.org,stable@vger.kernel.org,rostedt@goodmis.org,peterz@infradead.org,mingo@redhat.com,mgorman@suse.de,Liam.Howlett@oracle.com,juri.lelli@redhat.com,dietmar.eggemann@arm.com,bsegall@google.com,baolin.wang@linux.alibaba.com,shawnwang@linux.alibaba.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged] sched-numa-fix-the-potential-null-pointer-dereference-in-task_numa_work.patch removed from -mm tree
Message-Id: <20241029192407.39B0EC4CECD@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: sched/numa: fix the potential null pointer dereference in task_numa_work()
has been removed from the -mm tree.  Its filename was
     sched-numa-fix-the-potential-null-pointer-dereference-in-task_numa_work.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
From: Shawn Wang <shawnwang@linux.alibaba.com>
Subject: sched/numa: fix the potential null pointer dereference in task_numa_work()
Date: Fri, 25 Oct 2024 10:22:08 +0800

When running stress-ng-vm-segv test, we found a null pointer dereference
error in task_numa_work().  Here is the backtrace:

  [323676.066985] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
  ......
  [323676.067108] CPU: 35 PID: 2694524 Comm: stress-ng-vm-se
  ......
  [323676.067113] pstate: 23401009 (nzCv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
  [323676.067115] pc : vma_migratable+0x1c/0xd0
  [323676.067122] lr : task_numa_work+0x1ec/0x4e0
  [323676.067127] sp : ffff8000ada73d20
  [323676.067128] x29: ffff8000ada73d20 x28: 0000000000000000 x27: 000000003e89f010
  [323676.067130] x26: 0000000000080000 x25: ffff800081b5c0d8 x24: ffff800081b27000
  [323676.067133] x23: 0000000000010000 x22: 0000000104d18cc0 x21: ffff0009f7158000
  [323676.067135] x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000ada73db8
  [323676.067138] x17: 0001400000000000 x16: ffff800080df40b0 x15: 0000000000000035
  [323676.067140] x14: ffff8000ada73cc8 x13: 1fffe0017cc72001 x12: ffff8000ada73cc8
  [323676.067142] x11: ffff80008001160c x10: ffff000be639000c x9 : ffff8000800f4ba4
  [323676.067145] x8 : ffff000810375000 x7 : ffff8000ada73974 x6 : 0000000000000001
  [323676.067147] x5 : 0068000b33e26707 x4 : 0000000000000001 x3 : ffff0009f7158000
  [323676.067149] x2 : 0000000000000041 x1 : 0000000000004400 x0 : 0000000000000000
  [323676.067152] Call trace:
  [323676.067153]  vma_migratable+0x1c/0xd0
  [323676.067155]  task_numa_work+0x1ec/0x4e0
  [323676.067157]  task_work_run+0x78/0xd8
  [323676.067161]  do_notify_resume+0x1ec/0x290
  [323676.067163]  el0_svc+0x150/0x160
  [323676.067167]  el0t_64_sync_handler+0xf8/0x128
  [323676.067170]  el0t_64_sync+0x17c/0x180
  [323676.067173] Code: d2888001 910003fd f9000bf3 aa0003f3 (f9401000)
  [323676.067177] SMP: stopping secondary CPUs
  [323676.070184] Starting crashdump kernel...

stress-ng-vm-segv in stress-ng is used to stress test the SIGSEGV error
handling function of the system, which tries to cause a SIGSEGV error on
return from unmapping the whole address space of the child process.

Normally this program will not cause kernel crashes.  But before the
munmap system call returns to user mode, a potential task_numa_work() for
numa balancing could be added and executed.  In this scenario, since the
child process has no vma after munmap, the vma_next() in task_numa_work()
will return a null pointer even if the vma iterator restarts from 0.

Recheck the vma pointer before dereferencing it in task_numa_work().

Link: https://lkml.kernel.org/r/20241025022208.125527-1-shawnwang@linux.alibaba.com
Fixes: 214dbc428137 ("sched: convert to vma iterator")
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: <stable@vger.kernel.org>	[6.2+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/sched/fair.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c~sched-numa-fix-the-potential-null-pointer-dereference-in-task_numa_work
+++ a/kernel/sched/fair.c
@@ -3369,7 +3369,7 @@ retry_pids:
 		vma = vma_next(&vmi);
 	}
 
-	do {
+	for (; vma; vma = vma_next(&vmi)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
@@ -3491,7 +3491,7 @@ retry_pids:
 		 */
 		if (vma_pids_forced)
 			break;
-	} for_each_vma(vmi, vma);
+	}
 
 	/*
 	 * If no VMAs are remaining and VMAs were skipped due to the PID
_

Patches currently in -mm which might be from shawnwang@linux.alibaba.com are



