Return-Path: <stable+bounces-4775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F4806138
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 23:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CBC1C20F8C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 22:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94396FCEE;
	Tue,  5 Dec 2023 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsuX86rl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CB71B5;
	Tue,  5 Dec 2023 14:01:08 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d7f3a4bbc6so3418296a34.2;
        Tue, 05 Dec 2023 14:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701813667; x=1702418467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BIl/aKA2ZNDAhecAebxG1OpDsA1pswxzZOP5ytc8JU=;
        b=ZsuX86rlA2S4UvIeYDxeN6unicYWQNUYHZAMSCe5bubbEJSEvA1Bvvu/c5NBARLJ67
         ymlMFT8Qpu0XzPW+qXNF4l6/F7MAjY3Fii7WTXbJaHFjsaG48LwIsNwJDQ2zVqgC88dp
         iAcFTk06Id6lfTObuXCLtpNwZuHsDoYnwjukH7/+PLDg0WXs+aUjpfzOjw5Zs817dLnE
         tVEWqXyAhdwG9u90vFQkZw3eb8QUsikkxlUp0gZXYityZ+qKQJ7leTrYW5SHdty+bcOl
         bl4m3nH2Yh+G+tb5FVPaItnx9c0oOHUYzOo1n77VKCR9CG8o+cMF/PaqxCat8GG/XLX2
         2jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813667; x=1702418467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BIl/aKA2ZNDAhecAebxG1OpDsA1pswxzZOP5ytc8JU=;
        b=Yjn/lh07E5JRZx0o5NnpqpKhKArC4DUiaDgX4piWYBI/4Gx/oXbTdW/u6Wz2uD7Wj2
         jF5ciT/o0bTFg30XBQzS71zfOnQrHf0cNPguFJrGkv31Vn7TZk1sS8m3l3I0pVyxGstQ
         yr4ARHnNO5xLu8xFZFGiAAI1THtq3r27bcI9p6c+FcCx9vv95vEx0YP/sc0lM0JVchPq
         wB5OBnm29I7KH7d+aKl6v8XiN32a4hZ67x8HLmAyR6JFxdTKafhzoKdK6KdygqqUxbel
         gL7s1PakMOcZzobvZaoQcDVmKyKrFA3M6GISw1Qd8AkRTEoD7IP3OrkV3/dGqjY1YDPh
         taQQ==
X-Gm-Message-State: AOJu0Yz2MUMJwajbD0nbxSh/yaoQygaiULgmV9YfKXj0A6mfNv+ev0ja
	Q67LyXevki1JeRCEdEascvU=
X-Google-Smtp-Source: AGHT+IG7st0GLhMIOr+Wll+/6m954fOY+eTkZAdBV6RjhDfSr8IXDFAx3nVYvp46966f/F/R7mF5Tg==
X-Received: by 2002:a05:6830:6998:b0:6d8:7cf8:a069 with SMTP id cy24-20020a056830699800b006d87cf8a069mr5818601otb.75.1701813667175;
        Tue, 05 Dec 2023 14:01:07 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id hg15-20020a05622a610f00b00424059fe96esm4671316qtb.89.2023.12.05.14.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 14:01:06 -0800 (PST)
Message-ID: <0f8a55c2-53c4-4d97-b2ad-e0c9cc30ed2a@gmail.com>
Date: Tue, 5 Dec 2023 14:01:03 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231205183249.651714114@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205183249.651714114@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 11:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
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


