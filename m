Return-Path: <stable+bounces-6470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDAA80F21B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A31C2819B8
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B387276DDE;
	Tue, 12 Dec 2023 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NwE3Nbyh"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C7F2
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:14:06 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b05e65e784so47492739f.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397646; x=1703002446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bmlfvvZM9RQjnrj4u41EYEYF+Fr4h87K1fw5d/6M30=;
        b=NwE3Nbyh84NfEYDx4tKDsCVuJC27TBov7Bg4QMNgFGtgkB0WSNVTWuKXue/AbEysGh
         8Ruro0Fw6guB8dwRKld9FScg+BEXl2lpmg11YG7/6UyGYSjbSYYW/HGZTH+CpHF3hpB5
         +NZwJBaDpsLGTHcMVctyzmbePTlqJxlZ/Hp/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397646; x=1703002446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bmlfvvZM9RQjnrj4u41EYEYF+Fr4h87K1fw5d/6M30=;
        b=OiUsyqIdh0vU89TLRW9gdxgXmiJ/7ZXlpAMGhWKpW4UXcmfLYuQiHIo9OxpmOxJKic
         I4Pj3rm4cmpG/aGxPBTKHTycAIC9ONKo6BD/Ebq/zcDsCDC6lpVuBubFyamWK2pFxYqK
         TO3EhxCXXoXRGxd6lu3/Txs2ND0/YfKBVCp2QVAZ2hEL4OQoEfRXDvTjxzG+ZHcj40QB
         UVAOjHw0meGirl9ekdNVOa39evdw1p009FTOl2tC5lPX2PxS+b+POCwIAg5t19UZTA3l
         TUHGvustt3VUQmeR5rNuvj+DiE21hbsTYk/YkfWhcJ4lUGe2hg854d5sTvB2k7pdGUxu
         +fPQ==
X-Gm-Message-State: AOJu0Ywe7L7p8+eF3kh644RDiykqfoAJ3qm0cdFWrsjMuMgUnhQHdC3+
	uIazdvfWg3e2uAX4y2pHLACKXA==
X-Google-Smtp-Source: AGHT+IHaG0x3XF1wweqZpO03xiSwEpRTZvLSUofRfC9gC3CFjErlqRHWOrCssJBqgyeHMnjz9O0VLg==
X-Received: by 2002:a05:6602:254e:b0:7b7:3ba4:8949 with SMTP id cg14-20020a056602254e00b007b73ba48949mr7121414iob.2.1702397646086;
        Tue, 12 Dec 2023 08:14:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:14:05 -0800 (PST)
Message-ID: <734382b8-9858-4c56-8c66-25d140807dc7@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:14:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/55] 4.19.302-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231211182012.263036284@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182012.263036284@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 11:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.302 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.302-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

