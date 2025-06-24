Return-Path: <stable+bounces-158389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6FFAE64C5
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5169C1BC2609
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AF6291C2A;
	Tue, 24 Jun 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2/92yD9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D251291C08
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767625; cv=none; b=KrLnxjCE8J97JZ1Rco/dxBmz8Wq/RrWMc8wSH07rRd95kjskny5IcSqyIKYP/S3KCyXsGjzPbB4vIEkk7q6GAkNDQOHwMpuA9pTlLwIsTZfQ6ndx3u/wWAk0BzWp5B2MamQksrlMbcctDxGiBpZIR0W/uNkqZJNdG8OFtS/kRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767625; c=relaxed/simple;
	bh=GZ/5iwl8ZZPmakE+efLtYtbJJP7cX9eI0cexO3y8u8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNaIbVr78Y+9wRd3KPsan858JOPztMgwagQGlXSAbj+yujOA1/tUlcBU68WQ6ObU8PG7O2NSGytGWmxnyl8bBG989yPDhTuJ0wn3GkLUy1u/HN8LI4p/ijZJeEM1RrU/QHMjHL+2U6gCS/igErIDB+w3u2m2UKsa30jWMRvlYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C2/92yD9; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so1662740276.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750767622; x=1751372422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=17QGHlSSDUGN/mqnXiKE0ZuW4uit1RiwoU2bfSWcixE=;
        b=C2/92yD9YxFTmpln1Dem2TL+U8jjm47uGjWuICg65ONXV/WmY0fPgpdVwVS0sYH4qE
         /dzURNyUO8OETR+8MSkxccqlkxdSrER+Rzi7GJ0OyQUwvkh7vcPRZm7c+y/kaTge3FHE
         ZJsDmyQRu/3hjXK5Ir8KRoWo8dlVZApl83I/UcHCaG5W4eewMJhJNAVoUs74hTOdRHOt
         6w1vdfVk4GRdOXtFLc+c/k4dD/Umk7MtXcIST4QvBqP00MhDHCJoa5BTUIVOCo5myZR8
         +K53RkAaQa8bsL7PNYFMj1r7h/g8Nez2wl7PwxQuxWvo1GbBcXlTn4t/Yzs8pOry3IrT
         mA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750767622; x=1751372422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17QGHlSSDUGN/mqnXiKE0ZuW4uit1RiwoU2bfSWcixE=;
        b=apPo6Feo2l3N2obAnL6Qyu6mMjBaK+PCOzjapOBIJ0K8RDKbnm+lYKci25VgVqlvJH
         rgCPh/cLBLozneBj5JJyfKDBT50XznQorRvPl/eVAehoJAASKho++CRj2PaacOXxtUqE
         EgTlQGrb+fVKtsLSsJ3gdWL5FtrXhMo74BjyXEEzW6+++pLiDoif85Ovf/mNEHgGMKPO
         GlVCpzkv+KPPn9qzfnG4rDlDb9sSJrSISKuRRUAE9SG85rsMBDG/fwDuDTPHYjG3NyWX
         zNQVSdYyWt9A32nSRBisykfNUjtl5MwFC/MovM4ZlEcPdeLOKBazte3hhXbDOknZjA2z
         iy4A==
X-Forwarded-Encrypted: i=1; AJvYcCXB0z6EbUv9HIsK8ODCEgpcNBjt1KqehlcLAj9A8/Cnn2LQ8ztyvDE30SjoJdP6gD7GkYSdyjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfXB/FBiMpT4o9RyBuLWGKJTfofsSmJMSYbVkVSowPQTY2btz
	jtsK6Xp1WbGcxtIKdLxigCoB1UdAc1OnSsR9YBPXhlNIgnhvBxBZJ5PBDtjzTYCfc7LM7Y+k5Wm
	XNcupCtgrCB/v0uozPeEll3Iz+1SkPjRp58UpdCExN0xu305xvA3+
X-Gm-Gg: ASbGncsnXa1YcfKB3RtlZoDtZssc6l5pUQbyGI5X5cwTTHromiN9nj3hhNyuVBi4EeP
	bSYSTWfZlUmUf+jgyJLxQAxgPhtNdVJh/wEcte5ZUu2bfH5/qhYti4l4jAx82hRCkjwFZ4uyANn
	RfUF88r9ULQ5J9QvlFaTk+qCrK16R0S4D9UfCPRdSClmtv
X-Google-Smtp-Source: AGHT+IGPTctpVVW06WOrtz3efzF82iIEaeDrUDN4ojSw3HrQtEK0IapvoQQeUraQNubsJNcTfkjZNirZjEE8U0ZxCKI=
X-Received: by 2002:a05:6902:1207:b0:e85:f1e3:81c0 with SMTP id
 3f1490d57ef6-e85f1e382b6mr4407587276.5.1750767622430; Tue, 24 Jun 2025
 05:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624110932.176925-1-ulf.hansson@linaro.org> <a0343926-1495-4766-a7d2-108d40fe9ea1@intel.com>
In-Reply-To: <a0343926-1495-4766-a7d2-108d40fe9ea1@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Jun 2025 14:19:46 +0200
X-Gm-Features: AX0GCFvm9jdM9vz3y8zmX9_7oU6NfR6QW6tWLObXhLGRJNwV8Wj0thFllf6dB0g
Message-ID: <CAPDyKFpFp=ONrpcfuK1K-GzhR81PxYBBNhjQxkHZwO86iw1KdA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci: Disable SD card clock before changing parameters"
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Erick Shepherd <erick.shepherd@ni.com>, stable@vger.kernel.org, 
	Jonathan Liu <net147@gmail.com>, Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 13:30, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/06/2025 14:09, Ulf Hansson wrote:
> > It has turned out the trying to strictly conform to the SDHCI specification
> > is causing problems. Let's revert and start over.
> >
> > This reverts commit fb3bbc46c94f261b6156ee863c1b06c84cf157dc.
> >
> > Cc: Erick Shepherd <erick.shepherd@ni.com>
> > Cc: stable@vger.kernel.org
> > Fixes: fb3bbc46c94f ("mmc: sdhci: Disable SD card clock before changing parameters")
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Reported-by: Jonathan Liu <net147@gmail.com>
> > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > Closes: https://bugs.debian.org/1108065
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Thanks, applied for fixes!

Kind regards
Uffe

> > ---
> >  drivers/mmc/host/sdhci.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 4c6c2cc93c41..3a17821efa5c 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2065,15 +2065,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >
> >       host->mmc->actual_clock = 0;
> >
> > -     clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > -     if (clk & SDHCI_CLOCK_CARD_EN)
> > -             sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
> > -                     SDHCI_CLOCK_CONTROL);
> > +     sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >
> > -     if (clock == 0) {
> > -             sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > +     if (clock == 0)
> >               return;
> > -     }
> >
> >       clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> >       sdhci_enable_clk(host, clk);
>

