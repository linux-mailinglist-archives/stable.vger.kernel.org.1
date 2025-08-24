Return-Path: <stable+bounces-172767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782D1B33356
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 01:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476A5189DE3C
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890DD269D18;
	Sun, 24 Aug 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGqBgFi5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64D1D5CC9;
	Sun, 24 Aug 2025 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756079003; cv=none; b=PtvG2qvzOztdE0Lq2NK9gn5TVTyamaRmP2TfsH2EaqsL2T450OuLcH2gPq0dd3PgIxDvhhqgkv1NTeSZyNp3uxmVclHzoGI5LdkgxtuknwZZfJqRI0c7XCY6shK7F+qoJm50oTTD5BckO2Cs9snC9o0gztcUwM406yXzbCwAzsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756079003; c=relaxed/simple;
	bh=IBq9EZc6+dDD1HP0GSai2K0pWxBQyOkdsmXO30/lf2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZhiF7gtLlTv38OQl0+UZH8O6zvMdBGeM0ECb50+nqijyWYMH5VYWp1VhpB0aE7KCT/uk2sOK9h1M8ezKsDHXTWpf8wLoCkWNO0qgQmyZ5LlVvMLnu1WJVpSmIMtRTROjwZVH4tqQ2xIdI7EiEguwpFiVglhKoEsQDinQJLeEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGqBgFi5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso20333515e9.3;
        Sun, 24 Aug 2025 16:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756079000; x=1756683800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B9sOQcHZGWCingXfvCh9FZr+nr6lsPlBdBXw4dYQhw=;
        b=OGqBgFi514ZTorOzRzZ0ZPbIVOTzyEyKGBl0nbT+gIq+8dvLQFWlOHDtncRG5yMBl3
         9AR1jKyU1mjMDWo7urcV/xymfCBRztOxuHlAF2GWN3P9ipg2IwOF9xXgh4XXcI4vsxqV
         dYrhv3ofENPbufAYcNLdKZlZl5sCEVY1mv1jV8ykVrRwna5xmaILr6pv1ygkjyBPrSZv
         CZxHJdELDQjvcknrxWEF6Zzzab0lIADbp3B8dFZvwCM7Q+IjDm/NN+9pUovP2ULB15Nh
         xnmqnruEw9mFNv151BDuMyMK2Dz0BfZwUCJkM9CSJbiquuKHO42yhav+/Ak/uLkgBHTC
         d/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756079000; x=1756683800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+B9sOQcHZGWCingXfvCh9FZr+nr6lsPlBdBXw4dYQhw=;
        b=F0dOo6N5dsr2lEU8wvMYpsqGBVq+Y8EkBmKh9VDMMW0e0e/yYxf5qoegzSzjcgI4RQ
         x1no7AXRTZhjAQy2wKX6dKAeX9DfxLwleeVQ94EEad9uJgNxiOeBavVX3XXPkn/iv1EO
         gPNmvFRbE2v3vyGwnU36Vfy9IP4wuNmyZ3CitkeOa41HXsiRoj/pSMX5mYZPVq0BnDTe
         ylsTvrigZysgImt2yKKxTvpzaxH4ZkvP47cvmTKBq0hPgNOa/dxtk7fsVlUar4W+t7Vf
         8lbiSAlEuiW3Ms/Yml4lQuTF42raS7ERc2V0x/BkvDBXpw4YG0gXlwh7PmbBcaSOYoro
         iCFg==
X-Forwarded-Encrypted: i=1; AJvYcCV2XZzRS2WE7OzRljIoMWUoPFHQu2nItKtAsoJaXjdF+vS+bVN9g28J544eIqTUFZlRqTqkVRlX@vger.kernel.org, AJvYcCVsviI7CG2ZnYYfrQY6YRfs9MlUPmTK1qVGZgnzjay8jcvpupAqFBNKFRUAkQdnaxreXnX3tFESCbFoXGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaeQNsTHDY3RYXXJpzIuhPdYE3pv7e9Mo07sHNR9y4HtZGvVN
	NQMvh+To4m+ATb0/wLAlduoKlr0PFUduaOIdyigr61gDByMlhLvWFEktOc7XAjJxKW+Q5aZGUmS
	CZ3dNzFuyXEF1z5e7l/B1BoaKRcD1nrWa9JVkX8+86g==
X-Gm-Gg: ASbGncvTf0m2txO70LiTnYL6FtsdhhpgVCgh7EiHNDxOr/L/Gh5YAafaQ8Gguu5tj2Z
	XsldaTrRK9C6s8B8VYHcuhM52iEVfhaewfmTqX86QyD79YvlW6fJiUTCXoQ3gePJdLBWS2rFynI
	lhOdtiJuOvAe8GwKQd/OETz3hGoSjDPBBFTemChhFKD9eslSx4Erypszl0F217e/Qy3HmZROq9T
	6egCEKHN4xskUuQ1mrTgN+1LuOo2pnwQBZdl8gpD9FRurow2k9vUKGUISEtp1nWS6/2XulnsaAj
	nC/8ww==
X-Google-Smtp-Source: AGHT+IHG8+LzmBHQPlkNbiAM+nxvka89tnoNbrD8fD99XUN2AtcXD7uaHnfS5btqkSxaYHYlEHcyAzLCF/UdZPXlBSE=
X-Received: by 2002:a05:600c:1d28:b0:459:d709:e5c9 with SMTP id
 5b1f17b1804b1-45b517955a9mr98779065e9.6.1756078999495; Sun, 24 Aug 2025
 16:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041526.467434-1-CFSworks@gmail.com> <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
 <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com>
 <CAMj1kXF00Y0=67apXVbOC+rpbEEvyEovFYf4r_edr6mXjrj0+A@mail.gmail.com>
 <CAH5Ym4h+2w6aayzsVu__3qu3-6ETq1HK7u18yGzOrRqZ--2H9w@mail.gmail.com> <874itx14l5.wl-maz@kernel.org>
In-Reply-To: <874itx14l5.wl-maz@kernel.org>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 24 Aug 2025 16:43:08 -0700
X-Gm-Features: Ac12FXzpphFzjfC62UXFEc5AApowvpQZxz4HbijNMarXXS5OpHei395iBSb46eM
Message-ID: <CAH5Ym4iqvQuO6JxO-jypTp05Ug_2vDokCDoBgGB+cOzgmTQpkQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
To: Marc Zyngier <maz@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baruch Siach <baruch@tkos.co.il>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Marc! It's been a while; hope you're well.

On Sun, Aug 24, 2025 at 1:55=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Hi Sam,
>
> On Sun, 24 Aug 2025 04:05:05 +0100,
> Sam Edwards <cfsworks@gmail.com> wrote:
> >
> > On Sat, Aug 23, 2025 at 5:29=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
>
> [...]
>
> > > Under which conditions would PGD_SIZE assume a value greater than PAG=
E_SIZE?
> >
> > I might be doing my math wrong, but wouldn't 52-bit VA with 4K
> > granules and 5 levels result in this?
>
> No. 52bit VA at 4kB granule results in levels 0-3 each resolving 9
> bits, and level -1 resolving 4 bits. That's a total of 40 bits, plus
> the 12 bits coming directly from the VA making for the expected 52.

Thank you, that makes it clear: I made an off-by-one mistake in my
counting of the levels.

> > Each PTE represents 4K of virtual memory, so covers VA bits [11:0]
> > (this is level 3)
>
> That's where you got it wrong. The architecture is pretty clear that
> each level resolves PAGE_SHIFT-3 bits, hence the computation
> above. The bottom PAGE_SHIFT bits are directly extracted from the VA,
> without any translation.

Bear with me a moment while I unpack which part of that I got wrong:
A PTE is the terminal entry of the MMU walk, so I believe I'm correct
(in this example, and assuming no hugepages) that each PTE represents
4K of virtual memory: that means the final step of computing a PA
takes a (valid) PTE and the low 12 bits of the VA, then just adds
those bits to the physical frame address.
It sounds like what you're saying is "That isn't a *level* though:
that's just concatenation. A 'level' always takes a bitslice of the VA
and uses it as an index into a table of word-sized entries. PTEs don't
point to a further table: they have all of the final information
encoded directly."
That makes a lot more sense to me, but contradicts how I read this
comment from pgtable-hwdef.h:
 * Level 3 descriptor (PTE).
I took this as, "a PTE describes how to perform level 3 of the
translation." But because in fact there are no "levels" after a PTE,
it must actually be saying "Level 3 of the translation is a lookup
into an array of PTEs."? The problem with that latter reading is that
this comment...
 * Level -1 descriptor (PGD).
...when read the same way, is saying "Level -1 of the translation is a
lookup into an array of PGDs." An "array of PGDs" is nonsense, so I
reverted back to my earlier readings: "PGD describes how to do level
-1." and "PTE describes how to do level 3."

This smells like a classic "fencepost problem": The "PXX" Linuxisms
refer to the *nodes* along the MMU walk, while the "levels" in ARM
parlance are the actual steps of the walk taken by hardware -- edges,
not nodes, getting us from fencepost to fencepost. A fence with five
segments needs six posts, but we only have five currently.

So: where do the terms P4D, PUD, and PMD fit in here? And which one's
our missing fencepost?
PGD ----> ??? ----> ??? ----> ??? ----> ??? ----> PTE (|| low VA bits
=3D final PA)

> > > Note that at stage 1, arm64 does not support page table concatenation=
,
> > > and so the root page table is never larger than a page.
> >
> > Doesn't PGD_SIZE refer to the size used for userspace PGDs after the
> > boot progresses beyond stage 1? (What do you mean by "never" here?
> > "Under no circumstances is it larger than a page at stage 1"? Or
> > "during the entire lifecycle of the system, there is no time at which
> > it's larger than a page"?)
>
> Never, ever, is a S1 table bigger than a page. This concept doesn't
> exist in the architecture. Only S2 tables can use concatenation at the
> top-most level, for up to 16 pages (in order to skip a level when
> possible).
>
> The top-level can be smaller than a page, with some alignment
> constraints, but that's about the only degree of freedom you have for
> S1 page tables.

Okay, that clicked for me: I was reading "stage" in the context of the
boot process. These explanations make a lot more sense when reading
"stage" in the context of the MMU.

So PGD_SIZE <=3D PAGE_SIZE, the PAGE_SIZE spacing in vmlinux.lds.S is
for alignment, and I should be looking at cases where PGDs are assumed
to be PAGE_SIZE to make those consistent instead. Thanks!

Cheers,
Sam

>
> Thanks,
>
>         M.
>
> --
> Jazz isn't dead. It just smells funny.

