Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C12783CD9
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjHVJ0G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVJ0G (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 05:26:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96837113
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692696361; x=1724232361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8B7Qt0rt+N8EjxjBYRYZz/QB0IMdM6hmZCDytO9rpNg=;
  b=cQ0GWi3ct72pACpwMuu2pmjBqq9YKz/gTuJcWnbHefgEGL0X1DGudWOz
   GzubpTXvffP6+PCNBZOecvajnII06Ud4Ig2BeDDSfSgaJ4XrLc8UArfvF
   jCX8ODIlrZGRv8pPO+yDlbYLzIW9hdMUlK2p8hq5ngbesrSf+oBMu2+iH
   kxQGYEVduICj9cBZp8DIBZGNzTn+oqcBqPI0r04kvp1W4isGtJEZ47LMY
   lj7WY5J7PUFkQuMJ2/J2WZlkyURH7/DQPcVpc80z6NljEMCTLMMGpG4VO
   0QjUOwVEiTTpsxaQQxhFrEpHq476GWGyW4EfPvrU//ZytOrRK4Wc1TQMy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371256809"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="371256809"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 02:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685977551"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="685977551"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.11.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 02:25:59 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     stable@vger.kernel.org
Cc:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH 5.15.y] drm/i915: Fix premature release of request's reusable memory
Date:   Tue, 22 Aug 2023 11:25:45 +0200
Message-ID: <20230822092544.51406-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023080739-trinity-overfed-f523@gregkh>
References: <2023080739-trinity-overfed-f523@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Infinite waits for completion of GPU activity have been observed in CI,
mostly inside __i915_active_wait(), triggered by igt@gem_barrier_race or
igt@perf@stress-open-close.  Root cause analysis, based of ftrace dumps
generated with a lot of extra trace_printk() calls added to the code,
revealed loops of request dependencies being accidentally built,
preventing the requests from being processed, each waiting for completion
of another one's activity.

After we substitute a new request for a last active one tracked on a
timeline, we set up a dependency of our new request to wait on completion
of current activity of that previous one.  While doing that, we must take
care of keeping the old request still in memory until we use its
attributes for setting up that await dependency, or we can happen to set
up the await dependency on an unrelated request that already reuses the
memory previously allocated to the old one, already released.  Combined
with perf adding consecutive kernel context remote requests to different
user context timelines, unresolvable loops of await dependencies can be
built, leading do infinite waits.

We obtain a pointer to the previous request to wait upon when we
substitute it with a pointer to our new request in an active tracker,
e.g. in intel_timeline.last_request.  In some processing paths we protect
that old request from being freed before we use it by getting a reference
to it under RCU protection, but in others, e.g.  __i915_request_commit()
-> __i915_request_add_to_timeline() -> __i915_request_ensure_ordering(),
we don't.  But anyway, since the requests' memory is SLAB_FAILSAFE_BY_RCU,
that RCU protection is not sufficient against reuse of memory.

We could protect i915_request's memory from being prematurely reused by
calling its release function via call_rcu() and using rcu_read_lock()
consequently, as proposed in v1.  However, that approach leads to
significant (up to 10 times) increase of SLAB utilization by i915_request
SLAB cache.  Another potential approach is to take a reference to the
previous active fence.

When updating an active fence tracker, we first lock the new fence,
substitute a pointer of the current active fence with the new one, then we
lock the substituted fence.  With this approach, there is a time window
after the substitution and before the lock when the request can be
concurrently released by an interrupt handler and its memory reused, then
we may happen to lock and return a new, unrelated request.

Always get a reference to the current active fence first, before
replacing it with a new one.  Having it protected from premature release
and reuse, lock it and then replace with the new one but only if not
yet signalled via a potential concurrent interrupt nor replaced with
another one by a potential concurrent thread, otherwise retry, starting
from getting a reference to the new current one.  Adjust users to not
get a reference to the previous active fence themselves and always put the
reference got by __i915_active_fence_set() when no longer needed.

v3: Fix lockdep splat reports and other issues caused by incorrect use of
    try_cmpxchg() (use (cmpxchg() != prev) instead)
v2: Protect request's memory by getting a reference to it in favor of
    delegating its release to call_rcu() (Chris)

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8211
Fixes: df9f85d8582e ("drm/i915: Serialise i915_active_fence_set() with itself")
Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.6+
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230720093543.832147-2-janusz.krzysztofik@linux.intel.com
(cherry picked from commit 946e047a3d88d46d15b5c5af0414098e12b243f7)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
(cherry picked from commit a337b64f0d5717248a0c894e2618e658e6a9de9f)
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_active.c  | 99 ++++++++++++++++++++---------
 drivers/gpu/drm/i915/i915_request.c |  2 +
 2 files changed, 72 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 2f640b9fdf4af..3034ce392ac1f 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -447,8 +447,11 @@ int i915_active_ref(struct i915_active *ref, u64 idx, struct dma_fence *fence)
 		}
 	} while (unlikely(is_barrier(active)));
 
-	if (!__i915_active_fence_set(active, fence))
+	fence = __i915_active_fence_set(active, fence);
+	if (!fence)
 		__i915_active_acquire(ref);
+	else
+		dma_fence_put(fence);
 
 out:
 	i915_active_release(ref);
@@ -467,13 +470,9 @@ __i915_active_set_fence(struct i915_active *ref,
 		return NULL;
 	}
 
-	rcu_read_lock();
 	prev = __i915_active_fence_set(active, fence);
-	if (prev)
-		prev = dma_fence_get_rcu(prev);
-	else
+	if (!prev)
 		__i915_active_acquire(ref);
-	rcu_read_unlock();
 
 	return prev;
 }
@@ -1040,10 +1039,11 @@ void i915_request_add_active_barriers(struct i915_request *rq)
  *
  * Records the new @fence as the last active fence along its timeline in
  * this active tracker, moving the tracking callbacks from the previous
- * fence onto this one. Returns the previous fence (if not already completed),
- * which the caller must ensure is executed before the new fence. To ensure
- * that the order of fences within the timeline of the i915_active_fence is
- * understood, it should be locked by the caller.
+ * fence onto this one. Gets and returns a reference to the previous fence
+ * (if not already completed), which the caller must put after making sure
+ * that it is executed before the new fence. To ensure that the order of
+ * fences within the timeline of the i915_active_fence is understood, it
+ * should be locked by the caller.
  */
 struct dma_fence *
 __i915_active_fence_set(struct i915_active_fence *active,
@@ -1052,7 +1052,23 @@ __i915_active_fence_set(struct i915_active_fence *active,
 	struct dma_fence *prev;
 	unsigned long flags;
 
-	if (fence == rcu_access_pointer(active->fence))
+	/*
+	 * In case of fences embedded in i915_requests, their memory is
+	 * SLAB_FAILSAFE_BY_RCU, then it can be reused right after release
+	 * by new requests.  Then, there is a risk of passing back a pointer
+	 * to a new, completely unrelated fence that reuses the same memory
+	 * while tracked under a different active tracker.  Combined with i915
+	 * perf open/close operations that build await dependencies between
+	 * engine kernel context requests and user requests from different
+	 * timelines, this can lead to dependency loops and infinite waits.
+	 *
+	 * As a countermeasure, we try to get a reference to the active->fence
+	 * first, so if we succeed and pass it back to our user then it is not
+	 * released and potentially reused by an unrelated request before the
+	 * user has a chance to set up an await dependency on it.
+	 */
+	prev = i915_active_fence_get(active);
+	if (fence == prev)
 		return fence;
 
 	GEM_BUG_ON(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags));
@@ -1061,27 +1077,56 @@ __i915_active_fence_set(struct i915_active_fence *active,
 	 * Consider that we have two threads arriving (A and B), with
 	 * C already resident as the active->fence.
 	 *
-	 * A does the xchg first, and so it sees C or NULL depending
-	 * on the timing of the interrupt handler. If it is NULL, the
-	 * previous fence must have been signaled and we know that
-	 * we are first on the timeline. If it is still present,
-	 * we acquire the lock on that fence and serialise with the interrupt
-	 * handler, in the process removing it from any future interrupt
-	 * callback. A will then wait on C before executing (if present).
-	 *
-	 * As B is second, it sees A as the previous fence and so waits for
-	 * it to complete its transition and takes over the occupancy for
-	 * itself -- remembering that it needs to wait on A before executing.
+	 * Both A and B have got a reference to C or NULL, depending on the
+	 * timing of the interrupt handler.  Let's assume that if A has got C
+	 * then it has locked C first (before B).
 	 *
 	 * Note the strong ordering of the timeline also provides consistent
 	 * nesting rules for the fence->lock; the inner lock is always the
 	 * older lock.
 	 */
 	spin_lock_irqsave(fence->lock, flags);
-	prev = xchg(__active_fence_slot(active), fence);
-	if (prev) {
-		GEM_BUG_ON(prev == fence);
+	if (prev)
 		spin_lock_nested(prev->lock, SINGLE_DEPTH_NESTING);
+
+	/*
+	 * A does the cmpxchg first, and so it sees C or NULL, as before, or
+	 * something else, depending on the timing of other threads and/or
+	 * interrupt handler.  If not the same as before then A unlocks C if
+	 * applicable and retries, starting from an attempt to get a new
+	 * active->fence.  Meanwhile, B follows the same path as A.
+	 * Once A succeeds with cmpxch, B fails again, retires, gets A from
+	 * active->fence, locks it as soon as A completes, and possibly
+	 * succeeds with cmpxchg.
+	 */
+	while (cmpxchg(__active_fence_slot(active), prev, fence) != prev) {
+		if (prev) {
+			spin_unlock(prev->lock);
+			dma_fence_put(prev);
+		}
+		spin_unlock_irqrestore(fence->lock, flags);
+
+		prev = i915_active_fence_get(active);
+		GEM_BUG_ON(prev == fence);
+
+		spin_lock_irqsave(fence->lock, flags);
+		if (prev)
+			spin_lock_nested(prev->lock, SINGLE_DEPTH_NESTING);
+	}
+
+	/*
+	 * If prev is NULL then the previous fence must have been signaled
+	 * and we know that we are first on the timeline.  If it is still
+	 * present then, having the lock on that fence already acquired, we
+	 * serialise with the interrupt handler, in the process of removing it
+	 * from any future interrupt callback.  A will then wait on C before
+	 * executing (if present).
+	 *
+	 * As B is second, it sees A as the previous fence and so waits for
+	 * it to complete its transition and takes over the occupancy for
+	 * itself -- remembering that it needs to wait on A before executing.
+	 */
+	if (prev) {
 		__list_del_entry(&active->cb.node);
 		spin_unlock(prev->lock); /* serialise with prev->cb_list */
 	}
@@ -1098,11 +1143,7 @@ int i915_active_fence_set(struct i915_active_fence *active,
 	int err = 0;
 
 	/* Must maintain timeline ordering wrt previous active requests */
-	rcu_read_lock();
 	fence = __i915_active_fence_set(active, &rq->fence);
-	if (fence) /* but the previous fence may not belong to that timeline! */
-		fence = dma_fence_get_rcu(fence);
-	rcu_read_unlock();
 	if (fence) {
 		err = i915_request_await_dma_fence(rq, fence);
 		dma_fence_put(fence);
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 79da5eca60af5..bd85113ad150c 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -1596,6 +1596,8 @@ __i915_request_add_to_timeline(struct i915_request *rq)
 							 &rq->dep,
 							 0);
 	}
+	if (prev)
+		i915_request_put(prev);
 
 	/*
 	 * Make sure that no request gazumped us - if it was allocated after
-- 
2.41.0

