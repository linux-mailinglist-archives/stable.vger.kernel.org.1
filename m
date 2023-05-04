Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E716F6863
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjEDJh1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 4 May 2023 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEDJh0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 4 May 2023 05:37:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE646B9
        for <stable@vger.kernel.org>; Thu,  4 May 2023 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683193044; x=1714729044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uuwvPTcukojeCkqdnTNYHkod5MKZZgUgvSBBaFF1kfE=;
  b=fKUiGf2Fq6L12Zy5/9vjpvY85nQvflA2hWPReWa9j3/mVcfpwixE46rn
   3YN287wtAhmHkKnm8W0CRMmvrMDK5tzDI1FQ0NDluQdpUUVBUvqo9P/cr
   /zqA9GAKjAKq7ZWmZTZX4xFTpG3b0MAq/DQT3IP23V+mKun/PzklwvXGX
   u48j5vFPx0Johd3+IAB6wTq99YwUY5vyFUJmb2mrygAre4N/wP9x55KGa
   6ORWPV1rEpC7xIhqzL0LMtiabbjCkqBEXUnBF7ylOylSjHGplooTINkvE
   vzjG4tQEexqBV4Y8WhJm3EtzhqXVDS1iLBmpt+idrzRWm6EYeYvrWueEh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348927902"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="348927902"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 02:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="761829691"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="761829691"
Received: from dmitriyp-mobl.ger.corp.intel.com (HELO intel.com) ([10.249.37.93])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 02:37:20 -0700
Date:   Thu, 4 May 2023 11:37:17 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        stable@vger.kernel.org,
        Maciej Patelczyk <maciej.patelczyk@intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 5/5] drm/i915/gt: Make sure that errors
 are propagated through request chains
Message-ID: <ZFN8zc85kGJ8dMlD@ashyti-mobl2.lan>
References: <20230412113308.812468-1-andi.shyti@linux.intel.com>
 <20230412113308.812468-6-andi.shyti@linux.intel.com>
 <ca796c78-67cf-c803-b3bc-7d6eaa542b32@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca796c78-67cf-c803-b3bc-7d6eaa542b32@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Tvrtko,

sorry for the very late reply, it's about time to bring this
patch up.

On Thu, Apr 13, 2023 at 12:56:00PM +0100, Tvrtko Ursulin wrote:
> 
> On 12/04/2023 12:33, Andi Shyti wrote:
> > Currently, when we perform operations such as clearing or copying
> > large blocks of memory, we generate multiple requests that are
> > executed in a chain.
> > 
> > However, if one of these requests fails, we may not realize it
> > unless it happens to be the last request in the chain. This is
> > because errors are not properly propagated.
> > 
> > For this we need to keep propagating the chain of fence
> > notification in order to always reach the final fence associated
> > to the final request.
> > 
> > To address this issue, we need to ensure that the chain of fence
> > notifications is always propagated so that we can reach the final
> > fence associated with the last request. By doing so, we will be
> > able to detect any memory operation  failures and determine
> > whether the memory is still invalid.
> 
> Above two paragraphs seems to have redundancy in the message they convey.
> 
> > On copy and clear migration signal fences upon completion.
> > 
> > On copy and clear migration, signal fences upon request
> > completion to ensure that we have a reliable perpetuation of the
> > operation outcome.
> 
> These two too. So I think commit message can be a bit polished.

In my intent of being very explicative I might have exaggerated.
I know that these kind of patches might bring some controversy.

I will review the commit.

> > Fixes: cf586021642d80 ("drm/i915/gt: Pipelined page migration")
> > Reported-by: Matthew Auld <matthew.auld@intel.com>
> > Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > Acked-by: Nirmoy Das <nirmoy.das@intel.com>
> > ---
> >   drivers/gpu/drm/i915/gt/intel_migrate.c | 51 +++++++++++++++++++------
> >   1 file changed, 39 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gt/intel_migrate.c b/drivers/gpu/drm/i915/gt/intel_migrate.c
> > index 3f638f1987968..668c95af8cbcf 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_migrate.c
> > +++ b/drivers/gpu/drm/i915/gt/intel_migrate.c
> > @@ -742,13 +742,19 @@ intel_context_migrate_copy(struct intel_context *ce,
> >   			dst_offset = 2 * CHUNK_SZ;
> >   	}
> > +	/*
> > +	 * While building the chain of requests, we need to ensure
> > +	 * that no one can sneak into the timeline unnoticed.
> > +	 */
> > +	mutex_lock(&ce->timeline->mutex);
> > +
> >   	do {
> >   		int len;
> > -		rq = i915_request_create(ce);
> > +		rq = i915_request_create_locked(ce);
> >   		if (IS_ERR(rq)) {
> >   			err = PTR_ERR(rq);
> > -			goto out_ce;
> > +			break;
> >   		}
> >   		if (deps) {
> > @@ -878,10 +884,14 @@ intel_context_migrate_copy(struct intel_context *ce,
> >   		/* Arbitration is re-enabled between requests. */
> >   out_rq:
> > -		if (*out)
> > +		i915_sw_fence_await(&rq->submit);
> > +		i915_request_get(rq);
> > +		i915_request_add_locked(rq);
> > +		if (*out) {
> > +			i915_sw_fence_complete(&(*out)->submit);
> >   			i915_request_put(*out);
> 
> Could you help me understand this please. I have a few questions - first,
> what are the actual mechanics of fence error transfer here? I see the submit
> fence is being blocked until the next request is submitted - effectively
> previous request is only allowed to get on the hardware after the next one
> has been queued up. But I don't immediately see what that does in practice.

This is the basic of the error perpetuation. Without this
serialization, for big operations like migrate and copy, we would
only catch the error in the last rq.

> Second question relates to the need to hold the timeline mutex throughout.
> Presumably this is so two copy or migrate operations on the same context do
> not interleave, which can otherwise happen?
> 
> Would the error propagation be doable without the lock held by chaining on
> the previous request _completion_ fence? If so I am sure that would have a
> performance impact, because chunk by chunk would need a GPU<->CPU round trip
> to schedule. How much of an impact I don't know. Maybe enlarging CHUNK_SZ to
> compensate is an option?

The need for a mutex lock comes from adding the throttle during
request creation, which ensures no pending requests are being
served.

I will copy paste from Chris review, which was missed in the
mailing list:

Adding a large throttle before the mutex makes the race less
likely, but to overcome that just increase the number of
simultaneous clients fighting for ring space.

If we hold the lock while constructing the chain, no one else may
inject themselves between links in our chain. If we do not, we
may end up with

ABCDEFGHI
^head   ^tail

Then in order for A to submit its next request it has to wait
upon its previous request. But since we are holding the submit
fence for A, it will not be executed until after we complete our
submission. Boom.

Andi

> Or if the perf hit would be bearable for stable backports only (much smaller
> patch) and then for tip we can do this full speed solution.
> 
> But yes, I would first want to understand the actual error propagation
> mechanism because sadly my working knowledge is a bit rusty.
> 
> > -		*out = i915_request_get(rq);
> > -		i915_request_add(rq);
> > +		}
> > +		*out = rq;
> >   		if (err)
> >   			break;
> > @@ -905,7 +915,10 @@ intel_context_migrate_copy(struct intel_context *ce,
> >   		cond_resched();
> >   	} while (1);
> > -out_ce:
> > +	mutex_unlock(&ce->timeline->mutex);
> > +
> > +	if (*out)
> > +		i915_sw_fence_complete(&(*out)->submit);
> >   	return err;
> >   }
> > @@ -999,13 +1012,19 @@ intel_context_migrate_clear(struct intel_context *ce,
> >   	if (HAS_64K_PAGES(i915) && is_lmem)
> >   		offset = CHUNK_SZ;
> > +	/*
> > +	 * While building the chain of requests, we need to ensure
> > +	 * that no one can sneak into the timeline unnoticed.
> > +	 */
> > +	mutex_lock(&ce->timeline->mutex);
> > +
> >   	do {
> >   		int len;
> > -		rq = i915_request_create(ce);
> > +		rq = i915_request_create_locked(ce);
> >   		if (IS_ERR(rq)) {
> >   			err = PTR_ERR(rq);
> > -			goto out_ce;
> > +			break;
> >   		}
> >   		if (deps) {
> > @@ -1056,17 +1075,25 @@ intel_context_migrate_clear(struct intel_context *ce,
> >   		/* Arbitration is re-enabled between requests. */
> >   out_rq:
> > -		if (*out)
> > +		i915_sw_fence_await(&rq->submit);
> > +		i915_request_get(rq);
> > +		i915_request_add_locked(rq);
> > +		if (*out) {
> > +			i915_sw_fence_complete(&(*out)->submit);
> >   			i915_request_put(*out);
> > -		*out = i915_request_get(rq);
> > -		i915_request_add(rq);
> > +		}
> > +		*out = rq;
> 
> Btw if all else fails perhaps these two blocks can be consolidated by
> something like __chain_requests(rq, out) and all these operations in it. Not
> sure how much would that save in the grand total.
> 
> Regards,
> 
> Tvrtko
> 
> > +
> >   		if (err || !it.sg || !sg_dma_len(it.sg))
> >   			break;
> >   		cond_resched();
> >   	} while (1);
> > -out_ce:
> > +	mutex_unlock(&ce->timeline->mutex);
> > +
> > +	if (*out)
> > +		i915_sw_fence_complete(&(*out)->submit);
> >   	return err;
> >   }
