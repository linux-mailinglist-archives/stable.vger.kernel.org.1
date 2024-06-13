Return-Path: <stable+bounces-50719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ED6906C27
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598721F21A73
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD7213C805;
	Thu, 13 Jun 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2r2oqPX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12613D624;
	Thu, 13 Jun 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279189; cv=none; b=MgQEHSCh4zf4kGILU4EisJGaOfDEFLaOfJq2r0OLessAfV7xFMFFePHfjKt8s5Y8vjNQonw5Lcz3fM9NeoHob4UJKlo440qZuAT0BQF9XiEUlQ6vu2jvucVDGeWEp/30JEoq2fQ0O2ZHqqRHpAdNQHL8fLXCSjIOgx2Atu5HPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279189; c=relaxed/simple;
	bh=XL5bLefMESkGprNixyB/mXYAJulY/6UDjT3qRR8obhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+e1DKL1GmxZ0TfVyD8lWuMTJxDY2ccmvobTcrWxqX9cFVdpm4c2GNbKrZSlci2o8AjzQtyBlzoWoRzmqyaKnDGLrOCdXYTVwaLQYXuXwKeWCr1pc1nW3q2AlHX/4fKPXV++Bz05kIzXkRTEeeNv84aL9np3XODru5eIDXI3Bf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2r2oqPX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso106517466b.0;
        Thu, 13 Jun 2024 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279186; x=1718883986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vYosH7aQ7gj462DMyx1t1RhUFmgYdVe9MWybhGXFWA=;
        b=k2r2oqPXRaxpqdkdedphQPkGZXZvuHHdjMDPggVH+ls3Yu64gByKM4D1ZjFJb/PUwr
         silYrWaORbDQjEg3Nc0YOqbyDZGzV2KYFBtHfQJgr94vgLg+gwZKxCeE6Ce12d3PPbEz
         yEZ2Ryg0Zf4WSzzN812prE+fUrxlEnQSB/tRrwDf1mFCz/Kx+Zxy+xYx+Ffgib9xunGC
         nIg5piD1R23GQUN4mz9OCRAEboqKCWa33gn0vmoQgyRj85aLBMEbTySUHJ3PvGdqEdJu
         R+FMXVuq0BkTiWxVdGtKGMuzlWX7w4qCsyqQrLrEQeX9BHyuxncPiYplFX4XVNyTJ5si
         FfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279186; x=1718883986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vYosH7aQ7gj462DMyx1t1RhUFmgYdVe9MWybhGXFWA=;
        b=Urigf9EU0pE9WkJyimR+PnZtiMxBfyId7IXn4OmhEiMV8U5DNlwcK/FPkPWeAc/2s8
         uAa/ILgCMBoGP3b7RR7mxQ+kNAa5wMqsYyI3fZv3t3zkNRFlAMAoEz9B2jXJ6Ix7+X88
         WCIw8tQ9dqQzOBFS861pIKcDx53j17O6WyduLU8uk98gH1MxKLBH/GOXcqBsUAbBEBiS
         tz0WLLsX6Oyd/9HRUWJ1VPNR9YyCGl6+qSPRWe4MEFGyqUW6Ysb+BJy/YTvl4TDT35wv
         w2c6octZvQyoWPPEoE/FBDMC58yVUeWaM6iQE2MlLrfAlLCp9FI3B/F3RxF9hks6WDcm
         vp9w==
X-Forwarded-Encrypted: i=1; AJvYcCWXOR4xGKx9Jg07N707aTdMlV/s6aUw7VOJ174vQPmZyw79eZSgTCf/35o5M8GOf2ckVmcynoUlhxW7Ihj/gqnvpBoper6vPkTi3GUa+nvmYSxRV9jgfygeIWuJajXCZAStgWwV3/j+Id8YUAH6f5ilY+OCvcrbzAL81sKSvlpx
X-Gm-Message-State: AOJu0YyEhrft+uNnhcjs3AaW1q0W6H9s4WBjOty1nQXPInJEMWBgGheA
	LwLBuflVVws2ubGfJmo52NVXtoGzrWbQ8t1UN2EdtrIIWMnVsWf7UYtnIitbQfCakz82Au41e7c
	MmcDk2BmK8Pw75ZNbQIicYD4uk10=
X-Google-Smtp-Source: AGHT+IF5r80EbGny6WBJIFoR4Q7nNI93cgnqLPNyWt21N0qDvZSFHgQwtrvWP/eyDmYl+2kXuJgiGRi4UlT5k9PxIUI=
X-Received: by 2002:a17:906:d8ae:b0:a6f:4be5:a65a with SMTP id
 a640c23a62f3a-a6f4be5a7b6mr279101366b.45.1718279185681; Thu, 13 Jun 2024
 04:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240612153922.2531-1-joswang1221@gmail.com>
 <2024061203-good-sneeze-f118@gregkh>
In-Reply-To: <2024061203-good-sneeze-f118@gregkh>
From: joswang <joswang1221@gmail.com>
Date: Thu, 13 Jun 2024 19:46:14 +0800
Message-ID: <CAMtoTm0NWV_1sGNzpULAEH6qAzQgKT_xWz7oPaLrKeu49r2RzA@mail.gmail.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jun 12, 2024 at 11:39:22PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > This is a workaround for STAR 4846132, which only affects
> > DWC_usb31 version2.00a operating in host mode.
> >
> > There is a problem in DWC_usb31 version 2.00a operating
> > in host mode that would cause a CSR read timeout When CSR
> > read coincides with RAM Clock Gating Entry. By disable
> > Clock Gating, sacrificing power consumption for normal
> > operation.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> > v1 -> v2:
> > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch,
> >   this patch does not make any changes
> > v2 -> v3:
> > - code refactor
> > - modify comment, add STAR number, workaround applied in host mode
> > - modify commit message, add STAR number, workaround applied in host mo=
de
> > - modify Author Jos Wang
> > v3 -> v4:
> > - modify commit message, add Cc: stable@vger.kernel.org
>
> This thread is crazy, look at:
>         https://lore.kernel.org/all/20240612153922.2531-1-joswang1221@gma=
il.com/
> for how it looks.  How do I pick out the proper patches to review/apply
> there at all?  What would you do if you were in my position except just
> delete the whole thing?
>
> Just properly submit new versions of patches (hint, without the ','), as
> the documentation file says to, as new threads each time, with all
> commits, and all should be fine.
>
> We even have tools that can do this for you semi-automatically, why not
> use them?
>
> thanks,
>
> greg k-h

We apologize for any inconvenience this may cause.
The following incorrect operation caused the problem you mentioned:
git send-email --in-reply-to command sends the new version patch
git format-patch --subject-prefix=3D'PATCH v3

Should I resend the v5 patch now?

