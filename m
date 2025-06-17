Return-Path: <stable+bounces-154586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9821DADDDD3
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 23:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4329D1780FD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200242749F4;
	Tue, 17 Jun 2025 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="coVAa+9J"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C527CCC4
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195201; cv=none; b=Ok71lZqhzV08lqZxxC5f/bXRCPjOpqYwS75UD8s7Q5nuGJL2E/0aGeiGWEdTnNfhhWxdjbSvRzkhy1BbqorOUUk4mvbjig5GipuLF43nDeE6eD7/y4Ec2k4w9wvW9pAf4SG49UPD4opHxdbAE27S6uPaSJYbJTDsshn82LYnZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195201; c=relaxed/simple;
	bh=l/D5NMvXAn+poLQPgkO1RMnglJ5burjvSRypMQfBzl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oga7By2SpRufn8Vm7/EXQcBQFQt0c76SzulyiOiCPbyq3VflwgBsjTYzKqI0Ba2gAQbY/dPfA7YO+WwMJ6nr6Xk2wy2/sssbBwjb8WSop6mk430a+GQWtZnoX+TBUDO0aGj7UoDx6CBc/GFsgiZ98kXdhXCr4/zbjuVxGF1iXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=coVAa+9J; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86d0c598433so170288039f.3
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750195199; x=1750799999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHXoE1l6VmkaktquQQpfS4tQHCY95q6ZnsLPHOm+DMk=;
        b=coVAa+9JiOa/qbCjkh3B7RMvFqfXF8zPcT5AQnsh2w2529gun0FLZPxr/BT3AtG2EZ
         6J5ePhNgD0jCxroLBY6qMEO0CWzFahfExQ5MKtvKtnlvXCKfbb0MP8npKB7InqLDKRzo
         i9uFW1CKsoNK1s114E0hnksZa7W4WRsRGmOCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195199; x=1750799999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHXoE1l6VmkaktquQQpfS4tQHCY95q6ZnsLPHOm+DMk=;
        b=MY4WOZD1E8DFJCSo6zuc3zGYD0eIohGMs/0bOOYzGKohV9GDdf/OKlQ/RHCVPuvznp
         cezovklyEu3Kix6cPyM9b2ASZL5cLq0dCDbX027YqzLYA2QoxCUqLn50SkCuY+cOOELq
         EIna6JcnOfzaMN3nS3vwudP1vbQz+wt190OvMlUqpUFOEjNOOygjo4/WYZ1RbOlWCM6o
         9XDWh9gdykMeGD77c620dUz8a5MdEfUUpTAzAOsifdZMfsVqfkxr6mCUtnFT2pHkN3vu
         EIu2GYrYBOWQlnZqwiLu7M/u/wn+WyPLhxAjmi5HEuGQx5bvl/22dDlcw5/iiXDAoA6b
         cB9A==
X-Forwarded-Encrypted: i=1; AJvYcCVedM71S5Awx2YitU9DcoHgbd5JOhnemtU8+vCqE/LQjvTwYxBsTodkvPp1D7ol7K/GKdlD0zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuFsx1d8LhkLgP5Uef3heu+q5Wy/HXHd7mlikx7w6KI7Ga950
	68PvWNP0omR/dgNzaxEM1qWOmjj7iMUI5yqsTwdYy3XyLukP/j65aGTNTwjvkW6orN4=
X-Gm-Gg: ASbGncvXudbO3kAq+kHS89f03aU51VR3p1GrXMMYpk7O6sprkcgY7dsO2sinTqHr/+5
	yoiZMlU15aolo3Dlh3Re7LFIKnN7XyZb8BG2Vb+TSVgjxQjspgLdvDbt49u1DtfzFkyvZHqCMeQ
	Olx6ChVoLaIbaFLdGOrHxv1bgsmr0i5qc5e/7JEjNpwFvbKLKVW9fbAtbOYRdssjujelE0eZ9tg
	QS6aZk20oGvRkJadG8DjqAFrvH/YnARVc1Jmzj29cGfJ3TKOi3Prf9kCrnzvJQrUiftfdvLLqdN
	Y5qESOimJM/7RRzGMXuAl2Nqn3gt6d/yZseiZUG4ppx7Tx+ADn4IS30jvPVT2TAlBwNAKnd8+w=
	=
X-Google-Smtp-Source: AGHT+IEWunlYJczIJ/My0qwdNVaCNeeax0MjC7QLjknh2C/jvr94Y70XxYA83yB6cMACh2HZsjWOmQ==
X-Received: by 2002:a05:6602:158e:b0:875:ba23:a062 with SMTP id ca18e2360f4ac-875dedb3cb0mr1806235039f.12.1750195199269;
        Tue, 17 Jun 2025 14:19:59 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875d570f54fsm225868539f.10.2025.06.17.14.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 14:19:58 -0700 (PDT)
Message-ID: <787f5b84-5969-4214-ae0d-7438a38d2735@linuxfoundation.org>
Date: Tue, 17 Jun 2025 15:19:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/356] 6.6.94-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 09:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.94 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jun 2025 15:22:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.94-rc1.gz
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

