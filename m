Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D067789C34
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjH0IhA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjH0Ige (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DF3E79
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D2960A70
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65D0C433C8;
        Sun, 27 Aug 2023 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693125377;
        bh=LvrU4WWrb1IzcSH8CDjaHSiOIARNlbHcBgw78gwkSBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xupPq4+0Z9lADZe2ojGzA+/M8mB3trls+KRlKGyL/iv2+b0mhAj2YofPaEUrBAT3y
         z64rZH40ZaxNnoXqG1S/JqQfhna1LoRvMTtUO7ydTy+F/0WfcuCYONqLlQDsaxvf5P
         aLsO6ZIcK0evn7fYOJqSh0yXkQoHZaa2oXGbAbnQ=
Date:   Sun, 27 Aug 2023 10:36:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] drm/i915: Fix premature release of request's
 reusable memory
Message-ID: <2023082702-dyslexia-disliking-2a94@gregkh>
References: <2023080739-trinity-overfed-f523@gregkh>
 <20230822092544.51406-2-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822092544.51406-2-janusz.krzysztofik@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 22, 2023 at 11:25:45AM +0200, Janusz Krzysztofik wrote:
> Infinite waits for completion of GPU activity have been observed in CI,
> mostly inside __i915_active_wait(), triggered by igt@gem_barrier_race or
> igt@perf@stress-open-close.  Root cause analysis, based of ftrace dumps
> generated with a lot of extra trace_printk() calls added to the code,
> revealed loops of request dependencies being accidentally built,
> preventing the requests from being processed, each waiting for completion
> of another one's activity.
> 
> After we substitute a new request for a last active one tracked on a
> timeline, we set up a dependency of our new request to wait on completion
> of current activity of that previous one.  While doing that, we must take
> care of keeping the old request still in memory until we use its
> attributes for setting up that await dependency, or we can happen to set
> up the await dependency on an unrelated request that already reuses the
> memory previously allocated to the old one, already released.  Combined
> with perf adding consecutive kernel context remote requests to different
> user context timelines, unresolvable loops of await dependencies can be
> built, leading do infinite waits.
> 
> We obtain a pointer to the previous request to wait upon when we
> substitute it with a pointer to our new request in an active tracker,
> e.g. in intel_timeline.last_request.  In some processing paths we protect
> that old request from being freed before we use it by getting a reference
> to it under RCU protection, but in others, e.g.  __i915_request_commit()
> -> __i915_request_add_to_timeline() -> __i915_request_ensure_ordering(),
> we don't.  But anyway, since the requests' memory is SLAB_FAILSAFE_BY_RCU,
> that RCU protection is not sufficient against reuse of memory.
> 
> We could protect i915_request's memory from being prematurely reused by
> calling its release function via call_rcu() and using rcu_read_lock()
> consequently, as proposed in v1.  However, that approach leads to
> significant (up to 10 times) increase of SLAB utilization by i915_request
> SLAB cache.  Another potential approach is to take a reference to the
> previous active fence.
> 
> When updating an active fence tracker, we first lock the new fence,
> substitute a pointer of the current active fence with the new one, then we
> lock the substituted fence.  With this approach, there is a time window
> after the substitution and before the lock when the request can be
> concurrently released by an interrupt handler and its memory reused, then
> we may happen to lock and return a new, unrelated request.
> 
> Always get a reference to the current active fence first, before
> replacing it with a new one.  Having it protected from premature release
> and reuse, lock it and then replace with the new one but only if not
> yet signalled via a potential concurrent interrupt nor replaced with
> another one by a potential concurrent thread, otherwise retry, starting
> from getting a reference to the new current one.  Adjust users to not
> get a reference to the previous active fence themselves and always put the
> reference got by __i915_active_fence_set() when no longer needed.
> 
> v3: Fix lockdep splat reports and other issues caused by incorrect use of
>     try_cmpxchg() (use (cmpxchg() != prev) instead)
> v2: Protect request's memory by getting a reference to it in favor of
>     delegating its release to call_rcu() (Chris)
> 
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8211
> Fixes: df9f85d8582e ("drm/i915: Serialise i915_active_fence_set() with itself")
> Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.6+
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230720093543.832147-2-janusz.krzysztofik@linux.intel.com
> (cherry picked from commit 946e047a3d88d46d15b5c5af0414098e12b243f7)
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> (cherry picked from commit a337b64f0d5717248a0c894e2618e658e6a9de9f)
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_active.c  | 99 ++++++++++++++++++++---------
>  drivers/gpu/drm/i915/i915_request.c |  2 +
>  2 files changed, 72 insertions(+), 29 deletions(-)

Now queued up, thanks.

greg k-h
