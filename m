Return-Path: <stable+bounces-4847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3FF807484
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 17:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B1EB20DC0
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A44644F;
	Wed,  6 Dec 2023 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GPHA6hV9"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82A10C6
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 08:05:28 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35d374bebe3so6534635ab.1
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 08:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701878727; x=1702483527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfHqMdgf8sbyN9wDJxguz1/nkkr9jhupgPfkwuG+lCA=;
        b=GPHA6hV9RC7C8MrH5c1bOjiM1MBiFvbDwpjdKTSDwrUDN/Y79V8eW+/caykL7gGtL4
         hFOTrfOYENi7jsil0mRIIZN1AHf0mFTPdQkaHQxnKvfVR2E3PbozH6AqbS2caM23PJcS
         MeYbPbnsDbaKQHi3y+KcvoiZsuWQpZUd5wJ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701878727; x=1702483527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfHqMdgf8sbyN9wDJxguz1/nkkr9jhupgPfkwuG+lCA=;
        b=UWauZuReDvE6I7a6Y1NPXsjvidIsk63kXy1NHPPNCemz43y1irgBelFtH/2EUHLDir
         LrqvJvauSmFpK8EDuwXJNnEUQQVKBpGyhpEwVj/dEgx3sSAxSqq/wABZo7R0yG1RJiCR
         26AhqdFjNNaKlHIZAuidHEY/DsBs2pHovlYs4aw/LsLquEJH3e4ZRVlhcbWF92OofGyJ
         C6NRheSDj6a5q34ANBqptHrRfUgPJRt2V2EEO0i0/jR2Ivh8P+/ST8cA+s6iqFp9JaR5
         6NBDDf7KkN3dZILy5nHDYlB1fU37UH9Cm+yOwVvSzvi5Z9+7yUc/wwOZn1SlSvRx3aiO
         p7Yw==
X-Gm-Message-State: AOJu0YwD5kMvNOPtHLJmCWSopoHb0sJwXFQggXkPAndC+RUQRJQ+Y0GF
	vmPaZCUyStdA1sDRdJ7RGkol9g==
X-Google-Smtp-Source: AGHT+IFASU5mVUojmqPOHR421PqQSolVDnYHY3+2N0sJLwISiUfCDxIOYhj/aS9mI7+r2gxbxcKFsw==
X-Received: by 2002:a05:6e02:1d94:b0:35d:5779:4a5 with SMTP id h20-20020a056e021d9400b0035d577904a5mr2508931ila.0.1701878727344;
        Wed, 06 Dec 2023 08:05:27 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id c17-20020a92b751000000b0035b186a19f7sm60492ilm.23.2023.12.06.08.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:05:26 -0800 (PST)
Message-ID: <543a9e8b-275c-4ac8-b4d0-13a08d8433a9@linuxfoundation.org>
Date: Wed, 6 Dec 2023 09:05:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231205183241.636315882@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205183241.636315882@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

