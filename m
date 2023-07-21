Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94275C127
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 10:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjGUIRd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 04:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjGUIRc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 04:17:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061EE2707
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689927450; x=1721463450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NTxbVFl37wxgOo9MgeuyCM7yZjA+5P+LDOd6KSpqgBo=;
  b=EHCkljU5wiGXFAYfCzJBckbC4yqTWoKl9fPbnV8qo7xllXa1tuhDa2dD
   mdgdVh0ADh6/u4bkxDepAKav0yTcSSJebwbb1ZbLPLDe5mSR6A+aqcu/K
   aZDqOFUQ9Wcr2bbCWXmmiwvOjRLpkkUouSCy2y8wgzQoq8cpAuatWhyre
   lNOe1v4l1RLVOQI6TGiD7Us59rOmKKDsrZ8pM6Rro99TB35bQmob4WPi/
   UqcPNZ2vYQx5SYTU0dbbad47RR9izYunn6cf5gHiPhTZUhxBUX0jNHCTu
   6iKmmNFD1HmpP+24rZ6wSMtKK3qU7aC3qB0S98QnKWzUwtcts29pKmnoj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397857189"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="397857189"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 01:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="790115397"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="790115397"
Received: from sahilama-mobl1.ger.corp.intel.com (HELO [10.213.213.22]) ([10.213.213.22])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 01:17:15 -0700
Message-ID: <3f5d4b87-16fe-11e3-a4b3-f14aa2a0b67a@linux.intel.com>
Date:   Fri, 21 Jul 2023 09:17:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/i915/dpt: Use shmem for dpt objects
Content-Language: en-US
To:     "Sripada, Radhakrishna" <radhakrishna.sripada@intel.com>,
        "Yang, Fei" <fei.yang@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Wilson, Chris P" <chris.p.wilson@intel.com>
References: <20230718225118.2562132-1-radhakrishna.sripada@intel.com>
 <37f64727-9bbd-c967-193c-97266dfc1331@linux.intel.com>
 <SN6PR11MB2574001C852621E0AFF4CF7F9A39A@SN6PR11MB2574.namprd11.prod.outlook.com>
 <46e2c9cc-bc9d-69cb-c40d-53a4012cf80c@linux.intel.com>
 <DM4PR11MB59711839F6735AB3330B226B873EA@DM4PR11MB5971.namprd11.prod.outlook.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <DM4PR11MB59711839F6735AB3330B226B873EA@DM4PR11MB5971.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 20/07/2023 18:02, Sripada, Radhakrishna wrote:
> Hi Tvrtko,
> 
>> -----Original Message-----
>> From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>> Sent: Thursday, July 20, 2023 2:17 AM
>> To: Yang, Fei <fei.yang@intel.com>; Sripada, Radhakrishna
>> <radhakrishna.sripada@intel.com>; intel-gfx@lists.freedesktop.org
>> Cc: stable@vger.kernel.org; Ville Syrjälä <ville.syrjala@linux.intel.com>; Wilson,
>> Chris P <chris.p.wilson@intel.com>
>> Subject: Re: [PATCH v2] drm/i915/dpt: Use shmem for dpt objects
>>
>>
>> On 19/07/2023 21:53, Yang, Fei wrote:
>>>> On 18/07/2023 23:51, Radhakrishna Sripada wrote:
>>>>> Dpt objects that are created from internal get evicted when there is
>>>>> memory pressure and do not get restored when pinned during scanout.
>>>>> The pinned page table entries look corrupted and programming the
>>>>> display engine with the incorrect pte's result in DE throwing pipe faults.
>>>>>
>>>>> Create DPT objects from shmem and mark the object as dirty when
>>>>> pinning so that the object is restored when shrinker evicts an unpinned
>> buffer object.
>>>>>
>>>>> v2: Unconditionally mark the dpt objects dirty during pinning(Chris).
>>>>>
>>>>> Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation
>>>>> for dpt")
>>>>> Cc: <stable@vger.kernel.org> # v6.0+
>>>>> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
>>>>> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>>>>> Suggested-by: Chris Wilson <chris.p.wilson@intel.com>
>>>>> Signed-off-by: Fei Yang <fei.yang@intel.com>
>>>>> Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
>>>>> ---
>>>>>     drivers/gpu/drm/i915/display/intel_dpt.c | 4 +++-
>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/display/intel_dpt.c
>>>>> b/drivers/gpu/drm/i915/display/intel_dpt.c
>>>>> index 7c5fddb203ba..fbfd8f959f17 100644
>>>>> --- a/drivers/gpu/drm/i915/display/intel_dpt.c
>>>>> +++ b/drivers/gpu/drm/i915/display/intel_dpt.c
>>>>> @@ -166,6 +166,8 @@ struct i915_vma *intel_dpt_pin(struct
>> i915_address_space *vm)
>>>>>                i915_vma_get(vma);
>>>>>        }
>>>>>
>>>>> +    dpt->obj->mm.dirty = true;
>>>>> +
>>>>>        atomic_dec(&i915->gpu_error.pending_fb_pin);
>>>>>        intel_runtime_pm_put(&i915->runtime_pm, wakeref);
>>>>>
>>>>> @@ -261,7 +263,7 @@ intel_dpt_create(struct intel_framebuffer *fb)
>>>>>                dpt_obj = i915_gem_object_create_stolen(i915, size);
>>>>>        if (IS_ERR(dpt_obj) && !HAS_LMEM(i915)) {
>>>>>                drm_dbg_kms(&i915->drm, "Allocating dpt from smem\n");
>>>>> -            dpt_obj = i915_gem_object_create_internal(i915, size);
>>>>> +            dpt_obj = i915_gem_object_create_shmem(i915, size);
>>>>>        }
>>>>>        if (IS_ERR(dpt_obj))
>>>>>                return ERR_CAST(dpt_obj);
>>>>
>>>> Okay I think I get it after some more looking at the DPT code paths.
>>>> Problem seems pretty clear - page tables are stored in dpt_obj and so
>>>> are lost when backing store is discarded.
>>>>
>>>> Changing to shmem object indeed looks the easiest option.
>>>>
>>>> Some related thoughts:
>>>>
>>>> 1)
>>>> I wonder if intel_dpt_suspend/resume remain needed after this patch.
>>>> Could you investigate please? On a glance their job was to restore the
>>>> PTEs which would be lost from internal objects backing storage. With
>>>> shmem objects that content should be preserved.
>>>
>>> intel_dpt_suspend is "suspending" the whole VM where, not only the dpt
>>> objects are mapped into, but also the framebuffer objects. I don't have
>>> much knowledge on how the framebuffer objects are managed, but the
>> suspend
>>> resume path still look necessary to me, unless the content of these
>>> framebuffer objects are also preserved.
>>
>> I don't think it has anything to do with fb content, but you are correct
>> it is still needed. Because 9755f055f512 ("drm/i915: Restore memory
>> mapping for DPT FBs across system suspend/resume") reminds me backing
>> store for DPT PTEs can be either lmem, stolen or internal (now shmem).
>> Even though with this patch internal is out of the picture, stolen
>> remains and so the issue of losing the page table content remains.
>> Perhaps resume could be optimised to only restore PTEs when VM page
>> tables are backed by stolen which may win some suspend/resume speed on
>> some platforms.
> 
> I will have to look into how suspend resume will change with the current flow
> as you said it can be looked in a later patch.

Thanks!

>>>> 2)
>>>> I wonder if i915_vma_flush_writes should be used (as a companion of
>>>> i915_vma_pin_iomap) from DPT dpt_bind_vma, dpt_insert_entries, etc. But
>>>> then I am also not sure if it does the right thing for the
>>>> i915_gem_object_pin_map path of i915_vma_pin_iomap. Perhaps it should
>>>> call __i915_gem_object_flush_map itself for that mapping flavour and
>>>> not do the ggtt flushing in that case.
> I am not sure if dpt_bind_vma will be called each time during pinning. IMO it gets called
> Only when the fb object needs to be bind after and unbind(triggered during obj destroy).
> Do you think if i915_vma_flush_writes should not be used if dpt objects are created from internal?

No, I *think* correct API usage is supposed to be: If one uses 
i915_vma_pin_iomap() for CPU access, then one should call 
i915_vma_flush_writes() after CPU writes are done - presumably as a 
barrier to make sure writes are visible before proceeding.

If that is correct, the I noticed problem (or I am missing something), 
that i915_vma_flush_writes only does something for the one of the three 
ways i915_vma_pin_iomap() can set up the CPU visible mapping (the 
ggtt->iomap path).

The i915_gem_object_lmem_io_map() path, relevant on dgfx, has no 
flushing. Maybe it does need it due WC, or maybe flushing the 
write-combine buffers would still be needed.

And the i915_gem_object_pin_map() path is also WC and in theory there is 
the corresponding __i915_gem_object_flush_map().

Don't know, maybe I am indeed missing something.

But for instance if __i915_gem_object_flush_map() *was* called from 
i915_vma_flush_writes(), and the latter *was* called after dpt_bind_vma 
does its thing, then notice how obj->mm.dirty *would* be set by that 
helper. Removing the need for this patch.

So perhaps i915_vma_flush_writes() should just dirty the object, *if* 
the idea is to be called after CPU writes. And perhaps it should call 
i915_gem_object_flush_map *if* the method of mmaping was other than 
ggtt. But the information would have to be recorded first, probably same 
as the i915_gem_object_pin_map() path records it in the bit 0 of the 
vma->iomap pointer.

> Or should we have a different flavor of i915_vm_pin_iomap that skips i915_vma_set_ggtt_write
> so that we can drop i915_vma_flush_writes during unpinning and move i915_vma_set_ggtt_write
> to dpt_insert_entires and do i915_vma_flush during clear range? Then I guess __i915_gem_object_flush_map
> called during vma bind and not object pinning. In either case I believe it is a larger cleanup
> which requires more extensive validation and analysis.

Yes definitely wasn't suggesting to do it in this patch.

>>>> In summary I think the fix is safe and correct but at least point 1) I
>>>> think needs looking into. It can be a follow up work too.
> 
> If you think this fix can work then I will look into the suspend/resume as a follow up and will appreciate
> an r-b for this change.  I believe 2) is a larger cleanup that may not be immediately required. I will have
> to dig more into the ramifications of the changes proposed above.
> 
> Thoughts ?

Yeah it is fine. I assumed someone else would r-b but I can too.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko
