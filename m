Return-Path: <stable+bounces-183305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10097BB7C9B
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 19:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C5318820C1
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998B02DBF48;
	Fri,  3 Oct 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkbxqKw+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD02DBF5B
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513258; cv=none; b=WvWKbzGmi9eQ2bTPPIubKD559L/Qdp31SbhO5QJbRqk6bHs/9yM+kmHSlftDVII7jwxsCIiOPtR8Z2iu3hfmkCjxCU0112prH3lyRS+3/Vvwn13gUswhq6obGxktDmCOrr3gGnCkoFatO6kl0kkYZm/Det2q4ph2o8U1u13ifBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513258; c=relaxed/simple;
	bh=7zGsOrHucK/F3TXGYVNST8Ic2yHVpPVoo2wGcmdWcrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3yW6kHEW7QiwWcsQsvYQE/KzM4At0Uwfakkeh3Au5kiaOUenPekLZxPEuyjvE2IJ5XSJKfdgPkp+0Ma2I/GAs9P3q1WIQas23rDCevYhRbCKYzQSkNrvMiFy9ZfrHlAAn2ItDXNZ8H4NQHsIGPGocAZiPBzxvovo5BidrM1z9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkbxqKw+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f343231fcso1641154b3a.3
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513256; x=1760118056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DvF1xSe5T64RA3ceOh6pYqc2KwrLyGdOksJedmvMUU=;
        b=hkbxqKw+DzXrAGrxqwX+lG9yp59iZVy6pdDuBC19kFtCCmW4sWNH1LejFm4KZ0AtNX
         6sf3Hd4AwWQH5u06uUlcfAMhOsrX8sywP3Fliv2n2BbvMcSLttdNWALlbGLuG4bKNoo8
         bnmci5vVJ5NILmWcPuZg2xf0x1qDuCM/cymCtDzsO/LBsQfEwDGF8vbfDoP5G/v0c/x9
         haQ4nqh926n1pWorWxT072pCf0s7TRMICgIPOV/AYurJxgYAWCglSsfilZpOWImZHghE
         ceTwfTpFU88x2953mi/DCh9dzc5Kknuw6rbN1s56qb3PLBoz70j8nrRh4LVioFCYjdM/
         C8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513256; x=1760118056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DvF1xSe5T64RA3ceOh6pYqc2KwrLyGdOksJedmvMUU=;
        b=TomhBwZ2phhoBnCEaLw2NTKt0Kz0zJbRcZCwRVjjp1Q68/mROq4fXBTInjYuvez7L/
         FY+Bo8NHupuosCWAeC2SPt6lCbVvRherBYhBBKXE39DA4i2y6GNT4hY8Uv/HpGZRtQ75
         yU9g2bFBbrault5JaLvjlQpGMgcowbsiQzYrpcKYWJs6yfQqNGgdz9iW41bjN6f8KArm
         wNdS1eWMmc+eNtWndcXNE2izXeS8bamd26LhEQU7y67lpVmPO0CgE7ZihtM0fPlD/NAC
         Ru/NpJHGV0jOYibmL0GPDtv8dpAW0kkkTOq+WJoOwhsUGnYeicpcnUtXOW3SSItrZKxI
         zOWA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0C5qnRfx5MJ6ufCX+D/XRIfp7R8WD5YTgRnBFzVHz5koeDst8GgW2cmyhTwsMZW6mQHg4ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxCOgnqqn/buAgqa97p6aC4mZHiMNrzxubKFb3lr+PgYaSCQc
	aWFEAQPausWJzMT1TMizLyJYnZzdgLUmM3Uisouyu5+nPe1l+xWHF88V
X-Gm-Gg: ASbGncsszBY8bWQnUzs5runbF4+cwij9IGF/LBteKRqtEuZpDZdoaEW2JS/XpnyxdY/
	Q47pk4YXFE1QGQQm47bzpMZfLTfc5PAm/a95OoFHyaS5vaWPjKJQD/AdbcI+qkeDNswsfYwD1zs
	4H/f64zYln5pNQqU9MJpgLb0MLRvZ3YY7qDw5orVauelIEhmrQeL3MFpRNtBq8HDljH5b0iWp9P
	ftK5jCSroA+/nY+YZ4AX9w4a0SM8qphooNUwzx5FS8smKYRg3JkryXyOAEEOueMKJWp27jJCL6i
	oswcNjuhLlp3Qc1+wATkBU996jzwmkXpazlNmRMCjZ+01DifytAbTdy0fo9RUfdZk43g1gb7+sH
	o56mtsfmSgIu6sZqJbVAI5caelkKoVeGv4loGjo3H+NmdVRXeVplZa6XlHfF2IoBlkCcDrHTuzR
	E2q+XcF196CSuiv3bqMRLEQwU=
X-Google-Smtp-Source: AGHT+IF0CWD2qg+PTIx7YyLiOrkXXs3s6uMSmo5ndEoOaGo2dua6hr9Ax9ka74DU9LIpjixcoQgBjQ==
X-Received: by 2002:a05:6a21:3283:b0:2e6:a01e:f218 with SMTP id adf61e73a8af0-32b61dfbdf5mr4344924637.11.1759513255860;
        Fri, 03 Oct 2025 10:40:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053584sm5446155b3a.50.2025.10.03.10.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:40:55 -0700 (PDT)
Message-ID: <cacabcda-c0c7-497b-8556-f6475639a341@gmail.com>
Date: Fri, 3 Oct 2025 10:40:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160359.831046052@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 9:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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


