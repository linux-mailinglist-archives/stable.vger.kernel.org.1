Return-Path: <stable+bounces-45999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3108CDBBA
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 23:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59162841CF
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647D84E1E;
	Thu, 23 May 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrbEkxEH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8A84D04;
	Thu, 23 May 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498396; cv=none; b=pksdEopuah5LSDo/wr4Iup8aSWcqcEmBMfkGJOCkBpc36mKvTh+oRYCGehmSoHJhgXZG2G877qBQJ20Af/pjgd8naGWxBLotO5pZjihID0syqth/Ix2j1gEFDqR1PiwmBaIdgJja4lDP11ZbQlx4cQNSciyGxhimvRZfky1QNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498396; c=relaxed/simple;
	bh=pKD8sIzMjawIjx8TgK8/CugVLHIN9wwV+v7SX4LeI7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7POdMrnvrIrrGO9BMOKKDwh2vKyI56Ifa26IkfzGT56D3f4TeYeP+JBjQRlRcplGchk4d1wYzXB6iiInWIB9jVobsP6CgOBATQBQbm7LHSlmPPF0iCmbvUrh52wki6rwXNEDuDQHySuqzXQG+w+ASjUCpLMqrdzIiNHHDXoQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrbEkxEH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f693fb0ab6so3388359b3a.1;
        Thu, 23 May 2024 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716498394; x=1717103194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTQYbO81rVm1d7lRu0tL1hZxpq81q3UNDF+EXPIQyIs=;
        b=IrbEkxEHh0gFWEWD7eRIaQn3tkHiWGFzTDnMsBadW4jf3VQH1dyW7kP7Co68S5Nb0X
         XsVdrvUMGYj3K6QRZ4P59n59grpXjqkbUejLAmzdq8oDzR67OGnDLz4dfR/hrWD/y/3Y
         V5jPd6zUOvW8YM/QAVMCe2akPkX7ihxdZEEL3AhqjT99IiJOXsHfCjN1kUu6+BPtZyq6
         sa1YW3HeOWfvNn0vp0caIqcEsOJow9Erq9JBkBNIU03JbY4QBy1HvsV+2eMddgwfwKAT
         Pf+bQ9Th0zuhvI/sQuokDmJ4N6IuN0ju9m69y4vGSQ4fjvxwde9Mr2GywLH0Dcoslon+
         UvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716498394; x=1717103194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTQYbO81rVm1d7lRu0tL1hZxpq81q3UNDF+EXPIQyIs=;
        b=JNqDNLmcsguf1QzztePFdU/vxLdSznc/C2lL09gOZOGcNbROFcHqcwm5sc1t8GU6eU
         EYwIHWGS4TIu9hnXQO/1ywDjMToheRIOxGbIP5RkkJnQ1eObjcRxFPUpSZKJMpo+9Nvc
         5T/LO7aWGEo3yOkfym08txJBFdsqg1208RY3pHYrBr5jtB3nZ7OC0MGMbeSCwO5Ylrvw
         2t3229ETBsjnqR2xwbRw1wghBtJTztoU7leP+4fU4qE8aSrChnbrwfpta7dbCudJBt/V
         Z7uLZBcL0Yj9ltna3Tm2Rab6hUcPKeMED2IvpRwlrDTEQ6kgQM8XfbC4JzFOyap31Zzg
         OYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiFKP3CQmS3R3OLIBrHY/EQRzsRuYiinamDDWZGPrLaKa6H7Bdwu0oTmN5z5qhD4Yrx4pg3r6y9Vj8RNoFY/0se2cZCHfzv76LmMRYSZrf3g42NpD8hAAsuKSop7QOZc1Ps1Ct
X-Gm-Message-State: AOJu0YzfaUIJQu+hWtIho4aKBU6faPvzwmDLq9r6/WnxhtOBmBxBVGl8
	KYPR5Gk1GAsB68KrU4HBJgE6J7xjUgo5FctSNvB2DieeCcp/9jxJZ0LFLbW8
X-Google-Smtp-Source: AGHT+IFu8eH3wryZgm20YQAvXwmv2wMxXRUbiTwAcGLlf4xqZlHr+NJrsBs4mNDXckPYZS2gAZKfmA==
X-Received: by 2002:a05:6a00:450a:b0:6e6:89ad:1233 with SMTP id d2e1a72fcca58-6f8f2c576d9mr396897b3a.2.1716498393894;
        Thu, 23 May 2024 14:06:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6822189197asm11024a12.20.2024.05.23.14.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 14:06:33 -0700 (PDT)
Message-ID: <84dce939-ff26-4179-b466-a4e5f8b8f104@gmail.com>
Date: Thu, 23 May 2024 14:06:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 00/25] 6.9.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130330.386580714@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240523130330.386580714@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 06:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


