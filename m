Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8257852A7
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjHWI0G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 04:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjHWIV5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 04:21:57 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174726A9
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 01:17:52 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-79ddb7fae73so1365473241.3
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692778671; x=1693383471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqe7mkEGHT7NgyOQeDLsG/n1Ckgqsp5wMv1XT9TA+F0=;
        b=hXhyKxRAa/XqLCTxuoqAArYlj9eqorGXCeup5cOmCN9mkKInNpCyyi8s9jF4kKRgHq
         FaZOyNg3gNOdj2ioyF+sv8XvT/Fnr53rI3SYlqnHBOgMxe79HPLV5lAXW0FNkAbGrRoS
         zY2qhPEayqE2RlGeFgxLI2KwuTkI3zoGCUuLKWPWxH95mvyOOQOV7INPOW3Q/NI9PSQF
         5eVEJ35yBMg+9nrPS4AbQvoIKUxl7QvSirKvzztNEIFwdPNxfqTdIeigsn+G9uZ/yFbB
         B5DS83W8cBn4mq8mjwbov6SPwvUQqh4LtUOZH1GO9aq+QiwpuBOaHlC376MacfVOp9Bb
         5emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778671; x=1693383471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nqe7mkEGHT7NgyOQeDLsG/n1Ckgqsp5wMv1XT9TA+F0=;
        b=EJiGYOtk+Z1uljY80Z5DG2+BiroHba8prdheuuvT6fLBGFEQg+Jc0H4lbHuVRjK0P9
         4Y9ouKwKPPnHUG0gNjTLNviKihPHLHfGxgcxxUrwvpiUpHPCDVNey9MEtVDqh2mhqCzs
         Evvgchu8J2PHXhK2ExTCRdAhEyVpFi2Y7/ZXLINZMkHh4ZiBPpeIWb/xfyc+b1BOYa0r
         cdk9Cx8tZKZJc+5siO4IzcRrHwNUUZyhFvp7VZi731KcNr6hikiRWvCnX80vYJvwl17w
         LKKccvSwaFDcjC4EE17xJhuEo6jY+AdkRf7+1vzU3rwpNV4iuBXoWOrCQqVyCwvzBjjZ
         ovSQ==
X-Gm-Message-State: AOJu0Yz+F3n8RnwKd+/Zd1Wj5ROLCDntuL6UaSFsS/KnXJ6oi0/1ST0V
        cmD2r+MEkpX12+4l+jDelZ0nWoaPmGP3RK5E+0Xu5Q==
X-Google-Smtp-Source: AGHT+IHSgU62Q6R+8iOJxv7mKFz8zOjUZr5Tp7B2zIBJp9mM3XkHYJsE5kmt1bfZn81x6p3V6xFkkvMxAmVTWuEkcTs=
X-Received: by 2002:a67:fd0f:0:b0:44a:c20a:ebb1 with SMTP id
 f15-20020a67fd0f000000b0044ac20aebb1mr6941151vsr.13.1692778671115; Wed, 23
 Aug 2023 01:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194122.695845670@linuxfoundation.org> <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
 <2023082309-veggie-unwoven-a7df@gregkh>
In-Reply-To: <2023082309-veggie-unwoven-a7df@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 23 Aug 2023 13:47:39 +0530
Message-ID: <CA+G9fYvwxuVpSn24YvtdNXaofg2JtZDREatOpDsKTVJX+nFN3Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 23 Aug 2023 at 12:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 22, 2023 at 05:49:54PM -0700, Guenter Roeck wrote:
> > On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.47 release.
> > > There are 194 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > Anything received after that time might be too late.
> > >
> >
> > Build results:
> >       total: 157 pass: 156 fail: 1
> > Failed builds:
> >       m68k:sun3_defconfig
> > Qemu test results:
> >       total: 521 pass: 519 fail: 2
> > Failed tests:
> >       arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:f2fs
> >       arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:f2fs
> >
> > The m68k build failure is
> >
> > Inconsistent kallsyms data
> > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> >
> > I already have KALLSYMS_EXTRA_PASS=1 enabled, so that doesn't help.
> > Nothing to worry about. The f2fs crashes are still seen. They
> > also happen for other architectures, so it is not just an arm problem.
> > I'll probably just disable all f2fs testing going forward. If so I'll
> > send a note clarifying that the lack of reported test failures doesn't
> > mean that it works.
>
> I'll look into this later this week, next week to resolve the f2fs
> stuff.  I wanted to get to the other known bug fixes first.
>
> > For x86 I get the same runtime warning as everyone else.
>
> Yeah, this is troubling...
>
> Is it clang only?  I'll dig into this today...

It is seen with gcc-13 and clang-17 with few extra configs.
We are not booting defconfig.

The Kconfigs are enabled with KFENCE.

I see this from lore
"
This is from overnight testing that hit this only in the KCSAN runs.
The KASAN and non-debug runs had no trouble.

Thanx, Paul

"

steps to reproduce:
-------------------
tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-13
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2UJAv99Wwi6YMltFjlQD5XRO5x4/config


Here is the links to details and build details,
[1]
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.46-195-g5165f4e9738c/testrun/19256276/suite/log-parser-boot/test/check-kernel-exception/details/

[2]
https://storage.tuxsuite.com/public/linaro/lkft/builds/2UJAv99Wwi6YMltFjlQD5XRO5x4/

[3]
https://storage.tuxsuite.com/public/linaro/lkft/builds/2UJAv99Wwi6YMltFjlQD5XRO5x4/config

- Naresh


>
> thanks,
>
> greg k-h
