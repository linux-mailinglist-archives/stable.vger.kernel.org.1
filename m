Return-Path: <stable+bounces-86371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CCE99F3FE
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 19:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89441F24BC3
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113641FAEEE;
	Tue, 15 Oct 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu/AMdr5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413A1F9EAB;
	Tue, 15 Oct 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013152; cv=none; b=Sz23Tdk2tJukbt3bWAur8PB1zZkEUQT7sLVaR8Y5X5hO2a4eSha9a4a0md8/tnCHa6kWle5a/X/IY4dBGyFZxBm8LLpHfzoRmwVE1MGvRXGmty23FBqmdj1UySlKT7Lz3P1FQ0slxAaKqiJKpzrWRMkio29D1ZBwFClLZkbUMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013152; c=relaxed/simple;
	bh=LKr6eCiL7zYXhzK7DIIDARWLKtxeLAQBHXgdBh5hlVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnXKAh6xD1HphQAomefiCPkLOB8eTx0fwDntL56ESco7rzbIian6a586gv7xx4EC+IcvJnP8RSyHhRI9GCqTaO/GK4kwsCM4UA5dLBriwPftTrIRK0lwtV4ZBr2ofBPPyOPv0RS1eLNOWrdrLQEYc+E1crl8A9g9qzFQt6SYWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu/AMdr5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45f07eb6f5fso698551cf.1;
        Tue, 15 Oct 2024 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729013150; x=1729617950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GcQX3JDDWbQMMy3zmo3DJsYBI0G7ZbUEVumODIsy6Vg=;
        b=fu/AMdr5DAEv76ZD0ZoZR4Kyp/sMH3r469U93q/jDrwRpRvlob5jliaVaCA7q6xpyn
         +ojX7unJMXUfVEzEsSSDBIc93VNWP6wlXvHEQfn+ZKgWdvfGmasHAv2kc8f4dbypoFpu
         O8fb9Vx8vTPu1GY/mo8r/uQIynXTHJPIlIKFWurY0//3rCSP7FTlFKu0hxtfU3mybp7I
         lBqciHzSW9ZZiu9sTLQMmgS6Az1zz1+te3sKxOAeV/w01hnYny6ntL9Z3rRC5HerwhdA
         mZreKUOBybhzZe+hqEShsS2Bf+tw4d2mEnzmXjTNhcJux37fNS4+6L3grBhUQVKtOBiD
         OKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729013150; x=1729617950;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcQX3JDDWbQMMy3zmo3DJsYBI0G7ZbUEVumODIsy6Vg=;
        b=YlqKNkGfyvSsYgwewXrTqQ5/TN2MdQsVL1KM2g4uyoX0Tuf8dz2fSxggxpDz2G5V2J
         otGNlfua3Be77G1D278XY8+nUCU5adtiV0VZkTyMj+zSMXrg0pXn+uCOmljTyhmDzcau
         pZd6qfNDmuoqnziebdi+cCbD1/WOcanVxjN3E0djJ+YpNqYc/9tSxM8rKRo+BbtAjweR
         bjkpK0KHj8zjQ1KzVRymczk7MSWGe0dZwP1ASnRiP+dJ+Ec1AK89bT1ptQIxLrLvy8vg
         wEFayJyhf9vF7Zq/UIw0JOQpXZQ+52kkSSnBQeEDwdvBcaceL0D+GT2aazWtpuqLb1iO
         eCow==
X-Forwarded-Encrypted: i=1; AJvYcCXuIA5CLqmUqVvVLtgruH9kUJPSWsRqjGh9nSL753yHHMFVZkRT4uc9n9o6kXZI+vHMa5UsXL1pMZTK9Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8H8STCkjPOk+9OtCbDzEWowsNXdoqyxvQ0kkX9q+Ra8e/vEE
	liXwqasMNitNqRpf+VDL3ylL5G2xYIEHgAFSHRaBNAYIBmBk8jk8
X-Google-Smtp-Source: AGHT+IEXtMXDhseytBs9YZS3RYDMOm4+vsvSyB5wGvEdzqO9Cy/WdLwDUeU+Ap6k+599pNFAYoifhg==
X-Received: by 2002:a05:622a:cd:b0:458:27cb:a5e4 with SMTP id d75a77b69052e-4604b237603mr281620371cf.1.1729013150132;
        Tue, 15 Oct 2024 10:25:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b36f551sm8659301cf.62.2024.10.15.10.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 10:25:48 -0700 (PDT)
Message-ID: <7df2134c-a2fa-4cb8-8d57-e06fb7f62bca@gmail.com>
Date: Tue, 15 Oct 2024 10:25:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241015112440.309539031@linuxfoundation.org>
 <43399648-ea75-4717-b155-73541deacaba@gmail.com>
 <2024101515-timothy-overdrawn-b3f7@gregkh>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <2024101515-timothy-overdrawn-b3f7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 10:17, Greg Kroah-Hartman wrote:
> On Tue, Oct 15, 2024 at 10:09:15AM -0700, Florian Fainelli wrote:
>> On 10/15/24 04:19, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.168 release.
>>> There are 691 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> perf fails to build with:
>>
>>    CC /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/evsel.o
>> util/evsel.c: In function 'evsel__set_count':
>> util/evsel.c:1505:14: error: 'struct perf_counts_values' has no member named
>> 'lost'
>>   1505 |         count->lost   = lost;
>>        |              ^~
>> make[6]: *** [/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/evsel.o]
>> Error 1
>>
>> seems like we need to backport upstream
>> 89e3106fa25fb1b626a7123dba870159d453e785 ("libperf: Handle read format in
>> perf_evsel__read()") to add the 'lost' member.
> 
> Is this new?  I can't build perf on any older kernels, but others might
> have better luck...

Yes this is a new build failure, caused by "perf tools: Support reading 
PERF_FORMAT_LOST" AFAICT.
-- 
Florian

