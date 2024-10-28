Return-Path: <stable+bounces-89063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B999B302B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D9828107D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE131DB548;
	Mon, 28 Oct 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5FYrXGX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAF1DA313;
	Mon, 28 Oct 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118409; cv=none; b=H7UFHfxwDqEpRnDN0NPWwacsWC9DlnF1+exREBHcieukPswRk2nxGoKeBn5mFr9D65LVl4mUC/HoPRo+eEBcHUrGoAnw1+G0MHF4cgStCfQvKKIyth72O7eTCRolu+FN1pcnRyWTJc6/slGoiFiNNnWAFzSG8ToF/NcotM7aUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118409; c=relaxed/simple;
	bh=F1Cn1OL1mypf4cS71UxXHCw5sbhvfPk0IMePBRByXI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDNQiYflj+rhpuD4mkm+3qqKWrB5UNFMF+G3wKhJMgUsUlhLekqmd0SZyjSrUD3ci3kvXrah5TPL7llXDWANux2luyPb2LDGh9wpj04GqSGjhSCHVJAJ8feA6K+e76FUl9H7f6/hWTtraUbl75e9l7cB53cYN/2rBPCC14rlCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5FYrXGX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so42865695e9.2;
        Mon, 28 Oct 2024 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730118405; x=1730723205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaMoJV26f6iqcPHM609rRolyRmJ7XA3Ylcaj9EhtV1s=;
        b=g5FYrXGXutTM+fUWd7mBoMBBhraNxba5fIK3PsiPrXEKU/xHlR+3Lai7t9LhDeJvkl
         BuwwV+Os9H2+xYe99biBkmxXfrHQWV0ymRB1A4hPY65is3RzkaxHepeHWGRbUzV0bjN/
         1Xvysl8EdQrNFdOEPs3jHHcUJTB+nliUvzauakm9L0suvG9Y1M7kzL80SyRRVllApRzm
         8XxcMcYDmPiQ74AG4xvY8yabNGRtLCgUrSF4jQQEUQPqSIgw8tKu1oCzyKHfKJKqbKVR
         eIx1dsPw/HjbB0sND1eYdvkQg+ZGJ2i1dXTL+Qu+X3SjFsx77wpNeR99/G/AakAOoeDF
         rgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730118406; x=1730723206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaMoJV26f6iqcPHM609rRolyRmJ7XA3Ylcaj9EhtV1s=;
        b=WZG/4Ac2ZJsSnEH/CGjSsWES5F+UewiWBqV96b+s9ilrR3jD6UH6mbfAyrN0/tZXUi
         cwILSUAynW+DvQ3644r2k+W7GMqLoYD+59hseLlTxwqY7vmZjgO8HQrjl0FCybl+5eBM
         nxkaRu0/7LzRTFqTlGFB9JpqaYVnWM6N3OUtAgqMYduVk4POGNub0y3KNQldt7zqonnw
         BvQjO/Ndmi0CS7P7qve5VEwuI/iuzLPonBLgngB6vITDF6Pv1crmidcs3Q8efcSdar0i
         FaXkBZWubMJDuBXKDRdg2/s7VOmhxs9k3YnsmR+ZDANDXS1WsnnATmhDBHYfDvB+lMfg
         6K+g==
X-Forwarded-Encrypted: i=1; AJvYcCXX98AXQ8RTvJJez1OnR1BgDgKUVf6sb8pn17giPRdmTyF+khwnYSe7WN+mkFPrtbR2F12j6Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZjEiSjjM8Z0MQTxd2whvA4kk7ugn7pX6uh/mLXgr6XMbpVvZ
	Mz7aq+g0mIZTakXCmsg4byrB0TBwGKJB1KElX9OVZjtK5FeCaZXg
X-Google-Smtp-Source: AGHT+IEgz3MjW/RIHp0JsAJfZ6NmNAuPPgThjTX9drL6n0JMSxMKSAdqvkjvBk4s6JgIj2AsVmjXbA==
X-Received: by 2002:a05:600c:35c6:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-4319acb105amr80041225e9.16.1730118405302;
        Mon, 28 Oct 2024 05:26:45 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:b273:88b2:f83b:5936? (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567e18sm136630355e9.26.2024.10.28.05.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 05:26:44 -0700 (PDT)
Message-ID: <e7ca7a5d-749d-40c1-893f-da3d593eb4d4@gmail.com>
Date: Mon, 28 Oct 2024 13:26:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: fix child node refcount
 handling
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241013-timer-ti-dm-systimer-of_node_put-v1-1-0cf0c9a37684@gmail.com>
 <5a535983-6a78-4449-b57b-176869fd55d8@linaro.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <5a535983-6a78-4449-b57b-176869fd55d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/10/2024 12:24, Daniel Lezcano wrote:
> 
> Hi Javier,
> 
> thanks for spotting the issue
> 
> 
> On 13/10/2024 12:14, Javier Carrasco wrote:
>> of_find_compatible_node() increments the node's refcount, and it must be
>> decremented again with a call to of_node_put() when the pointer is no
>> longer required to avoid leaking memory.
>>
>> Add the missing calls to of_node_put() in dmtimer_percpu_quirck_init()
>> for the 'arm_timer' device node.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7
>> timer wrap errata i940")
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>   drivers/clocksource/timer-ti-dm-systimer.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/
>> clocksource/timer-ti-dm-systimer.c
>> index c2dcd8d68e45..23be1d21ce21 100644
>> --- a/drivers/clocksource/timer-ti-dm-systimer.c
>> +++ b/drivers/clocksource/timer-ti-dm-systimer.c
>> @@ -691,8 +691,10 @@ static int __init
>> dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
>>       arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
>>       if (of_device_is_available(arm_timer)) {
>>           pr_warn_once("ARM architected timer wrap issue i940
>> detected\n");
>> +        of_node_put(arm_timer);
>>           return 0;
>>       }
>> +    of_node_put(arm_timer);
> 
> Best practice would be to group of_node_put into a single place.
> 
>     bool available;
> 
>     [ ... ]
> 
>     available = of_device_is_available(arm_timer);
>     of_node_put(arm_timer);
> 
>     if (available) {
>         pr_warn_once("ARM architected timer wrap issue i940 detected\n");
>         return 0;
>     }
> 
> 
>>       if (pa == 0x4882c000)           /* dra7 dmtimer15 */
>>           return dmtimer_percpu_timer_init(np, 0);
>>
>> ---
>> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
>> change-id: 20241013-timer-ti-dm-systimer-of_node_put-d42735687698
>>
>> Best regards,
> 
> 

Hi Daniel, thanks for your feedback.

Actually, if we are going to refactor the code, we would not need the
extra variable or even the call to of_node_put(), since we could use the
__free() macro. That would be a second patch after the fix, which could
stay as it is without refactoring, because it is only to backport the
missing calls to of_node_put().

I can send a v2 with the extra patch leaving this one as it is, or if
really desired, with the available variable.


Best regards,
Javier Carrasco

