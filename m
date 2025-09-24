Return-Path: <stable+bounces-181558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF4BB97E06
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 02:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A205416C0B8
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C69814EC73;
	Wed, 24 Sep 2025 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O2+ryMD7"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77581146D45
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673798; cv=none; b=C3fdjucgPBqF5DAbtVw1Z2T1OaYK85JdW4++xJNZZQqsUMpsqtQsygHcrsWwL7IqGBHZ1bksfJ3RLuyHSAQNzx2BzRXNY/v6JH8R6au5R1elF6gD3CNe+/QqEwaZgG/iaoCELxX4yLMpDkhXAHrdxWUU90OuhYgdAUuIy5fis9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673798; c=relaxed/simple;
	bh=naM04PjuUlO+xdnHVfVxnmrRbVNoRT3anIgfuBPTHfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghyWLzT526gcyN9sPS2jH1wftbmehCUK7OQ6b6cV6cEqkYmFh+M6KtJPzIAT5rKcbgIsjxvXI/4gXqZ2yUdU74syL7FtMh24FcVdp73kLFJNWZcnegMd0bFzcy5lgxFYFmjm+l/jssfLXGU1g6IIyGIT5YdK8nn9ADExwEhwavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O2+ryMD7; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-893630dba34so19307039f.1
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 17:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758673795; x=1759278595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWZ9/JruCDlDknEZ2K8CsMBaKtIxwhOiVHBk73OP1Ik=;
        b=O2+ryMD7Z7N6VMkOcstbP16pGAdvlzfyGULKP6Id1FyImoWriO84Mnkc/EbaWf7251
         0QlhNWBrObKvGeE7r16ePynDHmspQF4bVexUjaOu3Q9fXOyEv6MAnAI2JURD7lgrFKrH
         GoQvni2V47S/SWp4qLy+LSoseJY8oEly6vxfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758673795; x=1759278595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWZ9/JruCDlDknEZ2K8CsMBaKtIxwhOiVHBk73OP1Ik=;
        b=A8P4ec5/WnmcNVH54cQd+NKTSOrma8yIYD3LpT195nHkuGTFd5vR/Gzixama3m2S4j
         bwQ1bTCkSwn098wOq9pAtfeBVh02xgC3+6D+tKB9f4mVr/FecJQilKpJbsyH28UpkQrT
         /7jwNX48g3osMvtdMtpVl13xuEVkWKstdoYVA64OqNTCLni8GFBWq6HbegDriCnhwtYx
         dLrYW8SdEeMAHeSMeefDDv2wBFseAu7gat0vTVJfz3+6b5XAgfHkCymJsXjJyCprRrdW
         L2/QdazhAIJlBTdO6OaEyH/KtTQ6Si3cGqLa2Vxpzggmojz8WArTzmBh9fPw/kdnEXnt
         8hNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Z8hR6ZTviyOy0o5Wsx7H1yaafMpCeCdcQCK98hnKbRDPE6f4C6+IDzCT1GVOyizIoEh2icE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoCfJ64xpSCccORxLIgZOtwL28mzOhTbdSMvC8tZj6O52VA0NA
	nglnJMabyDHqFfE8w4JHuyukP6DCjHjwdThVR3CYzfvA+vKfcAeYTBQoTqag1QXRGDs=
X-Gm-Gg: ASbGncvh2Rgr8iYDVQ6cwjG3UXugFN1YgWPf6FbzJROAoJ9eKewfGaSRqySR6fukLA4
	gatbXwdOnp0u4E7EiS/cvNn3BnBYni7ymTn617ukCEnsdHxdmIgwloM4cLEIpX9ntEtsyEbSANM
	iMxDjIopkJIwDJ+9w7QuIBfI+EkWuhG6/ryE4Glsif7CXCiXEpglPijSy97doefJtewpivyuWpZ
	wepSp3GlY80IZ+1eCZdwX7xoKqRM4PzBXYwz97C4yQQXvm+CQ1OLqf1ohZ5wdExfeWggq0Q+UWB
	kfUe6Ed1AmHgjcCDXmhE/VfN1a6yiDQftRKr1TGtE0xclpYhWDpM40SeV9o0IkOr25fKN+EGb8T
	2XUztQvVMUzT7doONWtt8W8GPWY3OGNRAesw=
X-Google-Smtp-Source: AGHT+IHhU+JZu2aqGQA0/LLnFJk70f/QV6Wcnf71guu/RWN01PgptATucxSvf33EjWlyaZRLKAvMrQ==
X-Received: by 2002:a05:6602:641a:b0:881:4b5e:fa9d with SMTP id ca18e2360f4ac-8f543776c01mr106084939f.0.1758673795487;
        Tue, 23 Sep 2025 17:29:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8ee5e2af876sm50376839f.23.2025.09.23.17.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 17:29:54 -0700 (PDT)
Message-ID: <9c0b57b1-e749-40bc-8c45-0658a8b5c960@linuxfoundation.org>
Date: Tue, 23 Sep 2025 18:29:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 13:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.108 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.108-rc1.gz
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

