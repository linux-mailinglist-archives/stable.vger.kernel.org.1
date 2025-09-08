Return-Path: <stable+bounces-178986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F52B49CFB
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC64D7B14B2
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025932ECE89;
	Mon,  8 Sep 2025 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AyAC6sBO"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022020C001
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371016; cv=none; b=D8W5WybKam5OLxzvthigaLjdZ51ug/0vOR3sIp8AzNbRvzXmcey6v+AmoXD4Dx+6DMBABANSEr6n6LbvUqTYWpZcP6TYiz1LQz79Pcy8tlLHiPkQRakmIpTZldb6Cuw9oEGg/qaoB/0q6ZBCMf0mXvLa/E5GjoR/7t7tcDVVAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371016; c=relaxed/simple;
	bh=T9P/K6SEcXRuUJUXzSA5TYU5bmqcQ8N7GHQaxFjMhXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHcq5HueqeS02DE83i3Yo/erSy4Ju0drk4uvOprMEl4cbzcAfpvQpCF3/dWnk53zV00tntuDe70h32GsTUuvU7QwDG+iC1bYKOngNtdIKxkBVkOaTEDRlE8uKAKKMRlvBxiKHcNX+0sJuErLfopjy+bocsTfg66wzCcJ6WX6ziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AyAC6sBO; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3f664c47ad2so53973845ab.2
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371014; x=1757975814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhYf+Oj/7EuAlJsyRI1kl4nGXkiLJ1sdDKDHJYLWFpc=;
        b=AyAC6sBOJckJGouZhLdbl/lu1ccFHoV/qtmPj0uIr39IJsJ31jHc7vRC+PeIZeiR5L
         FZSgeTwOsX4PT77HElqFA3ZmJu4grxfR8uegrN/69eFZgmN5NEApyfwaE9TwlmDOHMi0
         09X4srGgu5oqDRVX28CGzCCM/S5GXJNvVIZMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371014; x=1757975814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhYf+Oj/7EuAlJsyRI1kl4nGXkiLJ1sdDKDHJYLWFpc=;
        b=mItR0/phYA9CZLKkHdKpy2mGun81M2xH/16+TuxVGUbhPCLXrqCr4k56R7c0DTqJ/d
         P3cn9wDT90cYGtrEK3e66GakQTOSRM8suT9PN3wzsqtt5ltycaRLdI/HoqhK3sHgnnSm
         PDiKmqUD4h/8++YfT1me9w0MVEcn0HiaHZc8K1zHS6XxOnU0oB9M8x1bJnVyrufYwzaK
         h+rXB4dtlMp244zHFnho35Dr614wCegwdw+TAr6CPGzdP9TF6c+bX96OGzhhVbVgF0Fj
         ZsDZ5vpsnazfGdYxB4Npre+ewMZju699TbWEsyMt96a6zHQLuCm4uEaqEBPim8Z/UioH
         ZgKw==
X-Forwarded-Encrypted: i=1; AJvYcCXyD250+eLUsZvyHFNpYzSlQuN8N9lNSY9lA+mmOZyYDTKwbpuY9ZHewEP+GLkOhX/o0dWyfoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zTWUhQ5sDs6vD8CIASrmfYLtMKJzjy6bRKiPSaMZipKkPqjk
	i/I8vNdMEvKqHOfh3N+Ppl4TCtfBPzcF9bTIOPuC5Xj86I8aRrjj+gGAX0uZBJTfAY4=
X-Gm-Gg: ASbGncs2hxNHts8Ivr1C2b2ccPnRoz1wN4ivqSJbx73y+49MoeIX0q55eAF3GmbMG5j
	TJo5YN649d72Wm4yIesagB4++S0Yo6hm9OKkvIcnglkfRctc82MallzXadOHPUuoQlxvkpPPetS
	d+AAC8Moui6mVzKuJDtx8hsJxHoiVFgc4bcLFqO0/fMC1P4aTqgNcuhd362QxUSqzNr6WNVo0RZ
	dLEl1VNQws3nlrgOEQg8JZoPZVj5uxXInDhIV7252AUUhfSqKA0Xo8GW6Tx9BjGAydFHUgbkEeA
	vRHkttLpAMb6UEOWQhp/21P4MV1b6mGf7DcMeDy4v9eLW/I1Nl7x4NXwou4V5ZCqpg+Gf0bkem0
	WO14b/q01ukfOCOnm0AJV6JCk4hNH0nXLCRc=
X-Google-Smtp-Source: AGHT+IGWCoQv8jgv0YHriek8VPPsKGGZClBOcgF0YLzARTTz5XIpyx2mZHmSef9NietX+UdPwGY8Wg==
X-Received: by 2002:a05:6e02:932:b0:404:5e3a:292f with SMTP id e9e14a558f8ab-4045e3a2c31mr66923635ab.13.1757371014127;
        Mon, 08 Sep 2025 15:36:54 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31c926sm9214471173.53.2025.09.08.15.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:36:53 -0700 (PDT)
Message-ID: <b4878e9f-7f22-4d73-9a98-ac26b2aa6cb2@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:36:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/175] 6.12.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.46 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

