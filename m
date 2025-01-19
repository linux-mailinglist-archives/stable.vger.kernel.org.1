Return-Path: <stable+bounces-109477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E1A160C2
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 08:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729487A1DEE
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FFC18D622;
	Sun, 19 Jan 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AITm3UxW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC98F4A;
	Sun, 19 Jan 2025 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737272259; cv=none; b=MD6Tx9ZSIuEHLsFH7ynPYh0YrDZvN61cmbqiYenA7aXSnBFSieBcMmA2q5pfb85BXM3xB1AnpSiRZuTCbcu+ZK319RUeDiXE//AOUVA89ZRyPP6EroAqdlibCn2wqlgVxWMBxWVVbQAGWxarbHN/LLXdX5P4vagFYxWfsWuJx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737272259; c=relaxed/simple;
	bh=Uy7j0OUPuG7KfV18kfcnox04BMC0kq01e7aQ4lA16lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDPlnrzUkcWY+xdh+4hIpQUFusj1qpX+G4xbvldFD4g+jXqyBSvHlppfQqWGQROp/8nms0/9lQfmPlwPMkMJrn1wTeJL5+rIJ7fAE/gCPJLs8J8HQsIluCodNOz3/9uySSwJpQxdPSr5xehnFMGk9dsZJWXFJko5qDVm4oGBe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AITm3UxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B83C4CED6;
	Sun, 19 Jan 2025 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737272258;
	bh=Uy7j0OUPuG7KfV18kfcnox04BMC0kq01e7aQ4lA16lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AITm3UxW/cTEhcfTe7GMIeTO550rDYPWW0x+chschqZicqQ4CSwy7G0d0KmYD2IFB
	 rQBGRUVjY50S3L35Nbv9uk6c0tNxXULS9gr7cRsLgj7TWFta0hgvvMNn4LbseuO6ik
	 qnO+VD9iiC9ie55CFJGJs9ya/O0VWVP+VsCHjTy8=
Date: Sun, 19 Jan 2025 08:37:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>
Cc: stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef
 for CONFIG_PM conditionals
Message-ID: <2025011941-spinster-ploy-feda@gregkh>
References: <20250118122409.4052121-1-re@w6rz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118122409.4052121-1-re@w6rz.net>

On Sat, Jan 18, 2025 at 04:24:09AM -0800, Ron Economos wrote:
> commit 9734fd7a27772016b1f6e31a03258338a219d7d6
> 
> This fixes the build when CONFIG_PM is not set
> 
> Signed-off-by: Ron Economos <re@w6rz.net>
> ---
>  drivers/usb/host/xhci-pci.c | 8 +++++++-
>  include/linux/usb/hcd.h     | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)

<snip>

I've finally been able to reproduce this issue here, and have trimmed
this revert down even more to be the following patch.  I'll go do a new
6.1.y release with just it in now.

thanks,

greg k-h

From: Ron Economos <re@w6rz.net>
Date: Sat, 18 Jan 2025 04:24:09 -0800
Subject: Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org, Ron Economos <re@w6rz.net>
Message-ID: <20250118122409.4052121-1-re@w6rz.net>

commit 9734fd7a2777 ("xhci: use pm_ptr() instead of #ifdef for CONFIG_PM
conditionals") did not quite work properly in the 6.1.y branch where it was
applied to fix a build error when CONFIG_PM was set as it left the following
build errors still present:

	ERROR: modpost: "xhci_suspend" [drivers/usb/host/xhci-pci.ko] undefined!
	ERROR: modpost: "xhci_resume" [drivers/usb/host/xhci-pci.ko] undefined!

Fix this up by properly placing the #ifdef CONFIG_PM in the xhci-pci.c and
hcd.h files to handle this correctly.

Link: https://lore.kernel.org/r/133dbfa0-4a37-4ae0-bb95-1a35f668ec11@w6rz.net
Signed-off-by: Ron Economos <re@w6rz.net>
Link: https://lore.kernel.org/r/d0919169-ee06-4bdd-b2e3-2f776db90971@roeck-us.net
Reported-by: Guenter Roeck <linux@roeck-us.net>
[ Trimmed the partial revert down to an even smaller bit to only be what
  is required to fix the build error - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-pci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -571,6 +571,7 @@ static void xhci_pci_remove(struct pci_d
 		pci_set_power_state(dev, PCI_D3hot);
 }
 
+#ifdef CONFIG_PM
 /*
  * In some Intel xHCI controllers, in order to get D3 working,
  * through a vendor specific SSIC CONFIG register at offset 0x883c,
@@ -720,6 +721,7 @@ static void xhci_pci_shutdown(struct usb
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
+#endif /* CONFIG_PM */
 
 /*-------------------------------------------------------------------------*/
 
@@ -769,9 +771,11 @@ static struct pci_driver xhci_pci_driver
 static int __init xhci_pci_init(void)
 {
 	xhci_init_driver(&xhci_pci_hc_driver, &xhci_pci_overrides);
+#ifdef CONFIG_PM
 	xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
 	xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
 	xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
+#endif
 	return pci_register_driver(&xhci_pci_driver);
 }
 module_init(xhci_pci_init);

