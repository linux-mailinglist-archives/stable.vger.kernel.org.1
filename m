Return-Path: <stable+bounces-194993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DECC652EB
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A86038488F
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF11C54A9;
	Mon, 17 Nov 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RcnHxSv4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708B2C08B6
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396838; cv=none; b=A/LR/Z5PMp0kZfNg9iG/UVLRZICNJeEp9sAa7GEuUdN/1f/KyfeCRGtCVfZr+4h4JyN5igtBw+IiceQMq1H1EPe7CwNQwUpPPaS++lenX+d6jHfi74pIiT6FryxYU6u8AvRI7lsR357Fh6QolEQKW9U2v7NMwSZm6Su67sv/FY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396838; c=relaxed/simple;
	bh=AB2l7h28eCfihjsROsLqYnet8Vh9BGxbVEra/6m/f/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ3MC0+3Rj/RiF5ecqj3yzTDhrsr8CouYICKGV0PS2eXesjRFx38irQn5DY43GLkprNFhhSaEd8y50i/XaxZIhagHIkyHQYH/5mJahNV6Uk6nJx96JRzMRse8Nx6U2SE5DIxF4xHyeOEc5/DTMq/4SWOZ34OdF0GjZ4sYX9H3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RcnHxSv4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e13bf404so416915ad.0
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 08:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763396836; x=1764001636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5R4JD7ib7/u6FWEhmGXN24UmqpSR+/S1W3Xpq5KJg4=;
        b=RcnHxSv48IcgpDaZXKa+A3Dq6A0T+EXTUQgnFNS+4+HA18/Ioif21WVm6hDMAh8PMi
         6AY9dYlVq6Fb/BEQXHG5dRq0pWTgJtAjUtuR6AZnQyXWlxarTUPYUVW8IU7axKFcaamh
         cDQm2R5gjFVsZfoUg30U6GvQijaeBvmgjZfXCi8Q/WWTdG90FI3MeQBEsk1xeP7FO4a/
         A0iinXV1CqviA3xDb0FP8xFZuyb9ZawndZWRZZZDrFzhg+F/e+0w3NTlnTIspYAUIpEd
         6d1CyGy/seilUpdJTHjnS3ugFfn/QH6b2e7vb6bSVJqs6tK+cV+zZsBnqZ15l2MICWEy
         8UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763396836; x=1764001636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5R4JD7ib7/u6FWEhmGXN24UmqpSR+/S1W3Xpq5KJg4=;
        b=mR1Ksx7fHwfSW0bZdPLRLZtysO1q+LBcxBTmLqzttLJ0uQwfYbpOrsjyea2xYCGAB3
         Ojy8Q4RSHeBWYvewXhH9FWKp5DjpZcrW6hdO1tfyxrDlFmcKBHtVQBt70dDjSaJ67r08
         NuvfoNb7LurIpMIUv1eq0+YCJGUChZzSZcXeTaZW9+oR0bz18E/Ziq3ufgzBoh0Fhlf1
         Z2IF31RR5uqy4HybPWcuAcSdnS5QmWekjfHIDpOkSM76RWXenFApLc8xMcnEnp3H+8IO
         pvmdS9qdbXsUn76rw2d+bhz+mh4HrRaH6UV0M1jIM1BYuMq991PmZf3SCk4Ghrc3m7ha
         6peA==
X-Forwarded-Encrypted: i=1; AJvYcCXnd4Rkzg+BFp0R1e490PojEIBn+wDlzT2A19+ZVDChA6q9ynj0OvrzlRtV8lbv1i/eNaK4xnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOSCF7dvb49ExND7KbftZObCgtAn4/+EUIj4WdY1dZSyfEYZx
	pMZrox75+43SRxTmktLgVqFvtCtnDQY46804F/H/FSIMtNfJ822C7atFilTGSwflmqTlelM+hCM
	vYFy0HxRDwxA7U/C9zTFZVYPV15MV8rylgOEhAxSE
X-Gm-Gg: ASbGncuJ5FeWWoQO01qCM4TRnnie1QzIp3CbeW6CS5q9zKdRsJFsmQ2zCT65853RixS
	HfR+t0VwtyAAzGideiaqn/HUrUHaxvUklOZaF9tJx34PxDCPs5Dn7112ure17qe2jzCTBPtjTbS
	Qs8LUthOxn3pI+RVVxxKFJC1Gcjf94sbF4JhpIcfHC4jeIxMbAPa1b2qSl1ax2/2/uIEu6nqHm1
	B/mpTR2/85ePH/CzDjR0hOIHO7tEC1X16vrmSYkTTLC6qXpAmHTrnWyt26HpRJ0YX/lU6xAOFi0
	rChZumWrzsbw9Iduq9nC7QI18Q==
X-Google-Smtp-Source: AGHT+IHX1vkGDDoyZkwgcY+Ry09G3KtJBuT0JmHZFyIm6LthGp6A4Zd4g3PfrO/XqEP81KCrEuBV6AaJo3AIQtGuyKM=
X-Received: by 2002:a17:903:124a:b0:297:f2a0:e564 with SMTP id
 d9443c01a7336-299f5277bf4mr44035ad.11.1763396835574; Mon, 17 Nov 2025
 08:27:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEHkU3Vr4RVG1Up1_cnoV70QRaYrRXW8ONCMOBB88F+Cu7WRuw@mail.gmail.com>
In-Reply-To: <CAEHkU3Vr4RVG1Up1_cnoV70QRaYrRXW8ONCMOBB88F+Cu7WRuw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Nov 2025 08:27:04 -0800
X-Gm-Features: AWmQ_bkfNEU0Q8KiEzhsDe9_7m7Bf7dx0SyQPmgg_ZdhOFjoJhLorzaPDzvzfaQ
Message-ID: <CAP-5=fVKC=DeekeqTJ+Qtvem6fqu+w2F7oMohFeidCMW6PbDVA@mail.gmail.com>
Subject: Re: 6.1.159-rc1 regression on building perf
To: Max Krummenacher <max.oss.09@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: Max Krummenacher <max.krummenacher@toradex.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 8:00=E2=80=AFAM Max Krummenacher <max.oss.09@gmail.=
com> wrote:
>
> Hi
>
> Our CI found a regression when cross-compiling perf from the 6.1.159-rc1
> sources in a yocto setup for a arm64 based machine.
>
> In file included from .../tools/include/linux/bitmap.h:6,
>                  from util/pmu.h:5,
>                  from builtin-list.c:14:
> .../tools/include/asm-generic/bitsperlong.h:14:2: error: #error
> Inconsistent word size. Check asm/bitsperlong.h
>    14 | #error Inconsistent word size. Check asm/bitsperlong.h
>       |  ^~~~~
>
>
> I could reproduce this as follows in a simpler setup:
>
> git clone -b linux-6.1.y
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi=
t
> cd linux-stable-rc/
> export ARCH=3Darm64
> export CROSS_COMPILE=3Daarch64-none-linux-gnu-
> make defconfig
> make -j$(nproc)
> cd tools/perf
> make
>
> Reverting commit 4d99bf5f8f74 ("tools bitmap: Add missing
> asm-generic/bitsperlong.h include") fixed the build in my setup however
> I think that the issue the commit addresses would then reappear, so I
> don't know what would be a good way forward.

Hi,

To my knowledge the build issue fixed by 4d99bf5f8f74 ("tools bitmap:
Add missing asm-generic/bitsperlong.h include") only showed up in
Google's build infrastructure. Doing the revert should be fine, but
when you move forward to a newer kernel the issue will reappear. Tbh,
I think there is a lot of cruft in areas like this. The perf tool is
using linux/types.h to have code that's interchangeable with the
kernel, but we could just use stdint.h and be more C compatible. The
version of something like types.h that perf uses matches the kernel
version and not the UAPI version. The use of IS_ERR (and err pointers)
is just copying bad kernel code into user land, we should just use
errno, etc.

Why this issue appears in 6.1 and not 6.6, that's also confusing to me.

Looking at the error in the code:
```
#ifdef __SIZEOF_LONG__
#define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
#else
#define BITS_PER_LONG __WORDSIZE
#endif

#if BITS_PER_LONG !=3D __BITS_PER_LONG
#error Inconsistent word size. Check asm/bitsperlong.h
#endif
```

It would be interesting to see where __BITS_PER_LONG is coming from.
You can make the build verbose with V=3D1 and then run the CC command
with -E to gather details. My suspicion is that we've gotten a muddle
of your system's header files and those in perf, due to the include
order, etc. and the resultant combination is why the test fails. It
could be in 6.6 we added an extra header file in the perf tree and the
include order picks that up first there. It may be possible to suggest
that such an addition to tools/include is backported to 6.1.

A final note, the perf tool is backward compatible with old kernels
and so it should be fine to just have the latest perf and run it on an
old kernel.

Thanks,
Ian

> Regards
> Max
>
> P.S.
> Checking out Linux 6.6.117-rc1 builds perf.
> make NO_LIBELF=3D1 NO_JEVENTS=3D1 NO_LIBTRACEEVENT=3D1

