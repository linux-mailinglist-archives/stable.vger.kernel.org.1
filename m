Return-Path: <stable+bounces-80591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96F98E227
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 20:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11670B246C4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FCB201250;
	Wed,  2 Oct 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BriFqfOV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83C20012C;
	Wed,  2 Oct 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892981; cv=none; b=p4OQIAlY0op6fMa68oDZm9qj2SatvjwtWtQMSHprd8uhg6HswApBpG/m2kfa3FMlE53t2fU75C4+cL1wPl+O/Kp/5D3i267iDdweuAXFvOZasVg/6mZbaWQQR17AkEu401Y/1hlZc2wLqMAw6uV9S8+IMFzWeQsqsh4dgyzKV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892981; c=relaxed/simple;
	bh=p+F6Am4o5nvIqv3622Rlzj0tGof9Itwgqsrmj6FO1xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7Dy2RUs96WazQ8cHH3x7bqqi8aD5kr9EIjudfwYYkg0yBzoYHYrkj/wTRDDaRQ0vZXwKhMv4AgEYwcGe9/tLD7ohUCvNQaM+PsRkAFzVGMREAnKroKlE1ErpCXGIy6ByJdwlMOaYhZi5iU1+jnCKeM7p+G9v1RbDj2nQ7wGJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BriFqfOV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so21657a12.3;
        Wed, 02 Oct 2024 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727892979; x=1728497779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bktORYLFHNGUayeT37sdZlzfIYgEmP2B0sT7CAfbkiU=;
        b=BriFqfOVe/sW6VqEaU/Ff/Y8PK7HbzZGnVjPb3qYU3RVJ0+wwfMrff8oqOizQskood
         CoEVHpuqa/5Y0NJtEEbPyQksRmZFJdFV6Y0KubAhOdGo0DkgfjPa/OckomoGICfFS5jr
         CnmgOsYJVJAt1pU7uLISZX0HKYhMeHoU5GT5pZVSSo3i7IuXOiXEqZKjG8FlQxLLo8tf
         9pU3KD7tPONER1NQ5UN8LKL39TnrusVexDkfPE4GpqD7QCabgnPwUbOGJEE+z8Q5zU2V
         A0QwVqhdogOVNQ3nNE2OwTVwtz3linr9u/5p/KOZWnFCpDR0S+bAzUMFoD+91Jy35taJ
         Gzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892979; x=1728497779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bktORYLFHNGUayeT37sdZlzfIYgEmP2B0sT7CAfbkiU=;
        b=OrIqyGGBr7LPUdTjmPXQX8tsTMIfZkxBFHi+NVck5clEyiJx0WiUw2rmncNyttOixw
         0J+4mnu6PGb19aJaS9vNZUHANliLeN6+MzOJh2Nl4Qkl/CFHd0WxRD7+WKToa8aNDlsL
         nwxl2JVY1VB4OfEr0MZ0N68nPb9Wpn+51qJDHarlPJdM1K5lCXpLq7pVt9jGm0TZM4Gs
         gks//jvW4u/zJU4ylXjHvXXrAlLMAEL8Zx1FkxGbdDLH2fW0exjQWJKJ1UjWDKo+YPHM
         AozyNLx+v5Na5NT1ZE8iBUczYyQ5/fwftRxuzS8GFLUiBFHI0TQ5DHHYuqXoyqMMb9fc
         OZmg==
X-Forwarded-Encrypted: i=1; AJvYcCUlmPzHSI6ApeRkO4GCfnSACHvQXUk7D2AhqRYpTPHCAuoUIrkv2ICYXznCtD8kdAxPyYdp+Zdu@vger.kernel.org, AJvYcCXxPMRnndlelo+uf/BlLXSaiPV/tH2fKry+U0uMe3/SsQ5bBBLJF9aIHwhiXHpClWfQvsSU12NkIomXr5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrVnd2x8o09pxuA686lTZa5Cxmjo5brKGC6sOAROWxqdxsUhBp
	ZSTKAt2vQT5avAMWBuxg+ac7gVlPAZlZEk44xUpTnj4wPEbFbpby
X-Google-Smtp-Source: AGHT+IEAlxg5IuNIyk0tflZd5DcWA1J5MEo5EiVBkExgyMyUcPKx+g4OhM3s8idfBBxCsG2EMyedNA==
X-Received: by 2002:a05:6a20:d81a:b0:1d5:a29:3173 with SMTP id adf61e73a8af0-1d5db191e3dmr6050740637.24.1727892978650;
        Wed, 02 Oct 2024 11:16:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536bb6sm10154556b3a.194.2024.10.02.11.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:16:18 -0700 (PDT)
Message-ID: <18d43e10-f66d-478a-a16f-b0d203cc39ca@gmail.com>
Date: Wed, 2 Oct 2024 11:16:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/634] 6.10.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241002125811.070689334@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 05:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.13 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

