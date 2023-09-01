Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF2790058
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbjIAQBK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 12:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbjIAQBJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 12:01:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BFE10E4
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 09:01:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso572675ab.0
        for <stable@vger.kernel.org>; Fri, 01 Sep 2023 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693584066; x=1694188866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCsm7PXzMA4syA8CcbnCY0pyK9en/7AsjazHCOViui8=;
        b=KPri6qk70P9io5Y8CK7EJWF9xEMFjN//tviUwc6u9W9omyktH3laEWg6m9vK/2tL22
         dxNC85spxM3jVn4RHuQui/Hdo7n2ln25m/CS7XEsBFz56qlmuW024Y/w1dL438Rl4Ym9
         BheGqL+qISJpHd7nOIR04izJKiuVSC/R58ZJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693584066; x=1694188866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCsm7PXzMA4syA8CcbnCY0pyK9en/7AsjazHCOViui8=;
        b=Xj21PSTLDqdY1oyEQR4R+j8gvfZbXIkTqhyXwWqpwwL9fxICyrrkWxFQap0yl2Uke6
         kpaYp/FSDAH41PMHCWXHe4Pljh7Ae228VdQyaQzxW/ogPO5cHMuZz2p6TP1pYLO2QZQU
         vx+dWGz2jmPYZPsQyuDcCq6tkQFreakYwLJ2dS6cQNg0m0auIWnfd+NLD6M+OxiOL+hl
         l74W66oEALl/YTlsGK9wA0p+c75qDRowjo0i+DzpMo+UCDjpYK+1Ep3EKG5ifjNtmZfC
         c49Vwm138NaYX3TyefnikB/EiMqk2gwx3UG3/hpJE9d0/rWeqrx2GDS++S6moo7eQhGU
         YIWw==
X-Gm-Message-State: AOJu0YxsmG1aPuMxrUtmsUDHb4wLdCUdOc3WuNrzbz6OCfR5NI00X9yB
        AvsPPY0jJCpGlSM6eV0n0jnsSg==
X-Google-Smtp-Source: AGHT+IECl/yIAZ8YZTPgtDkBe82ANt3cbAnEAFiOnhj4JTckTUTkOO2xqK/EcdV8L56q0eNCdCsdHw==
X-Received: by 2002:a05:6602:3886:b0:792:6be4:3dcb with SMTP id br6-20020a056602388600b007926be43dcbmr2833593iob.2.1693584066384;
        Fri, 01 Sep 2023 09:01:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ge12-20020a056638680c00b004312e5c9b0dsm1097780jab.139.2023.09.01.09.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 09:01:05 -0700 (PDT)
Message-ID: <73970980-0076-292e-67d3-4563fc0d53ab@linuxfoundation.org>
Date:   Fri, 1 Sep 2023 10:01:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4.19 0/1] 4.19.294-rc1 review
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
References: <20230831110828.433348914@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230831110828.433348914@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/31/23 05:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.294 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.294-rc1.gz
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
