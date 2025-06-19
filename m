Return-Path: <stable+bounces-154812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E4AE0856
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 16:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA3F1899D73
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 14:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25F527EC9C;
	Thu, 19 Jun 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lw979Pmj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9F27E7D9
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342146; cv=none; b=iTb8E17jGjWiT+oBPILOOgCPkbwelmLYXxFiX9fK55JG3KYdo+J6+EJ7F8BjCu3iwSl7jEKcQ42AJxCxbRHro7xitNQukNrAxNsz9ZFZyoEox5FMWD592fBghr9q6ev67uVl+7x53gx65DYIB1sz+T0A3t1+O9ON/q1vdKEBCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342146; c=relaxed/simple;
	bh=Z3mp+pLnY7BGoYlVnxo7q7p0R3vDpjboJWoVW0jlMFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coqxFJ1MaBwhcnBg0a9PXpk+9XMEgNli/zDkbjAmgHaUq4Y44XNgi0O8HrgYRYR4UgmVyoD4wjRGmIM3vkUtjWkJq9MvSg0dVqMc0umNGd7ilefmvjY7oP2GTMriwx7uNedBloKkcM2qL2AIgTdDZeIIKxPknDoNW0Az4kK9xo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lw979Pmj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so443286f8f.1
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750342143; x=1750946943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uL1csz/rxe6tsI50qrJ0Y8JbGtRsq5liGnT1Pc42Q7Q=;
        b=lw979PmjY2e72LrEwiSLHn28YxE9zpwdPa3k5BpIyYOKcbzk4x/+zkJKHUAaWugNyM
         RlpgQsxv3v/8yIjV2NRXb+DCda7gL+K/GY3I69sxnxEzFxYVM2/AUgSSthOUW+0WEvo8
         I7Nk2Dt5Xwr0Hhi3s+cGHH/Bu+Mum1u68Dll8qh3wPViXknshyfTI3T38y6r+tpncDFp
         UIkxIorMmicKrD6oL0qFClJgq3NEipwqn9oy5Wd7kozJvFvkH0QiwP97cPNy/07X2HqN
         jEJMsjbcGHA1wRpOhDp+fJdWgem+lZfq0CF6j7yL3aqQ3/8N324g1z4sPO+yhqih1twl
         7gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750342143; x=1750946943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uL1csz/rxe6tsI50qrJ0Y8JbGtRsq5liGnT1Pc42Q7Q=;
        b=mmuhmry93vX/3r3mDlG9YPzBiiAe8cb6+kcJjlqpSTFRCN75M9fASzTOwWt1vb4RsN
         ZyIy9fvjTViB9JrFWUtEmPFrk37/nb8785ofvOVXfD5P1yIlFkVSooCzg3DXLrsXnJTM
         9aYCDFmCYqidxdsrWmgh0bl+0X8/7mzOnfA5D0kOIaajz6cxQWqlsmSeF9RnRhrUwCuP
         pgvT/pN86uFpbH8N8elUYTdZj4UwxDyvbGza0BwS0gV2Zb6hkHiK2ZyylmLP5BDohu/t
         OYF5YdUsMAhzNvJPEuL6zOMpBD5Qu5EPPUE6Hkx0LRhYrwh/QzUOh0/AjwpgcmvHnN9t
         /4kw==
X-Gm-Message-State: AOJu0YxHLDwlDU5Cb3y71C8PBFVzR69WCiqYrtrg1pHqui6dsljFW1iv
	0VxABh1e7uUG+c0fsDmX65A3FU+/Y6oIBjzJwA4/4qZz9P5v7Dg30kmvZ8J/qWugruU=
X-Gm-Gg: ASbGncsIa8yl3oky8zLNSGvDlfPlFBvn9CHkyPSsJ37iQ4P4gFlaekhR1Qd1mRk7thM
	aseluZ6GhEwXVwPz3fclct1wz/ePRXHYQHHaEReoC7ECIBpMoyQD7NrukwK2enytM09S+bUWM0Z
	9npJSv3Zqg3I1wfhUXWnTL8tQS5BAPPPKnS8xl53/MWXzD74X7W6UW7NhIAeZ87MnnCQ40t+lB0
	dqclFWXd7MtNvdcNLd9g2RZlLmdzTjd3Jwh8jBjJuolSEP/LKkTMn/O4UvtcTtlGKsjZQSOUPdB
	9ZNJ0sQjz+Eg7ldePw4BN7SYpvCMKE3j8B73rspHULctMM+1Hm5x+O85Zo/0Ki14EqsWGw2mkUl
	GZ0tvmQ5f1OssQQL1K/M9BhcxC/PU2dKQ5Gc=
X-Google-Smtp-Source: AGHT+IFIIExG46UX/MB/ru/b4nPulXf/JBYWMq9osJ7zPuzS2h623U5wdO9+t5qfSWtZvXnXzhnU9Q==
X-Received: by 2002:a05:6000:2dc4:b0:3a3:7077:ab99 with SMTP id ffacd0b85a97d-3a5723af862mr16973684f8f.45.1750342142737;
        Thu, 19 Jun 2025 07:09:02 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:b058:b8f5:b561:423c? ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a734b5sm20002737f8f.33.2025.06.19.07.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:09:01 -0700 (PDT)
Message-ID: <2ac47529-d72b-4de0-873e-247cce7c3c1c@linaro.org>
Date: Thu, 19 Jun 2025 16:09:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 296/356] ath10k: snoc: fix unbalanced IRQ enable in
 crash recovery
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Sasha Levin <sashal@kernel.org>
References: <20250617152338.212798615@linuxfoundation.org>
 <20250617152350.087643471@linuxfoundation.org>
 <a91ca229-0603-4385-9f9e-01f3c3ede855@linaro.org>
 <2025061953-alarm-oxidize-1967@gregkh>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <2025061953-alarm-oxidize-1967@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/25 06:21, Greg Kroah-Hartman wrote:
> On Wed, Jun 18, 2025 at 08:06:45PM +0200, Casey Connolly wrote:
>>
>>
>> On 6/17/25 17:26, Greg Kroah-Hartman wrote:
>>> 6.6-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Caleb Connolly <caleb.connolly@linaro.org>
>>>
>>> [ Upstream commit 1650d32b92b01db03a1a95d69ee74fcbc34d4b00 ]
>>>
>>> In ath10k_snoc_hif_stop() we skip disabling the IRQs in the crash
>>> recovery flow, but we still unconditionally call enable again in
>>> ath10k_snoc_hif_start().
>>>
>>> We can't check the ATH10K_FLAG_CRASH_FLUSH bit since it is cleared
>>> before hif_start() is called, so instead check the
>>> ATH10K_SNOC_FLAG_RECOVERY flag and skip enabling the IRQs during crash
>>> recovery.
>>>
>>> This fixes unbalanced IRQ enable splats that happen after recovering from
>>> a crash.
>>>
>>> Fixes: 0e622f67e041 ("ath10k: add support for WCN3990 firmware crash recovery")
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>
>> If fixing my name is acceptable, that would be appreciated...
> 
> I can, to what?  This was a cherry-pick from what is in Linus's tree
> right now, and what was sent to the mailing list, was that incorrect?

s/Caleb/Casey/ I sent this patch before updating my name.

Kind regards,

> 
> thanks,
> 
> greg k-h
-- 
Casey (she/they)


