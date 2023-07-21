Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD3675C3FC
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 12:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGUKFR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 06:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGUKFQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 06:05:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34534FC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689933916; x=1721469916;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4XWxDZFFegYToyIqIZf3bURRTc6vrm0v/unHyieLdFE=;
  b=J4QYomkFxwXaLC8K7Wd9ZMEAHSbnJ8I0J4S1rW4kcCR8a75AfldGBYOG
   5RPihoJvhWJ8LwFIzDg7XHqbdauJvAJEC0jBb/bCQ+JP0klj+ZKuXYBls
   S7qvC4eRfP6bWg3iowVfh08wQbwonWvAXixsOHB2IsHHhsaG+/O4a6jhx
   8BBEpWlgJKCZvHyaHBItxjXryu17lW7B+kwYzOhjBmP87Kf4ufhv09t15
   rND3IUEI/laxrLtnZYZhCOJsCu/Z3nOf6oYxWNQaWvnTJHtpFzB06arb5
   DMhzOIREZvtP03n3Bk906NupPysNemGHmFnf38p8MfWqphJCLlGlfnsDx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346580383"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346580383"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="754407158"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="754407158"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.21.56]) ([10.213.21.56])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:05:13 -0700
Message-ID: <0dc607fc-33ac-cebd-9303-873711dcc5d0@intel.com>
Date:   Fri, 21 Jul 2023 12:05:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [Intel-gfx] [PATCH v7 5/9] drm/i915/gt: Enable the CCS_FLUSH bit
 in the pipe control
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
 <20230720210737.761400-6-andi.shyti@linux.intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230720210737.761400-6-andi.shyti@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 20.07.2023 23:07, Andi Shyti wrote:
> Enable the CCS_FLUSH bit 13 in the control pipe for render and
> compute engines in platforms starting from Meteor Lake (BSPEC
> 43904 and 47112).
> 
> Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: <stable@vger.kernel.org> # v5.8+
> ---
>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c     | 7 +++++++
>   drivers/gpu/drm/i915/gt/intel_gpu_commands.h | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> index 7566c89d9def3..9d050b9a19194 100644
> --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> @@ -218,6 +218,13 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   
>   		bit_group_0 |= PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
>   
> +		/*
> +		 * When required, in MTL+ platforms we need to
> +		 * set the CCS_FLUSH bit in the pipe control
> +		 */
> +		if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
> +			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;


BSpec 43904 mentions also other platforms. Why only MTL+?


Regards
Andrzej


> +
>   		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
>   		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
>   		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
> diff --git a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
> index 5d143e2a8db03..5df7cce23197c 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
> @@ -299,6 +299,7 @@
>   #define   PIPE_CONTROL_QW_WRITE				(1<<14)
>   #define   PIPE_CONTROL_POST_SYNC_OP_MASK                (3<<14)
>   #define   PIPE_CONTROL_DEPTH_STALL			(1<<13)
> +#define   PIPE_CONTROL_CCS_FLUSH			(1<<13) /* MTL+ */
>   #define   PIPE_CONTROL_WRITE_FLUSH			(1<<12)
>   #define   PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH	(1<<12) /* gen6+ */
>   #define   PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE	(1<<11) /* MBZ on ILK */

