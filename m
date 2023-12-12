Return-Path: <stable+bounces-6468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3F80F210
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7841CB20BBB
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6377659;
	Tue, 12 Dec 2023 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fw+lP5ou"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A66AA
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:13:05 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b7117ca63eso34962539f.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397585; x=1703002385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oyzEVdmAliGsUngMkAe6aQzEr895fuMODSqQrJ+wJs=;
        b=Fw+lP5ouz3iD0Wk9+iyQrlYs/g/a+SqRzeOo7MYF7YRLnybCkrRsG+ZoCfyorteqzQ
         2MBQ85fFyNK1/+Qlfmsq0oIvhv1f8M+XYOEZvdorZek9lINuR829QfznNXy6UTchPuIp
         mty//N/b9wFmu01rSCoVoxqeJlU54J5QI6Taw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397585; x=1703002385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oyzEVdmAliGsUngMkAe6aQzEr895fuMODSqQrJ+wJs=;
        b=LBj8/1PnKGmDxzUpYl5RzNeJ6tIGtiVyvjcJNS+djZJiJXnSHQvbu8yX7de9AB7NAH
         F4tkzMeemXTIWvUB7jAPya00i+JHzMQ6byvoPvvqzTOC2bP3XC4faO+U3pw+pP6fWcDh
         CtMYrXJfax6lyWX8PyCakux7psOu8c+PQ+rjfaFk6Q4qWVdLoenAYD4Qs/foXSPAiVjM
         7OW2tu5hXKM3ni9X++a2QwiFRgXhrAL5ApwMhHslOp/eusv0BMCDe8SuVNiWS/v6s/Ww
         HIQNzE1Q0DGYbGwJLgrVIHxT5u/Y9x/F9bXH0TRQ9GubwzBJXk1tf9t392Wl6viBYRB/
         5eyg==
X-Gm-Message-State: AOJu0YzFOS0BoTQ0w8GSYHmgWFOo+IhOjScMHNkOmpwPEvErAOAOomV1
	faMGGyiOAjHasJPPI0dqJkxLpw==
X-Google-Smtp-Source: AGHT+IFjRYP2mc0SFnikAhhPerZKmWl5K81RkC+VqPe7I6E24/T0KK8w6EA39VLWbZw9d5EE73Wiig==
X-Received: by 2002:a05:6602:257c:b0:7b4:2bdf:5a27 with SMTP id dj28-20020a056602257c00b007b42bdf5a27mr10661594iob.0.1702397585277;
        Tue, 12 Dec 2023 08:13:05 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:13:04 -0800 (PST)
Message-ID: <1d900249-4160-46b0-aa66-00ff2a7733b2@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:13:04 -0700
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 11:20, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

