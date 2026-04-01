Return-Path: <stable+bounces-232822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ85I+FJzWn4bQYAu9opvQ
	(envelope-from <stable+bounces-232822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:37:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E837E01E
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA66730ABF51
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE29318EC7;
	Wed,  1 Apr 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GwWe2F6B"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC139B951
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061218; cv=none; b=LEZ8Vvg7AUuy6C4jx0XjjLFS8qELmaa+Lic5rIxfWk6OQxBNUCmXHc5V5Iwb/UJ/P/Lc1g3cTAGHgergeTbSxEvVM7b28s8W+MeRrH9cOWf4VZumOn53IGrVhfO6MNHY+WNmMhQmc0it2eZO4ysgWtztEv9mPgR8k6LF620tYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061218; c=relaxed/simple;
	bh=bbGQgXq3CFYt+VX0sV+aCx31FLqKgRb0Qy92VqwuNGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKsyAdcA0XQJPCRna7gGU/qddMW6pJFbRPHCl8Ql8U1XjUrMfC9ScUN3MqRYIRFcE/RCTKhDoj27vSjkrl0NONMGhV/gmLKqfr6ZcpuBBOIhyO1S7kSCeE12qWey83tZu0vhPaqyts8oYDoppeKtFvdDzLeId2saExuujQE155s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GwWe2F6B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66E2E1D6F;
	Wed,  1 Apr 2026 09:33:30 -0700 (PDT)
Received: from [10.57.77.192] (unknown [10.57.77.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD4483F7D8;
	Wed,  1 Apr 2026 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775061216; bh=bbGQgXq3CFYt+VX0sV+aCx31FLqKgRb0Qy92VqwuNGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GwWe2F6BfmTxsuY29owznO9HTvvEW56dJwVfyzV+5uN0GBcLYF7hpaKkCZDOcPPBz
	 TEcBqhEj+P8QyYRv1a/8cQy7DGKWuggpAfXXgXY+enYSwr4zFfe3AYZpwJmO6CKo0b
	 fnsDhTf4cmHiD1S89CGVZJpbWm2Pb2eppj60v/Lw=
Message-ID: <ee2c2044-e329-4cdd-ac35-9365824d3677@arm.com>
Date: Wed, 1 Apr 2026 17:33:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Always fill in gather when unmapping
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
 Baolin Wang <baolin.wang@linux.alibaba.com>, iommu@lists.linux.dev,
 Janne Grunau <j@jannau.net>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>, Neal Gompa <neal@gompa.dev>,
 Orson Zhai <orsonzhai@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Sven Peter <sven@kernel.org>, virtualization@lists.linux.dev,
 Chen-Yu Tsai <wens@kernel.org>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Jon Hunter <jonathanh@nvidia.com>,
 patches@lists.linux.dev, Samiullah Khawaja <skhawaja@google.com>,
 stable@vger.kernel.org, Vasant Hegde <vasant.hegde@amd.com>
References: <0-v1-664d3acaabb9+78b-iommu_gather_always_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0-v1-664d3acaabb9+78b-iommu_gather_always_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nvidia.com,ghiti.fr,collabora.com,eecs.berkeley.edu,lists.linux.dev,linux.alibaba.com,jannau.net,gmail.com,8bytes.org,kernel.org,lists.infradead.org,gompa.dev,dabbelt.com,sholland.org,mediatek.com];
	TAGGED_FROM(0.00)[bounces-232822-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4F6E837E01E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-31 8:56 pm, Jason Gunthorpe wrote:
> The fixed commit assumed that the gather would always be populated if
> an iotlb_sync was required.
> 
> arm-smmu-v3, amd, VT-d, riscv, s390, mtk all use information from the
> gather during their iotlb_sync() and this approach works for them.
> 
> However, arm-smmu, qcom_iommu, ipmmu-vmsa, sun50i, sprd, virtio,
> apple-dart all ignore the gather during their iotlb_sync(). They
> mostly issue a full flush.
> 
> Unfortunately the latter set of drivers often don't bother to add
> anything to the gather since they don't intend on using it. Since the
> core code now blocks gathers that were never filled, this caused those
> drivers to stop getting their iotlb_sync() calls and breaks them.
> 
> Since it is impossible to tell the difference between gathers that are
> empty because there is nothing to do and gathers that are empty
> because they are not used, fill in the gathers for the missing cases.
> 
> io-pgtable might have intended to allow the driver to choose between
> gather or immediate flush because it passed gather to
> ops->tlb_add_page(), however no driver does anything with it.

Apart from arm-smmu-v3...

> mtk uses io-pgtable-arm-v7s but added the range to the gather in the
> unmap callback. Move this into the io-pgtable-arm unmap itself. That
> will fix all the armv7 using drivers (arm-smmu, qcom_iommu,
> ipmmu-vmsa).

io-pgtable-arm-v7s != io-pgtable-arm. You're *breaking* MTK (and failing
to fix the other v7s user, which is MSM).

> arm-smmu uses both ARM_V7S and ARM LPAE formats. The LPAE formats
> already have the gather population because SMMUv3 requires it, so it
> becomes consistent.

Huh? arm-smmu-v3 invokes iommu_iotlb_gather_add_page() itself, because
arm-smmu-v3 uses gathers; arm-smmu does not. io-pgtable-arm has nothing
to do with it. Invoking add range before add_page will end up defeating
the iommu_iotlb_gather_is_disjoint() check and making SMMUv3
overinvalidate between disjoint ranges.

I guess now I remember why we weren't validating gathers in core code
before :(

However, if it is for the sake of a core code check, why not just make
the core code robust itself?

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35db51780954..9ca23f89a279 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2714,6 +2714,10 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
  		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
  			 iova, unmapped_page);
  
+		/* If the driver itself isn't using the gather, mark it used */
+		if (iotlb_gather->end <= iotlb_gather->start)
+			iommu_iotlb_gather_add_range(&iotlb_gather, iova, unmapped_page);
+
  		iova += unmapped_page;
  		unmapped += unmapped_page;
  	}


