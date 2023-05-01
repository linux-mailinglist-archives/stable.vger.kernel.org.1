Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB86F34F8
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjEARTO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjEARTL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 13:19:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4D1BFE
        for <stable@vger.kernel.org>; Mon,  1 May 2023 10:18:46 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f8af6dfa9so47939937b3.2
        for <stable@vger.kernel.org>; Mon, 01 May 2023 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682961525; x=1685553525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDAy0yw2Hl6Xad3kepfPR0FriSjDMaQH5Y0jnLgi2V4=;
        b=oDAyKLSdxWeDf2Rr539YuGPN8WIpEGf8MZUyaYq5jr+2u5r+cTYAw2jASoneiiCznU
         2SvyyFMMDnvtDUHjWd0FR1VXwxNkJF1Db2fr3bNgMpEqVPMJ7oTUtw4hQgx3+k8EZndj
         FscTv8obyqztv1iAv4Pz/neD2LiCUt46YSdAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961525; x=1685553525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDAy0yw2Hl6Xad3kepfPR0FriSjDMaQH5Y0jnLgi2V4=;
        b=TqKrZ5I8SknAuxTZFyxBPQJxjGwaoSTYxHHpFAiHxvRM2achYhC0zxLNWBA6y/m/7b
         kCZHijdMiMv4GGq5Vb7sMQyCYb7jWxXHPMXj7boCkv1YzwMhPmQsQLAcMKi4UF4Lrnyw
         MyVWiaG+3QsKaRJaZr8DO9X5TBGT47BMU2tbHf5jvIusxjqTHmd6xCkHYrDFlzjllqNI
         sYsXDSndvUiaHN/s3sQyVEqoSa7lGPwZhSSUp0jhvVD3AKVPz0XhM9jL/jMXlIa7D2zZ
         t64/qlnStGq46U1f7VKCe7rCbYVe8QNSlC3KRhbSL6gf7aPbx2HzOIu1N4JGxnVoifsJ
         mBsA==
X-Gm-Message-State: AC+VfDybL/jq6xJx/XKnZ7h+S3vrZfgo8eLKsuJEYUubvv+dmXw9v7bl
        DJrHDUolM0aJKcUGCBHTimeg+gxovM+sOuqJNgSCUA==
X-Google-Smtp-Source: ACHHUZ6jiNQzT3m8qKoCVNerhJZZANlDVOdtY+7iTegHhebqnO93Fj7yfWdJkj50+AKmCK5S5rECGA==
X-Received: by 2002:a0d:d8cf:0:b0:55a:64f0:366 with SMTP id a198-20020a0dd8cf000000b0055a64f00366mr2790698ywe.7.1682961525150;
        Mon, 01 May 2023 10:18:45 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id k63-20020a0dc842000000b00555ca01b112sm2187833ywd.105.2023.05.01.10.18.44
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:18:44 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so1353095276.3
        for <stable@vger.kernel.org>; Mon, 01 May 2023 10:18:44 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:1a8:1c9a:f68 with SMTP id
 h15-20020a170902f70f00b001a81c9a0f68mr17818554plo.36.1682961504069; Mon, 01
 May 2023 10:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org> <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
In-Reply-To: <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 1 May 2023 19:18:12 +0200
X-Gmail-Original-Message-ID: <CANiDSCtDfPffUQTuH3JiPWC+87FBtpog7kT954PSoiTbB_fmJQ@mail.gmail.com>
Message-ID: <CANiDSCtDfPffUQTuH3JiPWC+87FBtpog7kT954PSoiTbB_fmJQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>, llvm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Nick

Thanks for catching this. It should have said

risc/purgatory: Remove profile optimization flags

Will fix it on my local branch in case there is a next version of the
series. Otherwise, please the maintainer fix the subject.

Thanks!

On Mon, 1 May 2023 at 18:19, Nick Desaulniers <ndesaulniers@google.com> wro=
te:
>
> On Mon, May 1, 2023 at 5:39=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.=
org> wrote:
> >
> > If PGO is enabled, the purgatory ends up with multiple .text sections.
> > This is not supported by kexec and crashes the system.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_purago=
ry")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Hi Ricardo,
> Thanks for the series.  Does this patch 4/4 need a new online commit
> description? It's not adding a linker script (maybe an earlier version
> was).
>
> > ---
> >  arch/riscv/purgatory/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makef=
ile
> > index 5730797a6b40..cf3a44121a90 100644
> > --- a/arch/riscv/purgatory/Makefile
> > +++ b/arch/riscv/purgatory/Makefile
> > @@ -35,6 +35,11 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
> >  CFLAGS_string.o :=3D -D__DISABLE_EXPORTS
> >  CFLAGS_ctype.o :=3D -D__DISABLE_EXPORTS
> >
> > +# When profile optimization is enabled, llvm emits two different overl=
apping
> > +# text sections, which is not supported by kexec. Remove profile optim=
ization
> > +# flags.
> > +KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D% -fprofile-use=
=3D%,$(KBUILD_CFLAGS))
> > +
> >  # When linking purgatory.ro with -r unresolved symbols are not checked=
,
> >  # also link a purgatory.chk binary without -r to check for unresolved =
symbols.
> >  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
> >
> > --
> > 2.40.1.495.gc816e09b53d-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Ricardo Ribalda
