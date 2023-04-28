Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC256F1A63
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 16:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjD1OTF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 10:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345960AbjD1OSr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 10:18:47 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294034C12
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:18:46 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f0a2f8216fso1011431cf.0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682691525; x=1685283525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu6CluFUTtRnaBZwnaoLdbpyoIqPOJ+pqKyFgwstymY=;
        b=P5QH0dNvCLo3EWV8aUGUFmksU1VOrkjgdd/VV//mkR1PthZgpTwmF7r0UOPuzXPHLk
         07Mv1pwUM+I58m5AjocItsDof3SeHKLr4xc/Wy+rfZoZLIlRYOBU870dG1csLLeZGh6X
         NgtBs2iCV/UKJNu5ugqe1x6M5xjXwwVcsAGorYcAcXOzVgMuVufs7gquSYn6HnbMCinW
         WR4mHkW/UluGimOpSn3CuINIsWYQrlqd5YTITYLqd5w7lyQAXwkMMRNjXP0p8Q3+psHy
         E4GAHeYv18kcf4kcChPurQYJgWO5DNfSv1zNyifFf3WoMFh7ZS2Cl6ejU20AZwUJLagI
         tnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682691525; x=1685283525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pu6CluFUTtRnaBZwnaoLdbpyoIqPOJ+pqKyFgwstymY=;
        b=br3mRe14pO3So4qA82hQ4nE2OekqEQsYukQVRUTPvgvkk4wHIZ3CE0DYpBvEVZk9iQ
         IAB08Ja3TnRR4IZNIaqPdY/mN9Ef9308m6sshwNyf0TgDJhzXNZmCyCDMxccGglZ8V5Q
         eIM/Sbn8PBk8QFcmzBVGBVrG1BRjU6TVAa9qSA7eKMG2y8c5e4X4ZlVe+spDMZQYq+NK
         kUrft4jyG1q5ImGoCoFUMB9zSZ9RblTOMnAlyUjTp3LLWVKNnRw0kOOjjRrJRRnlQamn
         +Kyz0JBBdoHxWR3XazkItcXjNR+L0YboU/b7dWKlw3lSSWt+bqb5QS0p1ajuv/MMvKC5
         ZI0A==
X-Gm-Message-State: AC+VfDwcdjkdIqrB4ErfRvusyjjtaiaft+fUosDvjKVcmCi+0UbGGcdd
        poqDuvU3HiojozsxGKMlTvCFnl+Aizmijw7rbwmYkQ==
X-Google-Smtp-Source: ACHHUZ49wHROlihc67ea87HWUY2lpy74jY8EBGyNtVyCuBdDYGtAo6EokbOa0lcx0p1UDycSrkffEhHajNhJgHckI10=
X-Received: by 2002:a05:622a:1ba3:b0:3ef:330c:8f9e with SMTP id
 bp35-20020a05622a1ba300b003ef330c8f9emr396343qtb.10.1682691525255; Fri, 28
 Apr 2023 07:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230420210945.2313627-1-pcc@google.com> <ZEKAZZLeqY/Vvu+z@arm.com>
 <CAMn1gO7Kf39nTjrggPmk+biUa9A7sQ7JG8ZNfeH5yQzmQA=+rw@mail.gmail.com>
In-Reply-To: <CAMn1gO7Kf39nTjrggPmk+biUa9A7sQ7JG8ZNfeH5yQzmQA=+rw@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 28 Apr 2023 07:18:34 -0700
Message-ID: <CAMn1gO4n=d_cCjq851oy0G6r_sog6_aQsmPJ0hJTBeE5r40LqA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Also reset KASAN tag if page is not PG_mte_tagged
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     andreyknvl@gmail.com,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        =?UTF-8?B?R3Vhbmd5ZSBZYW5nICjmnajlhYnkuJop?= 
        <guangye.yang@mediatek.com>, linux-mm@kvack.org,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>, kasan-dev@googlegroups.com,
        ryabinin.a.a@gmail.com, linux-arm-kernel@lists.infradead.org,
        vincenzo.frascino@arm.com, will@kernel.org, eugenis@google.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Apr 21, 2023 at 10:20=E2=80=AFAM Peter Collingbourne <pcc@google.co=
m> wrote:
>
> On Fri, Apr 21, 2023 at 5:24=E2=80=AFAM Catalin Marinas <catalin.marinas@=
arm.com> wrote:
> >
> > On Thu, Apr 20, 2023 at 02:09:45PM -0700, Peter Collingbourne wrote:
> > > Consider the following sequence of events:
> > >
> > > 1) A page in a PROT_READ|PROT_WRITE VMA is faulted.
> > > 2) Page migration allocates a page with the KASAN allocator,
> > >    causing it to receive a non-match-all tag, and uses it
> > >    to replace the page faulted in 1.
> > > 3) The program uses mprotect() to enable PROT_MTE on the page faulted=
 in 1.
> >
> > Ah, so there is no race here, it's simply because the page allocation
> > for migration has a non-match-all kasan tag in page->flags.
> >
> > How do we handle the non-migration case with mprotect()? IIRC
> > post_alloc_hook() always resets the page->flags since
> > GFP_HIGHUSER_MOVABLE has the __GFP_SKIP_KASAN_UNPOISON flag.
>
> Yes, that's how it normally works.
>
> > > As a result of step 3, we are left with a non-match-all tag for a pag=
e
> > > with tags accessible to userspace, which can lead to the same kind of
> > > tag check faults that commit e74a68468062 ("arm64: Reset KASAN tag in
> > > copy_highpage with HW tags only") intended to fix.
> > >
> > > The general invariant that we have for pages in a VMA with VM_MTE_ALL=
OWED
> > > is that they cannot have a non-match-all tag. As a result of step 2, =
the
> > > invariant is broken. This means that the fix in the referenced commit
> > > was incomplete and we also need to reset the tag for pages without
> > > PG_mte_tagged.
> > >
> > > Fixes: e5b8d9218951 ("arm64: mte: reset the page tag in page->flags")
> >
> > This commit was reverted in 20794545c146 (arm64: kasan: Revert "arm64:
> > mte: reset the page tag in page->flags"). It looks a bit strange to fix
> > it up.
>
> It does seem strange but I think it is correct because that is when
> the bug (resetting tag only if PG_mte_tagged) was introduced. The
> revert preserved the bug because it did not account for the migration
> case, which means that it didn't account for migration+mprotect
> either.
>
> > > diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> > > index 4aadcfb01754..a7bb20055ce0 100644
> > > --- a/arch/arm64/mm/copypage.c
> > > +++ b/arch/arm64/mm/copypage.c
> > > @@ -21,9 +21,10 @@ void copy_highpage(struct page *to, struct page *f=
rom)
> > >
> > >       copy_page(kto, kfrom);
> > >
> > > +     if (kasan_hw_tags_enabled())
> > > +             page_kasan_tag_reset(to);
> > > +
> > >       if (system_supports_mte() && page_mte_tagged(from)) {
> > > -             if (kasan_hw_tags_enabled())
> > > -                     page_kasan_tag_reset(to);
> >
> > This should work but can we not do this at allocation time like we do
> > for the source page and remove any page_kasan_tag_reset() here
> > altogether?
>
> That would be difficult because of the number of different ways that
> the page can be allocated. That's why we also decided to reset it here
> in commit e74a68468062.

Ping.

Peter
