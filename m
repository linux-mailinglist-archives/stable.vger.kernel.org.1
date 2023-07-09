Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9DB74C65A
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGIQEX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGIQEX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 12:04:23 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5BF4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 09:04:22 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579de633419so41993067b3.3
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688918661; x=1691510661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0KuvByoHXqktYCrSIjlqlmfrcAGG/sOVhs4IK75ISs=;
        b=fHzfS+XS7hDxpVUXH1JAWIvnmBSq0QBjlMylToZ/FmCp0WP1/o4SVsbcd56dk6UN2R
         2aFILPrCr+zBVhJGKhmSVQBocxLSdgmLzZ1NNIvQxu6PMPkgxfq7BalTlmt8YtVyC6sl
         bgmHJ8Utq6q6SOqipetr/WCWtbyEu7uueOGDcYKPeoX5M8qSZ8KD8aNIZQl6pnqPhmc9
         ZGMODxxv9a4EeA7bdahl4YsnauWBAWWeIeboLLmzDK5OqJKT2npCkCHaCf+ZkmSsZrep
         OIKK49fynQIgevEnEzf+HnvKPd2uZ1MmbmK7T8tlAKqt8YL2iQaikXYeKYhZJdioHUFj
         MYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688918661; x=1691510661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0KuvByoHXqktYCrSIjlqlmfrcAGG/sOVhs4IK75ISs=;
        b=AXaFxElFOfOi/I8oqScL5tSBb+1SvwlwcGEKFSqPzOfWWWFF/xMdR1Ov3RzdC8YYLk
         mqVBms9y1hel6JBM6KBWGRAiXeyPSN4pAckCJ4ujZ67ShPcsrJMF5e0epJwAmqZjTBIm
         G1faNLPDWKnqamr5HUwNkIj2X3g/DUneWVXV9vgYQIjSUQ8f2Vhb1D2OpsVS1Kptgfn4
         fspsB2wYDE/AWP0k/xy87+3UD9cvR4Omq1gHwV3OnHp/pJoC94jfe8tFCD1eMwMJxN3B
         tf/lGA1ztnDtdQv/CQPbW7EYQvXqrWNy4ISb7Ucm3BsRWR7qI407py0or8qBlOSBTi1E
         DLiQ==
X-Gm-Message-State: ABy/qLaFR4ktP0sUuszJsC7rtc29yruwpiroxBahx4W0OIRohN1cRgzQ
        BBtBcuWnpIvxKyJYG4/79Ump27TjL6RAB6QUyZmOL1n4kFjK57htJ0iPgA==
X-Google-Smtp-Source: APBJJlEG5dgfk0Bp+rosc8yPULNzdLqJl8u/liKJjAw7PkUJ0zBiIb05b27NpeqMvxl/PVGgg7ZxJUv/bO7xDcDcFok=
X-Received: by 2002:a81:8353:0:b0:56d:325c:442 with SMTP id
 t80-20020a818353000000b0056d325c0442mr8553914ywf.31.1688918660952; Sun, 09
 Jul 2023 09:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230709111345.297026264@linuxfoundation.org> <20230709111345.516444847@linuxfoundation.org>
 <c783f635-f839-638c-5e32-ef923be432ad@leemhuis.info> <2023070904-customer-concise-e6fe@gregkh>
In-Reply-To: <2023070904-customer-concise-e6fe@gregkh>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 9 Jul 2023 09:04:09 -0700
Message-ID: <CAJuCfpFfc7tvv9CPMx=1b=X-1foiDZ+0bXkVUsFekWB_zNUnLw@mail.gmail.com>
Subject: Re: [PATCH 6.4 7/8] fork: lock VMAs of the parent process when forking
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        David Hildenbrand <david@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Sun, Jul 9, 2023 at 6:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 09, 2023 at 02:39:00PM +0200, Thorsten Leemhuis wrote:
> > On 09.07.23 13:14, Greg Kroah-Hartman wrote:
> > > From: Suren Baghdasaryan <surenb@google.com>
> > >
> > > commit 2b4f3b4987b56365b981f44a7e843efa5b6619b9 upstream.
> > >
> > > Patch series "Avoid memory corruption caused by per-VMA locks", v4.
> > >
> > > A memory corruption was reported in [1] with bisection pointing to th=
e
> > > patch [2] enabling per-VMA locks for x86.  Based on the reproducer
> > > provided in [1] we suspect this is caused by the lack of VMA locking =
while
> > > forking a child process.
> > > [...]
> >
> > Question from someone that is neither a C nor a git expert -- and thus
> > might say something totally stupid below (and thus maybe should not hav=
e
> > sent this mail at all).
> >
> > But I have to wonder: is adding this patch to stable necessary given
> > patch 8/8?
> >
> > FWIW, this change looks like this:
> >
> > > ---
> > >  kernel/fork.c |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -662,6 +662,12 @@ static __latent_entropy int dup_mmap(str
> > >             retval =3D -EINTR;
> > >             goto fail_uprobe_end;
> > >     }
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +   /* Disallow any page faults before calling flush_cache_dup_mm */
> > > +   for_each_vma(old_vmi, mpnt)
> > > +           vma_start_write(mpnt);
> > > +   vma_iter_set(&old_vmi, 0);
> > > +#endif
> > >     flush_cache_dup_mm(oldmm);
> > >     uprobe_dup_mmap(oldmm, mm);
> > >     /*
> >
> > But when I look at kernel/fork.c in mainline I can't see this bit. I
> > also only see Linus' change (e.g. patch 8/8 in this series) when I look=
 at
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/=
kernel/fork.c
>
> Look at 946c6b59c56d ("Merge tag 'mm-hotfixes-stable-2023-07-08-10-43'
> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
>
> Where Linus manually dropped those #ifdefs.
>
> Hm, I'll leave them for now in 6.4.y as that is "safer", but if Suren
> feels comfortable, I'll gladly take a patch from him to drop them in the
> 6.4.y tree as well.

Hi Greg,
Give me a couple hours to get back to my computer. Linus took a
different version of this patch and changed the description quite a
bit. Once I'm home I can send you the patchset that was merged into
his tree. Also let me know if you want to disable CONFIG_PER_VMA_LOCK
in the stable branch (the patch called "[PATCH 6.4 1/8] mm: disable
CONFIG_PER_VMA_LOCK until its fixed" which Linus did not take AFAIKT).
Thanks,
Suren.

>
> thanks,
>
> greg k-h
