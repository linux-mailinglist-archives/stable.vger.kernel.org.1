Return-Path: <stable+bounces-88228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B969B1DA0
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 13:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6790B281BC7
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5E1531C1;
	Sun, 27 Oct 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cOLKETCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C43210FB
	for <stable@vger.kernel.org>; Sun, 27 Oct 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730031394; cv=none; b=S1OmUf5lGFoKl6k2X0mbthlYcycSOP6FlcAO7Se5v7uXNssZxUTU4Twbl/30U6yd+TID9C9bfybux8I4USlOtxST8YzQa9Q1YTZtinX4ijdxF3W9ZaxrgydTvs4IihORke6VSd//JBZ6pifi24d2TDTYh7I5Q4n4rRQFKsYyMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730031394; c=relaxed/simple;
	bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXqoTI2M+/Aabnv6bN/Gotxns/E4UT9ayv4Qc9qcwWhzt/vzGhVcTRnOjmtJ53SJWma4P5ULMrJSOpudgjoKhnoPg3WjQRiio7wHhsBJWhQKPobDrmFEJ1FWcVD5S4tuENSbKONYcL920CaSCY2JNUIylGNUCpRRO3ukAUBpWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cOLKETCh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 611F73F2AC
	for <stable@vger.kernel.org>; Sun, 27 Oct 2024 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730031383;
	bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cOLKETChPWegF2Gj202JyGVIBA9x2m5mL0IIQ4F7z6tIlPdKlGGIZ582GF91zbQzQ
	 AvY3uyNm7E2i1Y+U8acTQ6vuP1P3kn0D3uBwsjQcEdD66Ws+I/K5Afx5PFZjuwW5al
	 w06UzVSxpMI1qGaLu3ewpSGqtqV6zHzSNQg7MU1C01Se8O7cR90BH0eSrBmZ88GfpM
	 PzsiijipY8pD4p2OdTLI8xjEqc0vq02hpT8proFNfzIX+4x/jxrQLpyXfJY7k9Uk5D
	 zwD4DQiYSXauEYALxMgU0NYcBoq5C/abZUaTTTgb46YhoevxoDlziEHl5xIupTAUn0
	 mnWlByFrw2oNg==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e60970ed1dso3354045b6e.0
        for <stable@vger.kernel.org>; Sun, 27 Oct 2024 05:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730031382; x=1730636182;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
        b=ErrDXj7vCUghl/sEdpuvh8fV19kMxV18aVoxDCHHmcAPlbuqhkwIKq1wmdTJv2evlf
         utls67Z47Vw+7P/Z8nHF3ST6tUFnT3qftBKv/dJppihUMjKf8jofQlCSabsn51JsgcLr
         Dcr29ifC5BB83i8KcjSOT2sXpmY4dAX37gH5Nl/u1XW6aRtQJxVWRdJdWL1AoZl2pCAK
         cxJeFfxOrdXp2oEDe67ZJsKATIDUpUgbHE2mDqAkRMwp91rAcLa9Xl02oTotJAyLFRQ5
         oD7x0FH0JKfG2+n3qWq1q9XUGdJ3fUcmv92h4N3cqcUBGcnwSja0wPfAZbsrDJLO/p9R
         nOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfF4lgBzB/vIj1v3FjRD75iGKTIyLxSMOrDAayiYCvzDUYX1dc4o+dP+OtcTu5JK/U2GWkEmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78Ej7pv6x4+AFOPdNTdPx6JpW1cCnMdWgij5hNlSlT4C3oZTB
	Rq/3+SUMGGKjqpMZ9qrmh4Uus1qE+yaixWshjc4Q+eHaq+hkpTZTx/kI/SAovvCZGrvzQhXPwfw
	K+3vw9snYYsrjic5z/A99DjMpB2di7lQl588bren+xTPzgceyLL1DmYD9Z2iMhPucJ9+1M0RQZD
	/Jet0V7dsXjm5PfFffwIvf07GKxBBeSOPBeakCrGiUjUi/
X-Received: by 2002:a05:6808:6492:b0:3e6:3ab2:3949 with SMTP id 5614622812f47-3e63ab23f2fmr1443461b6e.44.1730031381739;
        Sun, 27 Oct 2024 05:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3/p9UcQsOIF9XDrRaePo4CLioUPmMFOdhHm0S4hnuRvPrmJfiLwq408uv86dDavZhe/zgtp+drnC/1fSJ30k=
X-Received: by 2002:a05:6808:6492:b0:3e6:3ab2:3949 with SMTP id
 5614622812f47-3e63ab23f2fmr1443454b6e.44.1730031381414; Sun, 27 Oct 2024
 05:16:21 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 08:16:20 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAPDyKFoQsf89NeX28ms7FtM0QWNqYQ5xtt2=+G1JNCVi2z9=dg@mail.gmail.com>
References: <20241020142931.138277-1-aurelien@aurel32.net> <CAPDyKFoQsf89NeX28ms7FtM0QWNqYQ5xtt2=+G1JNCVi2z9=dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 27 Oct 2024 08:16:20 -0400
Message-ID: <CAJM55Z_CU5rwMBm7n10jhGk57_T_HWLKYrYaGoc7qvK9irT5yQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: take SWIOTLB memory size limitation into account
To: Ulf Hansson <ulf.hansson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: William Qiu <william.qiu@starfivetech.com>, 
	"open list:RISC-V MISC SOC SUPPORT" <linux-riscv@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, 
	"open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Ron Economos <re@w6rz.net>, Jing Luo <jing@jing.rocks>, stable@vger.kernel.org, 
	Adam Green <greena88@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, sydarn@proton.me, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Ulf Hansson wrote:
> + Adam, Arnd, Shawn-Lin, sydarn
>
>
> On Sun, 20 Oct 2024 at 16:30, Aurelien Jarno <aurelien@aurel32.net> wrote:
> >
> > The Synopsys DesignWare mmc controller on the JH7110 SoC
> > (dw_mmc-starfive.c driver) is using a 32-bit IDMAC address bus width,
> > and thus requires the use of SWIOTLB.
> >
> > The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> > bigger than 4K") increased the max_seq_size, even for 4K pages, causing
> > "swiotlb buffer is full" to happen because swiotlb can only handle a
> > memory size up to 256kB only.
> >
> > Fix the issue, by making sure the dw_mmc driver doesn't use segments
> > bigger than what SWIOTLB can handle.
> >
> > Reported-by: Ron Economos <re@w6rz.net>
> > Reported-by: Jing Luo <jing@jing.rocks>
> > Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>
> Thanks for working on this!

+1

> Looks like we have managed to mess things
> up. Besides the issue that you have been working on to fix, apparently
> there seems to be another one too [1].
>
> Unfortunately, $subject patch doesn't seem to fix the problem in [1],
> as has been reported by Adam.
>
> I have looped in some more people to this thread, hopefully we agree
> on how this should be fixed properly. Otherwise, I tend to say that we
> should simply revert the offending commit and start over.

Yes, unfortunately this patch also doesn't fix MMC when running 6.12-rc4 on the
StarFive VisionFive V1 (JH7100 SoC).

/Emil

