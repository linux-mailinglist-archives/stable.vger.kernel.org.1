Return-Path: <stable+bounces-4750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AA805D67
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5681FB21104
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5496A01D;
	Tue,  5 Dec 2023 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqBjJsa8"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA06918C;
	Tue,  5 Dec 2023 10:35:18 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b8b556aadbso2277106b6e.3;
        Tue, 05 Dec 2023 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701801318; x=1702406118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zp50cEMhA16nGXEsXh/65k5s1OUgtftGnHrdudTWHl0=;
        b=jqBjJsa8r+qXUYgm61vVAiruKmIQuWM3RIoPRCiy8q3xSc6ZFBAx8GfqvJ2zWVBhar
         K8MTJG28fs8pisowyx2OJN5yqmGy96igFfZpCAzznI9t8pK/uqgZaPvoPomsg7YroIgN
         Jpg/z18gHKtRewiZzxPbZ1qmVXZALgjzIrZja2eau9XsI3yJkOq3i1Z6RHLnCHX0Rdnl
         1rCqmsgDz413D/E+SGy9+aSfTOmIbeodsm63uGhItEg12Cc8YMzQEx25vOJkJZl6Ldp4
         xNfPIthqgJrq4fzhMwutd69c/gOENFxWsb7Aw/8LOw4W5p7fgPP3DcDQtJ7/KS18SATg
         FNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701801318; x=1702406118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp50cEMhA16nGXEsXh/65k5s1OUgtftGnHrdudTWHl0=;
        b=fP1G65R9Vt5MM/CLuETqrBYNcJMD+BjpCrK3JL6B3zioUY+b8WO/s92Ty9L14L2dGW
         OrhxmroofkQvU/pBFD3Ov+lwPQaXWdq1tWn9PFI+imM65kjMDjM3qNYIgch5jnCQeD82
         nrwgoRdnsvUg4BVhHunZSRyAdg6YtXp71qYo18FYIdfnpZr1/Vd21U/v6JsH8OFsXxad
         CbIAjmuatBu0mBSB2eOqWH9BsaN0XS7jC0Uy4CxDAHctW0xRFkjbUA+IhrR6KGx6/yF8
         1lHieXY6kmRUBi9/aZ2o0OATd8/UBBix6KCD9pR3hKdftWjXi3v/4V/LSQXcYPA47Mea
         zHDA==
X-Gm-Message-State: AOJu0Yws22X1TK3dDURj9gcYR+efBZBvPvaFN0y5kgHjR9Nm9ED65h2x
	xssB/th29uQ6sqtQ98vpsAw=
X-Google-Smtp-Source: AGHT+IH1zZJz1AecXGZ7V2IG87FO1soRW88u6fqO+HLSk/N/EZWXVJW9vwfEn6HsuUyXB3KlUZ2OXQ==
X-Received: by 2002:a05:6808:13c5:b0:3b9:96a1:1f40 with SMTP id d5-20020a05680813c500b003b996a11f40mr3934064oiw.44.1701801317850;
        Tue, 05 Dec 2023 10:35:17 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id vy13-20020a05620a490d00b0077da601f06csm5289868qkn.10.2023.12.05.10.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:35:17 -0800 (PST)
Message-ID: <0a676e7e-9b6a-476d-85e9-21fa6821e9f9@gmail.com>
Date: Tue, 5 Dec 2023 10:35:13 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231205031531.426872356@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 19:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


