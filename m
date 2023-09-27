Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A067AFA6D
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 07:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjI0FzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 01:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjI0Fyz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 01:54:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8529DCE6
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 22:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695793688; x=1727329688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WV2GT3MqmgvkaeOdGho0FQtzlWzULGvrDmyXN059hgU=;
  b=TpjPXIw9Rkrk6tCfkcrCHqXDbbsyWbyhFIFalEnJWC9PBoPfBW/bqxjA
   eP/Or7kJv1P615gg598hYjsY5VKn3mms38ZTMJ5EGq75O4n6QP9fUnI5q
   aN5F7qtuapHISbVDTL8QojtPc3ZhS0puTA9slXcJRV3EEokZH5mvTj96l
   jKN47gfhUqWgMPyQq9T4akzyjMvAvDQbz1qY/S1KuReJklLlNOH3vwAoO
   oyIaw5ib/NFqhAYg9Fky+tvWbyk2FiWpG+6cezbG94jo0Xgktr7ErQObC
   MW2VbrGf2gPX2PVqHejo8Q/HUQnP1oRCWkVUX3iXuWERrCn30YXvHhOCF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="468023394"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="468023394"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 22:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="742591810"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="742591810"
Received: from jchodor-mobl2.ger.corp.intel.com (HELO [10.213.23.248]) ([10.213.23.248])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 22:48:03 -0700
Message-ID: <af8f0c44-7f4a-f1f7-cd4a-6cae3ea477cc@intel.com>
Date:   Wed, 27 Sep 2023 07:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval
Content-Language: en-US
To:     Nirmoy Das <nirmoy.das@intel.com>, intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        stable@vger.kernel.org, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        =?UTF-8?Q?Tapani_P=c3=a4lli?= <tapani.palli@intel.com>,
        Mark Janes <mark.janes@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20230926142401.25687-1-nirmoy.das@intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230926142401.25687-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 26.09.2023 16:24, Nirmoy Das wrote:
> PIPE_CONTROL_FLUSH_L3 is not needed for aux invalidation
> so don't set that.
>
> Fixes: 78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before invalidation")
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.8+
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
> Cc: Tapani Pälli <tapani.palli@intel.com>
> Cc: Mark Janes <mark.janes@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej
> ---
>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> index 0143445dba83..ba4c2422b340 100644
> --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> @@ -271,8 +271,17 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
>   		if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
>   			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
>   
> +		/*
> +		 * L3 fabric flush is needed for AUX CCS invalidation
> +		 * which happens as part of pipe-control so we can
> +		 * ignore PIPE_CONTROL_FLUSH_L3. Also PIPE_CONTROL_FLUSH_L3
> +		 * deals with Protected Memory which is not needed for
> +		 * AUX CCS invalidation and lead to unwanted side effects.
> +		 */
> +		if (mode & EMIT_FLUSH)
> +			bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
> +
>   		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
> -		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
>   		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
>   		bit_group_1 |= PIPE_CONTROL_DEPTH_CACHE_FLUSH;
>   		/* Wa_1409600907:tgl,adl-p */

