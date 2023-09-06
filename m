Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ACF79419B
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 18:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjIFQm2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjIFQm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 12:42:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6484E1738
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694018543; x=1725554543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lq9JxCC3N2Aa9e4dE3C2xEN+ZoVsurQrfd8clRwArCw=;
  b=aCUPEAd+urI0UneOB5QbXc3IhwL3eEo+iDJy+2TEz0PFppjOnSXTvXHt
   +SZY4WJsGRjylCFtqhikijYSJaWlIlsl96Vzu1Pu9WBQ+0pSkgnPhqUKk
   CFIW1yi0j/Uye1wQijM7yO1kxJk2/kyiUVFwWC/I00D9DyxKJm2u+6mhc
   y0VSMnXouNnx2D74lIaz/627Yr7lEOLWDL1hlkDTJkIGyNlLK+6YYW+mL
   zEkUupUbl8rdllrfM/izSHCWQkI0gY8HM+aIgacftDNZpjfGGtZfxUQ56
   bTMdSp9WSpEmVey7cJZrX2ogULerjV4eabR/mz4fEfwzUoxfOU4HLSzyY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="379829159"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="379829159"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 09:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="915359389"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="915359389"
Received: from yjie-desk1.jf.intel.com (HELO [10.24.100.126]) ([10.24.100.126])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 09:42:22 -0700
Message-ID: <0fbee35a-f1a0-0dc7-b321-d3b90b57244c@linux.intel.com>
Date:   Wed, 6 Sep 2023 09:42:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] cpufreq: intel_pstate: set stale CPU frequency to minimum
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Doug Smythies <dsmythies@telus.net>, stable@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230906001646.338935-1-yang.jie@linux.intel.com>
 <2023090607-virus-earshot-268d@gregkh>
Content-Language: en-US
From:   Keyon Jie <yang.jie@linux.intel.com>
In-Reply-To: <2023090607-virus-earshot-268d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 9/6/23 01:38, Greg Kroah-Hartman wrote:
> On Tue, Sep 05, 2023 at 05:16:46PM -0700, Keyon Jie wrote:
>> From: Doug Smythies <dsmythies@telus.net>
>>
>> commit d51847acb018d83186e4af67bc93f9a00a8644f7 upstream.
>>
>> This fix applies to all stable kernel versions 5.18+.
>>
>> The intel_pstate CPU frequency scaling driver does not
>> use policy->cur and it is 0.
>> When the CPU frequency is outdated arch_freq_get_on_cpu()
>> will default to the nominal clock frequency when its call to
>> cpufreq_quick_getpolicy_cur returns the never updated 0.
>> Thus, the listed frequency might be outside of currently
>> set limits. Some users are complaining about the high
>> reported frequency, albeit stale, when their system is
>> idle and/or it is above the reduced maximum they have set.
>>
>> This patch will maintain policy_cur for the intel_pstate
>> driver at the current minimum CPU frequency.
>>
>> Reported-by: Yang Jie <yang.jie@linux.intel.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>> [ rjw: White space damage fixes and comment adjustment ]
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
>> ---
>>   drivers/cpufreq/intel_pstate.c | 5 +++++
>>   1 file changed, 5 insertions(+)
> 
> What stable kernel(s) is this for?

Sorry missed it. We need it for all 5.18+ kernel, but I have only 
verified it on linux-6.1.y.

Thanks,
~Keyon
