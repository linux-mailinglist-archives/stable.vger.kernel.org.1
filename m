Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915EE74C7EC
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 21:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjGITyF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGITyE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 15:54:04 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D31FD
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 12:54:02 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5701810884aso41583097b3.0
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688932442; x=1691524442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6pXGSwyhnHN/RAuNqa0NiZhHV7cOEEEIZDSxSE950g=;
        b=oQiwCtaaXWHKXlac5UAGZP8F00RD6Mz1qQlqRmA848N2SnogesPZuSU6zxi5olI7QH
         ljCI1chSTKTd+f96VO9yLjJRXwDyN7M+c6r18HNDTqQMrfWlbZakLwGP3UyN151sIZL9
         Era2IVRbGNaL3Vdn8cO9/skiAW9zFtT4NfXECz7D8kN7HAEdiT8Pfp97cC7SQhqbXnxW
         +qUUdY9FH0myc4gSwJLREikac043ew2L6iTcJuw7uKQtZv19kyASNDwCBM8NmtszIZUc
         XYwRlZFGr46QGyZYzfikFbpLxjxgRThktTb8SAkdbUTkjXldHJes0eCz0VDSbpQd7pmO
         t6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688932442; x=1691524442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6pXGSwyhnHN/RAuNqa0NiZhHV7cOEEEIZDSxSE950g=;
        b=h0DPMvYGy4CRL2hpCBF/j/echcXdXKjKVWSoQhdiRMJzE7vYxf+W09itiKXIT1Y7DZ
         WCd3Y5M/hu7FpuAnbuyS0uW+z0Sb6HtaSaLMG2Bkb8n4JoyqyGXkSfmHDklBfJ/qb2he
         LVKm1LrwJsn8QE32hJyIE/5xQVzHTC/631n4V4cmrW4NJ5TMy5nvfMSi+l18MmmwOMxT
         McT0qDq15pYF+Xc/ERANQu7Gya3q63HpMQ3maDjuLB1DdmxK0o8RvqXcLdYMVS9BzE6A
         AOMqZYbTLawGm7WIQDbvcWiftmgswdJy+yNN1izASPxxn/n7hx5m9ZLT70n6BaX1xmCx
         ygZw==
X-Gm-Message-State: ABy/qLaxpd0pi3VNcvUloZRzzPgIyW1ngDmaBxBtk+6ih5k9zSHxcVIm
        0WngfjdgIVFYpW3Pg2aZv4v8BcPflv8mRcn7bjMsjw==
X-Google-Smtp-Source: APBJJlHOjDvY3L2P2C6aH8eYw1mR/shBrau/mhWuDtkzbIzH3ruBtpOcMB+PmmsbbkpVkBJz3By6zXKwWzxrdUfg55I=
X-Received: by 2002:a81:a010:0:b0:57a:2e83:4daf with SMTP id
 x16-20020a81a010000000b0057a2e834dafmr11477270ywg.32.1688932441782; Sun, 09
 Jul 2023 12:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230709111345.297026264@linuxfoundation.org> <20230709111345.516444847@linuxfoundation.org>
 <c783f635-f839-638c-5e32-ef923be432ad@leemhuis.info> <2023070904-customer-concise-e6fe@gregkh>
 <CAJuCfpFfc7tvv9CPMx=1b=X-1foiDZ+0bXkVUsFekWB_zNUnLw@mail.gmail.com> <2023070931-conjuror-dweeb-bb4b@gregkh>
In-Reply-To: <2023070931-conjuror-dweeb-bb4b@gregkh>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 9 Jul 2023 19:53:50 +0000
Message-ID: <CAJuCfpHgq_2sZVw7Vv9TuNgBHLO_9f_KAmQ73kFY+093GdMfRg@mail.gmail.com>
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

On Sun, Jul 9, 2023 at 7:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 09, 2023 at 09:04:09AM -0700, Suren Baghdasaryan wrote:
> > On Sun, Jul 9, 2023 at 6:32=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jul 09, 2023 at 02:39:00PM +0200, Thorsten Leemhuis wrote:
> > > > On 09.07.23 13:14, Greg Kroah-Hartman wrote:
> > > > > From: Suren Baghdasaryan <surenb@google.com>
> > > > >
> > > > > commit 2b4f3b4987b56365b981f44a7e843efa5b6619b9 upstream.
> > > > >
> > > > > Patch series "Avoid memory corruption caused by per-VMA locks", v=
4.
> > > > >
> > > > > A memory corruption was reported in [1] with bisection pointing t=
o the
> > > > > patch [2] enabling per-VMA locks for x86.  Based on the reproduce=
r
> > > > > provided in [1] we suspect this is caused by the lack of VMA lock=
ing while
> > > > > forking a child process.
> > > > > [...]
> > > >
> > > > Question from someone that is neither a C nor a git expert -- and t=
hus
> > > > might say something totally stupid below (and thus maybe should not=
 have
> > > > sent this mail at all).
> > > >
> > > > But I have to wonder: is adding this patch to stable necessary give=
n
> > > > patch 8/8?
> > > >
> > > > FWIW, this change looks like this:
> > > >
> > > > > ---
> > > > >  kernel/fork.c |    6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > --- a/kernel/fork.c
> > > > > +++ b/kernel/fork.c
> > > > > @@ -662,6 +662,12 @@ static __latent_entropy int dup_mmap(str
> > > > >             retval =3D -EINTR;
> > > > >             goto fail_uprobe_end;
> > > > >     }
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +   /* Disallow any page faults before calling flush_cache_dup_mm=
 */
> > > > > +   for_each_vma(old_vmi, mpnt)
> > > > > +           vma_start_write(mpnt);
> > > > > +   vma_iter_set(&old_vmi, 0);
> > > > > +#endif
> > > > >     flush_cache_dup_mm(oldmm);
> > > > >     uprobe_dup_mmap(oldmm, mm);
> > > > >     /*
> > > >
> > > > But when I look at kernel/fork.c in mainline I can't see this bit. =
I
> > > > also only see Linus' change (e.g. patch 8/8 in this series) when I =
look at
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
log/kernel/fork.c
> > >
> > > Look at 946c6b59c56d ("Merge tag 'mm-hotfixes-stable-2023-07-08-10-43=
'
> > > of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
> > >
> > > Where Linus manually dropped those #ifdefs.
> > >
> > > Hm, I'll leave them for now in 6.4.y as that is "safer", but if Suren
> > > feels comfortable, I'll gladly take a patch from him to drop them in =
the
> > > 6.4.y tree as well.
> >
> > Hi Greg,
> > Give me a couple hours to get back to my computer. Linus took a
> > different version of this patch and changed the description quite a
> > bit. Once I'm home I can send you the patchset that was merged into
> > his tree. Also let me know if you want to disable CONFIG_PER_VMA_LOCK
> > in the stable branch (the patch called "[PATCH 6.4 1/8] mm: disable
> > CONFIG_PER_VMA_LOCK until its fixed" which Linus did not take AFAIKT).
>
> No rush, you can do this on Monday.
>
> I took the patches that Linus added to his tree already into the stable
> 6.4.y tree, and it's in the -rc release I pushed out a few hours ago.

I just checked your stable master branch and it's perfectly in sync
with Linus' tree.

>
> So if you want to look at the -rc release, that would be great, the full
> list of patches can be seen here:
>         https://lore.kernel.org/r/20230709111345.297026264@linuxfoundatio=
n.org

Let me sync git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
to see what's happening there.
Thanks,
Suren.

>
> thanks,
>
> greg k-h
