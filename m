Return-Path: <stable+bounces-78555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81B898C1A6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDCB23548
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DF51C9EA5;
	Tue,  1 Oct 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ni7x0wYd"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F11C9EA3
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796589; cv=none; b=XNWnRPID+JVA9Fbcb+eRGl8/VoWFogmjUAV3flq+fOFnOmjQ/u7AKZJFEFEmbQbMkQ7LJmucT4h2J5RY2L7goXobBAaoqs0yez85cgLFw7ptDJBIskXu5moTZalMcnp5kjuj0JNjoiGkP/ABD7t4tvop8SiM8f82UsaPqUUSbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796589; c=relaxed/simple;
	bh=ZwniB2LFXhfzJyFwXNkLoVJOnq+tKNhRsmGLkOFkk+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3TqVvV/t4PDl4xogGImsv3IzicHDciAhzmq0lC7gzWu7xsA9COpJk130AcvR+V34LH8MbQP2DN0fBcxXBihq9zM82zmNsg2boCeDb7dyi2VbyM9/MlTRA/TRwTlxuFEhF7Yf123Op5uk9phyIRkSISz2ZuThALXUBPSqktyCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ni7x0wYd; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a1a90bd015so20617105ab.1
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727796587; x=1728401387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdXjh3cuvbgdUl7ktHFOTyKRyEztBlzj+fhmF0/YVnM=;
        b=Ni7x0wYdqwA4xcywUGIP7y1sQaLweeDvu6u/BDByW+8H7fDCcZlKrZoh4nLuL4oLYE
         GHcKtDfSKIEUHmiFZKAJsfIlyToj2SwXYjQK0tFXAKFZM9MNcv/48Fjak4iLF9gG7hyo
         SbsxgA6Ar1Ae6mmJdFaA0xfRSO5+wxOqjYXJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796587; x=1728401387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdXjh3cuvbgdUl7ktHFOTyKRyEztBlzj+fhmF0/YVnM=;
        b=a0CKX46ylCNJbv4LN9uhKxf6Rb5duNFOgILkNZB+hi1A5hW9jW5nqiV3ef3N4CALwT
         Zp4S2bJfVpwdqrw1Zhs7AH01KcVddkd3BLBZqCNhVDX0JU05ODwBgBLvHSlGo0Vmfvni
         M3ohSKKE8jtnuQ1UajQKGGymmd036WQAQ3Iq8//YGpUIyq7gF6p4uNKc+BzF+g1YcB9C
         Ave88YcRmNx03PU2SBBYzpNt+49ee3cJtsE5Uhjhr8B3pIb9vUiZDRX8Taearf63kyUw
         jlddb4MAs5Ucpoqhv/RTPEztHFjvdK7YH+qboeWNxB5FMRhBovvPWKjo+QsuyLWDXe2F
         +Bvw==
X-Gm-Message-State: AOJu0Yz2fyfDVDJKBbwhnbA1nCHeEOgXvYYV5kAD0Of8JOfhWnRU0s9F
	z54hipERJFptEMOfuwkOqE3CZfrO6WBMcox7vvwDEbxGTYV6RYAs5vke0E/LI6U=
X-Google-Smtp-Source: AGHT+IF5+CpB9pv/tCZIejviLTSiAcp2QzI9FVrJed29txutVp5Uz5PFZ7IAZOv5gsS79yrgmSfRCQ==
X-Received: by 2002:a05:6e02:1b08:b0:3a0:52f9:9170 with SMTP id e9e14a558f8ab-3a34515c9ddmr149859275ab.1.1727796587021;
        Tue, 01 Oct 2024 08:29:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d927f6sm31645525ab.51.2024.10.01.08.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 08:29:46 -0700 (PDT)
Message-ID: <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
Date: Tue, 1 Oct 2024 09:29:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
 <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZvwPTngjm_OEPZjt@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 09:03, Jason A. Donenfeld wrote:
> On Tue, Oct 01, 2024 at 08:56:43AM -0600, Shuah Khan wrote:
>> On 10/1/24 08:45, Jason A. Donenfeld wrote:
>>> On Tue, Oct 01, 2024 at 08:43:05AM -0600, Shuah Khan wrote:
>>>> On 9/30/24 21:56, Jason A. Donenfeld wrote:
>>>>> This is not stable material and I didn't mark it as such. Do not backport.
>>>>
>>>> The way selftest work is they just skip if a feature isn't supported.
>>>> As such this test should run gracefully on stable releases.
>>>>
>>>> I would say backport unless and skip if the feature isn't supported.
>>>
>>> Nonsense. 6.11 never returns ENOSYS from vDSO. This doesn't make sense.
>>
>> Not sure what you mean by Nonsense. ENOSYS can be used to skip??
> 
> The branch that this patch adds will never be reached in 6.11 because
> the kernel does not have the corresponding code.

What should/would happen if this test is run on a kernel that doesn't
support the feature?

thanks,
-- Shuah

