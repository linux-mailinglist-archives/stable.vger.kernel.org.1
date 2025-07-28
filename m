Return-Path: <stable+bounces-164952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A608FB13C03
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBA43BF7FC
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700426C3B3;
	Mon, 28 Jul 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lswWSGPY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634326B74A;
	Mon, 28 Jul 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710646; cv=none; b=GRg1EJYt90wufDM7RImv/r5YONqsbW7Arnk/a8wwxWZ7eydcUZ1VCBdwvG6fJglsAbE7qNzggb7lFWbz4/FuCjhFPav7DOuoR2FFBhJsptT1k81xkItuun3K3J4q4PI8F2g69rhpqO1DcJeUkUETU3/ZyeVNC+Ze/n6PGe+pmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710646; c=relaxed/simple;
	bh=Ew/5uGcU29CC/VBf0ilfFpJ+h71CrlpHuq+m9f9/6Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2axEEok6i3U832LEMqgJMLUgnV9W2NWGXgHNvHOuvqdB0Zz+nN4Qfbi62Dm04d0xMUiy2O+1zfaN/Mfbl3BMsT9Vb6+Ao42/Ty062Z0AK6q2ZyUWeFgADPjU7bqAMpCp3HOKHqMQzNWAgXmlzaqL9TCH4swH9LOcWoIZCVoaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lswWSGPY; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87f30519147so848810241.0;
        Mon, 28 Jul 2025 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753710643; x=1754315443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kh+mA7QQJ5nSegEvrTlMVoCkxV6V9qWogl4zFBj3pA=;
        b=lswWSGPY9GPQV9NVYMDERFrASrYSAYltPWS+dHDHKS7uHt2FUJ9Um5qyk7iaxCISzA
         BJLTAEh9kNBe7tdhoHQFxIpouQc1oKY9xqhOlK6BnPcayDVa6Ab5EL1k4ofNXBImdAXq
         lxaN7uZcO2DklYQMTgTMxrES7ec6FXJAl0vdctZ+2xtssnnggUrqP2xqb1f8NM2WTS+/
         U122+iqqSPVALaq/yfvq607B/OJt+PJxO9/d7cSBETVOmD9hSSCKRUAQ9kQ3wfUWMsGP
         /ExaNqIPrz6W8XIeFdZAOyy6zOdkUpr0LdoeaMQh5xtG8ZjaZedyhu7X8yXedwIUahuy
         5PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710643; x=1754315443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kh+mA7QQJ5nSegEvrTlMVoCkxV6V9qWogl4zFBj3pA=;
        b=QZ+cwIRK4ZM+bFzqfvXCCiA3zsCtzp7dxgaa6SAVeWgElKFgL9hg8mo/WRiN4xnVZx
         RXYftIH0Rl6jt+Tk+8PLTaqXeaFeUCcb4zmvndjDNLb6xlL4e3AzYJFruaP1ZFkfXkG0
         gjIl1j0QXPiAbzFn/EAfe4SvqyqpftKtcDkVbJ1haXRpPmodbVbEjNVsvg3F6NazKcJz
         sQ/1MBkzipZTKGhMvAR1rr6xwsCUfgGD1HJ5PqIOtLZl+Cs0IY2whIlY/IHACsD9NZ31
         rQQqqhrrKig9UysCksDgW96dvbAlH0Y5FXrB7Tc1164v5/cjeZSEGX65Va3N0PUNYr0z
         8ZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW777Ofa6mHGhWjOCE3KmXPKSZ5TasdSd4cAMcHzMLV6qeJ0QvzgctJsep3kpOdo97nacyQK2iR@vger.kernel.org, AJvYcCWzN9xdEQH64aZl//s7uVo+1OzfKzNTY8um0dTfHAvLfFBbR7/Ni9aQa73dTQ/qdmW1aMqY03U4QPYMD3s=@vger.kernel.org, AJvYcCXjGCkSWKZ6PZvJFBut4fXf7fo1DiUaJdKdc4GGxJkKJQY4v/gQTHyw2Q1tsTV5c2z8AsLspu8XSr9i@vger.kernel.org
X-Gm-Message-State: AOJu0YxyO8Gq+tVbTLXsB0MwZe8dvbRotDGW8AxKlav22fsBbgbOTtfb
	Hw7nA3YlMcVGnkRrBDsX3bKBH+iuDBZ8yYtdjGuTKMyeh+/KRqNLrrp84Q+4Tew7ALbzwYf1Jho
	aF9ZCMfdTuIVbGi19x4L4K7k9YDnjeYkAiQiWrDw=
X-Gm-Gg: ASbGncuMtUwnf7NlgGeMnaDjFcAEVsnz0WDIoF6PnTfJGgUmBg6+pPM2NPBxgGDbY+S
	E0PWecSwahJJ0ky3pszW4gnZlnAOm85auc0KptASJY9edPzWqt4JpW4PLSlbOVSwqPVGwzeDYml
	apO68IJ2CDC3AszlCXCwE/ok/Nf1kmJuqlQfwmfE/XzwP/iy2SJzUFdapu2+sL1Dx4zT4D62g2W
	SJwJrszCj8rAOzc8y73G5aIv1TKP5K9yPv9LBn52ouvOJz/pg==
X-Google-Smtp-Source: AGHT+IHJBBtjb1Y9fQoUi6WM//B4rhMfxfHVdmxrGSYYFRvp0hQdEX54+sWEpSUJimUGGYU65XCzbrOaZ/o6B9v2P/I=
X-Received: by 2002:a05:6102:a4e:b0:4f4:b401:d04b with SMTP id
 ada2fe7eead31-4fa3ff5fb99mr4243957137.20.1753710643004; Mon, 28 Jul 2025
 06:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725105257.59145-1-victorshihgli@gmail.com>
 <20250725105257.59145-3-victorshihgli@gmail.com> <ffec6f56-bdae-4821-adfc-c6f0323620f3@intel.com>
In-Reply-To: <ffec6f56-bdae-4821-adfc-c6f0323620f3@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Mon, 28 Jul 2025 21:50:29 +0800
X-Gm-Features: Ac12FXw9qJF61fOioVohOP63DZWfVtI09Nsz9chG-pOpWFLpS770t1ew-d6leL0
Message-ID: <CAK00qKCovgpgYZVNQhJZ9=5BBVH4ngGnD6MYwfxrzDuOe0f1Ww@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer
 timeout of AER
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 2:56=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 25/07/2025 13:52, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Due to a flaw in the hardware design, the GL9763e replay timer frequent=
ly
> > times out when ASPM is enabled. As a result, the warning messages will
> > often appear in the system log when the system accesses the GL9763e
> > PCI config. Therefore, the replay timer timeout must be masked.
> >
> > Also rename the gli_set_gl9763e() to gl9763e_hw_setting() for consisten=
cy.
>
> Should be a separate patch
>

Hi, Adrian

I will split it into two patches in the next version.

Thanks, Victor Shih

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
> >  drivers/mmc/host/sdhci-pci-gli.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 98ee3191b02f..7165dde9b6b8 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -1753,7 +1753,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot=
 *slot)
> >       return ret;
> >  }
> >
> > -static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> > +static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
> >  {
> >       struct pci_dev *pdev =3D slot->chip->pdev;
> >       u32 value;
> > @@ -1782,6 +1782,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot=
 *slot)
> >       value |=3D FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDL=
Y_5);
> >       pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
> >
> > +     /* mask the replay timer timeout of AER */
> > +     sdhci_gli_mask_replay_timer_timeout(pdev);
> > +
> >       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> >       value &=3D ~GLI_9763E_VHS_REV;
> >       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> > @@ -1925,7 +1928,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pc=
i_slot *slot)
> >       gli_pcie_enable_msi(slot);
> >       host->mmc_host_ops.hs400_enhanced_strobe =3D
> >                                       gl9763e_hs400_enhanced_strobe;
> > -     gli_set_gl9763e(slot);
> > +     gl9763e_hw_setting(slot);
> >       sdhci_enable_v4_mode(host);
> >
> >       return 0;
>

