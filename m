Return-Path: <stable+bounces-6358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE1A80DA89
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 20:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534B0282103
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1244524AF;
	Mon, 11 Dec 2023 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNRm24YU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62417106;
	Mon, 11 Dec 2023 11:04:39 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67adea83ea6so35287216d6.0;
        Mon, 11 Dec 2023 11:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702321478; x=1702926278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fUIDGd0KQpiVx0QnEq4QPqvvyyGBKsYPzxwNFGD4zg=;
        b=hNRm24YUBuktHxfFqrWU4TgrUZ3+1Ip17N1erSnCKefN5rXy/9OQ3p5EeU0yV3A4A8
         pSle6OOYcDKRpVSbcQBXlxNtMf6VQRotAAhjDrTHnQ6Y8969fYrDeaH6CXxlSFCsUtP9
         x1rO9Xgd2EDhHtNYzPiaWD7W+0Pv057gWSFQOSVZvIvWLz9hdIytrDMOTaEYn8sB9J3n
         6Yo+vpB84f3F1HhuAza8kW0gKvZVB/LFdwNb6h6EcF87+upTmxy2j/VU3MnHuBp6KhvS
         hJKapMhNwtwiBPG6KEKJrLlIL9lZt9M1/TNBV5TWxsMPV52/dVT3Qmdc4I7ZZfpwW0Zn
         IEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702321478; x=1702926278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fUIDGd0KQpiVx0QnEq4QPqvvyyGBKsYPzxwNFGD4zg=;
        b=iJs8jcnxiPIhDFfwyIQ8Y6iFY3fKZCPQvDN0FcPVxdigeVucSg8qXufQAccUh7su7V
         udm8yebRPru4n8uW81rYuI4Tmb/nALvpIUyCVOk8STuL41UTIrNT4cvUCIGTZifCeiT8
         oc/k+gHeqkdCpoSuvUZ7hgFVio2eM9N236gr2Pi8z8vlk/OxPSiKvaEWUbU+V6S0ElTX
         TyQ/oifSWX1nZwKJeykRmjzhjS7OauDe2yBxqRcba2K36BPMOJpLrdXSjR/95I6rPmj8
         lQB0enhQZYZ8RFsvkD1DiYbKKsGbFRvR9BrFLHScuPhRKq1F6+q+138U9UTojNOfRQuo
         ZHeQ==
X-Gm-Message-State: AOJu0Yy+vl4xkOoT6Pp9Qu33XpERTsHUo78lVngcsLA9+snHkniWtZ9S
	DlfTgz7h+ePoUYyDtAHnV/E=
X-Google-Smtp-Source: AGHT+IFFPiRBGN3dmi5Ucvy2fzkixUTrsr3Dz8XWxnKWbsTXNEIqMUNXDyfefM4yxXdbkF5PghY9yQ==
X-Received: by 2002:a05:6214:b27:b0:67a:a947:72b1 with SMTP id w7-20020a0562140b2700b0067aa94772b1mr5326532qvj.13.1702321478398;
        Mon, 11 Dec 2023 11:04:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x15-20020a0ce0cf000000b0067aa31371ddsm3493378qvk.80.2023.12.11.11.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 11:04:37 -0800 (PST)
Message-ID: <031b2a9e-9b2a-44c7-aef2-191735da83a7@gmail.com>
Date: Mon, 11 Dec 2023 11:04:30 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/67] 5.4.264-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231211182015.049134368@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 10:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.264 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.264-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


