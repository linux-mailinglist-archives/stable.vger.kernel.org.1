Return-Path: <stable+bounces-106681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED43A004CA
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 08:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B98A163043
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE521C3054;
	Fri,  3 Jan 2025 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E3UARXSS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430814F9F4;
	Fri,  3 Jan 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888169; cv=none; b=tO+XTDvKQmanV0bQPOJZfkoZKk1QuNNRx1aa6U6GCHWqT6+ouDzsnOXMiTIcRsk4EdcJijc8mm6Vfje8tndq6Qfn55e47sIhZMykC1Z1sg/dSVrBWfrTwdn0v81pnDM+ew5zZe3O/FZSbT9mqLdpoemepLNoDG20eKehjUckJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888169; c=relaxed/simple;
	bh=iP3uA7XHAFGMmEZtpaxjE5rSgCknvcjaLy6X/ZKREC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjSU2Jw9C6QcmxTwY7qxO/wckVsKTUuDipjL66ZBgC2f6KLGseKyVtuVM9jQe56ZHraMDMaRjRcr/zohOm3dxFKnBxMWL7zwxyuXxTTYfZA9gpSHHx8RBgxbVct1m8iMu6hIFbo99hhEKENXPwAT4U4pJ9khr60Dll8dv1bTcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E3UARXSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518A1C4CECE;
	Fri,  3 Jan 2025 07:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735888167;
	bh=iP3uA7XHAFGMmEZtpaxjE5rSgCknvcjaLy6X/ZKREC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3UARXSSvHB5gChqCiZ3ajtbsb3TIO5INaIDhonG++mkmQzFgGq7qGmaNaL0/ejhB
	 xlvVDnIZdIPsMUzBJDHpBUGy/jti2rgPbNHnCpNfyXzgLaMsHNfO9trlOUPFp3rkFV
	 INmjoclC6UxA1uhOWw5+q0DF7EfpIAQT7OP4Enqw=
Date: Fri, 3 Jan 2025 08:09:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wayne Chang <waynec@nvidia.com>, stable@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: Re: [PATCH v3] USB: core: Disable LPM only for non-suspended ports
Message-ID: <2025010306-datebook-huff-fc1b@gregkh>
References: <20241206074817.89189-1-kaihengf@nvidia.com>
 <dd77fa22-fde8-48c7-8ef4-6e2dc700ef0c@nvidia.com>
 <51fefb2c-6858-49de-9250-d464ef9c6757@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51fefb2c-6858-49de-9250-d464ef9c6757@nvidia.com>

On Thu, Jan 02, 2025 at 02:20:13PM +0000, Jon Hunter wrote:
> Hi Greg,
> 
> On 18/12/2024 16:21, Jon Hunter wrote:
> > 
> > On 06/12/2024 07:48, Kai-Heng Feng wrote:
> > > There's USB error when tegra board is shutting down:
> > > [  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
> > > [  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
> > > [  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
> > > [  186.157172] tegra-xusb 3610000.usb: xHCI host controller not
> > > responding, assume dead
> > > [  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
> > > [  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for
> > > evaluate context command
> > > 
> > > The issue is caused by disabling LPM on already suspended ports.
> > > 
> > > For USB2 LPM, the LPM is already disabled during port suspend. For USB3
> > > LPM, port won't transit to U1/U2 when it's already suspended in U3,
> > > hence disabling LPM is only needed for ports that are not suspended.
> > > 
> > > Cc: Wayne Chang <waynec@nvidia.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
> > > Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > > ---
> > > v3:
> > >   Use udev->port_is_suspended which reflects upstream port status
> > > 
> > > v2:
> > >   Add "Cc: stable@vger.kernel.org"
> > > 
> > >   drivers/usb/core/port.c | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> > > index e7da2fca11a4..c92fb648a1c4 100644
> > > --- a/drivers/usb/core/port.c
> > > +++ b/drivers/usb/core/port.c
> > > @@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct
> > > device *dev)
> > >   static void usb_port_shutdown(struct device *dev)
> > >   {
> > >       struct usb_port *port_dev = to_usb_port(dev);
> > > +    struct usb_device *udev = port_dev->child;
> > > -    if (port_dev->child) {
> > > -        usb_disable_usb2_hardware_lpm(port_dev->child);
> > > -        usb_unlocked_disable_lpm(port_dev->child);
> > > +    if (udev && !udev->port_is_suspended) {
> > > +        usb_disable_usb2_hardware_lpm(udev);
> > > +        usb_unlocked_disable_lpm(udev);
> > >       }
> > >   }
> > 
> > 
> > This resolves the issue I have been seeing [0].
> > 
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > 
> > Thanks!
> > Jon
> > 
> > [0] https://lore.kernel.org/linux-usb/
> > d5e79487-0f99-4ff2-8f49-0c403f1190af@nvidia.com/
> 
> 
> Let me know if you OK to pick up this fix now?

This is already in linux-next and in my usb-linus branch and should go
to Linus today or tomorrow.

thanks,

greg k-h

