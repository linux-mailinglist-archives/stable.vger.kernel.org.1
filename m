Return-Path: <stable+bounces-204330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FC9CEBB43
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 10:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77CB2300CB58
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42953148C6;
	Wed, 31 Dec 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzWifXpU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424730F927
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767173868; cv=none; b=YfHNP2TAZHjjd0Nw3SzF8sjz3iakj6/mMkZwMQ1ORY81h7DgppySc56Qw5XoS2L5sN0EJ5QNUMQN7P9ddnSIluis9LsUBCrzbU37xXiXQ9N5vmBNscfUbb7vCG7vxkGJ/GUwS8vJHFdACUJ7ZYshcxaHepU98HBZHTvPBixx9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767173868; c=relaxed/simple;
	bh=CrFviPTfnO5MrTM9rh8FOMVvcVix84wLkSJAzKgr7zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkzfEeD6/ed7x/VuHshZ/7KZBWzodSirUPauic+w6/gRXhA8cCwvb69lMHQfNeuN6vo+8ueybgr7FGFY24b9k5FthzKHO2bv3TlHBzIOGtV362vYzBqf4ZGfw1ByAISlFtV2LsnLNQH3rKUjKs2ufmRk4jbUgffmcuyLnPt+8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzWifXpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DACFC19424
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767173868;
	bh=CrFviPTfnO5MrTM9rh8FOMVvcVix84wLkSJAzKgr7zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lzWifXpUGD8+E5nYogerhv72hssoknpG7XMlR6Z7ekxi2zayQG16WxiPqryzNJ47L
	 gWp64/BUYIqae392n6LnXQFMu8qdS+OtCNgmKRv73P2xxTx3PtINGY0EJaly8vpN3B
	 ztyQ/PkW94PfXgacNdR7fZTZGY1AFWvIqSeiSk8fUuwZeVFJpVBl81BMpwr/+XTZw7
	 9iDORh4w6uWJC5XV9EsVXDq1HpmC7lPxzV/K44ppLKiXYlN/xsYh1L1Nlu9lAZzfv5
	 uz+d/efR5N3wD7aIrjsiO8xSqVoUCYGKZm0hvGgw3ED8Cndbd/mnIA1WJnNiRxp+8i
	 wsBoVAzt67FFw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b832522b47cso634196766b.0
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 01:37:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFXpVfh0910IITjhdjMP6Vyj885eRIezxBSfwWwu6r+Tpxu0aWg+Rx7FKGJZmYx7eigO/Usws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fJXb8kSNWWaLOOm/pGRewuEDfgxbtMB3wQbygJzehQqg+9vX
	iF8ELMzLgyz/wEU6JKhCLBYUjuHgxPCQBgRV5khPJoqWPjR5g4KUw4KBAL2BRyTlkbJliUzTGKV
	W8nYt+DzoaTlAyvNDpa2JlBe5KMa5m+M=
X-Google-Smtp-Source: AGHT+IFVb1yQlzwVWFcEH4gHbnF69rkD0X0KgI3cOZ0pbxR47ekJuboYf5pLm4002RPGE5nWv6FYA/qq4tZgE3O6nAs=
X-Received: by 2002:a17:907:7f15:b0:b76:b632:1123 with SMTP id
 a640c23a62f3a-b8037159828mr3701463566b.42.1767173866870; Wed, 31 Dec 2025
 01:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh> <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
 <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
In-Reply-To: <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 31 Dec 2025 17:38:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
X-Gm-Features: AQt7F2oD7Hfhx3jnbBzE8YCrXoyByHlqtt_1IlJHGjEXZIcJ2n-YDfOhaboCLwI
Message-ID: <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Diederik de Haas <diederik@cknow-tech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Shengwen Xiao <atzlinux@sina.com>, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alan,

On Wed, Dec 31, 2025 at 12:42=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Tue, Dec 30, 2025 at 03:40:27PM +0100, Diederik de Haas wrote:
> > On Tue Dec 30, 2025 at 9:15 AM CET, Greg Kroah-Hartman wrote:
> > > On Tue, Dec 30, 2025 at 04:00:14PM +0800, Huacai Chen wrote:
> > >> Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is no=
t
> > >> loaded first") said that ehci-hcd should be loaded before ohci-hcd a=
nd
> > >> uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add so=
ft
> > >> dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on eh=
ci-
> > >> pci, which is not enough and we may still see the warnings in boot l=
og.
> > >> So fix it by also making ohci-hcd/uhci-hcd depend on ehci-hcd.
> > >>
> > >> Cc: stable@vger.kernel.org
> > >> Reported-by: Shengwen Xiao <atzlinux@sina.com>
> > >> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >> ---
> > >>  drivers/usb/host/ohci-hcd.c | 1 +
> > >>  drivers/usb/host/uhci-hcd.c | 1 +
> > >>  2 files changed, 2 insertions(+)
> > >>
> > >> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd=
.c
> > >> index 9c7f3008646e..549c965b7fbe 100644
> > >> --- a/drivers/usb/host/ohci-hcd.c
> > >> +++ b/drivers/usb/host/ohci-hcd.c
> > >> @@ -1355,4 +1355,5 @@ static void __exit ohci_hcd_mod_exit(void)
> > >>    clear_bit(USB_OHCI_LOADED, &usb_hcds_loaded);
> > >>  }
> > >>  module_exit(ohci_hcd_mod_exit);
> > >> +MODULE_SOFTDEP("pre: ehci_hcd");
> > >
> > > Ick, no, this way lies madness.  I hate the "softdep" stuff, it's
> > > usually a sign that something is wrong elsewhere.
> > >
> > > And don't add this _just_ to fix a warning message in a boot log, if =
you
> > > don't like that message, then build the module into your kernel, righ=
t?
> > >
> > > And I really should just go revert 05c92da0c524 ("usb: ohci/uhci - ad=
d
> > > soft dependencies on ehci_pci") as well, that feels wrong too.
> >
> > FWIW, I've been seeing this warning on several of my Rockchip based
> > devices as well. I thought I had already mentioned that on some ML, but
> > couldn't find it on lore.k.o ... turns out I reported it on my 'own' ML=
:
> > https://lists.sr.ht/~diederik/pine64-discuss/%3CDD65LB64HB7K.15ZYRTB98X=
8G2@cknow.org%3E
> > (and likely on #linux-rockchip IRC channel)
> >
> > Most of it is just my research notes, but the last post also had this:
> >
> > ```
> > I checked the last 20 boots on my devices to see that warning (or not).
> > Device                                Number of times that warning show=
ed up
> > Rock64 (rk3328)                       16x
> > RockPro64 (rk3399)            11x
> > Quartz64 Model A (rk3566)      7x
> > Quartz64 Model B (rk3566)     14x
> > PineTab2 (rk3566)             17x
> > NanoPi R5S (rk3568)           13x
> > Rock 5B (rk3588)              12x
> > ```
> >
> > While I generally don't like seeing warning messages, it often also
> > resulted in USB2 ports not working. Maybe even every time, but I only
> > notice it when I actually tried to use one of the USB2 ports.
> >
> > The first post mentioned what I 'assume' to be the problem:
> > ```
> > CONFIG_USB_XHCI_HCD=3Dm
> > CONFIG_USB_EHCI_HCD=3Dm
> > CONFIG_USB_OHCI_HCD=3Dm
> > ```
> >
> > So I guess USB_EHCI_HCD doesn't work with '=3Dm'.
>
> Not true, it really does work with "=3Dm".
>
> And in fact, your systems should work even if the modules are loaded in
> the wrong order.  The issue is that doing so can cause a brief
> interruption in the existing USB connections when the ehci-pci module is
> loaded.
>
> If your systems don't use PCI for these host controllers then I don't
> know how they would behave.  The issue is: How does the hardware route
> low-speed and full-speed USB connections to the different types of
> controller?
>
> On PCI systems, when ehci-pci isn't loaded, the hardware routes all
> connections directly to the companion UHCI or OHCI controller.  When
> ehci-pci is loaded, the hardware routes connections to the EHCI
> controller, and when the driver sees that a connection isn't running at
> high speed (480 Mb/s), it tells the hardware to switch the connection
> over to the companion.
>
> So if a low-speed (1.5 Mb/s) or full-speed (12 Mb/s) device is connected
> before ehci-pci loads, its connection will get routed to the companion
> controller.  Then when ehci-pci loads, the connection will be switched
> over to the EHCI controller, which will cause the existing connection to
> be dropped.  Then the connection will be routed back to the companion
> controller, but it will be perceived as a new connection, resulting in a
> brief interruption in service.  For many devices this won't matter, but
> for some it might.  The only way to avoid the problem is to load
> ehci-pci before uhci-pci and ohci-pci.
>
> (A similar problem can occur with high-speed-capable devices.  When
> initially attached to the companion controller, they are forced to
> connect at full speed.  But when the connection is changed to the EHCI
> controller, they are able to run at high speed -- and again, the result
> is a new connection, causing service to be interrupted and then start up
> fresh but running much faster.)
From your long explanation I think the order is still important. "New
connection" may be harmless for USB keyboard/mouse, but really
unacceptable for USB storage.

If we revert 05c92da0c524 and 9beeee6584b9, the real problem doesn't
disappear. Then we go back to pre-2008 to rely on distributions
providing a correct modprobe.conf?

Huacai

>
> Alan Stern

