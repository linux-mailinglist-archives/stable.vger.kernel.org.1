Return-Path: <stable+bounces-76158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3587F979705
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 16:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC46A282453
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3B1C6F64;
	Sun, 15 Sep 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bl8B3+sb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F61C68A8
	for <stable@vger.kernel.org>; Sun, 15 Sep 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409533; cv=none; b=cDSIixNasTDoH41v1Qt7tu7gLDtiGJIXvwpauJRl5aKtJ3lzMi5wYO6NQbNrXZUXGsImPp4ORqkqpr+Fz6ZR3InRpggOa4BpHkB7nD2F2TouY0rtTZt/kzqOkPJq/BhRHSZRtibqaI8SMiDS0uxJn6rKH7L0rZ4oheuByYm5tSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409533; c=relaxed/simple;
	bh=r5zBW4jZUhZNWoMWeQalIZceyQXecUyHiGiXyQHzAs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFizKCsxK4VuIeTpOeEtWTNA/v12jm7IcsAazwZeNwqGaA2aBih+/Vv91UjuLVkmVutqZlNXGNW6XWY4u2kLXNFcgQ0/jpHp67NYjZ6LeWQ5QyXWS3ThDjSFduLr9d2t2snDoieNuk97SC2LcyJeAbNcIWHwTxbojOeWfHeRBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bl8B3+sb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c4d4f219so2313160f8f.1
        for <stable@vger.kernel.org>; Sun, 15 Sep 2024 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726409530; x=1727014330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yxz5nmGRzq4N/sr7E3GVipIykhiwk1dNJyYW68ELoro=;
        b=Bl8B3+sb90meq3NlhAtcvAzOzGjPzim9doMwgsMF2hElf/eGMKH5J68dATgQOcozOi
         spDqaL5skQpIBa91NON63BBjn8oHUogo0ZiDb568Z29cB+AyDC83ZoQNFUCiNgXjCHcF
         l/QXavsh4VBvnEBosFMsin7go17aoR0IN/t71dwzVOd2qjBrealxxN1522MNnGjeqnQZ
         C+YNsksXNtW3ya8H9KYDdHRPsQNveueoj2cX5k5gdvue1mkDNXuS5/TR2FW2lmCdENgn
         ayehZKTwg13OJdkGVOoD10DYtjnMJ0OFHEQCSIgeHHjgp72XoTuQaLiGbcxWAY4Bmes0
         sSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409530; x=1727014330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yxz5nmGRzq4N/sr7E3GVipIykhiwk1dNJyYW68ELoro=;
        b=PXQ4b8xveb78TQAY7R3I4QoKEJcCJS42OF2bMFXASSFVzCVD0FMhKSz5mHwprQGZ71
         Ys74J5anq+Rf93W7KwayoULIdF8zccOF/E9R2fbY2dV5yf01GZO/cWhMpf4CCkRsLoMX
         NfPa/GH16oyGZMKwxfssm4j4/nfneaL8Xbdf6s5zqUaCAZA30Z8YVi4s9DMK1Puk82x2
         kXrZyCJBn+e0Dk/a8kkDxprD6MV32Bu8qyXxE9sJuVVjSvUGPCm4Dj/e1lgqLW0FPSzZ
         fm1uoMVEsUCkkClu/dhE59Kl0QFQ99Kty7TXfjw+MlZxtlpD1PMtxnjdz6D8ZJ0cB98g
         N9nw==
X-Forwarded-Encrypted: i=1; AJvYcCVzH6WAo9XsgX2vMR2aaLK3oGV3xHJ53gwx0mNUUi2vnEHaIHt+9h19W7spjZ4KP3juF8i2BYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGo9yNZOpjo2+N0UWQz1nzW0ZWU9ByyXaEU+GYobGjPpZ2DwQ
	zVHYDH1v1QWjQec7M0mGoSrNfAmC92ez2q2nT5Uhol04If+15vrKq6+lzwh9Xb9FUl8et/6BfKk
	+vVgp6BXblDBZ3yMXPodPn8411kkZliYlX/tk
X-Google-Smtp-Source: AGHT+IFYx2WRh//19q1aLbfgfstbMz/qJ1WyjNFbXNIv7xjFUNkkC/3NbCERqsrU73d4amcIy29/C9nVSzXq8QueaWA=
X-Received: by 2002:adf:f6c6:0:b0:374:baf1:41cb with SMTP id
 ffacd0b85a97d-378c2cfedebmr6870954f8f.4.1726409529945; Sun, 15 Sep 2024
 07:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
 <ZuSIPIHn4gDLm4si@phenom.ffwll.local> <ZuUtFQ9zs6jJkasD@boqun-archlinux> <20240915144853.7f85568a.gary@garyguo.net>
In-Reply-To: <20240915144853.7f85568a.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 15 Sep 2024 16:11:57 +0200
Message-ID: <CAH5fLggoz5gdgOpEiXu7u9hPXjLLeSv9An6jaq0am0-dG7+ohw@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: fix incorrect Sync bounds for LockedBy
To: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 3:49=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Fri, 13 Sep 2024 23:28:37 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>
> > Hmm.. I think it makes more sense to make `access()` requires `where T:
> > Sync` instead of the current fix? I.e. I propose we do:
> >
> >       impl<T, U> LockedBy<T, U> {
> >           pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
> >           where T: Sync {
> >               ...
> >           }
> >       }
> >
> > The current fix in this patch disallows the case where a user has a
> > `Foo: !Sync`, but want to have multiple `&LockedBy<Foo, X>` in differen=
t
> > threads (they would use `access_mut()` to gain unique accesses), which
> > seems to me is a valid use case.
> >
> > The where-clause fix disallows the case where a user has a `Foo: !Sync`=
,
> > a `&LockedBy<Foo, X>` and a `&X`, and is trying to get a `&Foo` with
> > `access()`, this doesn't seems to be a common usage, but maybe I'm
> > missing something?
>
> +1 on this. Our `LockedBy` type only works with `Lock` -- which
> provides mutual exclusion rather than `RwLock`-like semantics, so I
> think it should be perfectly valid for people to want to use `LockedBy`
> for `Send + !Sync` types and only use `access_mut`. So placing `Sync`
> bound on `access` sounds better.

I will add the `where` bound to `access`.

> There's even a way to not requiring `Sync` bound at all, which is to
> ensure that the owner itself is a `!Sync` type:
>
>         impl<T, U> LockedBy<T, U> {
>             pub fn access<'a, B: Backend>(&'a self, owner: &'a Guard<U, B=
>) -> &'a T {
>                 ...
>             }
>         }
>
> Because there's no way for `Guard<U, B>` to be sent across threads, we
> can also deduce that all caller of `access` must be from a single
> thread and thus the `Sync` bound is unnecessary.

Isn't Guard Sync? Either way, it's inconvenient to make Guard part of
the interface. That prevents you from using it from within
`&self`/`&mut self` methods on the owner.

Alice

