Return-Path: <stable+bounces-92163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E869C459B
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137371F22BB6
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA326155C98;
	Mon, 11 Nov 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCXl0IrW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE714B965
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352240; cv=none; b=uzKJs1NgX+1pzXf0Xh0mUpfWKcW9H0OT8yT5ReCyqkPgFLYuN3yrbo/4ncdd5CArsUUK+63XoHLhfyTdkqU9tERqulbwK2JMiMZkgYyfH80IL+0Hk1lPKPXi9L7tKERAbsG0FCpOW4gfyaDwMYzGbQNQ63WxwgvQoU7XcO8Q198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352240; c=relaxed/simple;
	bh=IPzhdX2mpdgE9XIQcEADClrqPJD+CiB2fV1kiSTvttA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGIyF9sM7s+VH2O8FSpsBjT0o/wc/cHYpAYiBzhB9NQzib6qKaRfwwOpuEsRFEGzPj1G0WgYX+qR8wP3OoOilDIHDjo5tQpDPQFCiFpHY+3+NNn3ABVHScucPS7usMLfkgx7Sulw1zSeu+rj4bc9Q/InETUyiUmP65jDLkpTBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCXl0IrW; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e5e5c43497so37037677b3.3
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731352238; x=1731957038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOpvGE4R4YUIYnuR/EnaJKnSdsQZQjG6B6aPhLJX7WU=;
        b=dCXl0IrW6neISmpQtFmLuOYAmAN+NocHOBXU7HCGdnj+4Br06TUNQns7Z/Z6OKP/Qz
         bXZtmRnGIEnV5w2b5IVqi0rzcSc2oz+EWENefGlYW0x0+Xy1LaUX3dkqsbZbjWXY8unA
         6Tk3Eg86I9aX6rGQGUKum9DG/wAgEY+wcsTUYlh2smysu6fI59uVoxXkNbZ37EMztYxm
         MJhPZL/K2oVzt2F98b59Y4m+7rsaji7uWZtH3aXa0eYNTQf536+N1h1w53/dedhNwKFH
         qDelRAKfZoBSj0+y5bngFGiu0NfsDPhzpdZwGTa6WyhseeIDc4IiWiYuu9OV4RgXjQc6
         +Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731352238; x=1731957038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOpvGE4R4YUIYnuR/EnaJKnSdsQZQjG6B6aPhLJX7WU=;
        b=I3XyrYgtylMjWy1tNHrRo3gyP5L4lEfXWwsZzRcPStJ5Zg9JVHXPEVsWAU1tOPyeSf
         svM99k2YAWaqvapxnE7WucWKxtLQGA2APokWCSnRoDfVovBu9SIu5Hl79ZpzN4pC0ZhF
         UT5s9K6V586b0P7pjApMy1SqDnYoeyrcjMWCfANLbDxqcTNnMusb4amNLswgGiO8xnOT
         BlZ+mPmEsrcEDCGRbPxvWhXdaNzg52rgzqCTRrTUkiwd0kzSIUYBMT9h0ZCB3IpghqNx
         Y+Ql7k43w1YAje8T2wSFdENlvLl+HALQnLiGKHb31rRq5PLNl6bMi/c45lOhlQeGGqu5
         9+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwoBuXeoRlsuyokigHans99CW+Y/mril1FmE/G7vXbpSd57duZOTDJr33A3Ys/fc1l8ISr1Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWbb3I2Ci4AlItkoRvA211a2hrjzIhOxHdVClVIJ5KUFuHCkLr
	UBzeykVBuaFOvk7jHZidWzLLULONimpENotz4lmaCeEH91ZJH5fuQ6SX0kb6dLmaIfFnWb9n0K6
	3bQrh1uVFsrf3zdTKLQ+aAzYVG3s=
X-Google-Smtp-Source: AGHT+IGIJ6eNd9YSxv4NJT08aD6CqtFKIPZ0iX854Fch+qxeGA/rBryQz21EMssmAZrYV4sVjqtv8tUrf8V5AOqchsQ=
X-Received: by 2002:a05:690c:6413:b0:6e3:14b0:ff86 with SMTP id
 00721157ae682-6eadde5b02fmr127539757b3.27.1731352237744; Mon, 11 Nov 2024
 11:10:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141710.9721-1-laoar.shao@gmail.com> <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com> <CALOAHbD6HsrMhY0S_d9XA0LRdMGr6wwxFYAnv6u-d7VRFt6aKg@mail.gmail.com>
 <cf446ada-ad3a-41a4-b775-6cb32f846f2a@redhat.com>
In-Reply-To: <cf446ada-ad3a-41a4-b775-6cb32f846f2a@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 12 Nov 2024 03:10:01 +0800
Message-ID: <CALOAHbA=GuxdfQ8j-bnz=MT=0DTnrcNu5PcXvftfNh37WzRy1Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async readahead
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 2:31=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.11.24 17:08, Yafang Shao wrote:
> > On Mon, Nov 11, 2024 at 11:05=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 11.11.24 15:28, Yafang Shao wrote:
> >>> On Mon, Nov 11, 2024 at 6:33=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 08.11.24 15:17, Yafang Shao wrote:
> >>>>> When testing large folio support with XFS on our servers, we observ=
ed that
> >>>>> only a few large folios are mapped when reading large files via mma=
p.
> >>>>> After a thorough analysis, I identified it was caused by the
> >>>>> `/sys/block/*/queue/read_ahead_kb` setting. On our test servers, th=
is
> >>>>> parameter is set to 128KB. After I tune it to 2MB, the large folio =
can
> >>>>> work as expected. However, I believe the large folio behavior shoul=
d not be
> >>>>> dependent on the value of read_ahead_kb. It would be more robust if=
 the
> >>>>> kernel can automatically adopt to it.
> >>>>
> >>>> Now I am extremely confused.
> >>>>
> >>>> Documentation/ABI/stable/sysfs-block:
> >>>>
> >>>> "[RW] Maximum number of kilobytes to read-ahead for filesystems on t=
his
> >>>> block device."
> >>>>
> >>>>
> >>>> So, with your patch, will we also be changing the readahead size to
> >>>> exceed that, or simply allocate larger folios and not exceeding the
> >>>> readahead size (e.g., leaving them partially non-filled)?
> >>>
> >>> Exceeding the readahead size for the MADV_HUGEPAGE case is
> >>> straightforward; this is what the current patch accomplishes.
> >>>
> >>
> >> Okay, so this only applies with MADV_HUGEPAGE I assume. Likely we shou=
ld
> >> also make that clearer in the subject.
> >>
> >> mm/readahead: allow exceeding configured read_ahead_kb with MADV_HUGEP=
AGE
> >>
> >>
> >> If this is really a fix, especially one that deserves CC-stable, I
> >> cannot tell. Willy is the obvious expert :)
> >>
> >>>>
> >>>> If you're also changing the readahead behavior to exceed the
> >>>> configuration parameter it would sound to me like "I am pushing the
> >>>> brake pedal and my care brakes; fix the brakes to adopt whether to b=
rake
> >>>> automatically" :)
> >>>>
> >>>> Likely I am missing something here, and how the read_ahead_kb parame=
ter
> >>>> is used after your patch.
> >>>
> >>> The read_ahead_kb parameter continues to function for
> >>> non-MADV_HUGEPAGE scenarios, whereas special handling is required for
> >>> the MADV_HUGEPAGE case. It appears that we ought to update the
> >>> Documentation/ABI/stable/sysfs-block to reflect the changes related t=
o
> >>> large folios, correct?
> >>
> >> Yes, how it related to MADV_HUGEPAGE. I would assume that it would get
> >> ignored, but ...
> >>
> >> ... staring at get_next_ra_size(), it's not quite ignored, because we
> >> still us it as a baseline to detect how much we want to bump up the
> >> limit when the requested size is small? (*2 vs *4 etc) :/
> >>
> >> So the semantics are really starting to get weird, unless I am missing
> >> something important.
> >>
> >> [...]
> >>
> >>> Perhaps a more straightforward solution would be to implement it
> >>> directly at the callsite, as demonstrated below?
> >>
> >> Likely something into this direction might be better, but Willy is the
> >> expert that code.
> >>
> >>>
> >>> diff --git a/mm/readahead.c b/mm/readahead.c
> >>> index 3dc6c7a128dd..187efae95b02 100644
> >>> --- a/mm/readahead.c
> >>> +++ b/mm/readahead.c
> >>> @@ -642,7 +642,11 @@ void page_cache_async_ra(struct readahead_contro=
l *ractl,
> >>>                           1UL << order);
> >>>           if (index =3D=3D expected) {
> >>>                   ra->start +=3D ra->size;
> >>> -               ra->size =3D get_next_ra_size(ra, max_pages);
> >>> +               /*
> >>> +                * Allow the actual size to exceed the readahead wind=
ow for a
> >>> +                * large folio.
> >>
> >> "a large folio" -> "with MADV_HUGEPAGE" ? Or can this be hit on
> >> different paths that are not covered in the patch description?
> >
> > This branch may also be triggered by other large folios that are not
> > necessarily order-9. Therefore, I=E2=80=99ve referred to it as a 'large=
 folio'
> > rather than associating it specifically with MADV_HUGEPAGE. If we were
> > to handle only the MADV_HUGEPAGE case, we would proceed as outlined in
> > the initial RFC patch[0]. However, following Willy's recommendation, I
> > implemented it this way, as he likely has a deeper understanding of
> > the intended behavior.
>
> Sorry, but this code is getting quite confusing, especially with such
> misleading "large folio" comments.
>
> Even without MADV_HUGEPAGE we will be allocating large folios, as
> emphasized by Willy [1]. So the only thing MADV_HUGEPAGE controls is
> *which* large folios we allocate. .. as Willy says [2]: "We were only
> intending to breach the 'max' for the MADV_HUGE case, not for all cases."
>
> I have no idea how *anybody* should derive from the code here that we
> treat MADV_HUGEPAGE in a special way.
>
> Simply completely confusing.
>
> My interpretation of "I don't know if we should try to defend a stupid
> sysadmin against the consequences of their misconfiguration like this"
> means" would be "drop this patch and don't change anything".

Without this change, large folios won=E2=80=99t function as expected.
Currently, to support MADV_HUGEPAGE, you=E2=80=99d need to set readahead_kb=
 to
2MB, 4MB, or more. However, many applications run without
MADV_HUGEPAGE, and a larger readahead_kb might not be optimal for
them.

>
> No changes to API, no confusing code.

New features like large folios can often create confusion with
existing rules or APIs, correct?

>
> Maybe pr_info_once() when someone uses MADV_HUGEPAGE with such backends
> to tell the sysadmin that something stupid is happening ...

It's not a flawed setup; it's just that this new feature doesn=E2=80=99t wo=
rk
well with the existing settings, and updating those settings to
accommodate it isn't always feasible.

--=20
Regards
Yafang

