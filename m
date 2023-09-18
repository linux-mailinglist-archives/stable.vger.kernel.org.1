Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6817A55B8
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 00:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjIRWYc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRWYb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 18:24:31 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5CDA3
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 15:24:22 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79d27df62f1so15673539f.0
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695075862; x=1695680662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9RqMXMvzJ54l6rW1/jkG7Qf45IJeJi55QA1eHCfUXCU=;
        b=anWLB3D9/vqtCZpcbEbx2wATTrK0QLsi2uM3WaCpxVNCOGAw6b/0PAD8y25PeOV4qp
         6P4PaVGiP78iJmEiKmtrmm+eI+BxIpcFwQTyxLi3pXsD2ru4Wi2VAg1wxg488v5lXYvd
         QilqXLVBBKjNWZGYaZgvK2z4hmEXjSFMF4n0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695075862; x=1695680662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RqMXMvzJ54l6rW1/jkG7Qf45IJeJi55QA1eHCfUXCU=;
        b=eZxOY/pc3iPk/p0aKgfhZlA4CvzFwxRmgr6rRYyd9wVj1TPjMoKHZNBnhsFvBaj9KR
         PyE0VCQV+fmMRPZc/TRNhwp1sZfH3S+QoXEvwwCKLFI0mhqj4S5Xc+8Zygq/lK8pAn67
         89+sApzW/IV7uc0dBsaaOYnEwU72eHqHLhUkTIgKOmA3hb6cPEHYguFRJajTZFb6K7eu
         DHlkDaQzFxKeb80zZqEI6p3bPdpE9XciWBECup5H7wAnAJL4jHgv482rWbGnfWYSnxz5
         LdMYYAIZftCcxUav6uYKpM4iZWA2QFYS8bvovrRM9Iw9eTqdDBUu4Zr79ZQhuC3283eY
         dIAg==
X-Gm-Message-State: AOJu0YxF4Ghw30nCyg6IR8vyJ78qMOv3txhsxXfRLH0VE7tXc8qQAlTZ
        mC9IxB5gBhuH4sGrO9VF9dWxow==
X-Google-Smtp-Source: AGHT+IEmtCaZtQgtls59oQZpAxJpiYXqY4y86H3T39IG52afnMK42cZB9aR/M3OM9LrWBKmola8Z9A==
X-Received: by 2002:a05:6602:1681:b0:792:6068:dcc8 with SMTP id s1-20020a056602168100b007926068dcc8mr14432162iow.2.1695075862083;
        Mon, 18 Sep 2023 15:24:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h23-20020a056638063700b00437a3c128dfsm3133587jar.108.2023.09.18.15.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:24:21 -0700 (PDT)
Message-ID: <5b3db5fa-0bc6-f455-cf08-c5495cfe434f@linuxfoundation.org>
Date:   Mon, 18 Sep 2023 16:24:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
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
References: <20230917191113.831992765@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/17/23 13:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.132-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
