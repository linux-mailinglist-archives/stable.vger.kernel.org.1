Return-Path: <stable+bounces-92150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B79C425D
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 17:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B202843B6
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22619995D;
	Mon, 11 Nov 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy2043ch"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A64C66
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341350; cv=none; b=OBwHxBYHlOXY1p/6/dveEv0QNbmJCQkBKUqU4K2yPz41seB1ORFkaB8KREbnA24gsItXFe4gnyTT1uA335JrjjHceWozaPD8wptnfBuIad/jav94ePmxquVzD4ALtoxmn+/nQYGuvrwnRVAiSb4wuugsMiY65A1x+XF3z9xtqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341350; c=relaxed/simple;
	bh=kTrY+M/qOB6UC+cOAWlha54f1CCqX8+YvGDAO+IoHFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlcYGjjI7kuz7bOipSCI9AVjOX/2Lu2/sH8NcxmxEKTRawf36S8foqLy0yoZogPy601BK5r+J2bom6RelXIyJx7kf4SD72SBoDPDXttuP4qrYafashOLbosnfwg7moydbyyO134M+Lo+vSsd0zId01ghKiqrXZe3gmM1Evc8NbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy2043ch; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso34996446d6.0
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731341347; x=1731946147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0DLm79c8nsyqnwnkNC9AVIHm71PDbkGvOOT8UgugGQ=;
        b=Iy2043chmikqhmGJAEMyEo7T4M9eyp433in9C6Yc1b/PPww2i/iiMfI+1y2axcNVEY
         aoOAcwKJpFRhg9CUpK5LW+/WagRGuKG6Y/mGC2F52Sr8QWWy1TcNKLdHQTu8w9VuSxXd
         +5mNDTte+vjE+M+cs8eScHjYzTiMTCH6Q08JYUFqrAkqGrzDcO8ZuTwR93IkMBgB8CLp
         Mtoy77QCBvb/AyroXcuZ4ymmXydB10F/rBvIn+LWBvb2iinYva7X2M/zafs+7occ9Dw7
         UEAv08RZaJyTbhzZgt/SqWiOpHK1pb1rV73Ckpxs7Qf7jwEPP3MZ9r7Nqxe2sQ+bi+Qo
         AXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731341347; x=1731946147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0DLm79c8nsyqnwnkNC9AVIHm71PDbkGvOOT8UgugGQ=;
        b=W3ZQ7T2DDzoxueRZptZdNc3jbHer19bz/2oJ1xcFX3nyaXPmHY0E+Q6pRob43V9iRc
         SBtRWdki/+2Duv+g63jhfvG8ux7XElikq37KzNjBZKoWQZ6XGzP4Nultb5m4GFUPDOwo
         upuIqVWJEsVn0M0n4V+oFumdtMeFyqcF93VVqz/k8ExdWM4WbwTMXtcy2uBa8DkWnp3R
         NEEuhYweemhokBhzn74uS6C/vh9fxwGvhKqVzn6je9gITMllO8zg4LVRWiLbUK+BNtDU
         VwbOMfoRrlSacqEqeTdE3SmBXHxr/kt9uaNOmrjPjwJkkYx9kRkeVt5zjPBV6I1Xs4rT
         b/cg==
X-Forwarded-Encrypted: i=1; AJvYcCUDEEMZf0sm5A7bQx5eX7BzkgbKot9vE039xojK7TsLK3hbSi+fN4i5h0cJuCFXaYuimUnHOI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8JljywhpmR63wAjcoq/icCnTDndjjF4JA4BjvMacsdnpAOl1p
	Cs29ccZAoE00VZDMmnf/0B0BduRsllW0YJ+hSPx9afg4ilhEjMjaHIxKMUKTuHbui1HsA/wFcce
	oNBs9k5BWzHztTz7uwJsm1a4I31M=
X-Google-Smtp-Source: AGHT+IHu0x4CdCBodNErT6K44euCCF0Z9POl4rIN/9Q4XzpF5dGVxexNjAbz7TUzm5sHsZupAPY8HbApNvrQ95g1QcM=
X-Received: by 2002:a05:6214:2b97:b0:6cb:c744:c415 with SMTP id
 6a1803df08f44-6d39e20a29cmr170018586d6.49.1731341347018; Mon, 11 Nov 2024
 08:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141710.9721-1-laoar.shao@gmail.com> <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com> <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
In-Reply-To: <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 12 Nov 2024 00:08:30 +0800
Message-ID: <CALOAHbD6HsrMhY0S_d9XA0LRdMGr6wwxFYAnv6u-d7VRFt6aKg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async readahead
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 11:05=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 11.11.24 15:28, Yafang Shao wrote:
> > On Mon, Nov 11, 2024 at 6:33=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 08.11.24 15:17, Yafang Shao wrote:
> >>> When testing large folio support with XFS on our servers, we observed=
 that
> >>> only a few large folios are mapped when reading large files via mmap.
> >>> After a thorough analysis, I identified it was caused by the
> >>> `/sys/block/*/queue/read_ahead_kb` setting. On our test servers, this
> >>> parameter is set to 128KB. After I tune it to 2MB, the large folio ca=
n
> >>> work as expected. However, I believe the large folio behavior should =
not be
> >>> dependent on the value of read_ahead_kb. It would be more robust if t=
he
> >>> kernel can automatically adopt to it.
> >>
> >> Now I am extremely confused.
> >>
> >> Documentation/ABI/stable/sysfs-block:
> >>
> >> "[RW] Maximum number of kilobytes to read-ahead for filesystems on thi=
s
> >> block device."
> >>
> >>
> >> So, with your patch, will we also be changing the readahead size to
> >> exceed that, or simply allocate larger folios and not exceeding the
> >> readahead size (e.g., leaving them partially non-filled)?
> >
> > Exceeding the readahead size for the MADV_HUGEPAGE case is
> > straightforward; this is what the current patch accomplishes.
> >
>
> Okay, so this only applies with MADV_HUGEPAGE I assume. Likely we should
> also make that clearer in the subject.
>
> mm/readahead: allow exceeding configured read_ahead_kb with MADV_HUGEPAGE
>
>
> If this is really a fix, especially one that deserves CC-stable, I
> cannot tell. Willy is the obvious expert :)
>
> >>
> >> If you're also changing the readahead behavior to exceed the
> >> configuration parameter it would sound to me like "I am pushing the
> >> brake pedal and my care brakes; fix the brakes to adopt whether to bra=
ke
> >> automatically" :)
> >>
> >> Likely I am missing something here, and how the read_ahead_kb paramete=
r
> >> is used after your patch.
> >
> > The read_ahead_kb parameter continues to function for
> > non-MADV_HUGEPAGE scenarios, whereas special handling is required for
> > the MADV_HUGEPAGE case. It appears that we ought to update the
> > Documentation/ABI/stable/sysfs-block to reflect the changes related to
> > large folios, correct?
>
> Yes, how it related to MADV_HUGEPAGE. I would assume that it would get
> ignored, but ...
>
> ... staring at get_next_ra_size(), it's not quite ignored, because we
> still us it as a baseline to detect how much we want to bump up the
> limit when the requested size is small? (*2 vs *4 etc) :/
>
> So the semantics are really starting to get weird, unless I am missing
> something important.
>
> [...]
>
> > Perhaps a more straightforward solution would be to implement it
> > directly at the callsite, as demonstrated below?
>
> Likely something into this direction might be better, but Willy is the
> expert that code.
>
> >
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 3dc6c7a128dd..187efae95b02 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -642,7 +642,11 @@ void page_cache_async_ra(struct readahead_control =
*ractl,
> >                          1UL << order);
> >          if (index =3D=3D expected) {
> >                  ra->start +=3D ra->size;
> > -               ra->size =3D get_next_ra_size(ra, max_pages);
> > +               /*
> > +                * Allow the actual size to exceed the readahead window=
 for a
> > +                * large folio.
>
> "a large folio" -> "with MADV_HUGEPAGE" ? Or can this be hit on
> different paths that are not covered in the patch description?

This branch may also be triggered by other large folios that are not
necessarily order-9. Therefore, I=E2=80=99ve referred to it as a 'large fol=
io'
rather than associating it specifically with MADV_HUGEPAGE. If we were
to handle only the MADV_HUGEPAGE case, we would proceed as outlined in
the initial RFC patch[0]. However, following Willy's recommendation, I
implemented it this way, as he likely has a deeper understanding of
the intended behavior.

[0]. https://lore.kernel.org/linux-mm/20241104143015.34684-1-laoar.shao@gma=
il.com/

--
Regards
Yafang

