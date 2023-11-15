Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D521A7ED627
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjKOViv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKOViu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:38:50 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B615B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:38:47 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c4884521f6so110064b3a.0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700084327; x=1700689127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viq9qvmJ3LM7HHbpPLpRFQxdnfMhe+VmNzi8uiGAz9o=;
        b=PSimt4LY1wWQIX3H7isGsOIl/SesLfbXmqLnUhZ3SO5LzLNxSvSS89xmfOZhEwShY+
         +/IY0lHA7cxuLl1WeFFuKMviMvHVxd63NSOaZ8HgHsa5WUAiSC6PLrwt2i7ZFKhN+ja5
         nZE+brp2Lb+eFqHlixNbPwNh9X3BQ+5/DP1gnJ6CB4N7GC6cte4Gab4hbsyATWEOryfI
         PNaKd5Jg92Z0hyiINvtArPapXVw6LGb0+S5He076fKu4au1hkQroeRrB1A2Rp1denqoJ
         tAVEdgRw1cwM2rP/Y8aXQl7XvsRlo6isq6xilXZDHyzk6bdUW5IdRLM7rg80eFiB4cRU
         G1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700084327; x=1700689127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viq9qvmJ3LM7HHbpPLpRFQxdnfMhe+VmNzi8uiGAz9o=;
        b=R0yGkDzi5WfaeNyuedXMZbvGNa9iO3saCBZy5UQVX476QWuETkNxTlyFuIlW2jvH3b
         ZqHnq40fC4TOx8gW7HCuunaUXmALuLvhn/EfD2RecreKLQknJfg6QX/09IdFQbI5KzS6
         ybOY1jWXkrN2MPOtaCCrZ48G3DUpTaQS5ahNTBrq4qJXlnjbV381UkCkTV7zrzZIbnNh
         oBaQSV2x+8rBRI6ex4idS6NIvCRtPLaaUSzxxlX+ThamuGAjvbNbEfqgMp2d7b1jcZp+
         TjQnlHTFbx7xvy8cJTzMyCk3UFuL6W4CVp2shjAO1VVKQ8ePky7hjF8IA6Z9m7Rx1OWi
         y93Q==
X-Gm-Message-State: AOJu0Ywfq6IKgZtH/Cjyy6YDj/DTFCKUboxFP+Tem+4hsZD8OORVYWyD
        rClZF1blb/ZK+WvDPZ1cx+a6Jqy1/es2zDudMMYviA==
X-Google-Smtp-Source: AGHT+IGsT1CibUn6Ia99KLaPjPtxI5AQqKcH5XAZwaf3OwLZ4vdydJ8RnA0NKLZ+rMU0rAcfhpGprFwG1SHgmX5tAe4=
X-Received: by 2002:a05:6a00:1394:b0:6c6:1648:5ac6 with SMTP id
 t20-20020a056a00139400b006c616485ac6mr14670509pfg.5.1700084326699; Wed, 15
 Nov 2023 13:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20231115191600.708733204@linuxfoundation.org>
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 15 Nov 2023 15:38:35 -0600
Message-ID: <CAEUSe7_KQ_-Q2ADLVcuKjb9vGOpkgAEgzgq5o-Hf=7a7c9NLXw@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/550] 6.5.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On Wed, 15 Nov 2023 at 13:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.5.12 release.
> There are 550 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.5.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

We're seeing build regressions on Arm, Arm64, i386, x86, with KUnit
defconfigs (and multi_v5_defconfig on Arm32):
-----8<-----
  In file included from /builds/linux/lib/kunit/executor.c:225:
  /builds/linux/lib/kunit/executor_test.c: In function 'free_suite_set':
  /builds/linux/lib/kunit/executor_test.c:130:30: error: invalid use
of undefined type 'struct kunit_suite_set'
    130 |         kunit_free_suite_set(*(struct kunit_suite_set *)suite_set=
);
        |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /builds/linux/lib/kunit/executor_test.c: In function 'free_suite_set_at_e=
nd':
  /builds/linux/lib/kunit/executor_test.c:141:49: error: invalid use
of undefined type 'struct kunit_suite_set'
    141 |         if (!((struct kunit_suite_set *)to_free)->start)
        |                                                 ^~
  /builds/linux/lib/kunit/executor_test.c:144:31: error: invalid
application of 'sizeof' to incomplete type 'struct kunit_suite_set'
    144 |         free =3D kzalloc(sizeof(struct kunit_suite_set), GFP_KERN=
EL);
        |                               ^~~~~~
  /builds/linux/lib/kunit/executor_test.c:145:17: error: invalid use
of undefined type 'struct kunit_suite_set'
    145 |         *free =3D *(struct kunit_suite_set *)to_free;
        |                 ^
  /builds/linux/lib/kunit/executor_test.c:145:15: error: invalid use
of undefined type 'struct kunit_suite_set'
    145 |         *free =3D *(struct kunit_suite_set *)to_free;
        |               ^
  make[5]: *** [/builds/linux/scripts/Makefile.build:243:
lib/kunit/executor.o] Error 1
----->8-----

This is with defconfig, CONFIG_KASAN=3Dy, CONFIG_KUNIT=3Dy, and
CONFIG_KUNIT_ALL_TESTS=3Dy. To reproduce,

tuxmake \
  --runtime podman \
  --target-arch arm64 \
  --toolchain gcc-13 \
  --kconfig defconfig \
  --kconfig-add CONFIG_KASAN=3Dy \
  --kconfig-add CONFIG_KUNIT=3Dy \
  --kconfig-add CONFIG_KUNIT_ALL_TESTS=3Dy

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Bisection is on-going.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
