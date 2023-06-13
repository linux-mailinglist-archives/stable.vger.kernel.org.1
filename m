Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C942D72D69A
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 02:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFMArF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 20:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFMArE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 20:47:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A322710D3
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 17:47:03 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-760dff4b701so49504239f.0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686617223; x=1689209223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmjM/dRJidQfKguFBam2mPgsQsHoFPzaRQGo375W5P8=;
        b=gAMbBeMggeuiAjdgkrulOmgIVAY7V5E6KWDdOurzhW+Bc4BkbTjixYbFK3styWR1xT
         U2j5UzjWlNRKQ7iigc5MCrjlMEf5zXi2KiezqakvxZMDlyhld/4dimIkOd5qPq8qYuvQ
         6Vv6Us+h2VuC4J2KS2sW3jgKR1liw3O0lRhmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686617223; x=1689209223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmjM/dRJidQfKguFBam2mPgsQsHoFPzaRQGo375W5P8=;
        b=IVW7dwX/ss27Mz6whgVb6uwp2etWpzEwlZKEM7ZOsw2NE0yMESky4Sd8MmMxiUvQam
         uSKZ55U8gW7B2fvIg605OKhWEWPnIU+sYXMlGnTQXYuW00RX3lxEbGK01a+rNmQ1kKkc
         BGwZZKsxF2hUkfKRw8Bsw4fjBYSsb39qbwOh2DSC0/BA5W180A5TTy7R/cD8Jxk3q1Ii
         B0xwRA5btxc9a5qpokrbYmhofrrgattpj/Zc5jBrw3ynv9aSaJHWPX1Cm/mOdy/VscvX
         CquCESJv8dA1vo9AxZkA599ZcllVsgirWWTVl28NK8qip/PAKDwO9vu87jX43PDk7aQo
         F1AA==
X-Gm-Message-State: AC+VfDzxwZasxP9A3ge28b5wAhI9UgpCUDLXbs4VxAxNlLrCqXhtFtMj
        kKFSbHvKA1B2UJLXzLMoQxJlEw==
X-Google-Smtp-Source: ACHHUZ7Zt0PUB3W0hglufQF5/lfwOVJDETIXODth+qZK6FonW+iF851KtxvZ4jXmJx1VrNbqXjGXQg==
X-Received: by 2002:a05:6602:2e07:b0:777:a94d:a362 with SMTP id o7-20020a0566022e0700b00777a94da362mr9730462iow.2.1686617223020;
        Mon, 12 Jun 2023 17:47:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056638293800b0041658c1838asm3082379jab.81.2023.06.12.17.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 17:47:02 -0700 (PDT)
Message-ID: <559744de-1f36-4b36-2dc6-c14354fd4e2b@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 18:47:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
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
References: <20230612101710.279705932@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/12/23 04:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.34 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.34-rc1.gz
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
