Return-Path: <stable+bounces-173532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D18EB35D28
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023A47C495A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D427A917;
	Tue, 26 Aug 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OUsnSvkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088E17332C;
	Tue, 26 Aug 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208493; cv=none; b=q85pcE6GpwhZ6m+wxGH+euqB8PYH9S6OjUF9y//CBRBQFn7VyxkjZUnip3n/xfm0J6qYqxa8YP9GNFvqrlaFp+f4w8SPyCZ2o5EHxLzr9eW5xzwjRx+qZxuk8zsSl8h6Vy++eojGvZFVPysxwVg5FLSfkUQgfSkXmA4fbwLmtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208493; c=relaxed/simple;
	bh=Z29N+t5udhRHzag6tpSyvPD03LNF4Q2elENhVC81soU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0abodx8LV3d/Z0NXHlh5Wuw8JB9XVv/ZsC92LhlNv82DV8Eceqc3qxg9Sdy144Iz2JjRoRiKQA/+0xxFN9Z8p7gTR+QIeMTLymRMBngV+nTWMSaH3P02f8Z0rc9/Fp5VEYVp4z5VPp9k0smi0Fe3WhbuL4QlpbVArXx4DGV4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OUsnSvkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE411C4CEF1;
	Tue, 26 Aug 2025 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208493;
	bh=Z29N+t5udhRHzag6tpSyvPD03LNF4Q2elENhVC81soU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUsnSvkBPBy/030VJQdzR40QximpMR010UjsGqLvqMbqF4cj11Ht4tZbMdhH76Hw4
	 R5mbQblyzaobWzgDS/e7pOuCXpN5gq8+MNg+kgVGEWmUjc8U7ip9Qqo2GMbeG1qIzZ
	 Fg9I2opNamT/vP8wazLwo40iOHycVhKboFvRPYHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.12 132/322] sched/ext: Fix invalid task state transitions on class switch
Date: Tue, 26 Aug 2025 13:09:07 +0200
Message-ID: <20250826110919.059374385@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

From: Andrea Righi <arighi@nvidia.com>

commit ddf7233fcab6c247379d0928d46cc316ee122229 upstream.

When enabling a sched_ext scheduler, we may trigger invalid task state
transitions, resulting in warnings like the following (which can be
easily reproduced by running the hotplug selftest in a loop):

 sched_ext: Invalid task state transition 0 -> 3 for fish[770]
 WARNING: CPU: 18 PID: 787 at kernel/sched/ext.c:3862 scx_set_task_state+0x7c/0xc0
 ...
 RIP: 0010:scx_set_task_state+0x7c/0xc0
 ...
 Call Trace:
  <TASK>
  scx_enable_task+0x11f/0x2e0
  switching_to_scx+0x24/0x110
  scx_enable.isra.0+0xd14/0x13d0
  bpf_struct_ops_link_create+0x136/0x1a0
  __sys_bpf+0x1edd/0x2c30
  __x64_sys_bpf+0x21/0x30
  do_syscall_64+0xbb/0x370
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

This happens because we skip initialization for tasks that are already
dead (with their usage counter set to zero), but we don't exclude them
during the scheduling class transition phase.

Fix this by also skipping dead tasks during class swiching, preventing
invalid task state transitions.

Fixes: a8532fac7b5d2 ("sched_ext: TASK_DEAD tasks must be switched into SCX on ops_enable")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5372,6 +5372,9 @@ static int scx_ops_enable(struct sched_e
 			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (!tryget_task_struct(p))
+			continue;
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
@@ -5384,6 +5387,7 @@ static int scx_ops_enable(struct sched_e
 		sched_enq_and_set_task(&ctx);
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
+		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);



