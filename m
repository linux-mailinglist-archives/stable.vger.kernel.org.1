Return-Path: <stable+bounces-136853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9EA9EEF5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB011887F92
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9A25EF93;
	Mon, 28 Apr 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="p9GEo2Ol"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012A25E800;
	Mon, 28 Apr 2025 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839453; cv=none; b=WkjujK/980NO/ZJnD/niOiloV4eaFlfe4FGsIyt4huVy3wxnoQpPrlMeG1zftWfD7szQxSgBpWnt3DfsUQWPJxsIg+mtedVin9SGCBMWBGJlzcmFMOCcX/+F61vpowmgVTsqUq9A7PjgpP6duJuntoJZUf35koFV+FvcmsAQecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839453; c=relaxed/simple;
	bh=3GCyjK38SquskHuPwGxdqPPOeOAIpnwiEXdmPp7Ipa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PreR2o503OuoTKhgPviCXsGqniD5ByZPYDG3c0IargmqRphatnUyj2WdvIQmOs2IdDyKHwzZefVBrdh2asars1s00sZ82Zaf7f2gpYNZ2K40FOl4iN77278jSvH4iqXjvm48IMsikCvyn0yOy9d0CvPpeKILahOOHIQgyTHac8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=p9GEo2Ol; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 490DF496F2;
	Mon, 28 Apr 2025 13:24:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745839450;
	bh=3GCyjK38SquskHuPwGxdqPPOeOAIpnwiEXdmPp7Ipa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9GEo2OlzrT1joyARmxAjX1W4U7qdr7KCtn1vhzhvgxpHpG9U28qsCZ8cAhuwNTZJ
	 8y33WYW4bXq1PVUzMH2WwOouNATzOT88JbkgzxrQLh5bCDC/W90vJ4oJoLfZgc1zKB
	 BNITdFaHfF/Vg5+A6qhQZgZkEyQtzpUrScfBYIOXGBM+z9oXARCs3GCz6K0rKz/20l
	 wNV9N0rPxQ/kL9GLB/v7M0SBfUbANUXYWH+ooREPYzgk/PL5OKkEcN2IADb8N9qTy2
	 QcZeiHTgJpyj+JucfyxuDeNcrWZRKO2qr47W/l8Rkkn+46LB6xK/vL1iHgcbWRfkUW
	 tkXd3YC2gb3Dg==
Date: Mon, 28 Apr 2025 13:24:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	shangsong2@lenovo.com, Dave Jiang <dave.jiang@intel.com>,
	jack.vogel@oracle.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
Message-ID: <aA9lWY8TwvI_4WL5@8bytes.org>
References: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424034123.2311362-1-baolu.lu@linux.intel.com>

On Thu, Apr 24, 2025 at 11:41:23AM +0800, Lu Baolu wrote:
>  drivers/iommu/iommu.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Applied, thanks.

