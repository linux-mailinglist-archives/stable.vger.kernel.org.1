Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809E875ED43
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGXIT7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGXIT5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 04:19:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1D131
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690186795; x=1721722795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vW4ze8oZKFb995ZUmc4ozXg5zKX+vuA/U5BVP8f2dbk=;
  b=fnVv57XPtenaERxOGHbT9NI65+oFo5mQHuscrFFCOSbXIMG5wSJZoFo5
   MliBp3KRuUp4C3oWUSmWdeG6oocBwW7Npd2mrVqu5UVf2daPCWEUGZ53G
   ZkjivImY3Jnt1zoaNQV6jSgdIaaB+ry11mubMUc7TlGCZo6mJNljqzgQt
   YcBrEjxMm7TAiwoWmzA69OhE61jmqhaKAY0BQDdWREI1+JdSPOo+ZB61r
   P1SHI+OFj8pXTEeOx5Wk6l7XAFCZi5PXNtrtlKGiWz6JoTU2Pv1m2h2WM
   iG+2ELgn52hF7qLsgXbh7sSVVow9sGeTBtCorYCGmhSNoMrY7q/fjMBMS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="367404735"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="367404735"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="675742972"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="675742972"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.14.115]) ([10.213.14.115])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:19:50 -0700
Message-ID: <3b7e1781-ca2b-44b3-846d-89e42f24106e@intel.com>
Date:   Mon, 24 Jul 2023 10:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v8 7/9] drm/i915/gt: Ensure memory quiesced before
 invalidation for all engines
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
 <20230721161514.818895-8-andi.shyti@linux.intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230721161514.818895-8-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 21.07.2023 18:15, Andi Shyti wrote:
> Commit af9e423a8aae ("drm/i915/gt: Ensure memory quiesced before
> invalidation") has made sure that the memory is quiesced before
> invalidating the AUX CCS table. Do it for all the other engines
> and not just RCS.
>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: <stable@vger.kernel.org> # v5.8+
> ---
>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 36 ++++++++++++++++--------
>   1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> index 5e19b45a5cabe..646151e1b5deb 100644
> --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> @@ -331,26 +331,40 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   int gen12_emit_flush_xcs(struct i915_request *rq, u32 mode)
>   {
>   	intel_engine_mask_t aux_inv = 0;
> -	u32 cmd, *cs;
> +	u32 cmd_flush = 0;
> +	u32 cmd = 4;
> +	u32 *cs;
>   
> -	cmd = 4;
> -	if (mode & EMIT_INVALIDATE) {
> +	if (mode & EMIT_INVALIDATE)
>   		cmd += 2;
>   
> -		if (gen12_needs_ccs_aux_inv(rq->engine) &&
> -		    (rq->engine->class == VIDEO_DECODE_CLASS ||
> -		     rq->engine->class == VIDEO_ENHANCEMENT_CLASS)) {
> -			aux_inv = rq->engine->mask &
> -				~GENMASK(_BCS(I915_MAX_BCS - 1), BCS0);
> -			if (aux_inv)
> -				cmd += 4;
> -		}
> +	if (gen12_needs_ccs_aux_inv(rq->engine))
> +		aux_inv = rq->engine->mask &
> +			  ~GENMASK(_BCS(I915_MAX_BCS - 1), BCS0);

Shouldn't we remove BCS check for MTL? And move it inside 
gen12_needs_ccs_aux_inv?
Btw aux_inv is used as bool, make better is to make it bool.

Regards
Andrzej
> +
> +	/*
> +	 * On Aux CCS platforms the invalidation of the Aux
> +	 * table requires quiescing memory traffic beforehand
> +	 */
> +	if (aux_inv) {
> +		cmd += 4; /* for the AUX invalidation */
> +		cmd += 2; /* for the engine quiescing */
> +
> +		cmd_flush = MI_FLUSH_DW;
> +
> +		if (rq->engine->class == COPY_ENGINE_CLASS)
> +			cmd_flush |= MI_FLUSH_DW_CCS;
>   	}
>   
>   	cs = intel_ring_begin(rq, cmd);
>   	if (IS_ERR(cs))
>   		return PTR_ERR(cs);
>   
> +	if (cmd_flush) {
> +		*cs++ = cmd_flush;
> +		*cs++ = 0;
> +	}
> +
>   	if (mode & EMIT_INVALIDATE)
>   		*cs++ = preparser_disable(true);
>   

