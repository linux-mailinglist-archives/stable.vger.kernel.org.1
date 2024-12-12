Return-Path: <stable+bounces-103937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F219EFCF7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 21:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8329516BF41
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 20:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9381A08DB;
	Thu, 12 Dec 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1mSgtRH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887418732A;
	Thu, 12 Dec 2024 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034043; cv=none; b=pFjxqN+yDvqlPpUe33XpkQDuD7dLDvtJ8jvozVk3ZDOcC36O13rNsCl+0tAYcGKUnUnM/Nnd3DXsX4zl2r2jmCvwNVSZIl/876LVVjUlroXC87pqiFPM/lirSI+DcyOzJ4k8/dLZxdgzvRc9uy4u6ulLWkoRvbpaFnyvco6ffko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034043; c=relaxed/simple;
	bh=FlPhV1bjZ+0Rf/43QU3UkdpWC4BUI2rB/HK7YHNKILs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJTtbchk2bth+JR7PdXVIEMH3GG5T2ZyhCCsoUo+5hBk3CL6QjXui4ghcrTnLWJxFed2x4jqM9nsS/DxPx7GFNBDLYF85zHPXd4+DtsEr/ePYyJE23lyKOgGQd89heJF3F1sM2fc4HaD46MHweCgd1xcsITaSpydFKrsJJOMPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1mSgtRH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a37a2a53so2337901cf.2;
        Thu, 12 Dec 2024 12:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734034041; x=1734638841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=88XXuE7Erf17aEg7l5Z2Kb5N7vsBcurNKnG7z+xy6vY=;
        b=k1mSgtRHHjJjR/yIuMmTBA/inTMKqx6ldpM6KziPEv9R4Ox0LZqi46tVCqKxNXJp/K
         cu2nNZqyo+HzVfCopjqLaiY6POwdIpEphB9npeyiH/cCrIdFqW7ntkQFU1HZ1Bx3KvQ7
         0zuYxc7QaJbcQY/fmVkv0nS8iQ9bilAmOeBjYccHcwtl/i2WiW+Uyz9xONsQ4mF/C3WJ
         EznjoWraAnPRK5btn0FHJpylDWnwOEcOkIeZqqmwtDYsMY4xlqJq8nIUn22HzPAZ5uAF
         L/fr5OWNNjdBBRBzyo7eEH9NofEZa6bOIcNx+VgVQSwrR/qTCWG4cHI02r8Pa1ElPElI
         6vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034041; x=1734638841;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88XXuE7Erf17aEg7l5Z2Kb5N7vsBcurNKnG7z+xy6vY=;
        b=dkMSCqx6RmhTpKQcpTKHhO+3nT7WOChk8ws/9zMwJjI2MdzbHhWhWK8e3tfBTcoBgJ
         FKnTdiSSvyrzZmwpf5tTvj08VAfK5nhLggYjka9w4AjDaya4rFsA6iSgoJkhu82LRVP0
         3NFbFpPSKmC/OvZPqenRpHz7q3PTGHNmTtEv8LIRXXWmn4ZIjNtpVhd0c0sIWf0lZMtX
         F8sKzZobRC3mHJAmbJIukfO1YovNosPj8UCZaNCU6jS7Q2HzpjeiGm/my/8t8sipkx2j
         7Tgd7qvxlNz72KDJuoH8PLSaFppxFoUbB9o7q+hrtjh5KSYPJQm5asX31ptZA5HnqCP1
         TjRw==
X-Forwarded-Encrypted: i=1; AJvYcCWXk9Ta0n8MDtYrufTEzKNCcdZe60CwbpCahrzCItCvFiiRBVaHS9r1g2sj3jcJeysNdXmUs51/bGMFQf8=@vger.kernel.org, AJvYcCX2NuI5hx0dQuJ0X6TbRsdPzOYgqtaMq3m9LVwoXdgIQqiearOawExzty2RfhQ1hZqwBmSrqjXS@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSoibOHp928cblXPCqLGYJbCVow5ztA0B2ZB3f3/ykU/BH/B9
	HkP+xFrpPqqPcmjb27AhzP7TFJA0pLC4MpTmZBt0QZb7UpD6aPtF
X-Gm-Gg: ASbGncuNHQu+Yt9danJa5Mx5ELm0iOr+BDzXmqDBNm+MqBR4fsMjk3SNEsK0oLpGDaZ
	33ToO6AED4Y6lRyI1ecFs4/S0P29sesFj8jL8q+J8yMpT9XTv0znX+g3LjI6u6wyxi5G9b/gaER
	K0Q5ZZFDBrU3NglSG3OnxhbcMXWFbQtkJn0dttJSqhXJOJnWkNwXlgHKf4Z+plRh3OyhlLU2/qr
	vPzi3MshOk7vxffGR6iHyIy+FpjpI0cFnGlgNjltQGIpHR4MEZ66zufJa52IBW6zQljGnM2B/Qb
	pNorOmFP
X-Google-Smtp-Source: AGHT+IFYQ7yLkmdgpklsrKzHkYqAu0dPICCKRmYn+YPk9SC6WfjfOb2Z14bJWZyoKXWoCzuWIrSlgw==
X-Received: by 2002:ac8:5804:0:b0:467:7513:3d8 with SMTP id d75a77b69052e-467a15f9c00mr23588131cf.21.1734034040873;
        Thu, 12 Dec 2024 12:07:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46783eb0d91sm28541471cf.63.2024.12.12.12.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:07:20 -0800 (PST)
Message-ID: <f370a612-d29c-4caf-8687-3cd7d1d89934@gmail.com>
Date: Thu, 12 Dec 2024 12:07:11 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/459] 5.10.231-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241212144253.511169641@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 06:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.231 release.
> There are 459 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.231-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

