Return-Path: <stable+bounces-207934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4C4D0CEDE
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 05:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E40F30A567C
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 04:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B1E280023;
	Sat, 10 Jan 2026 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orFDyOk1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6A2749D6
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017929; cv=none; b=BEsW9ZROe5rnJlyckCZoTFcqbtWKrKnB20b04alkjKzd+RVw1vB9KYEL+l6Dn5qqM8tDPmRlyfibgYCtW0mdk+PWlQXjEXRVUoLqiJm+qOWiPhTp4Y9Jsr0EM2LNu0ctF6mR5DA6/Et5DuGXY6StoBJ49mziwa40Cq++A4FQFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017929; c=relaxed/simple;
	bh=oyBxyaESQlE9z4FcjPvxQNUkT0mRyxsawflqvPboayo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwPKaZ2ck8bVvwI12fLIK6pYkyLkdNj8VXF9/gl8rn4sGPFVcinit0KpicL2SkuZkls9CNEZOIE9PSvPN0XaXUYf+p/yL1WfwJ3NMQh35XlSDLV81lyPKuGjkdOZ2gUQCCUsrFw6sYY2nQ+rwan90fk7m5U+KHgIhLDkdypz0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orFDyOk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF73C4CEF1
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 04:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768017929;
	bh=oyBxyaESQlE9z4FcjPvxQNUkT0mRyxsawflqvPboayo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=orFDyOk1UBzzYK/ekd8aexI4XK6IenRs9PXdqJUfcK7v1b3/xUjlEH5cbzLBRvusM
	 PFzKgw+T+F94Ltmcdymj3W8Xt6oBsOvkYVC094cZfCD5s5Sb+GyXZae05apc4NXWaQ
	 wGkD+axaIcgUz2t+8nZ9bVDkUEsoqxz2zSh/IsGFZPpPNkd6ktxJqVEj3pmPVSlJV+
	 rqDRIt2s3FHqMdN1Y+RXSOxsjqB95YcvO9q32P1SFqZgelIsDhgIpnc+KMogCT4WsG
	 aDdbR0NzrM7T5tjX2s3xS+NrJvBzzlNk1auKGjr6ISww4UUHsj16bWcUX9vvObDSui
	 wAxD7ADSZ5UFg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7633027cb2so937372666b.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 20:05:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKGyj3SuGBbNzctTVExGPcl1MwYDFGKuPLe2fYwXDyHhCB3/MNOKW0/43qQzvpSztH2z9cT9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KP/Tf9g3C2ls1UFQFH0qluRv/aH/yOosmjr80MuFi6GpVLvR
	XVm96S2gL+lWARrYY/3XeB+8Ym61945EwRh4guHw0woBDoWp6pjIeHpfBZB0jY92D+pQs7q+8Bo
	o9VyUuDw0FeeDngELrwwX0MEchc5MVm4=
X-Google-Smtp-Source: AGHT+IE8Fl+yT7jNZTYLKoUlApxaI4gjo5FvC344BEz7mQNcOW7hRfmh1nCSGX2cGkYHv/qgI1i9vtuuCqYnIM1IPBI=
X-Received: by 2002:a17:907:3d42:b0:b80:46f5:cabe with SMTP id
 a640c23a62f3a-b8444c4d2aemr1258316866b.4.1768017928111; Fri, 09 Jan 2026
 20:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025123049-cadillac-straggler-d2fb@gregkh> <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
 <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
 <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
 <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
 <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>
 <34c7edd0-3c0c-4a57-b0ea-71e4cba2ef26@rowland.harvard.edu>
 <CAAhV-H7j=cD9dkaB5bWxNdPtoVR4NUFvFs=n46TaNte1zGqoOA@mail.gmail.com>
 <98e36c6f-f0ee-40d2-be7f-d2ad9f36de07@rowland.harvard.edu>
 <CAAhV-H601B96D9rFrnARho4Lr9A+ah7Cx7eKiPr=epbG17ODHQ@mail.gmail.com> <561129d8-67ff-406c-afe8-73430484bd96@rowland.harvard.edu>
In-Reply-To: <561129d8-67ff-406c-afe8-73430484bd96@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 10 Jan 2026 12:05:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H41kwndL+oz2Gcfpe3-MCagaQd2X21gK9kMO2vpw_thhA@mail.gmail.com>
X-Gm-Features: AZwV_QghiCrKozy6ftSqUa9rEeMafQzFWOvCDRhlJ-mzUd72Krxpo_omrImpt8E
Message-ID: <CAAhV-H41kwndL+oz2Gcfpe3-MCagaQd2X21gK9kMO2vpw_thhA@mail.gmail.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Diederik de Haas <diederik@cknow-tech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Shengwen Xiao <atzlinux@sina.com>, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 12:41=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Sat, Jan 03, 2026 at 11:57:47AM +0800, Huacai Chen wrote:
> > On Sat, Jan 3, 2026 at 11:33=E2=80=AFAM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > > Since these systems don't use PCI, the question I raised earlier stil=
l
> > > needs to be answered: How do they route connections between the ports
> > > and the two controllers?
> > >
> > > There may be some exceptions, but for the most part, the code in
> > > ehci-hcd was written assuming that only PCI-based controllers will ha=
ve
> > > companions.  If you want to make an exception for loongson-2k0500, yo=
u
> > > will need to figure out how to get it to work.
> > Loongson-2K0500 use EHCI/OHCI with platform bus, while
> > Loongson-2K1000/2000 use EHCI/OHCI with PCI bus. They use the same USB
> > IP cores, so the route connections are probably the same.
>
> With PCI we know exactly which companion controller each port is
> connected to.  Is that true in your situation?
>
> Or do you have only one companion controller?
>
> For that matter, how many USB ports do these systems have?  Are some of
> them USB-1 only or USB-2 only?
>
> > > Have you tested any of those systems to see how they behave if a USB-=
1
> > > device is already plugged in and running when the ehci-hcd driver get=
s
> > > loaded?
>
> You did not answer this question.
On Loongson-2K0500 (OHCI/EHCI with platform bus).

If ohci-platform loaded before ehci-platform:

[   30.530103] ohci-platform 1f058000.usb: Generic Platform OHCI controller
[   30.555362] ohci-platform 1f058000.usb: new USB bus registered,
assigned bus number 1
[   30.583586] ohci-platform 1f058000.usb: irq 28, io mem 0x1f058000
[   30.671500] hub 1-0:1.0: USB hub found
[   30.687929] hub 1-0:1.0: 4 ports detected
[   30.798553] Warning! ehci_hcd should always be loaded before
uhci_hcd and ohci_hcd, not after
[   31.015178] usb 1-4: new low-speed USB device number 2 using ohci-platfo=
rm
[   31.090527] ehci-platform 1f050000.usb: EHCI Host Controller
[   31.107968] ehci-platform 1f050000.usb: new USB bus registered,
assigned bus number 2
[   31.143813] ehci-platform 1f050000.usb: irq 29, io mem 0x1f050000
[   31.227286] ehci-platform 1f050000.usb: USB 2.0 started, EHCI 1.00
[   31.248271] usb 1-4: device descriptor read/all, error -62
[   31.256845] hub 2-0:1.0: USB hub found
[   31.279310] hub 2-0:1.0: 4 ports detected
[   31.915149] usb 1-4: new low-speed USB device number 3 using ohci-platfo=
rm
[   32.264765] input: YSPRINGTECH USB OPTICAL MOUSE as
/devices/platform/bus@10000000/1f058000.usb/usb1/1-4/1-4:1.0/0003:10C4:8105=
.0001/input/input0
[   32.374306] hid-generic 0003:10C4:8105.0001: input,hidraw0: USB HID
v1.11 Mouse [YSPRINGTECH USB OPTICAL MOUSE] on
usb-1f058000.usb-4/input0

If ehci-platform loaded before ohci-platform:

[   30.724394] ehci-platform 1f050000.usb: EHCI Host Controller
[   30.743839] ehci-platform 1f050000.usb: new USB bus registered,
assigned bus number 1
[   30.775857] ehci-platform 1f050000.usb: irq 28, io mem 0x1f050000
[   30.811297] ehci-platform 1f050000.usb: USB 2.0 started, EHCI 1.00
[   30.829172] hub 1-0:1.0: USB hub found
[   30.847397] hub 1-0:1.0: 4 ports detected
[   30.934190] ohci-platform 1f058000.usb: Generic Platform OHCI controller
[   30.959877] ohci-platform 1f058000.usb: new USB bus registered,
assigned bus number 2
[   30.987617] ohci-platform 1f058000.usb: irq 29, io mem 0x1f058000
[   31.080419] hub 2-0:1.0: USB hub found
[   31.092038] hub 2-0:1.0: 4 ports detected
[   31.407288] usb 2-4: new low-speed USB device number 2 using ohci-platfo=
rm
[   31.741276] input: YSPRINGTECH USB OPTICAL MOUSE as
/devices/platform/bus@10000000/1f058000.usb/usb2/2-4/2-4:1.0/0003:10C4:8105=
.0001/input/input0
[   31.815422] hid-generic 0003:10C4:8105.0001: input,hidraw0: USB HID
v1.11 Mouse [YSPRINGTECH USB OPTICAL MOUSE] on
usb-1f058000.usb-4/input0

"new low-speed USB device number 3 using ohci-platform" only displayed
once and "usb 1-4: device descriptor read/all, error -62" disappears
in this case.

So I think we need a softdep between ohci-platform/uhci-platform and
ehci-platform, which is similar to the PCI case.

>
> There are other issues involving companion controllers, connected with
> hibernation.  You should take a look at commit 6d19c009cc78 ("USB:
> implement non-tree resume ordering constraints for PCI host
> controllers"), which was later modified by commit 05768918b9a1 ("USB:
> improve port transitions when EHCI starts up") and a few others.
>
> Also, read through the current code in hcd-pci.c (for_each_companion(),
> ehci_pre_add(), ehci_post_add(), non_ehci_add(), ehci_remove(), and
> ehci_wait_for_companions()).  Your non-PCI system will need to implement
> some sort of equivalent to all these things.
At least for the device probe, a softdep seems enough.

Huacai

>
> Alan Stern

