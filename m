Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF0776453
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 17:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjHIPrW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 11:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHIPrV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 11:47:21 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8322111
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 08:47:20 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63cf96c37beso5441396d6.0
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691596040; x=1692200840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k4wt+Tzjm2/JyQ83RChxY+eGbVjrYMUKttltS+DOZY=;
        b=k3Rz6yvUT7ntFxHLb/hSIERtPB9hhyi21VZp6EXtyrgOKfRxsAxXLdEuISn+RzxDNX
         kyvIPKbs2FKG3Q3ZcPsx1Wl1fWAQPCmRtcaomqr0HesYAsUOt48KI5mJL8b/lf/uLlh7
         UWh7NLZtGvgcGe7Q+Havpu4D5maHIWWRCbeJml4MA8Nh7xmMZPrXivYfrB4plrvIsfuj
         EwEh8AxsKXbXO9SNEKRdz0meIhmgMOMAWGoVbgNyP70cVfGWkzo7rwcEeDXnS5x5U2mm
         B45e8iBmtwakw8pauBaBWR0iE7wtTPiM9Fxu59SiQ8Iz+Rs0w50RVwmzDXXfAnqTIZVG
         4T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596040; x=1692200840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k4wt+Tzjm2/JyQ83RChxY+eGbVjrYMUKttltS+DOZY=;
        b=TPRJJWFfltQ9TdyeDybMJBPUG28KEwj+3Plrud484KwtPudGGDtyr2G4w336j0YEsY
         j1AS9MDdUGr/x5F1ETQ33HJHoz9nsbUcCQKoft8U2OCcU/LfzoHnh5sxvnsp5wTa+Xwa
         Qusa8FVXRPWlvvJ/kvpL45gzG5NDYBcTLrwQmaCkONV9Gvv4NrslliQ5B1/CAq7sNBjc
         Hsm4G4dtl8rAmQcaZ8heK3EOn03PPEDc9xDHl1iw9mzMLTSz2ATq2y3W0zOJBzEMV1lp
         6yR6eTpj7M7nqj6AYACxQCHJba9PWdJCGqLqhHefB4qfzCjy3hAlokE4/0pj+Ty/R0w5
         FZJQ==
X-Gm-Message-State: AOJu0Yxcj2IXUVcQPx9vrkllL4IJf4xam2yS2h5HCTW71LPrciOX0fle
        MNQVFLxtHig5DHbuRja2N6GJ49bpJMbOJ/90+qLLoA==
X-Google-Smtp-Source: AGHT+IE9aU1PzKqxfr6fYCczrILUc+cTuv62/L2zu3SgjXt3DbjTfppUtt5nPMV63Ag9GHMKNVDrQ5bl5uF5uEB7cws=
X-Received: by 2002:a05:6214:5285:b0:637:2eb:6c23 with SMTP id
 kj5-20020a056214528500b0063702eb6c23mr18312437qvb.18.1691596039898; Wed, 09
 Aug 2023 08:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsdUeNu-gwbs0+T6XHi4hYYk=Y9725-wFhZ7gJMspLDRA@mail.gmail.com>
 <CA+G9fYvDa-u22+gXt7VRWcQkCJFHvt2FPnjFmbwLX0bY__QrLg@mail.gmail.com>
In-Reply-To: <CA+G9fYvDa-u22+gXt7VRWcQkCJFHvt2FPnjFmbwLX0bY__QrLg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Aug 2023 08:47:08 -0700
Message-ID: <CAKwvOdmjAZ9BacrNYHEgGcs=6PExfZkNYe4VWrCwkDCk_pOmyg@mail.gmail.com>
Subject: Re: ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one
 side of the expression must be absolute
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Thanks for the report. We're tracking this here
https://github.com/ClangBuiltLinux/linux/issues/1907
It was pointed out that PeterZ has a series reworking this code entirely:
https://lore.kernel.org/lkml/20230809071218.000335006@infradead.org/

On Tue, Aug 8, 2023 at 11:25=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> also noticed on stable-rc 5.15 and 5.10.

That's troubling if stable is already picking up patches that are
breaking the build!

>
> On Wed, 9 Aug 2023 at 11:40, Naresh Kamboju <naresh.kamboju@linaro.org> w=
rote:
> >
> > While building Linux stable rc 6.1 x86_64 with clang-17 failed due to
> > following warnings / errors.
> >
> > make --silent --keep-going --jobs=3D8
> > O=3D/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=3Dx86_64 SRCARCH=
=3Dx86
> > CROSS_COMPILE=3Dx86_64-linux-gnu- 'HOSTCC=3Dsccache clang' 'CC=3Dsccach=
e
> > clang' LLVM=3D1 LLVM_IAS=3D1
> >
> > arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement:
> > unexpected end of section
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> > the expression must be absolute
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> > the expression must be absolute
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> > the expression must be absolute
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> > the expression must be absolute
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:191: at least one side of
> > the expression must be absolute
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:192: at least one side of
> > the expression must be absolute
> > make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > make[2]: Target '__default' not remade because of errors.
> > make[1]: *** [Makefile:1255: vmlinux] Error 2
> >
> >
> > Build links,
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7Sr=
Tm9Lb4fakgeTfw/
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build=
/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconf=
ig/details/
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build=
/v6.1.44-117-g74848b090997/testrun/18917095/suite/build/test/clang-lkftconf=
ig/history/
> >
> > Steps to reproduce:
> >   tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17
> > --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUg=
ExGs7SrTm9Lb4fakgeTfw/config
> > LLVM=3D1 LLVM_IAS=3D1
> >   https://storage.tuxsuite.com/public/linaro/lkft/builds/2TiTUgExGs7SrT=
m9Lb4fakgeTfw/tuxmake_reproducer.sh
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org



--=20
Thanks,
~Nick Desaulniers
