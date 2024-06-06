Return-Path: <stable+bounces-48274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F08FDFC9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 09:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4DF284B9B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A3013A89B;
	Thu,  6 Jun 2024 07:34:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59F1F5F5;
	Thu,  6 Jun 2024 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659272; cv=none; b=PSG8SraSqidSUpOGy90c6QMPgU0B1ts50c6zO9VqbnGtcMM9IrKeVUtpq3q75A6IS4nmHWOHqYAh1DR2pPXncm9Kvk+X41ZsfskQ8MaoVY2JGr1NLRCWV+FXQnbV3qIV4RftpxUbqfcGa8X3gYOcC6oba6aAylMKOG3L6WSp3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659272; c=relaxed/simple;
	bh=ClQsc8q9HrRkQiRCQ2nOZTB+tOad1qJGFv5pAgzNOFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9HoYbl4EAxfSdSpXxFlhWTCYmqEzQHnhTU0CBvj9iYfiV8Ug+X984qnMO0l1xcwk1khap/0btzbe1AFC+55pTVsMwlh+Jvb3bZ3g/REjEae7amCTM5m6vIKh+ogSX/ej7ytob8QP6UZrDaNu4uY/oBXfpNVo7VcJ6NnMnLWjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80ac76f1226so1022843241.0;
        Thu, 06 Jun 2024 00:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717659269; x=1718264069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GKftCP9/2k+rwdbFe8+uz5mmXt90F+mrxFfDHCGfSE=;
        b=m2Fqm2HLd6mMQcEmLcW6iv9j/l9BO6BLmUP5eWHTLbIDfew2SSQInAvrfUz2wkmIIb
         lxX306CJghzCTxu3v1Zpozn0tLOn+AKCal3LKM5uz6EN91L/7omMvgHCKyhORrONy3kI
         Bxtc1eON+QdLG21ge2LFBTBB/jWvEfPB3YayPkVOEiS/MIYggFDRRp4u4RdPeiWbojtX
         nluxg4Zk0AtdQeU4SzkSp+EAbaYgpSwvTLDNxGNnTl0GxY16AJFxGtvJtLo+ltC41CEA
         yAdLwD/ltDQetOPzAHOF9qb4DYU/O/tR0JPN2cV5sxXeAyDTJCUNVh0XtgCYaR4wtiau
         TRQA==
X-Forwarded-Encrypted: i=1; AJvYcCUMg6jKHBw3pikORA7TI1aLff1dlmyyfCom3EFKwNpta4530kmkAZch+6s7UzxUUrq+kWHvXYdy9L/3xHwZK5pGRvK7VqtdKZZeXaCnfFwt6NM3ymSjgMHrg7kxQfJqYL4/F6HvACMX6+IG2BNiPi4EP0HLR/wKRakw+J3WzGvEwN6W6DBX6A==
X-Gm-Message-State: AOJu0YyXh98B8BfYHXmvulSBX3JAkTzNhKZHzpEhVb0HCTkbWEnL8QXz
	a1RyGJWnzaTQkIlLUNnxUy/CseimsdZfBXxXBMdJu0Ru3wa5XZWl3BPDTPpBO3B2QFstTf06t90
	b4hHCL1nWJWVMjxcFe0my/OtXND8=
X-Google-Smtp-Source: AGHT+IHDkMbNMsty1ht2MnXgdQEVvR9NxMfwMhbf3doeT/zFY8jzDxGMadfWznImQanH/ixCrkzqx05d8QEvEiqihNY=
X-Received: by 2002:a05:6102:292c:b0:48b:d1dc:39f6 with SMTP id
 ada2fe7eead31-48c165b0062mr2590222137.0.1717659269214; Thu, 06 Jun 2024
 00:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605160848.4116061-1-kan.liang@linux.intel.com> <CAP-5=fV+-ytA2st17Ar-jQ5xYqrWtxnF2TcADKrC5WoPyKz4wQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV+-ytA2st17Ar-jQ5xYqrWtxnF2TcADKrC5WoPyKz4wQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 6 Jun 2024 00:34:17 -0700
Message-ID: <CAM9d7cjuHYDMvcq10ZD=3LSmia4WcvAzsme89B-odHYBAZzWYg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix the hard-coded metrics calculation on the hybrid
To: Ian Rogers <irogers@google.com>
Cc: kan.liang@linux.intel.com, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Khalil, Amiri" <amiri.khalil@intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:21=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jun 5, 2024 at 9:10=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > The hard-coded metrics is wrongly calculated on the hybrid machine.
> >
> > $ perf stat -e cycles,instructions -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >         18,205,487      cpu_atom/cycles/
> >          9,733,603      cpu_core/cycles/
> >          9,423,111      cpu_atom/instructions/     #  0.52  insn per cy=
cle
> >          4,268,965      cpu_core/instructions/     #  0.23  insn per cy=
cle
> >
> > The insn per cycle for cpu_core should be 4,268,965 / 9,733,603 =3D 0.4=
4.
> >
> > When finding the metric events, the find_stat() doesn't take the PMU
> > type into account. The cpu_atom/cycles/ is wrongly used to calculate
> > the IPC of the cpu_core.
> >
> > Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
> > Reported-by: "Khalil, Amiri" <amiri.khalil@intel.com>
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> > Cc: stable@vger.kernel.org
> > ---
> >  tools/perf/util/stat-shadow.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shado=
w.c
> > index 3466aa952442..4d0edc061f1a 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -176,6 +176,10 @@ static double find_stat(const struct evsel *evsel,=
 int aggr_idx, enum stat_type
> >                 if (type !=3D evsel__stat_type(cur))
> >                         continue;
> >
> > +               /* Ignore if not the PMU we're looking for. */
> > +               if (evsel->pmu !=3D cur->pmu)
> > +                       continue;

Hmm.. Don't some metrics need events from different PMU?
Like cycles per sec or branch instructions per sec..

Thanks,
Namhyung


> > +
> >                 aggr =3D &cur->stats->aggr[aggr_idx];
> >                 if (type =3D=3D STAT_NSECS)
> >                         return aggr->counts.val;
> > --
> > 2.35.1
> >

