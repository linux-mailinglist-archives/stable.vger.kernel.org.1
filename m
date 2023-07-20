Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AEC75B97C
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGTVZ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTVZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 17:25:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A526AB
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689888347; x=1690493147; i=friedrich.vock@gmx.de;
 bh=mha5x6qt3FZ0n16k7ZEdln9i/QyB6IST2EATsqREXno=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=U/U+/DeZrFaGawutOc72M46H5o7boIobViGrljJJJO/3CguY38Yz+g4MOKLoBZRt3I44exT
 GqfwoZCAMErLq3o1QTqwHfzYNv8Dn9MrM6pi5jO8Y4KEea0INe+nC1ivQhVFMuKTj2s8kiRbK
 ljDGoEkVO8PQSwlJw/0dzAvxWZ29VBMNVhPDZ+9rPONzPH6aYrk7+W90c57CIn18O2CqvRuu4
 Fa2+9Mw9uqIxCs8V4oJHhAeB62SGYnBeLOx81CwUDv7kuRYqlEci8nLuUKK70/EnhHBsX8qzv
 9bXmrB3slxQKJGo4dIEPzsEaowDPrtbbDsUHKvW2meLOZTc1dIcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.113.178]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1qKxG43jA2-002nSs; Thu, 20
 Jul 2023 23:25:46 +0200
Message-ID: <a13f0c63-1937-2093-602e-9282d44dd840@gmx.de>
Date:   Thu, 20 Jul 2023 23:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Always emit GDS switch when GDS/GWS/OA is
 used
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org
References: <20230707062908.9470-2-friedrich.vock@gmx.de>
 <a625bd04-1ae6-536d-d255-c3efa6351312@amd.com>
 <ef348f8d-27a6-06b2-210c-da1d8c8f3cca@gmx.de>
 <46b18e49-13e4-f5a3-e500-c4aa5bb8820a@amd.com>
From:   Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <46b18e49-13e4-f5a3-e500-c4aa5bb8820a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A6tbaFaHu1SuzY0VztK6QH/9jq4fH33chzhaMkqJwnPmIwXa+3T
 +mhnxQqtU4d3ifVHymxZJizzQ6kl7bStM9d17Q1PYnm/ptVcgqh3uV5C3deZ4uUCMYepa5X
 BQN2ppJc6bdtjk99bDSxQTiPKzezWuDJBSmBOgBJmNQiZCFvdPwaDlbz80ceMXcIPmpOx8Y
 4nJpDrDdo7KLPTDuDlCAw==
UI-OutboundReport: notjunk:1;M01:P0:CT+dReswblE=;ryM6FK4rRdpPYwnvJ78I8vCi54Y
 cafWjMrb6iyQTgPeVaCJDIuP1adBRLl6wAc+p1pPavnSzKrgopgr5mpM9NJk5ZZgLh0O3R82x
 P/xQlmCzBTipcQKd08P3MmYoKBD1X3IVp+xOV7wplZ8uULcLrS88eDWmFYJRCWiPze8N6O3d5
 9xrtnrDoBjRZXpyy/3+zwLOa+Pq8VL55KCh63loHTqL7/IfDtsPSuP/hHOqlo0Nf6TNs0Csts
 nkqRTNWcGRQ35BDjNerDd4U28kzqOJ+gS5w08+anpcfECEVxIeS0sCOww9BfQBq8VWVNn2+Ao
 x08DFv/ekyo3jj4MuSCLLH+hUzbpRN8yOnJvynEsRDhGSWhAH3vckmGq3u95b6RDJ89mfz3F5
 NRum3ZHdkHPiJSMHRZP6fsjCrN8uhYJaQVn9t/6JYmmDh9DCpE5IwIsOWfCN8zc+e1+F98FX1
 3Pt81//t6IXdMWvMvTd2zxsaanZ3AWWEWC5q6g8MFA6FdVoNW/hGUZ3rGnDJEdAfr5WfU9TSU
 JmbX4SO5dDNrTCBgu91pFC7GryrwJi2w8BKXMvQxKf2rbwSsEHhvT6Z87iT3I4YinZVIiRq4U
 BPrwa1CRbwprn4BbPd3JB5PdhibJBZrTy0sLN7er0gvd+jveI4NVuqutFJTmKDfRMkhfFtwTg
 V0UVTYVjHowgWBvh2qGG5dhYxOxIylLHgMJ0oYJ6CbqRakjL+0SdyBkk7edeYE6puKkfrhGKb
 k//28r06QfWmOD/3aPOye1TyIJSGiAztFeZ0MXVlGOj+kmQujEKfzOH5l1KUeNJZXPR2t18in
 Q/fUSpdpdFauMKF850wZzNgkuK6TtOvRXg+gEOKrxVszD2pzyHWEUN2M3fwhPbMSVHZZvWXPe
 yoGf1dChNpKzQb+z+98kflvy6glCvWbiko+MXdTaWyUkAZcQuXkADceh8eqfqQlHvI7OjVh/v
 gEZIXmXTpdfBhiiIZSP4Ponh//g=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 07.07.23 10:21, Christian K=C3=B6nig wrote:
> Am 07.07.23 um 09:28 schrieb Friedrich Vock:
>> Hi Christian,
>>
>> On 07.07.23 08:56, Christian K=C3=B6nig wrote:
>>>
>>>
>>> Am 07.07.23 um 08:28 schrieb Friedrich Vock:
>>>> During gfxoff, the per-VMID GDS registers are reset and not restored
>>>> afterwards.
>>>
>>> Hui? Since when? Those registers should be part of the saved ones.
>>>
>>> Have you found that by observation?
>>
>> yes. I tested this on my RX 6700 XT and the Steam Deck (Vangogh). In th=
e
>> bug report I linked, a test program using GWS I developed hangs because
>> of this.
>>
>> The hang occurs as soon as the kernel re-uses a VMID on which GWS was
>> already used once. In the hung state, inspecting the per-VMID GWS
>> registers shows that the values have been reset to 0.
>> The hang does not occur when gfxoff is disabled.
>>
>> Even without causing hangs, you can confirm the behaviour by doing the
>> following:
>> 1. Disable gfxoff.
>> 2. Set some GWS registers.
>> 3. Enable gfxoff and wait a bit.
>> 4. Disable gfxoff and read the registers again. The GWS registers have
>> been reset.
>>
>> I performed this test for the GDS_BASE/SIZE registers and it seems thes=
e
>> aren't affected, so it's only GWS that is buggy here.
>
> That's most like a bug in the FW then. I'm going to ask around
> internally.

Did the talks with the FW team result in anything yet? It's not that
high-priority, but it'd be nice to know if this is going to be fixed in
the firmware or if I should make a v2 (or if this isn't going to be
fixed at all).

Thanks,
Friedrich

>
>> I should probably make a v2 that combines the behaviour before this
>> patch for GDS and OA, and the patched behaviour for GWS.
>
> Yeah, that sounds like a good idea to me. But let me ping the fw teams
> first.
>
>>
>> I'm not aware of userspace using GWS (yet, I had some ideas for using i=
t
>> in RADV which is what I've been writing these tests for),
>> so perhaps the Cc to stable can also be omitted.
>
> Depends on what the fw teams says. As far as I know GWS has never been
> used widely on Linux.
>
> Could be that they say there is a hw bug and we deprecated it for this
> generation, or it's simply not handled by the fw and the driver needs
> to take care of this (like this patch does) or whatever.
>
> Thanks for the notice,
> Christian.
>
>>
>> Thanks,
>> Friedrich
>>
>>>
>>> Thanks,
>>> Christian.
>>>
>>>
>>>> =C2=A0 The kernel needs to emit a GDS switch to manually update the
>>>> GWS registers in this case. Since gfxoff can happen between any two
>>>> submissions and the kernel has no way of knowing, emit the GDS switch
>>>> before every submission.
>>>>
>>>> Fixes: 56b0989e29 ("drm/amdgpu: fix GDS/GWS/OA switch handling")
>>>> Cc: stable@vger.kernel.org
>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2530
>>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>>> ---
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 22 +++++++----------=
-----
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |=C2=A0 1 -
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c=C2=A0 | 10 ++++++++--
>>>> =C2=A0 3 files changed, 15 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> index ff1ea99292fb..de73797e9279 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> @@ -165,24 +165,17 @@ bool amdgpu_vmid_had_gpu_reset(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&a=
dev->gpu_reset_counter);
>>>> =C2=A0 }
>>>>
>>>> -/* Check if we need to switch to another set of resources */
>>>> -static bool amdgpu_vmid_gds_switch_needed(struct amdgpu_vmid *id,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu=
_job *job)
>>>> -{
>>>> -=C2=A0=C2=A0=C2=A0 return id->gds_base !=3D job->gds_base ||
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gds_size !=3D job->gd=
s_size ||
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gws_base !=3D job->gw=
s_base ||
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gws_size !=3D job->gw=
s_size ||
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->oa_base !=3D job->oa_=
base ||
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->oa_size !=3D job->oa_=
size;
>>>> -}
>>>> -
>>>> =C2=A0 /* Check if the id is compatible with the job */
>>>> =C2=A0 static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_job *job=
)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=C2=A0 id->pd_gpu_addr =3D=3D jo=
b->vm_pd_addr &&
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !amdgpu_vmid_gds_switch_n=
eeded(id, job);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gds_base =3D=3D job->=
gds_base &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gds_size =3D=3D job->=
gds_size &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gws_base =3D=3D job->=
gws_base &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->gws_size =3D=3D job->=
gws_size &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->oa_base =3D=3D job->o=
a_base &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->oa_size =3D=3D job->o=
a_size;
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 /**
>>>> @@ -434,7 +427,6 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct
>>>> amdgpu_ring *ring,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_move_tail=
(&id->list, &id_mgr->ids_lru);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 job->gds_switch_needed =3D amdgpu_vmid_gds_switch=
_needed(id, job);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (job->vm_needs_flush) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id->flushed_up=
dates =3D amdgpu_vm_tlb_seq(vm);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_put(=
id->last_flush);
>>>> @@ -503,7 +495,7 @@ void amdgpu_vmid_free_reserved(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0 * @vmhub: vmhub type
>>>> =C2=A0=C2=A0 * @vmid: vmid number to use
>>>> =C2=A0=C2=A0 *
>>>> - * Reset saved GDW, GWS and OA to force switch on next flush.
>>>> + * Reset saved GDS, GWS and OA data.
>>>> =C2=A0=C2=A0 */
>>>> =C2=A0 void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vm=
hub,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned vmid)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> index a963a25ddd62..2898508b1ce4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>> @@ -53,7 +53,6 @@ struct amdgpu_job {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 preamble_status;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 preemption_st=
atus;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 vm_needs_flush;
>>>> -=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 gds_switch_needed;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spm_update_needed;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 vm_pd_addr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 vmid;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 291977b93b1d..61856040cae2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -557,6 +557,12 @@ void amdgpu_vm_check_compute_bug(struct
>>>> amdgpu_device *adev)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> +/* Check if the job needs a GDS switch */
>>>> +static bool amdgpu_vm_need_gds_switch(struct amdgpu_job *job)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return job->gds_size || job->gws_size || job->oa_=
size;
>>>> +}
>>>> +
>>>> =C2=A0 /**
>>>> =C2=A0=C2=A0 * amdgpu_vm_need_pipeline_sync - Check if pipe sync is n=
eeded for
>>>> job.
>>>> =C2=A0=C2=A0 *
>>>> @@ -579,7 +585,7 @@ bool amdgpu_vm_need_pipeline_sync(struct
>>>> amdgpu_ring *ring,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (job->vm_needs_flush || ring->has_c=
ompute_vm_bug)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 if (ring->funcs->emit_gds_switch && job->gds_swit=
ch_needed)
>>>> +=C2=A0=C2=A0=C2=A0 if (ring->funcs->emit_gds_switch &&
>>>> amdgpu_vm_need_gds_switch(job))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (amdgpu_vmid_had_gpu_reset(adev, &i=
d_mgr->ids[job->vmid]))
>>>> @@ -609,7 +615,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring,
>>>> struct amdgpu_job *job,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_vmid *id =3D &id_mgr->id=
s[job->vmid];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool spm_update_needed =3D job->spm_up=
date_needed;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool gds_switch_needed =3D ring->funcs=
->emit_gds_switch &&
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->gds_switch_needed;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_vm_need_gds_switch=
(job);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool vm_flush_needed =3D job->vm_needs=
_flush;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *fence =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool pasid_mapping_needed =3D false;
>>>> --
>>>> 2.41.0
>>>>
>>>
>
