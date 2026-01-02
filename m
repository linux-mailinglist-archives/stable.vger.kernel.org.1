Return-Path: <stable+bounces-204431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13185CEDAF8
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 07:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEB813003512
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B81FECBA;
	Fri,  2 Jan 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="alXudCz4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D12C9D
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767336670; cv=none; b=f2E2FadcGihv7ibnXElEoc+GQmQ6DAVDKKBuMeV8vTaLGGIJER3nqB9piW6pS0D+9Y3OSwCn5C5usAOLQsjW4/B7GXI3AlBDd+4G29ZtYVEzv++enP7nEhkC5F+nlnTnFo62lFQPSQLZ72TlVp6N8DBY3SSlwUjF/IcsBh8AgGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767336670; c=relaxed/simple;
	bh=KtLHmMA0KgTnst4mIIuazHvvVQTrydXBMkF8NN05Wj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZKg8YAMHd7iIj3AkTHsuyEzU/cGWIpLD9W8kC0SAAXT34vP4vR0DzN6YaZQ9I4Ht7JcU/azQIrrq1lFZD4zAFORXYBBWiUgDzoHyeX5eW5sE3RY7uTtoEt5V6VB/LrV6pxE7IJMH4FP0KcM70N+K+vMozy5fN6UiE9v2zSsUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=alXudCz4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775895d69cso49906145e9.0
        for <stable@vger.kernel.org>; Thu, 01 Jan 2026 22:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1767336665; x=1767941465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hpQrTNwm3YyszShrc7DZ0drIuaJ2peMWnPJuSAGlVo=;
        b=alXudCz47fRKdb85D5jkymE/dHy67E13rS/Fx0jKyaHjP4iClRcSF2+Lhiff0fhaSp
         QqxSICsxOOW12jOyXbziyfvrJt+JCwjpPcjVsqcAokcxR+s92jVxKc6SQm+iWK1aAImp
         S1akj7CCNqqGo0vAsheuwRoroTVvp/U5qdMtsQiwEkFtrd3aNV6mdM0pjf8wK+pT1oha
         iZfdOpUYzuC5vRlsBK2tq3Kx3Olg9Le9iVtno7Eqa0ZjywhpTNCxDOq+xHVt/1Lxlsy/
         zwX2BdzqzN8yf5EyBJ3PVsObiQA5MDNYY3l9Spcos9KB4Iy14tA5L7EeM3VJWeAhmtE/
         H0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767336665; x=1767941465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hpQrTNwm3YyszShrc7DZ0drIuaJ2peMWnPJuSAGlVo=;
        b=XfvkJAfP+qNRIHCoLLnd74oNa+2sMoan5b7rq7H0GExwYXfbHWnXQWbf+cd1RITlG/
         AbrXvfk1pSl7XsHQWp5JsUWX4aPozV6D4At4jjMcDMudglkmqGxp5cSeUbGn596QgHr8
         F8Eb7bBLWQZ1EGjtgd6dtD3G1nUgLb5Ug4i6L8msdtx8zqpyeXCzXbrCCpQGvLEgir5t
         SbLJ78VSui6VnSGfuCQmI1XO6GJ/kCCy29m7foniekCGazJvEC36eiJS7nDqt7EMi8gg
         q1BVjD9N9QPoYU7j5+SJLYT7gsYKB5gbPfr3DvvCpoS+iGg/xtoooV8jQ73+uYP6Lp0e
         4nwA==
X-Forwarded-Encrypted: i=1; AJvYcCUxy+qWBx5Njlq7OOfTA2lmdq9cj3Y0epPRXmu7L9XsR1/V+XVBcEekEzZxABvklH3yTkoWs+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVrzRdGR+CGxrs8BYaGRArAwbDw3zewHQoErWC0/G1VDsZ7BR
	Xh3bmsWoLzlgEFzonU/8E2oveM6kQJs4KERa0p0LsaZ0IR4J6So6zPl5gCo/jFovX6M=
X-Gm-Gg: AY/fxX5cww8/twgF9QB0IwhtZtg7VulPXgEE38BfOM0DEDTWFox0DWsTLq9azFQhEIQ
	HqNPaqmXtWY3AcX6Snm8rlOWKuNb+d8O3YPmQY3ApOyFdMihowPjj9Tu9I06WFHECYs5BHBzNu5
	wQos4jth97R/TDnkMiR5aAhYCa3+vOOaTDok6Jy6WyRmgp0zCTEiU5u6V2pUNat8bgiwp+UovU3
	t9TY4u1xYYESTT0HGFF/Ufm30oMrI3kba7PLwqIal6P1CtU/E2KyVKrzLN34yuoSqWHGA25yZ40
	sq1C6TViLvMXnz67uGqStDgw+OO9P087BThwtHgTv/Zu65JmWgddImtYUUY9XHKFhlqvyzyKgX+
	JbG5n++gy9z20SQGUNAjTMIYXWkms3DVfm+FA8wo2sAKqpBlO9qqY/0oJ5RQbH4m57MbFFAPq85
	uG5EAYcZi1E63kBNe8Yia7rA==
X-Google-Smtp-Source: AGHT+IF68v7S6jIe8LbFTO5ivrVeh6lbPhFlQxBojLvMugVBqe3kYYVhpxZgzhYV2iodtfZEG+eZjg==
X-Received: by 2002:a05:600c:4e90:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47d19557183mr554474715e9.15.1767336664968;
        Thu, 01 Jan 2026 22:51:04 -0800 (PST)
Received: from [192.168.1.92] ([94.204.137.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm84134006f8f.37.2026.01.01.22.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 22:51:04 -0800 (PST)
Message-ID: <baefc4db-2e2f-4b20-b44c-eeaadfaa1c1e@cloudlinux.com>
Date: Fri, 2 Jan 2026 10:51:01 +0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/zswap: fix error pointer free in
 zswap_cpu_comp_prepare()
To: SeongJae Park <sj@kernel.org>
Cc: hannes@cmpxchg.org, yosry.ahmed@linux.dev, nphamcs@gmail.com,
 chengming.zhou@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260101003227.84507-1-sj@kernel.org>
Content-Language: en-US
From: Pavel Butsykin <pbutsykin@cloudlinux.com>
In-Reply-To: <20260101003227.84507-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/26 04:32, SeongJae Park wrote:
> On Wed, 31 Dec 2025 11:46:38 +0400 Pavel Butsykin <pbutsykin@cloudlinux.com> wrote:
> 
>> crypto_alloc_acomp_node() may return ERR_PTR(), but the fail path checks
>> only for NULL and can pass an error pointer to crypto_free_acomp().
>> Use IS_ERR_OR_NULL() to only free valid acomp instances.
>>
>> Fixes: 779b9955f643 ("mm: zswap: move allocations during CPU init outside the lock")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pavel Butsykin <pbutsykin@cloudlinux.com>
>> ---
>>   mm/zswap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 5d0f8b13a958..ac9b7a60736b 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -787,7 +787,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
>>   	return 0;
>>   
>>   fail:
>> -	if (acomp)
>> +	if (!IS_ERR_OR_NULL(acomp))
>>   		crypto_free_acomp(acomp);
>>   	kfree(buffer);
>>   	return ret;
> 
> I understand you are keeping NULL case to keep the old behavior.  But, seems
> the case cannot happen to me for following reasons.
> 
> First of all, the old NULL check was only for crypto_alloc_acomp_node()
> failure.  But crypto_alloc_acomp_node() seems not returning NULL, to by breif
> look of the code.  And the failure check of crypto_alloc_acomp_node() is
> actually doing only IS_ERR() check.
> 
> So, it seems IS_ERR() here is enough.  Or, if I missed a case that
> crypto_alloc_acomp_node() returns NULL, the above crypto_alloc_acomp_node()
> failure check should be updated to use IS_ERR_OR_NULL()?
> 

We have 'goto fail;' right before crypto_alloc_acomp_node() for the case 
where kmalloc_node fails to allocate memory. In that case, 'acomp' will 
still be initialized to NULL.


