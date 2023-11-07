Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0857E439B
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjKGPjH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 10:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbjKGPi5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 10:38:57 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793411A
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 07:37:26 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7a680e6a921so35618339f.1
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699371445; x=1699976245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDzkQitSyi/YwAVHmkQ+3L6zd+cMnfnuVuRUDTMMudk=;
        b=bpFQZyiD419RUYxNH81Ios+c9Bveh71nTuBquDNbBbUkHyBwWSw8rXm/AnjBIFGB8j
         sbTkvggBEtwJjtqyWxIUW8oZ+vK+GE4sgY60CzknJ0IF+6K9BD34J7OMFp7cjisjiwPQ
         dAUHdHlQlFtO7tcZRSzk8+JiLzhjVNecRfj20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371445; x=1699976245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDzkQitSyi/YwAVHmkQ+3L6zd+cMnfnuVuRUDTMMudk=;
        b=vL8Q5xvDQT5wwKixCkFbfvPlDZ2xfwifQcjJHcyuD9lZpCLHm7GakHKqhx5UrLm9mi
         7qdNGEd9yVhCjmIjVMh1rjC6wN3y2JttBY0F0e2HlYkZdignalj5+Ljupe6U+InwwmEZ
         OTH3kl3erS207ZzTmHb/LJ5EYulc8BrLfpbt8dpqv44qk8Ek0SBSt9ejy7vhqQzIVgGJ
         jCHDzLWZhfPsLvgqoAvg4emSo3i4M+fTR65Cx+oE/DhagJDD5b7lCBV69Rne96k7rIxF
         Rbps1umnSlX0GiMVNBcpj0yEojCnSZuTWWko5lbmcO3IP7Nsb0MKuk4ff2bHXn0aTTj/
         l5NQ==
X-Gm-Message-State: AOJu0Yw5/tH72ubq2QRAg4+eF/AszHFhNHo1F0KTaXKmShkv+op6o1KT
        1zyWVAKtFDWL+yhbIkxLTiRN4g==
X-Google-Smtp-Source: AGHT+IFxxAYfY/knWpIJB5/9ALe6JFyy7qTD4vgvbpq383FXiugruIENQJikmem4+TsLENoNUajfgA==
X-Received: by 2002:a6b:5c10:0:b0:790:958e:a667 with SMTP id z16-20020a6b5c10000000b00790958ea667mr32194643ioh.2.1699371445388;
        Tue, 07 Nov 2023 07:37:25 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f19-20020a02a813000000b0043321a50c29sm2703757jaj.93.2023.11.07.07.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:37:25 -0800 (PST)
Message-ID: <0bbc4351-a4a7-4e28-b1e7-082b29a932db@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:37:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/6/23 06:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc1.gz
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
