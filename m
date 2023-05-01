Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810426F3885
	for <lists+stable@lfdr.de>; Mon,  1 May 2023 21:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjEATzV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEATzT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 15:55:19 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34BA2107
        for <stable@vger.kernel.org>; Mon,  1 May 2023 12:55:17 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-559f1819c5dso30970297b3.0
        for <stable@vger.kernel.org>; Mon, 01 May 2023 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682970917; x=1685562917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6/Qwr73DpjqVyRdRECBbxXjLLTahq/uJGnivC6mAq8=;
        b=nOGV79JHEufvcYn2AKhdk79/ViXSWov22Cy33zWA1Gtst+eCDvoVa3OWWz5HNIcCII
         UZejZi5Uegh9PTt5hwbCSATYVQ0siN0O+UgoBQWNisA50H9K9bZk9Wrc9Z0OQeeEfA/+
         +yThvmo2Fno7BKwBTkUAF3LbTzoNv7/LwN0wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970917; x=1685562917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6/Qwr73DpjqVyRdRECBbxXjLLTahq/uJGnivC6mAq8=;
        b=arV54IN9tyk5XqEJejzzw3Acd8CEQ8H8o17PTW0a66maB2OoxbOgXh3BXpCf8H3kU/
         plRnJc/xPDecyJ73t8rge2UoGdCuzIXr3I944nBD6Mxoc13NNbAw3wk2zPLYUsuVk/DY
         9nMAO1nzATxOVtnM3Clme7cJMvXPZK14sk7F8YmKbuY67dqjW8lYf8tm0Y+9bSxlI1Pg
         e8Vt6hmhL8wx6qqahuRfghm+XuMvlzkdqEpIaf7Ij1i9mHMCvvUWB8cOWTxcLelkuGUw
         NtWPMqXTGT1f8jqkxdbCNmzo0eJtYEpZTpLaSSfEMpTyq/D4MuinX9wF+ShND+xJTyRf
         W4kw==
X-Gm-Message-State: AC+VfDz69U+ERORbuExvYZbClPh+tfgssnCqnUg4PJw8AqzDrYYrI+t7
        BssVnc90VSn23BvwDJ4NrawMWSbA+UOb7jqTt8w0Ww==
X-Google-Smtp-Source: ACHHUZ5Micsge5qcUkvACeh5qZkv599FhCeGkBYRYQhhbxuGHuyNnb0MS4tz8zmYPzwW51tDOt02Yw==
X-Received: by 2002:a0d:d853:0:b0:555:d12a:b5fa with SMTP id a80-20020a0dd853000000b00555d12ab5famr13747603ywe.5.1682970916877;
        Mon, 01 May 2023 12:55:16 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id d144-20020a814f96000000b00559f1cb8444sm1568657ywb.70.2023.05.01.12.55.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 12:55:16 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso7568276.3
        for <stable@vger.kernel.org>; Mon, 01 May 2023 12:55:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:a28a:b0:e6:f7e8:1e4d with SMTP id
 a10-20020a056a20a28a00b000e6f7e81e4dmr13625249pzl.33.1682970895325; Mon, 01
 May 2023 12:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org>
 <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org> <20230501-cottage-overjoyed-1aeb9d72d309@spud>
In-Reply-To: <20230501-cottage-overjoyed-1aeb9d72d309@spud>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 1 May 2023 21:54:43 +0200
X-Gmail-Original-Message-ID: <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
Message-ID: <CANiDSCufbm80g4AqukpiuER17OXhD-yRNmTZRz7s_x-Xi9BDCw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To:     Conor Dooley <conor@kernel.org>
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
        Simon Horman <horms@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Conor

On Mon, 1 May 2023 at 19:41, Conor Dooley <conor@kernel.org> wrote:
>
> Hey Ricardo,
>
> On Mon, May 01, 2023 at 02:38:22PM +0200, Ricardo Ribalda wrote:
> > If PGO is enabled, the purgatory ends up with multiple .text sections.
> > This is not supported by kexec and crashes the system.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  arch/riscv/purgatory/Makefile | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> > index 5730797a6b40..cf3a44121a90 100644
> > --- a/arch/riscv/purgatory/Makefile
> > +++ b/arch/riscv/purgatory/Makefile
> > @@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
> >  CFLAGS_string.o := -D__DISABLE_EXPORTS
> >  CFLAGS_ctype.o := -D__DISABLE_EXPORTS
> >
> > +# When profile optimization is enabled, llvm emits two different overlapping
> > +# text sections, which is not supported by kexec. Remove profile optimization
> > +# flags.
> > +KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
>
> With the caveat of not being au fait with the workings of either PGO or
> of purgatory, how come you modify KBUILD_CFLAGS here rather than the
> purgatory specific PURGATORY_CFLAGS that are used later in the file?

Definitely, not a Makefile expert here, but when I tried this:

@@ -35,6 +40,7 @@ PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding
-fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
+PURGATORY_CFLAGS := $(filter-out -fprofile-sample-use=%
-fprofile-use=%,$(KBUILD_CFLAGS))

It did not work.

Fixes: bde971a83bbf ("KVM: arm64: nvhe: Fix build with profile optimization")

does this approach, so this is what I tried and worked.

Thanks!
>
> Cheers,
> Conor.
>
> > +
> >  # When linking purgatory.ro with -r unresolved symbols are not checked,
> >  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> >  PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
> >
> > --
> > 2.40.1.495.gc816e09b53d-goog
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Ricardo Ribalda
