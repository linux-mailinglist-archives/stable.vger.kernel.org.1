Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08FC7A55BD
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 00:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjIRWZ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 18:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIRWZ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 18:25:57 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B6391
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 15:25:51 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso3818665ab.0
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695075951; x=1695680751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Rr0MlffztlGN+Dy0ATYiwBj5tqmkbKs8WVMjmYmCLY=;
        b=VSRZi/RMZNKv6UdjGJzAeqHfTg4gD7AzqGQmppHYfDXJ5RlodUoSXZxrY+stnIRRJa
         L/utUXiRCijD+jkUDhBTEnKovA24g+DvtmO5RMhVZGd5xk5cfD22w8OtQo2yTvrW8dqj
         UO9bp8XJv6kRocJlAd8QqQbMYtRpFcEBy16jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695075951; x=1695680751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Rr0MlffztlGN+Dy0ATYiwBj5tqmkbKs8WVMjmYmCLY=;
        b=SVeT9zSmdjxsW2UhTMXLy4+RZHlrdyBArOGNDlSUI11DS2iBaEEgdMamzuWqGU9p9w
         nramdhs18yxxdcJU+n32+Ka4lInuMnSyWGfyRa86YG91pqWT9IRYycJtV4tql0huZE+W
         qWKQue1yhVnHR7JzZqFgGHCInUX2hqupNDn7ERtrsUf50adix70LtUWb4n915kC15GGO
         5/w0JcQb9R5aFFi8Ea0g4F+OZ6fCxFZ1cPLrf/Jmupcf4MZDQWwtHfq7KD6TEO1/kPdU
         lXe0JDwatp3YhonqndFz9zAxplxCNJB3c11fyvGZmwuUAqwrxW/03dSdIgCnzZerx4iA
         2SpQ==
X-Gm-Message-State: AOJu0YwpBmjhSpTPbqhM6m+NccnyrdEJCJ++JP79qKOBC4a/05l7wm8H
        BN1SZGrq7HfNpB5PCRD6NUOWHSI3P1tq+hQjhb0=
X-Google-Smtp-Source: AGHT+IF/bvEbcnzsPqYzgQ7yplNPSXCWWJUy/HB/NbpKfspYUsNnNefYLIsPMNmvxfGdrHvek4g8kw==
X-Received: by 2002:a92:d20d:0:b0:34f:b824:5844 with SMTP id y13-20020a92d20d000000b0034fb8245844mr10310495ily.3.1695075951328;
        Mon, 18 Sep 2023 15:25:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y19-20020a056e02129300b0034fbea17e75sm2619936ilq.20.2023.09.18.15.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:25:50 -0700 (PDT)
Message-ID: <7c78ba71-fae7-e640-4ecf-78e2ef5ec129@linuxfoundation.org>
Date:   Mon, 18 Sep 2023 16:25:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
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
References: <20230917191101.035638219@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
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

On 9/17/23 13:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.195 release.
> There are 406 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.195-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
