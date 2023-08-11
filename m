Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845BD7785EF
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjHKDSO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 23:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjHKDSK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 23:18:10 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F1E2D7F
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 20:18:05 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48726442294so636914e0c.0
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 20:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691723884; x=1692328684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NWa1OLkDORI1sFVlYnxo6RPV3TWv31BScuGRKjWt/R4=;
        b=pVNQ7PD9BrEFTfSYVzq/2ZgPsbl2ALglT3PYDymOB7AODtOlUs1WU7GjuA/wGfULSO
         7rTsCnogtjR/dY3u8s/mAOj5SlWvM36IXryiN4daD0SNULGjQv2gn6EDoY0/N/0ZxiGa
         4s6tkhd0sr98EVg/4pZUg5IY9J3SxE1CzGOJeE2aeV7ysnLyc3WKn7nZpxLr+HSAPgDC
         KDzismsv6v5MBwiLGKz3as0t5zID7JZo/bcJq4NWWRSexqUQjMUMW0MNvboVxMUw7zce
         dvPqqW/xRmELqB/9s4IxsNZeavqzspje3rG75qht+krvmdLgrZXMyIvOIfeQnUdadS9i
         MLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691723884; x=1692328684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWa1OLkDORI1sFVlYnxo6RPV3TWv31BScuGRKjWt/R4=;
        b=C387CnPo1ymU27smqh1rE+ZWGCcL2ma6S6ruETEgkyEZHD4nT768qzK+Yv1WKetkaq
         DYn0YW6Vnn8NuqeIajzq0z6xty6DlmjZ26peUn79Ln0PTBnsyCvze0MEY4vbmt7jvxfi
         7f8yUoChtSiSbl6S02wdgB4tER6waCHThLErfMaKYbpTvbZhDLpsinoPavgXNzKYn5EC
         XVPhnjgvRD6xCwDWLQcotOQ172+ZF26V473FoOxGVkKQdToGO3KE/0YqW4LgQaQuWSxD
         cvLwMrh7yu3gUwwSdhWngNwLSpUx8BTsUPiO803v74v7HCNRYM/swEyHbhnoDBubKY96
         j8SQ==
X-Gm-Message-State: AOJu0YyEAb3E6PvMCDew0L/EJdt6yvioXUHUnB/8Jizk+RWW/lVdBMH1
        7xs5JZeqaEBxT8NxvO/paBGqMqdE/G6sN3M3QDyG3aE/tyijvladFAk=
X-Google-Smtp-Source: AGHT+IFz7uTfy59964S+IdElKv3sTs60h9FhAFCrxlWi7+8GZ3QWKcfLauypG3jdBd+GQ4hKBvz4al5R0T+5oPk9Yl8=
X-Received: by 2002:a67:f486:0:b0:444:57aa:571 with SMTP id
 o6-20020a67f486000000b0044457aa0571mr550289vsn.15.1691723884366; Thu, 10 Aug
 2023 20:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsf0jePDO3VPz0pb1sURdefpYCAYH-y+OdsAf3HuzbeRw@mail.gmail.com>
 <202308101328.40620220CB@keescook>
In-Reply-To: <202308101328.40620220CB@keescook>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Aug 2023 08:47:53 +0530
Message-ID: <CA+G9fYugggRyxJFgxRwb0GvgXPerCE928S5vVW7ZnzfTJCRnZA@mail.gmail.com>
Subject: Re: stable-rc: 6.1: gcc-plugins: Reorganize gimple includes for GCC 13
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-hardening@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 11 Aug 2023 at 02:01, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Aug 08, 2023 at 10:57:30AM +0530, Naresh Kamboju wrote:
> > LKFT build plans updated with toolchain gcc-13 and here is the report.
> >
> > Stable rc 6.1 arm64 builds with gcc-13 failed and the bisection is pointing
> > to this as first bad commit,
> >
> > # first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
> >    gcc-plugins: Reorganize gimple includes for GCC 13
> >
> > Thanks Anders for bisecting this problem against Linux 6.2-rc6.
> >
> > Build errors:
> > ---------------
> > In file included from /builds/linux/scripts/gcc-plugins/gcc-common.h:75,
> >                  from /builds/linux/scripts/gcc-plugins/stackleak_plugin.c:30:
> > /usr/lib/gcc-cross/aarch64-linux-gnu/13/plugin/include/gimple-fold.h:72:32:
> > error: use of enum 'gsi_iterator_update' without previous declaration
> >    72 |                           enum gsi_iterator_update,
> >       |                                ^~~~~~~~~~~~~~~~~~
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> I'm slightly confused by this report.

Sorry. I should have provided full details.

> Is it the build of v6.1 that is failing?

Linux-stable-rc linux.6.1.y failing with gcc-13.

> Commit e6a71160cc14 ("gcc-plugins: Reorganize gimple includes
> for GCC 13") was added in v6.2.

This commit is needed.

>
> I think you're saying you need it backported to the v6.1 stable tree?
> ("First bad commit" is really the first good commit?)

First good commit.
We need to backport this patch for linux.6.1.y

Bisect log:
------
# fixed: [6d796c50f84ca79f1722bb131799e5a5710c4700] Linux 6.2-rc6
# unfixed: [2241ab53cbb5cdb08a6b2d4688feb13971058f65] Linux 6.2-rc5
git bisect start '--term-new=fixed' '--term-old=unfixed' 'v6.2-rc6' 'v6.2-rc5'
# unfixed: [9f4d0bd24e6b42555c02e137763f12c106572e63] Merge tag
'linux-kselftest-fixes-6.2-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect unfixed 9f4d0bd24e6b42555c02e137763f12c106572e63
# unfixed: [37d0be6a7d7d6fede952c439f8d8b9d1df5c756f] Merge tag
'gpio-fixes-for-v6.2-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect unfixed 37d0be6a7d7d6fede952c439f8d8b9d1df5c756f
# fixed: [f851453bf19554a42eb480b65436b9500c3cf392] Merge tag
'io_uring-6.2-2023-01-27' of git://git.kernel.dk/linux
git bisect fixed f851453bf19554a42eb480b65436b9500c3cf392
# unfixed: [78020233418518faa72fba11f40e1d53b9e88a2e] bootconfig:
Update MAINTAINERS file to add tree and mailing list
git bisect unfixed 78020233418518faa72fba11f40e1d53b9e88a2e
# unfixed: [e6f2f6ac500c67164f6f6b47299aece579277c14] Merge tag
'i2c-for-6.2-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect unfixed e6f2f6ac500c67164f6f6b47299aece579277c14
# fixed: [be0d8f48ad97f5b775b0af3310343f676dbf318a] bcache: Silence
memcpy() run-time false positive warnings
git bisect fixed be0d8f48ad97f5b775b0af3310343f676dbf318a
# fixed: [e6a71160cc145e18ab45195abf89884112e02dfb] gcc-plugins:
Reorganize gimple includes for GCC 13
git bisect fixed e6a71160cc145e18ab45195abf89884112e02dfb
# unfixed: [4acf1de35f41549e60c3c02a8defa7cb95eabdf2] kunit: memcpy:
Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
git bisect unfixed 4acf1de35f41549e60c3c02a8defa7cb95eabdf2
# first fixed commit: [e6a71160cc145e18ab45195abf89884112e02dfb]
gcc-plugins: Reorganize gimple includes for GCC 13


- Naresh
