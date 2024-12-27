Return-Path: <stable+bounces-106185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C206F9FCF7B
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 02:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C741883677
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 01:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFEE1C6A3;
	Fri, 27 Dec 2024 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJ+d51sj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B20C19A
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735264018; cv=none; b=n8NxkNh2P2WfrbUdt8lUVzkwuRvMwgZCG7agOuRvHLzr3vy3QnBDQYsXFglAUoUO5uADZYVvpBNm2n0d17Sun1Ck8rwLyiN0R9olMWdca0czd0vWSL13MRC6dcSnGMJUoS810DEN2lx+hLM9zPFYQV15Uaf3eT67j1801GRldf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735264018; c=relaxed/simple;
	bh=qAYv2JvKv86dQFCH6INzUnuwbcuvPJ0fpLg6s02B0xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKcfQXx+4SBL4/Fzozz3y06GU9LXb01Yufq+N7WPlOHDAlS+Z1lBwIuFkd338VixGKz7uqwKNBv1jSbvx+lZje5ZFDp2G53cQJhmqJzDNOQE7oJEohW9lBhsSuMRYN2T/6UGhwyfOH0uYgA+KZ04mG3H5PL7F/utxkLk9zLg2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJ+d51sj; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467abce2ef9so1785361cf.0
        for <stable@vger.kernel.org>; Thu, 26 Dec 2024 17:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735264015; x=1735868815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj958brXk80Kh7/Z6yVmIROdSN39RgeOriwd3YqENak=;
        b=ZJ+d51sj6uTeztsYI9i95sXFNjFnizO7ZlUZE/0s1M+q+WqjlN8Ll4pspdSHQzbKf7
         4USmh9zQjMOJpUzhEsY8imwdAQ2rPr2R0U/yjzgYb4SuTFKqtXFU4yI8GIwNLVXAP45h
         6ko7qnsRdzk0q3SbwKz26MOKNV8rwSCQqafkG46tguUrARndASiGlCqsSgnuP12YcTh7
         ywnHN5PtLw1gHOB6g3MIFj+Pl9k8ySjl9hldDswWCk/LRUxWCXtsm5bDGOr1ELGpTVRO
         tOji3i9yIY/8hj92jQ3IVhGOsSOYtrTJkzeIFHe0S93jo5chCi2N39UREv+4sQpGZ14P
         Z07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735264015; x=1735868815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj958brXk80Kh7/Z6yVmIROdSN39RgeOriwd3YqENak=;
        b=JWCfA1KmZi0UrtxXbtZU1EnTL5dalGRvy3rkibin8eM7DTAljqniqI3raoLMlDAEHV
         6OPBROUrf02SkCeD5Gcx9XGj1qTodI1svN0C4G1OBWf3K0OpTtvthwpl6VTvbJuLCJIf
         m0LRqiTHMuE0pY3mSIn15VhX64Aw2ijVy6yNmLFGVB+JF5w2bmKLbhSkdNHIeKw3LxXf
         9YpNG/vVfwJfvRbff1R3Keerz5+0i3p7SNDCGrRsrWcH+mr9XZKdZQWZMENorrfpNjEO
         bhKKhhuBEVUych0H7J9cmNgi2RlJiRMbWXryCUlSpGCu4ojzyAjOyvd4LjLko+4bCZPG
         JAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhke8MWcywJSFRbpnf1BhYTbkGpCvsvYp+jFOTBuin9V9MW1Na5bATNjXP1PZlcrCb2nvmarU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAdcOB0zHAYoOhs6kvN/WbpWefhR4qMeZsuK11wx+Ys6+UCLly
	FXLjORA4BRzXAm3fs2kQVovmgqHaPzpz6tGj2buFbPLFtzHAacl3rPjpdBejcV+gctDrfeG4LXV
	lFmJU9tTnV//xqwzC6MvCdarUkw0BCv6gaOhI
X-Gm-Gg: ASbGncuxztzRrOUGrK0pg4gE/2GlDFaZYENTrdqWPZiO5zN3PypmRPxQmVVJaTe89fN
	8xtddtAJ8bDBjObUfc+KB+qr0aLlqgRQYguKAPA==
X-Google-Smtp-Source: AGHT+IHlbssmCh7lXI2kFApHOjBqOWqRNYeWvudAvWhdof7w+w/uoBJgwpYzKVs99ZpFyli3p7UHaqd3xn+DlwZyE9Q=
X-Received: by 2002:ac8:5e51:0:b0:467:5fea:d4c4 with SMTP id
 d75a77b69052e-46a4c01caa7mr20125561cf.27.1735264015028; Thu, 26 Dec 2024
 17:46:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226211639.1357704-1-surenb@google.com> <zvihgtiazhc7rgvikplfy342bqejfnsskv6avhqtbzwufwijsd@g7azxbtjl7ud>
 <CAJuCfpGbkp0OPucDLc9bvRZ_SztY0U4DOgAAdfWiTRM7BwCd8w@mail.gmail.com> <CAJuCfpGfSk5_o3ASp3VhmXL1=zRW1krx-6TBdSS83ThDMws+wg@mail.gmail.com>
In-Reply-To: <CAJuCfpGfSk5_o3ASp3VhmXL1=zRW1krx-6TBdSS83ThDMws+wg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Dec 2024 17:46:43 -0800
Message-ID: <CAJuCfpHajHXkxiE1BL_C5XYiZRtK-S9mnTKMkqJxSnQhUL38KQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] alloc_tag: avoid current->alloc_tag manipulations
 when profiling is disabled
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 5:09=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Dec 26, 2024 at 5:07=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Dec 26, 2024 at 4:43=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Thu, Dec 26, 2024 at 01:16:38PM -0800, Suren Baghdasaryan wrote:
> > > > When memory allocation profiling is disabled there is no need to up=
date
> > > > current->alloc_tag and these manipulations add unnecessary overhead=
. Fix
> > > > the overhead by skipping these extra updates.
> > >
> > > I did it the other way because I was concerned about the overhead of
> > > adding a huge number of static keys. But on further thought a static =
key
> > > probably isn't any bigger than an alloc tag, no?
> >
> > Hmm but a call
>
> Sorry, I pressed enter before finishing typing.
>
> Is a call to static_branch_maybe() generate a new static key? I
> thought mem_alloc_profiling_key would be used everywhere but maybe I'm
> missing something?

Or maybe you meant the NoOp/Jump generated for a static_branch ?

>
> >
> > >
> > > >
> > > > Fixes: b951aaff5035 ("mm: enable page allocation tagging")
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  include/linux/alloc_tag.h | 11 ++++++++---
> > > >  lib/alloc_tag.c           |  2 ++
> > > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > > > index 0bbbe537c5f9..a946e0203e6d 100644
> > > > --- a/include/linux/alloc_tag.h
> > > > +++ b/include/linux/alloc_tag.h
> > > > @@ -224,9 +224,14 @@ static inline void alloc_tag_sub(union codetag=
_ref *ref, size_t bytes) {}
> > > >
> > > >  #define alloc_hooks_tag(_tag, _do_alloc)                          =
   \
> > > >  ({                                                                =
   \
> > > > -     struct alloc_tag * __maybe_unused _old =3D alloc_tag_save(_ta=
g);  \
> > > > -     typeof(_do_alloc) _res =3D _do_alloc;                        =
     \
> > > > -     alloc_tag_restore(_tag, _old);                               =
   \
> > > > +     typeof(_do_alloc) _res;                                      =
   \
> > > > +     if (mem_alloc_profiling_enabled()) {                         =
   \
> > > > +             struct alloc_tag * __maybe_unused _old;              =
   \
> > > > +             _old =3D alloc_tag_save(_tag);                       =
     \
> > > > +             _res =3D _do_alloc;                                  =
     \
> > > > +             alloc_tag_restore(_tag, _old);                       =
   \
> > > > +     } else                                                       =
   \
> > > > +             _res =3D _do_alloc;                                  =
     \
> > > >       _res;                                                        =
   \
> > > >  })
> > > >
> > > > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > > > index 7dcebf118a3e..4c373f444eb1 100644
> > > > --- a/lib/alloc_tag.c
> > > > +++ b/lib/alloc_tag.c
> > > > @@ -29,6 +29,8 @@ EXPORT_SYMBOL(_shared_alloc_tag);
> > > >
> > > >  DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFA=
ULT,
> > > >                       mem_alloc_profiling_key);
> > > > +EXPORT_SYMBOL(mem_alloc_profiling_key);
> > > > +
> > > >  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> > > >
> > > >  struct alloc_tag_kernel_section kernel_tags =3D { NULL, 0 };
> > > >
> > > > base-commit: 431614f1580a03c1a653340c55ea76bd12a9403f
> > > > --
> > > > 2.47.1.613.gc27f4b7a9f-goog
> > > >

