Return-Path: <stable+bounces-233044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNjgFSaQzmkbogYAu9opvQ
	(envelope-from <stable+bounces-233044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:49:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF17438B745
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0402530157D3
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24B3BED22;
	Thu,  2 Apr 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDcw1prI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F492E266C;
	Thu,  2 Apr 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144959; cv=none; b=ACpzS8lWFFuqojrPdBBZBIep2l5Gwd0MvxwfPPx/aPCbAUrb09ZsmRHbk4kPG7Fc+AMK/jAhrB7wYY8181Ete1OeAuMu6enjnv/FX6aHyX76ZBzoI3HZ7sd+QFjFMp6scH0efbf60pJTQ/ucEcMMXDa5t83gZocSHrNMGQH7Ku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144959; c=relaxed/simple;
	bh=ETKq7zpXTNX+jfpHKOz+WPkBvuAndyFKqifyTs989fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzAQDvPcFm676Y4YLiwbdWLoFzFUVVk1q2ISNDnLGXOLjVUb4sENMCa1DwVt0g3YyUTiQIU/eAb4h9OyC4IFy89y02JoQy+sXJFZKd8lmjQq08KH33WDoXcF5K5/hoNRqlvNKBAD58SH0vdaMxqt4FGkfYUV5V96dQxpQdn7SA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDcw1prI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4634CC19423;
	Thu,  2 Apr 2026 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775144959;
	bh=ETKq7zpXTNX+jfpHKOz+WPkBvuAndyFKqifyTs989fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDcw1prILIQAXHJowYDTJb6Nn1rk2kMRffrcqcdVG1vKoLbLy61HSdGnHVqlkKx4q
	 ylg/MMGiQlKZe28tTkDSkOan0AGo1g+dPj/2nlK4S1pZ/d6kp0OuWyo/d0fkH2NCF6
	 xDn8/HO4hkB4cT2GGVpv80jHaaYSdWeTyjMVyo1o=
Date: Thu, 2 Apr 2026 17:49:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>, iommu@lists.linux.dev,
	Janne Grunau <j@jannau.net>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Neal Gompa <neal@gompa.dev>, Orson Zhai <orsonzhai@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel@sholland.org>, Sven Peter <sven@kernel.org>,
	virtualization@lists.linux.dev, Chen-Yu Tsai <wens@kernel.org>,
	Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Jon Hunter <jonathanh@nvidia.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v2] iommu: Always fill in gather when unmapping
Message-ID: <2026040202-uneaten-nutrient-b6e1@gregkh>
References: <0-v2-b24668f107b2+11bbe-iommu_gather_always_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-b24668f107b2+11bbe-iommu_gather_always_jgg@nvidia.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233044-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[ghiti.fr,collabora.com,eecs.berkeley.edu,lists.linux.dev,linux.alibaba.com,jannau.net,gmail.com,8bytes.org,kernel.org,lists.infradead.org,gompa.dev,dabbelt.com,sholland.org,mediatek.com,linux.intel.com,amd.com,nvidia.com,google.com,arm.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: EF17438B745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 11:25:16AM -0300, Jason Gunthorpe wrote:
> The fixed commit assumed that the gather would always be populated if an
> iotlb_sync was required.
> 
> arm-smmu-v3, amd, VT-d, riscv, s390, and mtk all use information from the
> gather during their iotlb_sync() and this approach works for them.
> 
> However, arm-smmu, qcom_iommu, ipmmu-vmsa, sun50i, sprd, virtio, and
> apple-dart all ignore the gather during their iotlb_sync(). They mostly
> issue a full flush.
> 
> Unfortunately the latter set of drivers often don't bother to add anything
> to the gather since they don't intend on using it. Since the core code now
> blocks gathers that were never filled, this caused those drivers to stop
> getting their iotlb_sync() calls and breaks them.
> 
> Since it is impossible to tell the difference between gathers that are
> empty because there is nothing to do and gathers that are empty because
> they are not used, fill in the gathers for the missing cases.
> 
> mtk uses io-pgtable-arm-v7s but added the range to the gather in the unmap
> callback. Move this into the io-pgtable-arm-v7s unmap itself. That will
> fix all the armv7 using drivers (arm-smmu, qcom_iommu, ipmmu-vmsa).
> 
> io-pgtable-arm needs to accommodate drivers like arm-smmu that don't want
> to use the gather by just adding a simple range, and drivers like SMMUv3
> that need to use gather->pgsize and also have a disjoint check. Move
> SMMUv3 to a new tlb_add_range() op which replaces calling
> iommu_iotlb_gather_add_page() in a loop with a single call to update the
> gather with the range and required pgsize.
> 
> iommu_iotlb_gather_add_page() is repurposed since nothing but SMMUv3 uses it
> now that amd, VT-d and riscv are using iommupt.
> 
> Add a trivial gather population to io-pgtable-dart.
> 
> Add trivial populations to sprd, sun50i and virtio-iommu in their unmap
> functions.
> 
> Fixes: 90c5def10bea ("iommu: Do not call drivers for empty gathers")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/r/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++-----
>  drivers/iommu/io-pgtable-arm-v7s.c          |  4 ++++
>  drivers/iommu/io-pgtable-arm.c              | 19 ++++++++++++++++---
>  drivers/iommu/io-pgtable-dart.c             |  3 +++
>  drivers/iommu/mtk_iommu.c                   |  1 -
>  drivers/iommu/sprd-iommu.c                  |  1 +
>  drivers/iommu/sun50i-iommu.c                |  1 +
>  drivers/iommu/virtio-iommu.c                |  2 ++
>  include/linux/io-pgtable.h                  |  3 +++
>  include/linux/iommu.h                       | 19 ++++++++++---------
>  10 files changed, 46 insertions(+), 18 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

