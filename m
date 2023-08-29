Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1678C6F4
	for <lists+stable@lfdr.de>; Tue, 29 Aug 2023 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjH2OKb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbjH2OKS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 10:10:18 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE569D
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 07:10:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-760dff4b701so45290639f.0
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693318216; x=1693923016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mqq0/zdBfxA6LY0W/aBRbvmqJ4sa/IPttGmwOYqApKo=;
        b=NyzFTqdHqMm3XTp/Y8UgS/8mesJwgeFvF9XVxpIrxxbL622+l/szmYW6DikCkGAPr7
         gDEvuzdcodL1sJUD4ARmeyTjUtnTyIG9gc+uNgaRO1PrHxSzlsJ6A6gPNd5LAEsBKMlr
         ARoNit2syUqK63nDbXiNoWTizGovfH5j9weK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318216; x=1693923016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqq0/zdBfxA6LY0W/aBRbvmqJ4sa/IPttGmwOYqApKo=;
        b=Ol6y4UYHiOV8Wj/OrjtDHgxWXEMptu7yn5X8GV6xVYBWJPXPm0rlKQ7d51NOkKQLBZ
         gopv0qGxxHPQLg6/zYZyQfDSanlGvtSHlkVsjhSSpZB5tbWin736I/WWJLGR5ocz/0gN
         kg0LugP5WKfr5Dyd60+NBDOHWsEx6tcXdFlCLUfuqR3VEB8SmqqwRbQenUEQXmIlfwim
         c7nZw3mrBFVx+e/gvKUKq33BArSR3G6tbnZd2ghQxDa0FDWPy+BqizZOKo62n7poNfeU
         FGr41Qk12v4j3UmoqDvmdxkhK2HonI6vhz9agbvfxpwvuVVV6b60CuvlLwiPXD3KeCUv
         ioWg==
X-Gm-Message-State: AOJu0Yz6AMYhZ63PA+r9hlJcLPY1vw0j7rSFD2f5AWZ0obVKOooliXbf
        n5RpOi9lYOTNJhzWtUhTSJofmA==
X-Google-Smtp-Source: AGHT+IFSet4A+TbHg4ZXf3gpuGrsePA90jB6PKYRC+y45A7GcOgJHCuWbe1ZJk7pDTAJrOAKOPykbw==
X-Received: by 2002:a92:c6c7:0:b0:345:bdc2:eb42 with SMTP id v7-20020a92c6c7000000b00345bdc2eb42mr29119426ilm.3.1693318215785;
        Tue, 29 Aug 2023 07:10:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t4-20020a02cca4000000b0042b16c005e9sm3196823jap.124.2023.08.29.07.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:10:15 -0700 (PDT)
Message-ID: <d7383d61-9c6d-616d-fc5d-6e8d9919bda0@linuxfoundation.org>
Date:   Tue, 29 Aug 2023 08:10:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/122] 6.1.50-rc1 review
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
References: <20230828101156.480754469@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/28/23 04:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.50 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.50-rc1.gz
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
