Return-Path: <stable+bounces-176807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D8B3DD10
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5220A189DBAC
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815BD2FF661;
	Mon,  1 Sep 2025 08:51:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01842FE59E;
	Mon,  1 Sep 2025 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716697; cv=none; b=Dbz6bLP5zFGSIvxYvNZhaeNIktxydLfBhzbz2pc93+KytM6nTdtG1gH4jOi6E7Di96TCUXEwT5Qp8zFV3IH/nWEJmxDPSEzfmFY5kMmqLJv+LTbY7osAc3TMxhkE2lro5C+kK503g4dbUqMe6Bmgphs/XdOpperl7EDtWMeemy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716697; c=relaxed/simple;
	bh=uSvK41FmgeQ8I6Z+IJZE9+asxAYJK58LDNCtRKIuCfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLsQOw91kO2Av0m8QN8+m4ZvYmZNUJJM/BlrnibQJ5znyRvoAD2W5g2I2onZYU9vjMOp2OUiTtogUWXLbeTSPsm72buwjDh4E6Gd/y3aocXzfTXoDHmYDiNL1D9rly/p+MtlWfTLKyg4O1lx9y5H4PVAa5FDVAguY2oHcILxDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8980d75995dso90406241.3;
        Mon, 01 Sep 2025 01:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716694; x=1757321494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WotrGx0bV1lkHS8mV0WZnLSC2eWHhyQWssws+EOHV0c=;
        b=p7SgahV7RoXT7A38WoD1vgnUmqAZERrnciNk7LyRKU1eTIoypOUvsgLEKvefVzqcKt
         ZmPhihBnA6GqSbgCN331Ho8T3yPMumFkhNQ2tMdZUdzzR9TFqFdWdKNPzocML1Ql2WzA
         UNhRpnAbcskO/OISk8Q0z/03PSNFZnpnlhl8NQ6q+BeyDb9YRCRB2FrqsCiP9NfsuZws
         sqfX01veiEbyy6Pm6NDwA3gH4lxz8ylf/FnB398FfabdHJwlq1MkZvcfwf6JuSMVbLTH
         nxhqhO1SmS4GqpmcM+iu2SpE4f8V2CFPTyPQIYA0w/Uvy84ZiakdceaIB3CW3k6N5QuE
         AJOg==
X-Forwarded-Encrypted: i=1; AJvYcCUgko+bJVnNSKf35gVkXWyM7AtcjMvo10iTMXpFckMdT9+Zgsl1Fgr73enfLyfVSDp1KLxK5xc/@vger.kernel.org, AJvYcCWzwnCPLgDHwIIilMr0RDGHB9LYVu8cuxfFa1cVBPs0C/g9dqrCkro/tJ6fd3LF/0zyQoj2q9JjCMY7SEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tLwG0oeqQsL/PGLxhMAjXlGf1B0NH8ArUTnWcfTFnrU3tVNW
	H2nvThcp6KjpLERYRQDY4MfbAKdZlON7/QIZnpqtg1/dpYA9fGrf6SpzZjXv80Ar
X-Gm-Gg: ASbGnctNdTQTCmkAmD4eBXPBH81XxiJmAExmcmA3mEFrqaVcUO2w+BkV9ALJcUp4y9g
	F/hq08bxDOxFBo2b9u4uBy2GNGtPu/5tdBirrrwacUIj9JrEqGxYX6pAmkC1FEWQ9E3LxEpyVfK
	S6w19QW4vc+YY6uHJkEi1xaKT62IVWwY/MEarByhP1+2n4j1Zx8YeZ0Traxag7/XA6N1JjaxJ3p
	dzGiqzunid8wPEz88ib33OCtHk00Wnfxr56ykv+4fmRkJCPoT5/v1TMTpPT8QfkTe1u1o60v1Gv
	aGnhwkrzaZ4w8vG6le4c/Jg+kapBc2WsGo3jf3+oqs29Augxf/ZIIOejR130AUs1Hax6dVRE6ue
	4azc2KRfTUBgcAIYsV5/iTwB1Lo0Ek2UtVYJiMj9V04Y+kx2L5UfrnNfZv1WrDjTgnrdeU9A=
X-Google-Smtp-Source: AGHT+IEXNgpFZ5qnf5jopxT/eEcLhmcSib3ubK5+GS3G45ed1p95enAA/RsXyaLeGTc0udPMq3rPKw==
X-Received: by 2002:a05:6102:1612:b0:522:2b10:7d07 with SMTP id ada2fe7eead31-52b1c14d255mr1629898137.30.1756716694155;
        Mon, 01 Sep 2025 01:51:34 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52aec3ae8ccsm3028925137.0.2025.09.01.01.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:51:33 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8980d75995dso90400241.3;
        Mon, 01 Sep 2025 01:51:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3Q+80U+kaFEQyVsU8pyJog9SdO8Tm+k79z3Q9A79U+wBMo68hlyXqPShLgRdZ9MoXnmFB3ZWU@vger.kernel.org, AJvYcCVc1RIk9BO6muUIlZZZTaP6ruKFxBi3cGYX0PzMBlxiXwHaoDugzI2Au+4CkFNds3oMc2msDF9WwOvKcEQ=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac9:b0:529:b446:1743 with SMTP id
 ada2fe7eead31-52b19a55edfmr2096555137.11.1756716693556; Mon, 01 Sep 2025
 01:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <1a5ce56a-d0d0-481e-b663-a7b176682a65@helsinkinet.fi>
In-Reply-To: <1a5ce56a-d0d0-481e-b663-a7b176682a65@helsinkinet.fi>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 10:51:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUKgMfL+1EnkZbbqNqTv4aMs_XWocXxq5jVGeOMaQXnDQ@mail.gmail.com>
X-Gm-Features: Ac12FXwMdMp9qNSuU3NsSHsJYJoBDJeG51xj4OtzBCmdyfOrJU-V6GtDcIUSO3U
Message-ID: <CAMuHMdUKgMfL+1EnkZbbqNqTv4aMs_XWocXxq5jVGeOMaQXnDQ@mail.gmail.com>
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
To: Eero Tamminen <oak@helsinkinet.fi>
Cc: Finn Thain <fthain@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lance Yang <lance.yang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Eero,

On Tue, 26 Aug 2025 at 17:22, Eero Tamminen <oak@helsinkinet.fi> wrote:
> On 25.8.2025 5.03, Finn Thain wrote:
> > Some recent commits incorrectly assumed the natural alignment of locks.
> > That assumption fails on Linux/m68k (and, interestingly, would have failed
> > on Linux/cris also). This leads to spurious warnings from the hang check
> > code. Fix this bug by adding the necessary 'aligned' attribute.
> [...]
> > Reported-by: Eero Tamminen <oak@helsinkinet.fi>
> > Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
> > Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > ---
> > I tested this on m68k using GCC and it fixed the problem for me. AFAIK,
> > the other architectures naturally align ints already so I'm expecting to
> > see no effect there.
>
> Yes, it fixes both of the issues (warnings & broken console):
>         Tested-by: Eero Tamminen <oak@helsinkinet.fi>
>
> (Emulated Atari Falcon) boot up performance with this is within normal
> variation.
>
> On 23.8.2025 10.49, Lance Yang wrote:
>  > Anyway, I've prepared two patches for discussion, either of which should
>  > fix the alignment issue :)
>  >
>  > Patch A[1] adjusts the runtime checks to handle unaligned pointers.
>  > Patch B[2] enforces 4-byte alignment on the core lock structures.
>  >
>  > Both tested on x86-64.
>  >
>  > [1]
> https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev
>  > [2] https://lore.kernel.org/lkml/20250823074048.92498-1-
>  > lance.yang@linux.dev
>
> Same goes for both of these, except that removing warnings makes minimal
> kernel boot 1-2% faster than 4-aligning the whole struct.

That is an interesting outcome! So the gain of naturally-aligning the
lock is more than offset by the increased cache pressure due to wasting
(a bit?) more memory.

Do you know what was the impact on total kernel size?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

