Return-Path: <stable+bounces-75961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC8976291
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 09:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCEE1F29EF0
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 07:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976DD18C92F;
	Thu, 12 Sep 2024 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Du9swgIG"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91818C90C
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125644; cv=none; b=m6bvWN5uAT6CPctv4wEQ9jI+scj+ulML8drpXFQZ3YrFYZq96yFocxIfqrHu0ClgT6tWd30gAU0y4WR8zhbYBOqqv5xu5Rfez4cOox+1EHD9v9Aq4uQKl1DymSR5Riy2b9KNvev/fPEPpbb54nTIoVikZSx/LsObHyQfjI75oAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125644; c=relaxed/simple;
	bh=b9U5eANp9GKWrkzxfXMblKUuLn8vJkNE9dbwlUT+x4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqZYAmeUT9fhgEykPtOzwVeO0QoR8lulr/GS4KWflIG4EjWUC1DOMV1nTqEYb6Edc6HB7O2n1ZhsKp5q4P6+nHO3ERDHRvvFvQ+gDLb6zWijfgsCEln3LwKL4k+MRcNAYrJrg4zKMVZRI0LfTWC9WWPifGQtnRHrGsyF7kFHxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Du9swgIG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2F905289812;
	Thu, 12 Sep 2024 09:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1726125640;
	bh=b9U5eANp9GKWrkzxfXMblKUuLn8vJkNE9dbwlUT+x4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Du9swgIGhvI5ohoThxzN4NYeuUHubhBseZP5GgQg5GDWtcRZ2w90CNPvirtmdlsqV
	 zdh492LxMSzw12B+MYhi/WdIkLGw1L2iGLSEUC1UQ/oddBld1L6iLQPCllXeUv76ju
	 NO0VaK0NbashSkTHYwtgoROguHJpxNV4rVkaod9siWK6AlK3Huu7ehrpznM+m8Scie
	 DjhoWquaZumI+9Xx/ApjBH/vFPDpv1ujwrLrbTC6Ryhp6onRPO7uUvSDbWCnQihOFR
	 RwopL0U+2u8fCeUyF6xSBBRNOuuhGsGkGdQCJUgCoX0MOz6S/vaXRXB5XqMXAZxO+b
	 LRFw1veEJpx6g==
Date: Thu, 12 Sep 2024 09:20:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Eliav Bar-ilan <eliavb@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>, patches@lists.linux.dev,
	stable@vger.kernel.org, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH rc] iommu/amd: Fix argument order in
 amd_iommu_dev_flush_pasid_all()
Message-ID: <ZuKWRo567ZkmFjvq@8bytes.org>
References: <0-v1-fc6bc37d8208+250b-amd_pasid_flush_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-fc6bc37d8208+250b-amd_pasid_flush_jgg@nvidia.com>

On Tue, Sep 10, 2024 at 04:44:16PM -0300, Jason Gunthorpe wrote:
> From: Eliav Bar-ilan <eliavb@nvidia.com>
> 
> An incorrect argument order calling amd_iommu_dev_flush_pasid_pages()
> causes improper flushing of the IOMMU, leaving the old value of GCR3 from
> a previous process attached to the same PASID.
> 
> The function has the signature:
> 
> void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
> 				     ioasid_t pasid, u64 address, size_t size)
> 
> Correct the argument order.
> 
> Cc: stable@vger.kernel.org
> Fixes: 474bf01ed9f0 ("iommu/amd: Add support for device based TLB invalidation")
> Signed-off-by: Eliav Bar-ilan <eliavb@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

