Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46B743428
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 07:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjF3FZe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 01:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF3FZa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 01:25:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F435A0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 22:25:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-543c692db30so1143776a12.3
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 22:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688102725; x=1690694725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzaczCUBTZTvAfZLPO+zN4aCSdU9+F5DHZ/dQrcjWzU=;
        b=gyQqADp/Sx903gGG+OLLNk+axKHxz5gbLh03VL9H3rJuq5frIVmqzynqnNdfUUkSO0
         chWzDJq2lk/NdeF58MtUmYE7rgpSzHA4Ilke0sHlMqPANkrZEudFK0RYm5MfTpP/s4Ga
         zW1HeN0uelHRkHaABPcmIdqJBVT4QvqCgK1/PBqH2yqrko+u3/kb0jmSz/FnArnW0Kqh
         wrFJRW6IeMWEJW/aUiQsaSI9Xxiw3LH/pbgdrhIti3ipTb0RUrDI2ehb/mTLq/y2lpBh
         W4nEVl1stzehvrVw5xWZnqomsyIQkIRFXHzVqK+nmyXlm+P1JPB8V4Y4cT2wxjx49U3H
         ZH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688102725; x=1690694725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzaczCUBTZTvAfZLPO+zN4aCSdU9+F5DHZ/dQrcjWzU=;
        b=eDJDe7gmzfLfp/AGM2mqBjUQwkyvL2JucZLh3S0p5z4PJhZby33bWtQf6w1otYJONV
         betUGoeBqbTuLs8u5KlzUub5XKjk29PpWL4dFPtSigdgsW0besXC0h1CaptC39ASILOJ
         Hxd52+ishd9bP5YJ8ncIU/D6frOYiWVyBwfMuzMzu6CKiHYorFWcSgZ24pW5KDqycGdx
         xbMXDKV+k5gMs37F2RVBYd7nDilK10X4AA+GdH0wF9nglWPMnef2WahS37jRUiPG8tJj
         H6LAkYgT0ue5J3381hGNcrGRx45P9VaLPf6kMe+epvO3yRdYhNEKcnE6w904KFjD+MgA
         7ngg==
X-Gm-Message-State: ABy/qLb1LAhFH57HJMdJv/jUs/monmB912VQBykSmTuAqY4tZRUGle3r
        EpRTnzSkJTPEwZxZjZ8ntlURUS3QxX27YmUrw6YUSw==
X-Google-Smtp-Source: APBJJlEerSM3CUZkODwE5AWzXSKWK4mLESDhEoDSC1FUtMU+f/Z6odp2bCPSDoFODGkGksQKGE17TmrF/h6P0IVn9PA=
X-Received: by 2002:a17:90a:3e0c:b0:262:ea83:ed34 with SMTP id
 j12-20020a17090a3e0c00b00262ea83ed34mr1463410pjc.0.1688102725225; Thu, 29 Jun
 2023 22:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.705870770@linuxfoundation.org> <CAEUSe7__cNqH6d1D96m8XriVckS9MnL6CRfd+iTYXnNkqu9nvQ@mail.gmail.com>
 <2023063037-matrix-urologist-030d@gregkh>
In-Reply-To: <2023063037-matrix-urologist-030d@gregkh>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 29 Jun 2023 23:25:13 -0600
Message-ID: <CAEUSe7-K199dv5_11O877i4pWYtCkaZU2zrsfVo4-QnNPdPQ+A@mail.gmail.com>
Subject: Re: [PATCH 6.3 00/29] 6.3.11-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On Thu, 29 Jun 2023 at 23:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 29, 2023 at 03:54:03PM -0600, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > Early report of failures.
> >
> > Arm64 fails with GCC-11 on the following configurations:
> > * lkftconfig
> > * lkftconfig-64k_page_size
> > * lkftconfig-debug
> > * lkftconfig-debug-kmemleak
> > * lkftconfig-kasan
> > * lkftconfig-kselftest
> > * lkftconfig-kunit
> > * lkftconfig-libgpiod
> > * lkftconfig-perf
> > * lkftconfig-rcutorture
> >
> > lkftconfig is basically defconfig + a few fragments [1]. The suffixes
> > mean that we're enabling a few other kconfigs.
> >
> > Failure:
> > -----8<-----
> > /builds/linux/arch/arm64/mm/fault.c: In function 'do_page_fault':
> > /builds/linux/arch/arm64/mm/fault.c:576:9: error: 'vma' undeclared
> > (first use in this function); did you mean 'vmap'?
> >   576 |         vma =3D lock_mm_and_find_vma(mm, addr, regs);
> >       |         ^~~
> >       |         vmap
> > /builds/linux/arch/arm64/mm/fault.c:576:9: note: each undeclared
> > identifier is reported only once for each function it appears in
> > /builds/linux/arch/arm64/mm/fault.c:579:17: error: label 'done' used
> > but not defined
> >   579 |                 goto done;
> >       |                 ^~~~
> > make[4]: *** [/builds/linux/scripts/Makefile.build:252:
> > arch/arm64/mm/fault.o] Error 1
> > make[4]: Target 'arch/arm64/mm/' not remade because of errors.
> > ----->8-----
>
> Is this also failing in Linus's tree?

(Sorry for the previous top-post.)

No, only here on 6.3.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
