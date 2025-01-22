Return-Path: <stable+bounces-110127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567BEA18DEE
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D99188C9CE
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D88520FA83;
	Wed, 22 Jan 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tyzd1AZy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD72045BC;
	Wed, 22 Jan 2025 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536309; cv=none; b=QawoTcr1pH6QE+ZZb7YlwPfptUxzyMZ6g/OkgdVxE3VltiUh/ocCbA1GE76VnXX1qlskvt6VLCzjnl6xr03sDXhd1OUwgK0dQuFTgjdjLb31vPsAdtNBAZmngt3pnw1D+6dbJ+ar+w5xoXOQW9iQfl5j3feVqiTRWXQK8XMpWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536309; c=relaxed/simple;
	bh=U+gqE+iw4ptpcTIYB9W0f5foTJTvvTyEulF4He7RP2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNKKt8N+LNfKgnlnzaHbp0WOsgjA+viftkKNXaovw25j7fGwzuKcWh3ZE49k1xscdeWDcXz2/k/WnxnTqlU/RgIcB2nELY4OxReTOITN3Ty3LKuZWzkHid1YF+bzhNBQy2WZ7tb8BinoGhJpy+kwykl3dH038DKDMYL+z2AnbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tyzd1AZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D67FC4CED6;
	Wed, 22 Jan 2025 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737536309;
	bh=U+gqE+iw4ptpcTIYB9W0f5foTJTvvTyEulF4He7RP2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tyzd1AZyxGRYzU0mkd2o7WtGL4XcE3ZFZAD/wX4z0rMobnewE9KyXk86+qzSc8PEm
	 pq75KvGvj5Xv71VC190HESNQrSRmU9wvpzDVoHxpIIDbXCnEACsUUhO2FQyda9DtU2
	 cwFslqw6I7sU+UTVFq2Z2/jyjEevrCSqllEA323c=
Date: Wed, 22 Jan 2025 09:58:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guoren@kernel.org
Cc: palmer@dabbelt.com, conor@kernel.org, geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] usb: gadget: udc: renesas_usb3: Fix compiler warning
Message-ID: <2025012212-pug-unmasked-a23b@gregkh>
References: <20250122081231.47594-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122081231.47594-1-guoren@kernel.org>

On Wed, Jan 22, 2025 at 03:12:31AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> drivers/usb/gadget/udc/renesas_usb3.c: In function 'renesas_usb3_probe':
> drivers/usb/gadget/udc/renesas_usb3.c:2638:73: warning: '%d'
> directive output may be truncated writing between 1 and 11 bytes into a
> region of size 6 [-Wformat-truncation=]
> 2638 |   snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
>                                     ^~~~~~~~~~~~~~~~~~~~~~~~     ^~   ^
> 
> Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas
> USB3.0 peripheral controller")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501201409.BIQPtkeB-lkp@intel.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
> index fce5c41d9f29..89b304cf6d03 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -310,7 +310,7 @@ struct renesas_usb3_request {
>  	struct list_head	queue;
>  };
>  
> -#define USB3_EP_NAME_SIZE	8
> +#define USB3_EP_NAME_SIZE	16
>  struct renesas_usb3_ep {
>  	struct usb_ep ep;
>  	struct renesas_usb3 *usb3;
> -- 
> 2.40.1
> 
> 

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

