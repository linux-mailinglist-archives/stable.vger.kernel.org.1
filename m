Return-Path: <stable+bounces-45179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D38C6931
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE191F21578
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BD1155747;
	Wed, 15 May 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LIycBO1R"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E515572C
	for <stable@vger.kernel.org>; Wed, 15 May 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785497; cv=none; b=npYfUWQW+flODuXwVC6s6mcDtscEYEpRvq2yvnbYRs/hv0KnIaE5izeEzRfHYP6noWN2JktsJmAek5pq5mRxZGmxvdofM5zFfMdFbKqNaZ2SFeLq29F8g5bz+Otm+rSFy+u6dL/FFdTrITxbb0D9HdnM98MRna42+j9jGr7wUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785497; c=relaxed/simple;
	bh=KflAjJacvHjs1RVSIHnQWp2/DStGL16WtVDIhgf6ZbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgiGqV2YMPQrctxrUe+sSg4dFyMywK90ummtzLez79y7l0F0I59hSA8hqTt2AhWiJH03i0RuI9uKAFKTjWOixdX+FgsEbZGiLo+cEEUlG/uX+2lMEMuEyChsdkArvwK63t4nNV0JI5lSPY4t4Y+J/p9/Lk+h5CGq/zfwxAqdeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LIycBO1R; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d9d591e660so23670339f.2
        for <stable@vger.kernel.org>; Wed, 15 May 2024 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715785493; x=1716390293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARNv4myOiz34n2955O0D3STgOGbvJhvrIoPTodeqsuE=;
        b=LIycBO1RWrXGVOeIQwPYdq4UQt8AXsypaKeWh2eMBDhi+UJAA7dkKyKWRk+eFSrBOb
         dQuuycnuI55jGLY3TBlFKXdmjB+qSyTak3K6P6s4R4wITPl/hxFtJVMO6QySjsT3iyPJ
         7y8zPXffkCzv8w6P0H/XP+OFqeRFB9hSW6d58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785493; x=1716390293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARNv4myOiz34n2955O0D3STgOGbvJhvrIoPTodeqsuE=;
        b=E8+pG8L87y+nIGbBUhNfslyxCQ5zYEJknAWaqpoQNvH1LVTj60OkWevw3TDw5+KtHn
         bIjRjY5rbipHaiHSSHL2jA+MpJP243+IhECtGeRp3Of/S7iuH7fuRnv8fhkGx6wAEC2N
         bR0dGWoBGiOybnf0efC/XEaD58WNyJfVeWOmDModqm1/sBbPHHiNMozy4LaYjNaOAP6y
         mng/EcFBTitix2tFzLEHIbwr6KEI8DrzXjWsCpc0T96g2DZfOu1JFagdthtMIFo8FA8m
         pVPHHz/B97M6RTwydRB+s+0hyyi571Y90LkmuIJG/NgGUgS/BGVpZJsaMC1gkNp9w5B5
         6UOA==
X-Forwarded-Encrypted: i=1; AJvYcCVmD0Gwf85ckkZBcp8p0IVFaZ8W74+ER2guCvW+dmCAsSimNBCJa8S7eRIV+LRMD8RyqPJHWPBHRLD/gQhy5HsPU0w7vax2
X-Gm-Message-State: AOJu0Yy2JIyNpYYPHMKk/mYgfhfO4FMGO3yPbrSdT9gLDSTY5eSQT2kU
	uSMcYPD1eMpqlGSfvHjwdPuLXsMHogfVkmnoo0LO0PeafnSQ8r2P1AJS8qQZkzIusurSWplABH7
	UcjA=
X-Google-Smtp-Source: AGHT+IF8hT10bt/12xnGpOweZNoPPER50rWWNs0TSukXJHWHG43ACWEkvi58mLCmBdpT853ZkzCpmA==
X-Received: by 2002:a92:c988:0:b0:36c:c86b:9181 with SMTP id e9e14a558f8ab-36cc86b9470mr143647785ab.0.1715785493475;
        Wed, 15 May 2024 08:04:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376dc9a6sm3548097173.140.2024.05.15.08.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 08:04:53 -0700 (PDT)
Message-ID: <1eaf604d-097e-4512-b279-6ce2aca79cd1@linuxfoundation.org>
Date: Wed, 15 May 2024 09:04:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/63] 4.19.314-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240514100948.010148088@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240514100948.010148088@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 04:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.314 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.314-rc1.gz
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

