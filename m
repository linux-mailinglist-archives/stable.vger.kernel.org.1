Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0AB773B3C
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 17:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjHHPqt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjHHPpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 11:45:13 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542ED3AA5
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 08:40:40 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d44c2ca78ceso5768008276.0
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691509143; x=1692113943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxRMXJiuQK91+yRpddjAZKkzZLy1vbif8oXNnv4g/Ag=;
        b=1AxLWrBHfHHLunr9ZrHlQ0Mc/HOxaol2K7H6w4SVm9k/WXa979CfNiskScnjukt5Vy
         L6ZeU9SALjiVhS+d6xx/cqZUnhKiDCde/ISrlXSXfceE+koVzbruYAgBPpwcJ9Woc4LC
         /X82J/oUEk8Vv+0UbY/dA9apDYN4z6vD96iaZj5kkO5vNsrbnXbI9pvlnfRTUmdv8r0B
         Keii5mB2tDGraMDeccGPCpbm85QXl6OI+YurPc0frlI0lpfFNltmx2tKo58xFUGRQOWa
         lhG/al3psDZ4xNzpctYNQi3ooZFp6rGWOxFZx6thXcRgb+c/uV6FhWxvutzoAWiMm0eK
         kB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509143; x=1692113943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxRMXJiuQK91+yRpddjAZKkzZLy1vbif8oXNnv4g/Ag=;
        b=Cv4q6UNN6cTfTr4WN4Fh6455VA7rmmRr2Fn1vV9vu0QZwwA85ARgbs16693KAzibWc
         gSV/tJsUv0BYUS0tl2f3BuubYxrqYg/wdQ3vvmvuEzfqBsOoTsCfwG9nHeyzn1cEm+Zd
         aUTIfzORuT+nkvL4or/031iJdv12X99Y4YwSo0CaA1riccjXGKBIZPQ0nMz2EDBqYcIn
         r+VpQytLTH2RqaGGMlneKjLajV8/inkrUxFv9zUwjM3wgFFS3Lgycfzr211EE/2WeP4l
         RaEm73x5jPT6IbIYHfJ7sQGMnawWHtygnluX60O99ZWjygQSOgcfyxAVd2dAyrcK+7P7
         7VtQ==
X-Gm-Message-State: AOJu0YyJCk9MJiL9T+FkrRG43jZXvf9cUgazfdI8J6jyRtK2Xu15wps2
        a/UYlsR6UOEumgKHGlGdjtwZVAHNE1daevmxq9BrlzrJiEcZcqbPtG8=
X-Google-Smtp-Source: AGHT+IGzx0RFgswgLrJMymfJnb2FD9jwg77jDF19tcueBiV97W9Lx+X3sLD3o5vXHt2lMPaogA6T3mfELdxFD7EAdOI=
X-Received: by 2002:a0c:b20c:0:b0:625:aa49:ea0d with SMTP id
 x12-20020a0cb20c000000b00625aa49ea0dmr192621qvd.32.1691508641145; Tue, 08 Aug
 2023 08:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvPn4N6yPEQauHLXw22AWihQFxyA=twQMDCEwDjXZyYAg@mail.gmail.com>
 <ZNIdrd+SQ0KjYWKA@e120937-lin>
In-Reply-To: <ZNIdrd+SQ0KjYWKA@e120937-lin>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Aug 2023 08:30:30 -0700
Message-ID: <CAKwvOdmoPUJXT3-+nwYdOBOpcp30zvxapDmvYAt+_wUQj98O8A@mail.gmail.com>
Subject: Re: stable-rc 5.15: clang-17: drivers/firmware/arm_scmi/smc.c:39:6:
 error: duplicate member 'irq'
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 8, 2023 at 3:49=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> On Tue, Aug 08, 2023 at 11:59:22AM +0530, Naresh Kamboju wrote:
> > LKFT build plans upgraded to clang-17 and found this failure,
> >
> > While building stable-rc 5.15 arm with clang-17 failed with below
> > warnings and errors.
> >
> > Build log:
> > ----------
> >
> > drivers/firmware/arm_scmi/smc.c:39:6: error: duplicate member 'irq'
> >    39 |         int irq;
> >       |             ^
> > drivers/firmware/arm_scmi/smc.c:34:6: note: previous declaration is her=
e
> >    34 |         int irq;
> >       |             ^
> > drivers/firmware/arm_scmi/smc.c:118:20: error: use of undeclared
> > identifier 'irq'
> >   118 |                 scmi_info->irq =3D irq;
> >       |                                  ^
> > 2 errors generated.
> >
> >   Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Links:
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/buil=
d/v5.15.124-80-g6a5dd0772845/testrun/18864721/suite/build/test/clang-lkftco=
nfig/log
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/buil=
d/v5.15.124-80-g6a5dd0772845/testrun/18864721/suite/build/test/clang-lkftco=
nfig/details/
> >
>
> Hi Naresh and Sasha,
>
> so this fix (unluckily) applies cleanly to v5.15 but fails to build since=
 the
> logic and code around it was different in v5.15.
>
> While looking at backporting it properly, though, I realized that the fix=
 is
> NOT needed really in v5.15 due to the different context and logic, so I a=
sk you
> to DROP this fix in v5.15.

What's the SHA of the patch that you are referring to (in
linux-5.15.y) that you're suggesting the stable maintainers revert?

>
> I suppose the patch has been automatically applied because the Fixes refe=
rred
> a commit that was on v5.15 too since some of those lines were indeed impa=
cted
> and were present also in later versions, but the logic around it has
> changed afterwards, so the original code (up to v5.17) was not really aff=
ected
> by the bug addressed by this fix...only later versions from v5.18 (includ=
ed)
> onwards needs it.
>
> Moreover note that the whole SMC ISR logic was introduced in v5.12 (and w=
as
> good up to v5.17 as said) so v5.15 is really the only stable release that=
 needs
> to drop this fix.
>
> Thanks and sorry for the noise,
> Cristian
>
> >
> > Steps to reproduce:
> >  tuxmake --runtime podman --target-arch arm --toolchain clang-17
> > --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2TeTE3=
iE8aq4t1kv169LcMmd9jo/config
> > LLVM=3D1 LLVM_IAS=3D1
> >
> >   Links:
> >     - https://storage.tuxsuite.com/public/linaro/lkft/builds/2TeTE3iE8a=
q4t1kv169LcMmd9jo/tuxmake_reproducer.sh
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
>


--=20
Thanks,
~Nick Desaulniers
