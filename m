Return-Path: <stable+bounces-183066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1632BB434C
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E54B19E32F1
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2812CCDB;
	Thu,  2 Oct 2025 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyYmN7qG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536531EA84;
	Thu,  2 Oct 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416327; cv=none; b=uMvucDYN95yyXe9a/ti6OzjIH19uV6eotbn2A3e1Ug32aK0fhBl2KInS+gswHsmXrAY6nI34M/2ZDtqdQnfh2WuYq+qyf9ZUun5qzzVa9O8v4yMg4Y4r7VC0kTZKdC4ZwIhi0Lqfzp/i3N3gH2qIFHjI8zMlzV9vLbwzffcunBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416327; c=relaxed/simple;
	bh=hovg+MzsVFfIJLx6d1wu/V4EcBcDv0vurkK1uFcHofU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6S+ISUaAl4D9cGSO0ETLZlZ7NglC66SEOJzgb/HaldLq+/1tV6T7byv+UrN3e79ACJSxb7Hw8O7C7q5ADdBKsQ5UT0eX1uof8OzG1s1VB3AM/3Ry0fTaU9UlLsg4GS/a2hBUii3sTete+nQ4dcHZs8j4tqUutQ0ByRL65HhWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyYmN7qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DDDC4CEFB;
	Thu,  2 Oct 2025 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759416326;
	bh=hovg+MzsVFfIJLx6d1wu/V4EcBcDv0vurkK1uFcHofU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyYmN7qGSN5/kArx1ABt8f54Dhd0h7gkfphpHTn4z25OegPbkGKP2p7D3d43QHWTA
	 GZ/lzlT/GJmx48qzLLzRxLNc0llBPlDHnSwrtFo+yt1Ajg4kMswpqTaqmKunTzXjPb
	 QEodCzLXRUpdU4wqTSUZkqOYfjAg+RNlV5rGVXeTu4IPxriV9dw2Kz7fw+yCXWOOE9
	 cHJPFjA0fSc+3+xomQUidEUQcE+YYDs/vtDF9PoWRhAh3XiwZiiXWEMwz0wEC5Rc8U
	 gs1Ej1bD9D3d+T74Ltcsc+OBqJNisb3Y1iuQ0JtXUkyZD4VWAUwEwvbqO+ld1mk1TC
	 I3e2xeW5IYCjg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v4KYX-000000001Ut-1qub;
	Thu, 02 Oct 2025 16:45:17 +0200
Date: Thu, 2 Oct 2025 16:45:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 11/14] iommu/omap: fix device leaks on probe_device()
Message-ID: <aN6P_Wt2ruMeKF3w@hovoldconsulting.com>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250925122756.10910-12-johan@kernel.org>
 <8e98159d-5c13-453f-8d4b-c7ff80617239@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e98159d-5c13-453f-8d4b-c7ff80617239@arm.com>

On Thu, Oct 02, 2025 at 01:05:08PM +0100, Robin Murphy wrote:
> On 2025-09-25 1:27 pm, Johan Hovold wrote:

> > @@ -1663,22 +1663,22 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
> >   	for (i = 0, tmp = arch_data; i < num_iommus; i++, tmp++) {
> >   		np = of_parse_phandle(dev->of_node, "iommus", i);
> >   		if (!np) {
> > -			kfree(arch_data);
> > -			return ERR_PTR(-EINVAL);
> > +			ret = -EINVAL;
> > +			goto err_put_iommus;
> >   		}
> >   
> >   		pdev = of_find_device_by_node(np);
> >   		if (!pdev) {
> >   			of_node_put(np);
> > -			kfree(arch_data);
> > -			return ERR_PTR(-ENODEV);
> > +			ret = -ENODEV;
> > +			goto err_put_iommus;
> >   		}
> >   
> >   		oiommu = platform_get_drvdata(pdev);
> >   		if (!oiommu) {
> >   			of_node_put(np);
> > -			kfree(arch_data);
> > -			return ERR_PTR(-EINVAL);
> > +			ret = -EINVAL;
> > +			goto err_put_iommus;
> >   		}
> >   
> >   		tmp->iommu_dev = oiommu;
> > @@ -1697,17 +1697,28 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
> >   	oiommu = arch_data->iommu_dev;
> >   
> >   	return &oiommu->iommu;
> > +
> > +err_put_iommus:
> > +	for (tmp = arch_data; tmp->dev; tmp++)
> > +		put_device(tmp->dev);
> 
> This should just pair with the of_node_put() calls (other than the first 
> one, of course), i.e. do it in the success path as well and drop the 
> release_device change below. It doesn't serve any purpose for client 
> devices to hold additional references on the IOMMU device when those are 
> strictly within the lifetime of the IOMMU driver being bound to it anyway.

I kept the reference until release() (even if not strictly needed) as I
mistakenly thought the driver was using the arch data device pointer
directly.

Turns out that one has never been used so I'll drop it as well as part
of v2.

Johan

