Return-Path: <stable+bounces-89471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B59B8952
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 03:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A11F22463
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147184D29;
	Fri,  1 Nov 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6eiSZob"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB783200CB;
	Fri,  1 Nov 2024 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428224; cv=none; b=PzEzP1GonX6iC87f9RrcF7dyZ6ienVGy7OvmX6ExwPXuNHtmBHdQrMXnFOzkwBzuuFV89mXousFPtssFIKoi1Rz/Pc96KLd9t/7BRtq9+bLNCIhJQpDEGeL5s/6heRd5fryumZD852mR+fdmRHaTPpQ29qmFIKnzGD4hIpUP+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428224; c=relaxed/simple;
	bh=qk3pVjM4j9p4R6OsPwAJ8dVXGT6jP0nT0Mfjm0PIrX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgYafyXgU0w5pUu0Y4kEM/QezW7iXqUkXFGeJFOG22GbMlRl4ASUv/6Y1ygtIKOBxKq+VsPcZ67y68PscpiiaREqdb6O+ELWEnXkYED0MRIeQDWv/JGjCm2mWQkFexZ8kQuBFLUEu7jNqHwH0XCmgIBsmsLddVLPXtwUamlh+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6eiSZob; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so1103916a91.1;
        Thu, 31 Oct 2024 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730428218; x=1731033018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnyjs9mZfz0IFsGTjdAXi5ZB7RMeF0PETouQsH0UHcE=;
        b=U6eiSZob7CR/tNrSxOerPOmjtRK+oJOGsSp0nMEpk9gtTpoc1QMs41d/O8G7oQrNIx
         QZywONdEFMIMwEt20So06Y69nMemceA3xrBVkVxiTfg9PiKug+KsJ5/qkeGji2K/ji5A
         j+OgijQrzk3yWHF33i3VpFVjxIq1UVNVirv3xhrbcRU5sQ+WkaZ81j7W8uJQzJdjFOQP
         bCcdNVZud4wC/BaK6g3LwtEq0dJZiF0XYiXyuDDnRynwhp21Bzb9IwY6hetovTwbXX6m
         /04BSgJnQFTaSwf643yg8SoAsMdtK/K9m3aA7r/gHFWtD7XLBO20ej6uTKema2b3LNMv
         YQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730428218; x=1731033018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnyjs9mZfz0IFsGTjdAXi5ZB7RMeF0PETouQsH0UHcE=;
        b=Q99hOr+mzumvphm/9uYTOuNh9D6erEWMpysdVBLuKdWGbx04h+GuMfdg2KXjYqnrAb
         qU/VsfJeKipUIQvPiOw4WMHTPUDx4/Anfj09LuV7acaVeSVZcZV0x5hGwW7fMgouzQmc
         BFFHteUGfdYYWUggueCBMqQwlZ9ZOqNwgKilcRhTav+mDovynFW/HDhhOazx0q2V/V0b
         ZW6G1rGslGtLQdk6HR8zKeHdZXf4L0fyG/klpYLZbGNX8jSpjfhnlYRQ0cCyHjFvxilR
         s1J0QolUh54rcjGxpz9b8WRsS3xu5rlDTVSrzagEXMejW87l+FchQw50EVxzf9s/zIK1
         WJfw==
X-Forwarded-Encrypted: i=1; AJvYcCWUZ5gco3XyRWh94ALxtf3P+EUSt6wMz8/lA0gEBFY3NjHzXdeajIQXAR6tzLjrQLTDoekAe/02EdLL@vger.kernel.org, AJvYcCX836GeTAVyevmkdvyHwRD8BYsmMWeT8Myw7kcr532E6JbcMDPK9qNBi/RPF5u5soLOHhU6xSON@vger.kernel.org, AJvYcCXGnWpkXUBYuRpovBtM5RBjUhamk7Pw7RZkX7ttRMM7ewuqpefKPftfIrg81sAZL31RWhRBo9ziXHq4WqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPrPYcwcskqK9vRrMsHNY750u6AsL3SitojsiXrnzuF2YFGc/
	wSgbrcp/XvFRGay+RA909MvGsZRLZ2n0VC8HBHtgYB35M3RThaQky5F9XAM6ZwnOwa07Sd6SZ4k
	zHg0YF50pjODd+ZKgAqKMX2gv5Xg=
X-Google-Smtp-Source: AGHT+IH6CwuFAuogBn3TuH9yoyjK1IF9VaMDPZudJbQuTXFL3Agi3fb+ynW2hbnGjFwmCycN+KMhplzkHCTn4N7jSCE=
X-Received: by 2002:a17:90b:224c:b0:2e2:da8d:2098 with SMTP id
 98e67ed59e1d1-2e94c294fcemr2942926a91.2.1730428218001; Thu, 31 Oct 2024
 19:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028025337.6372-1-ki.chiang65@gmail.com> <20241028025337.6372-2-ki.chiang65@gmail.com>
 <bceb89ce-7a4b-4447-8bd6-3129a37bfdb3@linux.intel.com>
In-Reply-To: <bceb89ce-7a4b-4447-8bd6-3129a37bfdb3@linux.intel.com>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Fri, 1 Nov 2024 10:30:09 +0800
Message-ID: <CAHN5xi2B5CcCKEsdQf1X7HD=8ZBAW66PefmO0ajvGCNdPOc-PA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] xhci: Combine two if statements for Etron xHCI host
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that one of the patches in your queue has a typo:

Commit 3456904e4bce ("xhci: pci: Use standard pattern for device IDs")

The Etron xHC device names are EJ168 and EJ188, not J168 and J188.

Thanks,
Kuangyi Chiang

Mathias Nyman <mathias.nyman@linux.intel.com> =E6=96=BC 2024=E5=B9=B410=E6=
=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:02=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On 28.10.2024 4.53, Kuangyi Chiang wrote:
> > Combine two if statements, because these hosts have the same
> > quirk flags applied.
> >
> > Fixes: 91f7a1524a92 ("xhci: Apply broken streams quirk to Etron EJ188 x=
HCI host")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
>
> Added to queue, but I removed the Fixes and stable tags as this is a smal=
l
> cleanup with no functional changes.
>
> > ---
> >   drivers/usb/host/xhci-pci.c | 8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index 7e538194a0a4..33a6d99afc10 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -395,12 +395,8 @@ static void xhci_pci_quirks(struct device *dev, st=
ruct xhci_hcd *xhci)
> >               xhci->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> >
> >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_ETRON &&
> > -                     pdev->device =3D=3D PCI_DEVICE_ID_EJ168) {
> > -             xhci->quirks |=3D XHCI_RESET_ON_RESUME;
> > -             xhci->quirks |=3D XHCI_BROKEN_STREAMS;
> > -     }
> > -     if (pdev->vendor =3D=3D PCI_VENDOR_ID_ETRON &&
> > -                     pdev->device =3D=3D PCI_DEVICE_ID_EJ188) {
> > +         (pdev->device =3D=3D PCI_DEVICE_ID_EJ168 ||
> > +          pdev->device =3D=3D PCI_DEVICE_ID_EJ188)) {
> >               xhci->quirks |=3D XHCI_RESET_ON_RESUME;
> >               xhci->quirks |=3D XHCI_BROKEN_STREAMS;
> >       }
>

