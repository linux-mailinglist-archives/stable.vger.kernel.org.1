Return-Path: <stable+bounces-179173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D0B50FD7
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BFA7A0F49
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFD53081C6;
	Wed, 10 Sep 2025 07:45:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599623C50F;
	Wed, 10 Sep 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490331; cv=none; b=Wf1hg3e3AqoUJe/57zKM6+ZQVagJg0WnirB0O3skCVXnf4j8MpjaWn6weTMVG1ul1QFL4+9MUsMOxAqc+D3RT1UbshOzCAYIl8Ugx1ooWJPkh8NyhBBPjc5cyFOg+lRYoRyEU2+iZS7Ar5E6aGZ4CoZTr/0nnUcTvJ86xCqp19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490331; c=relaxed/simple;
	bh=9UuXzhqtep4bvja/B6ExlTlasfLtdKs112q+8BCNMdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhUAMXLuZrVVNdBk1mLl/oinsfvaHYPPlI1aSf+yZtrGiv/hKreYqG2wnJV2/kDXm0B2m3BltFhR86n4JIwzoIKaBPkYbknY+cSEiyw/GlbMFrYPHJbGZEstgh5mb5sAO/FlOKsGeKVn1ILy4U9leesVXNz8eCy9/Hlm+vqQODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5300b29615cso4335280137.0;
        Wed, 10 Sep 2025 00:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757490328; x=1758095128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DubuMdJZ62j7dpAJW8CXKMHknQNz0VO1TEQG3tD98cw=;
        b=m46Bwgxqg3MOESgxSvcsZS+BXKrVnebdeiXyVAxPJlFEhcxaSZdv8KbA1csSD05kOy
         mozRaXtdzVXLvtzkLex3fG/vNWzVkGbSNiqcwIdxC3UH8CkZkwmjG1uDtG76L5Q1BnmK
         kyxoMsV83pT/0UHHqZZ/zwCD/9M4BrZRLljKoWOnyKa3itPMhNN7hBcXY27Z9oDRdW/q
         0SxPqKlkx7PpI6SmPStT6sUdb8UzNFLtn6osFyISIi1DMRra+e29UFK7XC65h86tKDj+
         TurmthnrBIz2Q4GavWUpth0ZZ7n9++ZzBlzHB3xJgG6guMEyO7vWi0gqwPfVqaQ2g1bj
         iS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyocl+aGnBnro9wzKau3D3k6Xsn1b59s3VXs59WwFWYs+/ml+wqsZkhe2ybq3XjM7JwJDmx5Qd@vger.kernel.org, AJvYcCXrRqOPbrqECDikD8AEudn7I7thk1tT2Bk+fMXoTjW2iqjerb6LtABUYWnMSkl15L20l2LIrX2Ien2q3IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkcySTtrO7CKy2CM0pPfFVg+uDiOFmLvPv+RYXFHxipjrlImpN
	2cCQBG2aynDatTyWuM48uJ8qwNT4FAqza24itAcxXiyk41OswHtkCA4KkXZQHPqq
X-Gm-Gg: ASbGncvPRHesG7axeYlsSkdgH0pwjM4qzajdLFiRUFF+9tMYcy3BAxOr4c4U4JojlsD
	PzPdO75aOywyZNxHs1w/39thNdftgJsZM9BXkrgGfvcebyAu6C76HsUhahcPHEzFF4hmxVWPL63
	nkxD41mHyKgA7vf7DUkr9woNzsuRLmqT1Da9e9P4y+Jfp8N/wmOjd/0VYIyFSfbDUYn/fxh23x0
	YMQrA8MjixH/5/CMWJmPrxpWktAmhUTp60ZNElOokdugTXaZjrDMIKtky3moKJ6xI4NjRoCPrQi
	8wRQvhFREjh45a7nIQKwONXK+TmWAR8qjEgBcbzLOo/XYLJaBDmafqeEAVzGDDTzyoQIPKI+hp/
	HHv90p02Rl1Xk66FHDLsFLzLsdmPBmuriYYoWqglZNbu07hg9S3SypK/DBxOCZnfo/l8sedT89z
	UoYZX3AA==
X-Google-Smtp-Source: AGHT+IEkCqUPiW6J3A7aM6rYbJ90qcoIa3o9rDg2o97Ge4/G+8DWmK3J80edmF16cBgLzcoGCxm4wg==
X-Received: by 2002:a05:6102:e07:b0:51c:4443:16e0 with SMTP id ada2fe7eead31-53d2490d54fmr5109579137.30.1757490327784;
        Wed, 10 Sep 2025 00:45:27 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52aef458ebasm12442747137.4.2025.09.10.00.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 00:45:26 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-52dd67b03c8so4591928137.2;
        Wed, 10 Sep 2025 00:45:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6/Ad7q7qy/yadbm2dQcQjrhCSFVqmOVte7hHU3RKRMhdzCb1g3LkooUhdVR/kgSvEXj109XT7Iwt88B0=@vger.kernel.org, AJvYcCWAscapUBFAAz4I+pXe633ld6q0fzJQiZ09DyNWUxPEv/PZcvw6fnkE47kEsU59ixDVQBEKel2o@vger.kernel.org
X-Received: by 2002:a05:6102:b11:b0:4e7:7787:1c2a with SMTP id
 ada2fe7eead31-53d231f9656mr5104922137.23.1757490326480; Wed, 10 Sep 2025
 00:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <875xdqsssz.fsf@igel.home>
 <d2942b1a5d338c35948933b0ccbf3e4f67e5fae2.camel@physik.fu-berlin.de>
In-Reply-To: <d2942b1a5d338c35948933b0ccbf3e4f67e5fae2.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Sep 2025 09:45:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwqqRiBJJwkPURkrEjbGbE1mY_NQ-hc56svzdOBOuBWw@mail.gmail.com>
X-Gm-Features: AS18NWBHwc8YE6Vdm_IGDbqHFO8ujroWnx8LY6VMHBDCK9GOp8Is_tBUl9ooEfc
Message-ID: <CAMuHMdWwqqRiBJJwkPURkrEjbGbE1mY_NQ-hc56svzdOBOuBWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock pointers
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Finn Thain <fthain@linux-m68k.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Lance Yang <lance.yang@linux.dev>, 
	akpm@linux-foundation.org, amaindex@outlook.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, ioworker0@gmail.com, joel.granados@kernel.org, 
	jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi, 
	peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, 
	tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Wed, 10 Sept 2025 at 09:39, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2025-09-10 at 08:52 +0200, Andreas Schwab wrote:
> > On Sep 10 2025, Finn Thain wrote:
> > > Linux is probably the only non-trivial program that could be feasibly
> > > rebuilt with -malign-int without ill effect (i.e. without breaking
> > > userland)
> >
> > No, you can't.  It would change the layout of basic user-level
> > structures, breaking the syscall ABI.
>
> Not if you rebuild the whole userspace as well.

Linux does not break the userspace ABI.

> FWIW, the Gentoo people already created a chroot with 32-bit alignmment:

That would be a different Linux architecture (m68k-32?).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

