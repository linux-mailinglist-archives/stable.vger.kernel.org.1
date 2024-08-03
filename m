Return-Path: <stable+bounces-65328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87003946A97
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059B11F2161A
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3012B64;
	Sat,  3 Aug 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nfnqOvG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444E14006
	for <stable@vger.kernel.org>; Sat,  3 Aug 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704980; cv=none; b=nKLNIzCuExb93PZacpI5bsD2I84DMxeovOf4cSG8IUbOT2w3f6/rUaQsJ+RLnzrDohqg0H5IvgmpfM9Lq0Zl60TfxUfGHAt/fw1DbIvR3FHPryTE0FTYwaMXijTUq5c+BvjBut7wrTiCx0XvPxtw95Ku8T9yH5Lc57U7dlxttHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704980; c=relaxed/simple;
	bh=WWbgVeE/Cg0KbJCdgM87SpDv9IR2A3JW26CZZpThANc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpIKdci6FLgDgGz0/Edu4QEWDo6B+Q1lgSB4/ynVJLFOAmUjoO+8XWGcOxy3z0b0L6Wv0T4nVnmb1SZ8gkT9kFJ3/ny5EA4wat4XPzBMVMvg8MFIITFqUdYxdHjAWTPzlbzFvONxip0ik5i6qGrHSlk3sd6GnC49aofk4uZ+pCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nfnqOvG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fee2bfd28so96021cf.1
        for <stable@vger.kernel.org>; Sat, 03 Aug 2024 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722704977; x=1723309777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJmgT6oTpLrEgwNYBG6iDU6/PwiyyeFSzdFO7EuJwL4=;
        b=0nfnqOvGSUNLlllJNlzpfwtIcjsFxbQxzdhFVjoUy52J4pCdOQRqt7+cElzyviiVs6
         gd0FFHnhsjM1aQaAht5x4gBjXWG/CKiqWptQW11Hljr4XzLYo9HwhLpS92OFrYE4VdBA
         9WO79ibxhs3Qfkdkg9mC9fVZE86Gm7VaGWvfqwPwc2whk9LcDZW3KZ6PsBFn4zx6jthQ
         BHGKmPOpy5ql9ZMhIl4mQ57nzjauChl1oC386MtVWAWCdrq4NhOemxHwunB1owxUvYYa
         hH8dUQXgWEepkX7Rqt0h+4Sn+rl5Xn8gPNBb9WSgB2a+rQLDILN4URGqFahEtXv4zVve
         gTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722704977; x=1723309777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJmgT6oTpLrEgwNYBG6iDU6/PwiyyeFSzdFO7EuJwL4=;
        b=OMkaJ+EE5aTw0GF947okcYbMC0xE9zbwkQH2mxoFSljUcoojMbfg1zwZp1SKHVa1Uk
         0V5RKVBCSOip4p7BYlDZVZJMTaEsG/2I98FcP4QObOhG5DmOCVAnxzLOEg23taaPbzSt
         HW+sxekCWkRPpfRjUa6vA95A5uqkW0w7qhsB/Bu5C995sWtLgNLmhFUI5Z4y0SVNesl/
         ibGm7hd/Sbi8I8IyJYZaJ/dmypsv6KzA72yF1hE94zf7n/eLD8H+bNmmyn/x233fswe2
         ql8ueGTGKihq1gHKO0otwZ9i/wgWQohv+OA3dFPQgVTopuBkN8U8qZjMMhkK0PqhrpW3
         goAA==
X-Forwarded-Encrypted: i=1; AJvYcCWJHvDuatnr4ztbx6JRThcIYCWZ5BfLBFUZoBMKlBw73vEiPWW1M/4RwYCOxhKz1C3D0R/NX9bTWUbbP0znBSz3ZK38vIfx
X-Gm-Message-State: AOJu0YzV2SUgEM/NEWh4uApvPYNC5RsJ9VfDo7V5ySj2efHnUwU6Jt8l
	LcvScsf/6rehO0Joi5pM0p9ioljI7y8p0ojQC8RK5dBj9iIOUNX2PwUbOVn0xbKahMDcivYMxD7
	BbkwstYuIgF1MLtjyRa9dohsur+pRMx7IgiJY
X-Google-Smtp-Source: AGHT+IF65CauaimP3NlXguEo+6ib8VGPl94a1Rq/hA9I/V2MtuTtcR15tRDCJOV1vVIreODcBjNKh0YrXFu5xHR3u2U=
X-Received: by 2002:a05:622a:591:b0:44f:ea7a:2119 with SMTP id
 d75a77b69052e-4519ae21848mr1632181cf.18.1722704977148; Sat, 03 Aug 2024
 10:09:37 -0700 (PDT)
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
 <00a27e2b-0fc2-4980-bc4e-b383f15d3ad9@126.com>
In-Reply-To: <00a27e2b-0fc2-4980-bc4e-b383f15d3ad9@126.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 3 Aug 2024 11:08:59 -0600
Message-ID: <CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Ge Yang <yangge1116@126.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org, Barry Song <21cnbao@gmail.com>, 
	David Hildenbrand <david@redhat.com>, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 2:31=E2=80=AFAM Ge Yang <yangge1116@126.com> wrote:
>
>
>
> =E5=9C=A8 2024/8/3 4:18, Chris Li =E5=86=99=E9=81=93:
> > On Thu, Aug 1, 2024 at 6:56=E2=80=AFPM Ge Yang <yangge1116@126.com> wro=
te:
> >>
> >>
> >>
> >>>> I can't reproduce this problem, using tmpfs to compile linux.
> >>>> Seems you limit the memory size used to compile linux, which leads t=
o
> >>>> OOM. May I ask why the memory size is limited to 481280kB? Do I also
> >>>> need to limit the memory size to 481280kB to test?
> >>>
> >>> Yes, you need to limit the cgroup memory size to force the swap
> >>> action. I am using memory.max =3D 470M.
> >>>
> >>> I believe other values e.g. 800M can trigger it as well. The reason t=
o
> >>> limit the memory to cause the swap action.
> >>> The goal is to intentionally overwhelm the memory load and let the
> >>> swap system do its job. The 470M is chosen to cause a lot of swap
> >>> action but not too high to cause OOM kills in normal kernels.
> >>> In another word, high enough swap pressure but not too high to bust
> >>> into OOM kill. e.g. I verify that, with your patch reverted, the
> >>> mm-stable kernel can sustain this level of swap pressure (470M)
> >>> without OOM kill.
> >>>
> >>> I borrowed the 470M magic value from Hugh and verified it works with
> >>> my test system. Huge has a similar swab test up which is more
> >>> complicated than mine. It is the inspiration of my swap stress test
> >>> setup.
> >>>
> >>> FYI, I am using "make -j32" on a machine with 12 cores (24
> >>> hyperthreading). My typical swap usage is about 3-5G. I set my
> >>> swapfile size to about 20G.
> >>> I am using zram or ssd as the swap backend.  Hope that helps you
> >>> reproduce the problem.
> >>>
> >> Hi Chris,
> >>
> >> I try to construct the experiment according to your suggestions above.
> >
> > Hi Ge,
> >
> > Sorry to hear that you were not able to reproduce it.
> >
> >> High swap pressure can be triggered, but OOM can't be reproduced. The
> >> specific steps are as follows:
> >> root@ubuntu-server-2204:/home/yangge# cp workspace/linux/ /dev/shm/ -r=
f
> >
> > I use a slightly different way to setup the tmpfs:
> >
> > Here is section of my script:
> >
> >          if ! [ -d $tmpdir ]; then
> >                  sudo mkdir -p $tmpdir
> >                  sudo mount -t tmpfs -o size=3D100% nodev $tmpdir
> >          fi
> >
> >          sudo mkdir -p $cgroup
> >          sudo sh -c "echo $mem > $cgroup/memory.max" || echo setup
> > memory.max error
> >          sudo sh -c "echo 1 > $cgroup/memory.oom.group" || echo setup
> > oom.group error
> >
> > Per run:
> >
> >         # $workdir is under $tmpdir
> >          sudo rm -rf $workdir
> >          mkdir -p $workdir
> >          cd $workdir
> >          echo "Extracting linux tree"
> >          XZ_OPT=3D'-T0 -9 =E2=80=93memory=3D75%' tar xJf $linux_src || =
die "xz
> > extract failed"
> >
> >          sudo sh -c "echo $BASHPID > $cgroup/cgroup.procs"
> >          echo "Cleaning linux tree, setup defconfig"
> >          cd $workdir/linux
> >          make -j$NR_TASK clean
> >          make defconfig > /dev/null
> >          echo Kernel compile run $i
> >          /usr/bin/time -a -o $log make --silent -j$NR_TASK  || die "mak=
e failed"
> > >
>
> Thanks.
>
> >> root@ubuntu-server-2204:/home/yangge# sync
> >> root@ubuntu-server-2204:/home/yangge# echo 3 > /proc/sys/vm/drop_cache=
s
> >> root@ubuntu-server-2204:/home/yangge# cd /sys/fs/cgroup/
> >> root@ubuntu-server-2204:/sys/fs/cgroup/# mkdir kernel-build
> >> root@ubuntu-server-2204:/sys/fs/cgroup/# cd kernel-build
> >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# echo 470M > memor=
y.max
> >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# echo $$ > cgroup.=
procs
> >> root@ubuntu-server-2204:/sys/fs/cgroup/kernel-build# cd /dev/shm/linux=
/
> >> root@ubuntu-server-2204:/dev/shm/linux# make clean && make -j24
> >
> > I am using make -j 32.
> >
> > Your step should work.
> >
> > Did you enable MGLRU in your .config file? Mine did. I attached my
> > config file here.
> >
>
> The above test didn't enable MGLRU.
>
> When MGLRU is enabled, I can reproduce OOM very soon. The cause of
> triggering OOM is being analyzed.

I think this is one of the potential side effects -- Huge mentioned
earlier about isolate_lru_folios():
https://lore.kernel.org/linux-mm/503f0df7-91e8-07c1-c4a6-124cad9e65e7@googl=
e.com/

Try this:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cfa839284b92..778bf5b7ef97 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4320,7 +4320,7 @@ static bool sort_folio(struct lruvec *lruvec,
struct folio *folio, struct scan_c
        }

        /* ineligible */
-       if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
+       if (!folio_test_lru(folio) || zone > sc->reclaim_idx ||
skip_cma(folio, sc)) {
                gen =3D folio_inc_gen(lruvec, folio, false);
                list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone=
]);
                return true;



> >> Please help to see which step does not meet your requirements.
> >
> > How many cores does your server have? I assume your RAM should be
> > plenty on that server.
> >
>
> My server has 64 cores (128 hyperthreading) and 160G of RAM.

