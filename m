Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DF671F3E6
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFAUdR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 16:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjFAUdP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 16:33:15 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5C2195
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:33:14 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7747f082d98so3624239f.1
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685651593; x=1688243593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JScrV/DfmhXD4Cc+NO+/eWA9oBP4RYcaj5oTYmiq9uU=;
        b=VANfQGUPrn2LjGh3WXPaLhUGVrHeDJA1BmHsYoN+YbXi2+IsS61LorFtjzyKa6rqvf
         2vx9K4IodE8poKBarRMzSjqGOCdfU5GwHSrGe4VSMRTLxEkYa3/0pC/bjD3Hdrz6m69O
         3L87xd8ZjIwKSM+XQRgFTYYVVD3af4K7KnYsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685651593; x=1688243593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JScrV/DfmhXD4Cc+NO+/eWA9oBP4RYcaj5oTYmiq9uU=;
        b=Cwnjrk9utYZjPnDw/xUSxmZ+yqMb749MlfryaJupiUbDw1aYV0qcYaO7DHxHPjFL9S
         d+L7N4MuF/dSb281AW1RcwxrhVD9XB+QcwOrEI24NOb7axIZVbSfXs1Cvlk/nruF26tV
         q/5klrQ5OFxgkP7CWM/kszfRw8lqeYgwJ1OA9wN/cnKoZQDoYGlFBMpKs6XrEno5CElD
         VaDnCi7UZmx+kg7Buq9sNmTUCx40NoOYWPhg6ktR3Po8Yz5eGtYLbhfbIv2uu9nvZKcD
         KrihF4OFPbbtWPaU0Hq3D0n5ki8N6vcDbcwtC1urpNeNdxUaiOztiOEoydtu/aBVXduq
         pYSA==
X-Gm-Message-State: AC+VfDze8NwHsUaHrAuMd7GN892GzQ3LLjy2wBli9IB+Er4rM4qiUvo1
        Jo7s/6k6qElHHrSzDLNEnITftf406d6tEb32gS4=
X-Google-Smtp-Source: ACHHUZ4NNj3n/x5UEY+zKRzcFDj/gAh5g/StyAp2V6buqjdeuW86xM1qNunh1nKn56anpm08EPHwSw==
X-Received: by 2002:a05:6602:2d8b:b0:774:9337:2d4c with SMTP id k11-20020a0566022d8b00b0077493372d4cmr8449059iow.1.1685651593717;
        Thu, 01 Jun 2023 13:33:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cs22-20020a056638471600b003e8a17d7b1fsm2571360jab.27.2023.06.01.13.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 13:33:13 -0700 (PDT)
Message-ID: <24603c92-1736-4691-435a-958a30d4b7d2@linuxfoundation.org>
Date:   Thu, 1 Jun 2023 14:33:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 00/42] 6.1.32-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/1/23 07:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.32-rc1.gz
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
