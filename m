Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5F72D450
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 00:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbjFLWU6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjFLWU5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 18:20:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06477131
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 15:20:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-65c6881df05so1143871b3a.1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686608455; x=1689200455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOwPkRnj0a3PFj3/ABjurFLJ13yHy4X6H2letubj6Tc=;
        b=FVb62amnTOscjxGHR7Xsf1KyYoJz2Cnz07bNZuJ4beo/wYwVzIxJPERqFBwSlJ+uJ3
         fBn1/nyspXNTg0uRY4YFX0o6aOLCd6MphUUMJjr1Q/JJZ6IdDoc1z83ir6IDx+AIF6sZ
         +R2ia5+3YFAJyNEQimIRkS0DuM/1JOI/Z+J2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686608455; x=1689200455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOwPkRnj0a3PFj3/ABjurFLJ13yHy4X6H2letubj6Tc=;
        b=fDuhFXsVJG7u2PCesT7AJJBvTC2BYVa3ytx/2jUY7l5cswRuaj2YjAtEN2SDDEpbw9
         qiktNMBWG5n9dBbShZW9mFMjbLaYC9y1+v+XTvdQyEiAwdZPbvKDwgdxlxAzBcZ9rKH3
         xqhp8+r67Z51VOgHzuy/2yvFpk4Kw4ME96q3vKCBbh4cL84gCFMiA1TbGcX9Mf7AvjM6
         inNl+7LvYBAAnmsquoKyk+oWuVx7Mo8k0j8JOD0Pd9VPLjYPvShRGIsnxAHV2bGzEf2v
         Zcn/Y462LbENJU21nZ5GfgTN5lSumQpJWGVQrkJaGJW9utlr90T4ml9e7OHOhPdE5+Pb
         p2ng==
X-Gm-Message-State: AC+VfDwEUgHi2Bkg42gZYBcOzWcG2zX2Uzashgn+2KUWRsl52C6SszJH
        lGIjPhh4jKVR5/zZb/HvUUjmZXRo1uHVwenIoQo=
X-Google-Smtp-Source: ACHHUZ5UBuCT8z71f85BHAqgRU97eprvZncKWLSUCI66wSvka/j4eyECqcmtyi/Kfr1Jj20JLOTdnQ==
X-Received: by 2002:a05:6a20:7da6:b0:11b:3e33:d2f7 with SMTP id v38-20020a056a207da600b0011b3e33d2f7mr4007558pzj.0.1686608455480;
        Mon, 12 Jun 2023 15:20:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f27-20020a02cadb000000b00416789bfd70sm3054788jap.1.2023.06.12.15.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:20:55 -0700 (PDT)
Message-ID: <225a4834-fc8f-21c0-fea6-9a7bad29d2fa@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 16:20:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.4 00/45] 5.4.247-rc1 review
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
References: <20230612101654.644983109@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/12/23 04:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.247 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.247-rc1.gz
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
