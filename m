Return-Path: <stable+bounces-86357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CE99EFC8
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5141F214C5
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9431C4A00;
	Tue, 15 Oct 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S0yriabV"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE014A4E0
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003205; cv=none; b=a6QPdhWmBD/4PthCOE2exe6ew124Sg6zp3a8tOBtK9k2/PBkxA8sAvmFH/IrD8l5bKqkEDgFWViPINtPx9XBMFD6NReTET/HuVkOvoutqoNScXnIwNBSo14yNFugtpDbMvsf/o/hyVGdPLUTWXh8lOVaML05nH9vLVGgWAihLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003205; c=relaxed/simple;
	bh=gEQsPCTYADqg/5dhizFfvZ4cQV1lHlJa0/ecRwJ3WD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ro1MCiZK9x/fX/ADIQPSObLsyJ3Udc4lTi0ld0EMH/35DIxqpV66dj7Qg9PnScRBTJPjqvk9LRye9JMAJ/dMoLF9xQYgE8oyG0RVLFrn9vXPXEeVxPWNuBQrvzUpROh3vJk+UAWKJFy8jrm/W4FK/OLxRliQA3wye+xTP8PFwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S0yriabV; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8354851fcabso225868939f.2
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729003202; x=1729608002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/17tHLWfe/53Rf7b+xc0smi0gst4zLWfVRqbp2qAVs=;
        b=S0yriabVdlGfAPqq3QzCuJ9xI24M723jDcVqvvKeaHYkOleguSh+aDYAPNLU0fjCy0
         wr+L54bdmOxA/SSSCSloVkR0cIUohpZ2IpVRDnxANTlu4jeJuKD4kRfKr+5+f5oEqOGY
         FEI15WzLZumZCUSX9zCi6RI70bXltaCC9zncM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003202; x=1729608002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/17tHLWfe/53Rf7b+xc0smi0gst4zLWfVRqbp2qAVs=;
        b=hqc3pQhWutWF7b+pdT5p8Ns+ZSdAsrNjgIeWekkO61F+2mBRB27+Q5xx4qEUdT9MPA
         i4eGRAEdGp7/1zTUwJpTPPYMEW6ZuQJFG507h1scKj3jJRciYxfCDICJLEv2imcvx5fW
         hVeM3xQXSQHU2qwvBmwkgWUPt4HD4GENb0rXucYAR0cm8iNIpXZ0V8YYB0X6h1JSf8ks
         o4fkGf3t9XpD6H/hkC76BK2l5J0D/SfSb3F6Fz3R9rcdIX4HLmHqlEOuzkihn0js22VY
         LLMoEASVTA3Ui8ejPVu+WkTgDwhJr1Em86md5+xIqgQsYtw+j5mXvXF44jhGjjzrfe5r
         LHwg==
X-Forwarded-Encrypted: i=1; AJvYcCWAVljRfyqQWwoFsrKMQfOwTaBuQ3IUx4LkerJzKW6JvzJiluddozvOv/F9vkN4RHsQ+azMwfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6U51C1jc4lh0cMyodCCymikvjHy2EF7Tfup4NQ55mOWmyQWz
	o99kVxn6C94JGpawT5b2GSlJAO0zZjrxD/M3AHccUov47zBFfp/QHie6lK+614s=
X-Google-Smtp-Source: AGHT+IEWRc2j6bG7NtrBwrqjdEIVjwyEUnvvDO8Xs+c5+ba5zr4uxhAk5xGhq6A0cTdDDVSpjzHdXw==
X-Received: by 2002:a05:6602:60ca:b0:82c:fd13:271c with SMTP id ca18e2360f4ac-83792cf4b2cmr1388841039f.4.1729003202534;
        Tue, 15 Oct 2024 07:40:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecb38c56sm333771173.97.2024.10.15.07.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:40:02 -0700 (PDT)
Message-ID: <dbfea7a1-dda3-4964-91ba-36cb25d8ef50@linuxfoundation.org>
Date: Tue, 15 Oct 2024 08:40:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/213] 6.6.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.57 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

