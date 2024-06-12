Return-Path: <stable+bounces-50202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B342904C48
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECFC1F22BED
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 07:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12216B72E;
	Wed, 12 Jun 2024 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBFRSogy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6812D1FE;
	Wed, 12 Jun 2024 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175857; cv=none; b=bQZP/yVlJp8ULaXOz4LhxmDaeB7r0rxqrsoN5uhiWHDrO/Z+qClLCdrHapR6Fett6nMFmoSX+pzW+aQRZnQ6+b2fXeBDKTP1d+ANdr9MvqbiI0VuTAlbdNHtRauo6bandkTsA6ciER9sB4hqzKPeFZOXodZSQM5nqWs44KSnewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175857; c=relaxed/simple;
	bh=xLZJ6yE0Pk1gBmwG99sse973y+wIq4AWyepsiAVNbpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUwKL/bLJwklbMHHuN6sTXCkri6YDCnF1E6RVInhdchup95kLmnjc4hufX2WxelU573IaZT5w4qmgV7HEs0dyrdcxPGxfqB1yVSzxlJXhKvIlBP2oBEtRZMZoodBr/wtFC72BD+xE9dpKV5st7vZuCUf1ePEfUA3eX/ghhhhqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HBFRSogy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AEBC3277B;
	Wed, 12 Jun 2024 07:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718175856;
	bh=xLZJ6yE0Pk1gBmwG99sse973y+wIq4AWyepsiAVNbpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBFRSogy9S64VkYnT3a6jjLvLbDwEg7hWZ2/ZOfcPJbtSwA32P9mZrBmNeeYsh1no
	 47QDbtBachJfcGtsRPzr0sg7F3l5fgkFL+sQDRBtqbZI95sr3efAoTkr/CGTY9ho4Z
	 JNWAI9TdUVJeMQco0L6/TtgzTMDykDiXiavLonoM=
Date: Wed, 12 Jun 2024 09:04:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] xhci: Don't issue Reset Device command to Etron xHCI host
Message-ID: <2024061257-audacious-usage-67e3@gregkh>
References: <20240612022256.7365-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612022256.7365-1-ki.chiang65@gmail.com>

On Wed, Jun 12, 2024 at 10:22:56AM +0800, Kuangyi Chiang wrote:
> Sometimes hub driver does not recognize USB device that is connected
> to external USB2.0 Hub when system resumes from S4.
> 
> This happens when xHCI driver issue Reset Device command to inform
> Etron xHCI host that USB device has been reset.
> 
> Seems that Etron xHCI host can not perform this command correctly,
> affecting that USB device.
> 
> Instead, to aviod this, xHCI driver should reassign device slot ID
> by calling xhci_free_dev() and then xhci_alloc_dev(), the effect is
> the same.
> 
> Add XHCI_ETRON_HOST quirk flag to invoke workaround in
> xhci_discover_or_reset_device().
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> ---
>  drivers/usb/host/xhci-pci.c |  2 ++
>  drivers/usb/host/xhci.c     | 11 ++++++++++-
>  drivers/usb/host/xhci.h     |  2 ++
>  3 files changed, 14 insertions(+), 1 deletion(-)


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

