Return-Path: <stable+bounces-94474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3BC9D4469
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 00:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA71F1F213BE
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 23:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D271ABEA2;
	Wed, 20 Nov 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZwQXqpw"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140FB1B5337
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144844; cv=none; b=kPvuD9t5JpCDCQ+gMFBfPxsOmtdCd4uu5UFTsBAXmBeb2zqc9nlRv1uMPjewFq0VMYMhvk2DPqzm4DquV1Q7tPqVYrYSMQQNnpP/1hsENkOH3QfFSem4WcgOc/j87BSqLbg1gXAFxYPuqQnyHXU5TG/f54S/6jWFKkP1UYcgV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144844; c=relaxed/simple;
	bh=eupxP0WAfuiBRZTPQdKjbDaBL40xdQ9r/lQfnUunKPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIhdDOaH60d3lVPBoRGdGvjppqSFjL5sngPeK79b7HY+V3aTZkC3RxeAhPzn0DwW6OM2nha6PQ6I9aeWs6VPtfP5WRLkCq0EZheljcJrUPsoFEWBUCcdXmhgQ6heWqLhcNGNePISg3d2vYKh0McOZWJVZwdogvt1tU+85M17yGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PZwQXqpw; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83abf71f244so10891339f.1
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 15:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732144842; x=1732749642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kI8LjRbHnrIYCWVFuTZVSrxkVpMakjiw/cyxut4YKfI=;
        b=PZwQXqpwR62MZrA+7oubRf492DnC+H+wDoWMS5g0f+hToW8jTlC1MBs5Zbm8qtJrUy
         oACXnMWF4GU4JMlW04tjWKAkNpuL1nTRhSOuh1CVa+URI7qamFy+U2RjUzK57jee0iRc
         EFohr1R/oiymvJeCqfz9zvmbtakvIdH3H0sWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144842; x=1732749642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kI8LjRbHnrIYCWVFuTZVSrxkVpMakjiw/cyxut4YKfI=;
        b=TRyXl/7pmzzT0lOT/299D2s7yNRjkSaew9BB8HhE2cwvPNrGA6K7mAwkuRH+MDUAxj
         eKiTkXGMpMugrz5RNKvbGvTLo3lbJB8IlwjDUPY6I0vVMgMjhd1LHnNTx/CEqpFOItvL
         6+YnS1Dk2Yz35s9Og0tOS3GzuHfSy/qEPUArsy863kUdT56sRJs4Cdc5sn1KQy8D7de+
         MVAia2EA7t0t8wlzShw1D9WV9xPp/M6Mb10GjZwyvmegjcr1eHKE10nSW7HDb+cZamyZ
         e7q3f/2u9QSPX71EVo0S1dcznPJrTgYTGfSlz3A6j2NLsNxN20cfOGSA7YdYv7jzeXJR
         fyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGFe8jGfhKwHAri1XodyK9PHNhHc5mm0vn28k5lG+Yc0rNdE99JLI6xtOZIQgdjEjjotG49PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEs6lCgoV5/ow6yob+pS7FnmxoTGniuyzcAcxydFnI9FpcaYT
	5WyQxg7IKawXB1VmJN0M+OS5Nr0fLnoMI7aFAIJNzQkk/FMReFpSf3xEe2kfk9w=
X-Google-Smtp-Source: AGHT+IEEiuGathMJnfCVnOnRROnN/kddhLVKZ8maKJ87UcKzpikjw9GywFlkWjEQ98DV5mVGfqUK2w==
X-Received: by 2002:a05:6602:2c03:b0:83a:ab63:20b with SMTP id ca18e2360f4ac-83eb5f88fd2mr584939039f.4.1732144842233;
        Wed, 20 Nov 2024 15:20:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6ebe55sm3349642173.6.2024.11.20.15.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:20:41 -0800 (PST)
Message-ID: <3b2a3cfc-861b-48c2-834b-408532a230e3@linuxfoundation.org>
Date: Wed, 20 Nov 2024 16:20:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/82] 6.6.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241120125629.623666563@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 05:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.63 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:56:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.63-rc1.gz
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


