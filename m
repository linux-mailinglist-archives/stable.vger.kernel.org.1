Return-Path: <stable+bounces-4779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087BF80619B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219361C20FB1
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F096E2D5;
	Tue,  5 Dec 2023 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf9RAEBD"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FF8188;
	Tue,  5 Dec 2023 14:21:57 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b898c9b4cbso2045703b6e.2;
        Tue, 05 Dec 2023 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701814916; x=1702419716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Cm00+NsimWLmQhdVNiamoI86kNbnX3twGr4LUKJDhM=;
        b=Nf9RAEBDQIemb5FZRx6PjzZVwR05w/WLE84VV1+X9b45lj+UZf3ZgmkinzJ+snV91Y
         erlAZgWPENOYCjiOH83azGAnfF6TjNAAfzcY7puxRI3i5293iwy331w6vFcVWO1PYBU6
         T//zBj4SLYzfZISj6+RNoJX2wPktgd8cmuDh7ErTp65hT5sCqLbkmZD9YNnkwgOeXllb
         21kezIp2RZA8uHBo6FvHI2JowgCXzloSZAP/Nmv+SH/+ZGNPteF3iIK91BrlusF/Q5FR
         VWx1pVyGxxGOflAycEPxSsnpWyBTscklzhrosiL29DiaZhafwXoTtXmTsP3aCmyHyBxB
         hxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814916; x=1702419716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cm00+NsimWLmQhdVNiamoI86kNbnX3twGr4LUKJDhM=;
        b=WrwositaNuGxh07DjhoXn7RxnH0emhV0fZvUuU0B+IE977xIkkVx68sAY9K0dja63m
         yX0sbh/6Sr/GK3NAEJrkXzvh5Cza3u2fZddVssqs9ObhTDX6o/SbKHqS4XFEKxSL6Zfv
         u3BAi+SSQq4YCvFbqiPSdZcj/nh73jsafc9xTzHSNLwIB5Z2RLVeninVU8ipdZNiFypT
         VA5MVHbf421OqRDtzYmMUpqdp8PgHQzKqlgJWJbboH3ZUI/YrAAaHndRbQEeAMrdKkcU
         WbkqZOKxAlb3OQfD+qVraRh08hpjwi55YQlMKJ80VkXu+KDw5eP8586tmApfid9il42/
         dNgw==
X-Gm-Message-State: AOJu0Yw++vJlL9qlIJcLV/QxW0wbshMM6uiSlD8OaoT9H1Axjs/x7TL0
	BbNuZ3/Aqlmgj0E3aVpA0Nw=
X-Google-Smtp-Source: AGHT+IF4bbGVePAgZJY4DL9eEdSzz00zGPhOiVdsVZDaC3YBbOyIuRcnhDp84gZ5xB8AdhJzkfis4w==
X-Received: by 2002:a05:6808:20a4:b0:3b8:b063:892e with SMTP id s36-20020a05680820a400b003b8b063892emr4300608oiw.60.1701814916133;
        Tue, 05 Dec 2023 14:21:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g5-20020a05620a278500b0077a029b7bf1sm5433609qkp.28.2023.12.05.14.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 14:21:55 -0800 (PST)
Message-ID: <96e7ce15-bcdd-45a4-ada6-bc21a37f2279@gmail.com>
Date: Tue, 5 Dec 2023 14:21:51 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231205183248.388576393@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 11:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc2.gz
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


