Return-Path: <stable+bounces-112036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B966A25E9F
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C8F160AE4
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F343A20967A;
	Mon,  3 Feb 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvM/Es2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9A204C04;
	Mon,  3 Feb 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596362; cv=none; b=QQGgqSCFQFxVw7qMeqzC4I2DhghYETExUATEjrtVb3ylsME7bsKZAj7iMz+NuyGb5NLV5dYadotDsT4XfTzfe6Zm9Ubge6cBJw0thoLCBgaGmdGC1AGZZ7cJJzbVWSIREGdneo3fR3Ixpe85FxCJClFRLYrX715IrH+q02IhlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596362; c=relaxed/simple;
	bh=I9J//zaTMkgQl1PQBe/KCkPtbJtu1NQ1QIDIsizyG4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLRnk6exoMo8gboq693+qTSm+xng+s5vvQSeka9BonhfbqS5XHxyxPKai0JrDSKSL21g0aXjrJCb24iM79Z+sgv9UMQgA6zZNyNSJKV0XYL7xAWPOjdO/neZe1DJIXNYCHxNgx9y40bo4sxTNK9xlEYawe1oRzvvUfOL3inNHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvM/Es2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E43C4CED2;
	Mon,  3 Feb 2025 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738596362;
	bh=I9J//zaTMkgQl1PQBe/KCkPtbJtu1NQ1QIDIsizyG4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvM/Es2it1v/17q9LLvh68nzNiPbCVMRmTysEhmn0dX2k7mNK2bYm5NVUU4ci1O+f
	 W3fLl4KhpBcmgYnVRr7uIXnS4gpaYSc8hmYON1rfJJBU5wMlcxW3H13huTsIWuRbzC
	 rvrn+kDt0/8Tem/q66caiehlv+VTivDojFw/5xtw=
Date: Mon, 3 Feb 2025 16:25:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: nb@tipi-net.de
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Ben Hutchings <ben@decadent.org.uk>, n.buchwitz@kunbus.com,
	l.sanfilippo@kunbus.com, stable@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Restore Renesas uPD72020x support in xhci-pci
Message-ID: <2025020336-filled-hardiness-e9f2@gregkh>
References: <20250203120026.2010567-1-nb@tipi-net.de>
 <2025020307-charity-snowfield-c975@gregkh>
 <5965e4219781df26f733a2e93bed9f37@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5965e4219781df26f733a2e93bed9f37@tipi-net.de>

On Mon, Feb 03, 2025 at 02:00:55PM +0100, nb@tipi-net.de wrote:
> On 3.2.2025 13:46, Greg Kroah-Hartman wrote:
> > On Mon, Feb 03, 2025 at 01:00:26PM +0100, nb@tipi-net.de wrote:
> > > From: Nicolai Buchwitz <nb@tipi-net.de>
> > > 
> > > Before commit 25f51b76f90f1 ("xhci-pci: Make xhci-pci-renesas a proper
> > > modular driver"), the xhci-pci driver handled the Renesas uPD72020x
> > > USB3
> > > PHY and only utilized features of xhci-pci-renesas when no external
> > > firmware EEPROM was attached. This allowed devices with a valid
> > > firmware
> > > stored in EEPROM to function without requiring xhci-pci-renesas.
> > > 
> > > That commit changed the behavior, making xhci-pci-renesas
> > > responsible for
> > > handling these devices entirely, even when firmware was already
> > > present
> > > in EEPROM. As a result, unnecessary warnings about missing firmware
> > > files
> > > appeared, and more critically, USB functionality broke whens
> > > CONFIG_USB_XHCI_PCI_RENESAS was not enabled—despite previously
> > > workings
> > > without it.
> > > 
> > > Fix this by ensuring that devices are only handed over to
> > > xhci-pci-renesas
> > > if the config option is enabled. Otherwise, restore the original
> > > behavior
> > > and handle them as standard xhci-pci devices.
> > > 
> > > Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> > > Fixes: 25f51b76f90f ("xhci-pci: Make xhci-pci-renesas a proper
> > > modular driver")
> > > ---
> > >  drivers/usb/host/xhci-pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > > index 2d1e205c14c60..4ce80d8ac603e 100644
> > > --- a/drivers/usb/host/xhci-pci.c
> > > +++ b/drivers/usb/host/xhci-pci.c
> > > @@ -654,9 +654,11 @@ int xhci_pci_common_probe(struct pci_dev *dev,
> > > const struct pci_device_id *id)
> > >  EXPORT_SYMBOL_NS_GPL(xhci_pci_common_probe, "xhci");
> > > 
> > >  static const struct pci_device_id pci_ids_reject[] = {
> > > +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS)
> > >  	/* handled by xhci-pci-renesas */
> > >  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0014) },
> > >  	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0015) },
> > > +#endif
> > >  	{ /* end: all zeroes */ }
> > >  };
> > 
> > Have you seen:
> > 	https://lore.kernel.org/r/20250128104529.58a79bfc@foxbook
> > ?
> Hi Greg.
> 
> Thanks, I must have overlooked Michal's patch when I initially stumbled over
> the issue.
> > 
> > Which one is correct?
> 
> I guess both, as Michal is implementing the same slightly different.
> 
> My approach was to to keep the changes less invasive as possible and thus
> make it possible to use pci_ids_reject[] for further exceptions in the
> xhci-pci driver. In Michael's patch the list is specifically used for
> blacklisting the Renesas devices and cannot easily be expanded for other
> controllers. Either approach is fine with me, so lets move the discussion to
> the patch which came first.

Ok, can you test Michael's patch and respond with a tested-by if it
works for you?

thanks,

greg k-h

