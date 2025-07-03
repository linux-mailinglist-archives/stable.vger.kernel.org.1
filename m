Return-Path: <stable+bounces-160129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B9AF8338
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 00:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB43B6E53AD
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 22:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12824A066;
	Thu,  3 Jul 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hY8v05Ic"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E61DF985
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581147; cv=none; b=eHF4E3fGsgNSlYWEaEVxkPtQjuiIT8bBzd7BqtqKxz+a/JMIN+D/KAYwFm9gikOz92IuQ62MgdIQXa4L4X7M4bUDs84btjrvrdvZtBzFcWlZcQvx7ZVhRf6Sjt5kdLP+1zfWA2JVuKOjWyz1+vlM4knjijaEC0gS1oQMPww0S2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581147; c=relaxed/simple;
	bh=bsQzXNp8DClq+bAKZa3sdGA9BUSFmOPEFWdTtJqquII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVRwUatGhg3aVM0h+g+Tdd+04f+m0FqHLF58r0u6w2h/BFS3LAOJ3xifn2FHYE04a7bLcEzJ/bj9w3o8vWJbKLkgDhxeN16vOrEJ0Titd3No46+3JUOwbkMrGzdNY7jNg55d9saiIUFzEUyoyIgWFZ8uP3i+c+CB5Cq3sZuLAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hY8v05Ic; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3df3ce3ec91so1473675ab.2
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751581145; x=1752185945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/ohUAJwNxFFjxA7YgIpc1NqK4PGnlTrw2zPL9RW/ps=;
        b=hY8v05IcJdcYv1Qx0OqiqVEUTfTC9LfjHDyvDy/hG3sKE1VkCpfVXNl1jDAzIrcSIB
         Ou8Hca+iBZbPqo2M+/uhpT5qPQoa+qls4RZcQd4J+OQqmgeuV4WkzusyHFTxtIkEVerb
         7PuHIDNf7AvDdMH+5KTf6ajyUpHA7AAs37QTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581145; x=1752185945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/ohUAJwNxFFjxA7YgIpc1NqK4PGnlTrw2zPL9RW/ps=;
        b=mK66WcwqfvnWOLTtvUA+PAxOA351y0lsfUYvRHg6KFAdXVtb7wSLf1xPfh0vwFZNq8
         dmJ6kVsSNcDuC+HtSu/+fyrESy3iRazSHmQOrJqB0tFRTYo7gRnqe59BezP22+87ksXw
         gfQ2zzpBhKVLBPyH3xg+Wx9eIxfSG0UrL5ZcgoFf4I5PHUoP1X10Gd68g5/jZWUXiXdw
         SqOhoMOqOrknOtgmvqdDYoMdQ63pu2HxJr4HEM3nLEzStKT2582HwO3wvjeO8YGoOubu
         NpgAUPW3XDnVhQXRIRwMneGaUv+vC719VPezYc2XU3uICrSOet3zsNbmzXOP1RRlITIc
         7dfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRPNfI9R7zq9BoAyBpykKVBX3chT9lnCkcBfTIV9Z3Vx54W+oCW7vwrRZbd5RavcyXuystV3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPo8zd0Ejv3C1r1h9zOzsn/kkKsBgul7gLTJtWZWQDtpFURWuz
	j7WitksKUR7UmNmPUn4d5nr6qtiWYb8W7UI+8uCVpj5BEiox2mrMeCSqiLxDjknvmCY=
X-Gm-Gg: ASbGncvzLLMJD15dl2fmFJZUe4MwmGa2qoTaJo9hXhn/L9KuINaTnxAHH3x+VOTq1je
	tFPVvs5v2m/LmZ56mjgAWe8cWAQGQmROiH2IJRsfbHWpLcfLWW+8iEUTFuy3jrFpm2ZVJIDWXTH
	QMJnBWN7yLaBdpKEYqB1QFNQcg8Jb1LqlVUe/jpvsBpQik/c5ZCLQ6gAts7qaBkILbSCHh8SCBN
	qRmhYXrHYG7GV38EQzBZZxs3gwPH7Th73OBsjCuhxo2kN5GP6e40rPtZCXdw0MjXMiwYfeCsgMA
	o1bQX0K6MECn4NVJebY2cBkrPIklgxalUgwfvK0qyoEE2oKnsXBetjrP71P4YImqVJcElmYP7w=
	=
X-Google-Smtp-Source: AGHT+IFkjsoDOoPrzIbbcNU8K6UylrmjRvuaaN9lDoZeoFFVq77lPnUcgvPUJ5086KzCi0xghesVaA==
X-Received: by 2002:a05:6e02:2189:b0:3dd:cbbb:b731 with SMTP id e9e14a558f8ab-3e1354bfa00mr2010855ab.9.1751581144798;
        Thu, 03 Jul 2025 15:19:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b599a3f9sm160059173.12.2025.07.03.15.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 15:19:04 -0700 (PDT)
Message-ID: <70155955-936f-4280-a0ae-c1e48af3ef28@linuxfoundation.org>
Date: Thu, 3 Jul 2025 16:19:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/132] 6.1.143-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.143 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

