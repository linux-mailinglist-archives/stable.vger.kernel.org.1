Return-Path: <stable+bounces-47558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A38D178F
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 11:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F277B221D2
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10226167266;
	Tue, 28 May 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhvQPAU5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA0155A4F;
	Tue, 28 May 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890021; cv=none; b=KO05OR4DxBPJ9bOYY4BMgUXZgBc3OlNY5zm9NC7M73LY0AJLPgOoYRFoUSWXHIOm3p0zIwFBoPB9cfHyWg4h6tNXlBIWfoduaKKI8joLuiACIOGeZLt9UlG96S0fe+Jfh1LVwp+3iYxb81mDsFt9DdnNtXxn9e8ebrREPiiH6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890021; c=relaxed/simple;
	bh=DwfIAvsMEGgL3IsgcE5uTNC+iW2pyzp8jO+8/qVFFIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGV/xiPAChJ6Ran5P76sAwLjfZ3284b1KMzFYDkYKFoFzk6htGqu2MzvdsVw8sZevW8i67M6IVRhWR10hqjDBCY+vpXx+SIbMeOtM9J/7DwPGsX7g8a6SNRBQUJvtDKq5w2RxBmS9id7nN8yL8t8RWs4QIUcHLL9O4WOi7nrab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhvQPAU5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2bdf439c664so135062a91.3;
        Tue, 28 May 2024 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716890020; x=1717494820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+CCht/uzDQdeE2w0O397gKXPjOgO9WVTzuCP3Dzrjg=;
        b=JhvQPAU5FXyR85iBSNtkrpU/lo8Nfm3lqm4JOH4796EZw8Pt0SvzqXl0zufjtm6uDP
         4bep6iIUyOvlpchLXb7BDtl7ofxlxZfF9hG1I1v7U80dLxte5f8emWaVAG6oG6MEWb7i
         Mlp3DfYK7JVqBaF9QTHrCYZolgHEopNdrxIY3scev0wLic3yTCuHkIZZuhXyQOzUXzdg
         zwVsAM2uXppMQ0/QIeSAIxmudXB4RPLN4en9rtjQjsOsG58pmSOqAX3Hq2YDUjF07jFe
         zHNlHHUVhx+140bfQQChaSpocYt/FiZlAk6k6Ibt5I+2CUgkTWpnbmDamBACVzOi1wLC
         5pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716890020; x=1717494820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+CCht/uzDQdeE2w0O397gKXPjOgO9WVTzuCP3Dzrjg=;
        b=V70WMS4ttYbC/6wmfYUd8Q6BWnaiYmD+pdVtns0F5RDEjhiL96jWHBa+yuHPWjayrm
         9D/x+21bWzaLrEte2/KsWuNsJUThwBaLzIIogSLREceRUDA0DQ0aqeIVgvyuMzbOXJKO
         BrHdlSJckitjpwaeCoHba7+UlxIrF6TzPJJ5gH6eZ2tMU4Hp8xJzKn2vlWUFGdVOCNe2
         FC9/npE0p9dhFuMuB3M+M9BjczuzlFoYYDVEmX3nBEtS3AOgJE7T9qN6+44JmyDwVjrX
         oBs+CuH+S+savg/hFnjLQ6L3gO7wCfiHft7XAAP46Y4oaIOZZmUzhhhK6rnDCez7swEK
         Ugyw==
X-Forwarded-Encrypted: i=1; AJvYcCXAxRVIb/4GNEoS4P71gle34B/SGfq0KG6iQGAeFi4LKQM1sA0C8OkQfVqszsl7LhbYfJ3h7TvN476yL32mvcb2s2wDH8F71a0kEYAIuZuIjd76FmvQZfE5ifllHaJoOeHtuX53pbz/pIhN0Fm+ec1KaFRS9jERzhQfn8wEaTjt
X-Gm-Message-State: AOJu0Yy7gkxExiyGHpBKdJ7YPKT1+KTaR8iwyR65keOmnXimmMh9bpe8
	Bowi8uWWPEKfhzx4Eisep22ankZDmDF6Jmcfq5yIHIR/acYYP6L6TLx/M+3HmN9vUFNSalbXX61
	ePmDvKUg4Ow44tgKWtT/pdG0H+eM=
X-Google-Smtp-Source: AGHT+IHcgkhWTP7zQpBfwy/dk/Ap1StaEOdZbXvZcs6NZFmo8RT5MAGq+ZerxzKxqaHRUdfdyOHLY45RAzsh7bwMmpo=
X-Received: by 2002:a17:90b:1c85:b0:2bf:eddc:590b with SMTP id
 98e67ed59e1d1-2bfedeb9d57mr3176120a91.1.1716890019935; Tue, 28 May 2024
 02:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528033136.14102-1-ki.chiang65@gmail.com> <20240528033136.14102-2-ki.chiang65@gmail.com>
 <40d075d0-7075-6ece-ffe3-797d7b49db4a@gmail.com>
In-Reply-To: <40d075d0-7075-6ece-ffe3-797d7b49db4a@gmail.com>
From: =?UTF-8?B?6JSj5YWJ55uK?= <ki.chiang65@gmail.com>
Date: Tue, 28 May 2024 17:53:28 +0800
Message-ID: <CAHN5xi00mi7T2M9Bj+r9b1gpw2YX5bfXbUzj5ocTSFLBQjpfuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI host
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

Sergei Shtylyov <sergei.shtylyov@gmail.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On 5/28/24 6:31 AM, Kuangyi Chiang wrote:
>
> > As described in commit c877b3b2ad5c ("xhci: Add reset on resume quirk f=
or
> > asrock p67 host"), EJ188 have the same issue as EJ168, where completely
> > dies on resume. So apply XHCI_RESET_ON_RESUME quirk to EJ188 as well.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> > ---
> > Changes in v2:
> > - Porting to latest release
> >
> >  drivers/usb/host/xhci-pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index c040d816e626..b47d57d80b96 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> [...]
> > @@ -395,6 +396,10 @@ static void xhci_pci_quirks(struct device *dev, st=
ruct xhci_hcd *xhci)
> >               xhci->quirks |=3D XHCI_RESET_ON_RESUME;
> >               xhci->quirks |=3D XHCI_BROKEN_STREAMS;
> >       }
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_ETRON &&
> > +                     pdev->device =3D=3D PCI_DEVICE_ID_EJ188) {
> > +             xhci->quirks |=3D XHCI_RESET_ON_RESUME;
> > +     }
>
>    You don't need {} around a single statement, according to CodingStyle.
>
> [...]
>
> MBR, Sergey

Got it, I'll modify it and resend patches.

Thanks,
Kuangyi Chiang

