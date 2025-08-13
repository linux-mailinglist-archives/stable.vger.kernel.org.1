Return-Path: <stable+bounces-169418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B33B24D00
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E282A11D1
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA52F6576;
	Wed, 13 Aug 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bbml6EM4"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680A2F5335
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097849; cv=none; b=eF+2DD+bm2guubpnDrK5ZSljgipJtbcc/fV+/Jx7ce17b8cei4kXkr1ye3jRCgOz6909YW2QgHOtSAR/sEnfsvsfMwYjoupCr/cN+gImP+jE6/2/6JLA/CbHw3JOeqinShlm8zfYwSa/qjNWfTBoe0gLVONC2ICZRwYVDTK/KSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097849; c=relaxed/simple;
	bh=qEyWX4DpS2OZS71Z3EmVZt3QnEC/1Su46EWk2Y0GS+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFtz/R+/oNGET90UR9XwKZDgXBGQeIOEFxa4vbI9Af3OzFoxZHuexkOLBwoqjGB3i9G5CGjBTaXbn/JlUYxjdFAu2c8mMwG2CjzB0Q2+waVSTGZ9+YLTGx+VuzDHI8HnEyvJJZRn/QqO+UhOBDVdyussqzv5MTGwzw34qBZ1qfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bbml6EM4; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e56aff470bso2945435ab.3
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755097846; x=1755702646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9TWMfaZ9cUPmbpbkghmAnSm/qty+t2w4h2Z0YWH3b4=;
        b=Bbml6EM4dcJmSUlUz7zDflXVklZnqbM2wZMCL+gI31yCikEYbTrDmBSHGvhEf7s1qE
         7V+gmPaEyK+gWhm2k/laTtstKpQPv2f4CAnmfy5DhLp6pynE75Tkkfk49gvjPvPLFCeG
         SqHxq7mw/95rq61RV0dQFfYf23fU2qEBTMkt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097846; x=1755702646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9TWMfaZ9cUPmbpbkghmAnSm/qty+t2w4h2Z0YWH3b4=;
        b=qlFcTJkB0H/Z624ox1k0FsX6IPFwGNX0+sMcuEDnYFPbN1yxR6bcGVEIQs4U3S837p
         RiHc2T37kqc1jjWsMdpBwc9TdfQNm78qCUwFGBK5sfF/blyP30FdyD5mdGvI3OkEMAPj
         qNgz2bf6J75/ODOj+tNSFphcnSaVWxKJ02SkY77n7sCgd+hI20jsm/QgNF3NxTFumA6e
         SKv+p2qnnlDvaZTStF0jnkwLqWJ988sNBltSIv4sWxqM57M9UZ7aSptixqypAbGUTNgX
         DVBilY5wyS0gvGFscCuugPD4wu+zpGrefU310ld/hAL0zyhTgaqJDNcKYbtQMJURHf8w
         KDZA==
X-Forwarded-Encrypted: i=1; AJvYcCVux9iGPlaNbBr4wyz4Lvg1iiqLdJ/9Vw3OhXUk9jNBtAvBNPSTDwI9drPfMB/vgwpRxw9eZjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKD2llnqtFCMYZiBWvuSHfyiInSZ7F0KOgtIv5rSKeZcRz84p
	B3HIY5ggoh0yG46UgYpKe4GLddQkrPbONnyUUTDOaA2x6BHop95uIYci2Mm8/n42HOY=
X-Gm-Gg: ASbGncuVULZb+4gVGcd9QeNaCdOSoG6w4CvEaiSy0VHDib5UoBxt8EYwjumibcNjhq9
	KX7ky2VoqHLngIILB8x18b6VdD9g5tjzCp4+FTRwarCI+0BYfd0c5CE8XlO7s2Uht77wsrBolA0
	hY8qUrxUei4ZJG/uBzXxn+GGasz+M3ZfCKL/haBdm/Ws/W3ahBr1Grpbz5Bt6NBYA31KsfjrwxH
	YCZfatnQpxtd7Ej0p69TYg1XoyyEDJNCnq0/0jhpJcjwK7H7NqXCczRjD0PFh2HgSUruIR8o3oz
	olqB0zX1yKoui2SaUik8t3tZjfg6YB0RMKKJ0FKQBC5gC4aUxLknWG2X+rLhs1GCni7KAzf4qqJ
	qrnLQymoZMZxllPrjEp1piizhtJxA2YQkjw==
X-Google-Smtp-Source: AGHT+IGIUfrH/onUJt9v2z5NiJEkUVDB0jr+F7u/mzY7NvvGCnp6Vfd2yhacr6P+7PUvb3cdMFgOqg==
X-Received: by 2002:a05:6e02:1645:b0:3e5:5c80:2cf3 with SMTP id e9e14a558f8ab-3e567492351mr51215665ab.13.1755097846224;
        Wed, 13 Aug 2025 08:10:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e55b077b34sm19523135ab.51.2025.08.13.08.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:10:45 -0700 (PDT)
Message-ID: <8e112680-447a-445f-ba94-1d4b25ce816f@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:10:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/369] 6.12.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.42 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.42-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

