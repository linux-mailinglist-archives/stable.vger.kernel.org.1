Return-Path: <stable+bounces-83482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346099A930
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44421282B6C
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2A19F103;
	Fri, 11 Oct 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufsVwA2Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D119CC1C;
	Fri, 11 Oct 2024 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665680; cv=none; b=Ju1VXecmV5fYqospNHvKA4gb9A5fuN8Cgk8oC05+vQVZFAxArS7N7I08P8lbcZ4J7KZsPL6nMUMDK1SSkcfCZ6u6iWiPAsgXIBRfJBkkE9pnkh++Do+A6vxlS7Dd7Xqa7hMMcimHbMd4vQqv8/wXJXMIjlACl0D63mB3F39lDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665680; c=relaxed/simple;
	bh=ZsYmybhZu4ZCvMH/vb4XwEgP+XdZzVCAccmz0o8mybY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHD0n73AmxRjfZL2vs7Z17ogyKV6646jqlkaICM90ClCeWehLtqA++bjjJKODw/dPf1KoZmMX1cmamMgGZygHJGdNvOxnq3oSeyvTkEW811jolOrKO7ztZuar8zFyWYnMlxVY33opBbyOvHo0sSFI/8NB9X1nJYXBIeNgJYhFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufsVwA2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B8C4CEC3;
	Fri, 11 Oct 2024 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728665679;
	bh=ZsYmybhZu4ZCvMH/vb4XwEgP+XdZzVCAccmz0o8mybY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufsVwA2ZElW1u+ZKTc4gZ77JWPyfWXlC6/7BBeR+oyAGop0Lk9FhP2FvwN/zOqxNO
	 OXg/3S64y9UXftmcuGFAUTzlpTLpJEqppvLDc0zUmf/INJnLD4AbgR0O0iYGdE09AT
	 99bJNDdvlFfyL4J2xJlqaXWBE8nj638X3pmGjAw4=
Date: Fri, 11 Oct 2024 18:54:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Henry Lin <henryl@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Jim Lin <jilin@nvidia.com>,
	Petlozu Pravareshwar <petlozup@nvidia.com>,
	linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] xhci: tegra: fix checked USB2 port number
Message-ID: <2024101120-sycamore-limelight-fe8b@gregkh>
References: <20241011145114.8905-1-henryl@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011145114.8905-1-henryl@nvidia.com>

On Fri, Oct 11, 2024 at 10:51:14PM +0800, Henry Lin wrote:
> If USB virtualizatoin is enabled, USB2 ports are shared between all
> Virtual Functions. The USB2 port number owned by an USB2 root hub in
> a Virtual Function may be less than total USB2 phy number supported
> by the Tegra XUSB controller.
> 
> Using total USB2 phy number as port number to check all PORTSC values
> would cause invalid memory access.
> 
> [  116.923438] Unable to handle kernel paging request at virtual address 006c622f7665642f
> ...
> [  117.213640] Call trace:
> [  117.216783]  tegra_xusb_enter_elpg+0x23c/0x658
> [  117.222021]  tegra_xusb_runtime_suspend+0x40/0x68
> [  117.227260]  pm_generic_runtime_suspend+0x30/0x50
> [  117.232847]  __rpm_callback+0x84/0x3c0
> [  117.237038]  rpm_suspend+0x2dc/0x740
> [  117.241229] pm_runtime_work+0xa0/0xb8
> [  117.245769]  process_scheduled_works+0x24c/0x478
> [  117.251007]  worker_thread+0x23c/0x328
> [  117.255547]  kthread+0x104/0x1b0
> [  117.259389]  ret_from_fork+0x10/0x20
> [  117.263582] Code: 54000222 f9461ae8 f8747908 b4ffff48 (f9400100)
> 
> Cc: <stable@vger.kernel.org> # v6.3+
> Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 6246d5ad1468..76f228e7443c 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -2183,7 +2183,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
>  		goto out;
>  	}
>  
> -	for (i = 0; i < tegra->num_usb_phys; i++) {
> +	for (i = 0; i < xhci->usb2_rhub.num_ports; i++) {
>  		if (!xhci->usb2_rhub.ports[i])
>  			continue;
>  		portsc = readl(xhci->usb2_rhub.ports[i]->addr);
> -- 
> 2.25.1
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

