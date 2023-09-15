Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B2D7A1BE5
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 12:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjIOKTZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 06:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKTY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 06:19:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266AEEB
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 03:19:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401da71b85eso21249705e9.1
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694773157; x=1695377957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sK9Eyjty3WcSPQgzQfhXSPOXZAdD5UkhlLQAAi98pcA=;
        b=X561EBz1kAJNnpe9IBhxsMGxWsy5qWD4wnyplh9GbcvD4d1DZvhkJ9hCGwcGy0mecp
         IcCSDRLZekpkzeSlMJKW5peTz4w8cT8rNPfbBv3hfiFYhKwnRC/QKdOrwcwXFPstsXUj
         fOu3gwEeD8bKyOMdXiPbwZFF+3LUodLXYKURgUe6K7LCD01hG31lcx0g9ZFyx0wPZIOc
         C6JU+R6mN4sL0nWlTXFTkonpKXT8Nls179KfFaFiQigZTOwHB2fUWi+vT6uz8qv7wtE+
         ALNtFpqjFsnt1Ge0yXn0KFtixF7QIAm/HM85ucmXPSfif5QhgQ1pcn1gnqujNTIO13mo
         HdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694773157; x=1695377957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sK9Eyjty3WcSPQgzQfhXSPOXZAdD5UkhlLQAAi98pcA=;
        b=rb2/Wyna7fMNAgmfr4Cz6jhCQhH9wiVyBFf1r/03laudV8t0cnQ9Syc8bry7lkcqYL
         WBoiaTtQsh0FTTTHRRfLc6vc0T3BzRw57kytlX0GqLFskTq1zvqfBSMEv9prnoFUI25K
         RA7LXU6F96Z/3+u+E+59Kq9M2gXDTvlKndRvR8X5bkzVU19jDveQkSwzmQnaNC0AcVVX
         MF/MFm0rmoN1GaC5Q70U3sJlJA19DlbYw6wV9sZMDfoGQOa+0bGgZu3tHLveI5a0NA0M
         /mJMMHcyKOakfNjzToWl3M2EJvzajJ2TzuZbE2XikoUeeyKxdRoWLOTi/fqCmvcQlj8O
         74HQ==
X-Gm-Message-State: AOJu0YxdYKgUBo3rDHIJL0xvo6bJ5glYR8fk8YwUVTpAMJcRlV+/hfko
        QHeFpXgxBlx/sujLSrQls3DygBrH1tHz9A==
X-Google-Smtp-Source: AGHT+IHB2R8E1JJhdEyHIDzJJv9xzmQEjZsoALFdszxJJyova8my7tMp6WkYUw4nrIO1rC9lZYwwlg==
X-Received: by 2002:a5d:6309:0:b0:315:9e1b:4ea6 with SMTP id i9-20020a5d6309000000b003159e1b4ea6mr846507wru.58.1694773157085;
        Fri, 15 Sep 2023 03:19:17 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d6585000000b0031accc7228asm4101670wru.34.2023.09.15.03.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:19:16 -0700 (PDT)
Message-ID: <39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com>
Date:   Fri, 15 Sep 2023 12:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Content-Language: en-US
To:     Lang Yu <Lang.Yu@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>, stable@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
 <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
 <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
 <745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com>
 <e7913001-ff45-169d-7110-3f2bef86208a@amd.com>
 <ZQQbmfuivo/F+b9o@lang-desktop>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ZQQbmfuivo/F+b9o@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am 15.09.23 um 10:53 schrieb Lang Yu:
> On 09/14/ , Felix Kuehling wrote:
>> On 2023-09-14 10:02, Christian König wrote:
> Do we still need to use legacy flush to emulate heavyweight flush
> if we don't use SVM? And can I push this now?

Felix needs to decide that. From what I understand the KFD needs 
heavyweight flushes for secure SVM operation.

If heavyweight flushes are buggy papering over that by using legacy 
flushes is only a mediocre workaround.

Regards,
Christian.

>
> Regards,
> Lang
>
>
>>> Am 14.09.23 um 15:59 schrieb Felix Kuehling:
>>>> On 2023-09-14 9:39, Christian König wrote:
>>>>> Is a single legacy flush sufficient to emulate an heavyweight
>>>>> flush as well?
>>>>>
>>>>> On previous generations we needed to issue at least two legacy
>>>>> flushes for this.
>>>> I assume you are referring to the Vega20 XGMI workaround. That is a
>>>> very different issue. Because PTEs would be cached in L2, we had to
>>>> always use a heavy-weight flush that would also flush the L2 cache
>>>> as well, and follow that with another legacy flush to deal with race
>>>> conditions where stale PTEs could be re-fetched from L2 before the
>>>> L2 flush was complete.
>>> No, we also have another (badly documented) workaround which issues a
>>> legacy flush before each heavy weight on some hw generations. See the my
>>> TLB flush cleanup patches.
>>>
>>>> A heavy-weight flush guarantees that there are no more possible
>>>> memory accesses using the old PTEs. With physically addressed caches
>>>> on GFXv9 that includes a cache flush because the address translation
>>>> happened before putting data into the cache. I think the address
>>>> translation and cache architecture works differently on GFXv10. So
>>>> maybe the cache-flush is not required here.
>>>>
>>>> But even then a legacy flush probably allows for in-flight memory
>>>> accesses with old physical addresses to complete after the TLB
>>>> flush. So there is a small risk of memory corruption that was
>>>> assumed to not be accessed by the GPU any more. Or when using IOMMU
>>>> device isolation it would result in IOMMU faults if the DMA mappings
>>>> are invalidated slightly too early.
>>> Mhm, that's quite bad. Any idea how to avoid that?
>> A few ideas
>>
>>   * Add an arbitrary delay and hope that it is longer than the FIFOs in
>>     the HW
>>   * Execute an atomic operation to memory on some GPU engine that could
>>     act as a fence, maybe just a RELEASE_MEM on the CP to some writeback
>>     location would do the job
>>   * If needed, RELEASE_MEM could also perform a cache flush
>>
>> Regards,
>>    Felix
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>>    Felix
>>>>
>>>>
>>>>> And please don't push before getting an rb from Felix as well.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>
>>>>> Am 14.09.23 um 11:23 schrieb Lang Yu:
>>>>>> cyan_skilfish has problems with other flush types.
>>>>>>
>>>>>> v2: fix incorrect ternary conditional operator usage.(Yifan)
>>>>>>
>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>> Cc: <stable@vger.kernel.org> # v5.15+
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> index d3da13f4c80e..c6d11047169a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> @@ -236,7 +236,8 @@ static void
>>>>>> gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t
>>>>>> vmid,
>>>>>>    {
>>>>>>        bool use_semaphore =
>>>>>> gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
>>>>>>        struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>>>>> -    u32 inv_req =
>>>>>> hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
>>>>>> +    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
>>>>>> +              (adev->asic_type != CHIP_CYAN_SKILLFISH) ?
>>>>>> flush_type : 0);
>>>>>>        u32 tmp;
>>>>>>        /* Use register 17 for GART */
>>>>>>        const unsigned int eng = 17;
>>>>>> @@ -331,6 +332,8 @@ static void
>>>>>> gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t
>>>>>> vmid,
>>>>>>          int r;
>>>>>>    +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
>>>>>> ? flush_type : 0;
>>>>>> +
>>>>>>        /* flush hdp cache */
>>>>>>        adev->hdp.funcs->flush_hdp(adev, NULL);
>>>>>>    @@ -426,6 +429,8 @@ static int
>>>>>> gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>>>>>        struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>>>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>>>>    +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
>>>>>> ? flush_type : 0;
>>>>>> +
>>>>>>        if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>>>>>>            spin_lock(&adev->gfx.kiq[0].ring_lock);
>>>>>>            /* 2 dwords flush + 8 dwords fence */

