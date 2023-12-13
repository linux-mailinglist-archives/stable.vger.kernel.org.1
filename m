Return-Path: <stable+bounces-6571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE22810BEB
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 09:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE064281578
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565561B298;
	Wed, 13 Dec 2023 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMG7ahS2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A77D0
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 23:59:53 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-425928c24easo243991cf.0
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 23:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702454392; x=1703059192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SCRsk8v2NeRoEP69IlZxtD0S6CzE5b/aKxi3o7os3s=;
        b=RMG7ahS2y5FimXrBwMrn5su+YdC85LbyRq3UhQuYeSGLNjMd+u8hjYpEjSrxPWVLnl
         g9Tb5+Rtm7J/Cwcp5R0bh06JD6cXyWYIxfldqWrW/nIhKxRND3UOShTOZb+P6SnRG3z8
         ml7K0s0pF8LJWijYT9LNBOzzw1HoHSkmI/VDIkv00Qq3eHc8D8uVzVHmmOlxGQoD08Ny
         5iGdMaelRwlvSX9ZqNcwT1cvN35VN+bR8bN+S1/VSRRP5ia+1KspZVdH8q6To3/kfa90
         Iu9BG+EhruHcEjK9ZNgbY3xssDUO+b3CV2qi3yvNQFeFSqqCRSxxHTriuULXX2dIi1HA
         SkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702454392; x=1703059192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SCRsk8v2NeRoEP69IlZxtD0S6CzE5b/aKxi3o7os3s=;
        b=nWBtP8ELYgCGnI+TzzWpqNPgeDLUV+GFq6zkrmJSMzjA9fbLaCRmATbGJBlx3/F3/m
         yLFMbp4EkJ3oxYtbW7TnOgHFy+0V3Ia0cPFRnsyBWZfxLJCGerZc739De/S53LkSPQyw
         e3ZnD2MQOdLtBtIkBs9aMMYAiNZqHMtD1XHtw8F9niJgl2WXptFcnRwq5ClEW7HM/W0f
         3V0KUapo67W3sdWJgePuQPkt7H6NOrqHM7qDq6IKXRj53EacDAYucYCtoc+58mZyS7po
         oOy3a+lbd1QlzbBLi6X+vqG1phraAZ+fLOlFoeA7TWd0EN+wRaOCBSM01adCEdlB+SoH
         PTdg==
X-Gm-Message-State: AOJu0YzcqlZ+OenAGM9eSTFDZ4cyB2V1zt+xpDnqsg4mVuHJZK3XHigi
	VRYLwdlzaAad3lHb6HtKgbM4FXTB4w7uDZEJJ/+Ohg==
X-Google-Smtp-Source: AGHT+IEpUfZumpmFkAwQhMzxID9arjyLxuQJmf93yVKOo9TY8C7lbVucG1fgltdFUHZLYcEy1F6UJMTjytiuxR7ltBE=
X-Received: by 2002:a05:622a:190c:b0:423:b6a1:2088 with SMTP id
 w12-20020a05622a190c00b00423b6a12088mr1307562qtc.5.1702454392208; Tue, 12 Dec
 2023 23:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
 <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
 <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com> <CAMgjq7CJ3hYHysyRfHzYU4hOYqhUOttxMYGtg0FxzM_wvvyhFA@mail.gmail.com>
In-Reply-To: <CAMgjq7CJ3hYHysyRfHzYU4hOYqhUOttxMYGtg0FxzM_wvvyhFA@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 13 Dec 2023 00:59:14 -0700
Message-ID: <CAOUHufa=ybd-EPos9DryLHYyhphN0P7qyV5NY3Pui0dfVSk9tQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> Kairui Song <ryncsn@gmail.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > > >
> > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Unmapped folios accessed through file descriptors can be
> > > > > underprotected. Those folios are added to the oldest generation b=
ased
> > > > > on:
> > > > > 1. The fact that they are less costly to reclaim (no need to walk=
 the
> > > > >    rmap and flush the TLB) and have less impact on performance (d=
on't
> > > > >    cause major PFs and can be non-blocking if needed again).
> > > > > 2. The observation that they are likely to be single-use. E.g., f=
or
> > > > >    client use cases like Android, its apps parse configuration fi=
les
> > > > >    and store the data in heap (anon); for server use cases like M=
ySQL,
> > > > >    it reads from InnoDB files and holds the cached data for table=
s in
> > > > >    buffer pools (anon).
> > > > >
> > > > > However, the oldest generation can be very short lived, and if so=
, it
> > > > > doesn't provide the PID controller with enough time to respond to=
 a
> > > > > surge of refaults. (Note that the PID controller uses weighted
> > > > > refaults and those from evicted generations only take a half of t=
he
> > > > > whole weight.) In other words, for a short lived generation, the
> > > > > moving average smooths out the spike quickly.
> > > > >
> > > > > To fix the problem:
> > > > > 1. For folios that are already on LRU, if they can be beyond the
> > > > >    tracking range of tiers, i.e., five accesses through file
> > > > >    descriptors, move them to the second oldest generation to give=
 them
> > > > >    more time to age. (Note that tiers are used by the PID control=
ler
> > > > >    to statistically determine whether folios accessed multiple ti=
mes
> > > > >    through file descriptors are worth protecting.)
> > > > > 2. When adding unmapped folios to LRU, adjust the placement of th=
em so
> > > > >    that they are not too close to the tail. The effect of this is
> > > > >    similar to the above.
> > > > >
> > > > > On Android, launching 55 apps sequentially:
> > > > >                            Before     After      Change
> > > > >   workingset_refault_anon  25641024   25598972   0%
> > > > >   workingset_refault_file  115016834  106178438  -8%
> > > >
> > > > Hi Yu,
> > > >
> > > > Thanks you for your amazing works on MGLRU.
> > > >
> > > > I believe this is the similar issue I was trying to resolve previou=
sly:
> > > > https://lwn.net/Articles/945266/
> > > > The idea is to use refault distance to decide if the page should be
> > > > place in oldest generation or some other gen, which per my test,
> > > > worked very well, and we have been using refault distance for MGLRU=
 in
> > > > multiple workloads.
> > > >
> > > > There are a few issues left in my previous RFC series, like anon pa=
ges
> > > > in MGLRU shouldn't be considered, I wanted to collect feedback or t=
est
> > > > cases, but unfortunately it seems didn't get too much attention
> > > > upstream.
> > > >
> > > > I think both this patch and my previous series are for solving the
> > > > file pages underpertected issue, and I did a quick test using this
> > > > series, for mongodb test, refault distance seems still a better
> > > > solution (I'm not saying these two optimization are mutually exclus=
ive
> > > > though, just they do have some conflicts in implementation and solv=
ing
> > > > similar problem):
> > > >
> > > > Previous result:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Execution Results after 905 seconds
> > > > ------------------------------------------------------------------
> > > >                   Executed        Time (=C2=B5s)       Rate
> > > >   STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
> > > > ------------------------------------------------------------------
> > > >   TOTAL           2542            27121571486.2   0.09 txn/s
> > > >
> > > > This patch:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > Execution Results after 900 seconds
> > > > ------------------------------------------------------------------
> > > >                   Executed        Time (=C2=B5s)       Rate
> > > >   STOCK_LEVEL     1594            27061522574.4   0.06 txn/s
> > > > ------------------------------------------------------------------
> > > >   TOTAL           1594            27061522574.4   0.06 txn/s
> > > >
> > > > Unpatched version is always around ~500.
> > >
> > > Thanks for the test results!
> > >
> > > > I think there are a few points here:
> > > > - Refault distance make use of page shadow so it can better
> > > > distinguish evicted pages of different access pattern (re-access
> > > > distance).
> > > > - Throttled refault distance can help hold part of workingset when
> > > > memory is too small to hold the whole workingset.
> > > >
> > > > So maybe part of this patch and the bits of previous series can be
> > > > combined to work better on this issue, how do you think?
> > >
> > > I'll try to find some time this week to look at your RFC. It'd be a
>
> Hi Yu,
>
> I'm working on V4 of the RFC now, which just update some comments, and
> skip anon page re-activation in refault path for mglru which was not
> very helpful, only some tiny adjustment.
> And I found it easier to test with fio, using following test script:
>
> #!/bin/bash
> swapoff -a
>
> modprobe brd rd_nr=3D1 rd_size=3D16777216
> mkfs.ext4 /dev/ram0
> mount /dev/ram0 /mnt
>
> mkdir -p /sys/fs/cgroup/benchmark
> cd /sys/fs/cgroup/benchmark
>
> echo 4G > memory.max
> echo $$ > cgroup.procs
> echo 3 > /proc/sys/vm/drop_caches
>
> fio -name=3Dmglru --numjobs=3D12 --directory=3D/mnt --size=3D1024m \
>           --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
>           --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D32 \
>           --rw=3Drandread --random_distribution=3Dzipf:0.5 --norandommap =
\
>           --time_based --ramp_time=3D5m --runtime=3D5m --group_reporting
>
> zipf:0.5 is used here to simulate a cached read with slight bias
> towards certain pages.
> Unpatched 6.7-rc4:
> Run status group 0 (all jobs):
>    READ: bw=3D6548MiB/s (6866MB/s), 6548MiB/s-6548MiB/s
> (6866MB/s-6866MB/s), io=3D1918GiB (2060GB), run=3D300001-300001msec
>
> Patched with RFC v4:
> Run status group 0 (all jobs):
>    READ: bw=3D7270MiB/s (7623MB/s), 7270MiB/s-7270MiB/s
> (7623MB/s-7623MB/s), io=3D2130GiB (2287GB), run=3D300001-300001msec
>
> Patched with this series:
> Run status group 0 (all jobs):
>    READ: bw=3D7098MiB/s (7442MB/s), 7098MiB/s-7098MiB/s
> (7442MB/s-7442MB/s), io=3D2079GiB (2233GB), run=3D300002-300002msec
>
> MGLRU off:
> Run status group 0 (all jobs):
>    READ: bw=3D6525MiB/s (6842MB/s), 6525MiB/s-6525MiB/s
> (6842MB/s-6842MB/s), io=3D1912GiB (2052GB), run=3D300002-300002msec
>
> - If I change zipf:0.5 to random:
> Unpatched 6.7-rc4:
> Patched with this series:
> Run status group 0 (all jobs):
>    READ: bw=3D5975MiB/s (6265MB/s), 5975MiB/s-5975MiB/s
> (6265MB/s-6265MB/s), io=3D1750GiB (1879GB), run=3D300002-300002msec
>
> Patched with RFC v4:
> Run status group 0 (all jobs):
>    READ: bw=3D5987MiB/s (6278MB/s), 5987MiB/s-5987MiB/s
> (6278MB/s-6278MB/s), io=3D1754GiB (1883GB), run=3D300001-300001msec
>
> Patched with this series:
> Run status group 0 (all jobs):
>    READ: bw=3D5839MiB/s (6123MB/s), 5839MiB/s-5839MiB/s
> (6123MB/s-6123MB/s), io=3D1711GiB (1837GB), run=3D300001-300001msec
>
> MGLRU off:
> Run status group 0 (all jobs):
>    READ: bw=3D5689MiB/s (5965MB/s), 5689MiB/s-5689MiB/s
> (5965MB/s-5965MB/s), io=3D1667GiB (1790GB), run=3D300003-300003msec
>
> fio uses ramdisk so LRU accuracy will have smaller impact. The Mongodb
> test I provided before uses a SATA SSD so it will have a much higher
> impact. I'll provides a script to setup the test case and run it, it's
> more complex to setup than fio since involving setting up multiple
> replicas and auth and hundreds of GB of test fixtures, I'm currently
> occupied by some other tasks but will try best to send them out as
> soon as possible.

Thanks! Apparently your RFC did show better IOPS with both access
patterns, which was a surprise to me because it had higher refaults
and usually higher refautls result in worse performance.

So I'm still trying to figure out why it turned out the opposite. My
current guess is that:
1. It had a very small but stable inactive LRU list, which was able to
fit into the L3 cache entirely.
2. It counted few folios as workingset and therefore incurred less
overhead from CONFIG_PSI and/or CONFIG_TASK_DELAY_ACCT.

Did you save workingset_refault_file when you ran the test? If so, can
you check the difference between this series and your RFC?

