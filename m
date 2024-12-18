Return-Path: <stable+bounces-105183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E7B9F6B83
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966F8167667
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05361C5CAA;
	Wed, 18 Dec 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggsRFkKC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F813B58F;
	Wed, 18 Dec 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540825; cv=none; b=rcpBphe4Dq81A/NWSsYyrEOZf58SvJUeZlRuZxO+pGKtmx9g4jT3C43iMqTTD0NhlRoZWkc1lZq0RfNV6QNHh4UpfKelyMLWMUxXR/oUTLk8Otr2SgJfQh30qebxhG4c01uq6Wu+aiLV9zF+9mHv5ukkbKOBVQ9gFdJYIkt0low=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540825; c=relaxed/simple;
	bh=ghl+rS5RbJ4dpzlCeRSQueLkjtWiUCXEeLogSa8THxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJKFoj6ovr3xfiWa+c5riB7nyO38xMZTNE011Wpr6SeVee1kGrludtQ8tyunPE7TMS7zyGjAcXclHRXV6DcE2uyW4ZTJVluKugkABX+g97ho73AbHoJW5lmumdoCToUcd63I29xcPZUvERIR1QfS3Mntyn55c8BD1aDpElh7Uhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggsRFkKC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725f4025e25so5916129b3a.1;
        Wed, 18 Dec 2024 08:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734540823; x=1735145623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fYZX4WpHUBpGZjv2mkz6NnN4sdv8/n7Wrtj5s6DT3cI=;
        b=ggsRFkKCcTB5AnDnFKlf2Np4PjnrRzsHwJc8EuFIJJK/30GvVGRMM15jeb+qEtx7ng
         aUlHdVFKG6bvNB2ZD/TaAD+yrgix+A9HWUuIFYUt4pjb3ll4aCYdzUj4DwadpSaK4k6c
         ashjzvPtKwHeBDNxU04hs9lxFS/o1W7emM8OyAYvcO9FYcrAmEVpr+gCW/e1itqD7uIm
         ly3W/QkaV3qEcKMTqeMUWs3+Yb6u7OsHg3lM5AdK6wUFS3BXCdqLPagSAgg8+NuY6xSF
         RyIr5+9vHgeceNUF+USvr4K8SR37qhP5jLFKVPLfWmClgrbUbSBOiEGJ0XPkJIvUbj4P
         YsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734540823; x=1735145623;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYZX4WpHUBpGZjv2mkz6NnN4sdv8/n7Wrtj5s6DT3cI=;
        b=wlCldhWLQpm4o2CN/pOgU72hAhuVjx8UEYQzUlVYHRf6VlE3gbDivGSzaJqf46Weyy
         7FB8kEFzrK2t31Y487YLrPBgTy3XdezdX+sZ0ASX+bKBAr3EBdiVwBDTKIVLb2IYR0oX
         Oh5ExTY7UoukIo3vbjzAfOOhZAxE+aVEdsoQa3jcD3fE+7/kHCpI/6weWmXg1J1bipWU
         60nrFynW7upik+DvGinO2GcMBJer0BzZxOnoH1fFweddF1b9Bqd9tE5j6hcro5DLRLeK
         z2u5odqBTw7nrn11iT+3T7tY/dQus/cBnjaUMDYL+uWq+O4y6lpvsAeypP1J1YjDNS7z
         bTwA==
X-Forwarded-Encrypted: i=1; AJvYcCXxJLDVEG+ItdG+YY+m1PMHds1iqRZ/ahbb7r/fXi7zGP6umWCZASJyjffq0HvbLqGRxXQMbwF3t6I4sZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jqLK3Tay6o7btxEg/bAhM4X1rWJGFiAsy2q3/8/ePRx8LenU
	CCrEjGiLOV456eaX2P/QaU/T1gfC0HEQEwSHxV8wiJlyM9pqaHaD
X-Gm-Gg: ASbGncsJuK4Z1KHyAS/rMQvPOwStdHYs2x18YXBoosedxFr4ot6FH7LLJGBesTboHrH
	1DTpC7WzzVqRcWnyOt0Pc+j9oM3KpXt16oNKqzBFJKcfsYcutNaZg2SyicW8E+47caHcM3AXpgY
	7+Ho/upDr9SYmgoULagENNntACVLQlCvQqqksK/fCa87CKSxIf7Njow3SyHzK+4Q4fEmybrdwH6
	nVZ2hIhcib1C0jCfE67H//mOXbesJ5dfhc0+l/29/abmG+ZSWfZBVq0TubCkwIugHhxhmNl6CT7
	+xlX3BGSV/9rTwEPAiJJprounbZntg==
X-Google-Smtp-Source: AGHT+IFLt5NouUXIMmTzTay5XtMMTulmOtTOYSnClk2jPkT2yDlT7FKsok6xF0m3biBB+7nkjalQvA==
X-Received: by 2002:a17:90b:4ec7:b0:2ee:f653:9f8e with SMTP id 98e67ed59e1d1-2f2e93ad927mr5213291a91.35.1734540823306;
        Wed, 18 Dec 2024 08:53:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26dba5sm1644074a91.49.2024.12.18.08.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 08:53:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <869c01f2-e069-440b-a81b-fe71e969b72e@roeck-us.net>
Date: Wed, 18 Dec 2024 08:53:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
To: Jiri Slaby <jirislaby@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>
References: <20241217170546.209657098@linuxfoundation.org>
 <CA+G9fYu0_o6PXGo6ROFmGC1L=sAH9R+_ofw0Hhg8fZxrPRBKLg@mail.gmail.com>
 <746e105c-c6b2-48c7-ae89-4deeb97e1866@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <746e105c-c6b2-48c7-ae89-4deeb97e1866@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/24 06:56, Jiri Slaby wrote:
> On 18. 12. 24, 14:19, Naresh Kamboju wrote:
>> On Tue, 17 Dec 2024 at 22:55, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> This is the start of the stable review cycle for the 6.12.6 release.
>>> There are 172 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.6-rc1.gz
>>> or in the git tree and branch at:
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> The all i386 builds failed with the gcc-13 and clang-19
>> toolchain builds on following branches,
>>   - linux-6.12.y
>>   - linux-6.6.y
>>   - linux-6.1.y
>>   - linux-5.15.y
>>   - linux-5.10.y
>>
>> * i386, build
>>    - clang-19-defconfig
>>    - gcc-13-defconfig
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> Build log:
>> -------------
>> i686-linux-gnu-ld: arch/x86/kernel/static_call.o: in function
>> `__static_call_update_early':
>> static_call.c:(.noinstr.text+0x15): undefined reference to
>> `static_call_initialized'
>>
>> The recent commit on this file is,
>>    x86/static-call: provide a way to do very early static-call updates
>>    commit 0ef8047b737d7480a5d4c46d956e97c190f13050 upstream.
> 
> Yes, the fix is at (via one hop):
> https://lore.kernel.org/all/aec47f97-c59b-403a-bf2a-d8551e2ec6f9@suse.com/
> 

The fix is not yet in mainline, meaning the offending patch now results
in the same build failure there.

Guenter


