Return-Path: <stable+bounces-219650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPnTDggUn2nhYwQAu9opvQ
	(envelope-from <stable+bounces-219650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:23:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB99C1998B7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 930343049333
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01490296BCB;
	Wed, 25 Feb 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qyF2GjSY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B596727280F;
	Wed, 25 Feb 2026 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032606; cv=none; b=mXbOeR61wBVfBwY5M0J5NicNsMYDWBfa/MT6HM3QKtAzQ5E+F7+iImLuL2bKg6FM95h52VMva08KjLBRUyQm7A7EU9OXug1fUxBoREMjql4rjABIHIX2jU10evFPrR7pLNJZvgJXYwExTz9U8GZB5NlHrdsW1prksZbERSFCE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032606; c=relaxed/simple;
	bh=UejWfdREaDrfFPZgYBJ+YzBzaiPzuyTqjgCRqfTmp5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMlJDaE7MTjhH1rtpzE5hPoxfv4isDrv5UGMr37Q/DDY7kvtSZRJbJtKiSSqeDLtU8MUHUVEtJa4NUdNUrx1j0wvzELUWiYQO8xg3m09Mr2EbtPHvPCeW2xyaFT9bFbeQ5wPSmGuZ55SaDr1wHIRDLhEMEwZZ/pDxMYzd5z/9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qyF2GjSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD6EC116D0;
	Wed, 25 Feb 2026 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772032606;
	bh=UejWfdREaDrfFPZgYBJ+YzBzaiPzuyTqjgCRqfTmp5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyF2GjSYZss/Pzj6Hd5RTlVOEhARbb4Z6Z+MJr8at3M7hApLfmwEaOf2GU0HuhNEK
	 JyJQg0yeLjI2l/9S8Jk+KuNOlOtftVIzoy+gnP8JzkOsVBm7bIj05VQbYcFQeMysFL
	 2mQsT58KR/w1Ahsswu2URXaQNP+nFaejO4Pg3RdQ=
Date: Wed, 25 Feb 2026 07:16:38 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] uio: uio_pci_generic_sva: fix double free of
 devm_kzalloc() memory
Message-ID: <2026022525-donut-speech-c4a9@gregkh>
References: <20260225145131.4178163-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225145131.4178163-1-lgs201920130244@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219650-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB99C1998B7
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:51:31PM +0800, Guangshuo Li wrote:
> uio_pci_sva allocates struct uio_pci_sva_dev with devm_kzalloc() in
> probe(), but then calls kfree(udev) both on the probe() error path
> (label out_free) and again in remove().
> 
> Because devm_kzalloc() allocations are devres-managed and are freed
> automatically when the device is detached (including after a failing
> probe() and during driver unbind), the explicit kfree() can lead to a
> double free.
> 
> If probe() fails after devm_kzalloc(), the error path frees udev and
> devres cleanup will free it again when the core unwinds the partially
> bound device.  On normal driver removal, remove() frees udev and devres
> will free it again when the device is detached.
> 
> Fix by removing the manual kfree() calls and dropping the now-unused
> label.
> 
> Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/uio/uio_pci_generic_sva.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
> index 4a46acd994a8..152201047334 100644
> --- a/drivers/uio/uio_pci_generic_sva.c
> +++ b/drivers/uio/uio_pci_generic_sva.c
> @@ -129,15 +129,13 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	ret = devm_uio_register_device(&pdev->dev, &udev->info);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register uio device\n");
> -		goto out_free;
> +		goto out_disable;
>  	}
>  
>  	pci_set_drvdata(pdev, udev);
>  
>  	return 0;
>  
> -out_free:
> -	kfree(udev);
>  out_disable:
>  	pci_disable_device(pdev);
>  
> @@ -150,7 +148,6 @@ static void remove(struct pci_dev *pdev)
>  
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
> -	kfree(udev);
>  }
>  
>  static ssize_t pasid_show(struct device *dev,
> -- 
> 2.43.0
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

