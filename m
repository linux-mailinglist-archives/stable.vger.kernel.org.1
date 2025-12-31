Return-Path: <stable+bounces-204378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B389CEC62A
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 18:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87391300A84D
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191021D5BC;
	Wed, 31 Dec 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="XW5/xx9A"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51B1DE4DC
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202429; cv=none; b=Ly1yqKr1xnHiDySn/pLDK+eDzumSswAlL4TprHiNvL3GMc2HQj6H5a0vnJZEydLfJ56UvsNvWse2CI52MNfZSXkYBcAmZhMHDuUNq5RL0PWcWm3aF2+VsqkCwdlRRCeUKxtrVS4ISkQu+yZ0mByL9Wg6b5XNwZxI7mdd1SbAz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202429; c=relaxed/simple;
	bh=pW4anJUv1AC7rC3eXHz2tmcoY54PcL9Qp2ollOjSFvU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OIGfaVH1xbsSssR92lq33jMQ6zlfCg6UWcsw205YyRGVqex465wP9Ru59yYHDlf0YPMdMfC23OhagqTp6g2benNbs5BB+cSwgzyk0rSNI6D8UsEO8ICYCoDRIUj9K/VvhmYrI5X/W6aqyvrL4psSjwX6mUVcN2Mt33a7zRguUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=XW5/xx9A; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1767202424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=152GR3bpCkA4edsFB/mhHCnTqy+h5Kh1YyF59UsoHYI=;
	b=XW5/xx9AeHfZWmeTvOCRcxRXv2ZTuRxLTSs7/g1QZzue0w9tJmLPm72NdIqmPMRyDOOjvG
	dFDdtVt76pTua9SYE+iAD40KYkoYY3fKm60luRp2LKyzFqu8aNV7LVE1SZa9SvoHOKv5Jr
	69760ZYS4hWuv5QIzgzbAcBm0bhHHI/b/XoRvUpfdnTBTaHQaral4qxfRGBUnrse9wc3Rw
	llNM1K2GtGvXVB9Eqkeho5iH7aAP5HGCeouorozxxKWww3DXvVNOschi+a14ZQY++yty2d
	q5CAHQiVjgO4GDiY1RMeFZQOQwEEaWRUwbQmX5I0BNtY9lDuYl8yILzpLlHWow==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 31 Dec 2025 18:33:34 +0100
Message-Id: <DFCKZ1I7C83G.1DUX9IT96CYZ3@cknow-tech.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Huacai Chen"
 <chenhuacai@loongson.cn>, "Huacai Chen" <chenhuacai@kernel.org>,
 <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Shengwen Xiao" <atzlinux@sina.com>,
 <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Alan Stern" <stern@rowland.harvard.edu>, "Diederik de Haas"
 <diederik@cknow-tech.com>
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh>
 <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
 <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
In-Reply-To: <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
X-Migadu-Flow: FLOW_OUT

On Tue Dec 30, 2025 at 5:42 PM CET, Alan Stern wrote:
> On Tue, Dec 30, 2025 at 03:40:27PM +0100, Diederik de Haas wrote:
>> On Tue Dec 30, 2025 at 9:15 AM CET, Greg Kroah-Hartman wrote:
>> > On Tue, Dec 30, 2025 at 04:00:14PM +0800, Huacai Chen wrote:
>> >> Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
>> >> loaded first") said that ehci-hcd should be loaded before ohci-hcd an=
d
>> >> uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add sof=
t
>> >> dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehc=
i-
>> >> pci, which is not enough and we may still see the warnings in boot lo=
g.
>> >> So fix it by also making ohci-hcd/uhci-hcd depend on ehci-hcd.
>> >> <snip>
>>=20
>> FWIW, I've been seeing this warning on several of my Rockchip based
>> devices as well. ... but the last post also had this:
>>=20
>> ```
>> I checked the last 20 boots on my devices to see that warning (or not).
>> Device				Number of times that warning showed up
>> Rock64 (rk3328)			16x
>> RockPro64 (rk3399)		11x
>> Quartz64 Model A (rk3566)	 7x
>> Quartz64 Model B (rk3566)	14x
>> PineTab2 (rk3566)		17x
>> NanoPi R5S (rk3568)		13x
>> Rock 5B (rk3588)		12x
>> ```
>>=20
>> While I generally don't like seeing warning messages, it often also
>> resulted in USB2 ports not working. Maybe even every time, but I only
>> notice it when I actually tried to use one of the USB2 ports.
>>=20
>> The first post mentioned what I 'assume' to be the problem:
>> ```
>> CONFIG_USB_XHCI_HCD=3Dm
>> CONFIG_USB_EHCI_HCD=3Dm
>> CONFIG_USB_OHCI_HCD=3Dm
>> ```
>>=20
>> So I guess USB_EHCI_HCD doesn't work with '=3Dm'.
>
> Not true, it really does work with "=3Dm".

I shouldn't have stated that before I fully investigated it.
I do plan to change my kernel config to make it "=3Dy" though.

> And in fact, your systems should work even if the modules are loaded in=
=20
> the wrong order.  The issue is that doing so can cause a brief=20
> interruption in the existing USB connections when the ehci-pci module is=
=20
> loaded.
>
> If your systems don't use PCI for these host controllers then I don't=20
> know how they would behave.  The issue is: How does the hardware route=20
> low-speed and full-speed USB connections to the different types of=20
> controller?

One of the issue is that I don't (fully) understand how this (should)
work. F.e. I wondered about all the PCI 'references' in your explanation
(thanks for that :-)).

I (also) wondered why the number on Quartz64-A was lower, but that
actually has a PCIe slot ... with a USB3 controller card in it.

If I do ``lsmod | grep pci`` on my PineTab2, I get zero hits, but I do
get hits when doing it on my Q64-A.

On my Rock 5B, I get 1 hit, "phy_rockchip_snps_pcie3", but that has a
NVMe drive connected to it. And I have a (working) keyboard connected
via a USB2 port. And/while I do have the warning ...

Cheers,
  Diederik

> On PCI systems, when ehci-pci isn't loaded, the hardware routes all=20
> connections directly to the companion UHCI or OHCI controller.  When=20
> ehci-pci is loaded, the hardware routes connections to the EHCI=20
> controller, and when the driver sees that a connection isn't running at=
=20
> high speed (480 Mb/s), it tells the hardware to switch the connection=20
> over to the companion.
>
> So if a low-speed (1.5 Mb/s) or full-speed (12 Mb/s) device is connected=
=20
> before ehci-pci loads, its connection will get routed to the companion=20
> controller.  Then when ehci-pci loads, the connection will be switched=20
> over to the EHCI controller, which will cause the existing connection to=
=20
> be dropped.  Then the connection will be routed back to the companion=20
> controller, but it will be perceived as a new connection, resulting in a=
=20
> brief interruption in service.  For many devices this won't matter, but=
=20
> for some it might.  The only way to avoid the problem is to load=20
> ehci-pci before uhci-pci and ohci-pci.
>
> (A similar problem can occur with high-speed-capable devices.  When=20
> initially attached to the companion controller, they are forced to=20
> connect at full speed.  But when the connection is changed to the EHCI=20
> controller, they are able to run at high speed -- and again, the result=
=20
> is a new connection, causing service to be interrupted and then start up=
=20
> fresh but running much faster.)
>
> Alan Stern


