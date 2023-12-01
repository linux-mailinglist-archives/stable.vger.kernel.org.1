Return-Path: <stable+bounces-3591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A767FFFE5
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 01:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEA1281B06
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 00:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3C5368;
	Fri,  1 Dec 2023 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F1E3cbMw"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9E196
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 16:09:28 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1f9f23b4fa2so302863fac.0
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 16:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701389368; x=1701994168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fHHUuDWZn9YqqYK3EYAhJra7nQxFC5yxmzo6hYrotQ=;
        b=F1E3cbMw7WdlGcPDREoA6iDs/vuMRsVzWyNJuAMxcW+/TC4SweAp36wrGw1IQJi14l
         3HW9zwhKYuCGKdgGBq2GTnKwWilPReEBSXtPdku8YHiQttkiZbl+389ACj/Pzob01lik
         nAEG9+fRoLZ8ACEBrEKl4GqHPkAYMLnbVwMyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389368; x=1701994168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fHHUuDWZn9YqqYK3EYAhJra7nQxFC5yxmzo6hYrotQ=;
        b=m7CFiOJ3GOjhuDGSXRl8tqZY5NysCvR5OtKjef7HmP2U8UEf+xJhDnhjyV8b95OovJ
         /pcEYGDXfVRfoeWyjWF1A/FW9dnicgdHSlPmpy/Nl7cdt14La5HpA7SdSB6kbFr/fzzs
         vlPpkioxpK9zSIbs3BjjIbMKZIHAeqKPHQkGH/rIz8BTnY9qQ8Q3GOwx06+xWfdgbvdZ
         MbCiXpNc1roKSNXSV2v1C/a3Ow5Ay7HuhQ0Sm/q0Iw2JS3kw5HOt4PZVaC6vSfG9ZZPp
         2XrLKCHNpIxs/Urvy1oyjim4gIliY35dxCf5prGYFmLeTY2FHYzDl6wElujfH61iasep
         Gakw==
X-Gm-Message-State: AOJu0YxKAdCGGgTubd8t3ZlXDypyG8WSIj3yiLZRyJCH3CvXx7EisyTB
	MCpjnTtKs/YPeND1QOvau6HXZQ==
X-Google-Smtp-Source: AGHT+IG8zzeD/auPSzGDXSrUbTz7+QRxnqkXG7XFtfKuRtBOeOFYfWJ5FDWCIruPxeg5QPBDml1OIg==
X-Received: by 2002:a05:6870:4c12:b0:1fa:3b7d:157d with SMTP id pk18-20020a0568704c1200b001fa3b7d157dmr4532394oab.1.1701389367779;
        Thu, 30 Nov 2023 16:09:27 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e24-20020a0568301e5800b006cd09ba046fsm315807otj.61.2023.11.30.16.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 16:09:27 -0800 (PST)
Message-ID: <30b73319-4958-4089-8dbc-7c72e66cccec@linuxfoundation.org>
Date: Thu, 30 Nov 2023 17:09:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/82] 6.1.65-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/23 09:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.65 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.65-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


