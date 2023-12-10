Return-Path: <stable+bounces-5186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A90F80B8E3
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 05:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B564C280ECD
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 04:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2517E1;
	Sun, 10 Dec 2023 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoW5CPJP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA25CC
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 20:50:20 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77f552d4179so107068485a.1
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 20:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702183819; x=1702788619; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIkIlVjuTsSZonYbT9Lh+ydI60SKI4+lH6hx+9t9RiI=;
        b=aoW5CPJPcB/+VBCVaf8ti0WvZyw+SThvDMS6V8XyUnwzaiQqIsL/v6q3qU4hdRcKvB
         XeCSyDVdH5KoRczSxUYAILALIcB/cvANvB+hGDNL4VtOpVzd52VxG7iW6cP2js7gTwc6
         tFKbFqv5LFR2PTQUfHtHIQBO5NWBwMV5HWKVJOePgsQikZzQ7eJVQE4ZX1Y4Hl7rVrrM
         MYaQOptEu4J4dx94NCwMp1Ps9z+z3s7sOSFXO1WJN1ese/HMFaDvRrk0EpyUgYzfswHw
         Xt+NA2TRIhxOQi2BXOo2lfCiv16+3EeECP5DYkg61UUqeXQa8py/Gy03glJmT7gVokhU
         zBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702183819; x=1702788619;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIkIlVjuTsSZonYbT9Lh+ydI60SKI4+lH6hx+9t9RiI=;
        b=wQg0h9NFSN8dYNuUpPnZInJrknClw4cAHK/ambQaLvPyrnInuyBb43L+/buOwvpnYe
         hBFYrQXqrleDn3QSlQxrgA92Hdd7Q+Ov3gqOfoGzUA0F0DPkpbEelXbELlQoB705kpM8
         b/o5sZTLaQlaz6hg0/3gRF7Dt7Smp12e16MiDxYN4jbYz8Pkl1bg+h6VBvLLzG1Re60o
         JAAWSnnVVOIJB6p75VhQr29ylkPkj9mocYl0lyOGUkIa0QXa/2Jg9DHCRmlr0Yuriz4b
         2NUXgcn6VHM7rVPXv9ZyRT+024a1a74wvkAxyBwitgq9NFm/+k6Mep8kShWI3r+CJAUr
         a3gQ==
X-Gm-Message-State: AOJu0Yxs+0vxcdKYChqQb7G2gh3TID2V+bp9kHUd0RYhtxnCWsNTK1+V
	Gp+I0E5uqyUc1//iSo9cqa7QFMlH5EOlV1ECMWbvhg==
X-Google-Smtp-Source: AGHT+IEm16/D/eAs3soq2Xal/FSr/wfLyb6kCBuJ6snlXpo/Orf/GeXYk5wUdplDUfNurPSmxIhKzQ==
X-Received: by 2002:a05:620a:4620:b0:77e:fba3:939c with SMTP id br32-20020a05620a462000b0077efba3939cmr3926688qkb.126.1702183819407;
        Sat, 09 Dec 2023 20:50:19 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w200-20020a0dd4d1000000b005d91e8945acsm1973500ywd.110.2023.12.09.20.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 20:50:18 -0800 (PST)
Date: Sat, 9 Dec 2023 20:50:08 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Matthew Wilcox <willy@infradead.org>
cc: gregkh@linuxfoundation.org, hughd@google.com, akpm@linux-foundation.org, 
    david@redhat.com, jannh@google.com, 
    =?ISO-8859-15?Q?Jos=E9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>, 
    kirill.shutemov@linux.intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm: fix oops when filemap_map_pmd()
 without prealloc_pte" failed to apply to 5.15-stable tree
In-Reply-To: <ZXS7/8jHrj8XFUoA@casper.infradead.org>
Message-ID: <f8b98b02-3467-50b9-21de-48de571ff3ec@google.com>
References: <2023120945-citizen-library-9f46@gregkh> <ZXS7/8jHrj8XFUoA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463753983-612107459-1702183818=:20836"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463753983-612107459-1702183818=:20836
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 9 Dec 2023, Matthew Wilcox wrote:
> On Sat, Dec 09, 2023 at 01:35:45PM +0100, gregkh@linuxfoundation.org wrot=
e:
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
>=20
> This should do the job.  It's not clear to me whether this bug remains
> latent on 5.15, so it may not be appropriate to apply.  I defer to Hugh.

Yes, that's exactly it, thanks Matthew. I knew I was going to need to
look at this one, and even the 6.1 version, when they came out: because
my mods did change what a safe procedure is; but this and the 6.1
version are both good, because of the old pmd_devmap_trans_unstable()
check which follows in both of those trees.

As to whether it's needed in 5.15 and 6.1: I believe so. There's no
doubt that my changes made it very much easier to hit, but I think it
was a possibility before them. When I first wrote the commit message,
I was describing how: I think you need huge tmpfs, and MADV_DONTNEED
zapping the huge pmd under mmap_lock for read, racing with this fault
which, to come this way, would have needed to have been on a previous
page table which khugepaged has collapsed just before MADV_DONTNEED
and fault got mmap_lock for read.

Far fetched, and of course I could be wrong. But reading my original
commit message, I thought it was needlessly encouraging to bad actors,
so cut it out. What I'm most afraid of is the "(or some other symptom
in normal case of ptlock embedded not pointer)" - data corruption or
data leak perhaps.

I see Greg provides some new and helpfully explicit instructions below,
on how to manage sending replacement patches: I'll send a replacement
following those instructions (but might hit an issue at git send-email
stage - will send manually if so).

Hugh

>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 81e28722edfa..84a5b0213e0e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3209,7 +3209,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, s=
truct page *page)
>  =09    }
>  =09}
> =20
> -=09if (pmd_none(*vmf->pmd)) {
> +=09if (pmd_none(*vmf->pmd) && vmf->prealloc_pte) {
>  =09=09vmf->ptl =3D pmd_lock(mm, vmf->pmd);
>  =09=09if (likely(pmd_none(*vmf->pmd))) {
>  =09=09=09mm_inc_nr_ptes(mm);
>=20
> > To reproduce the conflict and resubmit, you may use the following comma=
nds:
> >=20
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 9aa1345d66b8132745ffb99b348b1492088da9e2
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202312094=
5-citizen-library-9f46@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> >=20
> > Possible dependencies:
> >=20
> > 9aa1345d66b8 ("mm: fix oops when filemap_map_pmd() without prealloc_pte=
")
> > 03c4f20454e0 ("mm: introduce pmd_install() helper")
> >=20
> > thanks,
> >=20
> > greg k-h
> >=20
> > ------------------ original commit in Linus's tree ------------------
> >=20
> > >From 9aa1345d66b8132745ffb99b348b1492088da9e2 Mon Sep 17 00:00:00 2001
> > From: Hugh Dickins <hughd@google.com>
> > Date: Fri, 17 Nov 2023 00:49:18 -0800
> > Subject: [PATCH] mm: fix oops when filemap_map_pmd() without prealloc_p=
te
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >=20
> > syzbot reports oops in lockdep's __lock_acquire(), called from
> > __pte_offset_map_lock() called from filemap_map_pages(); or when I run =
the
> > repro, the oops comes in pmd_install(), called from filemap_map_pmd()
> > called from filemap_map_pages(), just before the __pte_offset_map_lock(=
).
> >=20
> > The problem is that filemap_map_pmd() has been assuming that when it fi=
nds
> > pmd_none(), a page table has already been prepared in prealloc_pte; and
> > indeed do_fault_around() has been careful to preallocate one there, whe=
n
> > it finds pmd_none(): but what if *pmd became none in between?
> >=20
> > My 6.6 mods in mm/khugepaged.c, avoiding mmap_lock for write, have made=
 it
> > easy for *pmd to be cleared while servicing a page fault; but even befo=
re
> > those, a huge *pmd might be zapped while a fault is serviced.
> >=20
> > The difference in symptomatic stack traces comes from the "memory model=
"
> > in use: pmd_install() uses pmd_populate() uses page_to_pfn(): in some
> > models that is strict, and will oops on the NULL prealloc_pte; in other
> > models, it will construct a bogus value to be populated into *pmd, then
> > __pte_offset_map_lock() oops when trying to access split ptlock pointer
> > (or some other symptom in normal case of ptlock embedded not pointer).
> >=20
> > Link: https://lore.kernel.org/linux-mm/20231115065506.19780-1-jose.pekk=
arinen@foxhound.fi/
> > Link: https://lkml.kernel.org/r/6ed0c50c-78ef-0719-b3c5-60c0c010431c@go=
ogle.com
> > Fixes: f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepa=
ths")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotma=
il.com
> > Closes: https://lore.kernel.org/linux-mm/0000000000005e44550608a0806c@g=
oogle.com/
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Cc: Jann Horn <jannh@google.com>,
> > Cc: Jos=E9 Pekkarinen <jose.pekkarinen@foxhound.fi>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: <stable@vger.kernel.org>    [5.12+]
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >=20
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 32eedf3afd45..f1c8c278310f 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3371,7 +3371,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf,=
 struct folio *folio,
> >  =09=09}
> >  =09}
> > =20
> > -=09if (pmd_none(*vmf->pmd))
> > +=09if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
> >  =09=09pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
> > =20
> >  =09return false;
> >=20
---1463753983-612107459-1702183818=:20836--

