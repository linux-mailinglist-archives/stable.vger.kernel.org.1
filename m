Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6433D75C411
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGUKK7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGUKK4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 06:10:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B552C2727
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934254; x=1721470254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DlNLP5+kQ2gtILG4UU0QlUbPl4G2stOHE1ua4oEL7vg=;
  b=kbLL3DTd6ngdn+95Vlg4jEJyCcuehvkkyXi0+561yqiI3XK9gh7+NMOU
   PB1k0UQ+p/E8pMQc8mx2FHVfMEg5i1NgC5UemFrGU/KeJbEmQQ/5saq/C
   6X3AaVbFogBPBjMZkz79VM0ofnTcK68ogAhSRCvvPX2ucrHPKDHUiKe/S
   eKp7Qs/1Gi4wELJQv3oSca0OqbXfDXvhXBSpiUoGj/rUNQEARZwBg8eSy
   OGXvoiIO/EncusKVp5vdZhW1zmh7Ote06CzlhLJSsHaJwkPlYHRo2xUu5
   M0qGDw5BZIV8gkvej52S2VLhtc/SpOs3nkPyhWowEBQx6r+j5A1XkKeWZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351869776"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="351869776"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="728055351"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="728055351"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.21.56]) ([10.213.21.56])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:10:50 -0700
Message-ID: <1cb56f45-cb68-82f2-dc43-b4706b2e12c1@intel.com>
Date:   Fri, 21 Jul 2023 12:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [Intel-gfx] [PATCH v7 6/9] drm/i915/gt: Refactor
 intel_emit_pipe_control_cs() in a single function
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        dri-evel <dri-devel@lists.freedesktop.org>
References: <20230720210737.761400-1-andi.shyti@linux.intel.com>
 <20230720210737.761400-7-andi.shyti@linux.intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230720210737.761400-7-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 20.07.2023 23:07, Andi Shyti wrote:
> Just a trivial refactoring for reducing the number of code
> duplicate. This will come at handy in the next commits.
> 
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.8+
> ---
>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 44 +++++++++++++-----------
>   1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> index 9d050b9a19194..202d6ff8b5264 100644
> --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> @@ -177,23 +177,31 @@ u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv
>   	return cs;
>   }
>   
> +static u32 *intel_emit_pipe_control_cs(struct i915_request *rq, u32 bit_group_0,
> +				       u32 bit_group_1, u32 offset)


s/intel/gen12/

but this and few other issues were raised already by Matt in v6.

Regards
Andrzej

> +{
> +	u32 *cs;
> +
> +	cs = intel_ring_begin(rq, 6);
> +	if (IS_ERR(cs))
> +		return cs;
> +
> +	cs = gen12_emit_pipe_control(cs, bit_group_0, bit_group_1,
> +				     LRC_PPHWSP_SCRATCH_ADDR);
> +	intel_ring_advance(rq, cs);
> +
> +	return cs;
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
> +		intel_emit_pipe_control_cs(rq,
> +					   0,
> +					   PIPE_CONTROL_DEPTH_CACHE_FLUSH,
> +					   LRC_PPHWSP_SCRATCH_ADDR);
>   
>   	return 0;
>   }
> @@ -210,7 +218,6 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   		u32 bit_group_0 = 0;
>   		u32 bit_group_1 = 0;
>   		int err;
> -		u32 *cs;
>   
>   		err = mtl_dummy_pipe_control(rq);
>   		if (err)
> @@ -244,13 +251,8 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
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
> +		intel_emit_pipe_control_cs(rq, bit_group_0, bit_group_1,
> +					   LRC_PPHWSP_SCRATCH_ADDR);
>   	}
>   
>   	if (mode & EMIT_INVALIDATE) {

