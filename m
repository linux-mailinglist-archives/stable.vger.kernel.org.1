Return-Path: <stable+bounces-6378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E2A80DF78
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 00:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B741F21BC4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 23:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774A5675B;
	Mon, 11 Dec 2023 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnDZvaan"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA1ACB;
	Mon, 11 Dec 2023 15:28:18 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77f44cd99c6so342305085a.0;
        Mon, 11 Dec 2023 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702337298; x=1702942098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/CcEU+t9kfeqhNVYW8ZXZVMGCQYXG+cCUEuVPMjWR0=;
        b=cnDZvaanJyA6H7yN6h+F6Jacq9l3UKIISjqIc2iR5qEQa0MqLwp7fC8sqJB32czomZ
         ddAAmVaAu9lQbpQI1tBrqHLFfmj/l/gVp6kKxZQgL2mMgQyh7hiK6v1Q92RIZNLJOvPT
         CnRIb7ZwaoImGxnF8NiIarracYAvYq56s2PrYAugOtrCxBJO7e+p/h+d1rxpRhMsHXr6
         Nce7zqidO26F/mF2c7lZxNe3/S8+lqGw9rZBBnO1BC6iWpEpi4ar2a8NF87YWCqEmNzU
         Y+5Uj+pFGFAYR6Y49RelZbub/WhPJ9D7Ty3CkOX/MtcZ7YmofFsOVyKQ/DG5DJ4S49gH
         ZN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337298; x=1702942098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/CcEU+t9kfeqhNVYW8ZXZVMGCQYXG+cCUEuVPMjWR0=;
        b=lRPByM46H2Ps1BaSUqVmLnnxS+l96vbCvP7iqP9i40LNk7hNF5sDSiZgRZ9rVnymrj
         LKaRa2BXnLrUf83ShTtJyWIlu0M7ww7XDtOqv+FysLJQsRihM/+a6N/laR2wJ0X5N7AE
         l1PmAbCTEJ/mWRKvDmWH4wMExrXg+pXbsK/3G8G5Bx85x/IOwqoR6kxxOdAW4xTFJwbO
         u/Bny4TpF9Zjc0ktT3wv4W3/mUmexx48yS1csUW55sc/fk2vpfk6EOIJqeRNFvBCz+xM
         0dKwlOKzmBF/mQUiwgF+1ZifW9JztICrz6jl53gKgwwesXo66RwnVaDOdcuqQ1BELe9b
         Wowg==
X-Gm-Message-State: AOJu0YxZWiXDwRhUv49Qb4SiVjkG6MbmEaku1AOVmCHildqZzaNktnmo
	bh/mWlc8jG/Djg4FWo5mBqBkIq0Gmqc=
X-Google-Smtp-Source: AGHT+IHOAg/4UrVqKpIdOiMYEw91NhkVrr61GYObY+JC4jNoSk5FEMkCyS25SKrirdNU1VFTYlhTaw==
X-Received: by 2002:a05:620a:2992:b0:77f:3b24:56c7 with SMTP id r18-20020a05620a299200b0077f3b2456c7mr10563991qkp.18.1702337297948;
        Mon, 11 Dec 2023 15:28:17 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a19-20020a0ce353000000b0067ac2490d95sm3688058qvm.136.2023.12.11.15.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 15:28:17 -0800 (PST)
Message-ID: <f24b655a-3921-4ae8-8536-c11357b9f755@gmail.com>
Date: Mon, 11 Dec 2023 15:28:11 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/141] 5.15.143-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231211182026.503492284@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


