Return-Path: <stable+bounces-106183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7E69FCF60
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 02:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0641635F3
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 01:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060DB66E;
	Fri, 27 Dec 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kzv8u9BP"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFE4A0F
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735261644; cv=none; b=LRD00dFD4zvq1QH48wQ9iT4JWPDDc5Mlad7ht5ZJNxfchkbqoPK/oNgBNNldU8iFqgJ0hF51nsWlJAqds5J8CDy9Dic2ZRX54aKjWQVudaq3YInoT6J/1cwLD96v0qT6CeihFccufeVj/qHZSpTcL0WJvi7uvb3cHBD1V64Sjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735261644; c=relaxed/simple;
	bh=6CFg0cLUR4RSaLe5R5ciKAttacnqu/iLLZ51wfrFWkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHY1Z2i+BgvyCKbaQlhjQC1egwbLVPzQv1aPhSp+XhI5DjR1T8ZhoGJ4fj3vyyB3vyc7ZHi/oP9GME2H5TFIt0M7aXtn7+XEHX/x41F9rYAl5ODxCOXkOiHvqVwr4r10R2FqhKY95lYtu+dUCrmCws4RGo4H+dz+/fJRRRHOmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kzv8u9BP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4679b5c66d0so1684731cf.1
        for <stable@vger.kernel.org>; Thu, 26 Dec 2024 17:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735261642; x=1735866442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st3/bns3WYTDrd0GGEQPTUGbHFXt16zLAdKuDAnBvV8=;
        b=kzv8u9BPIguGgcbAJfWJA/0eeMWc3W4Vgh+fbBqlm/2/cx8ntws3sAS53kmb3CCXXg
         YC/SUnZSLB+V2TyM276Zc4FJTTqAXC/kARdZuBMoVotG3umxk+bsM8uJw8mMlrLikxQa
         qoX2Kpzv/NEx9lV1DBichmAZmJbzkBY4jZvD5HRLqJlZo+0ngnYC4q2AfapELl3e+8F3
         rbzHrSo+F6a4mlpeUJo2sVVPqAqGanSAN3bVl4fxxmJoBNZQXB+WwMy/5Pjq+GfyS8i0
         6jbEtOce0ymFW6pBLgELS4MDKQS8A8RG1G1rEENXnYtQW10IISE+JImicXCaxmAtfIlp
         MJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735261642; x=1735866442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st3/bns3WYTDrd0GGEQPTUGbHFXt16zLAdKuDAnBvV8=;
        b=cTpEt+4BniCeyC5q1OyF4gdF04i23fOJ0Uyhh6plzQ6NHdJCDL0XwjKr12DP0+5GEm
         /JHMAvdNdlhxC9xImyx0BNSGB310N2JQ6L9FN1nWvX2fZkQOcisvY9PjxHMMS4KYYH9Q
         7TkTQOj/u8a2w2eC+51JfmemF4KLREYRqqLLBiJM9EYkVgM19K/JudYrvZChUvKzx/Z7
         SKyY5GJFimPvgbTXfbo1ZysCvQZY+6t0rtl7+uA5t+Vo2MNDiscqWA8FQqcOC55mWI0/
         IwOxHzUOEbNcKx7cC7CvQH/hm5I/PxBY+p+vmHD0lKYh4qWOi0JwK5kGs800gGtq+xDS
         kEtg==
X-Forwarded-Encrypted: i=1; AJvYcCVm5vlcON5IWz9w5mId26oYF4u7wOr0Z6vCDKSmlFv5K4O5z9ZGbkMvvzoeKYMd1SW/o/580RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojX30SvXKbWNLXZhvLm5SlA2xwFJj6VIbtLUN6aG8AA7rPHP8
	LcSOaaZusMvDCOMcaTxXHZRS04wMM4PvpXRsGSTG4WFGR4hHSD2Ielc1oN6ShyfMHHDlLmB4mmK
	HioEGONAw4IWLhD59zP0RSelw1/cp+Ro6yQ4a
X-Gm-Gg: ASbGncvH1ZUtpwmwPEtzZoXC0KdiyJdKsCfdjQ/7vKLCvAgo+lrt5yG8hpnRUspsZeE
	v1bjMDuHznz885lc/0Grvf5XeLKYrbe7WD68PIQ==
X-Google-Smtp-Source: AGHT+IFuKDIpf2iayr88l8W8TD9fETDSZSKIHR0ROgVNCDFGcuGsDjkgjuuGUrrYMWn8pxC6Qy5h1DCbwmX+653/AnA=
X-Received: by 2002:a05:622a:130a:b0:466:975f:b219 with SMTP id
 d75a77b69052e-46a4a8d36b5mr19947121cf.8.1735261641820; Thu, 26 Dec 2024
 17:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226211639.1357704-1-surenb@google.com> <zvihgtiazhc7rgvikplfy342bqejfnsskv6avhqtbzwufwijsd@g7azxbtjl7ud>
In-Reply-To: <zvihgtiazhc7rgvikplfy342bqejfnsskv6avhqtbzwufwijsd@g7azxbtjl7ud>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Dec 2024 17:07:10 -0800
Message-ID: <CAJuCfpGbkp0OPucDLc9bvRZ_SztY0U4DOgAAdfWiTRM7BwCd8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] alloc_tag: avoid current->alloc_tag manipulations
 when profiling is disabled
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 4:43=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Dec 26, 2024 at 01:16:38PM -0800, Suren Baghdasaryan wrote:
> > When memory allocation profiling is disabled there is no need to update
> > current->alloc_tag and these manipulations add unnecessary overhead. Fi=
x
> > the overhead by skipping these extra updates.
>
> I did it the other way because I was concerned about the overhead of
> adding a huge number of static keys. But on further thought a static key
> probably isn't any bigger than an alloc tag, no?

Hmm but a call

>
> >
> > Fixes: b951aaff5035 ("mm: enable page allocation tagging")
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  include/linux/alloc_tag.h | 11 ++++++++---
> >  lib/alloc_tag.c           |  2 ++
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > index 0bbbe537c5f9..a946e0203e6d 100644
> > --- a/include/linux/alloc_tag.h
> > +++ b/include/linux/alloc_tag.h
> > @@ -224,9 +224,14 @@ static inline void alloc_tag_sub(union codetag_ref=
 *ref, size_t bytes) {}
> >
> >  #define alloc_hooks_tag(_tag, _do_alloc)                             \
> >  ({                                                                   \
> > -     struct alloc_tag * __maybe_unused _old =3D alloc_tag_save(_tag); =
 \
> > -     typeof(_do_alloc) _res =3D _do_alloc;                            =
 \
> > -     alloc_tag_restore(_tag, _old);                                  \
> > +     typeof(_do_alloc) _res;                                         \
> > +     if (mem_alloc_profiling_enabled()) {                            \
> > +             struct alloc_tag * __maybe_unused _old;                 \
> > +             _old =3D alloc_tag_save(_tag);                           =
 \
> > +             _res =3D _do_alloc;                                      =
 \
> > +             alloc_tag_restore(_tag, _old);                          \
> > +     } else                                                          \
> > +             _res =3D _do_alloc;                                      =
 \
> >       _res;                                                           \
> >  })
> >
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index 7dcebf118a3e..4c373f444eb1 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -29,6 +29,8 @@ EXPORT_SYMBOL(_shared_alloc_tag);
> >
> >  DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
> >                       mem_alloc_profiling_key);
> > +EXPORT_SYMBOL(mem_alloc_profiling_key);
> > +
> >  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> >
> >  struct alloc_tag_kernel_section kernel_tags =3D { NULL, 0 };
> >
> > base-commit: 431614f1580a03c1a653340c55ea76bd12a9403f
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >

