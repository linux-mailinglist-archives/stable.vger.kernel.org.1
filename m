Return-Path: <stable+bounces-89073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6A9B3183
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 14:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A42B21226
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D71DB37B;
	Mon, 28 Oct 2024 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D5FX2dwG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/vAsEctH"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F0F3D3B8;
	Mon, 28 Oct 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121569; cv=none; b=Bd7aa3fz8Vep3yTBI9yX6lw0kClzko6oqgaXSJfa0+nSxg5pk8R1GZHKcDpeld89MDmQiR1KTN3yl6ivv60DnjnywODWem8DESqgSxTDX5bjTl8Xf46Q3DFe9cTb3q0wlHAj78qaW3I4A3VKS2Qw5DrrEqBymb1tUzDZfIwLzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121569; c=relaxed/simple;
	bh=vxjXarRkNCMSgEfVKy18nrdwExeL240oyx4KPnn4B5E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pd4BkC0lBoPDuWCDiedAGYUxakzQ2pet6PAMbfMsidj68UfOflaJ+RnEBRtnj7/GuR4ZdhhB1aDmw4WM9rOzkkL/UMvaO8g8utBrUrpXQzN9ubOSuQ1VJVIcJmNophgq8Xl9PgR7A3LSzaqHY8zCt7bukcSyl9tmbiT2s9Lo5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D5FX2dwG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/vAsEctH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 13:19:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730121564;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AbZsj0GtD/wXNWAFiarprco/IaXQ2DaH4S9HgmRnKA=;
	b=D5FX2dwG2FUikQEmnPmT4qTJ664StfC3CyVdHO+r0GOD2vb9sX+Pb9LT1loMHY0XbTTlqc
	Cr7MZGynZx2Nby8+yxszFagie/38GaU9JN426/gGuQ0XTXJnzIYwVnVFuyhQz/ylEGsRov
	tTS7OOWPFvYBIp9EAiror7z3kp+dGcbXLzFgUyBBBwEOnkktlU61xW0TZQET3Aj3y/9GVW
	T9jjwiWjBeMwtvbsXAcPZZM5pZ+Cv+WYTxTFhZK4hrtiLX7SC/77lLxwEX9oPRT66ynRin
	VhtcMTpCL3/oC6PzhB/2ixYN6irz2MEfnTt/44onnbgDK5LbRvCbN+8NB30qLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730121564;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AbZsj0GtD/wXNWAFiarprco/IaXQ2DaH4S9HgmRnKA=;
	b=/vAsEctHyO3XEJW4oNJEmGEbgljauUrIZWJj/S+RI6m8k8kOxIdzXFAd7aTQ0WgfMro/lb
	uIGklWJiM7mL1RCg==
From: "tip-bot2 for Shawn Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/numa: Fix the potential null pointer
 dereference in task_numa_work()
Cc: Shawn Wang <shawnwang@linux.alibaba.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, #@tip-bot2.tec.linutronix.de,
	v6.2+@tip-bot2.tec.linutronix.de, x86@kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20241025022208.125527-1-shawnwang@linux.alibaba.com>
References: <20241025022208.125527-1-shawnwang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173012156393.1442.1751639070858226239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9c70b2a33cd2aa6a5a59c5523ef053bd42265209
Gitweb:        https://git.kernel.org/tip/9c70b2a33cd2aa6a5a59c5523ef053bd42265209
Author:        Shawn Wang <shawnwang@linux.alibaba.com>
AuthorDate:    Fri, 25 Oct 2024 10:22:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 26 Oct 2024 09:28:37 +02:00

sched/numa: Fix the potential null pointer dereference in task_numa_work()

When running stress-ng-vm-segv test, we found a null pointer dereference
error in task_numa_work(). Here is the backtrace:

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

Normally this program will not cause kernel crashes. But before the
munmap system call returns to user mode, a potential task_numa_work()
for numa balancing could be added and executed. In this scenario, since the
child process has no vma after munmap, the vma_next() in task_numa_work()
will return a null pointer even if the vma iterator restarts from 0.

Recheck the vma pointer before dereferencing it in task_numa_work().

Fixes: 214dbc428137 ("sched: convert to vma iterator")
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org # v6.2+
Link: https://lkml.kernel.org/r/20241025022208.125527-1-shawnwang@linux.alibaba.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8796146..2d16c85 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
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

