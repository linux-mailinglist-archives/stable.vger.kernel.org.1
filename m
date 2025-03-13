Return-Path: <stable+bounces-124243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B6AA5EF1E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995B717DA86
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B8266192;
	Thu, 13 Mar 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFT5vGHm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D72641DD
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856920; cv=none; b=b+8dw1VO4PiEbP/os5jsIGySkYvCCIv5fwh0ZZwTEVnU/X+aQZVxTLXnbeeZgUpWA4q13EqX+KZCBoBN7YgHw2PiLArq6CXMFt5pjnelNsUySDiYletg5i+ZzE93jzI84TmeeDhYGpTA68A3DaK41KNUatpp71uZlvWbZ9Knves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856920; c=relaxed/simple;
	bh=PztL1jn1+N4C6TmWg0sG6oK6xjR3WYfz8OzOo4WF1vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tae/z6kvlyVJKYXTqb8t9vtVpqEQ75fMoT+SaAbYyVyn/reTv2kuzVPcIgj+w1QumkgajFcTNCvK3dt2cyrFws1w3/IDzGxDmMMsPgJc9Ceep9cNCPucx5w4uhqZTGbEFyD7D3x+0K8tAn8XhBg7o1zSDH7WxQR9Qq630y/yz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFT5vGHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECD3C4CEE3;
	Thu, 13 Mar 2025 09:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856919;
	bh=PztL1jn1+N4C6TmWg0sG6oK6xjR3WYfz8OzOo4WF1vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFT5vGHmEuN2CGbYRjl4DzhZ2Avufz9JFRE0Tp+RMJYAPmfCT3XuRtzItImxRoJQI
	 83O3qrl6QU9LPzptNz38Lnz3n3Og+qALT/dcGhZ3mTgRFXIAvzVGU5p3YBpOVoqOkL
	 954RHbHxvsQWFtO3SnuQ0UscJZ0FyQU0DuDaF80rbCLmmVBVNyErKdz3EqfwxyL8tP
	 IE92pam4xaEStghFkYVD8cEYRx1053cGQK26lBq2GMk3dlkL3wiD9icyY7CVTcYv+g
	 uR1To5RvVrkBNEt0Yy+/W583cO36k5Tf78v7vk0MT36mrqehXYFT3kHIfIpISJop3+
	 fwI3gJoXnzAbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 6.13.y] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Date: Thu, 13 Mar 2025 05:08:37 -0400
Message-Id: <20250312204312-a70d979730718b6e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312102924.16247-1-urezki@gmail.com>
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

The upstream commit SHA1 provided is correct: dfd3df31c9db752234d7d2e09bef2aeabb643ce4

Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  dfd3df31c9db7 ! 1:  ec5a5cc49c69d mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
    @@ Metadata
      ## Commit message ##
         mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
     
    +    commit dfd3df31c9db752234d7d2e09bef2aeabb643ce4 upstream.
    +
         Currently kvfree_rcu() APIs use a system workqueue which is
         "system_unbound_wq" to driver RCU machinery to reclaim a memory.
     
    @@ Commit message
         Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
         Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
         Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
    +    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
     
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
| stable/linux-6.13.y       |  Success    |  Success   |

