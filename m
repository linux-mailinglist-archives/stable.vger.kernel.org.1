Return-Path: <stable+bounces-92857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224DB9C6584
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907A2B2A3FB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1C21A4DF;
	Tue, 12 Nov 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wu/LtGJG"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66271201266
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453343; cv=none; b=NttSM1Y5Dr+k57ZsEjj26In49nD4QpnBcfiPf+OX5WXW5G14JeqzklsLF52wZTWEcwjSiwqHajZgkD0tp6JAPtr6jNfPjVWnEpDWh5IuOfpM0tXMcYg2Axn36booOf+7n3tcHySAxJH/jIBc5QmX1sT98Lv1x8lkJt7/RiPNkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453343; c=relaxed/simple;
	bh=g/R4ohx7mYN2DbBFxLjMcewmHXuw5CTSU6srdda8FSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IExTBM16IkWLLQF8Ce1aRA+TqmpZVDgtVxhnTX66efG771f0/HksMsvJ2K4mQ0yVH5XC1Ho0HmPCswZGYXhBYo7RcQhDhAlg3OA3cruzlE+W6iIN/bfgnneyofgdU4GQ8ooHEW8YGInHT0ZtY7BjeYLqOK7MZh4TzjufoPBNt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wu/LtGJG; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83a9ca86049so230706739f.0
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 15:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731453339; x=1732058139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnMK2dqBVllbxdNe3R5GvuE8xct6oB+YClxSZXO8Q+I=;
        b=Wu/LtGJGPjd48KzdqF2pSfCXn9Qz7HmLHglIgFYxlsg71M4zNNrnPC7++WbnB2z5dF
         LOatXeOoNzhbrUZu9lMoAQ6ESdb/uHtwgJjkpkdOjz5+pI5+v8KpWzOscbIMTWVFJN+Q
         xoXno1zNLDyFD7Sbv5hjr68faE5yjEC/IE3Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453339; x=1732058139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnMK2dqBVllbxdNe3R5GvuE8xct6oB+YClxSZXO8Q+I=;
        b=wEe8mToqIJQCMgqZVHuqmNHLvYyeuF9tohFvV44JYlVPVsKqz1K3rC4H4zFwUAEITq
         6HVnZtj5Aww1DdB+ZGHkoItfhfqXXVgVrdh9pV7KTbvvXnLPH0SucDVvmG6BzMshcmHV
         cNWlqgi2u3G2h/0t4genAeEgobBkJ3N3/zaAW4fKaUVpEPKVn4+r05KrR6GIztpfXXrZ
         aYXRPKLbRKQbnsB9FQwAJGxaSHAJaorcdhIpCL6ErEPDyg00AZoeA/G37PiC3hJoa56Q
         qjc53Lo1hdD8iqFzS3x1HiyDPpMB3g19HmeWgwIwiQmBGbeW+5AzQZuK7hJ/qyfr9CGH
         9C9A==
X-Forwarded-Encrypted: i=1; AJvYcCXyIv+K+39VRGOCDOSX6uZ4TfTlhw8xtjCnCQn9G6u8V/s0KYfgh1SG96vZh9vLklFHML4RI7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OaH4AydKs90gjL6gqICV8uzCe6N/0y759EUFwiLyYb0CLPCu
	5J7LmGHMlJ8O2UdQaLbartmhEUnUoblyE4WaRr1Bn2/6Y0BgBfwNsKxIs12lHLYC33KeoMCGXib
	h
X-Google-Smtp-Source: AGHT+IFe9FwwfyF1CfXGat4+I6PP+yEv+9tyc7mkPTeM33S6NC5Vw21jNi6/ApYRZEmQ7fQakABBrA==
X-Received: by 2002:a05:6602:1408:b0:835:4d27:edf6 with SMTP id ca18e2360f4ac-83e032b8401mr2284263439f.7.1731453339562;
        Tue, 12 Nov 2024 15:15:39 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e13256349sm228310839f.13.2024.11.12.15.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:15:38 -0800 (PST)
Message-ID: <2b93e9bc-e36c-4f4a-a137-f35a5742a3ae@linuxfoundation.org>
Date: Tue, 12 Nov 2024 16:15:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/119] 6.6.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 03:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.61 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.61-rc1.gz
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


