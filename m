Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD11737667
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 23:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFTVG3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjFTVG2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 17:06:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F56D1727
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 14:06:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760dff4b701so69415239f.0
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687295187; x=1689887187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7FX3ei7WxljWiN/f0vRH44gl13P4MQNxcfvKkmN450=;
        b=hl+HSCKh1jjpj7EVjSOdcH3FNkKmXDISO0FSTWbCfn4dpCn6jnkbHh//C2uON2Et5D
         bPxxfDz+QhWnCzonzREEGrUcI0MQG/k7AvYIhIeEfxy0JMZ+SAucDo0v2uaoJfwaNlif
         F3nj8ixRR5xYdwLITnF0ubkugPDIVaAZ+RUD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295187; x=1689887187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7FX3ei7WxljWiN/f0vRH44gl13P4MQNxcfvKkmN450=;
        b=YCvty3JPRVd9kY7KCRd2QQA5SBlwF15wnf+UcjegFnlU4FDo2qeN+OAfDUsiQfVV1H
         0Lt9ffCq8jtyFxJiRtjOsO+HHme6Q7VtxOTnuuQPRlngDPRwyn1N0aLpJw4/Qs4Vtqhr
         maTgCSmkpJU89BCJLzk7hApxGFvHY3UO0GoxHFm8abzG6qe8s5vRI2U/LmqDr1Opmhec
         A2JPFR9Pq80xNEtp1+FPb2m8L2iwC9vfSFaFNKl2kYt/1JRaIUMVqlzhBFF9yukrEkOJ
         8q1O1yOURz+jtnzkbDcQAycsXQPNhpU0ngv4eZis+YbF5yAyDtMume9rJXcoNDO+wTyE
         8jGA==
X-Gm-Message-State: AC+VfDz7N4iUIA5Z6Jt4adgDscjfzMqgSkBBgdtLoSmNGqQydjz67mBf
        rl6ogKhQ7Oia3F/7xGUISt3wcg==
X-Google-Smtp-Source: ACHHUZ5ub/upUVXfagLIdSXqCeAq1WjOIQyGj28Ycc/XO8AfL1PFN4uT/IAL+nW4ERq301c21CELVA==
X-Received: by 2002:a05:6e02:ee6:b0:343:ce12:d51 with SMTP id j6-20020a056e020ee600b00343ce120d51mr1182393ilk.2.1687295186938;
        Tue, 20 Jun 2023 14:06:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k24-20020a02cb58000000b0041ab9b6f5b0sm880647jap.128.2023.06.20.14.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:06:26 -0700 (PDT)
Message-ID: <ccc8f0d2-d397-21b1-80bc-fe1002f7179c@linuxfoundation.org>
Date:   Tue, 20 Jun 2023 15:06:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.4 00/64] 5.4.248-rc1 review
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
References: <20230619102132.808972458@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
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

On 6/19/23 04:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.248 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.248-rc1.gz
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
