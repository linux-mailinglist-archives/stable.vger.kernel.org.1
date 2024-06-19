Return-Path: <stable+bounces-53788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4C90E63A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C89B2139A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189577113;
	Wed, 19 Jun 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bBMky5p0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A62139B1
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786816; cv=none; b=L3aCg2VpKZV8zHARMclfvIpGmTGJnJ8hpNvDQ+sZ5TBJaYfBAlsI8Ca7JQRtf6hB9cWrFwzt584r0lhUrP1zQtHNwD/424uoH8TDNXW/QcDlhvj+4YosQJqwT41mZyIm23qYGdyvO9goygWa54lGbp5NcqQmASCTL/rsmDsX/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786816; c=relaxed/simple;
	bh=bgv2oOUtsWpSxcTFU+52dNG2tgw9597YPBZ44A3ZxqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+0290GFdjturqcK2FXhsUhobSR3bGjWGWhO/Az7DMduX8XCte1hvLDHm4rA0BvUlsxvLqkhDoHGBk5j4mgWQ8d/bedTzKLRx5T77/GdkSsiSl/eoN85ryrI6MFWthhIsWxM2aI99f2+MppIki86X9b+9hBqccaUybjOSx6sHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bBMky5p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB76BC2BBFC;
	Wed, 19 Jun 2024 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786816;
	bh=bgv2oOUtsWpSxcTFU+52dNG2tgw9597YPBZ44A3ZxqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBMky5p0/irM/RV6Hq1CHkwNdC2p4XFLCqkOmRBVBvnrdyw5kiN3Ae86zCCocHXO3
	 gwMY5fp3CO5+0ghZSQwrQinWcgSaq6Jychy0kcdKiWpfdQCL83lMO3R7Ctc4uTfTJ2
	 qCY7KuNunN4+MsVpfE9GRxR9W5C95lF5nmjlaHl4=
Date: Wed, 19 Jun 2024 10:46:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: stable@vger.kernel.org, will@kernel.org, mhklinux@outlook.com,
	petr.tesarik1@huawei-partners.com, nicolinc@nvidia.com, hch@lst.de
Subject: Re: [PATCH 0/3] swiotlb: Backport to linux-stable 6.6
Message-ID: <2024061940-specks-onyx-18e0@gregkh>
References: <20240617142315.2656683-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617142315.2656683-1-festevam@gmail.com>

On Mon, Jun 17, 2024 at 11:23:12AM -0300, Fabio Estevam wrote:
> This series of swiotlb patches fixes a iwlwifi regression on the
> i.MX8MM IoT Gateway board running kernel 6.6.
> 
> This was noticed when updating the kernel from 5.10 to 6.6.
> 
> Without this series, the board cannot boot kernel 6.6 due to the storm
> of alignment errors from the iwlwifi driver.
> 
> This has been reported and discussed in the linux-wireless list:
> https://lore.kernel.org/linux-wireless/CAOMZO5D2Atb=rnvmNLvu8nrsn+3L9X9NbG1bkZx_MenCCmJK2Q@mail.gmail.com/T/#md2b5063655dfcadf8740285573d504fd46ad0145
> 
> Will Deacon suggested:
> 
> "If you want to backport that change, then I think you should probably
> take the whole series:
> 
> https://lore.kernel.org/all/20240308152829.25754-1-will@kernel.org/
> 
> (and there were some follow-ups from Michael iirc; you're best off
> checking the git history for kernel/dma/swiotlb.c).
> 
> FWIW: we have this series backported to 6.6 in the android15-6.6 tree."
> 
> >From this series, only the two patches below are not present in the
> 6.6 stable tree:
> 
> swiotlb: Enforce page alignment in swiotlb_alloc()
> swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE
> 
> While at it, also backport:
> swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
> 
> as it fixes a commit that is present in 6.6.
> 
> Petr Tesarik (1):
>   swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
> 
> Will Deacon (2):
>   swiotlb: Enforce page alignment in swiotlb_alloc()
>   swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE
> 
>  kernel/dma/swiotlb.c | 83 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 20 deletions(-)
> 

All now queued up, thanks.

greg k-h

