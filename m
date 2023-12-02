Return-Path: <stable+bounces-3698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6872801B30
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 08:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB261C20A36
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB7FC121;
	Sat,  2 Dec 2023 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mp9Wp8JJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C98567C;
	Sat,  2 Dec 2023 07:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11956C433C7;
	Sat,  2 Dec 2023 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701503441;
	bh=m7wPyEdFGIEfY2IVD5FQ6M1rCIPZHyFgyXL+3r9lm0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mp9Wp8JJMRn3HD+2uPGV9tL+4+FXm95OAvzwCiEjWBBcOrBkdPV3RuWLa7VZTQOAZ
	 tt8+3S/B7H4/LopHnPts73A3K1tH0G8GUXk6M1CVFf68LIWVBsstUjPdW2LYxYPBwD
	 lVzLLmNrJDXX3lPWhr+wtTKirBJgqgJn+ebYHEjM=
Date: Sat, 2 Dec 2023 08:50:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	"Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
	stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline
 kernel 6.6.2+
Message-ID: <2023120213-octagon-clarity-5be3@gregkh>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
 <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
 <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>

On Sat, Dec 02, 2023 at 08:23:55AM +0100, Paul Menzel wrote:
> [Cc: +Mario, Mathias, linux-usb]
> 
> Am 02.12.23 um 07:43 schrieb Kris Karas (Bug Reporting):
> > Greg KH wrote:
> > > On Fri, Dec 01, 2023 at 07:33:03AM +0100, Thorsten Leemhuis wrote:
> > > > CCing a few lists and people. Greg is among them, who might know if this
> > > > is a known issue that 6.6.4-rc1 et. al. might already fix.
> > > 
> > > Not known to me, bisection is needed so we can track down the problem
> > > please.
> > 
> > And the winner is...
> > 
> > > commit 14a51fa544225deb9ac2f1f9f3c10dedb29f5d2f
> > > Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> > > Date:   Thu Oct 19 13:29:19 2023 +0300
> > > 
> > >     xhci: Loosen RPM as default policy to cover for AMD xHC 1.1
> > > >>     [ Upstream commit 4baf1218150985ee3ab0a27220456a1f027ea0ac ]
> > > 
> > >     The AMD USB host controller (1022:43f7) isn't going into PCI D3 by default
> > >     without anything connected. This is because the policy that was introduced
> > >     by commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
> > >     xHC 1.2 or later devices") only covered 1.2 or later.
> > > [ snip ]
> > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > > index b9ae5c2a2527..bde43cef8846 100644
> > > --- a/drivers/usb/host/xhci-pci.c
> > > +++ b/drivers/usb/host/xhci-pci.c
> > > @@ -535,6 +535,8 @@ static void xhci_pci_quirks(struct device *dev,
> > > struct xhci_hcd *xhci)
> > >         /* xHC spec requires PCI devices to support D3hot and D3cold */
> > >         if (xhci->hci_version >= 0x120)
> > >                 xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> > > +       else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
> > > +               xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> > > 
> > >         if (xhci->quirks & XHCI_RESET_ON_RESUME)
> > >                 xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
> > 
> > 
> > Huh, OK, I was expecting this to be a patch made to the bluetooth code,
> > as it caused bluetoothd to bomb with "opcode 0x0c03 failed".  But I just
> > verified I did the bisect correctly by backing this two-liner out of
> > vanilla 6.6.3, and bluetooth returned to normal operation.  Huzzah!
> > 
> > Just a brief recap:
> > 
> > This bug appears to be rather hardware-specific, as only a few folks
> > have reported it.  In my case, the hardware is an ASrock "X470 Taichi"
> > motherboard, and its on-board bluetooth hardware, reporting itself as:
> > lspci: 0f:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Zeppelin USB 3.0 xHCI Compliant Host Controller
> > lsusb: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth
> > 
> > When Basavaraj's patch is applied (in mainline 6.6.2+), bluetooth stops
> > functioning on my motherboard.
> > 
> > Originally from bugzilla #218142 [1]
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218142

Should already be fixed in the 6.6.3 release, can you please verify that
this is broken there?

thanks,

greg k-h

