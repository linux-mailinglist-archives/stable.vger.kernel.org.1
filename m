Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03E78FFF1
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjIAPaT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjIAPaS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 11:30:18 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644FF10D2
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 08:30:14 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-792973a659fso28486039f.0
        for <stable@vger.kernel.org>; Fri, 01 Sep 2023 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693582214; x=1694187014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiNqQgFbnxq6FrJH09GmzjeX1g4Nw3Ac0YdAkmhUigU=;
        b=TPjKIxbyE8lXlUnJGVhrX9vYvXcUntwoAMtfulKdMfNujqGLCXA4Qnwi1YTA1kKz59
         RHWpeWw9Ngc2lNS9i4iPNB4xhneyAM4Liox+NIl+4V41WeP44g7TL4rNBcQ8FDTdYCBR
         l3pfW/dXbrOPcoPlg0ERMpd8B4D+AazPX2U/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693582214; x=1694187014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiNqQgFbnxq6FrJH09GmzjeX1g4Nw3Ac0YdAkmhUigU=;
        b=Wgy9Jzwqc/k0P75/rLAni3YWIC/cLNF4qurSPCf9jItOeAzI/GkvjaaPlULLnMMlWq
         kS/4E19GkuUZN0mUNhamJQWtGJj3i1ddKQFbWEjxEVazWQ/ANe/dx3nn6kn47yZKXiLQ
         lNJhI4PDcDT1ywd76CYVX/FRIWeeGLcjSE7bDMJtFaD+UjJNlxHfQ6ZDaMEps5/hyiOf
         ZRyVPGVpVTqxo2KOa+SnZ2NBEOoFmswEZDi703pIGIWta3rya7R8jhw0s/llCLsTQBgN
         usRls9ZNU3rLngisQRW2ZmkVnJ/Veal0NbgRUHHooT6GLBcuMYGVgpKLnS/hK1MOEeBd
         OKAA==
X-Gm-Message-State: AOJu0YxnxER0IpZepKkJLXrHcul+1M1ECKa91kyB82tZPw8TYjcK6wNt
        SAy40b1PbIZI5KGLnpADHtFP2Q==
X-Google-Smtp-Source: AGHT+IG9M+xHgmCy5lDFf7tZbtMhIWUBTnKbt8HK9BHpFZRD0iyJvCFw9WD9Z63nDpdojJjkC/C8jA==
X-Received: by 2002:a05:6602:4192:b0:792:8011:22f with SMTP id bx18-20020a056602419200b007928011022fmr2525210iob.0.1693582213821;
        Fri, 01 Sep 2023 08:30:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s10-20020a02cf2a000000b0042b320c13aasm1123350jar.89.2023.09.01.08.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:30:13 -0700 (PDT)
Message-ID: <afedcfbd-1f77-230d-27c1-8019e658efa2@linuxfoundation.org>
Date:   Fri, 1 Sep 2023 09:30:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
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
References: <20230831110831.079963475@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/31/23 05:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.51-rc1.gz
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
