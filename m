Return-Path: <stable+bounces-83596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0DF99B574
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CB8284A74
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134CB19308A;
	Sat, 12 Oct 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juZrLeF8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAEF38384;
	Sat, 12 Oct 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742788; cv=none; b=NuXKxSzBMQdk/nBZ451sXza6s9yEEdgj3PR4p6k4O8vCeUpZNp2EWSSDM9rftAJnu39MyL9qMCf2ycZ6k9Z6Rnhm3HJe0qm16CcFemL9XbBmW4acrXHCS5GkdcIcViIxW1SLI6RqhS/PTVwd67av8ls6PMgnhzhp/nkJbzpgiiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742788; c=relaxed/simple;
	bh=UGX0PCuMoBfiAAVtFvwd7UVBfTp9C13ZWy2aAjRvrdU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pXyu7xAlEaY0GHSFJQZnchMPFAdWqYuVTctFCRx2mZBcVcGJUx0G1Oj50igwh7sm6CM8klvG/pDcNW3cN6UDmBWN56biKjiiL/I4dO0RQBTsZi7DaINq/1CP9vycr3FFR9+bUC9In8i53Sne7tbd1c6AisisbnGrKr3R8O2+Oeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juZrLeF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08886C4CEC6;
	Sat, 12 Oct 2024 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742788;
	bh=UGX0PCuMoBfiAAVtFvwd7UVBfTp9C13ZWy2aAjRvrdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=juZrLeF8mJ676GPmN4cI3Ys7qEok0aQk9imB3bBDPsrZnHWOw+lDEJzQJikQlnvQG
	 M3+ENaCImlwltHqeGHITaqClk2acdHX+HfGXb8JtQtWDCuIShZlNT7/lfHYFdV6goQ
	 utF2xRBFsFb05j1aILJaANR4xkcmDLjRIePGvyJzE+zA+yEeSALaU9MsAQLmMl90/R
	 YPZ4yJBN9pBnnmgCbfuykGvC5rIqygtDDqhf8EG/+1PZ1hRj3GXVtuDDIgQkHaTiOO
	 wtZn3QgY2Ce3GW7G+Y2VoEwEmKeuCG54QdPOwKP57XtS/FcEygU9qQ+ZVi6Q/O2VSo
	 8n63dxCzljr5g==
Date: Sat, 12 Oct 2024 09:19:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Todd Brandt <todd.e.brandt@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marcin =?utf-8?B?TWlyb3PFgmF3?= <marcin@mejor.pl>,
	regressions@leemhuis.info
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect pci_for_each_dma_alias()
 for non-PCI devices
Message-ID: <20241012141944.GA603705@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012030720.90218-1-baolu.lu@linux.intel.com>

[+cc Marcin, Thorsten]

On Sat, Oct 12, 2024 at 11:07:20AM +0800, Lu Baolu wrote:
> Previously, the domain_context_clear() function incorrectly called
> pci_for_each_dma_alias() to set up context entries for non-PCI devices.
> This could lead to kernel hangs or other unexpected behavior.
> 
> Add a check to only call pci_for_each_dma_alias() for PCI devices. For
> non-PCI devices, domain_context_clear_one() is called directly.
> 
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219363

Likely the same problem reported earlier by Marcin at
https://bugzilla.kernel.org/show_bug.cgi?id=219349

Thanks to Thorsten for pointing this out.

> Fixes: 9a16ab9d6402 ("iommu/vt-d: Make context clearing consistent with context mapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f6b0780f2ef..e860bc9439a2 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3340,8 +3340,10 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
>   */
>  static void domain_context_clear(struct device_domain_info *info)
>  {
> -	if (!dev_is_pci(info->dev))
> +	if (!dev_is_pci(info->dev)) {
>  		domain_context_clear_one(info, info->bus, info->devfn);
> +		return;
> +	}
>  
>  	pci_for_each_dma_alias(to_pci_dev(info->dev),
>  			       &domain_context_clear_one_cb, info);
> -- 
> 2.43.0
> 

