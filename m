Return-Path: <stable+bounces-126025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0386CA6F42C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4612E3B893B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558782561A8;
	Tue, 25 Mar 2025 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JexeCldD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B6255E47
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902431; cv=none; b=pIzOP+sfxeEEou19d+2EbBZltuqxHjxsqoUOzmMhqdp9HTrc8hJ0Q/hfJgSnBUCCutzkCcYTTCUsgJ/HfqNj1t0jczEKKFVd7iTz6FYrdegpG466aI4XXdwfLPaOrFhaCX7JCCVZcI/fJNF3eEOaJxOh8tj83vAvHDKFlQhzyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902431; c=relaxed/simple;
	bh=1nvub6VmcPWBU5DeaJMe39ZPNnlVg0YiEQNScqiABx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1HNBwHLDi3ST4rs8lfMUHnckpQAJ5hyaRcWkMLmDLlYL9cPptzJ+xTypsK0s/j35ffXOiMyvFYR9EdhwSI9RjyhSnI82hO/baMh+BrhTcdzYkEthozzqhk7SqrHBzVS/auptwJPMA1LYepWv0aPYCM2LMaXPF89S2hY/hrTU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JexeCldD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6952EC4CEE4;
	Tue, 25 Mar 2025 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902430;
	bh=1nvub6VmcPWBU5DeaJMe39ZPNnlVg0YiEQNScqiABx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JexeCldDxkoV5cw07DeplE3CKQOZ7GC6cmgeuehuP5NrJFfWA9uxZde0m0iSzzZQh
	 AOkob+2n3KWqsJsL7LRoo6g4Rj3ztxjdgYXBUBYLxs5nu2ZnFigxySIrcMUXQoJX2J
	 lmTaemmydXrqJLaGQsX4bSJ4U6VB9BLtw+DUNg8uii5iDtTOqcJLAItIduhuwxXgoO
	 p9rgnp0etS9ACOMBexBtIXjJgWf9KVxxMw+DJU+QuamfrqanHfM8AQKLNvQe+DEWqM
	 7+xKGyub8vGSWW23WnYRfJYPog1fs7Z4fqZ0lgalAgjfx34CdZ/6bVJ3TELaOFDyXY
	 CgNCtgg56HpFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
Date: Tue, 25 Mar 2025 07:33:49 -0400
Message-Id: <20250324203640-8a44c31bfa09fb2f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324213706.8335-1-hagarhem@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 76f970ce51c80f625eb6ddbb24e9cb51b977b598

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Dietmar Eggemann<dietmar.eggemann@arm.com>

Status in newer kernel trees:
6.13.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  76f970ce51c80 ! 1:  03098b8360be3 Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
    @@
      ## Metadata ##
    -Author: Dietmar Eggemann <dietmar.eggemann@arm.com>
    +Author: Hagar Hemdan <hagarhem@amazon.com>
     
      ## Commit message ##
         Revert "sched/core: Reduce cost of sched_move_task when config autogroup"
     
    +    commit 76f970ce51c80f625eb6ddbb24e9cb51b977b598 upstream.
    +
         This reverts commit eff6c8ce8d4d7faef75f66614dd20bb50595d261.
     
         Hazem reported a 30% drop in UnixBench spawn test with commit
    @@ Commit message
         Tested-by: Hagar Hemdan <hagarhem@amazon.com>
         Cc: Linus Torvalds <torvalds@linux-foundation.org>
         Link: https://lore.kernel.org/r/20250314151345.275739-1-dietmar.eggemann@arm.com
    +    [Hagar: clean revert of eff6c8ce8dd7 to make it work on 6.6]
    +    Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
     
      ## kernel/sched/core.c ##
     @@ kernel/sched/core.c: void sched_release_group(struct task_group *tg)
    @@ kernel/sched/core.c: static struct task_group *sched_get_task_group(struct task_
      
      #ifdef CONFIG_FAIR_GROUP_SCHED
      	if (tsk->sched_class->task_change_group)
    -@@ kernel/sched/core.c: void sched_move_task(struct task_struct *tsk, bool for_autogroup)
    +@@ kernel/sched/core.c: void sched_move_task(struct task_struct *tsk)
      {
      	int queued, running, queue_flags =
      		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
     -	struct task_group *group;
    + 	struct rq_flags rf;
      	struct rq *rq;
      
    - 	CLASS(task_rq_lock, rq_guard)(tsk);
    - 	rq = rq_guard.rq;
    - 
    + 	rq = task_rq_lock(tsk, &rf);
     -	/*
     -	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
     -	 * group changes.
     -	 */
     -	group = sched_get_task_group(tsk);
     -	if (group == tsk->sched_task_group)
    --		return;
    +-		goto unlock;
     -
      	update_rq_clock(rq);
      
    - 	running = task_current_donor(rq, tsk);
    -@@ kernel/sched/core.c: void sched_move_task(struct task_struct *tsk, bool for_autogroup)
    + 	running = task_current(rq, tsk);
    +@@ kernel/sched/core.c: void sched_move_task(struct task_struct *tsk)
      	if (running)
      		put_prev_task(rq, tsk);
      
     -	sched_change_group(tsk, group);
     +	sched_change_group(tsk);
    - 	if (!for_autogroup)
    - 		scx_cgroup_move_task(tsk);
    + 
    + 	if (queued)
    + 		enqueue_task(rq, tsk, queue_flags);
    +@@ kernel/sched/core.c: void sched_move_task(struct task_struct *tsk)
    + 		resched_curr(rq);
    + 	}
    + 
    +-unlock:
    + 	task_rq_unlock(rq, tsk, &rf);
    + }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

