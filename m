Return-Path: <stable+bounces-200804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB2CB65D4
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 16:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C0F3021E79
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B730F922;
	Thu, 11 Dec 2025 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="yerLci8W"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775E30F7F8
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765467632; cv=none; b=oehjkDek6MXTrbhN170OHAeMyfYe9PSr3fjFrPsl1wxvHdjQ5VFgKZJXSQwVGTtPrG0C8quaWzOQnDXRQxtDv+7htRJlyzXaa23doCRTJkFBcvOyfPTUERkuHuSIpt7u3NeyQIHXJ//wfSy7z9e8THnPQdqYa358CTJ8f14v9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765467632; c=relaxed/simple;
	bh=xY1BmqLej6LdL8opPSvDdksuAPvCJXAWVUx/9fU7It4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIR2ElnbXXDbUBA1HYI3j0a+hGQ75Az7bQxUNrzDqA0g/v2DkEW82RJyUKgR/Z1dgg1O6KW5CWZbX6B3I/xXjpxaY/xnO0sjwBB9TDJYrgPLlocg+hmEkfwJONdGSvnxHq1IXqmrJ7hPdP75GWRXYBlANrBK+cAhOuyrZ7bvM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=yerLci8W; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so403978a12.0
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765467629; x=1766072429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqPScvJ4WBIuB5P5PUVnKmLK9/PY1poWwXCsEBmV7EQ=;
        b=yerLci8WSj/BXGW3VM1yyd20wXjY0MJmDbFeSCB88cYZbEBTuHnxM2ma7QBo3VO+OW
         131Vu2i12uBU6p/ZChhI+j9GPslsvF5flSiZnLQGTFdV9CmxB1h+H7/sLREBEo/VdUfF
         fpOLNh7Rlg+aJ0Oe0JJb0o25BmD4ZN1FhPH1TtRflLZWVd7paQZp3q1tJimU3VJa2Lly
         UQr3MD9zn3sVyMGuGSpqVCQdq2nr+l3iA0vi6zb5oyTdhqGU1m4uGBB/M8VJjfDbjAzx
         3hRX+PwVpKybixL5G10Cam2Nb7tr8fSVXgHvPkp46tcRySDAp8wvgtONfbvKMujag8zd
         V7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765467629; x=1766072429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqPScvJ4WBIuB5P5PUVnKmLK9/PY1poWwXCsEBmV7EQ=;
        b=Ck/wLER1fX0oTHZjqmeVOV9lFQW2E6DhOm8jVPwmUdw2XoBsjkVOv8mYs+KxsaF1uO
         tzgdlQlZ3XUsXlI6K/ePr1aNEo+KyRofJ9EL99q7dLss0hP8iGUH10vzJcCg3g45UCPU
         7T7EJq76d9tOylyWmJpbYCQ9/UPDHcxdIZvq0clc1w33Bhf3sbTylVmQl0y63ZrhJOr1
         8K8V6K8Su+sPcmGeVJkumPEG+YPLpMvyAJBCfYf9/Jtf8yW6Quw/GtZkj+VqQcG1lwFp
         pczSLiQHyKUfZut7UTjKNISdCDiG8rOxarVf6MtQ8mGt2NLu379zMxg9ASYSKqSAglUl
         Ab2A==
X-Forwarded-Encrypted: i=1; AJvYcCXg55+T15tjdxsa469f0vruNvaxZZnhkLHKJTEYeGqY5wFom8uw7f3W/EBH5brU6HntZGYbIdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiczwolCUA5nasHSVL62SfX8SA1lnjAIiHiXYtaMHGpr8azLYm
	pPrjnY4/Pts3FHfFlvTjdRtCaZ7ZdL0t0cV017qxGMwfgTYo3Qyamv1a5BbhWWYRX3aW6au3eDo
	t8q0VDFTGi+bPYnpjIGRkPFwYNauT4hq4qCpcNR0E/g==
X-Gm-Gg: AY/fxX5XZCMTgCchpZRw084M6FpaxDGtAwKOzxP+1EWuBx5PvS9Kn/UNyQ3zo9Na0Q2
	AyHBXY6o5VKidyMuZjDQOglMN6PJz5yyGjm7JOGZ0vin8GojIEq7eOywTTTEqeU1Hw22yJT06bt
	bAVmq54zHdR+s+DA8yXb/UZazcPoDGKbQyrpVh0Yih07Qqi0ybaDM6GyZ2mQ1/uB9IHV1gz5p7a
	HesURwSgspGtLHg5KmuBaSpm32/0FtpkcfneJ1d00nxcnlPCxNgANGIaqDAsg9zN7EEN6bopWMI
	F3wA64g=
X-Google-Smtp-Source: AGHT+IFFm/09kODYtVj/jT3L/lBrOy6szLxdTZhvxFXifoxdEQMTCf0vVFebHgTlx3wBbXfRlHweSQTfq5fkyItlL8I=
X-Received: by 2002:a17:907:7ea8:b0:b77:1166:7d63 with SMTP id
 a640c23a62f3a-b7ce841c50bmr757021966b.40.1765467628648; Thu, 11 Dec 2025
 07:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072947.850479903@linuxfoundation.org> <CAG=yYwm==BjqjJWtgc0+WzbiGTsKsHV3e4Lvk60fcartrrABDw@mail.gmail.com>
 <2025121046-satchel-concise-1077@gregkh> <CAG=yYwm0bVzYoccKKcdheGOc-exuxVCPeXSftDixS68qZZ7W7w@mail.gmail.com>
 <aTnET5C2PGiKsW_2@auntie>
In-Reply-To: <aTnET5C2PGiKsW_2@auntie>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Thu, 11 Dec 2025 21:09:51 +0530
X-Gm-Features: AQt7F2pi6TZXr2dGaZGsLTRBYorVi9P5ROwKyX-pAKDthnXiINq9R-1QmXI1fSA
Message-ID: <CAG=yYwnYgw-MYea3yEfwSRiLL+PsKPdQdejotyFTpme0LXc-Pg@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
To: Brett A C Sheffield <bacs@librecast.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 12:35=E2=80=AFAM Brett A C Sheffield <bacs@librecas=
t.net> wrote:
>
> On 2025-12-10 19:13, Jeffrin Thalakkottoor wrote:
> > On Wed, Dec 10, 2025 at 6:17=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Dec 10, 2025 at 04:22:21PM +0530, Jeffrin Thalakkottoor wrote=
:
> > > >  compiled and booted 6.17.12-rc1+
> > > > Version: AMD A4-4000 APU with Radeon(tm) HD Graphics
> > > >
> > > > sudo dmesg -l errr  shows  error
> > > >
> > > > j$sudo dmesg -l err
> > > > [   39.915487] Error: Driver 'pcspkr' is already registered, aborti=
ng...
> > > > $
> > >
> > > Is ths new?  if so, can you bisect?
> >
> > this is new related. Previous stable release err and warn disappeared
> > (i think i changed  .config)
> >
> > can you give me a  step by step tutorial  for git bisect
>
> 1) cd to wherever you have your kernel checked out
>
> 2) `git bisect start`
>
> 3) if you're already on a known-bad commit, then mark it as such:
>
>   `git bisect bad`
>
> 4) Mark the last known good commit as such:
>
>   `git bisect good <commit / tag>`
>
> git bisect will choose a commit to test.
>
> 5) Build, install and boot your kernel as you usually do
>
> 6) Run whatever test you need to determine if the booted kernel is good o=
r bad
> (check dmesg in this case)
>
> 7) Mark the commit as good or bad. Git will choose another commit for you=
.
>
> 8) Goto 5.
>
> `git help bisect` will give you more information.
>
> At the end of the process git will tell you the first bad commit found.  =
You can
> dump the bisection log with:
>
> `git bisect log`
>
> which you can reply here with.
>
> HTH.
>
> Cheers,
>
>
> Brett
Thnaks for the tutorial  :)
1. should i start with the bad commit first ?
2. how to move forward or backward in commits ?
3. what is the point in re-compiling the kernel  if it cannot narrow
down and  test news lines of code







--=20
software engineer
rajagiri school of engineering and technology

