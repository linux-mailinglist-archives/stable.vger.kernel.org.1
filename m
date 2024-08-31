Return-Path: <stable+bounces-71678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9197966F68
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 07:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85939283A41
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 05:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1B13C9CA;
	Sat, 31 Aug 2024 05:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YqJzunrQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329913C691
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725082103; cv=none; b=mqs3WzIKORCnjhFR3e80rXBWJ59YEc3YWkbLsrR3N7WKq9Ea0rIzdTsl1QT6zG20bdbASaa0rbo9Bxkg0YwfGuE49pmIwhYp4a5h7p3I29lje5Tsf2mqZjgqtvypcg8THFB0hi1L2tPzCmRUIJJtzM956PHDm4/wVUVSDCtpMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725082103; c=relaxed/simple;
	bh=XKhgoD5cgg8QYq6RnTrjyOOOxqIw16eVmXoSCajDRjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDvt8n4N3DGQtJBu9b6ocZPZhf6Oq/xKzMh55TO95dTr/BGskBdvEQHLLKTUOJYTraRjxWZt1LqyUZpX69uBZgc9NNdlVTlq0pOupKrmfYroMXtbzqJYcZS/HgqgZesOzY2dCFE4FmepydZz5VAE7dM1eoy2wq9aFDJi4JCIYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YqJzunrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72902C4CEC0;
	Sat, 31 Aug 2024 05:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725082102;
	bh=XKhgoD5cgg8QYq6RnTrjyOOOxqIw16eVmXoSCajDRjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqJzunrQa7XheUUvnpzlm/N01gn1KTa2GqjdglwB2L6EmSeTyTZa6dddLr4l2NvW7
	 c9hF5vInp15ndn7f57SFw2iGvJTCqXJuKEV/D06DOTVPsh8DYjO7ExgPDOWYr8JWx2
	 uMKfQs8upgs2+f64PBRz+4sC41dAk635ntlEwOmI=
Date: Sat, 31 Aug 2024 07:28:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ariadne Conill <ariadne@ariadne.space>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] s390/pci: follow alloc_pages in dma_map_ops name change
Message-ID: <2024083155-impeach-harmony-034f@gregkh>
References: <20240830233023.20759-1-ariadne@ariadne.space>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830233023.20759-1-ariadne@ariadne.space>

On Fri, Aug 30, 2024 at 04:30:23PM -0700, Ariadne Conill wrote:
> In linux-6.6.y commit 983e6b2636f0099dbac1874c9e885bbe1cf2df05,
> alloc_pages was renamed to alloc_pages_op, but this was not changed for
> the s390 PCI implementation, most likely due to upstream changes in the
> s390 PCI implementation which moved it to using the generic IOMMU
> implementation after Linux 6.6 was released.
> 
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> ---
>  arch/s390/pci/pci_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
> index 99209085c75b..ce0f2990cb04 100644
> --- a/arch/s390/pci/pci_dma.c
> +++ b/arch/s390/pci/pci_dma.c
> @@ -721,7 +721,7 @@ const struct dma_map_ops s390_pci_dma_ops = {
>  	.unmap_page	= s390_dma_unmap_pages,
>  	.mmap		= dma_common_mmap,
>  	.get_sgtable	= dma_common_get_sgtable,
> -	.alloc_pages	= dma_common_alloc_pages,
> +	.alloc_pages_op	= dma_common_alloc_pages,
>  	.free_pages	= dma_common_free_pages,
>  	/* dma_supported is unconditionally true without a callback */
>  };
> -- 
> 2.46.0
> 
> 

Thanks for the fix, but as per:
	https://lore.kernel.org/r/20240830221217.GA3837758@thelio-3990X
I'll just go revert the offending commit instead.

thanks,

greg k-h

