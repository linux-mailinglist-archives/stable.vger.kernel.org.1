Return-Path: <stable+bounces-194700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA2CC58737
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E495F35AD9E
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78142F6923;
	Thu, 13 Nov 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mVFHUc32"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9402EE60B;
	Thu, 13 Nov 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047361; cv=none; b=iq+rDB062roffT7YRsTyeNtOp9iLtx1RfqAYL5nl1uxFHOQNFutL63tK9c80pl5iiDDIF3gDLM8I7E4Tg7ZbtKwii8YBtjsWuCSEYcdNgJhGcV/khN3i8vMbtxvxDSyMiY2GTQUipW5yY/O4gbOJgUxQYkqu0xXBdOICGwUZHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047361; c=relaxed/simple;
	bh=GXUVT5DeTUDwirgImMsBRE1IapdOHh4ftY+jbZ509jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huIaXKRtMLUn72/ydURKruXE+/6exSosYHk1VGpLZ/MBF76mW+1SE7dycfMbO5AeZQW0jU5QBPsD02OxowiKMi1f8OlsUnPYvZersABQQ+1oNAMuiFAJdPmDPW/JtnSOYl2jOFjnqU4DEGXV5n0TBZYBXyAmARiE+ts7JMccOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mVFHUc32; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 43B9D5AE33;
	Thu, 13 Nov 2025 16:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763047357;
	bh=GXUVT5DeTUDwirgImMsBRE1IapdOHh4ftY+jbZ509jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVFHUc32qYmz2AOOYJ81HTJSqKoMAqN8tszCwc3WyrYjezNQ/u7e62qXkmiZfapHf
	 4DOUEyZu2kcl3bfXm+YoDkAYgfDd2Q1Lzv3VUqpvtKYkjymzgaZtPR5AhncsYeY4A7
	 FfW0D0R0PaloccwbK391s5/zVz9EmPGtMthi2LgyOfLK3nWxS4WuUMT4XPgbPuSevm
	 A8cNM9O6Jjfh9bNPDcTgyFdz7YQFfQEdnTIlA9zlvoWmcAZJr7IfkABSw8k+XXcIVQ
	 DKL70gSgyD71AFgp6ZK5c4fuIP/bCWrho57kl6glqSvELPP23pdfd9bhTD/FApK9Y9
	 HmQgZ2kU5Ex8A==
Date: Thu, 13 Nov 2025 16:22:34 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] iommu/amd: Fix pci_segment memleak in
 alloc_pci_segment()
Message-ID: <yzhwgps5cawvflyg2jtl4x6zlu6bnrfpjy7hbler6v5qbdgit5@s6ijyxynxhx3>
References: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
 <20251027165017.4189-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027165017.4189-1-guojinhui.liam@bytedance.com>

On Tue, Oct 28, 2025 at 12:50:17AM +0800, Jinhui Guo wrote:
> Fix a memory leak of struct amd_iommu_pci_segment in alloc_pci_segment()
> when system memory (or contiguous memory) is insufficient.
> 
> Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
> Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table")
> Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>

Applied, thanks.

