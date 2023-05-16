Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AF7042EC
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 03:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEPBcL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 21:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEPBcK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 21:32:10 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC434690
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:32:08 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3357ea1681fso3215735ab.1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684200727; x=1686792727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxAuCAPbFp9ImZfMRV40TuMDQw2xswagc+lrSeMYOZw=;
        b=WtaQSJ8OTZ9/ZK6MoOV91CJMwdT7yRyP8PP1fjRZNWwklcJNHgxsOzhXYuCqLQUSzc
         qCU8ynMIPeSmK9Cqjwvg8aIiizqAwu3jexJCykVSL0WenYDu3eYsz0hDQUKehToa59cL
         vgUgJFqt83Imgc0jiDz//aS5TgVwZrd5qbqQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200727; x=1686792727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxAuCAPbFp9ImZfMRV40TuMDQw2xswagc+lrSeMYOZw=;
        b=AgRbXzNAM7/EfAmZknueVUdziBzcM0Eo+YwIivSZea7pJyb9Hpp7M790my8V8+XsEp
         f/gfX+eLjmei0lKi+62G/d3ow7RPiO/LJIxUjipzoEF0n8hFHToCgDmU4VMgeqvFeTNM
         5eBTUXRdxtK78ZpDZOqixVe+4n6VEefkuQQ+NXk9STB2IKNuPDhXfrf8YPjCO8RAe2o5
         zQ8fVEJhWfgKviCerRTvVL5nEhFfHoP4fVJWfKpK5KNw2IVTQ9vcCLsgWNg7pJsnlwg4
         EJbidenm5LONZbQjBnVy9cusV/9mMoJpW1lDOEEyT5EtvzmYmvqT9V+EvAomYLpwnzY6
         jz0w==
X-Gm-Message-State: AC+VfDwefykfxbL1SjgHJROUhilgZpIwSlPxY8+G3QAx576/panTsAWy
        G/R32GBhhEVvtRMF/ps4IcWwUQ==
X-Google-Smtp-Source: ACHHUZ4e+UJb59KuKDpjrZ4jheJdHLUsGADTus4l4moTjBngVNMYCjuMO7KHnT0PwYt978kaMbyS1Q==
X-Received: by 2002:a05:6602:3806:b0:76c:67bb:11d1 with SMTP id bb6-20020a056602380600b0076c67bb11d1mr986402iob.1.1684200727739;
        Mon, 15 May 2023 18:32:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b23-20020a5d8057000000b00763da065395sm7303195ior.3.2023.05.15.18.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:32:07 -0700 (PDT)
Message-ID: <9d8f2c28-653d-16e7-bdc1-3044ea7cab0a@linuxfoundation.org>
Date:   Mon, 15 May 2023 19:32:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.4 000/282] 5.4.243-rc1 review
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
References: <20230515161722.146344674@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/15/23 10:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.243 release.
> There are 282 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.243-rc1.gz
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


