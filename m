Return-Path: <stable+bounces-42927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33408B934F
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 04:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6341F2841DD
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 02:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91517588;
	Thu,  2 May 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SSSnOVcB"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633141757E
	for <stable@vger.kernel.org>; Thu,  2 May 2024 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714615864; cv=none; b=IePg11IYi+QkgRDZOt1sdt1DSd9mQzvnmFYgvgDoTAfZOfUWdGAkdxyxHl2UnbXHWkwr4kt1ArJyJUszNZkXeM7P6OszreKvMb9jKMNCIxz1xxuyOxhVUd9i3mh1ToD+YPNT1bA2uYOyWsTKgHIuSQ5F7zaY+VPcCwK32E5ZPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714615864; c=relaxed/simple;
	bh=iRqFjcp2JS4wJru6lJM4cL35QVmiTQNsqCV46bY/XCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZZ5YXN5HL6oSaRNwso89ADqEga914otgmWz167QBRjGAjOJTlcrctvgzOogKEs8pIteWGyduMqMrkLJeHu1JYMdCs+S9fVoQIxn8BVI7WfQp8M2RDw99TTLZOuLRDY86dxowN2RHjckaa6tbx5FFjHQoG3ACglrfWyRKBmveUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SSSnOVcB; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6b362115eso58438239f.0
        for <stable@vger.kernel.org>; Wed, 01 May 2024 19:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714615862; x=1715220662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ux36Du+V3TKAlinHlEmK9kfOgnPDluyCdGYd1Ayjxyk=;
        b=SSSnOVcBQmU6t2ygOIroqfD94FLOK1j1wKpWbRTOMFao7q7ufeA9Z6t6TiYO4++bro
         QQiJ0+adkiN3s1XYgEGVfo+Q1fM7D++KlzuSoN4GVs6pIpSfKK6hVCumNQUXZ77osG8k
         KX0Ee1bX6twiyor8aMcoKmcrC3urP9KN9fPsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714615862; x=1715220662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ux36Du+V3TKAlinHlEmK9kfOgnPDluyCdGYd1Ayjxyk=;
        b=wD2GaU8GwQmYFtWJRiv8t51Ag8wjug4pg1MbQJr4/nxliYo6fGAc+jQ98PuHiTdz8a
         BQR0vAgm6alf3rE+ECfNwH020jvtrH3qUJUryEyFx7bdgKKmMuuvAkp/q03y2uoybc6p
         wGzwoIP01+ITkDzcqNqUwJ6CSpkP/4HbnB7GpsJkbU6ijJervwewk9ct3uM698jr9UBD
         kXuOh3CUG8Th2U1Es40/B//K2p+LlqGUqnjACrG9BfxumC62czgn9i8R9PHc9Efab+Sy
         GU3rsAbaINJ2+q7+KATYoE4/vQWI4Cvu1l5KnCe11muaviqQzUarBfBUwQctFtBDLFvg
         uuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXdRz3eTjkATIaqvP6DyEysZUl40lA2oG1Ux7cunNsc/aEJgU3B+0+/zw0o7PtHcpQyjFtz61K0KIaryfLjSayR0EBkKMB
X-Gm-Message-State: AOJu0YxpUu3UpJbnDyek4MPYXl7FA0T1m4khfTKCBS/nU7uf+9DCQF/d
	1HmAWUbX2q2SkX4f4RAnNih5BLKxyc0uqcYyUvcSzJpmJJfha8bqIXmCWo1Jrlw=
X-Google-Smtp-Source: AGHT+IFk7Iv7uzyxXIfPDJ7VEbUGp3sjzrH395PU9dimMM9OWz98WD5XY4sa+Y76BZDYtMhmCFUdQg==
X-Received: by 2002:a05:6e02:1fe5:b0:36c:5572:f69d with SMTP id dt5-20020a056e021fe500b0036c5572f69dmr5487322ilb.1.1714615862413;
        Wed, 01 May 2024 19:11:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id s12-20020a056e02216c00b0036c5d1d1cf3sm923789ilv.87.2024.05.01.19.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 19:11:01 -0700 (PDT)
Message-ID: <fc4fff68-3012-4c90-beea-3d28dd1d7d61@linuxfoundation.org>
Date: Wed, 1 May 2024 20:11:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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

