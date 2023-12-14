Return-Path: <stable+bounces-6722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A0812B87
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072641F21566
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBCF2D05D;
	Thu, 14 Dec 2023 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRJ9yGAM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA8CF4
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 01:21:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-33644eeb305so522457f8f.1
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 01:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702545702; x=1703150502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ti/XnL9pCop+OWRzSFtBI/LQC8pXFmsJ2ahEPGjSNaM=;
        b=GRJ9yGAMHTnXsqjXxlKfhQdrqq6zfQx1m/FKO7rxx3moLHOHlTsfaanGX/Z/Zf+Yzo
         Su8R9p5rC6Y93PYUrhlmjdg37YRvdCHktjevexnJYuV3J8jAWHkPN0C4W2tZ+pqMAy9q
         BJfxlG5wZVtQxwNk/NkQ01kEgtHh8fAn32ixpZiYwkxx9GomBkPrgpY/kik0ksEYMMPT
         RoB4oVL3ND40GS54aKxugqeD6b/RDDIg9wrDQWWJXXp8GhCofi2ND/h6NCJQBgI1Z5xu
         7cnTUZLqxNDIx9lEYAP9hYCGUzNPPkapq3lJApuLoOX6h8uYZrHy8bj9t8LprTcqfqYH
         jKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545702; x=1703150502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ti/XnL9pCop+OWRzSFtBI/LQC8pXFmsJ2ahEPGjSNaM=;
        b=CwNi1eLoO0hMPm7nXrtRye1M1BTUOh6zERrWhZtSL/SMYpJLoy/Le2PJj1wOqKGoNf
         XDXkGa9U+ga5Q/phJ/Rk9YJM1qtXFBwHkZC4l7f8IFq2CZ5FYD9vKRfHchVPwXtcWyie
         TpOs6dSp/21p8wv2MWDt+ZBZRnCLOOxQvw3UZpJOaT95FWRN//jtYr5LLSdrcLzToB2V
         zzFcPzCVWrGOhQEarzHwnVMCPt29DD66mRavswx4jppdBEGiCgrlr8wfekKGdlJ0yQWG
         8OLK6RJpf14kbEaiIub5TBCFoQU8vsq0H0ep1ags6SD2Ew4SKGmMsrTkuIrL/qHgxlCw
         X2ig==
X-Gm-Message-State: AOJu0YxsNhROEE9YlIhkluvYCGGEOU8sMH7vNRyQ6J6dDLH5Fyjy3Vea
	h0P4pA1orCIASaaWiYead2LQmkixIwE=
X-Google-Smtp-Source: AGHT+IFtA7162IeubaayseDEGgzfcZgmzJmlsQy7mMUhh1yIZLx3o1fCEpAf2y8BpUuA3qfdvlyACA==
X-Received: by 2002:a7b:ca4c:0:b0:40c:62f1:ad11 with SMTP id m12-20020a7bca4c000000b0040c62f1ad11mr304642wml.81.1702545701692;
        Thu, 14 Dec 2023 01:21:41 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id bg16-20020a05600c3c9000b0040c517d090esm9321111wmb.15.2023.12.14.01.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 01:21:41 -0800 (PST)
Message-ID: <aacee34d-a62a-4af6-8fb8-de981e1dfc9c@gmail.com>
Date: Thu, 14 Dec 2023 10:21:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to
 flush TLB
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Tim Huang <Tim.Huang@amd.com>, stable@vger.kernel.org,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231213170454.5962-1-mario.limonciello@amd.com>
 <CADnq5_O=Kp+TkSEHXxSPEtWEYknFL_e_D7m5nXN=y8CJrR950g@mail.gmail.com>
 <38da4566-d936-42d9-9879-eee993270da0@amd.com>
 <13694238-418a-4fcb-8921-f9ab31e08120@amd.com>
 <CADnq5_MkkWqLyC3VYbTXSX7JL2Q5aaeJ6sFT9ROXjqdVfsXgjw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MkkWqLyC3VYbTXSX7JL2Q5aaeJ6sFT9ROXjqdVfsXgjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.12.23 um 20:44 schrieb Alex Deucher:
> On Wed, Dec 13, 2023 at 2:32 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> On 12/13/2023 13:12, Mario Limonciello wrote:
>>> On 12/13/2023 13:07, Alex Deucher wrote:
>>>> On Wed, Dec 13, 2023 at 1:00 PM Mario Limonciello
>>>> <mario.limonciello@amd.com> wrote:
>>>>> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
>>>>> causes the first MES packet after resume to fail. This packet is
>>>>> used to flush the TLB when GART is enabled.
>>>>>
>>>>> This issue is fixed in newer firmware, but as OEMs may not roll this
>>>>> out to the field, introduce a workaround that will retry the flush
>>>>> when detecting running on an older firmware and decrease relevant
>>>>> error messages to debug while workaround is in use.
>>>>>
>>>>> Cc: stable@vger.kernel.org # 6.1+
>>>>> Cc: Tim Huang <Tim.Huang@amd.com>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
>>>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>>>>>    4 files changed, 32 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> index 9ddbf1494326..6ce3f6e6b6de 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>>> @@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct
>>>>> amdgpu_device *adev,
>>>>>           }
>>>>>
>>>>>           r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
>>>>> -       if (r)
>>>>> -               DRM_ERROR("failed to reg_write_reg_wait\n");
>>>>> +       if (r) {
>>>>> +               const char *msg = "failed to reg_write_reg_wait\n";
>>>>> +
>>>>> +               if (adev->mes.suspend_workaround)
>>>>> +                       DRM_DEBUG(msg);
>>>>> +               else
>>>>> +                       DRM_ERROR(msg);
>>>>> +       }
>>>>>
>>>>>    error:
>>>>>           return r;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>> index a27b424ffe00..90f2bba3b12b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>>> @@ -135,6 +135,8 @@ struct amdgpu_mes {
>>>>>
>>>>>           /* ip specific functions */
>>>>>           const struct amdgpu_mes_funcs   *funcs;
>>>>> +
>>>>> +       bool                            suspend_workaround;
>>>>>    };
>>>>>
>>>>>    struct amdgpu_mes_process {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> index 23d7b548d13f..e810c7bb3156 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>> @@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct
>>>>> amdgpu_device *adev)
>>>>>                   false : true;
>>>>>
>>>>>           adev->mmhub.funcs->set_fault_enable_default(adev, value);
>>>>> -       gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>> +
>>>>> +       do {
>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>> +               adev->mes.suspend_workaround = false;
>>>>> +       } while (adev->mes.suspend_workaround);
>>>> Shouldn't this be something like:
>>>>
>>>>> +       do {
>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>> +               adev->mes.suspend_workaround = false;
>>>>> +               gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
>>>>> +       } while (adev->mes.suspend_workaround);
>>>> If we actually need the flush.  Maybe a better approach would be to
>>>> check if we are in s0ix in
>>> Ah you're right; I had shifted this around to keep less stateful
>>> variables and push them up the stack from when I first made it and that
>>> logic is wrong now.
>>>
>>> I don't think the one you suggested is right either; it's going to apply
>>> twice on ASICs that only need it once.
>>>
>>> I guess pending on what Christian comments on below I'll respin to logic
>>> that only calls twice on resume for these ASICs.
>> One more comment.  Tim and I both did an experiment for this (skipping
>> the flush) separately.  The problem isn't the flush itself, rather it's
>> the first MES packet after exiting GFXOFF.

Well that's an ugly one. Can that happen every time GFXOFF kicks in?

>>
>> So it seems that it pushes off the issue to the next thing which is a
>> ring buffer test:
>>
>> [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.0.0
>> (-110).
>> [drm:process_one_work] *ERROR* ib ring test failed (-110).
>>
>> So maybe a better workaround is a "dummy" command that is only sent for
>> the broken firmware that we don't care about the outcome and discard errors.
>>
>> Then the workaround doesn't need to get as entangled with correct flow.
> Yeah. Something like that seems cleaner.  Just a question of where to
> put it since we skip GC and MES for s0ix.  Probably somewhere in
> gmc_v11_0_resume() before gmc_v11_0_gart_enable().  Maybe add a new
> mes callback.

Please try to keep it completely outside of the TLB invalidation and VM 
flush handling.

Regards,
Christian.

>
> Alex
>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c in gmc_v11_0_flush_gpu_tlb():
>>>> index 23d7b548d13f..bd6d9953a80e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> @@ -227,7 +227,8 @@ static void gmc_v11_0_flush_gpu_tlb(struct
>>>> amdgpu_device *adev, uint32_t vmid,
>>>>            * Directly use kiq to do the vm invalidation instead
>>>>            */
>>>>           if ((adev->gfx.kiq[0].ring.sched.ready ||
>>>> adev->mes.ring.sched.ready) &&
>>>> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>>>> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) ||
>>>> +           !adev->in_s0ix) {
>>>>                   amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
>>>> inv_req,
>>>>                                   1 << vmid, GET_INST(GC, 0));
>>>>                   return;
>>>>
>>>> @Christian Koenig is this logic correct?
>>>>
>>>>           /* For SRIOV run time, driver shouldn't access the register
>>>> through MMIO
>>>>            * Directly use kiq to do the vm invalidation instead
>>>>            */
>>>>           if ((adev->gfx.kiq[0].ring.sched.ready ||
>>>> adev->mes.ring.sched.ready) &&
>>>>               (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>>>>                   amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
>>>> inv_req,
>>>>                                   1 << vmid, GET_INST(GC, 0));
>>>>                   return;
>>>>           }
>>>>
>>>> We basically always use the MES with that logic.  If that is the case,
>>>> we should just drop the rest of that function.  Shouldn't we only use
>>>> KIQ or MES for SR-IOV?  gmc v10 has similar logic which also seems
>>>> wrong.
>>>>
>>>> Alex
>>>>
>>>>
>>>>>           DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>>>                    (unsigned int)(adev->gmc.gart_size >> 20),
>>>>> @@ -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
>>>>>           int r;
>>>>>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>
>>>>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>>>>> +       case IP_VERSION(13, 0, 4):
>>>>> +       case IP_VERSION(13, 0, 11):
>>>>> +               /* avoid problems with first TLB flush after resume */
>>>>> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900)
>>>>> +                       adev->mes.suspend_workaround = adev->in_s0ix;
>>>>> +               break;
>>>>> +       default:
>>>>> +               break;
>>>>> +       }
>>>>> +
>>>>>           r = gmc_v11_0_hw_init(adev);
>>>>>           if (r)
>>>>>                   return r;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>> index 4dfec56e1b7f..84ab8c611e5e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>>> @@ -137,8 +137,12 @@ static int
>>>>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>>>>>           r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>>>>>                         timeout);
>>>>>           if (r < 1) {
>>>>> -               DRM_ERROR("MES failed to response msg=%d\n",
>>>>> -                         x_pkt->header.opcode);
>>>>> +               if (mes->suspend_workaround)
>>>>> +                       DRM_DEBUG("MES failed to response msg=%d\n",
>>>>> +                                 x_pkt->header.opcode);
>>>>> +               else
>>>>> +                       DRM_ERROR("MES failed to response msg=%d\n",
>>>>> +                                 x_pkt->header.opcode);
>>>>>
>>>>>                   while (halt_if_hws_hang)
>>>>>                           schedule();
>>>>> --
>>>>> 2.34.1
>>>>>


