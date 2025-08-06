Return-Path: <stable+bounces-166736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F11FCB1CBDB
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06D6189CC33
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208828C2BE;
	Wed,  6 Aug 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4GljbNIW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344B1A0BFD
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504479; cv=none; b=afA8HdS/SALTPC+zFNW3gqwCAdQ8y13VXFV2op4O9bDeTBjU1ztp4P1E4ZbswgvuHQSisZnmM49Z4bLAsbDZEGZP2f8Coce0MR8BB1VnFWs9BGGfsGcNaWyILEZU27pTpX9+VMJmX+b6DPCcWO1kUY51KFRs3qUEOHhO1ihaG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504479; c=relaxed/simple;
	bh=cFY/TZITiKjs0JtJtbpXn41ElMFKN7hRg8VmUNXXoSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDGxaunpaCpHHUZLm44CUX/0ljpCzXb5j5jsUPhEPIpONBbG0rdOPb4heqN+bgmYq16QmJ8SdjrAmXs9PZWcc+QW4Rll/w1PlDxRTlgOaxa/zfBAuL6DURA1Xw0ki76JFvnp8Pf53E5Jt28MUpEEwJQfnVWH3a5PwEwd+0Koju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4GljbNIW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b099118fedso60191cf.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754504476; x=1755109276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpzHgd6TpTYvjXVHg7u1dC6rZFfWzZnJYbp9d0+ZhbI=;
        b=4GljbNIWjcMMECy15WHr8vTsA96/Mc+nOoKLLJFK2OuzNPIHWlA874E7Uhts8de0d2
         mESbJduA/Hr6oOurs57T5nc+RUOGAYetc9UZlzwSASYrWQOs1pK19HfqEQwkgICxESP7
         mzPwg0hC2tJ035LmiVWEWJNWCF55Jyn3fM16okk38DmxRmqf8k062xMdBAjQpfcG7Eme
         255ntBPb6lx6dHjIb79Q9K0ITGSjymndrImKS8Et0GRleSD6uXbKgFSzJY1hzsVmU9++
         gyvm6I1FlmRdNKWxx02ZxSR8W9wdi6slB6QWk6f4D9bSwsQ1n4ZjUaWavz9dn5sesis+
         7wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754504476; x=1755109276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpzHgd6TpTYvjXVHg7u1dC6rZFfWzZnJYbp9d0+ZhbI=;
        b=DBelU6OhMtcgwirdA5vFrH9lOIzeoE4Mfu57o9UQaGIJVe54+9R13wOQs09Xja7pFZ
         zE3fNoBQhVqC8Gf9XMfypzpeuvPiERmAESoWc1YPaMMYMW1V5gILOSRBopuXLNUMbnY8
         eO52qBM1uRJmLFo3qYU0ZSWGTaoI82rOele/c4kUZban7BpgfYd8sqoKDlq5ulJgByFM
         +I1E3KBRXxMdIWbz079eVESIDtc2vEmDTt7MDdRixbPJWF7vnhDxRrmhuKPyDgxs/R99
         xhVI7LLUgqkfa5OIDVR344qXqT2YedSn/AHJdjygCiYrf+rLxnGU6Sx5IT8ERhkPs4Ur
         4yNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL9HnKrrcyZ0YLtbKj1AIk67uxkgmx7zQfJEOGS//rzzzLDLlfKSNmIICEWSbfuH9j6WRBQgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZ99vO5RIA4/DTBaYn5sSEuJpBat98nI7wZh7Wjm0d4bUYMsh
	uHjZynftpRp6bwrhXN4hS0dZOwvab4gc3uM9odA8ab3sgkAeadWrGG9VbJdnWyTiTNME1IYF3DU
	VvSKELJ3JCJc7hOkdeC6g6/Q2XaBxWKFnMFQItAT2
X-Gm-Gg: ASbGncveHDQRfaM9CmYGKOwQhvlKyM3jJUecb6MmvYP8frGPXPuVWmzIYdQQGfYvPos
	IAGo76uPJH4wBj1KeVaSevHE0UwkN6drvzuNvuntSy41nxtPfW/AiEW77zw4it8DVega0uXxmnz
	rnBu8UnNqcLlb5FBFfZTE44hITIfUibhSPMc6IujZ85QFFYYZ1LcpWG3cTuOM/NP4FXFGNMgfyt
	zWgQw==
X-Google-Smtp-Source: AGHT+IF/oBk+1Kx6MOGQZ+KRXoereierCI6MIImjRBAfsMTewdOnZY01NCyaNvQxEiMf8qFgK2ouIA3X3qcui1fNVQI=
X-Received: by 2002:ac8:5742:0:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4b0a1abba87mr458871cf.6.1754504475631; Wed, 06 Aug 2025
 11:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806154015.769024-1-surenb@google.com> <aJOJI-YZ0TTxEzV9@x1.local>
 <CAJuCfpGGGJfnvzzdhOEwsXRWPm1nJoPcm2FcrYnkcJtc9W96gA@mail.gmail.com> <aJOaXPhFry_LTlfI@x1.local>
In-Reply-To: <aJOaXPhFry_LTlfI@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 11:21:04 -0700
X-Gm-Features: Ac12FXx7qPXyaQOngW6323VZjhzisIrfexf_bbuz5pNIpI6czJ1v3UXAemPUJ5o
Message-ID: <CAJuCfpF0RJ9w0STKFaFA7vLEA5_kEsebuowYWSVnK-=5J2wsPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:09=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 06, 2025 at 10:09:30AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Aug 6, 2025 at 9:56=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Wed, Aug 06, 2025 at 08:40:15AM -0700, Suren Baghdasaryan wrote:
> > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and =
it
> > >
> > > The migration entry can appear with/without ALLOW_SRC_HOLES, right?  =
Maybe
> > > drop this line?
> >
> > Yes, you are right. I'll update.
> >
> > >
> > > If we need another repost, the subject can further be tailored to men=
tion
> > > migration entry too rather than non-present.  IMHO that's clearer on
> > > explaining the issue this patch is fixing (e.g. a valid transhuge THP=
 can
> > > also have present bit cleared).
> > >
> > > > encounters a non-present PMD (migration entry), it proceeds with fo=
lio
> > > > access even though the folio is not present. Add the missing check =
and
> > >
> > > IMHO "... even though folio is not present" is pretty vague.  Maybe
> > > "... even though it's a swap entry"?  Fundamentally it's because of t=
he
> > > different layouts of normal THP v.s. a swap entry, hence pmd_folio() =
should
> > > not be used on top of swap entries.
> >
> > Well, technically a migration entry is a non_swap_entry(), so calling
> > migration entries "swap entries" is confusing to me. Any better
> > wording we can use or do you think that's ok?
>
> The more general definition of "swap entry" should follow what swp_entry_=
t
> is defined, where, for example, is_migration_entry() itself takes
> swp_entry_t as input.  So it should be fine, but I agree it's indeed
> confusing.
>
> If we want to make it clearer, IMHO we could rename non_swap_entry()
> instead to is_swapfile_entry() / is_real_swap_entry() / ... but that can =
be
> discussed separately.  Here, if we want to make it super accurate, we cou=
ld
> also use "swp_entry_t" instead of "swap entry", that'll be 100% accurate.

Ok, that I think is our best option. I'll post an update shortly.
Thanks!

>
> Thanks,
>
> --
> Peter Xu
>

