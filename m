Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F47E7B1879
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjI1Kp7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjI1Kp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 06:45:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE9F195
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695897956; x=1727433956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4prNF3X8A5NF7Bh1dtvKt/RzHBfy/h58HJm97GxQ0Vk=;
  b=HN/TMUkA/LglMOG5nk1dCFDs0B+AGyeaJH+X/+pahLNR/ysHZ4kWGprK
   SgMbwRavcUR6ZwNNdfjdCNJ6hyp1yVScuouOwPPVZZRg4IPF9CdwC5wem
   C+ObEeHeVwA9dZjoB8offWob87uSc0NIb/p9stZCkAeNVS/ESQCY9/T/N
   VuYxH+OiVuWs4W5iCgvnelXH9O0ewjft7yVNBinnyRtMxaW5dThxVsZ7p
   H2fwVG5uToZ2OHRNqrQdp7YdY2vAKDGUp1owG31OoFNXzJycIhrVyrky5
   kuHtDHpOMKPV2KbY7cXT/e04WjQnxzEdvbsOCwvsKWZormvf+o9IkFF0r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="637838"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="637838"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 03:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="839807147"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="839807147"
Received: from haykharx-mobl1.ger.corp.intel.com (HELO [10.249.33.32]) ([10.249.33.32])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 03:45:52 -0700
Message-ID: <b0b2019b-3a0f-7204-5f5f-556df12776d8@linux.intel.com>
Date:   Thu, 28 Sep 2023 12:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval
Content-Language: en-US
To:     Nirmoy Das <nirmoy.das@intel.com>, intel-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Tapani_P=c3=a4lli?= <tapani.palli@intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        Mark Janes <mark.janes@intel.com>
References: <20230926142401.25687-1-nirmoy.das@intel.com>
 <f2bbf2f2-a966-d128-93b5-d3d58ea9b1dc@intel.com>
From:   Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <f2bbf2f2-a966-d128-93b5-d3d58ea9b1dc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Tapani,

On 9/27/2023 6:13 AM, Tapani Pälli wrote:
> Fixes all regressions we saw, I also run some extra vulkan and GL 
> workloads, no regressions observed.
>
> Tested-by: Tapani Pälli <tapani.palli@intel.com>


Thanks to testing it. The patch is now merged with" 
<stable@vger.kernel.org> # v5.8+" tag so it should trickle down to

v6.4.10. as normal stable release process.


Thanks,

Nirmoy

>
> On 26.9.2023 17.24, Nirmoy Das wrote:
>> PIPE_CONTROL_FLUSH_L3 is not needed for aux invalidation
>> so don't set that.
>>
>> Fixes: 78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before 
>> invalidation")
>> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
>> Cc: Andi Shyti <andi.shyti@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # v5.8+
>> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
>> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>> Cc: Matt Roper <matthew.d.roper@intel.com>
>> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
>> Cc: Tapani Pälli <tapani.palli@intel.com>
>> Cc: Mark Janes <mark.janes@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> ---
>>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c 
>> b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
>> index 0143445dba83..ba4c2422b340 100644
>> --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
>> +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
>> @@ -271,8 +271,17 @@ int gen12_emit_flush_rcs(struct i915_request 
>> *rq, u32 mode)
>>           if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
>>               bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
>>   +        /*
>> +         * L3 fabric flush is needed for AUX CCS invalidation
>> +         * which happens as part of pipe-control so we can
>> +         * ignore PIPE_CONTROL_FLUSH_L3. Also PIPE_CONTROL_FLUSH_L3
>> +         * deals with Protected Memory which is not needed for
>> +         * AUX CCS invalidation and lead to unwanted side effects.
>> +         */
>> +        if (mode & EMIT_FLUSH)
>> +            bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
>> +
>>           bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
>> -        bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
>>           bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
>>           bit_group_1 |= PIPE_CONTROL_DEPTH_CACHE_FLUSH;
>>           /* Wa_1409600907:tgl,adl-p */
