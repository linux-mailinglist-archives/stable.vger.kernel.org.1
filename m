Return-Path: <stable+bounces-6406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3610280E487
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 07:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06C2282E20
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 06:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA0A16420;
	Tue, 12 Dec 2023 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go3FEHfw"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF4EB;
	Mon, 11 Dec 2023 22:52:28 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f62fca3bso68237391fa.0;
        Mon, 11 Dec 2023 22:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702363946; x=1702968746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZo4NVf3AF8ZGR5m2uxx660ix6ln6qBZxuQ/HFN1wu4=;
        b=go3FEHfwVzBXMoHpXV2jW0ygF+sPerDz4tSDrePz0dKZeCbxfyZs/AqznJy58CYOIB
         MoPxqoxMRI4VdYNNU6cqj+EkWMdfdS/Lvol/hUhU5RUUx8nIGcDLUWAv/ZVN3Xz2nMWA
         SD3E6gTEwn7p4PR7fZNcSw+zmlucQUb3d2zztPE3tv2mejhr75xTH9R+WIFCdBaKUaEP
         oWDLxw96aiq9CGQSsL4+rSkPXi1IEfcj4vQDs4eQtYAY2ptAwYnBvVTL8toqFjw6f24c
         lt8sSZOyOHkEAxrPvY446HBxya58cMSpgJ7aU06IVlwR0YmKI6BSfCKo/jTvGTIt5L6i
         F1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702363946; x=1702968746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZo4NVf3AF8ZGR5m2uxx660ix6ln6qBZxuQ/HFN1wu4=;
        b=sOVTA31ua1nBWBWxygWHOTlEFkuwuI28RUp7lMADePNwH+uEg5/rUl6Qo0LdtJkVFN
         gG/u0BydOg9xUt81Uay1OfllgA4SuU6zRLyL6U/TH9y/H8qnaB72WaaF3kIFWWZjL+J+
         ABI9+wi7aqgHXB2UfRmVfHGUWVu+1cFpArthEfOSyAlGW4B8R9XIulSnTysZUH0AmlAR
         HuFuFt6xuQtybOc8pAAQTdbA7neS3GkxjsqQyTM9leAp046svHSWiteIINn2jcT2O1xe
         UZT2aXQxQYjWb2TuEwdaXkhAcNgj0J6AqvgXC0XqoT5FsYqlCw0C1rtlHxDU9xAWxyK6
         7KOw==
X-Gm-Message-State: AOJu0Yy1z4cnAcz7i2UGnws/lGdQZmOeZEqnUSHijSed8Lw7ksfOSMLH
	o7cuLJ2tmc6apmtTeb6vYzNUfNR0AkpBR2Fgtyg=
X-Google-Smtp-Source: AGHT+IEgznlicpRXzIo7QVmC4FLAv0DjsNVfS/JO4zV5pX1iElneh0jEkEQOXzst71I9Sb2gALJ/tz4LSshn5I2XDiA=
X-Received: by 2002:a2e:bd03:0:b0:2cc:20bd:e3a8 with SMTP id
 n3-20020a2ebd03000000b002cc20bde3a8mr2673486ljq.59.1702363946191; Mon, 11 Dec
 2023 22:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
 <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
In-Reply-To: <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 12 Dec 2023 14:52:08 +0800
Message-ID: <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=888=E6=97=A5=
=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Unmapped folios accessed through file descriptors can be
> > > underprotected. Those folios are added to the oldest generation based
> > > on:
> > > 1. The fact that they are less costly to reclaim (no need to walk the
> > >    rmap and flush the TLB) and have less impact on performance (don't
> > >    cause major PFs and can be non-blocking if needed again).
> > > 2. The observation that they are likely to be single-use. E.g., for
> > >    client use cases like Android, its apps parse configuration files
> > >    and store the data in heap (anon); for server use cases like MySQL=
,
> > >    it reads from InnoDB files and holds the cached data for tables in
> > >    buffer pools (anon).
> > >
> > > However, the oldest generation can be very short lived, and if so, it
> > > doesn't provide the PID controller with enough time to respond to a
> > > surge of refaults. (Note that the PID controller uses weighted
> > > refaults and those from evicted generations only take a half of the
> > > whole weight.) In other words, for a short lived generation, the
> > > moving average smooths out the spike quickly.
> > >
> > > To fix the problem:
> > > 1. For folios that are already on LRU, if they can be beyond the
> > >    tracking range of tiers, i.e., five accesses through file
> > >    descriptors, move them to the second oldest generation to give the=
m
> > >    more time to age. (Note that tiers are used by the PID controller
> > >    to statistically determine whether folios accessed multiple times
> > >    through file descriptors are worth protecting.)
> > > 2. When adding unmapped folios to LRU, adjust the placement of them s=
o
> > >    that they are not too close to the tail. The effect of this is
> > >    similar to the above.
> > >
> > > On Android, launching 55 apps sequentially:
> > >                            Before     After      Change
> > >   workingset_refault_anon  25641024   25598972   0%
> > >   workingset_refault_file  115016834  106178438  -8%
> >
> > Hi Yu,
> >
> > Thanks you for your amazing works on MGLRU.
> >
> > I believe this is the similar issue I was trying to resolve previously:
> > https://lwn.net/Articles/945266/
> > The idea is to use refault distance to decide if the page should be
> > place in oldest generation or some other gen, which per my test,
> > worked very well, and we have been using refault distance for MGLRU in
> > multiple workloads.
> >
> > There are a few issues left in my previous RFC series, like anon pages
> > in MGLRU shouldn't be considered, I wanted to collect feedback or test
> > cases, but unfortunately it seems didn't get too much attention
> > upstream.
> >
> > I think both this patch and my previous series are for solving the
> > file pages underpertected issue, and I did a quick test using this
> > series, for mongodb test, refault distance seems still a better
> > solution (I'm not saying these two optimization are mutually exclusive
> > though, just they do have some conflicts in implementation and solving
> > similar problem):
> >
> > Previous result:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Execution Results after 905 seconds
> > ------------------------------------------------------------------
> >                   Executed        Time (=C2=B5s)       Rate
> >   STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
> > ------------------------------------------------------------------
> >   TOTAL           2542            27121571486.2   0.09 txn/s
> >
> > This patch:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Execution Results after 900 seconds
> > ------------------------------------------------------------------
> >                   Executed        Time (=C2=B5s)       Rate
> >   STOCK_LEVEL     1594            27061522574.4   0.06 txn/s
> > ------------------------------------------------------------------
> >   TOTAL           1594            27061522574.4   0.06 txn/s
> >
> > Unpatched version is always around ~500.
>
> Thanks for the test results!
>
> > I think there are a few points here:
> > - Refault distance make use of page shadow so it can better
> > distinguish evicted pages of different access pattern (re-access
> > distance).
> > - Throttled refault distance can help hold part of workingset when
> > memory is too small to hold the whole workingset.
> >
> > So maybe part of this patch and the bits of previous series can be
> > combined to work better on this issue, how do you think?
>
> I'll try to find some time this week to look at your RFC. It'd be a

Thanks!

> lot easier for me if you could share
> 1. your latest tree, preferably based on the mainline, and
> 2. your VM image containing the above test.

Sure, I'll update the RFC and try to provide an easier test reproducer.

