Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59391793078
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjIEU4L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 16:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244045AbjIEU4K (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 16:56:10 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A28B2
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 13:55:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-77dcff76e35so42058939f.1
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693947352; x=1694552152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/BDBNGJ+Ts/N2mHyKONcpknFcVfprrEzRLax22my7E=;
        b=ht58s79nXUjblNHmykHuKLpJbwTVZNpztuLM3zamLVGCZX8x5/QvWyOzK2WuN6Ed0+
         AYnj9MoxlW6Ho4CRCLAlIxy+JVuwHrqEx7LKAH2G+w5425AMyq5XD+dHGfsUwnL0Sn/y
         6kM+u4fCIifJ1Btn+ZcHdZRSZj45GGo58r2G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947352; x=1694552152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/BDBNGJ+Ts/N2mHyKONcpknFcVfprrEzRLax22my7E=;
        b=F1x+sy0lsKgFPPbAFbUqPmHu6a10CraGcpNmaIacn66mx/vaMoAg/SjAp9sUqI5V05
         PY/tUU0dXC4eC8bDD6N9vjlEGn/1fWJnjMFEddF3vXwO/brbkC6CgIEDFW9ob00PJsbh
         fX2lHx3Y32w6E2ZeOH3+9ki9mHQXOdJnDvx9UEgUKPpjVbKSW7T078LrS/zgKZ5hrAA6
         9cMIH92/6TmJBMSP06GxA37ZFwx+owYRqRcnaJUDosHY9q40dXhtrH+kC3F1e5yLeGCi
         yN2HWNrv3JpRcqa+5q7WSLe9324C4WKEoJ4h8rPQ0He8w5Jh6GyHFi0wtZL6HRVCfE+o
         7Hug==
X-Gm-Message-State: AOJu0YwoIT39qijC+NZ2rNkvfBhyxnwsi0keosHJ5JHmQrPbEQEdTPZM
        W719psjBXqZsA2RQwwMuyrxfhw==
X-Google-Smtp-Source: AGHT+IG/gd5v9g5acFnEDrNk2qmxuZ27+UpxRK5gLxlSb+8t1or2tF3kHYKp2opEmEbtB8dWqFPjZw==
X-Received: by 2002:a92:c087:0:b0:345:e438:7381 with SMTP id h7-20020a92c087000000b00345e4387381mr12704337ile.2.1693947352511;
        Tue, 05 Sep 2023 13:55:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c8-20020a92cf08000000b0034bad471d1fsm4404809ilo.3.2023.09.05.13.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:55:52 -0700 (PDT)
Message-ID: <4ea02951-3ee4-65cf-4536-68bc281701c7@linuxfoundation.org>
Date:   Tue, 5 Sep 2023 14:55:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 00/31] 6.1.52-rc1 review
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
References: <20230904182946.999390199@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/4/23 12:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.52 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.52-rc1.gz
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
