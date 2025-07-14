Return-Path: <stable+bounces-161884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C553B0481C
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426DC3B3207
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 19:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A0758210;
	Mon, 14 Jul 2025 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JVyyY8KU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19213D531;
	Mon, 14 Jul 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522984; cv=none; b=Mxxdt6haOuLtPrRbskO7dP0J3hSaDTF8MxU+6eM/LfbJS6yVQP6PvgN17F11OJFeOCdgM4eME0IJ+0QKVBHSJYiYrCy25ysNJHBWVVSgxxRp5jxrLa6FmynWGJhvX5vuB3bD/GTAIg2+3pNKUwAj2qnWARhf+pnhIfaFFSuKIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522984; c=relaxed/simple;
	bh=msrTOzkx3nVfxEF+cyCWrsAAKGHytXv//zdlie3Ckr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O55xWZUgHCUdEJRl8k9jAFMSyHSrUvfILJO8DxoL9euaT+HhHUJO7VgIXX11hBu3GrtqDkpV8bwuffhPSPI61oOVYD4gKkUxY+gkFnCGGT7ZcCEVgYEtD7Q9oD3AzQfmxby2QFLk3yBlZ1lCSjRiBbAHGDTao11q2xZ/G+5zv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JVyyY8KU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2350b1b9129so32696125ad.0;
        Mon, 14 Jul 2025 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752522982; x=1753127782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8l3TuLeGRC12/isQU6yAP3w/Lelz62KKBJILK/IPuM=;
        b=JVyyY8KUAWyXBKn5/RoN5ilGhW+X2w+ylJtXlvtXk/U8d+IL72wv7Z/18+PP2bH6JF
         kKL3m1/GQPnfnbHR9zhvEf4fHeuSdUV1I+KwzHD/AepQ38xctW2nfzakfb+xzlRtGAg4
         HKfDwIRAsldTwoI4xeQvQ7FHVB69+hx6ZaaV5Vo313t7Ga/guayfXjqwlwvf1b5Uhiml
         lisnGXdHBnKbU1L3FqVr2/URDVxhQBNfc1C0WktXnCDnliD4hmeEqzsEJ4di0zWujuNB
         LUvQHjyFOGKp4Y4qG/5tyt1Ggkuc8S6ysaUN3WDp9/BrinV/BCkrhAjWDqjBfp5EfCxc
         7rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752522982; x=1753127782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8l3TuLeGRC12/isQU6yAP3w/Lelz62KKBJILK/IPuM=;
        b=P4gUBJIlyQysex3mDQHXtDgCPMfKde7sBJhz4NQZobgAuUixGH8/jwl8SGdKFlskkC
         ntq/YifninHSZf3PPBnjYtjXIOfTF5n2k1MLMsO+p3rPv8PZ4H2hRfKH80MEjxNF0H2r
         w3STXhI3I/Lx07ke8lur6M+zfD3mhC08t99NsAxW0pJOITgzgbjEEqHDE0x8exIntNgc
         bSfVm3ebILG2X7nC1UzJ33mR6iATmVURDzmnpPF6+kHrn2Twe1D2srP7PoMHSZl/6HiK
         xQ2Lu9izvVi10BngOlM6qXYtrvhQHmvBlWby4226xAStjAm3mrHaRB1NOTKFDqkzx3bZ
         vtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2lhll6ThcVSRJzO5l0zgoL3/T+atqz/aALQcBWqiqriuh9Eawj0TFPYER8vZKSlxNWNLxIx6Z@vger.kernel.org, AJvYcCXKp/TFubFxx6nemDehfpmeG0AcyJ1oNcrN5GZToX2ujrZ/OrBY3GgWMnOPDIu0+VMbvMhHCmT0S9OfjVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLyYiLF84vNng2lyLcW1hnvwlXrPyro3kEQqHmVT6Bddvsy94
	lhh1xHTjxFbo4Q0h0yBNiss8aRGFKEgEsT99Rz+R93SH0rXeylEdC67VviVcWRlG9G1fl5Ade6S
	8FqogaRCCDX2CRiXT87bLG/yiZTNCxns=
X-Gm-Gg: ASbGnctXwCLdnBMPt/tAeYFa8VurHrvO6UvPTBH+jmOs64XR2FRoR1dxhbcnd0o83Z+
	vYTMJkgMJ/9o3oNM9gk8ehq1f5ulabQVnJTQmRK7LiAZqMb69WZi6n18Q4FxBrLX0xSOgO1kFtw
	phol46xwvGW/sHnSHTg4VBzhzBMjla4Rgerlx0mqxZ+hw1uDGP1z1zvzoFFbxv03vaY6UYMUbdQ
	wlvKPbgaD4cO6bY9okbe/HblWL6rFlGDh3oEp4l
X-Google-Smtp-Source: AGHT+IEKcPO2dj8iuRmnxnt2knjE9fyHOUuiEh14mnU8le4Tje5sE5O+cSpiQaZ8gk8V5vL7ks0Ktg/2wNRtqQYal+I=
X-Received: by 2002:a17:902:e805:b0:234:c2e7:a0e4 with SMTP id
 d9443c01a7336-23dede2f317mr186119465ad.3.1752522982432; Mon, 14 Jul 2025
 12:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130632.993849527@linuxfoundation.org> <70823da1-a24d-4694-bf8a-68ca7f85e8a3@roeck-us.net>
 <CAFBinCD8MKFbqzG2ge5PFgU74bgZVhmCwCXt+1UK8b=QDndVuw@mail.gmail.com> <2025071238-decency-backboard-09dd@gregkh>
In-Reply-To: <2025071238-decency-backboard-09dd@gregkh>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 14 Jul 2025 21:56:11 +0200
X-Gm-Features: Ac12FXyfcdIioMVTiQL-1AbAhQ1x9Xhcwx1gMDfemUjWBrxju3vhXDvvescNI1M
Message-ID: <CAFBinCANe9oajzfZ_OGHoA-TtGC-CQdOm_O5TG8ke8m_NNE5NQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/411] 5.15.186-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, 
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, Jul 12, 2025 at 2:37=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 08, 2025 at 06:05:14PM +0200, Martin Blumenstingl wrote:
> > Hi Guenter,
> >
> > On Mon, Jul 7, 2025 at 8:05=E2=80=AFPM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> > >
> > > On Mon, Jun 23, 2025 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.186 relea=
se.
> > > > There are 411 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > ...
> > > > Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > >     drm/meson: use unsigned long long / Hz for frequency types
> > > >
> > >
> > > This patch triggers:
> > >
> > > Building arm:allmodconfig ... failed
> > > --------------
> > > Error log:
> > > drivers/gpu/drm/meson/meson_vclk.c:399:17: error: this decimal consta=
nt is unsigned only in ISO C90 [-Werror]
> > >   399 |                 .pll_freq =3D 2970000000,
> > >
> > > and other similar problems. This is with gcc 13.4.0.
> > Sorry to hear that this is causing issues.
> > Are you only seeing this with the backport on top of 5.15 or also on
> > top of mainline or -next?
> >
> > If it's only for 5.15 then personally I'd be happy with just skipping
> > this patch (and the ones that depend on it).
>
> It's already merged, and I see these errors in the Android build reports
> now.  I think they've just disabled the driver entirely to get around it =
:(
Can you confirm that only 5.15 is affected - or do you also see
problems with other stable versions?

> > 5.15 is scheduled to be sunset in 16 months and I am not aware of many
> > people running Amlogic SoCs with mainline 5.15.
>
> Great, can we send a "CONFIG_BROKEN" patch for this then?
In my own words: you're asking for a patch for the next 5.15 release
which adds "depends on BROKEN" to the meson drm driver. Is this
correct?


Best regards,
Martin

