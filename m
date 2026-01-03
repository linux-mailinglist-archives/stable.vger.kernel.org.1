Return-Path: <stable+bounces-204525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04272CEFA4E
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 04:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30A1F30076A5
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 03:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B81DD9AC;
	Sat,  3 Jan 2026 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEAfEe3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B00AD5A
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767410201; cv=none; b=kQ8F9A7wzxKAviXBfWT/mMGCO8DcuOjXrS/z3UZUrPFFeDwpB5aRGI+D8eTt5DV8KJ2wsd0nfU6M0ohbOD59HpGDEkBpIPed3B6m8iKA20DucxB1CcizFA6/tOeCJF6ZpgPEJmtP8bpWGFpNRf0e04OC5ETBoNY79aheYi5RHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767410201; c=relaxed/simple;
	bh=m9xIBj3yL9LawKUkeqOxIMHhpeBMxBfDFT4hgdvqNxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/SYcIKLQNnDK4G6Yl7+VJveI/BjskshI6tW4CzjNgTHJ92szY8ndV+caumyQqnheOSv0ae3u5fjSnl93JSO2+dZziOWaW67BxuLsvW0wQpkq7jQWhszOfg/5337iMwLBKGsjFyfwUn17C8QfRKo+dhCpydTDrUhyNlA1NZ/Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEAfEe3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E816AC19424
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 03:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767410200;
	bh=m9xIBj3yL9LawKUkeqOxIMHhpeBMxBfDFT4hgdvqNxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hEAfEe3Lme0NNGrJTeE6cc8HOq7gx3X/6ZnV7zwGPsAcHzxSu0eF1kvyJeSkWT8nk
	 b+9npTewLTl9oMrhQsLV/UoaC4GQNbTTI8zCWGnsf4EeO9bWoCemfc0UUhgobW0Pr4
	 kEwiKJHpXavsF0SxNfy1QP/wpnn1JxPHRhWIo+cId4lEyQpX7MQ8vnWWnStQgi0x3C
	 NXc+SK8m91C4kWYLIMqx0mUGNNMcInJdCyF/ZeDNdfNiiheGCBpjgx69XhvK+w/XJ+
	 TrFcuqR63iLiznhmTZK+hPAgeUupWd6LSKH/ItDy0bN3MYy1RgDbjLP3ZGJErZFiWk
	 oVKBVWw8c8iCA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so15098439a12.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 19:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZoKjBgICRA+q7tk7TD0UqPIRucYj+Ed7MsJl9awpbinai+CSNfW9NTNBHy/WHlhvNtXPtsT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvACr58/uzSmWHy9EDxAzA6HlzCq8GvkMS9Z69fgvJAUKzNoc
	AByfM9aMsmNyo4txeqEZ5YqauaqUmKe5A8yLwVhgcR28ya+9LAVOoBHULWvfpXBGau2+My5mzWd
	Y3GgmRot4ggHGVQ11ColHZMRnv/jEp84=
X-Google-Smtp-Source: AGHT+IENwkbY5Krujo1vI/+oQgXYSVTGsEftmHp5TsgQioVkf+KFrHnaVJGa5DrZDz3gGsdbfK08WhOdN1Wgf21PUHg=
X-Received: by 2002:a17:906:c146:b0:b73:99f7:8134 with SMTP id
 a640c23a62f3a-b8037180224mr4120664866b.45.1767410199407; Fri, 02 Jan 2026
 19:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh> <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
 <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
 <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
 <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
 <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com> <34c7edd0-3c0c-4a57-b0ea-71e4cba2ef26@rowland.harvard.edu>
In-Reply-To: <34c7edd0-3c0c-4a57-b0ea-71e4cba2ef26@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Jan 2026 11:16:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7j=cD9dkaB5bWxNdPtoVR4NUFvFs=n46TaNte1zGqoOA@mail.gmail.com>
X-Gm-Features: AQt7F2p7PUWpUJu1gk3NQjtCnUFNalt9DTy3BonfJ8TJwT21wFS49ZipknARuPk
Message-ID: <CAAhV-H7j=cD9dkaB5bWxNdPtoVR4NUFvFs=n46TaNte1zGqoOA@mail.gmail.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Diederik de Haas <diederik@cknow-tech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Shengwen Xiao <atzlinux@sina.com>, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 11:13=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, Jan 02, 2026 at 10:36:35AM +0800, Huacai Chen wrote:
> > On Wed, Dec 31, 2025 at 11:21=E2=80=AFPM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
> > >
> > > On Wed, Dec 31, 2025 at 05:38:05PM +0800, Huacai Chen wrote:
> > > > From your long explanation I think the order is still important. "N=
ew
> > > > connection" may be harmless for USB keyboard/mouse, but really
> > > > unacceptable for USB storage.
> > > >
> > > > If we revert 05c92da0c524 and 9beeee6584b9, the real problem doesn'=
t
> > > > disappear. Then we go back to pre-2008 to rely on distributions
> > > > providing a correct modprobe.conf?
> > >
> > > The warning message in 9beeee6584b9 was written a long time ago; back
> > > then I didn't realize that the real dependency was between the -pci
> > > drivers rather than the -hcd ones (and I wasn't aware of softdeps).  =
The
> > > soft dependency in 05c92da0c524 is between the -pci drivers, so it is
> > > correct.
> > >
> > > To put it another way, on PCI-based systems it is not a problem if th=
e
> > > modules are loaded in this order: uhci-hcd, ohci-hcd, ehci-hcd,
> > > ehci-pci, ohci-pci, uhci-pci.  Even though the warning message would =
be
> > > logged, the message would be wrong.
> > Correct me if I'm wrong.
> >
> > I found XHCI is compatible with USB1.0/2.0 devices,
>
> Yes.
>
> >  but EHCI isn't
> > compatible with USB1.0. Instead, EHCI usually has an OHCI together,
> > this is not only in the PCI case.
>
> It's more complicated than that.
>
> For quite a long time now, most systems using EHCI have not included a
> companion OHCI or UHCI controller.  Instead they include a built-in
> USB-2.0 hub; the hub is wired directly into the EHCI controller and the
> external ports are connected to the hub.  USB-2.0 hubs include
> transaction translators that relay packets between high-speed and low-
> or full-speed connections, so they can talk to both USB-1 and USB-2
> devices.  Hence no companion controller is needed.
>
> I don't remember when Intel starting selling chipsets like this, but it
> was probably around 2000 or earlier.  (Some non-Intel-based systems
> included a transaction translator directly in the root hub, so they
> didn't even need to have an additional USB-2.0 hub.)
>
> Before that, systems did include companion controllers along with an
> EHCI controller.  I don't know of any non-PCI systems that did this, but
> of course some may exist.  However, the EHCI-1.0 specification says this
> in section 4.2 "Port Routing and Control" (p. 54):
>
>         The USB 2.0 host controller must be implemented as a
>         multi-function PCI device if the implementation
>         includes companion controllers.
>
Thank you for your explanation, so it means there are two methods: The
old one is EHCI with a companion OHCI; the new one is EHCI with a
USB-2.0 hub. Right?

> > So I guess OHCI/UHCI have an EHCI dependency in order to avoid "new
> > connection", not only in the PCI case.
>
> Do you know of any non-PCI systems that do this?
Unfortunately, in 2026 there are really "EHCI with a companion OHCI"
for non-PCI systems, please see
arch/loongarch/boot/dts/loongson-2k0500.dtsi.

Huacai

>
> Alan Stern

