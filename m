Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D0D755F8C
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGQJll (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 05:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjGQJlW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 05:41:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ADD1992
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 02:40:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so89285e9.0
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689586831; x=1692178831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIgEdFgE+Ee/Plepe1RFgHeUv1XxEmWrc70tprVwr20=;
        b=WfXsyKTWiJFQeD1ne9fKmkEfM5JmpG51YuRGDw642Rz+Hlduv2pouGkb+HNkparMJb
         r/BYmvZP3KwFmfaNSnn8AW366UJfdbPQbxUPHgpiupR7HeIv/Ta7up/WX0R2GyaTPUhM
         I8ZaXOhHHzl6SkbIvZcIyv5QiAUkq7LABW+4KdFRPPspywX/BIe1IsYEg2uYSu6HfbJv
         ecFp6CdLvVtL8r4YUwd+EzX/2PopG5lMbckT4VQ7sot9+78B1FWQG9w68IOUv9mvUJPF
         YFRKzs8zM1iH1bfp8qhkj9QmHmGVyTAaeD0Kpe9HmRdcb2pxYpoprQibqP3IYke+etLf
         +8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586831; x=1692178831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIgEdFgE+Ee/Plepe1RFgHeUv1XxEmWrc70tprVwr20=;
        b=jy9cMLPRXqsijJkru20LF7YSFeRfesagBL/VDiOd7Dl1aYVY4vUtSwYytffTQ7eB59
         aCs5pcVVhcvKlMuReFcdezYTY1N9nsx7JXvGLKoPkRGF/764QEhf9GsAy07OP4ADXY+Z
         ZYrRUt/MbNX9lLmRptrTfWnZVbxoJlhUDSa93G9iOADFed3FJq9tWdp700a0qetRzbOG
         1BJKevVzqPmtsj9sgUGERDyXMi+6ZlhR3zUxIIqLilpvH8T7GcXFps8sCPHHpunRSWe8
         LLBnkBgf+QNrY2lXRCL0wDj3qLyIvMnRAkjl30Yy+U5K1dvr6SrmzBopyVb1V8vJM/q7
         cv1g==
X-Gm-Message-State: ABy/qLYZHfBhUzbNsE2c1T/Kes6UR9+CI44aypXzoYd7/EWv7bss6t8r
        GkCX1CMMBKid7flaC1BMjYnTD7sayxbL3HtSafJ9QA==
X-Google-Smtp-Source: APBJJlEE+vHJIyY+89IqyN2JE2fuCFTi7F/qZtnJkoZ90nz+/CdcYTA7GOHdyEcXNV//NtfhhVTp+ZsIZbrYZDUkjDo=
X-Received: by 2002:a05:600c:1d8b:b0:3f7:3654:8d3 with SMTP id
 p11-20020a05600c1d8b00b003f7365408d3mr514591wms.2.1689586831018; Mon, 17 Jul
 2023 02:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <202307170435.p9l0j6zC-lkp@intel.com> <CAG48ez0mT5KYe1=Bd0YHXvaM8a5OF_5OJOnF7jO1nmMteDvZMg@mail.gmail.com>
In-Reply-To: <CAG48ez0mT5KYe1=Bd0YHXvaM8a5OF_5OJOnF7jO1nmMteDvZMg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 17 Jul 2023 11:39:54 +0200
Message-ID: <CAG48ez3P+4C9+px_eVOBM2PTcY700h26f3qJ-o4MOCxHw=dUbA@mail.gmail.com>
Subject: Re: [stable:linux-4.14.y 4549/9999] drivers/android/binder.c:3355:
 Error: unrecognized keyword/register name `l.lwz ?ap,4(r20)'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        stable <stable@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[resending to correct openrisc list]

On Mon, Jul 17, 2023 at 11:37=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> On Sun, Jul 16, 2023 at 10:20=E2=80=AFPM kernel test robot <lkp@intel.com=
> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git linux-4.14.y
> > head:   60a6e3043cc8b918c989707a5eba5fd6830a08a4
> > commit: f40f289b96bf856e1613f17bf9426140e8b89393 [4549/9999] binder: Pr=
event context manager from incrementing ref 0
> > config: openrisc-randconfig-r002-20230717 (https://download.01.org/0day=
-ci/archive/20230717/202307170435.p9l0j6zC-lkp@intel.com/config)
> > compiler: or1k-linux-gcc (GCC) 12.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230717/2023071704=
35.p9l0j6zC-lkp@intel.com/reproduce)
> [...]
> >    drivers/android/binder.c: Assembler messages:
> > >> drivers/android/binder.c:3355: Error: unrecognized keyword/register =
name `l.lwz ?ap,4(r20)'
> >    drivers/android/binder.c:3360: Error: unrecognized keyword/register =
name `l.addi ?ap,r0,0'
> >    drivers/android/binder.c:3427: Error: unrecognized keyword/register =
name `l.lwz ?ap,4(r20)'
> >    drivers/android/binder.c:3432: Error: unrecognized keyword/register =
name `l.addi ?ap,r0,0'
> > >> drivers/android/binder.c:3555: Error: unrecognized keyword/register =
name `l.lwz ?ap,4(r21)'
> >    drivers/android/binder.c:3560: Error: unrecognized keyword/register =
name `l.addi ?ap,r0,0'
>
> Probably same issue as
> https://lore.kernel.org/oe-kbuild-all/202010160523.r8yMbvrW-lkp@intel.com=
/
> ? That thread says the fix is
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/arch/openrisc?h=3Dv5.9&id=3Dd877322bc1adcab9850732275670409e8bcca4c4
> , and it was then backported to 5.4 (as
> a6db3aab9c408e1b788c43f9fb179382f5793ea2) and 5.8.
