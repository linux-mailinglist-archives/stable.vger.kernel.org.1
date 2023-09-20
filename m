Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE57A8E86
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 23:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjITVfu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 17:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVfu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 17:35:50 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D8B9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 14:35:43 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7748ca56133so2443939f.0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245743; x=1695850543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnjLBTOoGB3BEH/QsYYxwDhaW5W429+ymNjcE88GaWc=;
        b=COPRiePDb8DjuRMkitqFGY6CwcmrrfJTjW0LuTBHTPfcuRFlMouA4th/bAmZQDFPgf
         WE6Bse0Ugl4C95/f1lcpraTCB/3c4peTcfSaoaaJr6qPoglWbB1vfPaWQzeGQJzZx1Cl
         zJajfM+LbSLDbxuMZ1EHqQPkhO/CQP58CQ8FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245743; x=1695850543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnjLBTOoGB3BEH/QsYYxwDhaW5W429+ymNjcE88GaWc=;
        b=su5fjqUMzn1I0GfEqiFxLYIpJ6V73ve7a98l7N5v27BItXLDqqJzx6A6bHksQZE6mu
         Uk/buiFgRGkLrdXXqQcBEMaiMfv5azTw2p2EfMxZ9nVssJKp0FIzfYNTUxEIGnpIDAuG
         f2dUKAHyxesRxVUJ5XbrL+P1jskXBrOkMx09NQrFZrpRHMUUVVxDYu775lfCp8ozFC2j
         lWe8GOqsjo2Neq4Itx8D7clb7emzG03LhAkfDeNDTqlb6ULToXmVpq/x3Hw1cqAylTVQ
         jOz7qs1AbM76V/QjVZR1oCVAlQOhVTnKz12HCz+0vOua16bEaANqQvox9fO0dfsg1igz
         t8fg==
X-Gm-Message-State: AOJu0YyVOue6b2r/Pmlii0beMGhS1Q9plIHbfNdofedgYCYwa03eKNRl
        E7FYJK9XxxInbNVQ7DGf+UmpWQ==
X-Google-Smtp-Source: AGHT+IFJemHteVc1ljGTNwHf12PlSt6hsHhCIWqr117Co1UpKaEaeNRR+7WriBQWOyoXCTlNDe8TRw==
X-Received: by 2002:a05:6602:4996:b0:79a:c487:2711 with SMTP id eg22-20020a056602499600b0079ac4872711mr4715130iob.0.1695245743114;
        Wed, 20 Sep 2023 14:35:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x15-20020a056638010f00b0043194542229sm4126541jao.52.2023.09.20.14.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:35:42 -0700 (PDT)
Message-ID: <b581fd37-1e31-1d9d-b87e-23e916bc2116@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:35:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
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
References: <20230920112826.634178162@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
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

On 9/20/23 05:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.196 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
