Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE1B7A8E58
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 23:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjITVXi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 17:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVXh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 17:23:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C83CC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 14:23:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-797ea09af91so4318739f.1
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245010; x=1695849810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+kTXKWF/KX1FezcljKFfED0Qa2CUlrf+Ao7Mn6CWqU=;
        b=a0AD7IMQn+Okh6csFNWDxr/hEfJEYSiu4h7i0CUQ/6xd0K4AS58pdqDpASmL9WpJQQ
         DhkW+j2AfMFWfNFw6ic+x4dTrCieXAj7hSmwl8JzudCXeZoGaqcEDYY5vsxpZOucN6yy
         GYB1RZuBCwmDLMN2YVVy+Ov9UPk0Itj2SRf4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245010; x=1695849810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+kTXKWF/KX1FezcljKFfED0Qa2CUlrf+Ao7Mn6CWqU=;
        b=dPx9TOTgJ7V95w/bhkx/taXNn8njj/QFCuUeQ2PgRf2Vvz1WFpmqEsfkVo1BcX7dKh
         bAHyivA8VvxY8nb9V0pxQGNUP63a16ko0S39JXvNBrgRBUw3eajvpYCoV97g//2SVRGH
         MJfZBSG4EmeP9I01ek+AHQyF6gax5FawIg1EqXFenJJbQ6/feJcmSoz9vj5EsiNiLW8B
         IbjW1/UzIVOkXysTKCjf0r1WURqnNh7AagRqQMWG4ZO8UryCBFhjy/UCl0rG/nm8iZxD
         GcXyMplhaTP1+cK0SNh9OEZ4xE4STpBjZ+BS36IA1X77Br2LM8dWRlb6GnVkHxAfyxGP
         q5Xw==
X-Gm-Message-State: AOJu0Yzj6hVVn6mNlq4H2hKhdira/vWqJcs3iQzyRiDJC73l15kqwlsO
        Jfu9aG5SyRp5BFBoU6DbyGiN5Q==
X-Google-Smtp-Source: AGHT+IHKK0frf2smMGPMVw9UQ7ZkzFuDG6iiZ3tu4xgNQkwCux9hKlN41noej6BF6Bi5CAx1pWRvbA==
X-Received: by 2002:a05:6602:178e:b0:792:8011:22f with SMTP id y14-20020a056602178e00b007928011022fmr4163079iox.0.1695245010355;
        Wed, 20 Sep 2023 14:23:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w9-20020a056638030900b0041fb2506011sm4265481jap.172.2023.09.20.14.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:23:29 -0700 (PDT)
Message-ID: <391f4acc-5e0e-5838-8ed5-bad58d2f5f84@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:23:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/211] 6.5.5-rc1 review
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
References: <20230920112845.859868994@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 6.5.5 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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
