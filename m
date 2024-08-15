Return-Path: <stable+bounces-67752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96515952B38
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 11:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD89F2826CB
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4801C579E;
	Thu, 15 Aug 2024 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZQoGLtV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B891917EB;
	Thu, 15 Aug 2024 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710765; cv=none; b=Pm2NJscvO8V4Bp6CIkNre3dL/2sb9ExdX2gQik1kstKgcNGCTqR47WuDanfj7ezylH+igpYa0ekZo0lJhKUyVizSzOMdJToxmN50a6kEmdDvMPpviEuttBT4mMjRjS8rRRpR1zYZPMceOBwZZh6kiAOhHRUn6riSCuS0OGVG+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710765; c=relaxed/simple;
	bh=+7FufQy5uUSO+rNEadZg8a0b3eY3z3EEqg/3AEjyNT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdtcIbTYUApTshq6hlsp+GwWPesnyfv8zuoFQ2C0sgHzwl1/bjC+h1XPFBn+NrSCLBFLixUozoocFXQ+OOvIsz6e3iHYi+rcFh49DB1DaiQIoObD5BxUyH2opZ689OktBrUof8Z/xdCvdxLYPbrNAOQjJ+09HdCV1Ryjk4HXAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZQoGLtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B7CC32786;
	Thu, 15 Aug 2024 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710765;
	bh=+7FufQy5uUSO+rNEadZg8a0b3eY3z3EEqg/3AEjyNT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZQoGLtVpvdd3N+nBuc9TebJy0eGxoVmPF1XY98qWJDzpZ16HSHIaaINe6BFr6Zoc
	 FqpuOMPRdVZQPwI/qnyOhtv+QbKyypmEHzN5cGO8rFb+xY0W5YO7urPoUhFYbdwrAE
	 /22W9fOQGxJKyCj6XwXO4JSqHF3YCS42BQCBrv10=
Date: Thu, 15 Aug 2024 10:32:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Erpeng Xu <xuerpeng@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, shyjumon.n@intel.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org, jonathan.derrick@intel.com,
	wangyuli@uniontech.com
Subject: Re: [PATCH 4.19] nvme/pci: Add sleep quirk for Samsung and Toshiba
 drives
Message-ID: <2024081527-barbell-game-545a@gregkh>
References: <87182CEADE011558+20240731075113.51089-1-xuerpeng@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87182CEADE011558+20240731075113.51089-1-xuerpeng@uniontech.com>

On Wed, Jul 31, 2024 at 03:50:46PM +0800, Erpeng Xu wrote:
> From: Shyjumon N <shyjumon.n@intel.com>
> 
> commit 1fae37accfc5872af3905d4ba71dc6ab15829be7 upstream
> 
> The Samsung SSD SM981/PM981 and Toshiba SSD KBG40ZNT256G on the Lenovo
> C640 platform experience runtime resume issues when the SSDs are kept in
> sleep/suspend mode for long time.
> 
> This patch applies the 'Simple Suspend' quirk to these configurations.
> With this patch, the issue had not been observed in a 1+ day test.
> 
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Shyjumon N <shyjumon.n@intel.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Erpeng Xu <xuerpeng@uniontech.com>
> ---
>  drivers/nvme/host/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9c80f9f08149..b0434b687b17 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2747,6 +2747,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  		    (dmi_match(DMI_BOARD_NAME, "PRIME B350M-A") ||
>  		     dmi_match(DMI_BOARD_NAME, "PRIME Z370-A")))
>  			return NVME_QUIRK_NO_APST;
> +	} else if ((pdev->vendor == 0x144d && (pdev->device == 0xa801 ||
> +		    pdev->device == 0xa808 || pdev->device == 0xa809)) ||
> +		   (pdev->vendor == 0x1e0f && pdev->device == 0x0001)) {
> +		/*
> +		 * Forcing to use host managed nvme power settings for
> +		 * lowest idle power with quick resume latency on
> +		 * Samsung and Toshiba SSDs based on suspend behavior
> +		 * on Coffee Lake board for LENOVO C640
> +		 */
> +		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
> +		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
> +			return NVME_QUIRK_SIMPLE_SUSPEND;
>  	}
>  

This breaks the build, how did you test this?

thanks,

greg k-h

