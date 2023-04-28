Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F316F20CD
	for <lists+stable@lfdr.de>; Sat, 29 Apr 2023 00:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjD1W3r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 18:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346745AbjD1W3q (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 18:29:46 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897D846B7
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 15:29:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-760dff4b701so2609639f.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682720985; x=1685312985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Boy6p0n8qLopxE4kdZMs85c3u3Z3pk27Cau95jGvS38=;
        b=AxqFfMerAPZPVYpMRAY46fKJ0DhoFUgnHw51zsrb3Lr04/brzvNQD2lwyf7EHhkRhO
         71pWYuMmQSV7fWbZkDJ84eNteBAP0FIfL+Cy8RBOAw8BCEMjZ+Xqz0pZhI/ZjRDNbgDk
         7ePe7hp1PfsngPr+igvxsenvTLmoLadU0+Kqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682720985; x=1685312985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Boy6p0n8qLopxE4kdZMs85c3u3Z3pk27Cau95jGvS38=;
        b=KvDQFXyfwmm9XKLbSUiQco5iN2pZ2AV06JvTwZDH5zA57mVXxoGxjThVkyni0VMQv+
         RaTrV8wzsIkZMDbApQlKPtwTcFx7XmOy4Kh2+R4kaTFMx625aI3+78FeKcfK1IaZ8zlT
         DsV2cX6+MhVwCjYN/SP/EeGsMIZJO/V9EMt76hIvh2+5kopc0hOYACMngw11wCHDJlZl
         fBlE8Mld4gZ3EDG+5lxj/2FYxgN0p6Q4BjXSaVxDnY2/L/BghlYGJShv3VEyXzx29qPm
         Tb77VvsvFiyk6H+7seezYu+3Cuq2BIcZd/n0HyLz9+MqKFucCIA+DeIRKap0SlSQtB/z
         Wp1g==
X-Gm-Message-State: AC+VfDw8BWkCkI40fmCzA8jM93aR4ksnUcYXhXT/FavLyIKtDBqFDfR9
        FPJKkwOtgHil7fOr4LfRS+Taiw==
X-Google-Smtp-Source: ACHHUZ56M48aorTP2dAefEJ2HRjRwrNDGc4PTjENkU+4VXTA3Ni1PQiOEC1ZyKlgDJYCLfncGvoekQ==
X-Received: by 2002:a05:6e02:1ba7:b0:328:4634:7ed5 with SMTP id n7-20020a056e021ba700b0032846347ed5mr3871162ili.0.1682720984852;
        Fri, 28 Apr 2023 15:29:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p5-20020a92c105000000b0032934416cc8sm344111ile.27.2023.04.28.15.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 15:29:44 -0700 (PDT)
Message-ID: <e018355e-46ea-8d4e-4e24-201c717ff887@linuxfoundation.org>
Date:   Fri, 28 Apr 2023 16:29:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 00/16] 6.1.27-rc1 review
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
References: <20230428112040.063291126@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 4/28/23 05:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.27-rc1.gz
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
