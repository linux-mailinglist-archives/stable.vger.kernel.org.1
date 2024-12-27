Return-Path: <stable+bounces-106184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9929FCF62
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 02:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456A33A045B
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 01:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD4C8DF;
	Fri, 27 Dec 2024 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDSVxzky"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A40A926
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735261784; cv=none; b=DSAJvivIslKTvxN/Td9xoviWpzAczIj9vTkOooG2QQBiTLn8lbiLOuwqSGH43x18jXoZgn+lPTI8HSjAIrGjO2B1S/oI5PJAosdFd5Zx3Pgszk9klUpu73kYbdTSbaVdFKtySNioojBO90NywO+gox9pIR27rwSepbkayCa3erc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735261784; c=relaxed/simple;
	bh=swQ9ngaFA5dn2ay1qZzIYolYzLe4uFpVPg1wIr9CI98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opzNmCD46XwfEvWkpERc+9zLj2aniluOS6EwHqzIrGQLkvlLB1yoUQA6muLE/9wM6+v15UmNnMUdU9UVC2//PmYJwS9bosq54NpgtPQ3VlgqsjZqu/U0aHKa6SiF8hexlLRVsgP4eQGB3aoQOWQ/sZU2J8BcvBsaWl2bAgUQdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDSVxzky; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467896541e1so1730111cf.0
        for <stable@vger.kernel.org>; Thu, 26 Dec 2024 17:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735261781; x=1735866581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E6wt8HlxBnw3ET83ugW/EugxKxuLhdbTQuA3jyOBfI=;
        b=DDSVxzkyxc0exmHmEeeFXasRzxVVbZap0T8R4u6nMyQhupYegY0GHwoheSi6ItBEPb
         jSzSzzeu2NYWrwsVJN255pSorKkXt9ZEPaZ0Zivh68MGOzN2M9gjFkDsMvACfH+M7C/z
         As2gOVzeaYgYat+czH1Gah0O+JyGmxODDXK8HL+f9uhm3eCmxjJMgJxbid2kLvrPmGbz
         NnEfh4u3W0cN/mMd6urtKtmRqmdjReGZi/AYlX9b77NpqzPpLgtv9bh79C7UD1WfMSOK
         K2Htb18Uk9lGMUu/CuB9bGZt1FOd+2svA3v3GNHSVU2wfVYFhFle5PrVZXlhyhlfc58d
         LjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735261781; x=1735866581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E6wt8HlxBnw3ET83ugW/EugxKxuLhdbTQuA3jyOBfI=;
        b=ipQ4G1d1Jqfe22alujctF5adgOTbetPZ2Tw2Txu9FhhWaIyeyrqQL+VUUW5lonZ2R0
         MKAA+J3U2H4zc62PZP0mm1vPgZNOFpQS/3qNRY+tdO2aL/3ZCKayXpOG3zb1BtZZ904j
         y4inQgmFlpkCmAwNjPYzecQ5mJvsIkyyqOlyDPvgKi6M7SHTANew3uDsoj6NabAS6pin
         Zb+81tzdN25qUIe77FobU8tNOt2mrNyFnLuC8Hc5M1Vmicfu1OXFVhRUrEZDwQF3uGbm
         hLuB61m1XJ8tCjD7+N0UlbxDDPbx+60vT10Rhdz3znfcGqosAieFfM0F7j36WKzRz3q3
         rI4A==
X-Forwarded-Encrypted: i=1; AJvYcCUnpthnHGShBX6TY111wJ6Z4RBoDU1bl93ZYf7W2TNNJjTBuO9yk++flEx4B28L1jTwOHcY3OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieRpVgvWVSEgafbF7/kPFHR8JuIqHdIjfD8kznxdmy9Ee9jaa
	7T3eBXNFuY8UibgThq4Cyj6hQkjyfuJ8Zk6IXm8EZqjokcR7nyX/zy0MgPU3EwhW544dkf7N09b
	Oyfq59p+d0pqMpjW8AZEdmAK+xGxPtVBGjLF2
X-Gm-Gg: ASbGncvmVGwABB/uPiH3CmtFueyVsHLlRYkymY1Zy28SCoMT0r+51mDgIW+2Mz3Hvln
	T3yAegFg2bQ1yKePrFqItYFN63+2ujCREAhbp9g==
X-Google-Smtp-Source: AGHT+IE2P9e8pBJfKJwgnh0PKZYfZDFnVOksblA6iIK6nqQgmKa21JPhsZf5iRj8Ha0+nGuwGqdNyxewdmEvA340cs4=
X-Received: by 2002:ac8:5992:0:b0:466:91fd:74c4 with SMTP id
 d75a77b69052e-46a4a6c3802mr19103811cf.0.1735261781453; Thu, 26 Dec 2024
 17:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226211639.1357704-1-surenb@google.com> <zvihgtiazhc7rgvikplfy342bqejfnsskv6avhqtbzwufwijsd@g7azxbtjl7ud>
 <CAJuCfpGbkp0OPucDLc9bvRZ_SztY0U4DOgAAdfWiTRM7BwCd8w@mail.gmail.com>
In-Reply-To: <CAJuCfpGbkp0OPucDLc9bvRZ_SztY0U4DOgAAdfWiTRM7BwCd8w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Dec 2024 17:09:30 -0800
Message-ID: <CAJuCfpGfSk5_o3ASp3VhmXL1=zRW1krx-6TBdSS83ThDMws+wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] alloc_tag: avoid current->alloc_tag manipulations
 when profiling is disabled
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 5:07=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Dec 26, 2024 at 4:43=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Dec 26, 2024 at 01:16:38PM -0800, Suren Baghdasaryan wrote:
> > > When memory allocation profiling is disabled there is no need to upda=
te
> > > current->alloc_tag and these manipulations add unnecessary overhead. =
Fix
> > > the overhead by skipping these extra updates.
> >
> > I did it the other way because I was concerned about the overhead of
> > adding a huge number of static keys. But on further thought a static ke=
y
> > probably isn't any bigger than an alloc tag, no?
>
> Hmm but a call

Sorry, I pressed enter before finishing typing.

Is a call to static_branch_maybe() generate a new static key? I
thought mem_alloc_profiling_key would be used everywhere but maybe I'm
missing something?

>
> >
> > >
> > > Fixes: b951aaff5035 ("mm: enable page allocation tagging")
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  include/linux/alloc_tag.h | 11 ++++++++---
> > >  lib/alloc_tag.c           |  2 ++
> > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > > index 0bbbe537c5f9..a946e0203e6d 100644
> > > --- a/include/linux/alloc_tag.h
> > > +++ b/include/linux/alloc_tag.h
> > > @@ -224,9 +224,14 @@ static inline void alloc_tag_sub(union codetag_r=
ef *ref, size_t bytes) {}
> > >
> > >  #define alloc_hooks_tag(_tag, _do_alloc)                            =
 \
> > >  ({                                                                  =
 \
> > > -     struct alloc_tag * __maybe_unused _old =3D alloc_tag_save(_tag)=
;  \
> > > -     typeof(_do_alloc) _res =3D _do_alloc;                          =
   \
> > > -     alloc_tag_restore(_tag, _old);                                 =
 \
> > > +     typeof(_do_alloc) _res;                                        =
 \
> > > +     if (mem_alloc_profiling_enabled()) {                           =
 \
> > > +             struct alloc_tag * __maybe_unused _old;                =
 \
> > > +             _old =3D alloc_tag_save(_tag);                         =
   \
> > > +             _res =3D _do_alloc;                                    =
   \
> > > +             alloc_tag_restore(_tag, _old);                         =
 \
> > > +     } else                                                         =
 \
> > > +             _res =3D _do_alloc;                                    =
   \
> > >       _res;                                                          =
 \
> > >  })
> > >
> > > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > > index 7dcebf118a3e..4c373f444eb1 100644
> > > --- a/lib/alloc_tag.c
> > > +++ b/lib/alloc_tag.c
> > > @@ -29,6 +29,8 @@ EXPORT_SYMBOL(_shared_alloc_tag);
> > >
> > >  DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAUL=
T,
> > >                       mem_alloc_profiling_key);
> > > +EXPORT_SYMBOL(mem_alloc_profiling_key);
> > > +
> > >  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> > >
> > >  struct alloc_tag_kernel_section kernel_tags =3D { NULL, 0 };
> > >
> > > base-commit: 431614f1580a03c1a653340c55ea76bd12a9403f
> > > --
> > > 2.47.1.613.gc27f4b7a9f-goog
> > >

