Return-Path: <stable+bounces-194534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A207C4FBA0
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 21:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F103B8D33
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 20:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65A2EAB71;
	Tue, 11 Nov 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aaXNtQQV"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D833D6D5
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893687; cv=none; b=Dira/QxFbiaFx+cqMA7x5AEkd3CJXqQV5H8afpJecCD6USlud3g2Wc8SG5SiYqcD8otTxHJ5rEchFdVQz/E86WYTdPtZJfs0GLcm4UHxPXQMfv045Zu1zXddx/0hK6QCXxTBA4DJh0KEDc0Ue1wRXDppwtM2IjbvWm2jYbwcWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893687; c=relaxed/simple;
	bh=YEr04aoMcmyecPDZJfLTTNm/R81XpSd91kOBrbpoX5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhNj83eadkAl4II0ezDwJSwHG6+y6wg+IGIKzP9iA2ZghRGSu4Uszu+t6WB5OLYTKuEdWzzmSYS81CNv4wSB7a55y/M7lc0EUUxQbM3+mWoVeD//rmbSv9rNsEs3o+gLy+ZXDd5K1gS5WRQbDNEyO3z5/tqktS5rXhtlwRM/4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaXNtQQV; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso10952039f.3
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762893685; x=1763498485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5r/++3mVCJ9xD+Mh5hsq3AQxsTxN+uDvyJmdcqTQc8I=;
        b=aaXNtQQVT0QVZ74s0Bb2mWmlC27v3Ww1CcjHi9IRDMJQfXaIJLQwAfi2yb8ibsKBvE
         OG+Y5fudBEJy+JgiMEZbxpdGQhZ5cBABrHNUsHlGJF7acxt0YiMrlVT7peqeGO7QOlaR
         ukkgbEvwdobj6n79HUmW1TEmS8jzT8qLvdP7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893685; x=1763498485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r/++3mVCJ9xD+Mh5hsq3AQxsTxN+uDvyJmdcqTQc8I=;
        b=pj4yK+h/cOWkJyEjL41pXmpX+sg7qRS0b9smk5fC4bh1qOJ8nQHHhSvD0BOzyDOe4F
         n1rFsUbtw6AjRMEb0Zza8ne/1jpkgoaZYOWUycLNLQ54LaC0vlItyhj7sxE+zEnhZ+Lk
         WFDPdINELDvBREsPbMi+eW3+D1wbayBl0k+9Mpb4tiC1fd8TpciXfSjG9oURcwsaI8eo
         RMroDpALTkM3A4OckKLxudnSWv7+rUXBp+VTEe8CIJoSsvZ5zLlIW4wrMPaqlrKcwGzE
         kTF9JvbhLTqM2z5oTA3inI4pvuSDtxCFbHJc+ra00oJTp49A3SwZAPhCPb7Qy+wqOD/o
         ZIbg==
X-Forwarded-Encrypted: i=1; AJvYcCWG1+0A6PUM84KyKBzOkyjH9qHPAeL+DOy10oZevyoL68rdg/d2adA/6Ud+JW8L0Xkp/3C3tSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXv4HeEweo4+z3u7JPMFYeymkG+ccBVymzsXedsuwBlWeisufu
	sQBUT0YLZ1Sgx61TJoV8LDri0Jw+j/OLz457CYoFikVl6ML/oI/hqvEzSMB9+GhBE6k=
X-Gm-Gg: ASbGncsweIwnb7nB1m45C2PxxfGvZZuM8WEMuRryqzU2Y65SkVpGqxQZhH9Y1BV/t+H
	odRE/L1CJgW2Dk84otbyNh5j6x/yoBrc7LDC1IgxlBaBCTVnBBW9fSw/mHvqyycC35aig2jWEwp
	9Ouxf6rNXRie0vtDVdNr/YwULfX5K/hJ+1O44Cfl7wa0VFhCTQZKoaRZsN1Uie2CPMC5S17nTBq
	PUXwAPV2fvE2PeDzrDNeuadQ5UckpEG2sMctKFRYf8Scp182YmqSpHhexinFi48qVpX1UEuJ/bQ
	PRFKCqefDJSX85669kJRq7TMrsmkAbIqPGI0ivcPmye1lEdyVna23OuOCbbIkIJL2U9QB8pvxLw
	aGdkHErNY29pwXyeZHrTF1Dlk9RLdgwwM/wDff3TBduxI6sWaKEaGegkzkL4dCKqKY/NcDIq4I9
	FL/vq1FieoK8cyR17TOcwiXvg=
X-Google-Smtp-Source: AGHT+IHc85hYIBG9ds9G2pphrlClRxY7dfT0RUGyDwgFy2LVDtnEan/ZgMhySlr1XPzoCUV2ctuLfA==
X-Received: by 2002:a05:6e02:174e:b0:433:5e33:d424 with SMTP id e9e14a558f8ab-43473cff5demr8186165ab.2.1762893684483;
        Tue, 11 Nov 2025 12:41:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347338d4d7sm2687265ab.20.2025.11.11.12.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:41:24 -0800 (PST)
Message-ID: <b7cc8106-6383-4035-bf9a-f3abcf0b7da3@linuxfoundation.org>
Date: Tue, 11 Nov 2025 13:41:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
To: Slade Watkins <sr@sladewatkins.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
 <641427c7-0069-4bee-8e6a-53347654a926@linuxfoundation.org>
 <07d63659-72b1-43d0-9139-2a0b6d73edd4@sladewatkins.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <07d63659-72b1-43d0-9139-2a0b6d73edd4@sladewatkins.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 12:47, Slade Watkins wrote:
> On 11/11/2025 1:00 PM, Shuah Khan wrote:
>> I am seeing a build failure on my system - the following
>> commit could be the reason.
>>
>>>
>>> Heiner Kallweit <hkallweit1@gmail.com>
>>>      net: phy: fix phy_disable_eee
>>>
> 
> Hey Shuah,
> 
> Just to save you some time, this patch was already dropped from 6.12.58-rc2! :)
> 
> rc2: https://lore.kernel.org/stable/20251111012348.571643096@linuxfoundation.org/
> 

Thanks. I noticed that right after sending the email. I am building
rc2 now.

thanks,
-- Shuah

