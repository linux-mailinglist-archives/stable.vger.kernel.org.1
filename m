Return-Path: <stable+bounces-94614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B319D6091
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25F7B23BBD
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E01DDA32;
	Fri, 22 Nov 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Fj1Ncw/p"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D14136E37
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286230; cv=none; b=ocyOGXGmCmS+bNGG6vi8YBujAk6VtsWq0Y1+0aQCJLASU8OOwvvflIPAE7C0rFYU/oBhrfg6t4R8SeKKshOrA1f+E0xPZH42ybplJaBmrIPvrJGNdzYjSJYmUC4T7RIDS9FIwJGwLlTpddBa78i2qmH5ExW2wgNnDOvqNnseVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286230; c=relaxed/simple;
	bh=CrjGYP/kWxa+js+YjbtI3bUhwxe6kOVdB63di8cRv+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGbKLz0A4rfP4SRY8UGwzs73YzK9vS+Rit95L/7SxUCAF6Y///s2ML2Qav+WnR+KR1F1gzi14mbIE40+x3ff5mNNSwT5hLOEITcu+aKoxsT/MHhy4GcE1/e4KRw9Qb8d3QxQSWXW3u+sVCp4TwOT2XllPEJRe0/IqonYwWiomzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Fj1Ncw/p; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tljsRWZ6gN6pFvwuG/Dk34JHxfyW4vkJss9YIAkk5l4=; b=Fj1Ncw/pVv/ie+27i3QfP6sMvJ
	YXaLW7cdHYsmE+8ValHYIq4JOcX8c0vN5HlMaLaW/Ksz6M1XMb35/n7Xf+7GaAJnlUT3OHDu46Vhz
	P2/qbdOo4XLJTvGbb6uzo5w6q9Z7iiYoYQfuzpsH+kfN8AmdnOqCjmGeciWDEHeX+lmY/IIxcC3tE
	eewFvWig6pFMRR167kfhBE6AqvWwbNrLwsBDHkGcbOgZnpyA3J6PeE4zoAkLdjW5w7UESNvRuROFF
	0fzdaSdExPGsayxi9M8sREfylNrpNMri2YzawiGUv7d5M/3u5Osu7SXXFi21bczGRBU3wf3FRliVF
	5hQi2L0A==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tEUmK-00AzAD-JA; Fri, 22 Nov 2024 15:37:00 +0100
Message-ID: <0af583a5-85d0-4c33-84e9-3856bde9fb4b@igalia.com>
Date: Fri, 22 Nov 2024 14:36:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Make the submission path memory reclaim safe
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, stable@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <pstanner@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Tejun Heo <tj@kernel.org>
References: <20241113134838.52608-1-tursulin@igalia.com>
 <e30428ce-a4d1-43e0-89d3-1487f7af2fde@amd.com>
 <154641d9-be2a-4018-af5e-a57dbffb45d5@igalia.com>
 <61ad957b-34be-4ee5-944f-261c7a412962@igalia.com>
 <14e6e7a3-4077-4074-aaae-3be4b6fd071d@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <14e6e7a3-4077-4074-aaae-3be4b6fd071d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 22/11/2024 13:46, Christian König wrote:
> Am 22.11.24 um 12:34 schrieb Tvrtko Ursulin:
>> On 13/11/2024 14:42, Tvrtko Ursulin wrote:
>>> On 13/11/2024 14:26, Christian König wrote:
>>>> Am 13.11.24 um 14:48 schrieb Tvrtko Ursulin:
>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>
>>>>> As commit 746ae46c1113 ("drm/sched: Mark scheduler work queues with 
>>>>> WQ_MEM_RECLAIM")
>>>>> points out, ever since
>>>>> a6149f039369 ("drm/sched: Convert drm scheduler to use a work queue 
>>>>> rather than kthread"),
>>>>> any workqueue flushing done from the job submission path must only
>>>>> involve memory reclaim safe workqueues to be safe against reclaim
>>>>> deadlocks.
>>>>>
>>>>> This is also pointed out by workqueue sanity checks:
>>>>>
>>>>>   [ ] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work 
>>>>> [gpu_sched] is flushing !WQ_MEM_RECLAIM 
>>>>> events:amdgpu_device_delay_enable_gfx_off [amdgpu]
>>>>> ...
>>>>>   [ ] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
>>>>> ...
>>>>>   [ ] Call Trace:
>>>>>   [ ]  <TASK>
>>>>> ...
>>>>>   [ ]  ? check_flush_dependency+0xf5/0x110
>>>>> ...
>>>>>   [ ]  cancel_delayed_work_sync+0x6e/0x80
>>>>>   [ ]  amdgpu_gfx_off_ctrl+0xab/0x140 [amdgpu]
>>>>>   [ ]  amdgpu_ring_alloc+0x40/0x50 [amdgpu]
>>>>>   [ ]  amdgpu_ib_schedule+0xf4/0x810 [amdgpu]
>>>>>   [ ]  ? drm_sched_run_job_work+0x22c/0x430 [gpu_sched]
>>>>>   [ ]  amdgpu_job_run+0xaa/0x1f0 [amdgpu]
>>>>>   [ ]  drm_sched_run_job_work+0x257/0x430 [gpu_sched]
>>>>>   [ ]  process_one_work+0x217/0x720
>>>>> ...
>>>>>   [ ]  </TASK>
>>>>>
>>>>> Fix this by creating a memory reclaim safe driver workqueue and 
>>>>> make the
>>>>> submission path use it.
>>>>
>>>> Oh well, that is a really good catch! I wasn't aware the workqueues 
>>>> could be blocked by memory reclaim as well.
>>>
>>> Only credit I can take is for the habit that I often run with many 
>>> kernel debugging aids enabled.
>>
>> Although this one actually isn't even under "Kernel hacking".
>>
>>>> Do we have system wide workqueues for that? It seems a bit overkill 
>>>> that amdgpu has to allocate one on his own.
>>>
>>> I wondered the same but did not find any. Only ones I am aware of are 
>>> system_wq&co created in workqueue_init_early().
>>
>> Gentle ping on this. I don't have any better ideas that creating a new 
>> wq.
> 
> It took me a moment to realize, but I now think this warning message is 
> a false positive.
> 
> What happens is that the code calls cancel_delayed_work_sync().
> 
> If the work item never run because of lack of memory then it can just be 
> canceled.
> 
> If the work item is running then we will block for it to finish.
> 
> There is no need to use WQ_MEM_RECLAIM for the workqueue or do I miss 
> something?
> 
> If I'm not completely mistaken you stumbled over a bug in the warning 
> code instead :)

Hmm your thinking sounds convincing.

Adding Tejun if he has time to help brainstorm this.

Question is - does check_flush_dependency() need to skip the 
!WQ_MEM_RECLAIM flushing WQ_MEM_RECLAIM warning *if* the work is already 
running *and* it was called from cancel_delayed_work_sync()?

Regards,

Tvrtko

>>>> Apart from that looks good to me.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> References: 746ae46c1113 ("drm/sched: Mark scheduler work queues 
>>>>> with WQ_MEM_RECLAIM")
>>>>> Fixes: a6149f039369 ("drm/sched: Convert drm scheduler to use a 
>>>>> work queue rather than kthread")
>>>>> Cc: stable@vger.kernel.org
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>> Cc: Philipp Stanner <pstanner@redhat.com>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 
>>>>> +++++++++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  5 +++--
>>>>>   3 files changed, 30 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index 7645e498faa4..a6aad687537e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -268,6 +268,8 @@ extern int amdgpu_agp;
>>>>>   extern int amdgpu_wbrf;
>>>>> +extern struct workqueue_struct *amdgpu_reclaim_wq;
>>>>> +
>>>>>   #define AMDGPU_VM_MAX_NUM_CTX            4096
>>>>>   #define AMDGPU_SG_THRESHOLD            (256*1024*1024)
>>>>>   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS            3000
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index 38686203bea6..f5b7172e8042 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -255,6 +255,8 @@ struct amdgpu_watchdog_timer 
>>>>> amdgpu_watchdog_timer = {
>>>>>       .period = 0x0, /* default to 0x0 (timeout disable) */
>>>>>   };
>>>>> +struct workqueue_struct *amdgpu_reclaim_wq;
>>>>> +
>>>>>   /**
>>>>>    * DOC: vramlimit (int)
>>>>>    * Restrict the total amount of VRAM in MiB for testing. The 
>>>>> default is 0 (Use full VRAM).
>>>>> @@ -2971,6 +2973,21 @@ static struct pci_driver 
>>>>> amdgpu_kms_pci_driver = {
>>>>>       .dev_groups = amdgpu_sysfs_groups,
>>>>>   };
>>>>> +static int amdgpu_wq_init(void)
>>>>> +{
>>>>> +    amdgpu_reclaim_wq =
>>>>> +        alloc_workqueue("amdgpu-reclaim", WQ_MEM_RECLAIM, 0);
>>>>> +    if (!amdgpu_reclaim_wq)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static void amdgpu_wq_fini(void)
>>>>> +{
>>>>> +    destroy_workqueue(amdgpu_reclaim_wq);
>>>>> +}
>>>>> +
>>>>>   static int __init amdgpu_init(void)
>>>>>   {
>>>>>       int r;
>>>>> @@ -2978,6 +2995,10 @@ static int __init amdgpu_init(void)
>>>>>       if (drm_firmware_drivers_only())
>>>>>           return -EINVAL;
>>>>> +    r = amdgpu_wq_init();
>>>>> +    if (r)
>>>>> +        goto error_wq;
>>>>> +
>>>>>       r = amdgpu_sync_init();
>>>>>       if (r)
>>>>>           goto error_sync;
>>>>> @@ -3006,6 +3027,9 @@ static int __init amdgpu_init(void)
>>>>>       amdgpu_sync_fini();
>>>>>   error_sync:
>>>>> +    amdgpu_wq_fini();
>>>>> +
>>>>> +error_wq:
>>>>>       return r;
>>>>>   }
>>>>> @@ -3017,6 +3041,7 @@ static void __exit amdgpu_exit(void)
>>>>>       amdgpu_acpi_release();
>>>>>       amdgpu_sync_fini();
>>>>>       amdgpu_fence_slab_fini();
>>>>> +    amdgpu_wq_fini();
>>>>>       mmu_notifier_synchronize();
>>>>>       amdgpu_xcp_drv_release();
>>>>>   }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> index 2f3f09dfb1fd..f8fd71d9382f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> @@ -790,8 +790,9 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device 
>>>>> *adev, bool enable)
>>>>>                           AMD_IP_BLOCK_TYPE_GFX, true))
>>>>>                       adev->gfx.gfx_off_state = true;
>>>>>               } else {
>>>>> - schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
>>>>> -                          delay);
>>>>> +                queue_delayed_work(amdgpu_reclaim_wq,
>>>>> + &adev->gfx.gfx_off_delay_work,
>>>>> +                           delay);
>>>>>               }
>>>>>           }
>>>>>       } else {
>>>>
> 

