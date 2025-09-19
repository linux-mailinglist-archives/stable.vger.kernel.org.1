Return-Path: <stable+bounces-180608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6821B883C7
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 09:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084D04673C7
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B192D131D;
	Fri, 19 Sep 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="hw3ZaB6J"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28C2D0C9D
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267632; cv=none; b=BBMoCPCpEkATfcO48K6znyNpywu4fj+K2XbnEWGRfIcit7JWR94fUXwO3N2GZ7ZBFM/pj11Uk4x9bFgZAw50goq1Pr6DuRylHb8wtLri6yhOoMhSIi128lG2xvRLFD9Bxg6eRHAuBxYMOLrInCyjok2oAPvjmvk0SWKv1cSqQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267632; c=relaxed/simple;
	bh=Ge0srBt8kuBHxlltoVn4IgBNE0Uz+odUeFDkrg808us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+r2LfUcndejswaPpC0q0Uk6Kop1YGQoPqMkUnwSTN/I1bb0B5qxICjmnt6Nyg7g40rLfxLa69wUbqwgGupEiwKV0lH3Q17HbeNp+8qzDCzT8dLbAMuUqdsCfLPAcKBZneFH0cRVmQFwrA4o/9BIKS9mPjT54Z+S0oEuPOA06+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=hw3ZaB6J; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3198A55998;
	Fri, 19 Sep 2025 09:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1758267623;
	bh=Ge0srBt8kuBHxlltoVn4IgBNE0Uz+odUeFDkrg808us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hw3ZaB6Jk+Qd1g9kjX7a7pX96ey02vnclSM4cZSi9lCjsips5EQuopLPaIG7mojAC
	 n+dfMpEpfJPovhq5QFEFOWfzxu8CAtLMn1qBOoB10VwPfZobhJY1ebVivq0pDYkfZW
	 uaiswwZ5soQhtJj+kKZBpB3uox1bve7QpEdyefanLWBqjzrJtfrgv6C/1MhnQk4wEC
	 6iMBLbPBr3mPZXj1aMSbAB0Anj/+Qvo+MU9MdOp9pNcWTHA33Uo78obxX3BNEOY+ec
	 yer/240qtVYYFTt09SH+WcU8LqIi531uoXPN8NCKbcUibKtB9v5yCSVwWNTbW53QEo
	 P8iX0QK+3IvFg==
Date: Fri, 19 Sep 2025 09:40:22 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2] iommu/amd/pgtbl: Fix possible race while increase
 page table level
Message-ID: <srhrjp5kcx6vma645asqa6r3zhxtflt2v2rxc3zwjqsbqxnp67@puw2tdybqebl>
References: <20250913062657.641437-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913062657.641437-1-vasant.hegde@amd.com>

On Sat, Sep 13, 2025 at 06:26:57AM +0000, Vasant Hegde wrote:
> Fixes: 754265bcab7 ("iommu/amd: Fix race in increase_address_space()")
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: stable@vger.kernel.org
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/io_pgtable.c      | 25 +++++++++++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)

Applied for -rc, thanks Vasant.

