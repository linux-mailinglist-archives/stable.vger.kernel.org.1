Return-Path: <stable+bounces-74017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542749719A1
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCCC1C22E23
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B851B5804;
	Mon,  9 Sep 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="egxI6oqd"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055A1B375C
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885460; cv=none; b=HlfTrfMsJw6hzA0aL9Q+nZNZ1H3ip21Dy+tueQh9rAtkc7CGGQ3FpdDXXADjECvdcmfW9uqiPffPQSLZqQ8O7MTgSJRrDHKFEXXkWhOMDS5CXxmcIDPSdwSIEIqnys0cTACpCqqe8MElP2ScowrgVUWmXjRXUTz8QCtrsoUoyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885460; c=relaxed/simple;
	bh=p+IJEIxf/duWAJK9NmOQmVieQ3au2vO3640ZoAVoZ8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pgftdhh9mph12n5mu3NQuRmyQnSmDnEuhlmxTMsw9qAvxgCjSfL75hTvApmbdg6Pf32ycWPoRgRVSEkzSjEtaFxx6cVRCI4nghyT6Mu8Buma8MFmc96fbBSOfrg/Oynyf6FxVKU+qYWvZjsJBDm6gPMfy4mYhOPOprtGGpWDElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=egxI6oqd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wb/yA7MmOMpJ7uPZGM++w1zIBXs2cTOoCfnoJjmbs9I=; b=egxI6oqdjYyEiKTN0QCEAPyP5o
	c2mlUZfzgM9Tt7qLd/RltkpG45b0TIQ7Qfb9oD1mr/JGbcSQ58B6zzEZpT6WWit8AwQycLg8DVpPj
	M4GJbBdLHLFEQLzjSFG0nHOFVwuekbsSDSIZ13qAdAkS7uYcVX0p2hs/D6U1UAPpY9IWLGkdhAEpJ
	gKkWtZHV/v0ijfxjdhcVBpSY2pHQ8jcMdlXslUrXkZkJ+jIEUbIe/q+oO6x6z0HaBXbkWZFiWo60e
	vOv7kmDfzUAvBmDSaIaqiJ+HzGqb68x8dL9teGjA/zHKvRCZcUk+omvnOXk8KN+2FUgk6iFiSB3RW
	JKNsXikQ==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1snddo-00BXNo-0q; Mon, 09 Sep 2024 14:37:12 +0200
Message-ID: <14ef37f4-b982-41c1-8121-80882917e9c0@igalia.com>
Date: Mon, 9 Sep 2024 13:37:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] drm/sched: Add locking to drm_sched_entity_modify_sched
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <pstanner@redhat.com>, Tvrtko Ursulin <tursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 stable@vger.kernel.org
References: <20240906180618.12180-1-tursulin@igalia.com>
 <20240906180618.12180-2-tursulin@igalia.com>
 <8d763e5162ebc130a05da3cefbff148cdb6ce042.camel@redhat.com>
 <80e02cde-19e7-4fb6-a572-fb45a639a3b7@amd.com>
 <2356e3d66da3e5795295267e527042ab44f192c8.camel@redhat.com>
 <fb9556a1-b48d-49ed-9b9c-74b21fb76af4@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <fb9556a1-b48d-49ed-9b9c-74b21fb76af4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/09/2024 13:18, Christian König wrote:
> Am 09.09.24 um 14:13 schrieb Philipp Stanner:
>> On Mon, 2024-09-09 at 13:29 +0200, Christian König wrote:
>>> Am 09.09.24 um 11:44 schrieb Philipp Stanner:
>>>> On Fri, 2024-09-06 at 19:06 +0100, Tvrtko Ursulin wrote:
>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>
>>>>> Without the locking amdgpu currently can race
>>>>> amdgpu_ctx_set_entity_priority() and drm_sched_job_arm(),
>>>> I would explicitly say "amdgpu's amdgpu_ctx_set_entity_priority()
>>>> races
>>>> through drm_sched_entity_modify_sched() with drm_sched_job_arm()".
>>>>
>>>> The actual issue then seems to be drm_sched_job_arm() calling
>>>> drm_sched_entity_select_rq(). I would mention that, too.
>>>>
>>>>
>>>>> leading to the
>>>>> latter accesing potentially inconsitent entity->sched_list and
>>>>> entity->num_sched_list pair.
>>>>>
>>>>> The comment on drm_sched_entity_modify_sched() however says:
>>>>>
>>>>> """
>>>>>    * Note that this must be called under the same common lock for
>>>>> @entity as
>>>>>    * drm_sched_job_arm() and drm_sched_entity_push_job(), or the
>>>>> driver
>>>>> needs to
>>>>>    * guarantee through some other means that this is never called
>>>>> while
>>>>> new jobs
>>>>>    * can be pushed to @entity.
>>>>> """
>>>>>
>>>>> It is unclear if that is referring to this race or something
>>>>> else.
>>>> That comment is indeed a bit awkward. Both
>>>> drm_sched_entity_push_job()
>>>> and drm_sched_job_arm() take rq_lock. But
>>>> drm_sched_entity_modify_sched() doesn't.
>>>>
>>>> The comment was written in 981b04d968561. Interestingly, in
>>>> drm_sched_entity_push_job(), this "common lock" is mentioned with
>>>> the
>>>> soft requirement word "should" and apparently is more about keeping
>>>> sequence numbers in order when inserting.
>>>>
>>>> I tend to think that the issue discovered by you is unrelated to
>>>> that
>>>> comment. But if no one can make sense of the comment, should it
>>>> maybe
>>>> be removed? Confusing comment is arguably worse than no comment
>>> Agree, we probably mixed up in 981b04d968561 that submission needs a
>>> common lock and that rq/priority needs to be protected by the
>>> rq_lock.
>>>
>>> There is also the big FIXME in the drm_sched_entity documentation
>>> pointing out that this is most likely not implemented correctly.
>>>
>>> I suggest to move the rq, priority and rq_lock fields together in the
>>> drm_sched_entity structure and document that rq_lock is protecting
>>> the two.
>> That could also be a great opportunity for improving the lock naming:
> 
> Well that comment made me laugh because I point out the same when the 
> scheduler came out ~8years ago and nobody cared about it since then.
> 
> But yeah completely agree :)

Maybe, but we need to keep in sight the fact some of these fixes may be 
good to backport. In which case re-naming exercises are best left to follow.

Also..

>> void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t 
>> ts)
>> {
>>     /*
>>      * Both locks need to be grabbed, one to protect from entity->rq 
>> change
>>      * for entity from within concurrent drm_sched_entity_select_rq 
>> and the
>>      * other to update the rb tree structure.
>>      */
>>     spin_lock(&entity->rq_lock);
>>     spin_lock(&entity->rq->lock);

.. I agree this is quite unredable and my initial reaction was a similar 
ugh. However.. What names would you guys suggest and for what to make 
this better and not lessen the logic of naming each individually?

Regards,

Tvrtko

>> [...]
>>
>>
>> P.
>>
>>
>>> Then audit the code if all users of rq and priority actually hold the
>>> correct locks while reading and writing them.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> P.
>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Fixes: b37aced31eb0 ("drm/scheduler: implement a function to
>>>>> modify
>>>>> sched list")
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Luben Tuikov <ltuikov89@gmail.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>>>> Cc: dri-devel@lists.freedesktop.org
>>>>> Cc: <stable@vger.kernel.org> # v5.7+
>>>>> ---
>>>>>    drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> b/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> index 58c8161289fe..ae8be30472cd 100644
>>>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> @@ -133,8 +133,10 @@ void drm_sched_entity_modify_sched(struct
>>>>> drm_sched_entity *entity,
>>>>>    {
>>>>>        WARN_ON(!num_sched_list || !sched_list);
>>>>> +    spin_lock(&entity->rq_lock);
>>>>>        entity->sched_list = sched_list;
>>>>>        entity->num_sched_list = num_sched_list;
>>>>> +    spin_unlock(&entity->rq_lock);
>>>>>    }
>>>>>    EXPORT_SYMBOL(drm_sched_entity_modify_sched);
> 

