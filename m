Return-Path: <stable+bounces-65349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E473946E91
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 14:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718091C20B30
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C962B9D7;
	Sun,  4 Aug 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsJ2xJus"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B4368;
	Sun,  4 Aug 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774123; cv=none; b=fHz1jIDOzuJ5f0nNwCtgiYzGNQOjwgHLWBS8i+v+dekm93Q22V2OOae1ssBM0bO8ytgdJd2swyPBItByy2tEWHA7+dtTc9+KFksT2jpgm+dsjKub46dLuQbILoF/2iBzEJ/m1p9BqO6t1bf/dPO1rOJW9qDHrW2yZMqS9wb3o1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774123; c=relaxed/simple;
	bh=lC/fh6rXnVTj07nqs7MzHysyhacUyR06+6KtKgx081o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJgvFhe/ggwAKKY6g4pnXTq6yN3nD22IdpN+RRnwFhVAgi+rCLe6+cH+sFdzbuwwqwOqKlTx0ONHKZJfLzHrOdS3l/YqxoW6YHZt9QRR4P8Q57lOoUldWbkvCUgdDuiVfeEaDfWJfmcoeFLQp3lBofC4RB3Isa75E+VZ2Dz8sj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsJ2xJus; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f136e23229so82295321fa.1;
        Sun, 04 Aug 2024 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722774120; x=1723378920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsi1fL04R0DYy7XwEizcUQkYQtOH3HB8IADsN0w8GsA=;
        b=dsJ2xJusQpOcoDpK/dyfHIfettXTce8eiAhQVIZrfbUOGD0b65xMUx472GHo+bi2QW
         QHI4ZADWYC+Bpgz0zP786G6YJ8pZ9uZ1/2IBHWer5KxaJZjNeZlPLdn8b+o/tLXOU45Y
         VR7FsS20iHB6DXCIMVg34PfQkDfVeT/ApibPvH09lImdn86L97jhiInM9zip7/bfodxc
         PXyqSrMjUKmoT6dXNXSoeTYYpyQsspqjdO0OpG8d2czwY9ZzpqFqsNdkPWtJb4hoN2Yu
         FzxcnB+oFW7e3/UvUJ/cmQ5KxQm9rdv23w+knaObK8O8tiNmt2Wfdvl8uT1e29DU7fIe
         p1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722774120; x=1723378920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsi1fL04R0DYy7XwEizcUQkYQtOH3HB8IADsN0w8GsA=;
        b=XGOFoXhHXQhVgeaJhyPQbqSgPr/SI4K1xayQc2+6b7ZsK7G7Fz4bgJkg2Ukds0YqTS
         fht5Hcom//NydWIhhVrKXS0fG95tbO9tIWVXGTKpKA/D5cfp5Qw+UicpCLBLQ8TsFoyg
         yIgonkRbTeTfKgymIw1051asuzjfrsQn0FaVK+uuZdRt66QywDeX1Pz2Y2ZoTLVVz3uK
         EmI8y24aAyjXHRzwjf4A1QxtVaabEE/cGk9i2FODVdzExYFFYQE6Pv9Nc3mDLeFNppj3
         pLenJUqcIyZwpEyXd0d29BCIguJxHMdeZT1VpIu1D52YyBC+odsRAY7Sjw//JJpE9kWN
         b0tg==
X-Forwarded-Encrypted: i=1; AJvYcCU8veJby13IE8WdeWzoqWmHlLVderosjG+aKyIK0YvdRhyzIRmEdEIXPsn8kZAjOqgnD1WUSR28UYOamCNENBYd9zdiCb3l9DdLXsdaAXXHkRqy3OOe+mMdS0CqlP7RrS9HripK
X-Gm-Message-State: AOJu0YwBDPAyyYBL4BnDy3PPwmpWE8kvmq0GptQnm9Yp63qgRXu36+GD
	Q+JiALchKHv9kPs3/2cj+SUYm7ShsRpHWyhncF7AwByEpp+h7dv2KZrGfW433OtpUuJDzOgRB4Q
	PzW448Yu1doUC78IVGxFIuejvEI8=
X-Google-Smtp-Source: AGHT+IE+8xriYSRBJFDmZHpDtMTJPvlIHseBHdis+XTfdELhfULmeDSHiWi0nfKVonJLhiMm0+Hx3c2i3UK4Yidfh9E=
X-Received: by 2002:a2e:914b:0:b0:2ef:17ee:62b0 with SMTP id
 38308e7fff4ca-2f15aa8368bmr61733491fa.2.1722774119072; Sun, 04 Aug 2024
 05:21:59 -0700 (PDT)
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
In-Reply-To: <CAMgjq7CLObfnEcPgrPSHtRw0RtTXLjiS=wjGnOT+xv1BhdCRHg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 4 Aug 2024 20:21:42 +0800
Message-ID: <CAMgjq7DLGczt=_yWNe-CY=U8rW+RBrx+9VVi4AJU3HYr-BdLnQ@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Ge Yang <yangge1116@126.com>, Yu Zhao <yuzhao@google.com>, Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 4:03=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Sun, Aug 4, 2024 at 1:09=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
> > On Sat, Aug 3, 2024 at 2:31=E2=80=AFAM Ge Yang <yangge1116@126.com> wro=
te:
> > > =E5=9C=A8 2024/8/3 4:18, Chris Li =E5=86=99=E9=81=93:
> > > > On Thu, Aug 1, 2024 at 6:56=E2=80=AFPM Ge Yang <yangge1116@126.com>=
 wrote:
> > > >>
> > > >>
> > > >>
> > > >>>> I can't reproduce this problem, using tmpfs to compile linux.
> > > >>>> Seems you limit the memory size used to compile linux, which lea=
ds to
> > > >>>> OOM. May I ask why the memory size is limited to 481280kB? Do I =
also
> > > >>>> need to limit the memory size to 481280kB to test?
> > > >>>
> > > >>> Yes, you need to limit the cgroup memory size to force the swap
> > > >>> action. I am using memory.max =3D 470M.
> > > >>>
> > > >>> I believe other values e.g. 800M can trigger it as well. The reas=
on to
> > > >>> limit the memory to cause the swap action.
> > > >>> The goal is to intentionally overwhelm the memory load and let th=
e
> > > >>> swap system do its job. The 470M is chosen to cause a lot of swap
> > > >>> action but not too high to cause OOM kills in normal kernels.
> > > >>> In another word, high enough swap pressure but not too high to bu=
st
> > > >>> into OOM kill. e.g. I verify that, with your patch reverted, the
> > > >>> mm-stable kernel can sustain this level of swap pressure (470M)
> > > >>> without OOM kill.
> > > >>>
> > > >>> I borrowed the 470M magic value from Hugh and verified it works w=
ith
> > > >>> my test system. Huge has a similar swab test up which is more
> > > >>> complicated than mine. It is the inspiration of my swap stress te=
st
> > > >>> setup.
> > > >>>
> > > >>> FYI, I am using "make -j32" on a machine with 12 cores (24
> > > >>> hyperthreading). My typical swap usage is about 3-5G. I set my
> > > >>> swapfile size to about 20G.
> > > >>> I am using zram or ssd as the swap backend.  Hope that helps you
> > > >>> reproduce the problem.
> > > >>>
> > > >> Hi Chris,
> > > >>
> > > >> I try to construct the experiment according to your suggestions ab=
ove.
> > > >
> > > > Hi Ge,
> > > >
> > > > Sorry to hear that you were not able to reproduce it.
> > > >
> > > >> High swap pressure can be triggered, but OOM can't be reproduced. =
The
> > > >> specific steps are as follows:
> > > >> root@ubuntu-server-2204:/home/yangge# cp workspace/linux/ /dev/shm=
/ -rf
> > > >
> > > > I use a slightly different way to setup the tmpfs:
> > > >
> > > > Here is section of my script:
> > > >
> > > >          if ! [ -d $tmpdir ]; then
> > > >                  sudo mkdir -p $tmpdir
> > > >                  sudo mount -t tmpfs -o size=3D100% nodev $tmpdir
> > > >          fi
> > > >
> > > >          sudo mkdir -p $cgroup
> > > >          sudo sh -c "echo $mem > $cgroup/memory.max" || echo setup
> > > > memory.max error
> > > >          sudo sh -c "echo 1 > $cgroup/memory.oom.group" || echo set=
up
> > > > oom.group error
> > > >
> > > > Per run:
> > > >
> > > >         # $workdir is under $tmpdir
> > > >          sudo rm -rf $workdir
> > > >          mkdir -p $workdir
> > > >          cd $workdir
> > > >          echo "Extracting linux tree"
> > > >          XZ_OPT=3D'-T0 -9 =E2=80=93memory=3D75%' tar xJf $linux_src=
 || die "xz
> > > > extract failed"
> > > >
> > > >          sudo sh -c "echo $BASHPID > $cgroup/cgroup.procs"
> > > >          echo "Cleaning linux tree, setup defconfig"
> > > >          cd $workdir/linux
> > > >          make -j$NR_TASK clean
> > > >          make defconfig > /dev/null
> > > >          echo Kernel compile run $i
> > > >          /usr/bin/time -a -o $log make --silent -j$NR_TASK  || die =
"make failed"
> > > > >
> > >
> > > Thanks.
> > >
> > > >> root@ubuntu-server-2204:/home/yangge# sync
> > > >> root@ubuntu-server-2204:/home/yangge# echo 3 > /proc/sys/vm/drop_c=
aches
> > > >> root@ubuntu-server-2204:/home/yangge# cd /sys/fs/cgroup/
> > > >> root@ubuntu-server-2204:/sys/fs/cgroup/# mkdir kernel-build
> > > >> root@ubuntu-server-2204:/sys/fs/cgroup/# cd kernel-build
> > > >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# echo 470M > m=
emory.max
> > > >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# echo $$ > cgr=
oup.procs
> > > >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# cd /dev/shm/l=
inux/
> > > >> root@ubuntu-server-2204:/dev/shm/linux# make clean && make -j24
> > > >
> > > > I am using make -j 32.
> > > >
> > > > Your step should work.
> > > >
> > > > Did you enable MGLRU in your .config file? Mine did. I attached my
> > > > config file here.
> > > >
> > >
> > > The above test didn't enable MGLRU.
> > >
> > > When MGLRU is enabled, I can reproduce OOM very soon. The cause of
> > > triggering OOM is being analyzed.
>
> Hi Ge,
>
> Just in case, maybe you can try to revert your patch and run the test
> again? I'm also seeing OOM with MGLRU with this test, Active/Inactive
> LRU is fine. But after reverting your patch, the OOM issue still
> exists.
>
> > I think this is one of the potential side effects -- Huge mentioned
> > earlier about isolate_lru_folios():
> > https://lore.kernel.org/linux-mm/503f0df7-91e8-07c1-c4a6-124cad9e65e7@g=
oogle.com/
> >
> > Try this:
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index cfa839284b92..778bf5b7ef97 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4320,7 +4320,7 @@ static bool sort_folio(struct lruvec *lruvec,
> > struct folio *folio, struct scan_c
> >         }
> >
> >         /* ineligible */
> > -       if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
> > +       if (!folio_test_lru(folio) || zone > sc->reclaim_idx ||
> > skip_cma(folio, sc)) {
> >                 gen =3D folio_inc_gen(lruvec, folio, false);
> >                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][=
zone]);
> >                 return true;
>
> Hi Yu, I tested your patch, on my system, the OOM still exists (96
> core and 256G RAM), test memcg is limited to 512M and 32 thread ().
>
> And I found the OOM seems irrelevant to either your patch or Ge's
> patch. (it may changed the OOM chance slight though)
>
> After the very quick OOM (it failed to untar the linux source code),
> checking lru_gen_full:
> memcg    47 /build-kernel-tmpfs
>  node     0
>         442       1691      29405           0
>                      0          0r          0e          0p         57r
>        617e          0p
>                      1          0r          0e          0p          0r
>          4e          0p
>                      2          0r          0e          0p          0r
>          0e          0p
>                      3          0r          0e          0p          0r
>          0e          0p
>                                 0           0           0           0
>          0           0
>         443       1683      57748         832
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>         444       1670      30207         133
>                      0          0           0           0           0
>          0           0
>                      1          0           0           0           0
>          0           0
>                      2          0           0           0           0
>          0           0
>                      3          0           0           0           0
>          0           0
>                                 0           0           0           0
>          0           0
>         445       1662          0           0
>                      0          0R         34T          0          57R
>        238T          0
>                      1          0R          0T          0           0R
>          0T          0
>                      2          0R          0T          0           0R
>          0T          0
>                      3          0R          0T          0           0R
>         81T          0
>                             13807L        324O        867Y       2538N
>         63F         18A
>
> If I repeat the test many times, it may succeed by chance, but the
> untar process is very slow and generates about 7000 generations.
>
> But if I change the untar cmdline to:
> python -c "import sys; sys.stdout.buffer.write(open('$linux_src',
> mode=3D'rb').read())" | tar zx
>
> Then the problem is gone, it can untar the file successfully and very fas=
t.
>
> This might be a different issue reported by Chris, I'm not sure.

After more testing, I think these are two problems (note I changed the
memcg limit to 600m later so the compile test can run smoothly).

1. OOM during the untar progress (can be workarounded by the untar
cmdline I mentioned above).
2. OOM during the compile progress (this should be the one Chris encountere=
d).

Both 1 and 2 only exist for MGLRU.
1 can be workarounded using the cmdline I mentioned above.
2 is caused by Ge's patch, and 1 is not.

I can confirm Yu's patch fixed 2 on my system, but the 1 seems still a
problem, it's not related to this patch, maybe can be discussed
elsewhere.

