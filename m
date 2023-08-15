Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4677C4A1
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 02:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjHOAsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 20:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHOAsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 20:48:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42847133
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 17:48:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77dcff76e35so51786139f.1
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 17:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692060482; x=1692665282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukogAUa4ocH8ByC+yfaWUlJyirwsSGA/r/2pc70jO2g=;
        b=HB4+b+sHrTF6qOQjgz0IL9t5QHSzfIk4wpavGIC8e/vJ9aAwxBosFQxh8cDyO8yl9c
         fCgfE4NCWOMAA5I4KUaEMsap6XfUswIyZV+urtLoiq30nYKlmvM9plHLTRnfMBWBdvk0
         jkmqZ4ixVPzn1Xm+kylG9lxk4Mr55F4dwZY/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692060482; x=1692665282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukogAUa4ocH8ByC+yfaWUlJyirwsSGA/r/2pc70jO2g=;
        b=JMyZHIsIFVnknDxBdY7qgXZfe86DSfYT814adHOJ/yop63qkpGncL/InQGGunQsvbg
         9+0tLhrqkhedyhp0Dx65i/Ph7iNMMePLGNcDPf6RG6j2SoNzgnMnCoyIj/FnNxykvIBj
         AN6z3VsPdKj4t7uZCL+XXEkcMXAJHv1rPOsYkHzyXdc+r1UW/MIhAOLFr4vW9ExrChzC
         YrHr5hC7SSj5fvsRmvWp6dhXMWVaRIOP9AfZOKf+wzzNXIT8uLv/6LZ3mcOYY9mKauEw
         Ss1n7R3tSUC7a62x71yduBtc8kbBG+Xg3x1LcU66D2O2XQ86Tdnqv9p63dlOJlQSk2CY
         tGyA==
X-Gm-Message-State: AOJu0YwIaNXYTMsz83r5OQ6cfou3ohuA/pCYARLF8huJXApSwljKQT7l
        CvMlDNXJFzinS2p9HKvhbgYIRA==
X-Google-Smtp-Source: AGHT+IElHmrz0ZozMelXl4KgM3inJg7xAE16vvhdPbsnqAtkfank5asX6xxKIeVMbsEyihL/tfpujg==
X-Received: by 2002:a05:6602:3a13:b0:783:63e8:3bfc with SMTP id by19-20020a0566023a1300b0078363e83bfcmr14241537iob.0.1692060482678;
        Mon, 14 Aug 2023 17:48:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id em6-20020a0566384da600b0042b0a6d899fsm3363834jab.60.2023.08.14.17.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 17:48:02 -0700 (PDT)
Message-ID: <a2b84aa7-dc02-dd98-9a27-e9969c8f1824@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 18:48:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/13/23 15:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.46-rc1.gz
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
