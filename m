Return-Path: <stable+bounces-42934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AEB8B938E
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 05:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0015A1C20C4F
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 03:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528DC18E20;
	Thu,  2 May 2024 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LL4xSxad"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB218054
	for <stable@vger.kernel.org>; Thu,  2 May 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618907; cv=none; b=QLw6BprLKbIBnl4hVvVujxZ23YjDHXCnoarVlqK2X+eJlzyKtBLPgpOXXBIDjcdxh/hytPvNmrq4E/dkZZF/MIOvreF2WJBPbnGCExZHQ0btSfL61Nki2Yx8MG/uaJ1lnVLnBxjYj82T4cfJ/pU/oZYwrczzFhQPWQIhii7YqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618907; c=relaxed/simple;
	bh=BkZwjGi9xHFmiL4nfLiT+Ex0R1ixPTG84Y2Wyym36rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=on1fA6INHFv/a3UNKa0bWdrraZJ27zepyC2/PEI5XTkY1f/nw28Iz0wfAF6RCsjfybluN2kiLfWf/SGh1A8A/fuBnCmdaT1NT2YLE2M9lq0X/x2DLHEntknd+GSVxfkBpkCwP9bcdk/DsaGpeLGE6k8G6W+ajRkGOHvc4LAq2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LL4xSxad; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d9ef422859so57045739f.0
        for <stable@vger.kernel.org>; Wed, 01 May 2024 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714618904; x=1715223704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEbLbPrNhjOiBsrjmUYUubkruoX+8IYozwRGt3/a5Dg=;
        b=LL4xSxadI/SHLyt+ie6KjVIszYT5ZgYQtfzY6lu/0pRV0XL4IJRyAKj7kMUEaL7Dus
         2Tz6kskAMQYXBRyf06dDO+sn7B2fPUWptYNctbw4PTsXDDkaXzSW1doolQ6C9ViiEySC
         Y3/zC4Zp7HJhUnLII7151xeY8Ka8xJve/a644=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714618904; x=1715223704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEbLbPrNhjOiBsrjmUYUubkruoX+8IYozwRGt3/a5Dg=;
        b=fsfptp3Kh3EkGv7oFIz1JVn3A7agv4t3e2IiBw2xfTcC/if9EOZIxgpeOoP4JFbavW
         vPmqkCa/3D1JOwB5jjkkJ3gdC0vgbyt4wnT9xlzApZjJyFVPnJgfqbeV0GNIRoI1o/cI
         2GmDBFKpnT7jbqtW0rg7GA81YS/fwoyf1bous5KHCIdyZ9uOnqhtY4CmBgCHTXRPslKe
         Xd6FEMXasK/+4tHl8BjYCdC+ka88DQQ1hIBNnnj8bvYgu0BnyskelxJeNvQpcB31MJU4
         wrWb9QKqVkx/Xaz8iOEdkrRes943jedeeJXzFnd1EkyyekQ7vVyT8Uk3GpyWIoEI3/t2
         Q7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUEa2VJOIgWHjaWM3CMTO38lV2AYCCaBjNN+KkTeSw7jLUNDlF68H6mtzZ3pOVaWlifjp1GVM25BUFGhbFZMZYnXwRpn66P
X-Gm-Message-State: AOJu0Yz+Q3iS8CQXWP9VAfo55Sa6EV8NMu83qtLxpmcezgDvyv114Ze0
	nTcGpUQwExfsxrFg4d/RMr+07SlzESnyZwwS8/STjkWkm52GvbkuMVUky7NQ4Ws=
X-Google-Smtp-Source: AGHT+IHjgrfimqrsDqQVMZXl8hehMhT3txq7RWm8puN/VGmrCn5LcYRp8OPwG462EjPGbVuGDuF24g==
X-Received: by 2002:a6b:3113:0:b0:7dd:88df:b673 with SMTP id j19-20020a6b3113000000b007dd88dfb673mr5566655ioa.0.1714618904091;
        Wed, 01 May 2024 20:01:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ky4-20020a056638940400b0048805115ed7sm968194jab.79.2024.05.01.20.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:01:43 -0700 (PDT)
Message-ID: <d1f1ee27-4606-4a84-85e0-284936e453d2@linuxfoundation.org>
Date: Wed, 1 May 2024 21:01:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.30-rc1.gz
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

