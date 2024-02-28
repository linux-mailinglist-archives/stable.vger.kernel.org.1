Return-Path: <stable+bounces-25398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4177986B566
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60E2B26A03
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B643FBAC;
	Wed, 28 Feb 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hLPcbDN5"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA31208D7
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139510; cv=none; b=cdp80Qx/t9MWxcbRb5L28AF/Wjl7XOJTTUp5DmKSdqXgG8/tGDEWm935GCUdKmD4ovCcchlab2qDxuVe9o6DZ4/VOpVtnXrkrS5R+NtnXzpnp0AMmqNtnOtxyt61VhZgkTEmZlVMht/E2TGhat9lt07yHWr6B4YPsMcVk30xWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139510; c=relaxed/simple;
	bh=bMlDs7yBQYCcu4DKHS4UqUXWxsAp/yIjHTqNlIRq6mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZwo3eqDcAUUc/imcP2RF19tkCImtHvUOZkvkIMU6P4rADslYCtKoYDiJW94H3Fe74bJBQdwkAGufa9cXL+L4IddzoCdlv9rITCwO/H1I+ReUJTh9S8HGHL6C9O9Wo2kjysUMy1L/jpaUxh7GkUeCu1CcEZzo2jpysIDzbHoevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hLPcbDN5; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso114382439f.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709139508; x=1709744308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYAQxmYZbaAZw17MlObOfiOcMGN2Gwvik4DkJbgp85c=;
        b=hLPcbDN5iplNoKVUID8bl3gl65rj1hI5sEUilwd+YiCPyJVRZMAnlDiJ74xEyGQ5qq
         olYiSrPffrcF/LvSrB8d7fEVJv76ZE3ufhRGaI5u13/KTeqT/o1VtQRJSURPG7Jtl9R5
         TW8kRNgmx02g1RTa0ULVqpC2gRbJESiHoxcfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139508; x=1709744308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYAQxmYZbaAZw17MlObOfiOcMGN2Gwvik4DkJbgp85c=;
        b=bAX27cJOS/rSnXEfk2Z9GPbTmttiDOE8G04UFt80sMIIkW0lm2ESiKEznpY3H71SpJ
         6uK4vCZX7iTIvXQLk/rDWZ6F3lOHZdygnKNP4mbG8tVdgX/M7Ys+uA88N1OljkDFSj1P
         gBOBbTOqTPub0Sf3GfobywOAenTgzB6oWZ3Zytu2ShGMFBU8qB2oMnj8XHFtthxZO47c
         mxC4/8L4CG3A8YuG6GXJCRLGGrm5S1+C86YN2RwWah3405cKWwuGxZfnIpW2Dws4Gy50
         w52W3yw/tUTT5HT9xfh/t+gKlU3QfxwMzKaqAkBJVjfWOE44mfalnh78pT9FWRLrpsM5
         H/gw==
X-Forwarded-Encrypted: i=1; AJvYcCVmgKHPaBt0DnJ8H3pKXeBIIlVlOD+SKMbGJW7gQeXr13jP2PM5CgM663+PC+aB3fCMg8qW+ltj/T/1UiUVv2y/jMQUE4Gq
X-Gm-Message-State: AOJu0YwfQH4VpZwzmU09lhwiXnDu94bv/Lmsz0oFjiZlbHdd7UEacA7b
	pPKDKvZQfTYjtS8dUrGo0EPAdDyq3f6g6WooYNzprZVtXtwKgTMgcJ77KF6rZqW47YSuAGcN5Lh
	IkX8=
X-Google-Smtp-Source: AGHT+IF7HKqsk7OlJFFWRmBCmrY8cVas7yNe8MrolNXPjuqX96G3BVToSjl5cGRFw0X7TvetVBi6yA==
X-Received: by 2002:a92:cda6:0:b0:365:4e45:33ad with SMTP id g6-20020a92cda6000000b003654e4533admr12524621ild.1.1709139508320;
        Wed, 28 Feb 2024 08:58:28 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bn29-20020a056e02339d00b0036533cae5afsm623565ilb.60.2024.02.28.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:58:27 -0800 (PST)
Message-ID: <2902f57c-4438-4761-b48e-d40bfc019de7@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:58:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/52] 4.19.308-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131548.514622258@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.308 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.308-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

