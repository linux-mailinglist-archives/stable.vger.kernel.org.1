Return-Path: <stable+bounces-124226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E6A5EEC0
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2288B19C0A84
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5C1FBCA3;
	Thu, 13 Mar 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw3mmtGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450C155C96
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856480; cv=none; b=IBA3igYgZ16X4MxGkiSy3hVxk1b75iRl2DMuVbxJ97dQDxGGjpbhn6nHeB2+Jqzc89xQxezEVvj41VzZCV4sFb2SdZiq44P6eeAyzCIspQ+xrT/FvkRQh+toVZeRo/WGk77nZ/gEZwuYZgjIUQlhhSyHnP2e6+2C2gn7YM/h5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856480; c=relaxed/simple;
	bh=7Dtah6WHPwKab1f1dJszcm/yd4hfUig7EKMFJJd4EBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEw49v7xGfBuiPg4uM9NUx2FZdt6Vp2aVvI/+NSRXwCSD25zgFmS6WSCb4dD6hCanCfKTUATfsE5P1AG8Gw1/sTRrWf5js4mJ32x/XZ5ruvBYp88CAvnb5zQp1yvaUv3TmqW90dL8Yynoa0ffIEtUsWd0VtAz0lYMc7cPGnZVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw3mmtGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61ABC4CEEE;
	Thu, 13 Mar 2025 09:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856479;
	bh=7Dtah6WHPwKab1f1dJszcm/yd4hfUig7EKMFJJd4EBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bw3mmtGX+pW1q1H/7BVT2Clxx0fOYWIzncrkAKnXj7Sg/lN2DN/rLV/ZTMJw4lw1X
	 37wC7e4c0E0dxc4DJS3FzA76hN8inpGu5L5SswCZ+Awn2OydL8Q6TkHNgLMvVV0UNj
	 Pop6ZM7+OwumPgTTRcrmYxupRKZLjjuwD73Xd5JFC3Sel5k4mkaAE0D99SVUB/cA2T
	 03Fgu/AFMOf4XqrD037fGHGxBfMOFu2Kq0WRivZdlooj5ZyFB8lW2coFOUM0ko6Zxu
	 ZXGPHn5aA2inUy1ePL9oPNIfuv9I5YQPyrUWK+wwbE+hhNhf2G3AwdRgdY5NNqCOz5
	 fPBQaGloDSVhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	urezki@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Date: Thu, 13 Mar 2025 05:01:17 -0400
Message-Id: <20250312223646-63491c95dc46f5e4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311165944.151883-1-urezki@gmail.com>
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

Found matching upstream commit: dfd3df31c9db752234d7d2e09bef2aeabb643ce4

Note: The patch differs from the upstream commit:
---
1:  dfd3df31c9db7 ! 1:  95c2d9d981779 mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
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
| stable/linux-6.13.y       |  Success    |  Success   |

