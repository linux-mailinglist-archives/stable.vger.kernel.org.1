Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7776A146
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 21:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGaTbD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 15:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGaTbC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 15:31:02 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5336199E
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:31:00 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bb140cd5a5so3572038a34.3
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690831860; x=1691436660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri5yafbuL09u63Nj9JUthSCzYPjx6uG9CsWJ2yEpNqI=;
        b=UjhhRZWDtRx74bTvWmT3fMpVy9szO/l+3kCSx8h2TcZ9k4cgarSo5SfvC1JUtQWX+y
         Ic0vdZX0fvJbxOGIa/D4ARmFCuIfLrgd0MsaajA7pWuYCWijlokkay5XSTFAsM6eCGxn
         lguEpnYec9vPl+WHyI8moFd1j+CX9bxV+CFdeAUO1AREy0HzxFzqpzgNp73nFfxI0fnt
         FSg/TEgrKzORzXHYSN3aBJMJaGF3Vzw/rFysSJIkiclwC8RQJhRZKsgJ5SIzI0w0w40v
         1LafnpwapEkqmNENRXtCKrlWcCnu7ppHubztKogJbCnGcndzzwpLF6B9kqtZR49JlvKQ
         BArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831860; x=1691436660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri5yafbuL09u63Nj9JUthSCzYPjx6uG9CsWJ2yEpNqI=;
        b=ahpvbWr9Y8lgt4ofEIyYopMITc7EGj2tMHuJfSvcCu9Evl8Gk6xzGsfrAdBvUN1rnX
         0OYIVDqcsRKOOLxLWD2V6sAChhL48isMUQ21eAOG0BkkzL84wfkmzVG050KsUVcGYB3I
         MKcxQZNqcDLPRA1f+id3cLZq9L2itHle7OqCBTriSNrBvMKHsA3wsKOKavnrgkxMSAs9
         MgjytsNomCqm32PxqyEJc5xMPsPEqmC6TBzWDnNH+WcVIbS/m+I5ImlA2wJb9aez8aZp
         GeN1MUYxtj7VNByQw9TAHzz3YtCEC6u5K2an5PcaNXuUqqexF75A6PW22aeSSQPmsu4c
         Mp2Q==
X-Gm-Message-State: ABy/qLaydypBlF7oPIEIbSakTxrXz5eWayfiolqZPrgut0bNFkjPDAmZ
        izxrZlgM00RDpTrgcVRvvzIvCVrk06RegI6T/hP8Jg==
X-Google-Smtp-Source: APBJJlH1Nb3wYpeMxuSzBBPjz1Nyltou8BS0F/g8ei595+a0AVaM6Jlz10PXmItkuf3OR74IkTYEFYxYrZGe05RE9y8=
X-Received: by 2002:a05:6358:4283:b0:134:d467:b751 with SMTP id
 s3-20020a056358428300b00134d467b751mr830493rwc.21.1690831859825; Mon, 31 Jul
 2023 12:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com> <20230731171233.1098105-2-surenb@google.com>
 <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jul 2023 12:30:46 -0700
Message-ID: <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: enable page walking API to lock vmas during the walk
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
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

On Mon, Jul 31, 2023 at 11:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 31 Jul 2023 at 10:12, Suren Baghdasaryan <surenb@google.com> wrot=
e:
> >
> > -               walk_page_vma(vma, &subpage_walk_ops, NULL);
> > +               walk_page_vma(vma, &subpage_walk_ops, true, NULL);
>
> Rather than add a new argument to the walk_page_*() functions, I
> really think you should just add the locking rule to the 'const struct
> mm_walk_ops' structure.
>
> The locking rule goes along with the rules for what you are actually
> doing, after all. Plus it would actually make it all much more legible
> when it's not just some random "true/false" argument, but a an actual
>
>         .write_lock =3D 1
>
> in the ops definition.

Yeah, I was thinking about that but thought a flag like this in a pure
"ops" struct would be frowned upon. If this is acceptable then it
makes it much cleaner.

>
> Yes, yes, that might mean that some ops might need duplicating in case
> you really have a walk that sometimes takes the lock, and sometimes
> doesn't, but that is odd to begin with.
>
> The only such case I found from a quick look was the very strange
> queue_pages_range() case. Is it really true that do_mbind() needs the
> write-lock, but do_migrate_pages() does not?
>
> And if they really are that different maybe they should have different wa=
lk_ops?

Makes sense to me.

>
> Maybe there were other cases that I didn't notice.
>
> >                 error =3D walk_page_range(current->mm, start, end,
> > -                               &prot_none_walk_ops, &new_pgprot);
> > +                               &prot_none_walk_ops, true, &new_pgprot)=
;
>
> This looks odd. You're adding vma locking to a place that didn't do it be=
fore.
>
> Yes, the mmap semaphore is held for writing, but this particular walk
> doesn't need it as far as I can tell.

Yes you are correct. Locking a vma in this case seems unnecessary.

>
> In fact, this feels like that walker should maybe *verify* that it's
> held for writing, but not try to write it again?

In this particular case, does this walk even require the vma to be
write locked? Looks like it's simply checking the ptes. And if so,
walk_page_range() already has mmap_assert_locked(walk.mm) at the
beginning to ensure the tree is stable. Do we need anything else here?

>
> Maybe the "lock_vma" flag should be a tri-state:
>
>  - lock for reading (no-op per vma), verify that the mmap sem is held
> for reading
>
>  - lock for reading (no-op per vma), but with mmap sem held for
> writing (this kind of "check before doing changes" walker)
>
>  - lock for writing (with mmap sem obviously needs to be held for writing=
)
>
> >         mmap_assert_locked(walk.mm);
> > +       if (lock_vma)
> > +               vma_start_write(vma);
>
> So I think this should also be tightened up, and something like
>
>         switch (ops->locking) {
>         case WRLOCK:
>                 vma_start_write(vma);
>                 fallthrough;
>         case WRLOCK_VERIFY:
>                 mmap_assert_write_locked(mm);
>                 break;
>         case RDLOCK:
>                 mmap_assert_locked(walk.mm);
>         }

I got the idea but a couple of modifications, if I may.
walk_page_range() already does mmap_assert_locked() at the beginning,
so we can change it to:

if (ops->locking =3D=3D RDLOCK)
        mmap_assert_locked(walk.mm);
else
        mmap_assert_write_locked(mm);

and during the walk:

        switch (ops->locking) {
        case WRLOCK:
                 vma_start_write(vma);
                 break;
#ifdef CONFIG_PER_VMA_LOCK
        case WRLOCK_VERIFY:
                 vma_assert_write_locked(vma);
                 break;
#endif
         }

The above CONFIG_PER_VMA_LOCK is ugly but with !CONFIG_PER_VMA_LOCK
vma_assert_write_locked() becomes mmap_assert_write_locked() and we
already checked that, so it's unnecessary.

>
> because we shouldn't have a 'vma_start_write()' without holding the
> mmap sem for *writing*, and the above would also allow that
> mprotect_fixup() "walk to see if we can merge, verify that it was
> already locked" thing.
>
> Hmm?
>
> NOTE! The above names are just completely made up. I dcon't think it
> should actually be some "WRLOCK" enum. There are probably much better
> names. Take the above as a "maybe something kind of in this direction"
> rather than "do it exactly like this".

I'm not great with names... Maybe just add a PGWALK_ prefix like this:

PGWALK_RDLOCK
PGWALK_WRLOCK
PGWALK_WRLOCK_VERIFY

?

>
>             Linus
