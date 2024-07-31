Return-Path: <stable+bounces-64802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3B943710
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F1EB212AF
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4D114F9C4;
	Wed, 31 Jul 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8h4doNa"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFC182D8
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457505; cv=none; b=cvuLJMyWoX6Yth1yT6imSkrWxUQ3KaPvz3yCcgEKNadFzawyR4Bv0ulzzYByo0syQeBthQnPB1mBb5P8xumPP5Q4iikTLv7gmqM6NRqwWBh34+vckWIGF5Ucvp7+9WMa/gpRNlzSby4WOaMBmAspZj8d4JkX7vD70mvdUTbhWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457505; c=relaxed/simple;
	bh=5iljddl6Dy1+iqapnBBDqeHgVvb6+kC9EnooWBoaZ+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3giq8sqjiLyJs24BUUctg7jyIA6njcFixBmFOoMaZ/gceTD4ecTRgInNgrjCoFfjib8kV8/yhuT9jMtVLWxojbc22vk7dEdHznaLevvyj4kCG2SytZHBA2eh+if/LdkiuMoD71xdwA69QiaRFkxJomMDoZPF8/IrGqM+W/B7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8h4doNa; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81f8ac6b908so31090039f.1
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722457502; x=1723062302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNpsP02VSjKsYtcASUUA6qMfypdvykuyxCt7zWGiFLk=;
        b=a8h4doNatuWmRmGXwjWRvKVJ/3qjjMfFJKweCwHIGVMI/QIC1ccOBfAP6/y7pIRK16
         u5kyTnJkx5sPO414swIiDpbwKtDes2xjH9BGMmQLUfA9CYMQbSk3pW9K4qeoH1OyCRQQ
         k3UiVeqo4ZIkBEgrJLwJozoGwEzmsZ1Oqy4EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457502; x=1723062302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNpsP02VSjKsYtcASUUA6qMfypdvykuyxCt7zWGiFLk=;
        b=qBdkKEtkyw8ueG5NN3/msJLDP+qzwi/iZptibr8NoGFEaD5p/ZM8eLlXBz2s/mQ8tP
         EjiFh6Bb/dED0zwfLK/WYr1Ighw1vAfPL7TP/R2jG8nhwhhk/TiliaHnU2wbhXRXnif4
         e2hM3sfu6B7aPeC7jkQbvSEsCIwOrtWzu3jyXp06jGQZhU73egBoLTjeS4CiXXhRxLSg
         1YYABVaCX+23IDn2C/IYG/iV+LCGcSCAkMhrAg9mhSBdV3F6cmX/P+lrTbugq7m5fLdF
         G7cZofxCPFdGi3BQGDSUh5pJxwfPbUmFubTRPZ4DR9bIby3ns4XxU+qmqttcp35xd9oU
         H1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEjMp4qLLPVIPIgjXgvQY6c/T1oHC+7fazDE8CfiOx+2rg4nP4nk6A6L/AhcSvGwD0aiC+v4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfVKHsQFq97exRA8AOTjqYBvWyqU0W3AoYU2wOqOP6UeA+vW2r
	5t260rIec1fX70ri1vd5qD5aRoZMfdHklS0xCCv7gEVMUse/bLsZCjZiJjwM6io=
X-Google-Smtp-Source: AGHT+IHizPAHD4S5ZiqFk080B6OLpCMsmkSB9xS6xlQxHULKrSv9bR+UjdoWxv8uUQ1IXUjy0JVfbQ==
X-Received: by 2002:a6b:4f0a:0:b0:81f:8295:fec5 with SMTP id ca18e2360f4ac-81fcc1c1b19mr28919539f.1.1722457502455;
        Wed, 31 Jul 2024 13:25:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbd9a7asm3352896173.96.2024.07.31.13.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 13:25:02 -0700 (PDT)
Message-ID: <d9fea67f-4871-4b26-8a69-f9a8fca8fb13@linuxfoundation.org>
Date: Wed, 31 Jul 2024 14:25:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731095022.970699670@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 04:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

