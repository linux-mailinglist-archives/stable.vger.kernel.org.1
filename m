Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DF576BE6F
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHAUVp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHAUVo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 16:21:44 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2481BEA
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 13:21:43 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-790af3bfa5cso23040539f.1
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690921303; x=1691526103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWGP9BeLTMzvWlvC1x6kX/MLAb6wyiLuscMm6B5HJhI=;
        b=SB+yJXF9E325EtanROvy4JEKrcCexVyZRSlfTIQt4uPEyotPAqrMDbTf1CTXs7eFBX
         0LH7nn4ogCoZqaTfQ/MmhG162Dij8g1dl/g6YD+AV2lMEWJwsZa2qFj8ZYKrZQqGiIHX
         Or3QGfIj97rQSLIcHuHDDGMo/SkssMt0oF2Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690921303; x=1691526103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWGP9BeLTMzvWlvC1x6kX/MLAb6wyiLuscMm6B5HJhI=;
        b=i3s3fn6wy9/Vafyitq12mOcgXMAgv99LE0+3HFLeR/Q9qqInwFS7LOcBaNTkMlAacm
         piGzgww91fs7lTJjwFxAXN5ZymTSAqtVj/k5dn8oqAFOTN5fW9zxoRwgaOFDKTSmPIAf
         bF+qnFdmElE0DtagC1slZVE3DiZ3ZUMPap7QcRe1xhAYzb7rooz/F30IatBnDLgMMEgz
         g3qgUCxIFvehUFTUlWjcuZEG+hegmdom2PI8ssegx/v89lWN0/LvKhcm0cyhOKCNrJCk
         VpihX5fbOeQBZhr/7HrOC0Qd2RF+DdJCWWw0LV7/dKy9uoA18x32FWkVb9/Et12lavZm
         7R9g==
X-Gm-Message-State: ABy/qLaslDo0wNY8mPrjVIViCFhHEYizcrazhPl9L0k4MJYwlK7Cfs6g
        Eeb0jr+WvcWC4NF5fd66owxKIQ==
X-Google-Smtp-Source: APBJJlEG7CLPzM6d/ScSfm0rELXCLf28lq0W7i3UWqfhg6X2Aa3MIwDj5yD41cSlPkz0Qfy4yqeQ/g==
X-Received: by 2002:a05:6602:2b91:b0:77a:ee79:652 with SMTP id r17-20020a0566022b9100b0077aee790652mr15320953iov.1.1690921303256;
        Tue, 01 Aug 2023 13:21:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s18-20020a02cf32000000b0042916ad15bcsm3823190jar.31.2023.08.01.13.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 13:21:42 -0700 (PDT)
Message-ID: <e3e1b789-329f-9d17-67d9-0ffca1450b96@linuxfoundation.org>
Date:   Tue, 1 Aug 2023 14:21:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 000/155] 5.15.124-rc1 review
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
References: <20230801091910.165050260@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
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

On 8/1/23 03:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc1.gz
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
