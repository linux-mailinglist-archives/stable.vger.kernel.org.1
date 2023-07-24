Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE6175ECC5
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGXHw6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjGXHww (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 03:52:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE841A3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690185171; x=1721721171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=18HrS3rmE0LhoroiohHtBYV8bIE2JHOhM3MwP5aRQ30=;
  b=VdfjLFJ59i6tjuBxd/Rzg27Fm45bJ0Q4TxitUImDtTE+UaVoCOli0qS3
   ty6szC0aMdagWdDZ+WQbagnZd6mOzM0EDIWIhzJt6QvnlGYViHHkGxmYa
   nAqiLOBGrKLLJtRwpb+tn5VBnQGV3SW0Jn/mvktlt+OmrN2HNJeTR8fqA
   w9pBxHHohGUeYjNfLQpMD2ABzh+8TxOY+xiHwBLSyf7y30VVowB57GmiT
   wGkimyONLOJWJ+22sggUSG3ZCbS0SNgJQKtfKU/4WfpmDLXiCjaInRlQt
   YQXR+h8sJpx1X6PZDGSlnGcz+yeWIjPTCRoVtWp9gVYdAWFFHVz1Nqknt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="352273396"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="352273396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 00:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="790878313"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790878313"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.14.115]) ([10.213.14.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 00:52:46 -0700
Message-ID: <5db69384-06bc-6ec5-ced7-d5c5245a03c5@intel.com>
Date:   Mon, 24 Jul 2023 09:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v8 2/9] drm/i915: Add the gen12_needs_ccs_aux_inv helper
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
 <20230721161514.818895-3-andi.shyti@linux.intel.com>
Content-Language: en-US
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230721161514.818895-3-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 21.07.2023 18:15, Andi Shyti wrote:
> We always assumed that a device might either have AUX or FLAT
> CCS, but this is an approximation that is not always true, e.g.
> PVC represents an exception.
>
> Set the basis for future finer selection by implementing a
> boolean gen12_needs_ccs_aux_inv() function that tells whether aux
> invalidation is needed or not.
>
> Currently PVC is the only exception to the above mentioned rule.
>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: <stable@vger.kernel.org> # v5.8+


Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej
> ---
>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> index 563efee055602..460c9225a50fc 100644
> --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> @@ -165,6 +165,18 @@ static u32 preparser_disable(bool state)
>   	return MI_ARB_CHECK | 1 << 8 | state;
>   }
>   
> +static bool gen12_needs_ccs_aux_inv(struct intel_engine_cs *engine)
> +{
> +	if (IS_PONTEVECCHIO(engine->i915))
> +		return false;
> +
> +	/*
> +	 * so far platforms supported by i915 having
> +	 * flat ccs do not require AUX invalidation
> +	 */
> +	return !HAS_FLAT_CCS(engine->i915);
> +}
> +
>   u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv_reg)
>   {
>   	u32 gsi_offset = gt->uncore->gsi_offset;
> @@ -267,7 +279,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   		else if (engine->class == COMPUTE_CLASS)
>   			flags &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
>   
> -		if (!HAS_FLAT_CCS(rq->engine->i915))
> +		if (gen12_needs_ccs_aux_inv(rq->engine))
>   			count = 8 + 4;
>   		else
>   			count = 8;
> @@ -285,7 +297,7 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   
>   		cs = gen8_emit_pipe_control(cs, flags, LRC_PPHWSP_SCRATCH_ADDR);
>   
> -		if (!HAS_FLAT_CCS(rq->engine->i915)) {
> +		if (gen12_needs_ccs_aux_inv(rq->engine)) {
>   			/* hsdes: 1809175790 */
>   			cs = gen12_emit_aux_table_inv(rq->engine->gt, cs,
>   						      GEN12_CCS_AUX_INV);
> @@ -307,7 +319,7 @@ int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
>   	if (mode & EMIT_INVALIDATE) {
>   		cmd += 2;
>   
> -		if (!HAS_FLAT_CCS(rq->engine->i915) &&
> +		if (gen12_needs_ccs_aux_inv(rq->engine) &&
>   		    (rq->engine->class == VIDEO_DECODE_CLASS ||
>   		     rq->engine->class == VIDEO_ENHANCEMENT_CLASS)) {
>   			aux_inv = rq->engine->mask &

