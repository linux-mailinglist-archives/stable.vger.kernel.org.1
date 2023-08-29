Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0678C6E9
	for <lists+stable@lfdr.de>; Tue, 29 Aug 2023 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjH2OIY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjH2OIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 10:08:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D558109
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 07:08:01 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-791fe25b960so10668639f.0
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693318080; x=1693922880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5A52SOhqx+LK1llSr0QkkwCAZdwMynClS+NesllUSg=;
        b=ESAbl/DQTDF14M08nuV6OqabJeJ/XfgWJ9UcBOnIAbjdxF927sZj9zXzUd2VeGPrF9
         dHucC5SBp3C6y2Q5SqOqfTzPN3EIjRxZgIsKy34+s6IZJAj7pUPOizUe+hwuD+wNdvwW
         G09UXS2jkZ7IuVthlSs9pClLCG2GRQIAZyYtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318080; x=1693922880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5A52SOhqx+LK1llSr0QkkwCAZdwMynClS+NesllUSg=;
        b=RJ2kN9V6kOOJrHFKwN/+YeSUh8mx34Rt+OpxYHAXhwxRTojJaYdD2ac3OlOJomJPHW
         n/WHigUWqGJzKUi+8ub4ZqBBtba/r0eL2Vn6tpmVtqeVcAGqPyvwAgjWP0oTH/K4ybf/
         MdeJsrIpHc9pklXK3Kae6ExljdmLhW7AOopgoERTF4yr/Ejk8JDq2wvEvw/4wXKDPszA
         6fOVz59hAoI62IkCpR8JxGQ0FsNaEXMVMnv+HYy+U7ipUVU9EVoUdauKBYC/aJ8YLuEz
         c3Lto2I5z8XNW3u5QzA1gI1/y1A2+q3YQLFIqVZrrXDbNaYnvIIw2z4oDL9CkKwHCiw2
         V34g==
X-Gm-Message-State: AOJu0Yza9PH83mLGuGwt8EuyJVnT0O9ssjBsNxT8fotNCONz/yLce7ak
        akX7kukMYA7zBZWjpk6Xayvxgg==
X-Google-Smtp-Source: AGHT+IF77SqYKsSv7x93DBydszfo6Yvo8h02fntFgI9+7/+WPTA62RjvgnoCXrBuXLffbcN+zbuYmQ==
X-Received: by 2002:a5e:8911:0:b0:792:7c78:55be with SMTP id k17-20020a5e8911000000b007927c7855bemr12984783ioj.0.1693318080641;
        Tue, 29 Aug 2023 07:08:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id gc24-20020a056638671800b00430996b3604sm3211365jab.125.2023.08.29.07.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:08:00 -0700 (PDT)
Message-ID: <2fe6f656-23f5-1fcc-5387-c9c2ed4dc701@linuxfoundation.org>
Date:   Tue, 29 Aug 2023 08:07:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/28/23 04:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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
