Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFF57A8E8D
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjITVhj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 17:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITVhi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 17:37:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0520E83
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 14:37:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-797ea09af91so4526039f.1
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245852; x=1695850652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTMZOz7zfHEZnxo271y0b24B0nwEkFYYZgLSU5ara0Y=;
        b=Z+Szb6LP0i2gtMuiE1Z4/+Tros+n5A2uR4l7kapcRkD97JS+NudCenqj20qhzeM7fC
         m+CvYJoH/4b0vKfPT6fZN40T5kmqlMVdUlddRh8gxn3K5i6C9xIl1dCVd7rCTUkOEX60
         gQBp9n/kaWrpFYBsjAWo/a86rpH1wrT4dpXck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245852; x=1695850652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTMZOz7zfHEZnxo271y0b24B0nwEkFYYZgLSU5ara0Y=;
        b=azRK2qXQ4AuwywKACpgBSVK073WOjzfXST/xz468WzG3U/d+nGnx7Oui6bQazh/8EQ
         5CO9zYCjTYbjz00+MCD07JyipckUJROO++3iQHN4qhxsAfzg8ejpAyB7oqy6gDh07OWm
         KDVAnQ0mKO3NUeYZ5jcgTElfA9ZGphY0CYYYdUs4h0nEB/eEOaxJFcVWRIMuwXD8yo0x
         BWVOJXfWt4MLx4UpqBmDP+OhjccHl192/UtPjPLJts8Fsfukjy6gogqkxQ1S4C2DBSm3
         kXRl9Fw/bK88zWy3b52EpkH2U/ME9AW2hgYJtLNEz/ndmdz52C2h8kRObwPcv+SWGPsf
         Jqbg==
X-Gm-Message-State: AOJu0Ywg2TyiBi5fmaQX1wY72ghe9mON6Sj0PIlZFanLPgSrh7d1Agy1
        ILaXRfqNhPcMS2lp/FV5rv8j+w==
X-Google-Smtp-Source: AGHT+IG+gK+YYQCk4IAiV2PPKsJx5uyC6ZxdPHbNqGW18/9b8GKsVSaBcs6rXtre0KtZ7uGd7+FmAg==
X-Received: by 2002:a05:6602:121a:b0:795:172f:977a with SMTP id y26-20020a056602121a00b00795172f977amr4007024iot.1.1695245852407;
        Wed, 20 Sep 2023 14:37:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f5-20020a02b785000000b0042b2f0b77aasm4203305jam.95.2023.09.20.14.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:37:32 -0700 (PDT)
Message-ID: <96958c2b-bc0d-72b5-fcee-51d86bb5f7de@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:37:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
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
References: <20230920112858.471730572@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
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

On 9/20/23 05:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.257 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
