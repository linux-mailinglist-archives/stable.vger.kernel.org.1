Return-Path: <stable+bounces-159217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E057BAF1111
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10782483725
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3223D2B8;
	Wed,  2 Jul 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WGkFT4SQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40BD223DEF
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450588; cv=none; b=W1MAHE8CppLKKc5yPJ9etDTjcrfd5OxFtbRKylBwG07jbwZRzXaCthTIv6VvTWxNUtwLG9w2xs9wSb9J6bFh3w22Uyc+QE1v7dfqisuH3XBKR5yTmWOa9pq33Ko5iaVrTE5VJrliafb7AidV6N6i/yyDaEf/9zo0eIFUVpk2dQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450588; c=relaxed/simple;
	bh=1QG1NDhltwyomt8Q0/pRGI048AtmLD0aYgE30VlsWUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=revMyxxY59X6ilX+vnvI0dU1cyEh1XUuK8LpYUZO44MO0A8FCOXwOCfXcwP8E6s2XPAmtt69XScUF3hVB5mSA2W7/fR8t3bDWKldXJc8Q/JljiR4RU0G+LLvvueVY/pjfM9ooRMK6nXDZesTwRTRTC0OE881uKtB/J95XsAvIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WGkFT4SQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0C7C4CEED;
	Wed,  2 Jul 2025 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751450588;
	bh=1QG1NDhltwyomt8Q0/pRGI048AtmLD0aYgE30VlsWUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGkFT4SQkFBBJ33aBSleIWMMHORqCUoRsmToMAQ/+m0CiolGgO00MkXIFxMCQtE7r
	 dxlWSMu6uPn7hniPqcV4rOm6E8ELFs8OYk3ANhcBowQXqoXatzGGILGpEJewwQTP8E
	 F5DpF1XB5IsKgEVwBpYm3HFfKIU8ixJkKSAHfWCE=
Date: Wed, 2 Jul 2025 12:03:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rajani kantha <rajanikantha@engineer.com>
Cc: kees@ijzerbout.nl, baolu.lu@linux.intel.com, jroedel@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
Message-ID: <2025070217-bright-energetic-3537@gregkh>
References: <trinity-5b3af13a-3731-4b47-80a1-8ac7af67791f-1751424444098@3c-app-mailcom-lxa07>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-5b3af13a-3731-4b47-80a1-8ac7af67791f-1751424444098@3c-app-mailcom-lxa07>

On Wed, Jul 02, 2025 at 04:47:24AM +0200, Rajani kantha wrote:
> From: Kees Bakker <kees@ijzerbout.nl>
> 
> [ Upstream commit 60f030f7418d3f1d94f2fb207fe3080e1844630b ]
> 
> There is a WARN_ON_ONCE to catch an unlikely situation when
> domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
> happens we must avoid using a NULL pointer.
> 
> Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
> Link: https://lore.kernel.org/r/20241218201048.E544818E57E@bout3.ijzerbout.nl
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
> ---
>  drivers/iommu/intel/iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 56e9f125cda9..7c351274d004 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4306,13 +4306,14 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>                         break;
>                 }
>         }
> -       WARN_ON_ONCE(!dev_pasid);
>         spin_unlock_irqrestore(&dmar_domain->lock, flags);
> 
>         cache_tag_unassign_domain(dmar_domain, dev, pasid);
>         domain_detach_iommu(dmar_domain, iommu);
> -       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
> -       kfree(dev_pasid);
> +       if (!WARN_ON_ONCE(!dev_pasid)) {
> +               intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
> +               kfree(dev_pasid);
> +       }

Meta-comment about this patch.  If this does trigger, it will still
crash the billions of Linux instances that run with panic-on-warn
enabled.  So you really haven't "solved" the issue here.  If this can be
NULL, then properly handle it please, don't crash boxes...

thanks,

greg k-h

