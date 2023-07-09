Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8609B74C7E5
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 21:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjGITtC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 15:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGITs7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 15:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3CA131
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 12:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20CCA60C38
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 19:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A26EC433C8;
        Sun,  9 Jul 2023 19:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688932131;
        bh=i+XOnoxVNlDAYmcA+gZO9/oFEjVljgF6LZpweWKnr+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1bpZN40vT5i7wmGhmqz7JWepM/gLgfn1eoKIgbVWHW8U7bkYWItAkicyQCpIox1NR
         tmdgeY4ROodxB75iDdkQRQV4NGbdpNhxZKoW6mNYs9JihDGhqaPA9KtuumxKEDI+yI
         t4fJbs7bpW6eIRdxHYK9PkIlWc2DRWNCDL7WZUbY=
Date:   Sun, 9 Jul 2023 18:09:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        David Hildenbrand <david@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.4 7/8] fork: lock VMAs of the parent process when
 forking
Message-ID: <2023070931-conjuror-dweeb-bb4b@gregkh>
References: <20230709111345.297026264@linuxfoundation.org>
 <20230709111345.516444847@linuxfoundation.org>
 <c783f635-f839-638c-5e32-ef923be432ad@leemhuis.info>
 <2023070904-customer-concise-e6fe@gregkh>
 <CAJuCfpFfc7tvv9CPMx=1b=X-1foiDZ+0bXkVUsFekWB_zNUnLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFfc7tvv9CPMx=1b=X-1foiDZ+0bXkVUsFekWB_zNUnLw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 09, 2023 at 09:04:09AM -0700, Suren Baghdasaryan wrote:
> On Sun, Jul 9, 2023 at 6:32 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jul 09, 2023 at 02:39:00PM +0200, Thorsten Leemhuis wrote:
> > > On 09.07.23 13:14, Greg Kroah-Hartman wrote:
> > > > From: Suren Baghdasaryan <surenb@google.com>
> > > >
> > > > commit 2b4f3b4987b56365b981f44a7e843efa5b6619b9 upstream.
> > > >
> > > > Patch series "Avoid memory corruption caused by per-VMA locks", v4.
> > > >
> > > > A memory corruption was reported in [1] with bisection pointing to the
> > > > patch [2] enabling per-VMA locks for x86.  Based on the reproducer
> > > > provided in [1] we suspect this is caused by the lack of VMA locking while
> > > > forking a child process.
> > > > [...]
> > >
> > > Question from someone that is neither a C nor a git expert -- and thus
> > > might say something totally stupid below (and thus maybe should not have
> > > sent this mail at all).
> > >
> > > But I have to wonder: is adding this patch to stable necessary given
> > > patch 8/8?
> > >
> > > FWIW, this change looks like this:
> > >
> > > > ---
> > > >  kernel/fork.c |    6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -662,6 +662,12 @@ static __latent_entropy int dup_mmap(str
> > > >             retval = -EINTR;
> > > >             goto fail_uprobe_end;
> > > >     }
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +   /* Disallow any page faults before calling flush_cache_dup_mm */
> > > > +   for_each_vma(old_vmi, mpnt)
> > > > +           vma_start_write(mpnt);
> > > > +   vma_iter_set(&old_vmi, 0);
> > > > +#endif
> > > >     flush_cache_dup_mm(oldmm);
> > > >     uprobe_dup_mmap(oldmm, mm);
> > > >     /*
> > >
> > > But when I look at kernel/fork.c in mainline I can't see this bit. I
> > > also only see Linus' change (e.g. patch 8/8 in this series) when I look at
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/kernel/fork.c
> >
> > Look at 946c6b59c56d ("Merge tag 'mm-hotfixes-stable-2023-07-08-10-43'
> > of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")
> >
> > Where Linus manually dropped those #ifdefs.
> >
> > Hm, I'll leave them for now in 6.4.y as that is "safer", but if Suren
> > feels comfortable, I'll gladly take a patch from him to drop them in the
> > 6.4.y tree as well.
> 
> Hi Greg,
> Give me a couple hours to get back to my computer. Linus took a
> different version of this patch and changed the description quite a
> bit. Once I'm home I can send you the patchset that was merged into
> his tree. Also let me know if you want to disable CONFIG_PER_VMA_LOCK
> in the stable branch (the patch called "[PATCH 6.4 1/8] mm: disable
> CONFIG_PER_VMA_LOCK until its fixed" which Linus did not take AFAIKT).

No rush, you can do this on Monday.

I took the patches that Linus added to his tree already into the stable
6.4.y tree, and it's in the -rc release I pushed out a few hours ago.

So if you want to look at the -rc release, that would be great, the full
list of patches can be seen here:
	https://lore.kernel.org/r/20230709111345.297026264@linuxfoundation.org

thanks,

greg k-h
