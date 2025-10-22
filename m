Return-Path: <stable+bounces-189014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 454FEBFCFCD
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4B533469B7
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA842586E8;
	Wed, 22 Oct 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HY7be3Uu"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDD25783F
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148723; cv=none; b=cBhk5Z6gZP+2sSo3BdKZ11RAflsFEbIVW1TyGHimb6zJa0njoI9wKg/Ug1MZOXu9eXUhlG1FOCkYMOf/Od4TAcVATUeH3QRLkMXr45ORVgnfrdolgtv7C+sABCfzX0mDGCxA/bF2WcaDb5mHnA8jOHf+IKp7R/kFK0zN/MimE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148723; c=relaxed/simple;
	bh=NM70aKifWa2Kd7WDeVBufAQ+rHD0r0An/049xG9//QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwT89ZI4BAYEgrFhd62Px7mbajyKVXpNgbeGFGzgubHqtqSwadsIXSoYwiwpcZCYpPYLuF/1emI9jYyDy7x/Jd+RAVAZelk6upRdS+zPFLX1zkPy/OOf2V34tyFeHlimoHeIRbkjSzH/g0wWGqip0U8HZtB6agaIhuqdbpxa5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HY7be3Uu; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-93e7ece3025so56430639f.1
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761148720; x=1761753520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtlN632BuZQuTO1b1nC1/pJZ9G7lNRGEK1QOBTkTILQ=;
        b=HY7be3UuLkE8mMupUjRKYOmUFTvbSWgkKYyySvF6UhSVG4TZZ0aKEc33ZnLSN+i57b
         N9XpC/0juZ/yB1E7aKaNd//oa/lZ+st1Ti9caJeIUTbKyEaAjsTtiLu40Ijfc8OoAO3I
         AHcVQo3CNVqKARWTWuSjY8byKN78A1jOnOidA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148720; x=1761753520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtlN632BuZQuTO1b1nC1/pJZ9G7lNRGEK1QOBTkTILQ=;
        b=oElceRvcVfAWyyq9pczRLHxMACwQAn7Tj2JMymkPA0Vqh5Y6Of9X2IZ4Fm81i03ic3
         Y0rog706q6uV5DERnoYRKgTFbClqUAb70PjjVA6Sf0OITByh0oFkbreST/c0uN4rWOuc
         GxY7wOVKtpcQW7+5afpJIBvv+COzrrBXUVkSDUnY6QX8cMP8j04efDwg15zRK7q8G6hF
         6uTuQ2tJhqjI8EDXcMqNdgZdqVPqu/vvkP+FkQ9GnWX6Mu5QqsFoLyRC0zWoHdpOZj37
         /EggTybIiZXB98GCWUR17Ke/VsG6TTg3yK9HP44joOtyUvfeNwNex3mLvk+NDs1dQg2Y
         +hFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQbQV5kWIlNsTDeGgdLwRzf0V7gOEvDg0qsQoRUf+T5Rs5ktel5nGPfqBtmviAfQb7whAZT/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNE7+NQA6T48ikWNafK6FLEf4U4PXRQibWmNKzTsJAifO9Fod
	uE21q3tIeiU97pPxnuqBttXuH6CWLbg1oL4lX9y2/aPL3JU9818Pd4T9C3HWXprpseo=
X-Gm-Gg: ASbGncs7goNqaHE1X5dj5PlqZv2RhSOt+3TDHVBaGAgd9F6xUyzLzk9mXdYEOfeLndU
	Un4wPq4q1OCELzeaFtO/bpwsQTpPR2mu8Q2JJsCCmgJBUE/5w3T3Gpfq+TifB7CLzsfXsYLz42W
	bAyfJ60167js+Wn/fIPQjal9cS/yGoI9ErC2pV+DIimTCeCwifEUkYKIv1Xexp0CoPpGvALgpYt
	005FmvRna0DdB+80JiJHkZRLIMW7+O0p+MlkaKRpwnlAUROWrlbekgMMS+q7Cc2JPmpi0UtCRrs
	MiiFRC3Zba0lDQ5LmytqY2SMfkyvBkAX5Qd2tU3Gyg268q3d2qbE16Ufh3IkufWc14TgkiQESkm
	LQJzPURfTL+k0PjDGDjARE9toht/6gOaIl9rddH/wOA7RaBkwskqUk4Q01AmcO2qrA228ywGbwQ
	fldcgXeYnCuzlVyMPOB6cHb7Q=
X-Google-Smtp-Source: AGHT+IFfmpCao/YI4qPYRvNe/k0MEVLSsUtQkapDAZIbYz/MAtfhrLCaFirgnyqdBAlZJ4fmtoS9qQ==
X-Received: by 2002:a05:6e02:228f:b0:430:b4e1:bcb8 with SMTP id e9e14a558f8ab-431d32d4088mr52223745ab.13.1761148720159;
        Wed, 22 Oct 2025 08:58:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431d73e411asm5735545ab.7.2025.10.22.08.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:58:39 -0700 (PDT)
Message-ID: <f0c89ede-19ee-4046-b2ba-0178c62e7243@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:58:38 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/159] 6.17.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251021195043.182511864@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 13:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


> Mario Limonciello <mario.limonciello@amd.com>
>      drm/amd: Check whether secure display TA loaded successfully
> 

Verified that the error messages are now gone with this patch.

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

