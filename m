Return-Path: <stable+bounces-185474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4042ABD56E4
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 792BF4F7BF5
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F81F1313;
	Mon, 13 Oct 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OgkKJGJR"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4CC29B79B
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374932; cv=none; b=iX3oJu9Er8s6sfNLV7L0TwV7lY1RrdV378Y+wckauVYJV4zBmFV4aPQw4kfZMuQpk1cUBgU1F3PXZsEbcigbayPIJpFWChz964PVcPpGAjHDAJZSG3/unWkAclc+OmQgB0sX+fW3I1NemwflUGzCIY5GXeVwbfexqvOgmo05Crw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374932; c=relaxed/simple;
	bh=Q7ksSjmsESpk2eHKEoDDklNpts2z6Gzynf1+1sIJkyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QitQaLXqS5kvRZsm7Jt039PKhQNHIskYlRNyM4oRR7hL9g11tl33pyj8d5/1SHkMHuoWL6EPhAjrMh1j+a1To9Vaz+omf++gQSt4LjyeLcvDLC8feq1v5dViRfxbuoFYUg4q5Uo3W6VdC1cqkuPz1heE5976sT4miJXhPbNKJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OgkKJGJR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rf2Kwp4pv2GEoF2nGgSBDDiBI66LND96h+MNtJBFqzo=; b=OgkKJGJRDFriZ8wpIS3C6wslRJ
	+GJ/h50pPKHVtL7UH30jD3l5TGRfiCITwUaShC03x322sS0mhbJ2cYntU+wItyBlxQEahRR7wYhNz
	IxcCFTnaxx2pijKkWAVwgREsaVdJw7FiorsBc/I/iH342dEhJp0Alk0ryFX5ipqiatX/2Ohk7OotE
	/dx+vmZ4hmy7lf9BuYWOCr0lRAwBhtb7abPNsU8qKjWBd4rLqGISwmPsj5VmpsQHh8ohFvJER+DSm
	bkFWZg2XD4QMxFabJwxKc6m1rSmf8H36G9pS7GyNQKma8iCpuY9+8diUFehGGmWXrFEjNKy8qGe1d
	hLPTxoKw==;
Received: from [90.242.12.242] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v8Lvj-0091Ub-Gx; Mon, 13 Oct 2025 19:01:51 +0200
Message-ID: <fa1cf2f6-a82d-46f4-b1ec-b07e678cad76@igalia.com>
Date: Mon, 13 Oct 2025 18:01:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Fix potential double free in
 drm_sched_job_add_resv_dependencies
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 stable@vger.kernel.org
References: <20251003092642.37065-1-tvrtko.ursulin@igalia.com>
 <6c150c95531b3d401b1dceec8d328a6d77b6849d.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <6c150c95531b3d401b1dceec8d328a6d77b6849d.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13/10/2025 15:39, Philipp Stanner wrote:
> On Fri, 2025-10-03 at 10:26 +0100, Tvrtko Ursulin wrote:
>> Drm_sched_job_add_dependency() consumes the fence reference both on
> 
> s/D/d

I cannot find the source right now but I am 99% sure someone pulled it 
on me in the past and educated me sentences should always start with a 
capital letter, even when it is not a proper word. Because in the past I 
was always doing the same as you suggest. I don't mind TBH.
>> success and failure, so in the latter case the dma_fence_put() on the
>> error path (xarray failed to expand) is a double free.
>>
>> Interestingly this bug appears to have been present ever since
>> ebd5f74255b9 ("drm/sched: Add dependency tracking"), since the code back
>> then looked like this:
>>
>> drm_sched_job_add_implicit_dependencies():
>> ...
>>         for (i = 0; i < fence_count; i++) {
>>                 ret = drm_sched_job_add_dependency(job, fences[i]);
>>                 if (ret)
>>                         break;
>>         }
>>
>>         for (; i < fence_count; i++)
>>                 dma_fence_put(fences[i]);
>>
>> Which means for the failing 'i' the dma_fence_put was already a double
>> free. Possibly there were no users at that time, or the test cases were
>> insufficient to hit it.
>>
>> The bug was then only noticed and fixed after
>> 9c2ba265352a ("drm/scheduler: use new iterator in drm_sched_job_add_implicit_dependencies v2")
>> landed, with its fixup of
>> 4eaf02d6076c ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies").
>>
>> At that point it was a slightly different flavour of a double free, which
>> 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder")
>> noticed and attempted to fix.
>>
>> But it only moved the double free from happening inside the
>> drm_sched_job_add_dependency(), when releasing the reference not yet
>> obtained, to the caller, when releasing the reference already released by
>> the former in the failure case.
> 
> That's certainly interesting, but is there a specific reason why you
> include all of that?

Yes, because bug was attempted to be fixed two times already. So it is 
IMO worth having a write up on the history.
> The code is as is, and AFAICS it's just a bug stemming from original
> bugs present and then refactorings happening.
> 
> I would at least remove the old 'implicit_dependencies' function from
> the commit message. It's just confusing and makes one look for that in
> the current code or patch.It does say "back then" and it references the commit so shouldn't be 
confusing.

The discussion is long for an additional reason that Fixes: targets not 
the original commit which did not get this right, but the last change 
which tried to fix it but did not. It sounded more logical to continue 
the chain on fixes but dunno. Could replace it with the original one 
just as well.
>> As such it is not easy to identify the right target for the fixes tag so
>> lets keep it simple and just continue the chain.
>>
>> We also drop the misleading comment about additional reference, since it
>> is not additional but the only one from the point of view of dependency
>> tracking.
> 
> 
> IMO that comment is nonsense. It's useless, too, because I can *see*
> that a reference is being taken there, but not *why*.
> 
> Argh, these comments. See also my commit 72ebc18b34993
> 
> 
> Anyways. Removing it is fine, but adding a better comment is better.
> See below.
> 
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Is there an error report that could be included here with a Closes:
> tag?No, it did not come from any such system. Could perhaps put a link to 
the report as Reference: 
https://lore.kernel.org/dri-devel/aNFbXq8OeYl3QSdm@stanley.mountain/

?

>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Rob Clark <robdclark@chromium.org>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v5.16+
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index 46119aacb809..aff34240f230 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -960,20 +960,16 @@ int drm_sched_job_add_resv_dependencies(struct drm_sched_job *job,
>>   {
>>   	struct dma_resv_iter cursor;
>>   	struct dma_fence *fence;
>> -	int ret;
>> +	int ret = 0;
>>   
>>   	dma_resv_assert_held(resv);
>>   
>>   	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
>> -		/* Make sure to grab an additional ref on the added fence */
>> -		dma_fence_get(fence);
>> -		ret = drm_sched_job_add_dependency(job, fence);
>> -		if (ret) {
>> -			dma_fence_put(fence);
>> -			return ret;
>> -		}
>> +		ret = drm_sched_job_add_dependency(job, dma_fence_get(fence));
> 
> You still take a reference as before, but there is no comment anymore.
> Can you add one explaining why a new reference is taken here?
> 
> I guess it will be something like "This needs a new reference for the
> job", since you cannot rely on the one from resv.

I was mulling it over but then thought the kerneldoc for 
drm_sched_job_add_dependency() is good enough since it explains the 
function always consumes the reference and dma_resv_for_each_fence() 
does not hold one over the iteration. I can add it.

> 
>> +		if (ret)
>> +			break;
>>   	}
>> -	return 0;
>> +	return ret;
> 
> 
> That's an unnecessarily enlargement of the git diff because of style,
> isn't it? Better keep the diff minimal here for git blame.

Given the relative size of the diff versus the function itself it did 
not look like a big deal to reduce to one return statement while 
touching it, but I can keep two returns just as well, no problem.

Regards,

Tvrtko


