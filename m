Return-Path: <stable+bounces-131778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0EA80F64
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F851889017
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8960226D12;
	Tue,  8 Apr 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RywL16kE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827E224887
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124843; cv=none; b=ayZz2Ev9Ht8ZeM3Bac9IrTKMC4sd18++iK2/CvXln/talSMtvOMsGugWcX1ZMyd8cWNbzroyftWl3bd/a/yaVDvg7agy1x80693lUfqzxX5INzJwJRyCgwFX037KUz5T7WB2cfypN8t+4wFitUPxrb4r9MSnQdPamTSFpMIzFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124843; c=relaxed/simple;
	bh=S53wWg6EVuiCl94q6KeD9ibvuRkH7pkNwygNbzLdELg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBLv2HNYEdPlkn0B0z4fDbF+TOqxXTJi3YL1Bqn+hYRSqleW3uP8y6QUDOcWkuV9ggj+FAOjetWD5Y9bJ9SjsEONz7bATmVQ7pJvDOi/dvUSaPKVjrUK7GTwy4qJIOq4/UBKlG4ZXEBO9eZYMhAOBn8mtqol41QWhpm7s1LI0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RywL16kE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2263428c8baso204515ad.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744124841; x=1744729641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unlVTFrgXvzgDf2aayfiA97WI+Y8WYBYEfd6y5NTwTE=;
        b=RywL16kEOFtbTP2genqiDWBVdaajuoTGPDy2aX83qoaHTxbtXVO5GHmJY3GijOUypA
         PfvhJwJJnb9ezLWxFdMQBRwBLrSYKl6oo2zpHq5mLl6tRt6qSKdgWzVo1vmhTRmxJweI
         PdQMXRa0HiOoaG9UTOqPtKPqqgshCrOAPSKN1FtCQosSXMM8piMJHQ/5fn2o7nHUHnJz
         vxb2Kpi5jpLi7eFM8uFhjMh3JeiyOYE8M5rbzmbp0cBxmyzn5rg0OQKY9dzeTGe1ibJ6
         YN3umapW+N8/2dihPCC5aqUmGqVcDF1IzvI2Wygzh9Qrf0KLvtcyTEcD2u8LmAGGE4kx
         jCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124841; x=1744729641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unlVTFrgXvzgDf2aayfiA97WI+Y8WYBYEfd6y5NTwTE=;
        b=PPj/HAFZkZwfZgr5SzsSHeMN/y87uE+5CQTpbYGBGObc1fUt0bTVgdeO70dS5CoAz4
         qHjWFTLxBvIe0cMU2DUD7zNbpLUx4mjwL6UX4I/eGy6GM/UfqikxUx3Ct1CQBeq9Soeq
         Rq+FMsQxB1IYGqmIhqg7XyRNybdL8uTbUgovkg+StIFPGioqbQwoFbzJiYLzpYf81m//
         QMeS7qqFkmiJ9mHlk7q9aZDrNQgbBFukVORLttLYEMtd/G/dNV4TMKfloh55wDJH1xJV
         eQS0OzUDkiXvNxwZq+RtGcIA/IkIsRybjOeiiizkO2kgdnPrbUKJEOYPNHeX1ljmp7g6
         w6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUk9JOOkHSgcFWa6wGqQM3loe80hVMv2NQwQOZ2n46SvsbchaZPzQM/SYgHTChBWrES8hD/0h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+yA8JTvg2mDRqkHG95NMhdtMYvn7m3l0o9TAPRcSxByVe2ml
	DGZogyaq34r5xkiWtgb/7L5LxstsJfYtkBY+ixA5V19ERCVefnk5vzyMMnyCm0ULiC+dmRv87ke
	tAMSeeWUzDFPFkyoOBmYG+M2A9TNkzDg/f+Wj
X-Gm-Gg: ASbGnctXPDrzx9K7tvq8D7tx2iU4In8D4EUL9B5lO5FXv7e87Vc7EtfCtpB5nMj6pgH
	pvmx/MmjQvkhonOvnH74lJFZL7j4xpcte5XA5MxVAlzK0cAIiypgMqhbmVYeeUPWHmWW6IQzutc
	njavgw5X0AOAo3X4kOFPCZbWW+0PzFNFXOpCP1rbgPQVRGA648Q/NwGOU=
X-Google-Smtp-Source: AGHT+IHFvpD+UYJr1rf7dkMEUUfZYlYA2D8wwBs41XpEWpKcKPQk1Z5yF1J8r08XTvksa7AT4b5xjMDYxJPxKmrPCzA=
X-Received: by 2002:a17:903:3d54:b0:215:aca2:dc04 with SMTP id
 d9443c01a7336-22ab711fba1mr2414715ad.26.1744124840778; Tue, 08 Apr 2025
 08:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104851.256868745@linuxfoundation.org> <7d11f01f-9adc-467c-95bc-c9ff4bbf6a0f@leemhuis.info>
In-Reply-To: <7d11f01f-9adc-467c-95bc-c9ff4bbf6a0f@leemhuis.info>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Apr 2025 08:07:09 -0700
X-Gm-Features: ATxdqUFsPT9ssGEEy4_cYrt1sV-fWT0gbYl4L_w8VJ-E1PwhOl7_XOsF39WP5YY
Message-ID: <CAP-5=fVCADCyXeeLZT4EpU1OtOxMKB8omf5FFpDHmKgOWetW2A@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/499] 6.13.11-rc1 review
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Justin Forbes <jforbes@fedoraproject.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 6:09=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.in=
fo> wrote:
>
> On 08.04.25 12:43, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.13.11 release.
> > There are 499 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> Compiling for Fedora failed:
>
> util/stat.c: In function =E2=80=98evsel__is_alias=E2=80=99:
> util/stat.c:565:16: error: implicit declaration of function =E2=80=98perf=
_pmu__name_no_suffix_match=E2=80=99 [-Wimplicit-function-declaration]
>   565 |         return perf_pmu__name_no_suffix_match(evsel_a->pmu, evsel=
_b->pmu->name);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> From a *very very* quick look I wonder if it might be due to this change,
> as it seems to depend on 63e287131cf0c5 ("perf pmu: Rename name matching
> for no suffix or wildcard variants") [v6.15-rc1]:
>
> > Ian Rogers <irogers@google.com>
> >     perf stat: Don't merge counters purely on name
>
> But as I said, it was just a very very quick look, so I might be totally
> off track there.

Thanks Thorsten, I repeated the failure and reverting that patch fixes
the build. Alternatively, cherry-picking:

```
commit 63e287131cf0c59b026053d6d63fe271604ffa7e
Author: Ian Rogers <irogers@google.com>
Date:   Fri Jan 31 23:43:18 2025 -0800

   perf pmu: Rename name matching for no suffix or wildcard variants

   Wildcard PMU naming will match a name like pmu_1 to a PMU name like
   pmu_10 but not to a PMU name like pmu_2 as the suffix forms part of
   the match. No suffix matching will match pmu_10 to either pmu_1 or
   pmu_2. Add or rename matching functions on PMU to make it clearer what
   kind of matching is being performed.

   Signed-off-by: Ian Rogers <irogers@google.com>
   Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
   Link: https://lore.kernel.org/r/20250201074320.746259-4-irogers@google.c=
om
   Signed-off-by: Namhyung Kim <namhyung@kernel.org>
```

Also fixes the build.

Thanks,
Ian

> HTH, Ciao, Thorsten

