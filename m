Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4946FB9B1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjEHV3B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjEHV27 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 17:28:59 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD945B9B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 14:28:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-760f040ecccso32084439f.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683581327; x=1686173327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdHfEQtLtNDQXgK0ROcb2pQ+ZbGp8ywADrDmw5EHPD8=;
        b=BH7x4gf6827DTq+nNDr+4p/4dTFyOqjDVC5nSVY+1km3AnPfWvFFAQHpvdZq1twQOk
         AgP9gLG8IAzJE1pft9Fng790hAEGz/jZ47TYL73eKGRi5J0WwgA7TJf61JYCRQpKnVyJ
         M2t1TdUpm+wjed9SFDCA1uKS9XiQ5VrzB7lJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581327; x=1686173327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdHfEQtLtNDQXgK0ROcb2pQ+ZbGp8ywADrDmw5EHPD8=;
        b=fddku65Veipi1kgBw0Zl7MbII/0NBg8/wbO9GGOgOn9OdrITHHJS76MF7hx89/8iNK
         DQUHu1BPpqjFv/iSg/EZEXcZDPiV/yXpNQxf7WT5x66UIEoMkmcr9uWxL81rtnuJ0exA
         SwAgG/GM6xeeyzcPewqubQjXlJktvH/eS7bqvCFmG8C7nhXbDh/LfrbSDcXQK0VdBUz9
         /9rTwxH6mrw/3/cyEGkwKgipe9lqy9jS5qD0Rath6YfNBfhl1IDM9eLrrMFhQJ1zqIMN
         dGL7fYzXBPo5StTjhlwhMs6ltI/M1dlDzcFL64K2MR4LwpuUgBs+6mfL19qj5/2In/Mz
         tjfg==
X-Gm-Message-State: AC+VfDzoTM9Tls4dZiAP6GYdtbzGpQxSIl35Z2fvne+K0m3R+1VrDqZ5
        TOGoXxpvrzpc43CGx24w99L1Vg==
X-Google-Smtp-Source: ACHHUZ7h17gNHcSuwR609gd5cM+lScBgEdnF7oLgTBriBGKNYl4xiJXFoscS58xF/YfjzMkuutzf0g==
X-Received: by 2002:a05:6602:2c81:b0:763:86b1:6111 with SMTP id i1-20020a0566022c8100b0076386b16111mr8286721iow.2.1683581326840;
        Mon, 08 May 2023 14:28:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y5-20020a6bd805000000b00704608527d1sm2444124iob.37.2023.05.08.14.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 14:28:46 -0700 (PDT)
Message-ID: <23f8bbc9-19db-dc6c-8d59-f0eed757dcc6@linuxfoundation.org>
Date:   Mon, 8 May 2023 15:28:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.2 000/663] 6.2.15-rc1 review
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
References: <20230508094428.384831245@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/8/23 03:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 663 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
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
