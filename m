Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053077E2B79
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 18:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjKFRxM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 12:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjKFRxL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 12:53:11 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D22D4C
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 09:53:08 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b3f6dd612cso2852785b6e.3
        for <stable@vger.kernel.org>; Mon, 06 Nov 2023 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699293188; x=1699897988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WROodUma+YX9D9t3U/MSNsWH+qYxH1P9vdKfkt+6QQ=;
        b=PobQ5QTDnCm8vGzRfT7VWsT4fmRpH2RYfqsgxlMzmWsPPSB4I/2xhetA1bvmDtIkru
         0nRJU8gIWBOHD0ziYBprWME7Df0Aer0nVpXw73TJ8hv2PjjK+ezNRHsEFr5TuYdGioNO
         2Fmg5s2XnGBzzLMC+NeNtu4O6D01EHQOAb6xPjl/p29xi0HNle/EqUBFyu51VmkFXrbc
         RQ63OwTlVTyhSgu7mBlYvu4pNPN3HGnAzxSh9fyPwEXA5+zu7ttyFg81lbZqlEPNOPfX
         caHgr262Sc6/nax2GZwlIzclTWV5ZwFVpwN0v7hN4uGTCHlsd+Z53nexL++a/4zFd89A
         L9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293188; x=1699897988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WROodUma+YX9D9t3U/MSNsWH+qYxH1P9vdKfkt+6QQ=;
        b=nOEXD2p5u1+D65vN7wb3b/3oKjii7xxzY0PQ+dIEB0FXIo3bF2DEDJpBtWRzKhBESw
         Kj95FfC8U0VnCnx5ndzAxiIbwg4QSzo1hBsUHiMMETrwsWxU61fE8fco8n2EiaetmLjc
         ma67TzfYvOmsGrli352gfxsJjYWpzSjdvd3kddWG/ohSI58kRS3iodaIvsvO21Q8wyk3
         /J5GDagvZKoMnSUBy62qfWSycWl+rPk2pKLeHHmRsqRfjJS4P4tgBWgPYwah4GTX//V5
         KCea5cnyfIKyfYcnKMZ0z2xoYb8qMlYDW6oroaLZZ+u0mkWZ1zdo9NImVExPZVSXIdXn
         z8Mw==
X-Gm-Message-State: AOJu0YzeD/3sQ+fiW8NBL8O8SEDnjonl6XLWlKqe7xJhKQqEGN9t8aRu
        +K6wtBVv/f4JgCT+OVIJV0KNTA==
X-Google-Smtp-Source: AGHT+IEL8z1Tr9lAONkY54ORSL5BRqixdea0A8W3dB2QXLDSm17ZTbZxHici7Eg4mDMAISCQAjNb8Q==
X-Received: by 2002:a54:4407:0:b0:3ab:38b0:8b84 with SMTP id k7-20020a544407000000b003ab38b08b84mr31465404oiw.17.1699293187829;
        Mon, 06 Nov 2023 09:53:07 -0800 (PST)
Received: from [192.168.17.16] ([138.84.54.223])
        by smtp.gmail.com with ESMTPSA id 11-20020aca100b000000b003b2e4b72a75sm1302246oiq.52.2023.11.06.09.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:53:07 -0800 (PST)
Message-ID: <8aec1bd5-befc-486c-9e47-7571b937b8c7@linaro.org>
Date:   Mon, 6 Nov 2023 11:53:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231106130304.678610325@linuxfoundation.org>
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On 06/11/23 7:03 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

There seems to be a problem building for RISC-V with GCC 8, 12, and Clang 17. This is with defconfig, allnoconfig, tinyconfig:

-----8<-----
/builds/linux/drivers/irqchip/irq-riscv-intc.c: In function 'riscv_intc_init':
/builds/linux/drivers/irqchip/irq-riscv-intc.c:119:17: error: implicit declaration of function 'fwnode_dev_initialized'; did you mean 'zone_is_initialized'? [-Werror=implicit-function-declaration]
   119 |                 fwnode_dev_initialized(of_fwnode_handle(node), true);
       |                 ^~~~~~~~~~~~~~~~~~~~~~
       |                 zone_is_initialized
cc1: some warnings being treated as errors
make[3]: *** [/builds/linux/scripts/Makefile.build:286: drivers/irqchip/irq-riscv-intc.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/builds/linux/scripts/Makefile.build:503: drivers/irqchip] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1832: drivers] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:192: __sub-make] Error 2
make: Target '__all' not remade because of errors.
----->8-----

Currently bisecting.

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

