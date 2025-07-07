Return-Path: <stable+bounces-160353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36997AFAF68
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 11:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D37A1AA370C
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292728D8CA;
	Mon,  7 Jul 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKz4l6Bi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790435949
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879776; cv=none; b=psATxBCTRsOHC6n4C2dDmjU4RxO/DuzKRhprV+aYfZqLB8E0TIb5xFRbISaa0K7PPJNpJMCIw9kN8e3njRLC3SWFFK00LRaDF3Q12xal5iah0wuCMFyBdZIRqKDHSkd07g3NODiC1CixGjqslI7UMOFcJ9P/kenyxfj2eC8TscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879776; c=relaxed/simple;
	bh=2N0U1EDqI/jQKzqP2h1Jsj1CKcBZm2BCirQSwgH6hIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uj7hvtJjLeUthLv8G3F75N7qg4N1bEgt5bN8YL5AgexnsVFD5nw7DSPOBVr5nJi7BzO3yJeHFewuSeRcwpirZ7B4x7BM1hrUK8tA9FkYX0TEZKO+enlKSDJ/WWv2rTkXnfrGNpCSj/I51srBVXOKE8yMjSh4RmQWfpa/k6q0f1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKz4l6Bi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2797756f8f.0
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751879773; x=1752484573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PSMRH5QDvCqW5KnIuvKRJN2G/mVFdVuXbgUbVefRVkM=;
        b=wKz4l6BicRPAH8Tcx9JEwTsy7t2f2Dhfub5lrK+q6mJmzwinjf3PHwigni2zfviSpk
         oBoQ1QQfgHHzmSZDazPEHpvWSQ5dDsmfez9xFDfoPQDdjMffkhncJGiXVRml3qjUR24M
         NFucxuvIhmqKYR/lmz69dvvyakmi0xlr6WI6WguFKAW5/EO2RN9264c7ZwMvejQCeG0r
         4mswesWiNMnU2U6D2Qddfpc9Zie07tNFZhFzCOte3xaK6xkOWEl0FV0OgaNSOIQED3VQ
         1AzBmMaNq0APaXUc+TBz1B0MLCRwwC6MrCTypZ1+ZMehIY0pr6iiMdAIJ2kDhYtOrRkz
         K43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751879773; x=1752484573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSMRH5QDvCqW5KnIuvKRJN2G/mVFdVuXbgUbVefRVkM=;
        b=m9uNKk6O6DW5Zp+zc1Aef0C8nrwKkjSTFJtqWZe7gPtptzUoSQiFqQfipDIMxOWjso
         RJKidlcBMFkRssJPyo+2dv6Pim9psrOifaWMePiRChSmydM4zR835Ay8PgIJZZVdD6+K
         klEKFUrF7Pz+OerIvdDI85z7ZCoI+EiKViW9NpmjCQ3bxcNPmgNAzQStkIDTxvgndmwd
         7JyVzyH1X/RA+VFC/pCuikJvfMUAapXYI/j04SvJDodyEr6RdfZnjPrt0l8gdw3yW54I
         hX/mp50A0Su2dWtQ8ZM/XOc9cefXtSZwFiXCtEUVGHyWgEgU8JM6VYakiIAfisZpqT9T
         qx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF9wpoHv9sHNIX6LL7dINC/Do0jAD+YhU6H0sbe+KpSElbNEe6eday3WAcmYL+EPA/tjDmANQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKstAM8hUNwVjMEKtrd7DHAoromp5H3dhFV5fEQSX0/TQhsEE
	UmRZdVqdb86OVMhae7p6JbLJSPtCSlU04VbQVzD8iNx7hK9b2MbU/sZxsskU2RhIFrs=
X-Gm-Gg: ASbGncuQ7rO7EZPpBVk6xdN7omQsgHMMrpo7piCzcZuf4VWI/pUYgaV9ueG0Jl5odoP
	qlNydE9mtVvLc1jQtykRudJ08K7uYEbpgCldLbFQsNniykfjSR3rrB5ExD66mFblZyHMC/X21he
	n5CcjFlFW0E47/Km/T4EoktwDgHWRq435XNYzbqhl7cCpOZgzzJeNVWtUrbvOCk7k+ivpnvp5yk
	btusIcJcKlt2D0pEWbSc5H3URmpM8cJjhkQlC/ekfd8anFHVxCUvtRcWRIZL7S26AKQzvFW3rww
	ofqhv/gwkyuqZnzz9hg8kVX+4MW1RTHcdR9473vR5f/cizz/nJg+2JzWnWoBvbdI4/U=
X-Google-Smtp-Source: AGHT+IGGCWZfAUj4VNzkhRD8HfhSu3KCxQFzzdO1XpeV+D2rkMvRTzngh9EBKomoGoCaM7fN+nIbCA==
X-Received: by 2002:a5d:6f1c:0:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b49aa0e8e8mr6353994f8f.1.1751879772702;
        Mon, 07 Jul 2025 02:16:12 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b9671asm9687980f8f.53.2025.07.07.02.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 02:16:12 -0700 (PDT)
Message-ID: <207d1f3a-60f6-4a8d-8adc-e03e95f198e7@linaro.org>
Date: Mon, 7 Jul 2025 10:16:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/139] 6.6.96-rc1 review
To: Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Yeoreum Yun <yeoreum.yun@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
References: <20250703143941.182414597@linuxfoundation.org>
 <CA+G9fYu=JdHJdZo0aO+kK-TBNMv3dy-cLyO7KF4RMB20KyDuAg@mail.gmail.com>
 <CA+G9fYv4UUmNpoJ77q7F5K20XGiNcO+ZfOzYNLQ=h7S3uTEc8g@mail.gmail.com>
 <2025070605-stuffy-pointy-fd64@gregkh>
 <20250707090308.GA2182465@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250707090308.GA2182465@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/07/2025 10:03 am, Leo Yan wrote:
> On Sun, Jul 06, 2025 at 08:55:32AM +0200, Greg Kroah-Hartman wrote:
> 
> [...]
> 
>>> Bisection results pointing to,
>>>
>>>      coresight: Only check bottom two claim bits
>>>       [ Upstream commit a4e65842e1142aa18ef36113fbd81d614eaefe5a ]
>>>
>>> The following patch needs to be back ported ?
>>>     b36e78b216e6 ("ARM: 9354/1: ptrace: Use bitfield helpers")
>>
>> Thanks, that makes sense, and is easier than me fixing this up by hand
>> like I had tried to in one of the branches :)
>>
>> Now queued up.
> 
> I built for the Arm target in my local environment and confirmed that
> the build failure has been fixed on the linux-6.6.y branch.
> 
> Thanks for reporting and resolving the issue.
> 
> Leo

That commit only fixes it by transitively including the header though. 
I'll send a proper fix to include it in coresight-core.c so it doesn't 
break again in the future.

Thanks
James



