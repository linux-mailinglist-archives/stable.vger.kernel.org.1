Return-Path: <stable+bounces-65290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73B9459E6
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 10:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D9E284114
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70731BF30C;
	Fri,  2 Aug 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShGM4v4r"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E24436C
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587419; cv=none; b=XZCdQFfpcOBn3mgZmUwaIf1lhQVAZb058hSEHwljDZt2TViRZOkhSW0dkDvMhXlufW1Z+KhNoAI6uUDRg8lHV8GT/BONfrK8Mpu59P+o6bFkuEV0UAi26les3VuAQPGSinsmz4G7Ewk72aMJvPO7QS96d7RZ5uK86GNH1rzZ8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587419; c=relaxed/simple;
	bh=+vdZPfkTEha46xuxPLWrlG8T1CGODb1jcBDvLJ00K2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCsStwtHmybTMmtOsSKymNv8ZvzWjnXK+6ANLSyIYbhdakvXP7D8J8e5dmgkz73dv/2pCaJox4YJ2E+BNUSP7vbfMhKDL7R4WC7OQw7LG2EjSzgc6YrgL1UB4mOPxXZcBj/XCJ+FVT4xxlYm60N6Xt7Y+SbzKmWtXEc1kVieka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShGM4v4r; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso49761715e9.0
        for <stable@vger.kernel.org>; Fri, 02 Aug 2024 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722587412; x=1723192212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDFMHzyewIoOpZDpgk+/wgKqvZvm4VhVGjIAU3I3z4E=;
        b=ShGM4v4rRKiFgZ1IYDnD3bdJA+9fLLgSHhnvZvJidUMy1b3GuGw7yYb+Dkw00xErAp
         xPD7A4EyVzgdvucu1fMhPv6vwxHpIMbhLAMOE9KBtlsGgh6XyvZCXL70VZ+RA14PUeVL
         5yytVBkKuKNva5eNpDYrlTmZ6cnCJUQDZQrXOKeU5GpsWxpNQAOG8ZUHotDg1TFPtX+E
         DUvJAHdE9kZ13+Ffoqg9Uc7vH9GBlgSkTp8hXO1Cc+efo7XW8AS5vHe4H0PXaWXU4TTw
         +f1zb1VOZsmDLXb+LcEZEPB8yiYRZKyMXfLEIMbf7qQ6U9+BB2e4vh0/DyJk++Gol0SY
         I0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722587412; x=1723192212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDFMHzyewIoOpZDpgk+/wgKqvZvm4VhVGjIAU3I3z4E=;
        b=Zy/fTfDRi1fzZMAXSf9eqMBDBDESIKDAisZgQ1c0/RFb/607EJt6unMxCH6e4Cq2SM
         JwlTcGpfSLIgCiUlaWVv/NbT8p23k28zlA3x0jzDJv3cGJIU4L+7skLL3JVoEGlKd987
         GbIEsD86kVbu4yqytmSKKo1kIEpEvGPbXhr4IbciEB8xVzNm/+g97bCo/JuCgEH1gfY7
         F0CWxETyD5MfB/XMVzC4fyL3J6owny28TnT/lwrEY4gKHZg8TuVHbHL65eOpZYvq89JB
         G2pnS3ccdso3hg4Hw/9OABHvCVCgCpSdU00XekGJcx1GVg8vzj7rp+7BTaDfH9WjPuuH
         91nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkTwKjnTuQcThD4Arb33kRYtgBaDBMZU+YFGyi0h8vgyBcEPsoQaXUUhfSvTH9TANxIkp6KWtcNg6hudRH97XCYWfkKZDV
X-Gm-Message-State: AOJu0Yz2/rDZucU1U49G/EiNCTMVW43pe66RNgz0/hirqSagV2O3TYyq
	+fDUWjr0bs7y2XhG2AjBjxGTs7y7CtoH+o0A2Ewz5qKCJHN29Svl
X-Google-Smtp-Source: AGHT+IFW5WdLmz7uruPbI37n2QHgfclR7n+YUA7F1btIGIUNebQWZc/IrYJ6b5x7PXaxxPlRHcb57A==
X-Received: by 2002:a05:600c:4ec6:b0:426:6960:34b0 with SMTP id 5b1f17b1804b1-428e6afea7fmr16959445e9.14.1722587411424;
        Fri, 02 Aug 2024 01:30:11 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa9esm85094135e9.2.2024.08.02.01.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 01:30:10 -0700 (PDT)
Message-ID: <c600abec-d16b-45d3-afe3-f10ba2fc8871@gmail.com>
Date: Fri, 2 Aug 2024 10:30:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Forward soft recovery errors to userspace
To: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org,
 "Olsak, Marek" <Marek.Olsak@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
 <641ce39c-a6a6-4448-bb2a-9c12d2873c1c@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <641ce39c-a6a6-4448-bb2a-9c12d2873c1c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 01.08.24 um 17:17 schrieb Friedrich Vock:
> Hi,
>
> I happened to come across an issue just now again where soft recovery
> fails to get reported to userspace properly, causing apps to submit
> hanging work in a loop (which ended up hanging the entire machine) - it
> seems like this patch never made it into amd-staging-drm-next. Given
> that it has a Reviewed-by and everything, was this just an oversight or
> are there some blockers to pushing it that I missed?
>
> If not, I'd be grateful if the patch could get merged.

Sorry that was my fault, I've forgotten about it because Alex usually 
picks up stuff for amd-staging-drm-next.

Thanks for the reminder, just pushed it.

Regards,
Christian.

>
> Thanks,
> Friedrich
>
> On 08.03.24 09:33, Christian König wrote:
>> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
>>> As we discussed before[1], soft recovery should be
>>> forwarded to userspace, or we can get into a really
>>> bad state where apps will keep submitting hanging
>>> command buffers cascading us to a hard reset.
>>
>> Marek you are in favor of this like forever.  So I would like to request
>> you to put your Reviewed-by on it and I will just push it into our
>> internal kernel branch.
>>
>> Regards,
>> Christian.
>>
>>>
>>> 1:
>>> https://lore.kernel.org/all/bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@froggi.es/ 
>>>
>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>
>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: André Almeida <andrealmeid@igalia.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 4b3000c21ef2..aebf59855e9f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -262,9 +262,8 @@ amdgpu_job_prepare_job(struct drm_sched_job
>>> *sched_job,
>>>       struct dma_fence *fence = NULL;
>>>       int r;
>>> -    /* Ignore soft recovered fences here */
>>>       r = drm_sched_entity_error(s_entity);
>>> -    if (r && r != -ENODATA)
>>> +    if (r)
>>>           goto error;
>>>       if (!fence && job->gang_submit)
>>


