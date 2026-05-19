Return-Path: <stable+bounces-249658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIaLIR6oDGodkgUAu9opvQ
	(envelope-from <stable+bounces-249658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:12:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB96058378E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C48303034B21
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235BB33A9CB;
	Tue, 19 May 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="teydhau/"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1C33B961;
	Tue, 19 May 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214304; cv=fail; b=HWzoJxniiX0s83M5h6rsuR74JzmU4pyRg/Uqto4LezOJMhvTCGNFBtuoMRgwTcBjDTZmnDpJR4AAFt46Kw6WISVNgRjIJyQfIaGxI1UWaRy0UY6xfGDf2wirT6GYA9UlWnpqXnXPlPThh5ymAM6F0g0cSBuQTeo67ECf4BNv7hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214304; c=relaxed/simple;
	bh=5+DJTNxsYMyxKOZR4VGtAwBbcaN5M/8RLlIPCqQb7Tc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHGIo+I5Uvgpb63ZQAlMUdSuGNPiPX0Svixp+s/GTzZx2WeRpj1sGqWO6EoSc/j4WhlSICt4EcFGuywyIeW7Zkv2PEwKwkilUF+WmPHiQY2gZ95W68Uhhc6opCKnGH85plD5lN1911goHVh80vz4gsWv+3IZJvXGdbCe8VUMvKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=teydhau/; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgOGL+PKpaot+U9C4ENovXlUzOBCGalYKyUhnjHlzhFiXJ4gvrugykZQOMsoB2qRWRN2U2DLuDULdos9lATD+FhLiXXznPpbApEIJyWpqGgp+zwchSHw+RS6y2gTF9tCk9SA28vxR5xsb/zJ3jQme86H1y/HODAmagJKNejhuAW7xKcLtGbjCqPnSemkHE+mrJYSlhdsnaq2rXrJb5AgcQ/KlSl+LmuOOiDBaxJ7tRATTnVnnp69oem5zD2nZmzo0KkoHfNGyCaOi+SnWnR/n21QLSRcSxews/dli1x/LsFC5aPkmJo6lwYvg7/hJ4M9i5svmwcC/jlBq+QXYy7Wyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgRBkCmrVFIcU+m1ZUQvi0yOiHueQY9rHeengMjGAzc=;
 b=KcXV/IJJ9lhyj1Ruq3o47jdIOVUjjl/8CZLa0NUBwkOvBGq3QOHSQAsZbqPE5A6HC3MHamwMqbGgMi8rzZcC1Y/g/r7OXdRyWxk4vHjgA2DLhl0NWbOK4QGiwF6bGH4J+8U9vpHOlwsvXrADr7jp4T8sZSgUmOay8DP6jtDxd/YoSKmTRIXMgSmhMC3/1R08Bky+D2cK9DqSQaHyi+7O2KSCtgI/pxpqouB7L+Kgl4aesbwU9ykWLhd4OfvAX9C2ZNRbddcghCB2R3QANnixx8zztnv3BymTlSB4BiCFXPPc7md0ETBAFhPTLxuKJhkAzfpJV/1LghwitdADNEU2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgRBkCmrVFIcU+m1ZUQvi0yOiHueQY9rHeengMjGAzc=;
 b=teydhau/Uibmzk/z8q6BrUvBaD5xyTSg8pAek0X3fUHeKVoBL+aLWAhLpjigiZ1O96Te6bSgm0pIe0swdhOrpCIE4GIe4YCEI4AEO7IyvFYInl6QvEVE3bTHwJnauIlPay8Fw1/MBJQO7i3Xy22JnSA58D47gYSpgwgoDcZweKm7q4OmBi6RFJIj2/oRViJT0rZTZkecYyec5vtW0LOyMdRZclcBPKKZGbIjzUtlCZr4IrBAt08Y4SbVpwui2ToxafsJpE/z6EEEs4OoujS7F3DbjvdS/1TYSuX7PDRQ9XoQlUaq8GNKA0P8MY13ikQO+A/OzzXtAIj8jh9nGUg1Fw==
Received: from BLAPR03CA0176.namprd03.prod.outlook.com (2603:10b6:208:32f::26)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 18:11:31 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::65) by BLAPR03CA0176.outlook.office365.com
 (2603:10b6:208:32f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:11:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 11:11:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 11:11:11 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 19 May 2026 11:11:10 -0700
Date: Tue, 19 May 2026 11:11:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH v5 1/6] iommu/arm-smmu-v3: Add
 arm_smmu_kdump_adopt_strtab() for kdump
Message-ID: <agynvTrzP3FGtQEi@Asurada-Nvidia>
References: <cover.1778416609.git.nicolinc@nvidia.com>
 <0582326eeadd4ae2b16fd4914e9bd46da5a251d3.1778416609.git.nicolinc@nvidia.com>
 <20260519171003.GD3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519171003.GD3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: fac5f49c-0624-4548-51ba-08deb5d20bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	/ZXA4OS3Uy2k50DrO4VwNyabwROzYeQ6OKmkj6fqef1h3/aPs/az2GPwyPAxMfwPvLoCRIK/8vgrrZQ+lIyZ74eqJQ3aGbkKwRxx4Pj8bXPTk6kYiq7r5wFzzTtSEOu//3tMsV/viSY6ZrW2QfRHScwFhBuJ1HqNy1zH2wGx7jAIy1UYxyKdm4ssck2/P3ODqR+pwN96lT4BwBA09oSd7E/MkbPV70qHrAiexyWZeeqIOlAIEU7jN+1QyPjQhN06vwtYO0PdT32OxWUTF4AoxgMGWyl7bvzzt+wty40+9H7BtRLdVH1UzNqOpRE9QQpDW6fobrdaVKK2pSKtGXmpAchXKznOu9O5lXRSjhDQGROnQZPiG124e43Z/xNErEay+zSFKHyNoNN7But2ObIAs71kZYzAz6tV6YTnBkTqNWpepXO/8LFRRw5ObYTrJTPE+3F5IvrSA6N+E3HbQaRhCgBye8+xBtxOFELIxF2iV7o6zV9xQHqU756ofjFF932JmmcIGjuMLK3e4lEIGSUA2c+mJOHdV/wgpYY3c2eCImGiqc+aWm6ZVvarF6j3cVy/TxUjifShT+pCEoIVFXWNv3IRIl7iGUGWJxhgpctS+WyL0j7yEY9wwilpccGCFjb22kql61F05R9IwmwX9KgNaW9Ym740QQBlgC1VtoU0oANLe1zoFaSH+6QhVCIFLz2iTHt6HSLCFkkHU7qApVbczme8pjuJpQ4sCalaGMxaK58=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wry8nhhLmVoy/p9IFMMi7asHaX1ZgZNVhAC5VpB5ZjPWbQbFCFe5yX+cVp1WWEe0hHuqS9v9UCB1Ab5zp4QuD0QyDvywg/CThbghOp8D2gJwN5OYWtmSEDvV2/soAkrUqswoQatXuivXPsNTHKy7fEYVFVzhCSqdm2QGcCCvXoeazfcRqsftqsXFe2ZH7m7JLqDzlbXrw/aJFRKdZfBzWUDMeRoz8XB+Gzck7OLYotj6RjwpMStZE4k9D98TV+kYTxZ33IgCysy6Px6uxjRVVRlNoI/v1/nAGJytLBzxZscsLLntn8+IDxc7qjZnsbTZ8+7XJGXTRYqZAene620rjQLd5ZFWn+Mq0SXiTQkzx9mDqUPcLIZi1xNFP+aspRn76lYlXP/ElHUGvwiGfIC4AbmS5Sgt4K1e0pUMsJBHnOb67zJkEqkpAmHbHQsGenQj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:11:27.6898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac5f49c-0624-4548-51ba-08deb5d20bcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249658-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DB96058378E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 02:10:03PM -0300, Jason Gunthorpe wrote:
> On Sun, May 10, 2026 at 02:23:00PM -0700, Nicolin Chen wrote:
> 
> > +#include <linux/dma-direct.h>
> 
> Nope, never do this, it is an internal header.

Hmm, I have included it for a wrong reason, yet it does mention
"IOMMU drivers".

/*
 * Internals of the DMA direct mapping implementation.  Only for use by the
 * DMA mapping code and IOMMU drivers.
 */

> > +/*
> > + * Adopting the crashed kernel's stream table has risks: the physical addresses
> > + * read from ARM_SMMU_STRTAB_BASE / L1 descriptors may be corrupted. Reject any
> > + * range that overlaps the kdump kernel's critical regions.
> > + */
> > +static bool arm_smmu_kdump_phys_is_corrupted(phys_addr_t base, size_t size)
[..]
> Something like this should not be in the smmu driver, this is some
> core kdump code. I'd drop it, I don't see other drivers doing this?

OK.

> > +static int arm_smmu_kdump_adopt_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
> > +					  u32 l1_idx, u64 l2_dma, u32 span,
> > +					  struct arm_smmu_strtab_l2 **l2table)
> > +{
> > +	phys_addr_t base = dma_to_phys(smmu->dev, l2_dma);
> 
> The thing stored in the L2PTR is a *phys*, the HW doesn't support any
> kind of translation. When using dma_alloc_coherent we never get a phys
> so it uses the dma_addr_t and assumes it is == phys.
> 
> But on this flow this is *phys* and should remain phys. Never touch
> dma_addr_t.

Fixing that and other places too.
 
> > +static void arm_smmu_kdump_adopt_cleanup(struct arm_smmu_device *smmu, u32 fmt)
> > +{
> > +	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> > +
> > +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> > +		if (cfg->l2.l2ptrs)
> > +			devm_kfree(smmu->dev, cfg->l2.l2ptrs);
> > +		if (!IS_ERR_OR_NULL(cfg->l2.l1tab))
> > +			devm_memunmap(smmu->dev, cfg->l2.l1tab);
> > +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> > +		if (!IS_ERR_OR_NULL(cfg->linear.table))
> > +			devm_memunmap(smmu->dev, cfg->linear.table);
> > +	}
> > +}
> 
> If we have a cleanup function why is it using devm? Call the cleanup
> function during remove too?

Dropping "devm_"s.

Thanks
Nicolin

