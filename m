Return-Path: <stable+bounces-194645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B49C548F1
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8333B22FD
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356AD2D7397;
	Wed, 12 Nov 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXhSghs5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6101B3925
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981835; cv=none; b=jXHooMWJan3HqEkhgMLKVgu1TsGC84EsZ/x4qx95o7g0phDx7TAlr6cARtpK4qucHlgczr74M7Oq7g3vqrWCK+sDljZscw8GA9z5XGJxQHkzDOCZYJBq6ItgSYIgoxe1EH4S/ozUGnDQWlLcHNvUeHz4druWTbtm9XpgNT2Rruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981835; c=relaxed/simple;
	bh=NFCiZbCWZdsDuxKkR+3uhYDtGTTOmadQRYG4/hTK6zg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UbbJduVJz7T8+S1TfbcIGoTgkxXvAkdWIvoDScGpo2RoP8DrI6xqZ+iYJ5m7cRigXYhlC79T0yOcn/FP94ENXlnwbNWS+tWNR4gUcI2MjRzZNvYfKfC3olTTzR75DC/9jhqkSKIhGaqMOXTBs5bVLNXPHM2rmmgkuDQVfLHBw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXhSghs5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8824ce9812cso1178366d6.0
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981832; x=1763586632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q8qaWvPN3J8o3Bl5ry+HYdP7j93QWDZn/Cnz56U1Aog=;
        b=BXhSghs50a4FDsSg7n2sUOYCsKoT4fFgVOH0h0skFAqQOf9/jjLFIffeb+UpAfGDMK
         NE/WGDzbcd0mG9sfFjWNiL1+a8o0BPTtAkN8eFxDavC+ySyYvuZGA9A6SMBAQ8NM66Zb
         lda6ZctYFFJ3gzp9tEnKAH1uGEg3lJ83cRV3jFU/78uEUGhpXVQtBxJRhPGI9uzVFeOl
         QMY21Mucaja6n/nVW12U56g45k84rGr0/3VZ7Pl3SQRyVzEVRNsMJtp7e09RnAO2Sr/X
         MOhlDTpDplVk14+UxzJcEkjjd2N9foC0i7PfvXygOqgIkNNrIBzl/M3CMEM1drkxTLIB
         jygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981832; x=1763586632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8qaWvPN3J8o3Bl5ry+HYdP7j93QWDZn/Cnz56U1Aog=;
        b=L5no4glWs0OiuBenDF1Cdfh89w6FtAfivlx4Q0HhyD2cyeN4/RcKREJj51k5QruSX8
         K3n2tsXPvFvgEuXscNv8qkPJlK8xjQDZq0UJb5DqqlCHDd+PUWcMRbieMuvEzGvEl4XI
         GxJhxxJ1SqgEo0xOziqEs/u4YcKmM0EOaZSmum4esHc4ENAG0GERvEyEXF0rFsVRiqBK
         eKkLt86BTN9faKjYNSFDSwB3wnYtYum8vpoHR7CwIr424+RWVZ1FaRyVhjtvWYGuQ/Qi
         F7mZG25GrW/lJd7R0NXnWfqmFsOPoqUkQPlUYFz1b19NhEKf9sxTJZs1OiFj5YSESjQ/
         jtsg==
X-Forwarded-Encrypted: i=1; AJvYcCVhRl0v+HGY3dbOjRywy5GM/FPTCvwN5D2XWxcKCwXYHJlaHPP6E7P8MYPVa9P4D8eThMz+mCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9tWj5nGpRf0QqjOw7oKZmjDk+7alqr9m65CtYXzga6OS799M
	9MUxef3EWEI1T+vp5mIme9KSwM/o9Tqo8qKCZ+1VpmB3luTSGc8oy2lD
X-Gm-Gg: ASbGncvuUN3NUCeS7k2Zgj1yl7XTE+puq+6ZI8Bg9xD66C4trkuPyTs4LA8O8L0HbRR
	nExOCdMxNXEKCgnPPCaYkW8CguVjW5qcfrQmD3LP6zPcOx6zw7Z+fu/DwtRcw0Gw6QngpHpr5xI
	BfuBkicUiQaIwbiGzYbwA5HQ1Yj7bANuFQgKqxED3a/0eoQc4Vuuz+nIrBGuh99C1YNhLmJpBLm
	2YUNJswwZW9O5NKHWv6c/t31mOs30R9SsZxyniKLJfNWKNvjpIJJHp9mb/aQIaYoaiD1fKAaSJl
	6PaHEoQKafYFamxJmK28R2C+Uk2yx8IbFOJZKBBhDvn1DJUfZOsn+QrUS6EplZxuP7wrLpAMtSA
	BgjJLm9k+Jpxhou6gx5tl52dUJZ3Pr3ESKMyvU/VwviGlHWH7SE9Va+IxD2RUZYIsrkAiGspYYi
	OP+9GYhcZ8Qg1Z6uyzdnCT+4pJ6sY=
X-Google-Smtp-Source: AGHT+IFofS0tn+1q/BFHwqg8tHswBktjEiPFttAd7/GfZAqUecg++L2+A/6CVudzDds3JxckzQyKcg==
X-Received: by 2002:a05:6214:48c:b0:882:4a63:63a7 with SMTP id 6a1803df08f44-88271a4232bmr71218726d6.60.1762981832057;
        Wed, 12 Nov 2025 13:10:32 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823892b84bsm103123356d6.10.2025.11.12.13.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:10:31 -0800 (PST)
Message-ID: <845a2c50-8d2c-49bf-bb47-2f6ee1c31d61@gmail.com>
Date: Wed, 12 Nov 2025 13:10:27 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251111004536.460310036@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2025 4:32 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTb using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


