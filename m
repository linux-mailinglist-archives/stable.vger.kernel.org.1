Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342227D4FAA
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjJXMUm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 08:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJXMUi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 08:20:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E6B3
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698150036; x=1729686036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lYmBzITJOyBGYtHf4xg0RdGKmfdhdZx0HVURRbjhEvY=;
  b=O0JnyMiVvNdT2KkZYmGnRCi/3vsOo6yMc26NHR5EkoUF9TgC5/JAETgK
   5SBJM9Dh1WN3kJRfaEECNbwh/FO+wN6lorTb9q7+qAApa17zjkfHtOfPt
   J6dEG9VfndaonQdziMNYbky8pgqEZh4ngSeXhFuGl77IWo/ePVp/eAqfC
   XH0O3XuIm856dmuxtlTvWweDX3HB/TwqD0pgQuf0r894lkfjUmScn/ygj
   yeYy8LfuMt51g0CsIQebVW7dUBVzEW2KSYQTd0Xn/crO/9KDfCNq0oSIS
   ztm39XCl56iBwwydDwIWDRPy+8mV7useCSYEHOCX8Nv9B85L6U5AxsPLK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385937537"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="385937537"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6433810"
Received: from yaminehx-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.33.158])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:20:29 -0700
Date:   Tue, 24 Oct 2023 14:20:33 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915/pmu: Check if pmu is closed before
 stopping event
Message-ID: <ZTe2ka9rOHQDxs8t@ashyti-mobl2.lan>
References: <20231020152441.3764850-1-umesh.nerlige.ramappa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020152441.3764850-1-umesh.nerlige.ramappa@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Umesh,

On Fri, Oct 20, 2023 at 08:24:41AM -0700, Umesh Nerlige Ramappa wrote:
> When the driver unbinds, pmu is unregistered and i915->uabi_engines is
> set to RB_ROOT. Due to this, when i915 PMU tries to stop the engine
> events, it issues a warn_on because engine lookup fails.
> 
> All perf hooks are taking care of this using a pmu->closed flag that is
> set when PMU unregisters. The stop event seems to have been left out.
> 
> Check for pmu->closed in pmu_event_stop as well.
> 
> Based on discussion here -
> https://patchwork.freedesktop.org/patch/492079/?series=105790&rev=2
> 
> v2: s/is/if/ in commit title
> v3: Add fixes tag and cc stable
> 
> Cc: <stable@vger.kernel.org> # v5.11+
> Fixes: b00bccb3f0bb ("drm/i915/pmu: Handle PCI unbind")
> Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

argh! 4th time that this patch has been sent. Please next time
use:

   git format-patch -v <version number>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

No need to resend :-)

Andi

> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index 108b675088ba..f861863eb7c1 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -831,9 +831,18 @@ static void i915_pmu_event_start(struct perf_event *event, int flags)
>  
>  static void i915_pmu_event_stop(struct perf_event *event, int flags)
>  {
> +	struct drm_i915_private *i915 =
> +		container_of(event->pmu, typeof(*i915), pmu.base);
> +	struct i915_pmu *pmu = &i915->pmu;
> +
> +	if (pmu->closed)
> +		goto out;
> +
>  	if (flags & PERF_EF_UPDATE)
>  		i915_pmu_event_read(event);
>  	i915_pmu_disable(event);
> +
> +out:
>  	event->hw.state = PERF_HES_STOPPED;
>  }
>  
> -- 
> 2.38.1
