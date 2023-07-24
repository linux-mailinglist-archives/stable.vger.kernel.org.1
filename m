Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81D875ECED
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjGXH5W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGXH4v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 03:56:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8701716
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690185370; x=1721721370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9MYGepOmucZkFKKawDLrW6irF0O4CITjlV6O/LiLNZw=;
  b=Pk9dw8hWJ8M+j7wjpkiy5IbMhtJYQUSL+7CAR/bKf1u7HXahJGT9L/53
   lUqryQujUV4BCRaPCowdhmFudfvH502JqAQ4RorfAL12XJdMwd1nk+4Fj
   dO5901TQBBnSuwgr8kPVVg20kT9ltIRT0DHwsxnwLKEDb63wW9NrQ1NVt
   kapi8YaBaH64G0hbc7fYFXSV2fQQMHbMCW/Lgx0pWJVqv4tRxY7oX7jS3
   ALh8/oAo1KgrOBsBNfJUsLEIKjQ+UBqFnTLu+KMGaCF0bHWG0cEarPVhD
   idcBEPcRK5Z5+b6u2/2vNG/jM+cuOhOuxlW7Kri+l7FpXmqn0ISPqCnek
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="352273834"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="352273834"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 00:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="725603352"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="725603352"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.14.115]) ([10.213.14.115])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 00:54:56 -0700
Message-ID: <446e7f3b-3e85-9d27-c8c2-4a1c105a280a@intel.com>
Date:   Mon, 24 Jul 2023 09:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v8 6/9] drm/i915/gt: Refactor intel_emit_pipe_control_cs()
 in a single function
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-evel <dri-devel@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>
References: <20230721161514.818895-1-andi.shyti@linux.intel.com>
 <20230721161514.818895-7-andi.shyti@linux.intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230721161514.818895-7-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 21.07.2023 18:15, Andi Shyti wrote:
> Just a trivial refactoring for reducing the number of code
> duplicate. This will come at handy in the next commits.
>
> Meantime, propagate the error to the above layers if we fail to
> emit the pipe control.
>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.8+

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

> ---
>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 47 +++++++++++++-----------
>   1 file changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> index 139a7e69f5c4d..5e19b45a5cabe 100644
> --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> @@ -7,6 +7,7 @@
>   #include "i915_drv.h"
>   #include "intel_engine_regs.h"
>   #include "intel_gpu_commands.h"
> +#include "intel_gt_print.h"
>   #include "intel_lrc.h"
>   #include "intel_ring.h"
>   
> @@ -189,23 +190,30 @@ u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv
>   	return cs;
>   }
>   
> +static int gen12_emit_pipe_control_cs(struct i915_request *rq, u32 bit_group_0,
> +				      u32 bit_group_1, u32 offset)
> +{
> +	u32 *cs;
> +
> +	cs = intel_ring_begin(rq, 6);
> +	if (IS_ERR(cs))
> +		return PTR_ERR(cs);
> +
> +	cs = gen12_emit_pipe_control(cs, bit_group_0, bit_group_1,
> +				     LRC_PPHWSP_SCRATCH_ADDR);
> +	intel_ring_advance(rq, cs);
> +
> +	return 0;
> +}
> +
>   static int mtl_dummy_pipe_control(struct i915_request *rq)
>   {
>   	/* Wa_14016712196 */
>   	if (IS_MTL_GRAPHICS_STEP(rq->engine->i915, M, STEP_A0, STEP_B0) ||
> -	    IS_MTL_GRAPHICS_STEP(rq->engine->i915, P, STEP_A0, STEP_B0)) {
> -		u32 *cs;
> -
> -		/* dummy PIPE_CONTROL + depth flush */
> -		cs = intel_ring_begin(rq, 6);
> -		if (IS_ERR(cs))
> -			return PTR_ERR(cs);
> -		cs = gen12_emit_pipe_control(cs,
> -					     0,
> -					     PIPE_CONTROL_DEPTH_CACHE_FLUSH,
> -					     LRC_PPHWSP_SCRATCH_ADDR);
> -		intel_ring_advance(rq, cs);
> -	}
> +	    IS_MTL_GRAPHICS_STEP(rq->engine->i915, P, STEP_A0, STEP_B0))
> +		return gen12_emit_pipe_control_cs(rq, 0,
> +					PIPE_CONTROL_DEPTH_CACHE_FLUSH,
> +					LRC_PPHWSP_SCRATCH_ADDR);
>   
>   	return 0;
>   }
> @@ -222,7 +230,6 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   		u32 bit_group_0 = 0;
>   		u32 bit_group_1 = 0;
>   		int err;
> -		u32 *cs;
>   
>   		err = mtl_dummy_pipe_control(rq);
>   		if (err)
> @@ -256,13 +263,11 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   		else if (engine->class == COMPUTE_CLASS)
>   			bit_group_1 &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
>   
> -		cs = intel_ring_begin(rq, 6);
> -		if (IS_ERR(cs))
> -			return PTR_ERR(cs);
> -
> -		cs = gen12_emit_pipe_control(cs, bit_group_0, bit_group_1,
> -					     LRC_PPHWSP_SCRATCH_ADDR);
> -		intel_ring_advance(rq, cs);
> +		err = gen12_emit_pipe_control_cs(rq, bit_group_0, bit_group_1,
> +						 LRC_PPHWSP_SCRATCH_ADDR);
> +		if (err)
> +			gt_warn(engine->gt,
> +				"Failed to emit flush pipe control\n");
>   	}
>   
>   	if (mode & EMIT_INVALIDATE) {

