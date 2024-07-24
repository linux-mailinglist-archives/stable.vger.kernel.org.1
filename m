Return-Path: <stable+bounces-61253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E826A93ADDD
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E581C20CAB
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C9F14A09C;
	Wed, 24 Jul 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="h84mPW0O"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7A1CAA1
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809044; cv=none; b=IaEU5nns/icGEKF9xRW5SlNbM09/UnlgrR9LoRqaRP+ChsNm/lwhgjQyoTmDs1u8OTcAQ/1cdGy3XeIkPORd78CyRjsprBaOItiPDPI+yGCNmAo6qJiOB9U2QisKDEsgu/SKmRZ3/DCiu9vQ8o75aklxvvXo+udfP8bkrJSsDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809044; c=relaxed/simple;
	bh=gPjNQWLWSWxO/hghO8UgufqIdCMTT0lX7zyRXRjjI0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDz0bV+w7OwjXj0JOYF5ho0Yp2scHPSgQ90jyp1H2VLIH9AE79iQ1calstE15mBTz4cNYoVhdOmY/LpxmKmkE+ddSttC4mju37a6Qj1aimllreB0oXZpYPXr0/NI+zNkmA+uIJszGOzURmxa3pNOo+Swr2AvnBL1gj5AZAkHFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=h84mPW0O; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k+eCM4giXZ30XEioe7+Fgj54F6YI8rOam69609kXZJE=; b=h84mPW0O+1sa4cl70QAXVsxvcf
	Us7NL+zL/Ibd2TauzmJld9qDuqUQMMvyqviGLKXAy4DulimtIK+3iTefLmlbpT5bpFsa2LAk1mdKz
	5h2QvSYPxwcVV7IGE8wof+7XqsfrUOKR1Fif6FG7nlcrrDA3NIxtfoMfu+qx750YRDzGCKEnxkf0W
	w9uNPgq9aaB83/XNnIXybHpuYKbgUE/1Bg5P/6PLU5mDSiQpMQdNxjht3bFFtEPqHFzlgqhpsXZED
	kQN4dfnUBNYpZJ/McC3pxl994YOfF7G1Rbdhtza4m0XS0gYkpge6pZTeJ8EpHV+TLpU1ROLH5OH/p
	TtSX5oDA==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sWXBC-001OZd-RA; Wed, 24 Jul 2024 10:16:58 +0200
Message-ID: <ecc032cd-d595-4f4d-a96a-bee51f290547@igalia.com>
Date: Wed, 24 Jul 2024 09:16:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/scheduler: Fix drm_sched_entity_set_priority()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20240719094730.55301-1-tursulin@igalia.com>
 <61bd1b84-a7f3-46fd-8511-27e306806c8d@gmail.com>
 <bd1f203f-d8c4-4c93-8074-79c3df4fe159@gmail.com>
 <8f977694-eb15-4b64-97f7-f2b8921de5cf@igalia.com>
 <eb8a2ce7-223f-4518-8d72-fac875a51f98@amd.com>
 <9867a2b2-6729-424f-abc9-e1d1b81bab41@igalia.com>
 <6b254b3d-a6d9-4b12-9a5e-dacb32d41ee9@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6b254b3d-a6d9-4b12-9a5e-dacb32d41ee9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/07/2024 16:13, Christian König wrote:
> Am 22.07.24 um 16:43 schrieb Tvrtko Ursulin:
>>
>> On 22/07/2024 15:06, Christian König wrote:
>>> Am 22.07.24 um 15:52 schrieb Tvrtko Ursulin:
>>>>
>>>> On 19/07/2024 16:18, Christian König wrote:
>>>>> Am 19.07.24 um 15:02 schrieb Christian König:
>>>>>> Am 19.07.24 um 11:47 schrieb Tvrtko Ursulin:
>>>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>>
>>>>>>> Long time ago in commit b3ac17667f11 ("drm/scheduler: rework entity
>>>>>>> creation") a change was made which prevented priority changes for 
>>>>>>> entities
>>>>>>> with only one assigned scheduler.
>>>>>>>
>>>>>>> The commit reduced drm_sched_entity_set_priority() to simply 
>>>>>>> update the
>>>>>>> entities priority, but the run queue selection logic in
>>>>>>> drm_sched_entity_select_rq() was never able to actually change the
>>>>>>> originally assigned run queue.
>>>>>>>
>>>>>>> In practice that only affected amdgpu, being the only driver 
>>>>>>> which can do
>>>>>>> dynamic priority changes. And that appears was attempted to be 
>>>>>>> rectified
>>>>>>> there in 2316a86bde49 ("drm/amdgpu: change hw sched list on ctx 
>>>>>>> priority
>>>>>>> override").
>>>>>>>
>>>>>>> A few unresolved problems however were that this only fixed
>>>>>>> drm_sched_entity_set_priority() *if* 
>>>>>>> drm_sched_entity_modify_sched() was
>>>>>>> called first. That was not documented anywhere.
>>>>>>>
>>>>>>> Secondly, this only works if drm_sched_entity_modify_sched() is 
>>>>>>> actually
>>>>>>> called, which in amdgpu's case today is true only for gfx and 
>>>>>>> compute.
>>>>>>> Priority changes for other engines with only one scheduler 
>>>>>>> assigned, such
>>>>>>> as jpeg and video decode will still not work.
>>>>>>>
>>>>>>> Note that this was also noticed in 981b04d96856 ("drm/sched: 
>>>>>>> improve docs
>>>>>>> around drm_sched_entity").
>>>>>>>
>>>>>>> Completely different set of non-obvious confusion was that whereas
>>>>>>> drm_sched_entity_init() was not keeping the passed in list of 
>>>>>>> schedulers
>>>>>>> (courtesy of 8c23056bdc7a ("drm/scheduler: do not keep a copy of 
>>>>>>> sched
>>>>>>> list")), drm_sched_entity_modify_sched() was disagreeing with 
>>>>>>> that and
>>>>>>> would simply assign the single item list.
>>>>>>>
>>>>>>> That incosistency appears to be semi-silently fixed in ac4eb83ab255
>>>>>>> ("drm/sched: select new rq even if there is only one v3").
>>>>>>>
>>>>>>> What was also not documented is why it was important to not keep the
>>>>>>> list of schedulers when there is only one. I suspect it could have
>>>>>>> something to do with the fact the passed in array is on stack for 
>>>>>>> many
>>>>>>> callers with just one scheduler. With more than one scheduler 
>>>>>>> amdgpu is
>>>>>>> the only caller, and there the container is not on the stack. 
>>>>>>> Keeping a
>>>>>>> stack backed list in the entity would obviously be undefined 
>>>>>>> behaviour
>>>>>>> *if* the list was kept.
>>>>>>>
>>>>>>> Amdgpu however did only stop passing in stack backed container 
>>>>>>> for the more
>>>>>>> than one scheduler case in 977f7e1068be ("drm/amdgpu: allocate 
>>>>>>> entities on
>>>>>>> demand"). Until then I suspect dereferencing freed stack from
>>>>>>> drm_sched_entity_select_rq() was still present.
>>>>>>>
>>>>>>> In order to untangle all that and fix priority changes this patch is
>>>>>>> bringing back the entity owned container for storing the passed in
>>>>>>> scheduler list.
>>>>>>
>>>>>> Please don't. That makes the mess just more horrible.
>>>>>>
>>>>>> The background of not keeping the array is to intentionally 
>>>>>> prevent the priority override from working.
>>>>>>
>>>>>> The bug is rather that adding drm_sched_entity_modify_sched() 
>>>>>> messed this up.
>>>>>
>>>>> To give more background: Amdgpu has two different ways of handling 
>>>>> priority:
>>>>> 1. The priority in the DRM scheduler.
>>>>> 2. Different HW rings with different priorities.
>>>>>
>>>>> Your analysis is correct that drm_sched_entity_init() initially 
>>>>> dropped the scheduler list to avoid using a stack allocated list, 
>>>>> and that functionality is still used in amdgpu_ctx_init_entity() 
>>>>> for example.
>>>>>
>>>>> Setting the scheduler priority was basically just a workaround 
>>>>> because we didn't had the hw priorities at that time. Since that is 
>>>>> no longer the case I suggest to just completely drop the 
>>>>> drm_sched_entity_set_priority() function instead.
>>>>
>>>> Removing drm_sched_entity_set_priority() is one thing, but we also 
>>>> need to clear up the sched_list container ownership issue. It is 
>>>> neither documented, nor robustly handled in the code. The 
>>>> "num_scheds == 1" special casing throughout IMHO has to go too.
>>>
>>> I disagree. Keeping the scheduler list in the entity is only useful 
>>> for load balancing.
>>>
>>> As long as only one scheduler is provided and we don't load balance 
>>> the entity doesn't needs the scheduler list in the first place.
>>
>> Once set_priority is removed then it indeed it doesn't. But even when 
>> it is removed it needs documenting who owns the passed in container. 
>> Today drivers are okay to pass a stack array when it is one element, 
>> but if they did it with more than one they would be in for a nasty 
>> surprise.
> 
> Yes, completely agree. But instead of copying the array  I would rather 
> go into the direction to cleanup all callers and make the scheduler list 
> mandatory to stay around as long as the scheduler lives.
> 
> The whole thing of one calling convention there and another one at a 
> different place really sucks.

Ok, lets scroll a bit down to formulate a plan.

>>>> Another thing if you want to get rid of frontend priority handling 
>>>> is to stop configuring scheduler instances with 
>>>> DRM_SCHED_PRIORITY_COUNT priority levels, to avoid wasting memory on 
>>>> pointless run queues.
>>>
>>> I would rather like to completely drop the RR with the runlists 
>>> altogether and keep only the FIFO approach around. This way priority 
>>> can be implemented by boosting the score of submissions by a certain 
>>> degree.
>>
>> You mean larger refactoring of the scheduler removing the 1:N between 
>> drm_sched and drm_sched_rq?
> 
> Yes, exactly that.
> 
>>
>>>> And final thing is to check whether the locking in 
>>>> drm_sched_entity_modify_sched() is okay. Because according to 
>>>> kerneldoc:
>>>>
>>>>  * Note that this must be called under the same common lock for 
>>>> @entity as
>>>>  * drm_sched_job_arm() and drm_sched_entity_push_job(), or the 
>>>> driver needs to
>>>>  * guarantee through some other means that this is never called 
>>>> while new jobs
>>>>  * can be pushed to @entity.
>>>>
>>>> I don't see that is the case. Priority override is under 
>>>> amdgpu_ctx_mgr->lock, while job arm and push appear not. I also 
>>>> cannot spot anything else preventing amdgpu_sched_ioctl() running in 
>>>> parallel to everything else.
>>>
>>> Yeah that's certainly incorrect as well. 
>>> drm_sched_entity_modify_sched() should grab entity->rq_lock instead.
>>
>> Ah cool. Well not cool, but good problem has been identified. Are you 
>> going to work in it or should I? Once we agree the correct fix for all 
>> this I am happy to write more patches if you are too busy.
> 
> Absolutely.

Absolutely good and absolutely me, or absolutely you? :)

These are the TODO points and their opens:

- Adjust amdgpu_ctx_set_entity_priority() to call 
drm_sched_entity_modify_sched() regardless of the hw_type - to fix 
priority changes on a single sched other than gfx or compute.

- Document sched_list array lifetime must align with the entity and 
adjust the callers.

Open:

Do you still oppose keeping sched_list for num_scheds == 1? If so do you 
propose drm_sched_entity_modify_sched() keeps disagreeing with 
drm_sched_entity_init() on this detail? And keep the "one shot single 
sched_list" quirk in? Why is that nicer than simply keeping the list and 
remove that quirk? Once lifetime rules are clear it IMO is okay to 
always keep the list.

- Remove drm_sched_entity_set_priority().

Open:

Should we at this point also modify amdgpu_device_init_schedulers() to 
stop initialising schedulers with DRM_SCHED_PRIORITY_COUNT run queues?

Once drm_sched_entity_set_priority() is gone there is little point. 
Unless there are some non-obvious games with the kernel priority or 
something.

>>>>> In general scheduler priorities were meant to be used for things 
>>>>> like kernel queues which would always have higher priority than 
>>>>> user space submissions and using them for userspace turned out to 
>>>>> be not such a good idea.
>>>>
>>>> Out of curiousity what were the problems? I cannot think of anything 
>>>> fundamental since there are priorities at the backend level after 
>>>> all, just fewer levels.
>>>
>>> A higher level queue can starve lower level queues to the point that 
>>> they never get a chance to get anything running.
>>
>> Oh that.. well I call that implementation details. :) Because nowhere 
>> in the uapi is I think guaranteed execution ordering needs to be 
>> strictly in descending priority. This potentially goes back to what 
>> you said above that a potential larger rewrite might be beneficial. 
>> Implementing some smarter scheduling. Although the issue will be it is 
>> just frontend scheduling after all. So a bit questionable to invest in 
>> making it too smart.
> 
> +1 and we have a bug report complaining that RR is in at least one 
> situation better than FIFO. So it is actually quite hard to remove.
> 
> On the other hand FIFO has some really nice properties as well. E.g. try 
> to run >100 glxgears instances (on weaker hw) and just visually compare 
> the result differences between RR and FIFO. FIFO is baby smooth and RR 
> is basically stuttering all the time.
> 
>> I think this goes more back to what I was suggesting during early xe 
>> days, that potentially drm scheduler should be split into dependency 
>> handling part and the scheduler part. Drivers with 1:1 
>> entity:scheduler and full hardware/firmware scheduling do not really 
>> need neither fifo or rr.
> 
> Yeah that's my thinking as well and I also suggested that multiple times 
> in discussions with Sima and others.
> 
>>
>>> This basically means that userspace gets a chance to submit infinity 
>>> fences with all the bad consequences.
>>>
>>>>
>>>> I mean one problem unrelated to this discussion is this:
>>>>
>>>> void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>>>> {
>>>>     struct dma_fence *fence;
>>>>     struct drm_gpu_scheduler *sched;
>>>>     struct drm_sched_rq *rq;
>>>>
>>>>     /* queue non-empty, stay on the same engine */
>>>>     if (spsc_queue_count(&entity->job_queue))
>>>>         return;
>>>>
>>>> Which makes it look like the entity with a constant trickle of jobs 
>>>> will never actually manage to change it's run queue. Neither today, 
>>>> nor after the potential drm_sched_entity_set_priority() removal.
>>>
>>> That's intentional and based on how the scheduler load balancing works.
>>
>> I see that it is intentional but if it can silently prevent priority 
>> changes (even hw priority) it is not very solid. Unless I am missing 
>> something here.
> 
> IIRC the GSoC student who implemented this (with me as mentor) actually 
> documented that behavior somewhere.
> 
> And to be honest it kind of makes sense because switching priorities 
> would otherwise be disruptive, e.g. you have a moment were you need to 
> drain all previous submissions with the old priority before you can do 
> new ones with the new priority.

Hmmm I don't see how it makes sense. Perhaps a test case for 
AMDGPU_SCHED_OP_*_PRIORITY_OVERRIDE is missing to show how it doesn't 
work. Or at least how easy it can be defeated with callers none the wiser.

For context I am kind of interested because I wired up amdgpu to the DRM 
cgroup controller and use priority override to de-prioritize certain 
cgroups and it kind of works. But again, it will not be great if a 
client with a constant trickle of submissions can just defeat it.

Regards,

Tvrtko

