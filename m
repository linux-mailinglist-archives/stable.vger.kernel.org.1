Return-Path: <stable+bounces-60287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2F1932FB6
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1DA1C220C4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1185C1A01A0;
	Tue, 16 Jul 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOEDnt58"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0C111AA;
	Tue, 16 Jul 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153375; cv=none; b=fCvZnZPBeqW+KMX9XVHRwxTIrUSHXyGhFScR95wkA1oif/nWXlxgY3w8zLuaMhSS35CFeRbOe7KOQuQhgnX7otY8/1VS5TqjQBfvGFAOmDiENoNN+1/NS/4LH2ADkpr7y9ut97EqvB10amWGOuPPSnjt1LJ3EIyoOVZKM5LmTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153375; c=relaxed/simple;
	bh=g9CfOXkLcan6WBgXvNGE/BIOD9t9bAsaGP4P2EQXzqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhGCQmEB3aMpo26ozlaIsT6Yx4eo+4BjNJN89hRi9XtJZg/IgzzfUhZ+cpn7/10OjTy30XWEY64UfDj4sJMo/9HLb9IhOshMXm2BRxsRRWngOS6DD8usiRnEFKs41eETwGuF5feF4zFCnJAAdcR5GhY7V04By3YEMopqpgtlGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOEDnt58; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c690949977so41502eaf.1;
        Tue, 16 Jul 2024 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721153373; x=1721758173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+jvhKyrOsm+zWY2YedScKUBxcdQMCOw7qzfz7YdD3I=;
        b=GOEDnt58L+rY2BVf60xkZ+sdUwDcXhMNVcRMApmGhy8crlmBhfX/S6NQE5wp9patW+
         /F0W7hens+AcOhDk04ZMXpy8R+eQy07+p+5WpDPpTyrdeHazC74zz0gp32k+0EunDGut
         hRtohG/x2L4EvqLpHCm2gilPD86UCcXz2VduzVWOXYHqKxjUA2xfEQI+4voss09iRQ7L
         bUreHe6T9yQGFCGKRaVBUfL95+LZYEt04RdjdGd/la/vVEawbWxleXBf4a5pWNfx7Gzl
         B878HGXeVQPHQDDFdry6TrwoJJS5ZaFihztYFWrwYetgtZACs3OcLgkZK46Nxzno1bgC
         wumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153373; x=1721758173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+jvhKyrOsm+zWY2YedScKUBxcdQMCOw7qzfz7YdD3I=;
        b=kF3n56A5oamtQ2GAY3DXsa/CvTy0s+Fgf4UNlC4/LtNl4/kmlNtAEAapULGEtjUcVD
         eAvEetev+8aB0FhDdmKNRDQm+vARcT4yOVvxc3LXDBg//udU1k8XC9nUoq36u+32DQk/
         l37rE136DkybpmuQvvNtwJnC4Mj35u7CtpZCnKsqYA7N47IWOh38EFktn3Co+DqFMss3
         TNXWujlwuE5aT2NAYfuDjuLHvFsa2RYpwHumQr0s9Kaq0ExbONfj64QSSP61ED1VOSIf
         K12X9Rb/iXRxpVy6TQm57I5c/3lTC9Mp1d+EL+JdkUxilAOfAkmmCj3ocTZ3KfvQKYLp
         fw5A==
X-Forwarded-Encrypted: i=1; AJvYcCUhaLP0csk2RhmLdK6gZhV3mZSJtrm7mGwXWW8ik8LiGydgiP+OiLwwd5SYDfuy7NGYmlyUxYLuhpwnVxgJ/tm2DzH4r6DkJRb10z3kB5bAIngPobrWIISwsyd5h5iUIpzOaKsi
X-Gm-Message-State: AOJu0Yx4qUpBVDIrWTvWmFd8lZQOSYsKjE/t0TX0ohAPYxpSQAWp4+DC
	nVwTld7qQEN8NlF9I45D7/xqy5IZ0LYK+7u9GEjNWEVqR0hdNlKC
X-Google-Smtp-Source: AGHT+IF3dNmLleWLkSbEQrh9sPKL50qMCpAsHuIjsxgfCe1EA3kyx+2RHXisp7kDG0a4e6w2IIsi4g==
X-Received: by 2002:a05:6870:7020:b0:25e:1be2:a163 with SMTP id 586e51a60fabf-260bdfbed0amr2327263fac.47.1721153373304;
        Tue, 16 Jul 2024 11:09:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b7ebb6ae9sm6639931b3a.78.2024.07.16.11.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:09:32 -0700 (PDT)
Message-ID: <9fc222c5-2ecd-472c-9890-f109a34bdb09@gmail.com>
Date: Tue, 16 Jul 2024 11:09:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/108] 5.10.222-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240716152745.988603303@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 08:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.222 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.222-rc1.gz
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


