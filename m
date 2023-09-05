Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9744B7930D6
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjIEVQr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 17:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIEVQq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 17:16:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63910B8
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 14:16:43 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34bbc394fa0so2327145ab.1
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693948603; x=1694553403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lN5fpIYRwWULY83XeFrIApl3PJ3oceB+pvimMrfAuCE=;
        b=fWDnDClKbjxZIfM8wBa4YvCaJ+yAjDmnmRreDh8xOheTL2CqwTdMm7/QIPmxVcViln
         ZxfhOGJ8DveHhGSRlSpJsh8CDam+4fKXtfEmNle21d927J7LHN48JOy4zNHD563WsowS
         wNRAXhoQOGpmci/MJ23cXsYx2KcDyOkmGW1CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693948603; x=1694553403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN5fpIYRwWULY83XeFrIApl3PJ3oceB+pvimMrfAuCE=;
        b=Gn2dMORf/gnECqvEKeirBLBPXEyWMXGVyyhuMoJVSPAimN33dbYHkga1Z3VGklG2vY
         VY2RYAp9E2HPvPTn/o9CTyx0PI8tkBZjVYduCullqR5M0XFLNfkU7Z6/aCJxR9EuIQRa
         VADMXYTkExlslLvE/WtY3nuSv4jaxy9C+qc7a0weWRdhKASMVPN9WaeAyH+4vBqSsGVt
         NNQCUKoDKSaRcOcGvtyEWtPM42emLjtqTPQ5t8ull2Sv8tj74jMRWOdWwM7cBzthxXjd
         g0FIN826oAI/RWlP4sUzof6/LeaLhV/gdieBIE9W9rZNg5MTE0faDd3O12g4b3qgXIgU
         9goQ==
X-Gm-Message-State: AOJu0Yya+/iqd9TiLwi/k3Awtgn5GAVk7o2ryON9VhvwMrYgJ2FXCxPq
        8x/XHCvMTIdaxYkgeOnVyx1Kvg==
X-Google-Smtp-Source: AGHT+IHEPY4lFmXX0Ow6iJOiyRNqTd9k5SNtoCEfUz2WO8gHrcXjl+GBxtNwXR+mSJe6ze4lMbh59w==
X-Received: by 2002:a05:6602:4192:b0:792:8011:22f with SMTP id bx18-20020a056602419200b007928011022fmr12640055iob.0.1693948602750;
        Tue, 05 Sep 2023 14:16:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b0042ff466c9bdsm4449092jan.127.2023.09.05.14.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 14:16:42 -0700 (PDT)
Message-ID: <3c819b63-19be-62a6-a3a7-5c4430f7827c@linuxfoundation.org>
Date:   Tue, 5 Sep 2023 15:16:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
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
References: <20230904182945.178705038@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/4/23 12:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.131-rc1.gz
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
