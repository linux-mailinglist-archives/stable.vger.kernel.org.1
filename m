Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74687A7A3E
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjITLSz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjITLSz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:18:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54438A1
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695208729; x=1726744729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V/blwaER0AEA6MQ0muNozilAvVoc4x9ou18moN7caUY=;
  b=CH7/c/KhYcm5ry1nevrTPEkkJxjVM7oGsFU2oUpKnFqqZee9yDm5Pgda
   FqD1qRlMKZyjpwuRw70o01sFDWwEIi283jQ14/4sGOaDARxTFx1Kw0K8j
   xjXKEaaGO8GOX2vdY6btVrHTylAGnPa9REJsKBTTxrlefFtPQFxt3hlI5
   deHuA0364qRC8xm2CfRfYvUusrJgF/ss6T5eUS+6P1Cjk5NE/H/JxwmjH
   LTTUsyYsokgNkrsOXRKH5ljKujG7xCaNHeUy3d0wr1XNCzIhX0KDjTzQ4
   JfgU5vxwhXAK+3TxhY5o9yBVaGDpLKOkAXWTW3KL3RRfs8ZW32hcjr2ML
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="446662747"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="446662747"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 04:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746604130"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="746604130"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.252.39.128]) ([10.252.39.128])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 04:18:46 -0700
Message-ID: <5ff2eb37-fa7b-84a5-4354-7e1b54dba907@linux.intel.com>
Date:   Wed, 20 Sep 2023 13:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/i915: Fix aux invalidation with proper pipe_control
 flag
Content-Language: en-US
To:     =?UTF-8?Q?Tapani_P=c3=a4lli?= <tapani.palli@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
References: <20230919114716.19378-1-nirmoy.das@intel.com>
 <ZQmP+IWIcu1yUkSC@ashyti-mobl2.lan>
 <aa102a2e-0b73-9f1b-8fcf-75eb5b741d03@intel.com>
From:   Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <aa102a2e-0b73-9f1b-8fcf-75eb5b741d03@intel.com>
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

Sent out https://patchwork.freedesktop.org/series/123975/

to replace this one as this not really fixing the issue.


Thanks,

Nirmoy

On 9/19/2023 2:19 PM, Tapani Pälli wrote:
>
> On 19.9.2023 15.11, Andi Shyti wrote:
>> Hi Nirmoy,
>>
>> On Tue, Sep 19, 2023 at 01:47:16PM +0200, Nirmoy Das wrote:
>>> The suggestion from the spec is to do l3 fabric flush not L3 flush.
>>>
>>> Fixes: 78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before
>>> invalidation")
>> please put this in one line.
>>
>>> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
>>> Cc: Andi Shyti <andi.shyti@linux.intel.com>
>>> Cc: <stable@vger.kernel.org> # v5.8+
>>> Cc: Nirmoy Das <nirmoy.das@intel.com>
>>> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
>>> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>> Cc: Matt Roper <matthew.d.roper@intel.com>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
>>> Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
>>
>> and I believe
>>
>> Tested-by: Tapani Pälli <tapani.palli@intel.com>
>
> Yes, tested on TGL LP (0x9a49)!
>
>
>> Thanks,
>> Andi
