Return-Path: <stable+bounces-124235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC00A5EED3
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED7D19C1127
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A15265630;
	Thu, 13 Mar 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNJO6dQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D5155C96
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856498; cv=none; b=FQJMO52uSUYLgMa5yBoYoGjrOKQiLsQLX/bdzhJL29iyB+GOZaB95dZ0/EaEhJmc8Xn3rvynUPk5kDQfPIMmk8EnVmHTFA0fbLE+qrV47NWedVUXNzzIhbTaeFraemk5L7A5HJZsKPZjGe5Rn6ZbyGMc1EoMbAiQHO/3PKL+VTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856498; c=relaxed/simple;
	bh=wcNpg//cMMPzhntZGfSX++p37bUSpBc2R0MNjEQS/nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTITnhExNBcocdBKTDVrYd5hZfWDusjdxrn37mMp9bra7D695767P825IJHczYLTWbw0hsJmpxMkY2ayDaI1gj4HNkHUyY36wCNoKhhmVawSHh+ebSmt38RAIn+4IFY+rCsh0kFnNE1lKfOtQER/E14IRCgeGU2VXPkyWBIyFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNJO6dQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8945C4CEE3;
	Thu, 13 Mar 2025 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856497;
	bh=wcNpg//cMMPzhntZGfSX++p37bUSpBc2R0MNjEQS/nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNJO6dQUl2r2laXenC7tUhhpPsbLrsWtDk99d/1fpyK7q7LKIeAFAbWv0kvYvqO/s
	 vtno/ug3c5bdm358SqFaxLHT9CVqA8tfxLri0KF21UkjOymwSOi6IolNf0L+NBRdGr
	 cAOeoMFTcDZjCgWGrzzvzAvZd2SkaFcNIfNRbNgrBa43CSlcFED3u+XlTRUl5/RFKB
	 cwPXff7taYQEMRQeQJGUty16iMcQCkeUMXuhcmZkp4JMBRo3jShHBCNeonMmXCR1mb
	 Dl1rGCieJqfQWVRVehatZbC/ibQX9d88He5WSyFzMC1ekO0QAZ+/r6GUUF5cCwRnU2
	 Gch+ssArE3KnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	urezki@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Date: Thu, 13 Mar 2025 05:01:35 -0400
Message-Id: <20250312230601-fe0c364f617e016d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311165416.108043-1-urezki@gmail.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

Found matching upstream commit: dfd3df31c9db752234d7d2e09bef2aeabb643ce4

Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  dfd3df31c9db7 ! 1:  b4fb63fe8c845 mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
    @@ Commit message
         Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
         Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
     
    - ## mm/slab_common.c ##
    -@@ mm/slab_common.c: module_param(rcu_min_cached_objs, int, 0444);
    - static int rcu_delay_page_cache_fill_msec = 5000;
    - module_param(rcu_delay_page_cache_fill_msec, int, 0444);
    + ## kernel/rcu/tree.c ##
    +@@ kernel/rcu/tree.c: void call_rcu(struct rcu_head *head, rcu_callback_t func)
    + }
    + EXPORT_SYMBOL_GPL(call_rcu);
      
     +static struct workqueue_struct *rcu_reclaim_wq;
     +
      /* Maximum number of jiffies to wait before draining a batch. */
      #define KFREE_DRAIN_JIFFIES (5 * HZ)
      #define KFREE_N_BATCHES 2
    -@@ mm/slab_common.c: __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
    +@@ kernel/rcu/tree.c: __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
      	if (delayed_work_pending(&krcp->monitor_work)) {
      		delay_left = krcp->monitor_work.timer.expires - jiffies;
      		if (delay < delay_left)
    @@ mm/slab_common.c: __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
      }
      
      static void
    -@@ mm/slab_common.c: kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
    +@@ kernel/rcu/tree.c: kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
      			// "free channels", the batch can handle. Break
      			// the loop since it is done with this CPU thus
      			// queuing an RCU work is _always_ success here.
    @@ mm/slab_common.c: kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
      			WARN_ON_ONCE(!queued);
      			break;
      		}
    -@@ mm/slab_common.c: run_page_cache_worker(struct kfree_rcu_cpu *krcp)
    +@@ kernel/rcu/tree.c: run_page_cache_worker(struct kfree_rcu_cpu *krcp)
      	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
      			!atomic_xchg(&krcp->work_in_progress, 1)) {
      		if (atomic_read(&krcp->backoff_page_cache_fill)) {
    @@ mm/slab_common.c: run_page_cache_worker(struct kfree_rcu_cpu *krcp)
      				&krcp->page_cache_work,
      					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
      		} else {
    -@@ mm/slab_common.c: void __init kvfree_rcu_init(void)
    +@@ kernel/rcu/tree.c: static void __init kfree_rcu_batch_init(void)
      	int i, j;
      	struct shrinker *kfree_rcu_shrinker;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

