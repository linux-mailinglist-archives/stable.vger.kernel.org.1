Return-Path: <stable+bounces-106220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E19FD698
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 18:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F407D188590B
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0611F540D;
	Fri, 27 Dec 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/3ZolzX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369F1FB3
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735320744; cv=none; b=UCCBt+DdC7My5Rae3gApfhcYOPIIdwE+RYcYPKwGVcT0F76gPv8Mmkd0QyYJjmSW4lEX9OWnjwLzXKqxYbz6X9gAhKaPCbbtcFUr9crdbdynQoWGuxVby2cfTaQyBveEDCA56cn1qFXMyTPJzl7C1dB0AGPbLJIq5okmvwsYZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735320744; c=relaxed/simple;
	bh=3Za89p1AJUVKLvTESTvLCCRcRlcpPs2RUs4Uj0BvdEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkluksuvuGf6hy1oOjgbcurNoF+x9927IqxRFtxxAuKJbaJjUxwZOgbxL5K/MYfKq+COmVzALKfgZRtBB0vs+Wlp3Dqh0ZtRVB4u9mSnJlYb1/fy2ybimM+Ihd+jCrWy4Ti7aUWG5YdNV8fo4INQxDwV2ztw5EKPs151bVK0QcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/3ZolzX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4679b5c66d0so1883851cf.1
        for <stable@vger.kernel.org>; Fri, 27 Dec 2024 09:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735320741; x=1735925541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04SxCpsaZ7KCjEolpa+jFc5TEJpImpO+Qtvwvnqh0yA=;
        b=l/3ZolzXeaf0v622BlXOch2Pk6BztZytEstwXrjr17CjkFRzJ+ix2eJ6jvcFCwGG/B
         n+FUKGPifQWXXXHlOAf5ojlpxWcYdDCMK7CgmNdx151vpPcz8UV5oUTTUYP1cvRDMRoW
         8ZyqvurcJk5baqHIdZcCcyy0oSnL2ATUyD8VvC3RmIJPN6CG1ynA1EbZwXSncH2zpbPK
         uUR4kDrfHEzGFhJtb4+vG5TQCg52T0X7FTCTVnhbjnSlm0OhLmu2Bj+hNb2oebwfsOAn
         ZeLuJblhr1PZtcusGNwrTjyyl7Gt6sKwnJMSzb3u2kM0BdFkGHFFX9GMlnNRd7B2r8ie
         Ioiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735320741; x=1735925541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04SxCpsaZ7KCjEolpa+jFc5TEJpImpO+Qtvwvnqh0yA=;
        b=fnsFOaOUBGtoRUDN2mJBqv3n8/avVFfhIwH2aDZaP/NCtS7dk7dSt6UxxEKnklYbmF
         VHIxBYCKA7KSU6L16Wqiqm9Aer5gSasiNgM/kQL4z3WZTm/vkSm9htMNLEZCTsiHmJKp
         RMH+qYb3rUBQeOrrJVfFHuevL2uDCm+GtL6NzmxV9XuF5j/Q6utQmJm9QsKwxuANNkeU
         vbtIfVwH0w+3wn7qk1qIcToUNAImfGTNzZPp6RkjZYknHipnvqLADslx20NCglSYXsEB
         rhBrBI2kmwFK5jbIUbbMaPviAyda+c1mNPPM3FxoDG+jgMFihjW8uCfyf9IW5XPGnIl2
         hD1A==
X-Forwarded-Encrypted: i=1; AJvYcCUvxo6LoVVQ+xhhB4KioFY0Orgr4gzQomKcx7/GyrZ/WL8am0COtclnzb/hb+E5CAgGsTTj+WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1yR9QalqEt875O1v4dg2BLNO/Wg9W6KRBuhkZRnEcw77tejd
	6IrgwMRnrek219qAour2sPZjE9cJN0Uw6xavuYXgcPO5wHlRXj9N42RcXS9VomTVOmkH4VS4+pX
	F3iS5lH0dkrjkUSQ8fblSYNt8vB/0d25QGz57
X-Gm-Gg: ASbGncv+Dyf7fq/y3GFC11Sw7XIVmMVpWQJppsJDeR1UOWPZx/mzUG+oASOjEizU9i6
	iM2yyleBzr3PCNoGFnHvys1MEzyVZ2TsXzYR9Tg==
X-Google-Smtp-Source: AGHT+IFcBTHXKztvE10gZyJ3MYoBAJikURcg/HIDcbPftZvqfZcicz+LBrQC0kbUMElsmtxWbTj4Z7qSC3T+TnLLQuU=
X-Received: by 2002:ac8:7f82:0:b0:466:8887:6751 with SMTP id
 d75a77b69052e-46a4c01bab2mr20251161cf.23.1735320741443; Fri, 27 Dec 2024
 09:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226211639.1357704-1-surenb@google.com> <20241226211639.1357704-2-surenb@google.com>
 <20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
 <CAJuCfpFSYqQ1LN0OZQT+jU=vLXZa5-L2Agdk1gzMdk9J0Zb-vg@mail.gmail.com>
 <20241226162315.cbf088cb28fe897bfe1b075b@linux-foundation.org>
 <CAJuCfpG_cbwFSdL5mt0_M_t0Ejc_P3TA+QGxZvHMAK1P+z7_BA@mail.gmail.com>
 <20241226235900.5a4e3ab79840e08482380976@linux-foundation.org> <CAJuCfpHJ7D0oLfHYzb9jvktP4X6O=ySGe7CK7sZmVNpSnzDeiQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHJ7D0oLfHYzb9jvktP4X6O=ySGe7CK7sZmVNpSnzDeiQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Dec 2024 09:32:10 -0800
Message-ID: <CAJuCfpFKDejZz8KqniMa4U+8oQ8LSCwx6U3eAqphN2FeCD8WTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is disabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 9:28=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Dec 26, 2024 at 11:59=E2=80=AFPM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 26 Dec 2024 16:56:00 -0800 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > On Thu, Dec 26, 2024 at 4:23=E2=80=AFPM Andrew Morton <akpm@linux-fou=
ndation.org> wrote:
> > > >
> > > > On Thu, 26 Dec 2024 15:07:39 -0800 Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > > >
> > > > > On Thu, Dec 26, 2024 at 3:01=E2=80=AFPM Andrew Morton <akpm@linux=
-foundation.org> wrote:
> > > > > >
> > > > > > On Thu, 26 Dec 2024 13:16:39 -0800 Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > > > >
> > > > > > > When memory allocation profiling is disabled, there is no nee=
d to swap
> > > > > > > allocation tags during migration. Skip it to avoid unnecessar=
y overhead.
> > > > > > >
> > > > > > > Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > Cc: stable@vger.kernel.org
> > > > > >
> > > > > > Are these changes worth backporting?  Some indication of how mu=
ch
> > > > > > difference the patches make would help people understand why we=
're
> > > > > > proposing a backport.
> > > > >
> > > > > The first patch ("alloc_tag: avoid current->alloc_tag manipulatio=
ns
> > > > > when profiling is disabled") I think is worth backporting. It
> > > > > eliminates about half of the regression for slab allocations when
> > > > > profiling is disabled.
> > > >
> > > > um, what regression?  The changelog makes no mention of this.  Plea=
se
> > > > send along a suitable Reported-by: and Closes: and a summary of the
> > > > benefits so that people can actually see what this patch does, and =
why.
> > >
> > > Sorry, I should have used "overhead" instead of "regression".
> > > When one sets CONFIG_MEM_ALLOC_PROFILING=3Dy, the code gets instrumen=
ted
> > > and even if profiling is turned off, it still has a small performance
> > > cost minimized by the use of mem_alloc_profiling_key static key. I
> > > found a couple of places which were not protected with
> > > mem_alloc_profiling_key, which means that even when profiling is
> > > turned off, the code is still executed. Once I added these checks, th=
e
> > > overhead of the mode when memory profiling is enabled but turned off
> > > went down by about 50%.
> >
> > Well, a 50% reduction in a 0.0000000001% overhead ain't much.
>
> I wish the overhead was that low :)
>
> I ran more comprehensive testing on Pixel 6 on Big, Medium and Little cor=
es:
>
>                  Overhead before fixes            Overhead after fixes
>                  slab alloc      page alloc          slab alloc      page=
 alloc
> Big               6.21%           5.32%                3.31%          4.9=
3%
> Medium       4.51%           5.05%                3.79%          4.39%
> Little            7.62%           1.82%                6.68%          1.0=
2%

Note, this is an allocation microbenchmark doing allocations in a
tight loop. Not a really realistic scenario and useful only to make
performance comparisons.

>
>
> > But I
> > added the final sentence to the changelog.
> >
> > It still doesn't tell us the very simple thing which we're all eager to
> > know: how much faster did the kernel get??

