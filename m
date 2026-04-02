Return-Path: <stable+bounces-233023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCYdA5F0zmkpnwYAu9opvQ
	(envelope-from <stable+bounces-233023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:52:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07D38A0B1
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBA493011C96
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF43019DC;
	Thu,  2 Apr 2026 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A6zkSczA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3C35898;
	Thu,  2 Apr 2026 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137932; cv=none; b=mXOJkGfBycFlmKDPuQ/owsiCzpoYJ6Sr9eOOiE3Xr3xzDR3a+Rf8u8zXiSACizgbTT1bWMK9q2AI8WoNfqAz/HoS6nEdSDfcPhJAdsiQkIhOpdHC43TLqQWNsIVukj1qVJ2UFHEU4b+uuna1QqWByCwxLoIxuvTs99+GcLl8iEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137932; c=relaxed/simple;
	bh=j1nFlbTjW5G0+xsWFfUs/pFocKtHvLXqUGhmlkuoA3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8kmmaCi2aJSJHDNs3xj6edCGQWmh35xznkgHTsmF9RQZZSkB73B7luplUtDVCQaHELrbv5KCMs9wjEtqW4rlqmvJZoS0cH4NnE2WFekTB8e180gY4Or8FsYRIUoilf4EIZGawxk+BhPoYO30btO4Dm8tLyqAjWH6epald1eX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A6zkSczA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE5BC116C6;
	Thu,  2 Apr 2026 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775137931;
	bh=j1nFlbTjW5G0+xsWFfUs/pFocKtHvLXqUGhmlkuoA3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6zkSczAudYAcWYEof0EcBFfQnJvxUkba7dRTtu3ZzNKNZ2CjdoGp2E/dsLHWRubw
	 UbJ5G2yWbqA9fE2r+6FJeZCLYmNyXinop9CkxSZ1flhq9/5BwgC9Qil/7WUaiqVzSP
	 hgqqQiehf9BTFWjMjjHkCC6kwIcvdYJe5TX/HK8k=
Date: Thu, 2 Apr 2026 15:52:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] uio: uio_pci_generic_sva: fix double free of
 devm_kzalloc() memory
Message-ID: <2026040232-ungloved-bonnet-a407@gregkh>
References: <20260226153250.18079-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226153250.18079-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233023-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8E07D38A0B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Feb 26, 2026 at 11:32:50PM +0800, Guangshuo Li wrote:
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
> bound device. On normal driver removal, remove() frees udev and devres
> will free it again when the device is detached.
> 
> This issue was identified by a static analysis tool I developed and
> confirmed by manual review. Fix by removing the manual kfree() calls
> and dropping the now-unused label.
> 
> Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v4:
>   - Add description of how the issue was found and tested.
> 
> v3:
>   - Add changelog below the --- line describing changes since v2.
> 
> v2:
>   - Reflow commit message to keep lines within 75 characters.
> 
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

Breaks the build, how did you test this:
  CC [M]  drivers/uio/uio_pci_generic_sva.o
drivers/uio/uio_pci_generic_sva.c:147:26: error: unused variable 'udev' [-Werror,-Wunused-variable]
  147 |         struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
      |                                 ^~~~
1 error generated.

{sigh}

