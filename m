Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9EC76BE49
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 22:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjHAUIp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 16:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHAUIo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 16:08:44 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51406268C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 13:08:43 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id ca18e2360f4ac-77dcff76e35so73439139f.1
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690920522; x=1691525322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJWk/08ykvlArnbaiiPJv/MrXaekrWWFTI2d28oOw9A=;
        b=L/5ovkUyagKpcZSUhKykWeslxFnBh4iKCZVzSU0dUt7GoF7wnshiMY21AYc75rmLn5
         X080x8ndHe9JgHpM/Y76jyS0bIYKDWoXpcwwMUlSyP2+vYDWHxgcIkB3qaOpNsNR2Ktt
         rsBKIIXELrmYU5PSeiR2LBcLKPF76jGpH3pQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690920522; x=1691525322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJWk/08ykvlArnbaiiPJv/MrXaekrWWFTI2d28oOw9A=;
        b=Is1UuXfhW5kNzSDWUxW+pyrTrA6yT6IbTISeiMFnXP+p8+KfXMO2e/CM6R6G+tLK0R
         RVlWv8ZV5HNE6yYpaNgYWnygHSa5seX70mYWVBb+4e25Jx8p7JMzCCBq1ly9V6h+5kT1
         RslvD8yRTBNuQ17ULbKTKLHxqO4zAma4zeevxT7EMCNFhBWOQ0P0FS7zAfNMb+01FMjJ
         mpkDnd5oeu2CZa3B0NyVoofGdko5g59kH2BdCAzlIYoP5rMVo2lHcBffv4/OfMq3BDgO
         GZNQq1A880wZoRoo1y+cWNlS2s3SZBGS2maXSrLDQkn7GzCC+ycAUBFlwc87hbsmsOqR
         WIZQ==
X-Gm-Message-State: ABy/qLbS8XVxfIvyhn1pwbyiG5qOIcdKnskShZouVdqPIYF6oTzy7Mca
        +Vfh0I/BqrCMS4ghz/KtJP5vxA==
X-Google-Smtp-Source: APBJJlEpDqBHD3fGrxb6cgw5TGR2+VWOGlEw24TNEFcPIC9wdrhEWZd1+XxYkF0V0kQF2DSOVUoq8Q==
X-Received: by 2002:a92:cd05:0:b0:345:e438:7381 with SMTP id z5-20020a92cd05000000b00345e4387381mr10710318iln.2.1690920522676;
        Tue, 01 Aug 2023 13:08:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s7-20020a92cb07000000b003487840f1d3sm4030572ilo.50.2023.08.01.13.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 13:08:42 -0700 (PDT)
Message-ID: <6b7b32b3-3c52-23ec-3c93-984170a42ba3@linuxfoundation.org>
Date:   Tue, 1 Aug 2023 14:08:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/228] 6.1.43-rc1 review
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
References: <20230801091922.799813980@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/1/23 03:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc1.gz
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
