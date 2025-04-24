Return-Path: <stable+bounces-136593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B5EA9AFA8
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8049A5E87
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51119B5B1;
	Thu, 24 Apr 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYPH8lEo"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED619993D;
	Thu, 24 Apr 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502512; cv=fail; b=MOJLFvS4vpKyPy9jEd+iHn3dIV2nbI+57AEXzTWF+nxR+I4GFTiAzp1QrB2kBxI/7aDADOztaUOKZaR16MnvEF21ErhSlr1Ba/dpCEgdxY4K1MuGkwGdC+oPAGQcZNGOaCElAGaJjtrqczoVDNc4PZty53G7fQtY8/S2hAIrjOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502512; c=relaxed/simple;
	bh=51l29vM9tM/+S2bY4lRmzJDIA8GeDPaEJGJxy4I7DDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ksqNbjfrZV20uuhIZLFh6ezkf1lri+llwMaNFXqCx+op1DE6YrHKi3ny23HKLaT1esRn8CSbw5T5ElxHTlmsD/nTH8QlKSPu+BfihGFYprcZTtPv7gufYFbBvcOHopvQP1Cvj5v0eiEZzqyMUTMA/kd5lse123+qCMvL2IDRyyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uYPH8lEo; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYH8SoAZw8Ce4Uig167bButOapDworqpYqBOYUMsWTamwnAqDdnxteTM+h18l9kqyqKPAl865tb1fqprkOQQ6V515TmlKAzhp6NuMzGnJm4n13IUQdp/k4keV6zJtNVy6pkKDzvoNIv02aCvNoMUfJ1k8nW2afy3GCY/e/JHvSHkFTYQP3WmLbXlNt5PsqqM0Tqe2z+mFyJPx1M6j/WifSDbgtQ8PziFnR4rlCbs4djOJr4ehmQZgm40NzgunoITTe6rZhD4bygh/+BCppCLTr/jIpXc9PF0865MDrJVP6gwJEhej/ohEbgNM2a4Ai/sDxh0Q20N1DAsdh5BuI5W0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBe2lCq4bGsKe2iIwuGmPLxO3cPus2MHbNCCNhiyciw=;
 b=r2NCC60+Ute5/1CqHY1XqrNAZyFlQ7Xq9jWBNIQ4LEiHn3ubW9Qj5whXvyzuFMNW+cw6IHvYqL8rhEsR5kuBpoXcSxNUSgZ3yJ5dXB//j4hVxJhOIP7DKrUbdbdZVmZKbqoFkqb+/3BakRDwvgEUrJvxYEHkFU39ryV/5iRR1F+479NZ5XldKg4d6qHOoCagzdBwRC+ujgWU1Ji9W0B/YRVEu6WJu8wirQHV8fK1DsA/MzdZHYmn4Z1dEj7AKKUr3T8yb2kjd0dzVV8Z7fSuy+J9b9ydWeNp7aZ5xLVHCJiKxzA/n0eabKQMkiGpxLCvcND7fR0qkMSdSF9czPIp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBe2lCq4bGsKe2iIwuGmPLxO3cPus2MHbNCCNhiyciw=;
 b=uYPH8lEoCdxiiN5mcF2svMk5FzHp18pFm62o0QkMEqz4xRdUpanVBP2XuJSoFxhj6fWKONalwqdU683Bt526VjL1dsA+Iczhgi0WtOZAsZ99vfOtdgDYe3JpQnBKOR9ZEhdFt7+/+sNRSYtNSLq4bldezrslyJm+HyxqHiJxO6EQR/mC/3hPHG2/U7Vwb1ve7yR99mjnoyRc/xL8r+I8kB6wjoK+CYUjD6ZDfA3N49BLWKxkgDx5s42Dx8WEwIfBiPjGy7+YJqy42Vk38Lr0Bfo921YGxGeBTx9Bab+Z78F7uEd26ebWTfFqtpQrgr8ub+xftQ9snVuSrqVWaXDuyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 13:48:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Thu, 24 Apr 2025
 13:48:27 +0000
Date: Thu, 24 Apr 2025 10:48:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, shangsong2@lenovo.com,
	Dave Jiang <dave.jiang@intel.com>, jack.vogel@oracle.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
Message-ID: <20250424134826.GQ1648741@nvidia.com>
References: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:408:f7::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc7cfd5-f28f-4785-c5a0-08dd8336b0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BzgUd1kVAUO3XwjYwrIwG76/IIrpBE16XOJtNIG/AEUV9xosyc+Qw9gbxsJ6?=
 =?us-ascii?Q?GAkwH9bBxo4n+XWfKVuFDVvafChZ4NUfV6ym3TJpPgGMunQvD/nV9EuJI/9c?=
 =?us-ascii?Q?0xVUvbAFo6ENtHEDkKcCwWNkhREqUrMgBsA+oma8c8/cCTiZihSZn1CkwIxt?=
 =?us-ascii?Q?o3IihAio7dZ5ZzBvRYn7xJMms7ftgX7hB9qJk2C+VnCteePN/AlwTS2VvVhZ?=
 =?us-ascii?Q?EG4rV2iEywa4zBL/zASiqQYhUArSF5RnGmCT46z+TjqJ4cRo7pGnbfzwaM+Y?=
 =?us-ascii?Q?+iGeaS1l4Hw8lrudD2NWmdy+8liBqjkgN+BDFG6EpnrJ0ZuMixA3bPBYLc/8?=
 =?us-ascii?Q?NEbVfU3c/KuJc/vMY1BYtSO+NkUkU6A0EnQSEK942zJzP8h8jagJWblNMvU+?=
 =?us-ascii?Q?iwewDNKy7ozDAV3QwaFAX/j3fjg8LtpQ0wp7Pun2oM5q+2f7hX0lcRFae1AQ?=
 =?us-ascii?Q?15NN6M6Cq8WZvX14VsuFMvZMLyIZ9zqUqxp6yK38eg0V5DccvdQORynZ+JWZ?=
 =?us-ascii?Q?6z2OnxwqVzt6K6h4E3/zBUcvIs2+69QUp2hfEWGT/IXxOOwBYOQ64jYoNC3t?=
 =?us-ascii?Q?l7EKBHg24A02GZYxgJaOaskBlqR88y9tNnolE6MxsMcmdRIy/aZDOANO9Uyq?=
 =?us-ascii?Q?0BE9ZJ/2+1lsEvtiSGnlt94VWS61ZhuM7jBf2sRyaiNUajTkzxLQZ0vS/b/K?=
 =?us-ascii?Q?l8cTz2O4cmxwjXUscmGzobawQP91Z5Fnn9V6Iv0oE2ApZ3uRPVAI4FoNrepz?=
 =?us-ascii?Q?qMCXEWu/p28ZZuYJo9xroW4OiJvGce5oALrUG+2t+jILPt8hcsQ0WYIsMqg2?=
 =?us-ascii?Q?CWM2Ifgk7dF+69KdxcQWfGR0HLY+suLaAwXCqZSfJ/4VeJ7g4BPpTvKfuc94?=
 =?us-ascii?Q?DOxqePzZaKiKePHqbAnrDvHYFVMyRVDSOyrjP/r6E8E7zZBLdvJpjksPeV2A?=
 =?us-ascii?Q?LVZhnE+gVzbapSp+qnIf6wQb+froTSrknZkprVdPM1mBiJ56+hQMEPV2VwTY?=
 =?us-ascii?Q?/mOwGzbpgNJS8vEtyOLTeCz9zZcQ1UPWxI25KmW2+YdE76yfnt2D6IwhakuU?=
 =?us-ascii?Q?FbPOzzAaHEzwdA9vN+cABPL+yyWifXa6lsTnREvyz3G54gOA6+t2G0lToqnx?=
 =?us-ascii?Q?RoVXY+9V8BMKiEySJUknauTPmAgeYMYc2nn3moxFjfIcuHTgMk19ghuS3O3X?=
 =?us-ascii?Q?sK7BTpVRb0ylLZYSIxD+dDIqrl8h8kum9ni0o7znB3RprWg57HCMHNh1gq7y?=
 =?us-ascii?Q?6bzaeF42JKWihBzM+R//Dwdj6BpFrvVAL/RZPsWQe+6Q78cBLW39Wet5S+Lt?=
 =?us-ascii?Q?sPM972sPhfScCUa1peVejdbWd60bAsEdYVUCek7Npc1PZialnH0wJZRpRpj0?=
 =?us-ascii?Q?/DSWgjZO71OfCstCM9Le8Ki/IGAB4C//yYDR/Y3BpDyymn1Ew/52eGqcHqod?=
 =?us-ascii?Q?aQOx7DbNWok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXQBNV8ClbEYWrDnfXNOezSZW25Qb2LGrleDGvYxmbafS0cKVlMzb0I0Btar?=
 =?us-ascii?Q?HhCGlzvafaZDHGjyNrJjhLo3wth19pJMzK/WSC8EQR24jvsa6gOFhpMpBCBO?=
 =?us-ascii?Q?SjCAOZe172EgVwpxPDD+dr2T62oXUxi5V8glkmG7X8YSy+VSgUigAH5yNeqR?=
 =?us-ascii?Q?H3EUdYKDicNmt/Q1yAhFS3mlYVkCIVNMs2VFISu0qnNGJAGi7cQasWjLRc3h?=
 =?us-ascii?Q?BPqmZsKEGx+qTFjMqmlWF+ty4JVbEgbM6gQvw3vSjxx6fw30S+76KBCgrCaZ?=
 =?us-ascii?Q?BMM0A6/Tdy25T4zIQmhHprYFt90LuwBhZeZhr29dU8mh30gXAG+MdPc0UWhd?=
 =?us-ascii?Q?o8jgjUQKjwhSjeYsSQuVUHFInSPghWM6VVdwoGi1FQ44bVbrw8f8Fg4M/1sS?=
 =?us-ascii?Q?y6gGlgATIepXNIYFYU4okSX34aYuuwB8vWsCgdJF0QjP0i+NHXYTQ3ZGQKdx?=
 =?us-ascii?Q?0aWA654dO5XSVCRd3wJ+Qxy0Neu3tE0hnxOcwlVYtJPjuXOO3YPTSp+QUmaa?=
 =?us-ascii?Q?YyM0L3Fv6Q6h3C1GvNoPhCejtMXXVZfPr5oBa1LSIirBr938O89fOMEW2j5D?=
 =?us-ascii?Q?hvtVLYARnSnUTPLGl749lMLI12dQYWH1o171tIbCL20RMjGbilziGiaRYLaA?=
 =?us-ascii?Q?e7D/HRioQ+vaOGT3C6RutM0PXMs9o5jc7VzAO6T9ey4n9cvgDYwhV9acGt97?=
 =?us-ascii?Q?VtNykATib/8pdYXdIjz/Xe8Ii/iCVVCulrY4+BeaX993qHROHMCE/UwgeLpV?=
 =?us-ascii?Q?mjmAyBcu9Whf5woF3THP2JQJ77P+jOb6kmjc2lqE+QvJviGND6fUvfOnGUUh?=
 =?us-ascii?Q?/WteXXpU4ObSV5SNrQOkmmYanhnqN/otvrdSGPaWWOKyrSpB7ND6yA8eLqV2?=
 =?us-ascii?Q?jYB/ZEzUIV0EHJiFA+kvPtxtCYebifoym5H6WuYA9u6dLk5M7cadbtyjS0Db?=
 =?us-ascii?Q?4HRqHRQ5bl81chRqenyAg1ERBZwXvWrdWvbmVv560240eHdD1zDuK6Z3CKZ5?=
 =?us-ascii?Q?ycPPRg87NmfEOdAyfJAB1c0NK+yljf6RA7RKXMCMyc2Oz3sRXXJzD2dqhQf6?=
 =?us-ascii?Q?n3bhqzeJC76XA+E0mKtTwuBWFiWUoaCO28D8zBsrMoJvFdG0uHn1nz62/UVF?=
 =?us-ascii?Q?XaqBVBRgJTQ5hxwZ8wYvZ5eIv5kSSN8+tt5ZLT2kZ5VcOupCTWWgYNnkKUMy?=
 =?us-ascii?Q?+Ead5/AhoQyrERjUSNTCOewtNvcfsPWrK19p4mITkfpWKpHdS4w/+/9a0U6r?=
 =?us-ascii?Q?Hjp/yd33VayjO3YQ7aonE7aV5BVee24OG58XKY2nrOSNooE3Gpsa+g3SKjbV?=
 =?us-ascii?Q?DvMqxsGKIMbBr6t7SW/ZPrqaGDIel9HxJ+atRqQk2hfXGBUMo9IOiLzEOCzf?=
 =?us-ascii?Q?Afx+J60NT5fqwHmyYwHzwVrcy3Ssssd3SbauRohzLvxt01LZMralQvDmR5zK?=
 =?us-ascii?Q?kwp7cTJM85iWbciRzRpPnxz6yEGdGroRp9dlez1R8TqV4FzY7WTVEfjcFn1O?=
 =?us-ascii?Q?xMs4FejZHUMYemGaB6kHIgokj0AyF5l8xbB6Z0sO7v5qmF7fSo4cEncihfo8?=
 =?us-ascii?Q?kWEIq77u1JrJlyn774s/JBO/G/CzMsMbAEFmGu/H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc7cfd5-f28f-4785-c5a0-08dd8336b0a0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:48:27.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc9qu3na+Ar154O4i6t8yAa7qr1D8XZBRW5ZQPMlT97yO5LKvmhO/iRSITdlMBkr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814

On Thu, Apr 24, 2025 at 11:41:23AM +0800, Lu Baolu wrote:
> The idxd driver attaches the default domain to a PASID of the device to
> perform kernel DMA using that PASID. The domain is attached to the
> device's PASID through iommu_attach_device_pasid(), which checks if the
> domain->owner matches the iommu_ops retrieved from the device. If they
> do not match, it returns a failure.
> 
>         if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>                 return -EINVAL;
> 
> The static identity domain implemented by the intel iommu driver doesn't
> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
> for the idxd driver if the device translation mode is set to passthrough.
> 
> Generally the owner field of static domains are not set because they are
> already part of iommu ops. Add a helper domain_iommu_ops_compatible()
> that checks if a domain is compatible with the device's iommu ops. This
> helper explicitly allows the static blocked and identity domains associated
> with the device's iommu_ops to be considered compatible.
> 
> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

