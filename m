Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE817DD980
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 01:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjKAAPK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 20:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjKAAPJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 20:15:09 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB247B7
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 17:15:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35904093540so4697145ab.1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 17:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698797703; x=1699402503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H01XgswRPGwawONIAmjiaU9xQBusRZiNk3wBO1wRmYA=;
        b=Q+n1S8UVaCm/kz6FjQB1sKgWjGJNfZQ9jUIJCHdqnKE7hBmvUPr6Nx3vC2kqSksWus
         N2bhNI20sdpzamT4mql3lTFUMoq7s00wX4NNjukUFfchtoNub3j7Bmsmfpz/9K3KM7RH
         D9a3UbVMO8r62GiYT+k2/FUR28sgU028fz880=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797703; x=1699402503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H01XgswRPGwawONIAmjiaU9xQBusRZiNk3wBO1wRmYA=;
        b=BkOOrpsjDiwaH8CPrSR/dmfuuFNAtsZmtAjfoO/rT3J3dDoC2DInY3nr9BFxTCho6O
         qk+jdDAnfOLecYc6eal4naY4VL7Ie1qEOd3YuDqyFWhGErZqi0lZN1q7Adzmy20oNwzA
         ZtxIneFeWVyCiAw3uq6nP1594tlnMcwd4D0PoRJn7Hf0V/ZkXHEaD84nY2MUaffZZQWr
         iP9Cwq/xDWUqjJwmG3vomgJskxGY6YXRKxYdAUltvG3fZIjIIGl2jVkmhN6eoUjnwq2K
         6+jWWutLzRMwZBz10Cd0jt/dwB8x26fKLe3KQ0in/9zVoOoeAmB3VAFe5/ywKMFT+cW6
         +bYA==
X-Gm-Message-State: AOJu0Yx2JFXmExTUY36AKd8tJcLDt3Zajlxe/Bh00B+e6bG4yC5MAyVs
        jQ0rCGwPfR2xqD2kLuawuZx61A==
X-Google-Smtp-Source: AGHT+IGl+WxhoFAyV7WnhN40xADAgliUOCfNAwIL75Rsrgz0hw4g6miD1Ry9thMYblpeYpqd4Qn83g==
X-Received: by 2002:a5e:a80c:0:b0:792:8011:22f with SMTP id c12-20020a5ea80c000000b007928011022fmr16901322ioa.0.1698797703330;
        Tue, 31 Oct 2023 17:15:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l14-20020a02ccee000000b0045ae21e7291sm614212jaq.32.2023.10.31.17.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 17:15:02 -0700 (PDT)
Message-ID: <1140cd7b-e1b0-455c-8219-1b31e0227bc3@linuxfoundation.org>
Date:   Tue, 31 Oct 2023 18:15:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
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
References: <20231031165918.608547597@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/31/23 11:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.61-rc1.gz
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
