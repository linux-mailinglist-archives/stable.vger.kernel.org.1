Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9977A8E8F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 23:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjITVi6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 17:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjITVi5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 17:38:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011259E
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 14:38:51 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79f7d596279so4671439f.0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245931; x=1695850731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QY8PVgVpIHAID+AJM7qZltvMhQbKxhG6t29eKHUi9O0=;
        b=Wb4lmqOsd6Y1VdqTr8MN1/PodcE6dfpZJschv+UhNCci2Npo1ncRHR+urZbUJ8OTVl
         QVynQnvWeJsBe8AkvZa8z75GFVns6Hn0B8BkVG6YjejO5azTCwS9QhtMQ135cOH9tWuc
         Qw+OykMgEbeeAZSbIHYINy6CZ4hPc4Xc3urg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245931; x=1695850731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY8PVgVpIHAID+AJM7qZltvMhQbKxhG6t29eKHUi9O0=;
        b=UAIgEY2CNv690OGYL48EpIaX2qiUpKaOeANV/4KZWKkm8Uq8wxoAl3X6RvBNUyFWuc
         8Sbc+L+U/1UXMmo8Z9Qzt930pvqdG+PIEv/6Dwhye1ViRKr+A60i2b+D0q3xle8zjyUw
         BF0NJBIGZgZr480M45Eb2jVEOC2yZZKw/Fxnfo5s0LUoyOBBoyAiEM7YKo/A0BSBRvps
         wj0fv0pZfy1Y6hEnk8/6bnN9wKxtSUwkLrRFb8H4Zg3b+1t8QojtOths3pBneIILKnoD
         uzW8OklBvE0SHhAzL//oRX6oaQFAXUXJYlKkmVFxRCiEZg8oncU1QSL5RMypazlKA8mP
         9okA==
X-Gm-Message-State: AOJu0YzxN6WsaGR29z5hNlUGbYJrD4UIV9GyQRhjBNujZP4ZHA7/xhrc
        OKva05/vuSZltZCMH/A2oeLzzQ==
X-Google-Smtp-Source: AGHT+IGeHWyarZCNN2M1V8niROtMVtxRAlyZHQiX5ZEUHbSs7i9apmB2jBsqQqYB8J9AtOBuxissgA==
X-Received: by 2002:a05:6602:13c2:b0:79d:1c65:9bde with SMTP id o2-20020a05660213c200b0079d1c659bdemr5599120iov.1.1695245931384;
        Wed, 20 Sep 2023 14:38:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n2-20020a02a902000000b004290fd3a68dsm4262773jam.1.2023.09.20.14.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:38:50 -0700 (PDT)
Message-ID: <db56cb31-9615-c4a7-3740-17fa61e7bffd@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:38:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4.19 000/273] 4.19.295-rc1 review
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
References: <20230920112846.440597133@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/20/23 05:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.295 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.295-rc1.gz
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

