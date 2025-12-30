Return-Path: <stable+bounces-204191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F5ACE8FDB
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 09:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A23B3018F56
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D039267B02;
	Tue, 30 Dec 2025 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dy8srKj4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC11D7E5C;
	Tue, 30 Dec 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767082540; cv=none; b=cOkkqP0Z/X1/RkzpRIbMHYMdfUDzZFpBDImWAwLciof5ShMoMBajNKKO2NwITItb23h2xHO1sdfEnX7ckLu1Bv1tqx01Xmhde9eyuUb0f8BB2TmJTwRJt36HBi+T6WomeXu+HiHmGroq+6ufQFb9RW8Ijx++gdfnUdosI17tpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767082540; c=relaxed/simple;
	bh=doZSLDo7Ij3/ApxM11VoQZBMFJCbz8oHQ1+yI8Fmsow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR2ngmcxm55IDl74jLJrndrkRsrFlvJr8LxLu7iYr1lk6ODzV5Na09Dyub9+3psWrYl1Vl30FR7hLTImzTg3x6uby4avN2AmT76Pw8qpgGksGrOmsjXqN4RfLXHJwRtt828S5BB9FEkB4d7Al8bgkJsD4fZ0IwwFP2pFKAP1Jak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dy8srKj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449EDC4CEFB;
	Tue, 30 Dec 2025 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767082539;
	bh=doZSLDo7Ij3/ApxM11VoQZBMFJCbz8oHQ1+yI8Fmsow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dy8srKj4bfb1djkQ1KqwBhE7WuCcTnWcGF2IIsk3QZ/6rD//JJ7EyclIfMI1jtQey
	 pT6Uqem8X/hGz/WUgCi+bDVSmwfgh3Sya5Y+34LPwiP/7DWFwSAABtkEBlA/TtJmFW
	 ncMiUBNFe4fmm6eBnDqoStmF4Q1waOb9K9C5yu6I=
Date: Tue, 30 Dec 2025 09:15:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shengwen Xiao <atzlinux@sina.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
Message-ID: <2025123049-cadillac-straggler-d2fb@gregkh>
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230080014.3934590-1-chenhuacai@loongson.cn>

On Tue, Dec 30, 2025 at 04:00:14PM +0800, Huacai Chen wrote:
> Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
> loaded first") said that ehci-hcd should be loaded before ohci-hcd and
> uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add soft
> dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehci-
> pci, which is not enough and we may still see the warnings in boot log.
> So fix it by also making ohci-hcd/uhci-hcd depend on ehci-hcd.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Shengwen Xiao <atzlinux@sina.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/usb/host/ohci-hcd.c | 1 +
>  drivers/usb/host/uhci-hcd.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 9c7f3008646e..549c965b7fbe 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -1355,4 +1355,5 @@ static void __exit ohci_hcd_mod_exit(void)
>  	clear_bit(USB_OHCI_LOADED, &usb_hcds_loaded);
>  }
>  module_exit(ohci_hcd_mod_exit);
> +MODULE_SOFTDEP("pre: ehci_hcd");

Ick, no, this way lies madness.  I hate the "softdep" stuff, it's
usually a sign that something is wrong elsewhere.

And don't add this _just_ to fix a warning message in a boot log, if you
don't like that message, then build the module into your kernel, right?

And I really should just go revert 05c92da0c524 ("usb: ohci/uhci - add
soft dependencies on ehci_pci") as well, that feels wrong too.

thanks,

greg k-h

