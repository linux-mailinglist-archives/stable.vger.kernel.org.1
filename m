Return-Path: <stable+bounces-45183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1137C8C6948
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E171C21CF0
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD815574D;
	Wed, 15 May 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yps7hFEL"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582515573D
	for <stable@vger.kernel.org>; Wed, 15 May 2024 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785700; cv=none; b=OpL42yTth23dmoe6JUiJZXoZui79v+wgOhmBVvUkndPIAEX22Q5eYLI4VFxHpHtTwoGUw4b5FQ3Pl7DQVUPJWP964LaTn75+v/iPGEuCScjQ3kjwQE70L4zBcK/Owf36TyjeIVBSPg5sMdqvTnO3ndt7QKeCMrqmWhTnJ5A31lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785700; c=relaxed/simple;
	bh=gRfOWhIoSyKemrb8DtpuxFtzGN1XUH+ReA+JPh8EG88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPMwGmKfTvngKILwHSIGhbh8w5Wiq8fBfDhVRfNsAQvEbJwBSWzvvtAWAq6bxqyiF+srcWbXsEzDZz4Av635N63370jaHX/p+K/N6v7PvSHu5mbLz22LapOlHYJwU4kiuk7LFkkCVDcUkhta9mtmpu0fXesS6o0qBmwDwMy3T+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yps7hFEL; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e195fd1d8eso57590639f.0
        for <stable@vger.kernel.org>; Wed, 15 May 2024 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715785698; x=1716390498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBLlj71inZ8mMsFWn7dN44R4dEBX7/1kMetgzAWjhNY=;
        b=Yps7hFELP2I2d10bw5brR1EU3cejg80xJc06R3dnIrbd1QC03R+KyuWqbuqKMlgfJB
         X7R1t8HXVSCKaQ+fAahEdajoXyCOVaNWmMS+iS3Mwh3x3MgZA3P41F1DSZWQ3wZ/3OPR
         uLoDKNHOw8kYK93ZO4lTOC5iYhnnkbJ8kF6Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785698; x=1716390498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBLlj71inZ8mMsFWn7dN44R4dEBX7/1kMetgzAWjhNY=;
        b=IAvnZKM06Kt+S4WFvvR6Gn7ixrNXwkN5wngCyjVwWCx1oLAK9o+l5WwnDjkH9TKXUs
         BSCLn5+/PT4B8kp4tbjG+pNqc0b1Ii0GMSgjZ5maz6b8yInzycLguK/t8KsMP/CqIgTC
         F67IsN9Ws1u5z+pgfpWlAL+DG209rN2SwINfvG+Uw4h8auPQTQXJVN6N7p3ITDI5IS/L
         gqcDN3uZHCd343bqvWBJu2NAUH9XzMdGcKdgCcGTvxk9+SwCaUQ35lKQCITbhv1PiD0i
         hEqZfmV2+VsmDHQAUNLGvHgob4MV+vOFNxnBJS6KFEjiDkCKJPPgpbVmAHO8BS/fbrRI
         uqCg==
X-Forwarded-Encrypted: i=1; AJvYcCVIkmJUe1GTzeIU6dXtKVLpYHwem1YSq7PIt22e4dqpQ1ZZXysznbIqXtt8+/s4RdmURx9UlojojVrsjzRuhBt+gK8wk0qf
X-Gm-Message-State: AOJu0Yzruw2Ob3Qlflierztm69AYgyOWmmOWVq+P63ShBSlKoq2ACGc/
	DZchcTV+rIRjIfyF94Eu+TsNgHlRpcqi+t+0YUhS0NHJ6KV/G7cifpBTixOhNYk=
X-Google-Smtp-Source: AGHT+IFoS53qNQlUZHcoRAS86QlHWEiEiVWLsUoMhJOpc31no4AJSKfNUCayuVN6kr8LqkjR11VsYQ==
X-Received: by 2002:a92:d3d1:0:b0:36b:2a68:d7ee with SMTP id e9e14a558f8ab-36cc1444baemr159606765ab.1.1715785698377;
        Wed, 15 May 2024 08:08:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d3fa8fsm31774145ab.8.2024.05.15.08.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 08:08:17 -0700 (PDT)
Message-ID: <bf443782-3dc7-4c98-839f-bcc7ea95d727@linuxfoundation.org>
Date: Wed, 15 May 2024 09:08:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/168] 5.15.159-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 04:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.159 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.159-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

