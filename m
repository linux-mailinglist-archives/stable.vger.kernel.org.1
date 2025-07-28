Return-Path: <stable+bounces-164951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D63B13BFD
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207753AB6D3
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5372C26A0A8;
	Mon, 28 Jul 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McF/ff7A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDEF266565;
	Mon, 28 Jul 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710642; cv=none; b=asEw00TzixF1W0O/YJQ5VbOgtkBCRr8a5aRY2poWHfsKAFSR/NeV0VuOtZGppXUzCC1gU9e27YjJ3Gvgec5HZjpRmGgX31t/TEu0dbNsff+28VpzLnlPCLbtbPdEaJALnt93v/xJ5w/MzFmQVnx4x9E76dMJBRlrdcq1YUwnPoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710642; c=relaxed/simple;
	bh=bhC4x7+JbOnIulVeIOz2949cHf1+vhPQHCA4lWyGpw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlftstvN7o7mF7SceYZspGkw7nQizMZnI+8Oe3QFlRQ2kAcNsBSF479+x6VeIT2mAqkIMOA4D9vn9wniTS9bIErX3KgMX6gy72GN5ZvnwTKUeZynFymDaPvBc4H49xCoW7sCQIHumf14Sv2gZSCsJ7iLXZPiqRrn/Ft1Ac9lDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McF/ff7A; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-88bb987d8fbso203611241.3;
        Mon, 28 Jul 2025 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753710639; x=1754315439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht1Aj7iGWA998E0Nx4ezPZqar5kH28gypyAYAW14OsQ=;
        b=McF/ff7AuCOIHSakgYrYJy44M/b/sNvCIxyxyqla53zE8RAGEoTEBON9kBThWelypj
         TESWTIDU8qDxfu/9h6bSz6n1rfSVKAu5xLyNLjfccOtb73CjMzhQ4G5Slxqf1Ht/p8fl
         9d49aWwkAg2KsOgf8XPbjBMnC7cq7sA0oN9/NelisP1nbAqoG8Xh8f4A921e9aKoF2QP
         EJHSIY+Q+rD1Dl86wmm88VMf3kbII6bL/L4dYa8MHjduFVBjmzlIA1WGrrdQcr+EkkVP
         Si9OCosTJB5edFFXoZ+qWC2JJ93t+x3RlvH2htIIDTUB1NYEzhqJRKLDbk5An0dXyUWR
         Wx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710639; x=1754315439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht1Aj7iGWA998E0Nx4ezPZqar5kH28gypyAYAW14OsQ=;
        b=QEroI9hHK5FSSrewk/AQa6nLwvfIGLhuA2gaLYkSvdX3SCBDD93DP5LRj46o5gDS4+
         dIxkBisbIfOVo/b2uStZFcpM4oF3Rh80WiL3yTblo2yK+8iJZfUIKmHeJbL6ZW0uRwVM
         g91MZxPzzCaUipxf38gFlPNFbSJTtxLrJEk+cJudy1Hhjkk2r/n5PfBafAO8l3Pq6pvR
         M/b5yPvdHqO5SKrfm8unDlSs9aRRSiKl40hMX5GPQTHaTCqHk8t3Dqy9KGjMQDW1CZ4J
         n5qV61k4JCPiCQlFKsltDBI9Mxth9alNCXvvyWIt4u8c/TtCWSVHgCyi1b0KliyNYgMF
         K90g==
X-Forwarded-Encrypted: i=1; AJvYcCUinJIouzvOW52gMCRuKQaaA/hJPKmodHfHzgvAS4k++C2EcmgjFHMMAcy2HDoNzxHtpQIsdHFT@vger.kernel.org, AJvYcCWl7ndaLaFFV0pNS5mz+joR/+qcvDc9KySjw8QcHVQz0D71J34k2/ufSeFpJ9awlLW97/kUXeX8nhqN@vger.kernel.org, AJvYcCX8Yfest/ElwWjiXojJNixVuNfQCTzNYK1NQULXvUiJeSfKlvkfljaUx1f9dMgJOorPO3i87q6ton/vmjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwqf9YlObjJBNggVWQtFGkbbwnQ3KBSyOvJG1n8X81Vdcuk9NG
	j7JGE+lna/H73eYVmpWr3Zp9nzvc4BVHD80cvvTlnsNI/m+I8k0n0VtCNarA+iHIiOPDGqdul8y
	Z86i54JduCIDhgk1D1CTjjNy06/fz4vw=
X-Gm-Gg: ASbGnctXDDLWVGHX/aNeYMjeJtyFbEdlwHqikVLz2bLAHTjFW6U374IsqsErfpmRteJ
	IUyefOyeu64VEwDhReOdn6tufucdkMRNDc196fdpraCRQ/pF4kjE2AsVmDU+saBKH38G2n/5pRp
	6QxOoU1x8YJAxBJVJEUJ713q9U4bsf+UuDVRxM/gqj63ED5AdisI8bn47I6YPooYhmViX3vMKxI
	7YG5N73Wto0xsB4ZkP7HD68t5zf55yU512TTVMQshNPAAuLzQ==
X-Google-Smtp-Source: AGHT+IEbuvAO7GsFkENLN7i98TrLUe4nvWoSmscGw4QtLx/dlpzb0qkjTR5qsCD5f5HTLGXRTSgGxovBIxMaFJ0qK+c=
X-Received: by 2002:a05:6102:358d:b0:4df:4a04:8d5e with SMTP id
 ada2fe7eead31-4fa3fa86718mr4103173137.8.1753710639152; Mon, 28 Jul 2025
 06:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725105257.59145-1-victorshihgli@gmail.com>
 <20250725105257.59145-2-victorshihgli@gmail.com> <900a4f9d-a995-4142-afa0-b06012854ca3@intel.com>
In-Reply-To: <900a4f9d-a995-4142-afa0-b06012854ca3@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Mon, 28 Jul 2025 21:50:26 +0800
X-Gm-Features: Ac12FXziLOQDkt6o2wD6lPZShOotf8x8OB8Gys9lg7cJVoE_pW64THboqWU9FEQ
Message-ID: <CAK00qKA9EP2aV+P5XeeO2T+Vrc5wXv8Yt73b65yKNKgmkt3zRw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: sdhci-pci-gli: Add a new function to simplify
 the code
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 2:55=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 25/07/2025 13:52, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
>
> Need to explain in the commit message, why it has a stable tag, say:
>
>         In preparation to fix replay timer timeout, add
>         sdhci_gli_mask_replay_timer_timeout() to simplify some of the cod=
e, allowing
>         it to be re-used.
>

Hi, Adrian

I will update it in the next version.

Thanks, Victor Shih

> > Add a sdhci_gli_mask_replay_timer_timeout() function
> > to simplify some of the code, allowing it to be re-used.
> >
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> It is preferred to have a fixes tag as well.  What about
>
> Fixes: 1ae1d2d6e555e ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E supp=
ort")
>

Hi, Adrian

I will add this fixes tag in the next version.

Thanks, Victor Shih

> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 30 ++++++++++++++++--------------
> >  1 file changed, 16 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 4c2ae71770f7..98ee3191b02f 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -287,6 +287,20 @@
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > +static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *dev)
>
> dev -> pdev
>

Hi, Adrian

Sorry, that's my mistake, it should be "(struct pci_dev *pdev)".
I will update it in the next version.

Thanks, Victor Shih

> > +{
> > +     int aer;
> > +     u32 value;
> > +
> > +     /* mask the replay timer timeout of AER */
> > +     aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> > +     if (aer) {
> > +             pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &valu=
e);
> > +             value |=3D PCI_ERR_COR_REP_TIMER;
> > +             pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, valu=
e);
> > +     }
> > +}
> > +
> >  static inline void gl9750_wt_on(struct sdhci_host *host)
> >  {
> >       u32 wt_value;
> > @@ -607,7 +621,6 @@ static void gl9750_hw_setting(struct sdhci_host *ho=
st)
> >  {
> >       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> >       struct pci_dev *pdev;
> > -     int aer;
> >       u32 value;
> >
> >       pdev =3D slot->chip->pdev;
> > @@ -626,12 +639,7 @@ static void gl9750_hw_setting(struct sdhci_host *h=
ost)
> >       pci_set_power_state(pdev, PCI_D0);
> >
> >       /* mask the replay timer timeout of AER */
> > -     aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> > -     if (aer) {
> > -             pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &valu=
e);
> > -             value |=3D PCI_ERR_COR_REP_TIMER;
> > -             pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, valu=
e);
> > -     }
> > +     sdhci_gli_mask_replay_timer_timeout(pdev);
> >
> >       gl9750_wt_off(host);
> >  }
> > @@ -806,7 +814,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_hos=
t *host, unsigned int clock)
> >  static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
> >  {
> >       struct pci_dev *pdev =3D slot->chip->pdev;
> > -     int aer;
> >       u32 value;
> >
> >       gl9755_wt_on(pdev);
> > @@ -841,12 +848,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slo=
t *slot)
> >       pci_set_power_state(pdev, PCI_D0);
> >
> >       /* mask the replay timer timeout of AER */
> > -     aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> > -     if (aer) {
> > -             pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &valu=
e);
> > -             value |=3D PCI_ERR_COR_REP_TIMER;
> > -             pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, valu=
e);
> > -     }
> > +     sdhci_gli_mask_replay_timer_timeout(pdev);
> >
> >       gl9755_wt_off(pdev);
> >  }
>

