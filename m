Return-Path: <stable+bounces-121178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A4BA54330
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 08:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152107A28BF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1F1A3149;
	Thu,  6 Mar 2025 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RdmqlPGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5819DF4D;
	Thu,  6 Mar 2025 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244546; cv=none; b=jA+A6hIGLhjGgJkOfMAGn89NY+Nr7KjpdcCsEThK+vPKM9XIoofrWXf6cb6L6vfMeefphynt+9dSALs9vQy1prfLQwYGgiuO8DuaxToPLC3bjVhzCnwKTauSE8x9dPiU31rRycttBHAKysDASE0z7WKhhp9QPDuT3FpZaFVenuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244546; c=relaxed/simple;
	bh=Zg6JBzN0mj2pZVjDAg7PAPRHG1G0yRHfC36Vs3T6Or0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TI5diJP6uV5b1Xhd1/Uq4/Ot8kck05SQh4CeY2EpYBiqbRhp7/kareFSdl8fthjuuIooGuUxTcFx4v5a2dXNAlYSjaltz+Z90NyXSrM9tMLUMvGO2DQGNH4yxnCn1KkXY8/lAsWiqZEf6gIPUA+IShn876+qMNib5FLVM0ZWOzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RdmqlPGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C415EC4CEE4;
	Thu,  6 Mar 2025 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741244545;
	bh=Zg6JBzN0mj2pZVjDAg7PAPRHG1G0yRHfC36Vs3T6Or0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdmqlPGoNu+0Mc88XT7qAyuQrCqZ1aC/UhucS5XyFW/vzGavy0WV7NE8kc3DRN3KH
	 JIKY18q65cPMMrb26LGsTa1NHEtdpi5mekzCUTge00GC5NhoUoGlAi8AfAONQ5xHmL
	 6h2gmJzfP4WdP+uX2SS/zbIZtweF92HSTMJ/FsS4=
Date: Thu, 6 Mar 2025 08:01:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: stable@vger.kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, wei.huang2@amd.com,
	apais@microsoft.com
Subject: Re: [PATCH 6.6.y] iommu/amd: Fixes refcount bug in iommu_v2 driver
Message-ID: <2025030602-trowel-cartridge-fbf0@gregkh>
References: <20250306051822.4267-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306051822.4267-1-sidchintamaneni@gmail.com>

On Thu, Mar 06, 2025 at 05:18:22AM +0000, Siddharth Chintamaneni wrote:
> This fix addresses a refcount bug where the reference count was not
> properly decremented due to the mmput function not being called when
> mmu_notifier_register fails.
> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  drivers/iommu/amd/iommu_v2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index 57c2fb1146e2..bce21e266d64 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -645,7 +645,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
>  
>  	ret = mmu_notifier_register(&pasid_state->mn, mm);
>  	if (ret)
> -		goto out_free;
> +		goto out_mmput;
>  
>  	ret = set_pasid_state(dev_state, pasid_state, pasid);
>  	if (ret)
> @@ -673,6 +673,8 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
>  
>  out_unregister:
>  	mmu_notifier_unregister(&pasid_state->mn, mm);
> +
> +out_mmput:
>  	mmput(mm);
>  
>  out_free:
> -- 
> 2.43.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

