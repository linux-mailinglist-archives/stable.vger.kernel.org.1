Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1990D71A06E
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjFAOjd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjFAOj3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 10:39:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02AEE45
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685630363; x=1717166363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kN660c8NFUyOdJrkLu+dYkEvaszRGd9qNNXBXk/WuAU=;
  b=l9jWTMgd6SevfcswDEWsHYY98b5kfu87yWII75ZpCOTNW89duNY5jwuo
   Zsg8MF6xHeUP6oQxyHtvjJnNUJtzq5k062HIQec4JOgT1N2ifFN4nYW3z
   veQMqAD6LXCsCy8DTCy1YBM4v8nkszs3W4M1sEvhm3e1P9TdPXWMQu/4H
   Np1TB7It927utkWglL48/ujQIjiJTcq6aprHnk9NF1MnemdE0v5w6WAPH
   tyxalgBwc4HXrzB+bjfu3Cw+rlDoOcYbM2StvQJJ5lQibdC0CXt7Nk5Np
   Ii6qlPEo9Wv+oecQnVsrzS5er43MKVp/7vQksxfY/FbbwSAPBmh/aX2Nf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441936187"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441936187"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="684867629"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="684867629"
Received: from mborsali-mobl.amr.corp.intel.com (HELO intel.com) ([10.251.208.75])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:38:05 -0700
Date:   Thu, 1 Jun 2023 16:38:02 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
Cc:     "Hajda, Andrzej" <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Intel GFX <intel-gfx@lists.freedesktop.org>,
        DRI Devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/gt: Use the correct error value
 when kernel_context() fails
Message-ID: <ZHitSozwyB69h8kU@ashyti-mobl2.lan>
References: <20230526124138.2006110-1-andi.shyti@linux.intel.com>
 <6897a425-8217-8fca-d0a0-fc02073f6b45@intel.com>
 <SJ1PR11MB620427ACD1EB3B717FDFA1BF81499@SJ1PR11MB6204.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB620427ACD1EB3B717FDFA1BF81499@SJ1PR11MB6204.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Tejas,

> > > @@ -1530,8 +1530,8 @@ static int live_busywait_preempt(void *arg)
> > >   	struct drm_i915_gem_object *obj;
> > >   	struct i915_vma *vma;
> > >   	enum intel_engine_id id;
> > > -	int err = -ENOMEM;
> > >   	u32 *map;
> > > +	int err;
> 
> We could initialize err with 0 and remove err = 0 assignment below but leaving up to you. 

that assignement must be a leftover from previous patches because
err is already initialized here:

	err = i915_vma_pin(vma, 0, 0, PIN_GLOBAL);

will remove it. Thanks!

> > >
> > >   	/*
> > >   	 * Verify that even without HAS_LOGICAL_RING_PREEMPTION, we
> > can @@
> > > -1539,13 +1539,17 @@ static int live_busywait_preempt(void *arg)
> > >   	 */
> > >
> > >   	ctx_hi = kernel_context(gt->i915, NULL);
> > > -	if (!ctx_hi)
> > > -		return -ENOMEM;
> > > +	if (IS_ERR(ctx_hi))
> > > +		return PTR_ERR(ctx_hi);
> > > +
> > >   	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
> > >
> > >   	ctx_lo = kernel_context(gt->i915, NULL);
> > > -	if (!ctx_lo)
> > > +	if (IS_ERR(ctx_lo)) {
> > > +		err = PTR_ERR(ctx_lo);
> > >   		goto err_ctx_hi;
> > > +	}
> > > +
> 
> Looks fine,
> Acked-by: Tejas Upadhyay <tejas.upadhyay@intel.com>

Thank you!
Andi

> 
> > >   	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
> > >
> > >   	obj = i915_gem_object_create_internal(gt->i915, PAGE_SIZE);
> 
