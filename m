Return-Path: <stable+bounces-65352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D357094704F
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 21:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27013B209D3
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69C12E1DB;
	Sun,  4 Aug 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYA6ZAeD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA902FB6
	for <stable@vger.kernel.org>; Sun,  4 Aug 2024 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722798678; cv=none; b=rBZ7CAZSNBjg/UwqYWvO/L/tBGzs/y3yDpyoZE60lLYMVMBuSFakU7j2j2eoq5b38C7jJ5se2i2fI3aR842UBnvNfBZWQKQkjfHIrkC084l1uV+xaaWz9zZQnzzyMB3+S3vSk9fEVturyBTxHl8B65nZHDmWeTlO14vICAdsc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722798678; c=relaxed/simple;
	bh=zCHyjwJy6TODD6BRPU486rpar5QR9t0oYZivvlXqf6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkXrhbhcIU4UUQKXwiEnx859im6swQB46gJR0yS/4jhPVYoGTA7V/QUcgidrpflD1yto6MNNtz+b0fYa2hwB4qZZf7/TrvM3EvXlwWrg9hOqwzx719KN/6G4atjmhyJAGOzfrN7ShGy+eXpPkkfc9DoBw1heKNN3m/fAGCdyCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYA6ZAeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC274C4AF10
	for <stable@vger.kernel.org>; Sun,  4 Aug 2024 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722798677;
	bh=zCHyjwJy6TODD6BRPU486rpar5QR9t0oYZivvlXqf6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sYA6ZAeDNC30bq5rf1X56xQQk+ZYwPbT8ktdv05OK9pKESGyH36UEGFG03wzNavou
	 EvQYPbcYpRQ9WNlRVHC0eRJ46AcP8f6QUb1WxGFZXwV4/5eRmYpSLNESEaVFEmnHTp
	 42dtW4V4HD8mb0C4zuIOEvMgtoT6cmbx4Dmwa/Tjwwm6U7o8oChh+x7AJLLL6MSMUh
	 H2TQsH6UmJZ27HBCUZhTzJIkzpfD5Ey034JU29kW9JQmwVTQrjMAARPa034kmEm0Y0
	 E5A0/hBBNBiJMwnkGnDcqrcQ9rhQX+hhgdgavzfl2wPm/XZb7kEgp27f2SyuBdsnEE
	 pPiSAA2KE5imA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-690af536546so8068057b3.3
        for <stable@vger.kernel.org>; Sun, 04 Aug 2024 12:11:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWf7IqNWixrEkso2OUudXSeBxGQtCuFFFeChtF3LQugHnKnSsmLrz71yvd96bt2Vo3dLojXi/fLK+e+5JkNIjv0Q2rgr5Qq
X-Gm-Message-State: AOJu0YxjuUhuUVbbBT1W8YIlUYxEYCxPBpx1/e3vSRpy6H8Qi3K605c2
	L1UAn14lltuL1XU8D5jRzRt+Ax+/CloGZeR4mkEmNG1BclrpRqXXbrfSS7wHBABUmcTIhcND3BC
	ytttPXTmXnQkspHDG8O0r5L/E6g8HxCeVBgoLrg==
X-Google-Smtp-Source: AGHT+IFdYqWYjZxjWfKoZc2K8ta1VmIOXPkbqU01TmEirMTITJ9Fd8Ev56SH9e8i/5wdnonsShVfMz4BN67kSDekIRw=
X-Received: by 2002:a0d:c981:0:b0:665:657d:9847 with SMTP id
 00721157ae682-6895f9e5f6bmr100332707b3.13.1722798676947; Sun, 04 Aug 2024
 12:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com>
 <0f9f7a2e-23c3-43fe-b5c1-dab3a7b31c2d@126.com> <CACePvbXU8K4wxECroEPr5T3iAsG6cCDLa12WmrvEBMskcNmOuQ@mail.gmail.com>
 <b5f5b215-fdf2-4287-96a9-230a87662194@126.com> <CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=pb_w51kucLKQ@mail.gmail.com>
 <00a27e2b-0fc2-4980-bc4e-b383f15d3ad9@126.com> <CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com>
 <CAMgjq7CLObfnEcPgrPSHtRw0RtTXLjiS=wjGnOT+xv1BhdCRHg@mail.gmail.com>
 <CAMgjq7DLGczt=_yWNe-CY=U8rW+RBrx+9VVi4AJU3HYr-BdLnQ@mail.gmail.com> <CACePvbXJKskfo-bd5jr2GfagaFDoYz__dbQTKmq2=rqOpJzqYQ@mail.gmail.com>
In-Reply-To: <CACePvbXJKskfo-bd5jr2GfagaFDoYz__dbQTKmq2=rqOpJzqYQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 4 Aug 2024 12:11:06 -0700
X-Gmail-Original-Message-ID: <CACePvbWTALuB7-jH5ZxCDAy_Dxeh70Y4=eYE5Mixr2qW+Z9sVA@mail.gmail.com>
Message-ID: <CACePvbWTALuB7-jH5ZxCDAy_Dxeh70Y4=eYE5Mixr2qW+Z9sVA@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Kairui Song <ryncsn@gmail.com>
Cc: Ge Yang <yangge1116@126.com>, Yu Zhao <yuzhao@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 10:51=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Sun, Aug 4, 2024 at 5:22=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > > Hi Yu, I tested your patch, on my system, the OOM still exists (96
> > > core and 256G RAM), test memcg is limited to 512M and 32 thread ().
> > >
> > > And I found the OOM seems irrelevant to either your patch or Ge's
> > > patch. (it may changed the OOM chance slight though)
> > >
> > > After the very quick OOM (it failed to untar the linux source code),
> > > checking lru_gen_full:
> > > memcg    47 /build-kernel-tmpfs
> > >  node     0
> > >         442       1691      29405           0
> > >                      0          0r          0e          0p         57=
r
> > >        617e          0p
> > >                      1          0r          0e          0p          0=
r
> > >          4e          0p
> > >                      2          0r          0e          0p          0=
r
> > >          0e          0p
> > >                      3          0r          0e          0p          0=
r
> > >          0e          0p
> > >                                 0           0           0           0
> > >          0           0
> > >         443       1683      57748         832
> > >                      0          0           0           0           0
> > >          0           0
> > >                      1          0           0           0           0
> > >          0           0
> > >                      2          0           0           0           0
> > >          0           0
> > >                      3          0           0           0           0
> > >          0           0
> > >                                 0           0           0           0
> > >          0           0
> > >         444       1670      30207         133
> > >                      0          0           0           0           0
> > >          0           0
> > >                      1          0           0           0           0
> > >          0           0
> > >                      2          0           0           0           0
> > >          0           0
> > >                      3          0           0           0           0
> > >          0           0
> > >                                 0           0           0           0
> > >          0           0
> > >         445       1662          0           0
> > >                      0          0R         34T          0          57=
R
> > >        238T          0
> > >                      1          0R          0T          0           0=
R
> > >          0T          0
> > >                      2          0R          0T          0           0=
R
> > >          0T          0
> > >                      3          0R          0T          0           0=
R
> > >         81T          0
> > >                             13807L        324O        867Y       2538=
N
> > >         63F         18A
> > >
> > > If I repeat the test many times, it may succeed by chance, but the
> > > untar process is very slow and generates about 7000 generations.
> > >
> > > But if I change the untar cmdline to:
> > > python -c "import sys; sys.stdout.buffer.write(open('$linux_src',
> > > mode=3D'rb').read())" | tar zx
> > >
> > > Then the problem is gone, it can untar the file successfully and very=
 fast.
> > >
> > > This might be a different issue reported by Chris, I'm not sure.
> >
> > After more testing, I think these are two problems (note I changed the
> > memcg limit to 600m later so the compile test can run smoothly).
> >
> > 1. OOM during the untar progress (can be workarounded by the untar
> > cmdline I mentioned above).
>
> There are two different issues here.
> My recent test script has moved the untar phase out of memcg limit
> (mostly I want to multithreading untar) so the bisect I did is only
> catch the second one.
> The untar issue might not be a regression from this patch.
>
> > 2. OOM during the compile progress (this should be the one Chris encoun=
tered).
> >
> > Both 1 and 2 only exist for MGLRU.
> > 1 can be workarounded using the cmdline I mentioned above.
> > 2 is caused by Ge's patch, and 1 is not.
> >
> > I can confirm Yu's patch fixed 2 on my system, but the 1 seems still a
> > problem, it's not related to this patch, maybe can be discussed
> > elsewhere.
>
> I will do a test run now with Yu's patch and report back.

Confirm Yu's patch fixes the regression for me. Now it can sustain
470M pressure without causing OOM kill.

Yu, please submit your patch.  This regression has merged into Linus'
tree already.

Feel free to add:

Tested-by: Chris Li <chrisl@kernel.org>

Chris

