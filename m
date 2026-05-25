Return-Path: <stable+bounces-254089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJKEOxDoE2pdHQcAu9opvQ
	(envelope-from <stable+bounces-254089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:11:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150B5C6379
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44FA53007978
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB10E34214A;
	Mon, 25 May 2026 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WAZDqWfn"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83B13D53C
	for <stable@vger.kernel.org>; Mon, 25 May 2026 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689484; cv=none; b=eQoxG3p06lneEjt/4aLRFoLC7B8YoUCp1fT/Mt2eHrTW9buuT3mWPjxh70V375z/E56KpjlAENkdraVPwPt+9/76ir4dCM9h1UNFcKBnstwcyzELImevxN3vcSeNscakDqKYWX4YAPOJjjlaHPg1B305vu88AzjYTD1AHnttgv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689484; c=relaxed/simple;
	bh=IWVJO3oBQPbyibautNWEnx7xsDaZHZRBx4CT5BJnbyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p3/H3CWAZNUPkcBEvjVgOYgt6CxCsQazYgJ9XmNRSaLcMgfjHuedWKK63xiDTDmYHHPPghk2NtaCsJBnNm4NiETXp06ezJYX4Tc7z0KuHkxTQjxLqJ7cfeMHZidVGq7bISGGVcn1/AVUGnE9+KUNyyohqvJ/wQ7X+0ZOchQ+/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WAZDqWfn; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qfxTNK1Utv4HvvGu4K2EZ3mPuUHSqDqac6SGTBgM8NM=;
	b=WAZDqWfnX3Xz5lA2sK7TDhu447LJRGW2iMRXtcxfnG67RFKdyy3Bo8zZfFhXaFTNZdL2/j7W+
	l6/5r8+nft2ybSMpevkCqcWvKETPvB+CPS97V9RgPKT8u+oOifoxubSQSK5kQkKk36d0qcab3GZ
	jx7z5wXmHKxpZVXV071DlSA=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gP50g1kJlzKm4m;
	Mon, 25 May 2026 14:03:31 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A33DA40574;
	Mon, 25 May 2026 14:11:17 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 14:11:16 +0800
Message-ID: <c608c5b4-5d5c-43bc-b56b-9fc1857d2167@huawei.com>
Date: Mon, 25 May 2026 14:11:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH OLK-6.6 4/4] iommu/arm-smmu-v3: Fix pgsize_bit for sva
 domains
To: <patchwork@huawei.com>
CC: <linhongye@h-partners.com>, Balbir Singh <balbirs@nvidia.com>,
	<stable@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@ziepe.ca>
References: <20260525014651.3531030-1-xiaqinxin@huawei.com>
 <20260525014651.3531030-5-xiaqinxin@huawei.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20260525014651.3531030-5-xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254089-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaqinxin@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6150B5C6379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Sorry for the noise – I forgot to use --suppress-cc=all when sending
the patch. Please ignore the previous email. Thanks.

On 2026/5/25 09:46:51, Qinxin Xia <xiaqinxin@huawei.com> wrote:
> From: Balbir Singh <balbirs@nvidia.com>
> 
> mainline inclusion
> from mainline-v6.15-rc5
> commit 12f78021973ae422564b234136c702a305932d73
> category: bugfix
> bugzilla: https://atomgit.com/openeuler/kernel/issues/9215
> CVE: NA
> 
> Reference: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12f78021973ae422564b234136c702a305932d73
> 
> ----------------------------------------------------------------------
> 
> UBSan caught a bug with IOMMU SVA domains, where the reported exponent
> value in __arm_smmu_tlb_inv_range() was >= 64.
> __arm_smmu_tlb_inv_range() uses the domain's pgsize_bitmap to compute
> the number of pages to invalidate and the invalidation range. Currently
> arm_smmu_sva_domain_alloc() does not setup the iommu domain's
> pgsize_bitmap. This leads to __ffs() on the value returning 64 and that
> leads to undefined behaviour w.r.t. shift operations
> 
> Fix this by initializing the iommu_domain's pgsize_bitmap to PAGE_SIZE.
> Effectively the code needs to use the smallest page size for
> invalidation
> 
> Cc: stable@vger.kernel.org
> Fixes: eb6c97647be2 ("iommu/arm-smmu-v3: Avoid constructing invalid range commands")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20250412002354.3071449-1-balbirs@nvidia.com
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> Signed-off-by: Hongye Lin <linhongye@h-partners.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 9342fac71801..4075ef00c4c9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -402,6 +402,12 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>   		return ERR_CAST(smmu_domain);
>   	smmu_domain->domain.type = IOMMU_DOMAIN_SVA;
>   	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
> +
> +	/*
> +	 * Choose page_size as the leaf page size for invalidation when
> +	 * ARM_SMMU_FEAT_RANGE_INV is present
> +	 */
> +	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
>   	smmu_domain->smmu = smmu;
>   
>   	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,

-- 
Thanks,
Qinxin


