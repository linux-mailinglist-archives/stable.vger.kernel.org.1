Return-Path: <stable+bounces-72995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6D296B79C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 12:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0494A1F261E5
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079C41CEEA2;
	Wed,  4 Sep 2024 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="0AxWx5hk"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76711CF2A0
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443994; cv=none; b=I2xeDInCpp0JU6CVyPA6G48iNtMokdDZ1Ks6pAUQjfKniTjuvonUpuvA+01M7hqRVB9JuJwtdkeQwxdAXpcOfD148csN7++ooXJchkMOm2DtZJPxe9wZCh7HuMBy/Ibwzzwybeo37lbXxIeLuukkbF9UwhuTxt+emBaN31nGh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443994; c=relaxed/simple;
	bh=VHrhhVaO46LvkZBmAdJSgss0EEKfhfVag9hWgmGpxPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPUZIopVOwkzv5TyZUSTKzSxES9e8x+tZa182k/4rFI1y5Hezw/idBfQ2cTmYfzzwzdmbHTorqoEZgKyrdA5Kw7K93aXjIqV9igZGZc5ws72QtSgUYNm8QmqE3+C32FShkZ88X0FcZhKDOQQFwcmU2ZvCKO4KVnt3WjsDoeKvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=0AxWx5hk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53351642021so693387e87.3
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1725443991; x=1726048791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKw4TKs+xzYW9ssVI3ZPbWWg9xJx5sIdNAvzUrikQOI=;
        b=0AxWx5hk0soOsE8By3nzb2uFSygGTXYxHUF4VpfC/vMqr9zNIwxhiMUAZOUFgp9SK8
         lvBu9DkV123AOGQ2TsEcm2hhU8bbqJSNiH8Q13Q2ZawdlMahdYNnUKFKv8W7dw3+jliw
         nBJU6PFmQ1yuljr1ds1IbTT0BC5bpK4U/L6e3UFHedAdS1rxkAGRY97XEqtTt6D+ispL
         lOrAE6Cl9fVN2drmsIR31O0UeUStTyM/oA1UqYOwpGa5Ue0jsGTx/0SIo9G/Ixm42p9w
         EYDDpVZfU3u6J6XC7Em49JOxQNRsGzWcXk950e6QjG5J0PK7ngqmUjfAnkHj0KmuW/Kk
         OVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725443991; x=1726048791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKw4TKs+xzYW9ssVI3ZPbWWg9xJx5sIdNAvzUrikQOI=;
        b=wCPcK70Jy/UEKMVem643IN4setJYHx0Gog7F37Xv80j3XHHcMBP8cC3++R1oGps2Pe
         Xk64yFst66cuPwu5fJu3tjLA1yMykEve28ZvhqK1qLGSXuHqbJDRH0XClgzBbfFTU/fR
         ZHkfQhoC7VqltmWaVczzjtzWqN/sZq2usunNVVOkIRmazAK0aWJ1vcw53rq/zb9knL+s
         vXpewjupEOq3WCEhlo+V1Fh2SWKrUENX3MIAZ+5rv1M9CBJ5AdMrjPpTQx3RzksmeR7+
         3cUbyHzQKhYTYulCwWD8eU8FQvnMM+2o7YQYnFbmBQ/eqm1BtFXDLpbqAa2NMOVOaXOw
         h6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzuPlS/UNcLJ4Bomz98nuTAfqcodHr3P06NyfOkeiuWH6S2SFgIoVxuml9j1xJE/rk5Xg5/K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGPgGDuGyrqToB+jakVl//aR16G2Zgff2odHQMXG/9WIH+tpWh
	aibI3URyVD0ocEwZNBXYIknlJDL3ZJglqpdEcJJNPlokOpaZxo12eQzm+j/udaA=
X-Google-Smtp-Source: AGHT+IEPyItpR2bACoedLZ7pWA5hZAWhYY365d5rJb/PygA+fYSu2UVo8ep34qzIyn6ABHTDoGcUVQ==
X-Received: by 2002:a05:6512:3351:b0:535:6778:952b with SMTP id 2adb3069b0e04-53567789601mr964900e87.44.1725443989971;
        Wed, 04 Sep 2024 02:59:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:74:3d01:559f:5c36:7f62:a0be? ([2a0a:ef40:74:3d01:559f:5c36:7f62:a0be])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891daf81sm786066266b.163.2024.09.04.02.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 02:59:49 -0700 (PDT)
Message-ID: <64732bd4-f946-4359-a3b0-19b3f6f10d44@ursulin.net>
Date: Wed, 4 Sep 2024 10:59:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/guc: prevent a possible int overflow in wq
 offsets
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org, Daniele Spurio <daniele.ceraolospurio@intel.com>,
 John Harrison <John.C.Harrison@intel.com>
References: <20240725155925.14707-1-n.zhandarovich@fintech.ru>
 <56362df7-7502-4b35-81da-f3fe9ff7da47@fintech.ru>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <56362df7-7502-4b35-81da-f3fe9ff7da47@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/08/2024 11:45, Nikita Zhandarovich wrote:
> Hi,
> 
> On 7/25/24 08:59, Nikita Zhandarovich wrote:
>> It may be possible for the sum of the values derived from
>> i915_ggtt_offset() and __get_parent_scratch_offset()/
>> i915_ggtt_offset() to go over the u32 limit before being assigned
>> to wq offsets of u64 type.
>>
>> Mitigate these issues by expanding one of the right operands
>> to u64 to avoid any overflow issues just in case.
>>
>> Found by Linux Verification Center (linuxtesting.org) with static
>> analysis tool SVACE.
>>
>> Fixes: 2584b3549f4c ("drm/i915/guc: Update to GuC version 70.1.1")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>>   drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> index 9400d0eb682b..908ebfa22933 100644
>> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
>> @@ -2842,9 +2842,9 @@ static void prepare_context_registration_info_v70(struct intel_context *ce,
>>   		ce->parallel.guc.wqi_tail = 0;
>>   		ce->parallel.guc.wqi_head = 0;
>>   
>> -		wq_desc_offset = i915_ggtt_offset(ce->state) +
>> +		wq_desc_offset = (u64)i915_ggtt_offset(ce->state) +
>>   				 __get_parent_scratch_offset(ce);
>> -		wq_base_offset = i915_ggtt_offset(ce->state) +
>> +		wq_base_offset = (u64)i915_ggtt_offset(ce->state) +
>>   				 __get_wq_offset(ce);
>>   		info->wq_desc_lo = lower_32_bits(wq_desc_offset);
>>   		info->wq_desc_hi = upper_32_bits(wq_desc_offset);
> 
> Gentle ping,

With the current hardware this cannot overflow but I guess it doesn't 
harm to be explicitly safe. Adding some GuC folks to either r-b or add 
more candidates for review.

Regards,

Tvrtko


