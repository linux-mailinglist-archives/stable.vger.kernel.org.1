Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852DE7488F0
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 18:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGEQLP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEQLO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 12:11:14 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB212A
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 09:11:13 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c17534f4c63so7882488276.0
        for <stable@vger.kernel.org>; Wed, 05 Jul 2023 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688573472; x=1691165472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4CizjzMyVryUzo9zkH8yPfHNB6eZIgaisjI66Xz0ps=;
        b=p3sGXarQz4x4/EmK2Xq5/rWClhl7cjpV3yLtHQHjTD/GnYOz7/mfQyb18mnyca94W0
         sroj10MWFWDJM8ZkO/U8ygDvPd9iBDHjw3VuReL4hsYcQ205TAAn4Tp2GJjLs2//L/VQ
         rVq8XGqc6+Qbdn9CgKabb9EgMoFGPWEnP3AyKvPFLmI5YsLWmA7/n8N3j/iXFjuiSlct
         bRg7ZCqB9z/ASsrjPlzxypGqGuvFrayFmgyyapxuPag/8Syfiyz57BG1M6LSygq3A8WS
         s8dKKhJJvCF8MgCVfxOH5FMLGwn313ijAVrU7BMPNN3Ky3JR2Tf+j0REf1U5rgUXDsxV
         bHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688573472; x=1691165472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4CizjzMyVryUzo9zkH8yPfHNB6eZIgaisjI66Xz0ps=;
        b=M7u9Nqwqv6WB3JH4R71U4MomFVVoI7slk59NRyUFlFgllWkI7pqSlbYTg5GzY9+sCp
         e2o/fhysiHVBWLSg5Vc0Y4dEwASYltkadmbVx0BbQHanHAiFWgy3jJU0hvv6ZanubpEB
         Y/D7W5Q7eUHW9nOiDk+pFUVsHHidG/C3qSMLaRhT3Ilf101gDhDGvl5V+HXVLLsgKj6n
         Ae96vCzm9QAl1k+yrbfiEO9X2MQ6A0SDyEwA68u/yru5aG7EIxKTImA0pZVDD7DFUFkB
         TRMx0hSKFO9FpXmLO+n4daiF8BsUzuYZ2aQ8UcrljowNwk48EHeI936F/7s2y+NkXBdv
         7eTA==
X-Gm-Message-State: ABy/qLbLLMahhrf2LeeeJT8Ou23lH5D6ScyK9CmPn/8yI6Qku9E+97ta
        Ilk5O/VuEz+JBru/nvBcfEEAHsw37CZMDU+kYqnPsw==
X-Google-Smtp-Source: APBJJlHulVtZG5SP3B5FT5kXTl3vzTRyAFjlJZNFEC+4RVdD1bhcdNpFSDHB6IB+VKa5q1dQjsSw3rX4BYZHYErisWs=
X-Received: by 2002:a25:b315:0:b0:c5d:6992:6fa7 with SMTP id
 l21-20020a25b315000000b00c5d69926fa7mr4528975ybj.9.1688573471234; Wed, 05 Jul
 2023 09:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230705063711.2670599-1-surenb@google.com> <20230705063711.2670599-2-surenb@google.com>
 <970295ab-e85d-7af3-76e6-df53a5c52f8b@redhat.com>
In-Reply-To: <970295ab-e85d-7af3-76e6-df53a5c52f8b@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 09:10:58 -0700
Message-ID: <CAJuCfpEkzSqsprQE_zLaPF0zefvuAXQJtpYCgGNZzfj4bRr2dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fork: lock VMAs of the parent process when forking
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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

On Wed, Jul 5, 2023 at 1:08=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.07.23 08:37, Suren Baghdasaryan wrote:
> > When forking a child process, parent write-protects an anonymous page
> > and COW-shares it with the child being forked using copy_present_pte().
> > Parent's TLB is flushed right before we drop the parent's mmap_lock in
> > dup_mmap(). If we get a write-fault before that TLB flush in the parent=
,
> > and we end up replacing that anonymous page in the parent process in
> > do_wp_page() (because, COW-shared with the child), this might lead to
> > some stale writable TLB entries targeting the wrong (old) page.
> > Similar issue happened in the past with userfaultfd (see flush_tlb_page=
()
> > call inside do_wp_page()).
> > Lock VMAs of the parent process when forking a child, which prevents
> > concurrent page faults during fork operation and avoids this issue.
> > This fix can potentially regress some fork-heavy workloads. Kernel buil=
d
> > time did not show noticeable regression on a 56-core machine while a
> > stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> > shows ~5% regression. If such fork time regression is unacceptable,
> > disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> > optimizations are possible if this regression proves to be problematic.
>
> Out of interest, did you also populate page tables / pages for some of th=
ese
> VMAs, or is this primarily looping over 10000 VMAs that don't actually co=
py any
> page tables?

I did not populate the page tables, therefore this represents the
worst case scenario (the share of time used to lock the VMAs is
maximized).

>
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf51=
b@kernel.org/
> > Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> > Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a34=
c@applied-asynchrony.com/
> > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling fi=
rst")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   kernel/fork.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index b85814e614a5..d2e12b6d2b18 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_stru=
ct *mm,
> >       for_each_vma(old_vmi, mpnt) {
> >               struct file *file;
> >
> > +             vma_start_write(mpnt);
> >               if (mpnt->vm_flags & VM_DONTCOPY) {
> >                       vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mp=
nt));
> >                       continue;
>
> After the mmap_write_lock_killable(), there will still be a period where =
page
> faults can happen. Essentially, page faults can happen for a VMA until we=
 lock that VMA.
>
> I cannot immediately name something that is broken allowing for that, and=
 this change
> should fix the issue at hand, but exotic things like
>
>         flush_cache_dup_mm(oldmm);
>
> make me wonder if we really want to allow for that or if there is some ot=
her corner case
> in fork() handling that really doesn't expect concurrent page faults (and=
, thereby, page
> table modifications) with fork.
>
> For example, documentation/core-api/cachetlb.rst says
>
> 2) ``void flush_cache_dup_mm(struct mm_struct *mm)``
>
>         This interface flushes an entire user address space from
>         the caches.  That is, after running, there will be no cache
>         lines associated with 'mm'.
>
>         This interface is used to handle whole address space
>         page table operations such as what happens during fork.
>
>         This option is separate from flush_cache_mm to allow some
>         optimizations for VIPT caches.
>

I see. So, we really need to lock all VMAs before
flush_cache_dup_mm(). Makes sense. I'll post an update to this patch
shortly.
Thanks,
Suren.

>
> An alternative that requires another VMA walk would be
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 41c964104b58..0f182d3f049b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -662,6 +662,13 @@ static __latent_entropy int dup_mmap(struct mm_struc=
t *mm,
>                 retval =3D -EINTR;
>                 goto fail_uprobe_end;
>         }
> +
> +       /* Disallow any page faults early by locking all VMAs. */
> +       if (IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
> +               for_each_vma(old_vmi, mpnt)
> +                       vma_start_write(mpnt);
> +               vma_iter_init(old_vmi, old_mm, 0);
> +       }
>         flush_cache_dup_mm(oldmm);
>         uprobe_dup_mmap(oldmm, mm);
>         /*
> --
> 2.41.0
>
>
> Unless there are other thoughts, I guess you change is fine regarding the=
 problem
> at hand. Not so sure regarding any other corner cases, that's why I'm spe=
lling it out.
>
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>
