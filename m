Return-Path: <stable+bounces-204375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C3BCEC472
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3C443007C59
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA422882C9;
	Wed, 31 Dec 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT0xsaem"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B8280CF6
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767199361; cv=none; b=gHLVLGf4OmyH4f4iy5mSNM0Lq9KRnVnDBgyPSWBCD9Jt51OG8k/+xHbebX0qqHUFj+cu5aW90us56fielBETEb5ssLZGAFkiSxTD9vUtUmNLUY040iYxaN2zIKpm6J0NZ1VTq1LXkzDqAsvqjr3wb0g2DWCIbWN4ENXjQCh/HYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767199361; c=relaxed/simple;
	bh=YpCg3qw+Z1wkIcOm4rB2dEF4s6zC158uPvyqzAu8hgc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W4GB2nBI3sHFFdYsapZhg2FQzoA2eZiFsckm4Hu/TyoPT+f3MKVaZstPPnMfFlVeZRDq/REvYlzB6800R+34fbOAthkeUzJovn8HXvC4iR97fCGoSeQy1FXyFVxGef6Tg2N2j88ZaoAdOmiHKAZpqhOTv2OK2+luhT9b/8ctst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT0xsaem; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c20ee83dso139671705ad.2
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767199359; x=1767804159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oKHQ/a06IGiaHLwaEqb+SclSJxG6Kp0hGdhM04nP50=;
        b=CT0xsaemxTiFoxacePNTZE6vx5HWmsGohSBsMPS5osaVE6uJBxQ8Eyg7Hbn//DguwB
         a3haPOF/H6G5L4GtZZUL8qGrJQCdoyUwLvTGRZyAQ8YbTDdRGLm8u4pfWuxQwpb3w4Bd
         BpeYSSz38EXRPC01uWhbvroFerX5BeWt8j3fKUeRFkLxmzb3f1WKYQMdW4pFGfDNYAfx
         GpLySKjcMM0JyGAx+6Q9eF6holbwrYNvN+BgoiSNXtSHW+k6diwmksQeayUg5+Cj44sa
         xLTvk2ODt/P906UK1Ph7Sr8McKoEYht3DIHS2C1Nh3vCDtM24Wci4NgvOEQT0RG4Ku2i
         rPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767199359; x=1767804159;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oKHQ/a06IGiaHLwaEqb+SclSJxG6Kp0hGdhM04nP50=;
        b=GbvjWo/yekfS7o9Sk1dgVrNhbDpEH+n74EnrXh+8acPQUC/uSKEhmjMDG7mp0C+xAN
         89N3WB8fJcrXw1ygqQDOoBQAIdfkFsbXmjVxs8MIbP0NfUhrbscHsqjXF0F2W86lTQZL
         IiCuTN0bvNPR95VML3jfpLOCu05mkpvXbYYBcwkFlSQ1lJaLcENiooTA1+8rJFR4yUOM
         OZYykGHW4VgYZoW3Cj63QAisRDhHBCQnttTtxoBg+m1ha7VT12vNEJRBpB1zbMvwhBJP
         9Bc6++OPIyZjY9uduEAs9hyNsUqL542ERGmxB6nZKyAcx25qZp9GyZVfVto1AKITYYwO
         9Qqw==
X-Forwarded-Encrypted: i=1; AJvYcCWmCD0DP+OYVXbPBvMp3SURvO0hOLR5BPnJcmMtaN9a3OADqO1cDCH0K1GvNk7KIp8rj46x7kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzfqFNd8pXVMsvlEpW4T/bV5ljC2p1CZ6EfJjT/ECq1wvMwtS
	ey4wN5ZfNILAIUtHDR3QONDWyhm5w43uVy8XqeI6dnB9Hmq8VE34zzsr
X-Gm-Gg: AY/fxX6N3+6ZFbkVN59hJidNLzqswhCS02In5F6ofUp90Vw9NJIFzNjV36LT7Nxe00Z
	Nw8oO2aHlSKIm7lfW4NHzGuMsnevGco8b6rEQTsYwAPkQSYsY4Oj2YIx2QUF8zRtm0x92iQ8SBL
	UmajoZ9s3XfNrJf+NMle8WUpVYYW00dNbM2wJo/PcnzV+CaynKiJ/aD1zSwZ/qIQOsm7Fme1ICW
	QwA4qMGlwUMBuHTG7JirmITII0QEM/kafv0iXBVnz5GY5UjPnhzzgrH9JSSna9uNnu4KWTbB979
	iP7N7jhsbnT3sqYF1YM0dTgDrhtXKUP+YKIz9SFfG8nis2oO3vinVvvm1jmAJJSDtEHiA0ta7mQ
	SncTSEfSFaI6m7kiI8J/zc6eMZJdTzKJEkyL+XGsEDgsrQLAyE9sbPutM/SQ/3wHuoR05rhWUO+
	lu9nQw4zwZrD/seW3eNBQIKO9DnSVNb+qCaHE0GkkVcqLNLG7kfjdQ
X-Google-Smtp-Source: AGHT+IFBoAaXyfy0SkCC/oCwJazyENqfm00APYCRV06LNH0kLYlcc+IDqG/xDcpHfu2EMDNPQrIbcA==
X-Received: by 2002:a05:7022:6886:b0:119:e56c:18a5 with SMTP id a92af1059eb24-121722b46c8mr32858031c88.13.1767199359365;
        Wed, 31 Dec 2025 08:42:39 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254ce49sm136098635c88.15.2025.12.31.08.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 08:42:38 -0800 (PST)
Message-ID: <2af82725-2ffd-459b-aee6-12cc8e5635a5@gmail.com>
Date: Wed, 31 Dec 2025 08:42:38 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.18 000/430] 6.18.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251229160724.139406961@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/2025 8:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.3 release.
> There are 430 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Dec 2025 16:06:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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


