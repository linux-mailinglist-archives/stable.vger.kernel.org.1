Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8291E74C817
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 22:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGIUYo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 16:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGIUYn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 16:24:43 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52294100
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 13:24:42 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57a6df91b1eso18922217b3.1
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688934281; x=1691526281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uW0GWUqDhej8YE4TmXrO6nZoyzCK9m/mkLpbzfSkm0=;
        b=C7TLvJb5eek/bFD8tWekWDzO8kWzxPTUqdyl2JRxogo/vwl5m1K6gxsF/oPvL65JHh
         b+AxIo3B1nvtJKnEG3og06c7Q0t06Jy7NHnGq/ONanfkQxsMH0KJmwkNmCfeKvJKmxV6
         Y3G72597srppDaP3Pyel7SFtM6FHK6yBrITwYHlStw4MSjLNNyU+77AT3etPw1hzx8W3
         ePqORZ+4HGjt5J5Vn3uR1dmplBnC5ci2Fa0bqcu86fOPEogkMa5qmX7XfKmTrxTM3t4x
         4+mVe7IDSnHMk+EwbVzZvyp/eKNQ6mNCwAnGcY54OrOuEA0qiUsuGutfunTz7UQltevM
         xyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688934281; x=1691526281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uW0GWUqDhej8YE4TmXrO6nZoyzCK9m/mkLpbzfSkm0=;
        b=YzcW7MWcVsYY1pnfTtUao3e/zRqTZTI0chfkjWFdmAPlkr4U+cU2C8Gcd0uVKWN2s6
         avKJPPDrfuc89zsUnsVy7tWPPU8W0rVXeU9FlKZ2eMCEfDkla+Zh6rPvhUlkU1Dg4A6t
         5mp+8bs3bVdpZjN3Q7B9useU/WIi8EOmMQ7ylC/UR51Xnlvp7Fp8NqKdF1QgGiKodhqo
         5l1nIgLtBopFqYDURwEI6e0JhfACg9Iu+Q/6U9/rq5zNU4jS6fsluDaBobUcpTtK3S+6
         dgY5B5rfb8UfWrYLdmroTOH30RzN7VED2pFe4uL7PZECI5EdmcfdCasR8VqtSeWrMm7Y
         pQkA==
X-Gm-Message-State: ABy/qLb9+fY24bR06QEp3Z86dOSWHHsZWL6272/zSpH68aY9YB7NObFC
        1qmaHkBV0vjSolpiuZSsw4qxH/1Z/v5FLkIgc17nww==
X-Google-Smtp-Source: APBJJlE/KK0VDsMccmZgZCoSgIpk9mNTNLMm3rkqLdlyNGL7ZD08rC5ujIn6RaLaMPdPYbulBBuutalqp4eYy9r5QVE=
X-Received: by 2002:a0d:e645:0:b0:57a:6df7:5ccd with SMTP id
 p66-20020a0de645000000b0057a6df75ccdmr4965342ywe.13.1688934281057; Sun, 09
 Jul 2023 13:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230709111345.297026264@linuxfoundation.org> <20230709111345.516444847@linuxfoundation.org>
 <c783f635-f839-638c-5e32-ef923be432ad@leemhuis.info> <2023070904-customer-concise-e6fe@gregkh>
 <CAJuCfpFfc7tvv9CPMx=1b=X-1foiDZ+0bXkVUsFekWB_zNUnLw@mail.gmail.com>
 <2023070931-conjuror-dweeb-bb4b@gregkh> <CAJuCfpHgq_2sZVw7Vv9TuNgBHLO_9f_KAmQ73kFY+093GdMfRg@mail.gmail.com>
In-Reply-To: <CAJuCfpHgq_2sZVw7Vv9TuNgBHLO_9f_KAmQ73kFY+093GdMfRg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 9 Jul 2023 20:24:29 +0000
Message-ID: <CAJuCfpGjXWYzUFdje=ZvTxFmTR5NoXAhXO4y5ZEEsFAihbZpYg@mail.gmail.com>
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

On Sun, Jul 9, 2023 at 7:53=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Sun, Jul 9, 2023 at 7:48=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jul 09, 2023 at 09:04:09AM -0700, Suren Baghdasaryan wrote:
> > > On Sun, Jul 9, 2023 at 6:32=E2=80=AFAM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sun, Jul 09, 2023 at 02:39:00PM +0200, Thorsten Leemhuis wrote:
> > > > > On 09.07.23 13:14, Greg Kroah-Hartman wrote:
> > > > > > From: Suren Baghdasaryan <surenb@google.com>
> > > > > >
> > > > > > commit 2b4f3b4987b56365b981f44a7e843efa5b6619b9 upstream.
> > > > > >
> > > > > > Patch series "Avoid memory corruption caused by per-VMA locks",=
 v4.
> > > > > >
> > > > > > A memory corruption was reported in [1] with bisection pointing=
 to the
> > > > > > patch [2] enabling per-VMA locks for x86.  Based on the reprodu=
cer
> > > > > > provided in [1] we suspect this is caused by the lack of VMA lo=
cking while
> > > > > > forking a child process.
> > > > > > [...]
> > > > >
> > > > > Question from someone that is neither a C nor a git expert -- and=
 thus
> > > > > might say something totally stupid below (and thus maybe should n=
ot have
> > > > > sent this mail at all).
> > > > >
> > > > > But I have to wonder: is adding this patch to stable necessary gi=
ven
> > > > > patch 8/8?
> > > > >
> > > > > FWIW, this change looks like this:
> > > > >
> > > > > > ---
> > > > > >  kernel/fork.c |    6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > >
> > > > > > --- a/kernel/fork.c
> > > > > > +++ b/kernel/fork.c
> > > > > > @@ -662,6 +662,12 @@ static __latent_entropy int dup_mmap(str
> > > > > >             retval =3D -EINTR;
> > > > > >             goto fail_uprobe_end;
> > > > > >     }
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +   /* Disallow any page faults before calling flush_cache_dup_=
mm */
> > > > > > +   for_each_vma(old_vmi, mpnt)
> > > > > > +           vma_start_write(mpnt);
> > > > > > +   vma_iter_set(&old_vmi, 0);
> > > > > > +#endif
> > > > > >     flush_cache_dup_mm(oldmm);
> > > > > >     uprobe_dup_mmap(oldmm, mm);
> > > > > >     /*
> > > > >
> > > > > But when I look at kernel/fork.c in mainline I can't see this bit=
. I
> > > > > also only see Linus' change (e.g. patch 8/8 in this series) when =
I look at
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/log/kernel/fork.c
> > > >
> > > > Look at 946c6b59c56d ("Merge tag 'mm-hotfixes-stable-2023-07-08-10-=
43'
> > > > of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
> > > >
> > > > Where Linus manually dropped those #ifdefs.
> > > >
> > > > Hm, I'll leave them for now in 6.4.y as that is "safer", but if Sur=
en
> > > > feels comfortable, I'll gladly take a patch from him to drop them i=
n the
> > > > 6.4.y tree as well.
> > >
> > > Hi Greg,
> > > Give me a couple hours to get back to my computer. Linus took a
> > > different version of this patch and changed the description quite a
> > > bit. Once I'm home I can send you the patchset that was merged into
> > > his tree. Also let me know if you want to disable CONFIG_PER_VMA_LOCK
> > > in the stable branch (the patch called "[PATCH 6.4 1/8] mm: disable
> > > CONFIG_PER_VMA_LOCK until its fixed" which Linus did not take AFAIKT)=
.
> >
> > No rush, you can do this on Monday.
> >
> > I took the patches that Linus added to his tree already into the stable
> > 6.4.y tree, and it's in the -rc release I pushed out a few hours ago.
>
> I just checked your stable master branch and it's perfectly in sync
> with Linus' tree.
>
> >
> > So if you want to look at the -rc release, that would be great, the ful=
l
> > list of patches can be seen here:
> >         https://lore.kernel.org/r/20230709111345.297026264@linuxfoundat=
ion.org
>
> Let me sync git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> to see what's happening there.

Ok, I'm looking at the linux-6.4.y branch in
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git

This patch is not needed (obsolete):
32d458fa68fe ("fork: lock VMAs of the parent process when forking")

Patch fb49c455323f ("fork: lock VMAs of the parent process when
forking, again") can be renamed into "fork: lock VMAs of the parent
process when forking" as its original.

Patch 11eaf9aa0699 ("mm: disable CONFIG_PER_VMA_LOCK until its fixed")
was removed in Linus' tree, see comment in
946c6b59c56dc6e7d8364a8959cb36bf6d10bc37 saying: "The merge undoes the
disabling of the CONFIG_PER_VMA_LOCK feature, since it was all
hopefully fixed in mainline.". Unless you want to keep
CONFIG_PER_VMA_LOCK disabled in the stable tree, that patch should
also be dropped.

Everything else LGTM.
Thanks,
Suren.


> Thanks,
> Suren.
>
> >
> > thanks,
> >
> > greg k-h
