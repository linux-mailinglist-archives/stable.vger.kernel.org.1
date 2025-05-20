Return-Path: <stable+bounces-145724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CBABE76E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 00:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3327716ECD9
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 22:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89DB219A80;
	Tue, 20 May 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JIuesaM7"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3A1CD1E1
	for <stable@vger.kernel.org>; Tue, 20 May 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781179; cv=none; b=ZoNu3vBgmAWpjkJjMlgmoIT1pa/YTxLPZUJ/vMMny1U+5NLFZkFLUgqQV3wNwb1UfX7c+dc8j9Et8oOpoaQxJlCHS8w+aRkcsHSYFEaSHKE3jRiScQnl14P8zXZv1V39E5p4lZ73QGsf+cWY4I7Z1CNg7K7OQruD9IDt8tSmhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781179; c=relaxed/simple;
	bh=xU1qrpva3srGXzaRllUISS4qZ9R1FkREbCpATdGX090=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQIebrPCpe8DXDhsKKAYhVC8j8epGs7dM8OsasD7jG1sgAF1gS54UkETiCVSKfiIFKPSI65h0G9Bdw5uTzX1d8vC1fI8qJ0Zsld55LoIbL1/Bavo1bYBOq0jbGHTHusyx3H8vQlkqu69lVqjM9LAU8xfsF5bC4PHCG3whCNqnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JIuesaM7; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86135d11760so492680639f.2
        for <stable@vger.kernel.org>; Tue, 20 May 2025 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747781175; x=1748385975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBK2iNtnFXG+56awWUtYZcqCou699Pnyv5HV8iziaWs=;
        b=JIuesaM7weI+iM93RjfzACOI6VFPOqHYt52beJBVKQN+EBwLUnKywffDLZJTQMxmOM
         zf09Q1sTkNDkxl9/IGuUAaeLAy8CkEyCuytFaR0hSoxiorXMsTqv0g1L2lte7x2lgkkp
         EQgpXhYrsBxxknpdnrdgLOLZbthEBfxIFk4+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781175; x=1748385975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBK2iNtnFXG+56awWUtYZcqCou699Pnyv5HV8iziaWs=;
        b=wMdEl1Bk0y06xjAlBmyVIyBOiZH79NYyIqACWReSnjkyZH8cdELP4PuwP5pJCjyiB0
         2XuAWCJNuag1zgi1J5uH06N+jySueGcgwded8rYyj+VlByQW6dk6OqFsBurEC8EShmb9
         WWGoU5S2vV8kQeBGScHkpRQJjZgY0Oqw2PIaKxSvJympL4tYOxVUEcUyagqGAIOZJPPb
         qf7EwuSrkJTJnWjCJt7GbIblyUdE5gfWpk+Pp+3GQtYFA6WgJOx5Upj8+CKq1wzWm4kU
         BIWwSdYWRhVEf+L820gRasXBfEgoF6cG7GrFjz8wQDCn7Cu5Qdih6zUD2A/T1HCBKB/g
         Dxcw==
X-Forwarded-Encrypted: i=1; AJvYcCXKHwjh0Iyi0UrE4eFPmUuws35ZecL+r/ViAej4MniTqwshn+jMYdQ7zdT3k2UkEyxflsXYICU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhpwNGWktA1UZgyUW9p5Vf1anbANkNNEf2yqSHhFxZnO6Olle
	PMEWhLA14kZ3T9vnbIqYQBplsz45shoU1oxMvV4eKprVQDkICEQS8Az//eTHsCW9wLk=
X-Gm-Gg: ASbGncvGP5anhU9FtaJFTme1dg8XZv8dPkg1lQZj/MPVmDTVLBzpksGZfPFTz3W/4nY
	0IpFs93uX3gY1ctCNjly3cZt8kAEmWMLtZVsZ1a+EJ0EK6fHE0m4F5PbYrhgt1XAu6Tn67gX0R7
	hlWSPGf1iHplhnVHH8zS7tkVXVhfgZNO3smZ9GFD8pw1EYMtFZJ+Ep6nvCRI0p95tdhQm8S7znB
	dnRND1kvEU5T08SCbnmrhpjfA3c4XKTwnRZzISJzXUuDXDFJtDmMsU7tG1BlH/5N00C0k1chw0i
	LVP8WZE84SBVxcGOkrSuuPaXbHp5SSVr0I9xPbZ1RIIJJr4N4xCCC/0yhvpzejBKK3kcC5f1
X-Google-Smtp-Source: AGHT+IGaYckQ1ocB0rCSKdcZon0qF7utkxxlGcyX9+/b8GAs+CN77IZYj8Y6+RKi+IUPbifSGPiiMA==
X-Received: by 2002:a05:6602:4808:b0:867:6680:8191 with SMTP id ca18e2360f4ac-86a2306ee1cmr2732619239f.0.1747781174829;
        Tue, 20 May 2025 15:46:14 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbe649f14asm1726634173.79.2025.05.20.15.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 15:46:14 -0700 (PDT)
Message-ID: <d2cd655a-7375-4870-b6a0-757721ae183f@linuxfoundation.org>
Date: Tue, 20 May 2025 16:46:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250520125753.836407405@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.184 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.184-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

