Return-Path: <stable+bounces-158197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35145AE5771
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9235A042D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6122172C;
	Mon, 23 Jun 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApYBLfZ1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0519CCEC;
	Mon, 23 Jun 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717870; cv=none; b=eJuxC+bpjLjRJa5FGCNTWqkfgFclkoeFuYg08mu5orN9YFfqB/2fpHOlHPyVpPF3tOom+nny5YiEGuU+H1IR3gxSnIEIqtgkgHRo9MdxVKt2Oj2RupUSyS0+FVVQ5PJs+aAYvlhZf96so7EV3VrxP/x33pQ5+7ZSMHVGtJmiTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717870; c=relaxed/simple;
	bh=J4prJqFMOZSWKIBygwjjzYfvEK0tX+WSmnnAOmH0vIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZnz19oX+wIkIhRqH6JbOcH9EGxPR9G5i1h26p111e+HXh54duirdLdBUYOtant2z2ick37NpjfjjOz1YtpW1X7phOxsbcuGFVsWuOod8Q7ghnyWHyQi7K1Ia+5uFbcxX9fhjyW7DXcj1sIH+H0G34rlYmrS+LeGEesf6ld2NxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApYBLfZ1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3692227b3a.2;
        Mon, 23 Jun 2025 15:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750717869; x=1751322669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=crs67wobF2BOCAMBhQN6sPHu3RMDqfrP+kr/UvgkGpc=;
        b=ApYBLfZ1M7hSexGWszgnAR5riJX0b3NEp3tsuevFx6rQ/5w+hweQMzBi1mZnwaDIsA
         YwfgGqPOgrW/ToROiSHs0v/nER7HNKF6kc2kOx76/OXwDtHclgojIxDv/0Ld6JDDm682
         pq/BXUOJ8P14lj4zpTIyI89YPVyRW9fC6xh/kPl8Z9nGAlCicdf+pMcr2Nw5QIUqVRh0
         PPbRRRdJj+WWwASUU94vkKTXl/vx/j3lB0wwaRkRaixTLtnuCfmzTqgAJOMAJGlKjMFu
         egczPSIrZ+HrxRpJAiBNlolL6tLWq8WVVH0TzR+U4XQIphizR9DKnMuD6wW15MgeW3Z6
         wFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717869; x=1751322669;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crs67wobF2BOCAMBhQN6sPHu3RMDqfrP+kr/UvgkGpc=;
        b=pbWGyKAehlOGFFBK+2HM4EfxnGt9QsoMx2OUCvLOtR/Nc971fzrYAZu7dQcDJwBA9k
         16JImMaOjnD+pZt/kqcgIEeU5rxJ26zYiYVE0o3oiTl+1qt8XO4SxmHQtF91vgnbJuFr
         nQDoijKUHPDGbNob+n6oj8auJna1uT8ukD4SHWpTkhL8RkrTVRIDiGG646y/8cTgunO9
         1LkrWTJ2UXxMDmHM1LU/AU4kTH1bbL4dJojZ4oaaK+dgyRgYee5BApfBdVtVgzW1vttj
         zZKRDU0rTQL4QKdpzLdkf1hk8ojR6UMhF63/PeNrW5Km0uerHLOYy4PhYfz5blxbEhRG
         LXaA==
X-Forwarded-Encrypted: i=1; AJvYcCUXT7jAsdt3ZsHcFLVYKUAYMQkitDxyt/J+bNDUCOb0W8V5Xbp/EBAPfmsXLtZcMuzGzgZNQ2wf@vger.kernel.org, AJvYcCV2rhqebxvgGqB3ayX/Ftg5QPFg3QZjPgNFnrBHL6J59auIfFHCRoP4GAGjBVk3SkpXdRNErAlSx510Dnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iM2ix6n3vRNJSJVSYti1a4lbygw/rAn5d7mI+QOybgyeFKQu
	izsOxG37JlEcNQVRLyczNCE7sFwkv7hkZfMZq9rPPZAoFkd/kNZelp1AJYu9uewC
X-Gm-Gg: ASbGncs7Wnu+kGabTQbbDAR9WVBuByug9gwnTJ4saLs2m6Ou1kvrDwJh0e2Wc6tR9Fe
	anM6RUaD8NPxgXadiYE0QgNWGIh6jrrIdfHmhYMQ91Hi6vIXjSUcsrau8tTGH5ZhiyOCY5LnmVI
	/GK0XJKXIZjsil3XV2nKHnltl5YILALZcqAa6Y3PcIrm9JZsA3nkidSfBJFShm+7aw9iNGcmmP/
	VuOzutpnA2LnyxzIpGG6f3V+2+SOAIur+qLRwv+9ir7syFI4x34JtQQX6RfwU+NiRJ1Phk7xgGD
	eAKEt5v1PWaAL1IG3sf3YjyLznQujc320I5Uj6lMPRsEsWSQnI9q1TSOQ14PIijWd/don5LzYli
	lwRKqlL4J7e+iBA==
X-Google-Smtp-Source: AGHT+IEjk1KO6eKn/BPMgWMsPPKOKrRIfqRcuAx757mpeqbEUNy0qrn+KEdNTu8FV7x0iFVmxafGGA==
X-Received: by 2002:a05:6a00:4f8f:b0:742:a334:466a with SMTP id d2e1a72fcca58-7490d6659f7mr20225510b3a.12.1750717868667;
        Mon, 23 Jun 2025 15:31:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88532absm180337b3a.131.2025.06.23.15.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 15:31:08 -0700 (PDT)
Message-ID: <fc7376ac-21bc-4c9e-847e-5e86c748777d@gmail.com>
Date: Mon, 23 Jun 2025 15:31:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/414] 6.12.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130642.015559452@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 06:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.35 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jun 2025 13:05:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.35-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

