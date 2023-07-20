Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F81675AACD
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjGTJaM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGTJ3r (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 05:29:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E64EEF
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689844615; x=1721380615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mmeLamPM31NW+qzOU0sAArK2NpXVTLIB3CgRiTCwHhM=;
  b=D+0pzuvd3offwLBAXV0lz/mcPb64lIFLuoY5BPTH51vIxRmGF6YJI911
   afk33uEbm04D4lhVQngDMSRPtAUHF+7SkvBNefLzQBA77kELvpE2SlE8J
   deeF+4G8QtU0kTyUf1bTJoO7Vc7qz4VF3Ycq+BYQwZrJsRSRjHqqY77Hx
   B+fpxP8kF5gbSAxIOcNJKAcLdwpZHoZBjJlW0cyRLD9V+w+Xg9dWdfmZ7
   5iFVGPWg0joPqPDlqTXi7l0+8egRkJY8WL0YSITw1xUsZT70e30xW5/pp
   Txg+A00YIQt2oeJzqGJZLpaO7n/ZfWwlDPwhI+43Mdod4z1NO8VtYLo7p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="432879714"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="432879714"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="970982393"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="970982393"
Received: from ctuohy-mobl1.ger.corp.intel.com (HELO [10.213.193.21]) ([10.213.193.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:16:53 -0700
Message-ID: <46e2c9cc-bc9d-69cb-c40d-53a4012cf80c@linux.intel.com>
Date:   Thu, 20 Jul 2023 10:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/i915/dpt: Use shmem for dpt objects
Content-Language: en-US
To:     "Yang, Fei" <fei.yang@intel.com>,
        "Sripada, Radhakrishna" <radhakrishna.sripada@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Wilson, Chris P" <chris.p.wilson@intel.com>
References: <20230718225118.2562132-1-radhakrishna.sripada@intel.com>
 <37f64727-9bbd-c967-193c-97266dfc1331@linux.intel.com>
 <SN6PR11MB2574001C852621E0AFF4CF7F9A39A@SN6PR11MB2574.namprd11.prod.outlook.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <SN6PR11MB2574001C852621E0AFF4CF7F9A39A@SN6PR11MB2574.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 19/07/2023 21:53, Yang, Fei wrote:
>> On 18/07/2023 23:51, Radhakrishna Sripada wrote:
>>> Dpt objects that are created from internal get evicted when there is
>>> memory pressure and do not get restored when pinned during scanout.
>>> The pinned page table entries look corrupted and programming the
>>> display engine with the incorrect pte's result in DE throwing pipe faults.
>>>
>>> Create DPT objects from shmem and mark the object as dirty when
>>> pinning so that the object is restored when shrinker evicts an unpinned buffer object.
>>>
>>> v2: Unconditionally mark the dpt objects dirty during pinning(Chris).
>>>
>>> Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation
>>> for dpt")
>>> Cc: <stable@vger.kernel.org> # v6.0+
>>> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
>>> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>>> Suggested-by: Chris Wilson <chris.p.wilson@intel.com>
>>> Signed-off-by: Fei Yang <fei.yang@intel.com>
>>> Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
>>> ---
>>>    drivers/gpu/drm/i915/display/intel_dpt.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_dpt.c
>>> b/drivers/gpu/drm/i915/display/intel_dpt.c
>>> index 7c5fddb203ba..fbfd8f959f17 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_dpt.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_dpt.c
>>> @@ -166,6 +166,8 @@ struct i915_vma *intel_dpt_pin(struct i915_address_space *vm)
>>>               i915_vma_get(vma);
>>>       }
>>>
>>> +    dpt->obj->mm.dirty = true;
>>> +
>>>       atomic_dec(&i915->gpu_error.pending_fb_pin);
>>>       intel_runtime_pm_put(&i915->runtime_pm, wakeref);
>>>
>>> @@ -261,7 +263,7 @@ intel_dpt_create(struct intel_framebuffer *fb)
>>>               dpt_obj = i915_gem_object_create_stolen(i915, size);
>>>       if (IS_ERR(dpt_obj) && !HAS_LMEM(i915)) {
>>>               drm_dbg_kms(&i915->drm, "Allocating dpt from smem\n");
>>> -            dpt_obj = i915_gem_object_create_internal(i915, size);
>>> +            dpt_obj = i915_gem_object_create_shmem(i915, size);
>>>       }
>>>       if (IS_ERR(dpt_obj))
>>>               return ERR_CAST(dpt_obj);
>>
>> Okay I think I get it after some more looking at the DPT code paths.
>> Problem seems pretty clear - page tables are stored in dpt_obj and so
>> are lost when backing store is discarded.
>>
>> Changing to shmem object indeed looks the easiest option.
>>
>> Some related thoughts:
>>
>> 1)
>> I wonder if intel_dpt_suspend/resume remain needed after this patch.
>> Could you investigate please? On a glance their job was to restore the
>> PTEs which would be lost from internal objects backing storage. With
>> shmem objects that content should be preserved.
> 
> intel_dpt_suspend is "suspending" the whole VM where, not only the dpt
> objects are mapped into, but also the framebuffer objects. I don't have
> much knowledge on how the framebuffer objects are managed, but the suspend
> resume path still look necessary to me, unless the content of these
> framebuffer objects are also preserved.

I don't think it has anything to do with fb content, but you are correct 
it is still needed. Because 9755f055f512 ("drm/i915: Restore memory 
mapping for DPT FBs across system suspend/resume") reminds me backing 
store for DPT PTEs can be either lmem, stolen or internal (now shmem). 
Even though with this patch internal is out of the picture, stolen 
remains and so the issue of losing the page table content remains. 
Perhaps resume could be optimised to only restore PTEs when VM page 
tables are backed by stolen which may win some suspend/resume speed on 
some platforms.

Regards,

Tvrtko

> 
>> 2)
>> I wonder if i915_vma_flush_writes should be used (as a companion of
>> i915_vma_pin_iomap) from DPT dpt_bind_vma, dpt_insert_entries, etc. But
>> then I am also not sure if it does the right thing for the
>> i915_gem_object_pin_map path of i915_vma_pin_iomap. Perhaps it should
>> call __i915_gem_object_flush_map itself for that mapping flavour and
>> not do the ggtt flushing in that case.
>>
>> In summary I think the fix is safe and correct but at least point 1) I
>> think needs looking into. It can be a follow up work too.
>>
>> Regards,
>>
>> Tvrtko
>>
