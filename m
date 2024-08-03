Return-Path: <stable+bounces-65333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BA0946B1F
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 22:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50011C20E62
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 20:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658FF28DBC;
	Sat,  3 Aug 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClUGQatn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F141755C;
	Sat,  3 Aug 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722715437; cv=none; b=GhFbfqCSrzjndySt7pj7CzNRhyuaJCENwbK4kw92Z7P/HqEMiEI5/E/MokMO8505SmSqQHXf/1EcxiFCMvtARB5kx/ZD3hkqdkvKcC/SW6Tc2Z04Uiad4wLq6ecTi5YfjNXv0uzp6TUgAWYu9XcsfJuCLivna1vyw7zg5k6lMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722715437; c=relaxed/simple;
	bh=nQh3rus4HLT2dZF2SWazOQH7o++PtxiVVzxR2pkeVyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg1kGFTUUxAuUesqZlqpiKr4a3fMoO17cH1HT8gpAB3pw3eeykQUULN+NEUFz3b/hCJn4Nrsl0U2Drp2CeGK3plZfNMg+QVtdTM6+uUpVVNvUoJtRUqZNkf9xr/r0Hv3cY3nBjwhencb59NU2QU5H5Kj2rErqsCgyxA6HB4lRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClUGQatn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f16d2f2b68so12735121fa.3;
        Sat, 03 Aug 2024 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722715433; x=1723320233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbFlmObUtEbhQx6rRjGzT9NcRqSMZAqWwo3sMuWT600=;
        b=ClUGQatnZGsIzYht8+prpv5SHlKvvG+j/5Fo0kdLbYynlH448Ewd1FDBHNB4oqAshl
         6x9pTG7I1M2Cq5tZ4ObJYOfIEdknL4BSBcNxrD0/6Dd5CfqA/rLfFV5w6FNzwLvHaPL3
         EzWNI3kKd5gHY78/xJTF7vVDkMAfahQ9jvsM6Le8weBakn0fRnNXJKltoPPURib73vIl
         oQXsGuaHajpI2blotXH4hphPc4hY0HqNw1Ad9YSi55pQYKSnFeICwlQQuNT5EgjQL9mX
         o5KggMzaxeNiCkFsaBkrJ4mbwX4fFtlbSFOhnwo3Z7HOBSqK/VVDTROCsG/z2igOrk3x
         MPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722715433; x=1723320233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbFlmObUtEbhQx6rRjGzT9NcRqSMZAqWwo3sMuWT600=;
        b=YSEdVGUwgmWwwkD47fUfjFw/etmX1R0/vTsBumBazts4rhIvBJ6xFazZ167EVv7pOW
         g3xZEQNwQM3D8Ew3ROZ2DZQfzVPKwPfKngnlHz/gR2/+DQCJvrmDMV/j7M/MnV/Yem/s
         N8tKX4wA9KOJ4C0aZfXn06QpEMUp8YNXiAcb00OO23dQEHp/Nnvhsgib0u8CHqnX4D3O
         XxyXhlHSOzkwuQ3uRDDC8JufbLR9qNF+hglULROBewZwu0GkCgwTo2fV7sKEx4R3/yoY
         ZqWsWspUaFNLn9+kkBrzIUm7ter9n7M5J0lnWKpr8VS9h1NsandTrStNxGi+pXfnwrYY
         OLHA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Vfzg/pB/r9HIR8ijyV0lS4ib6BZjG8tuvp3J0rQNfYKTTjG91AkKmAr4GrlJVsnf5Y5bPBmuVNWydD3RU7Yr3kF77ioF9QLVhgEO5bWrDSLrE6WqwxBaIfuryMeW+g6s8Xp9
X-Gm-Message-State: AOJu0YyBTmruVBkKG7YPmuuoLrwCraFAPwxBdtyXBpaxywt8vVVCVQ3i
	S+V9xee4XlxdAw2k9PvafQPHLgzOkvgRVI6TBbR2f8d7iIdsvw3UbMLLoeZr/5GgID690N7Et+I
	lBJK12VBCS3KTzBQGP8YCkVxNsvs=
X-Google-Smtp-Source: AGHT+IGPt7FFwRlIPDfsnpVBQUgOimqXQMMBsiyEKXCBYKM86ppNn5RJFmyX8JPKJllaSr8r5umuf7fnpWUoEgjltGo=
X-Received: by 2002:a2e:9cc9:0:b0:2ef:1c0f:a0f3 with SMTP id
 38308e7fff4ca-2f15aa88b76mr58267881fa.6.1722715432838; Sat, 03 Aug 2024
 13:03:52 -0700 (PDT)
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
In-Reply-To: <CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 4 Aug 2024 04:03:36 +0800
Message-ID: <CAMgjq7CLObfnEcPgrPSHtRw0RtTXLjiS=wjGnOT+xv1BhdCRHg@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Ge Yang <yangge1116@126.com>, Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 1:09=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
> On Sat, Aug 3, 2024 at 2:31=E2=80=AFAM Ge Yang <yangge1116@126.com> wrote=
:
> > =E5=9C=A8 2024/8/3 4:18, Chris Li =E5=86=99=E9=81=93:
> > > On Thu, Aug 1, 2024 at 6:56=E2=80=AFPM Ge Yang <yangge1116@126.com> w=
rote:
> > >>
> > >>
> > >>
> > >>>> I can't reproduce this problem, using tmpfs to compile linux.
> > >>>> Seems you limit the memory size used to compile linux, which leads=
 to
> > >>>> OOM. May I ask why the memory size is limited to 481280kB? Do I al=
so
> > >>>> need to limit the memory size to 481280kB to test?
> > >>>
> > >>> Yes, you need to limit the cgroup memory size to force the swap
> > >>> action. I am using memory.max =3D 470M.
> > >>>
> > >>> I believe other values e.g. 800M can trigger it as well. The reason=
 to
> > >>> limit the memory to cause the swap action.
> > >>> The goal is to intentionally overwhelm the memory load and let the
> > >>> swap system do its job. The 470M is chosen to cause a lot of swap
> > >>> action but not too high to cause OOM kills in normal kernels.
> > >>> In another word, high enough swap pressure but not too high to bust
> > >>> into OOM kill. e.g. I verify that, with your patch reverted, the
> > >>> mm-stable kernel can sustain this level of swap pressure (470M)
> > >>> without OOM kill.
> > >>>
> > >>> I borrowed the 470M magic value from Hugh and verified it works wit=
h
> > >>> my test system. Huge has a similar swab test up which is more
> > >>> complicated than mine. It is the inspiration of my swap stress test
> > >>> setup.
> > >>>
> > >>> FYI, I am using "make -j32" on a machine with 12 cores (24
> > >>> hyperthreading). My typical swap usage is about 3-5G. I set my
> > >>> swapfile size to about 20G.
> > >>> I am using zram or ssd as the swap backend.  Hope that helps you
> > >>> reproduce the problem.
> > >>>
> > >> Hi Chris,
> > >>
> > >> I try to construct the experiment according to your suggestions abov=
e.
> > >
> > > Hi Ge,
> > >
> > > Sorry to hear that you were not able to reproduce it.
> > >
> > >> High swap pressure can be triggered, but OOM can't be reproduced. Th=
e
> > >> specific steps are as follows:
> > >> root@ubuntu-server-2204:/home/yangge# cp workspace/linux/ /dev/shm/ =
-rf
> > >
> > > I use a slightly different way to setup the tmpfs:
> > >
> > > Here is section of my script:
> > >
> > >          if ! [ -d $tmpdir ]; then
> > >                  sudo mkdir -p $tmpdir
> > >                  sudo mount -t tmpfs -o size=3D100% nodev $tmpdir
> > >          fi
> > >
> > >          sudo mkdir -p $cgroup
> > >          sudo sh -c "echo $mem > $cgroup/memory.max" || echo setup
> > > memory.max error
> > >          sudo sh -c "echo 1 > $cgroup/memory.oom.group" || echo setup
> > > oom.group error
> > >
> > > Per run:
> > >
> > >         # $workdir is under $tmpdir
> > >          sudo rm -rf $workdir
> > >          mkdir -p $workdir
> > >          cd $workdir
> > >          echo "Extracting linux tree"
> > >          XZ_OPT=3D'-T0 -9 =E2=80=93memory=3D75%' tar xJf $linux_src |=
| die "xz
> > > extract failed"
> > >
> > >          sudo sh -c "echo $BASHPID > $cgroup/cgroup.procs"
> > >          echo "Cleaning linux tree, setup defconfig"
> > >          cd $workdir/linux
> > >          make -j$NR_TASK clean
> > >          make defconfig > /dev/null
> > >          echo Kernel compile run $i
> > >          /usr/bin/time -a -o $log make --silent -j$NR_TASK  || die "m=
ake failed"
> > > >
> >
> > Thanks.
> >
> > >> root@ubuntu-server-2204:/home/yangge# sync
> > >> root@ubuntu-server-2204:/home/yangge# echo 3 > /proc/sys/vm/drop_cac=
hes
> > >> root@ubuntu-server-2204:/home/yangge# cd /sys/fs/cgroup/
> > >> root@ubuntu-server-2204:/sys/fs/cgroup/# mkdir kernel-build
> > >> root@ubuntu-server-2204:/sys/fs/cgroup/# cd kernel-build
> > >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# echo 470M > mem=
ory.max
> > >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# echo $$ > cgrou=
p.procs
> > >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# cd /dev/shm/lin=
ux/
> > >> root@ubuntu-server-2204:/dev/shm/linux# make clean && make -j24
> > >
> > > I am using make -j 32.
> > >
> > > Your step should work.
> > >
> > > Did you enable MGLRU in your .config file? Mine did. I attached my
> > > config file here.
> > >
> >
> > The above test didn't enable MGLRU.
> >
> > When MGLRU is enabled, I can reproduce OOM very soon. The cause of
> > triggering OOM is being analyzed.

Hi Ge,

Just in case, maybe you can try to revert your patch and run the test
again? I'm also seeing OOM with MGLRU with this test, Active/Inactive
LRU is fine. But after reverting your patch, the OOM issue still
exists.

> I think this is one of the potential side effects -- Huge mentioned
> earlier about isolate_lru_folios():
> https://lore.kernel.org/linux-mm/503f0df7-91e8-07c1-c4a6-124cad9e65e7@goo=
gle.com/
>
> Try this:
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cfa839284b92..778bf5b7ef97 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4320,7 +4320,7 @@ static bool sort_folio(struct lruvec *lruvec,
> struct folio *folio, struct scan_c
>         }
>
>         /* ineligible */
> -       if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
> +       if (!folio_test_lru(folio) || zone > sc->reclaim_idx ||
> skip_cma(folio, sc)) {
>                 gen =3D folio_inc_gen(lruvec, folio, false);
>                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
>                 return true;

Hi Yu, I tested your patch, on my system, the OOM still exists (96
core and 256G RAM), test memcg is limited to 512M and 32 thread ().

And I found the OOM seems irrelevant to either your patch or Ge's
patch. (it may changed the OOM chance slight though)

After the very quick OOM (it failed to untar the linux source code),
checking lru_gen_full:
memcg    47 /build-kernel-tmpfs
 node     0
        442       1691      29405           0
                     0          0r          0e          0p         57r
       617e          0p
                     1          0r          0e          0p          0r
         4e          0p
                     2          0r          0e          0p          0r
         0e          0p
                     3          0r          0e          0p          0r
         0e          0p
                                0           0           0           0
         0           0
        443       1683      57748         832
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
        444       1670      30207         133
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
        445       1662          0           0
                     0          0R         34T          0          57R
       238T          0
                     1          0R          0T          0           0R
         0T          0
                     2          0R          0T          0           0R
         0T          0
                     3          0R          0T          0           0R
        81T          0
                            13807L        324O        867Y       2538N
        63F         18A

If I repeat the test many times, it may succeed by chance, but the
untar process is very slow and generates about 7000 generations.

But if I change the untar cmdline to:
python -c "import sys; sys.stdout.buffer.write(open('$linux_src',
mode=3D'rb').read())" | tar zx

Then the problem is gone, it can untar the file successfully and very fast.

This might be a different issue reported by Chris, I'm not sure.

