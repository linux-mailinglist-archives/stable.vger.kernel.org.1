Return-Path: <stable+bounces-100417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F839EB0A1
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B3C162E92
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1641A0AFA;
	Tue, 10 Dec 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Az/y4fyj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662F23DE9A;
	Tue, 10 Dec 2024 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833162; cv=none; b=kjFxhzMUL0iBLHqAB0c/1et29FWp0F2LRhJlEAm0Sm/QF/x+YyVpo61ZIFZ9sb4/palSV3nWXj9nnDyx14fgJzG5TFY/1z5sl2wJTSX0nUsZyFUNLCX/oLft9ypMdyDip9ayN+X2CRDNBl+K7eflKiHf03qnJkRf0HrDpbI/0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833162; c=relaxed/simple;
	bh=nrNTEf2/DhTGVPKySIxg6W7f4R3qe2Kjs8k61X0pxDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLnGn5wXWwMyYk4lWiGmZm9LfKprZMnzL+vKXSJxh++luRVI0zXmdazJUwoR5+xkxGCXGb750zY7bh9q4lTR6D8pjoW2rvIpB4aO4ArMrzrzA3NcovLtiIGKQU4sWy7X5Z9u4wbncdO42piXBWPXiI/hw4fKT7jF9NH+lVqTgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Az/y4fyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B93FC4CED6;
	Tue, 10 Dec 2024 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733833161;
	bh=nrNTEf2/DhTGVPKySIxg6W7f4R3qe2Kjs8k61X0pxDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Az/y4fyjj5tGAOq22cF4IQ8btn/dLYkDqaaRP+LLUCxE1Te7ZZOQ0fRkv1WgiKXyW
	 ZmgrtBM2Z+SGa5vohrvF+UcMy6tHk2URacz/bTJr6dgf3Ah82PzfpOKikVJyPMruSY
	 fHBYEa5xmwAGgO4bZvIMTowPxTQRM+SdZqSOW/So=
Date: Tue, 10 Dec 2024 13:18:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	quic_pbrahma@quicinc.com, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: Patch "iommu/arm-smmu: Defer probe of clients after smmu device
 bound" has been added to the 6.6-stable tree
Message-ID: <2024121030-donated-giggly-0c15@gregkh>
References: <20241209112749.3166445-1-sashal@kernel.org>
 <7dc48afa-1ea8-4ed4-8e55-7c108299522b@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dc48afa-1ea8-4ed4-8e55-7c108299522b@arm.com>

On Tue, Dec 10, 2024 at 12:14:44PM +0000, Robin Murphy wrote:
> On 2024-12-09 11:27 am, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      iommu/arm-smmu: Defer probe of clients after smmu device bound
> > 
> > to the 6.6-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       iommu-arm-smmu-defer-probe-of-clients-after-smmu-dev.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> FWIW the correct resolution for cherry-picking this directly is the
> logically-straightforward one, as below (git is mostly just confused by
> the context)
> 
> Cheers,
> Robin.
> 
> ----->8-----
> diff --cc drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0,14618772a3d6..000000000000
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@@ -1357,10 -1435,19 +1357,21 @@@ static struct iommu_device *arm_smmu_pr
>   		fwspec = dev_iommu_fwspec_get(dev);
>   		if (ret)
>   			goto out_free;
>  -	} else {
>  +	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
>   		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> +
> + 		/*
> + 		 * Defer probe if the relevant SMMU instance hasn't finished
> + 		 * probing yet. This is a fragile hack and we'd ideally
> + 		 * avoid this race in the core code. Until that's ironed
> + 		 * out, however, this is the most pragmatic option on the
> + 		 * table.
> + 		 */
> + 		if (!smmu)
> + 			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
> + 						"smmu dev has not bound yet\n"));
>  +	} else {
>  +		return ERR_PTR(-ENODEV);
>   	}
>   	ret = -EINVAL;a

Can you resend this in a patch that we can apply as-is?

thanks,

greg k-h

