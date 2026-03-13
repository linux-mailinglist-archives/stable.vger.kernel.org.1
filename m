Return-Path: <stable+bounces-225251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q7p/Eouks2lnZQAAu9opvQ
	(envelope-from <stable+bounces-225251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:45:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0427D7B1
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C84B53075948
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B4B1B85F8;
	Fri, 13 Mar 2026 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIdnqygs"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800511862A
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380743; cv=fail; b=gdnK1BbbUeJR5HB/psM3O9b38dwTpe4YCS/iM6jn7tphQ2OuejgipZyS85lHG8S3j7rAMnxqeqE7AzjPk/PCoph3JG3WPMvs9h/yogcXmEpPOoa/0Ih1v8+xKahg0zzGNhqGPvvNTwTbY9e+FLfi3z5IUraC5d4sc0oVAdQnWw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380743; c=relaxed/simple;
	bh=b7+WMzhCpXl5vYOXb5k3B1AWv6AefSxt64L2ebu1/00=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9VSval5T5gryQ+a/StVVGW5Hd0uRjz3ltbw2ZXI68cRHYhQEFoQO3Mcvhwciw6vc0DRiETlC71no3hg7y4dcAPwUzQ15u9uu9urbIC+7BLwu0I721nxIjTcfpGMXgcBDeX3yWYwAClIgVUoE/0SpME4YlzAiAG+2xwfzXEAb7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DIdnqygs; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3KfVQKHJRE1VcSu4udu8F6pdALhUP2KzKm8skiEAHFFPwitABUZW4PvExLAAT2+BQHoA/WMsYsBQuKb2DWggSaMkjbfCOTD+iwFR6214TRrei5Iwcva8WgyJjW/lmF3cwnZKnMSeEH0c6shmaomnzuQf3J2eUyHVzUCLu9kZEy/om0Tic3VENWnErK/4qRwg2QyLlh5zkMPGyt/RGhi4TUqX0MZ7VtKXr0OMfTjC3MqKOUshx9DmwvcQc6W6pmjOmGdcUyMIzXLV6FJ/EyNRM6raLTje9WKHgH7/MVouT9ZwnbpaX/Eg7ZHZCxbOYRUuapUkOuODmHB1oOeM4VHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2424RGLchfLzIjw7mh3X+1ewitTKb2KyWadPZZpX9rU=;
 b=Qt6BqBtiD1b9S0Ulu/b0LXMejIlmUW4wvWGQuH2iUZqDY9XypbOsigyKPSEtfSQ5jJyFwdH5VSsLZM+LN5L5r8S9Jm8lWyyW+he65SxQjAojx8UFy0ytXzlVSrTbUjkWYnQwdjV+w/Tw6Bdn9quH6bnKrzEKXlEIBNGRlxDkAJtNrcYPGq9heW506+qHzFMKktD1lkLnfxDp5aoFnEe9O9f2gmywZS+0L27RbQtldsvkqBQ54e7bjva0sTuuQeUw9dNdUilOV5neHNtaTCGRhjjyVHL3c1665oOiAitK8xsCCPPRU25WxjsXTX68qWI057JNwWWbD4zzzeKP4YosbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2424RGLchfLzIjw7mh3X+1ewitTKb2KyWadPZZpX9rU=;
 b=DIdnqygsCV9/WLUTlgB4HX0sQWWCiKQGOWAmEdnQXjVR2OD7yHG9FLkbK4Lzn8/2rau8IKQfOsCiW9ChMDBTUb16sPkF1i2dn+4T1x9H7/FZvPDXHZ2H/3u0VwIfjIctsxGxbjGBSTk1XrbsY1NO1SEv/t1akmwHfrElh8mxbUQjKxy0PAyFFwYIglLashBm1kBW3DaRudIWV8x/BgpLoO0XGTMEaXFdi3KEKcme0EZ7thq+gV0rM6soexDzFhjYjPD8t5+MDQCGmfSpcLkKQMerSYVz8Tu4mSsfnlsWf5cGHTn1KkXK2KJMmLGj2qDAZZ/qB/U1bE6/9uxcEYpydA==
Received: from DS7PR05CA0018.namprd05.prod.outlook.com (2603:10b6:5:3b9::23)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 05:45:38 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ff) by DS7PR05CA0018.outlook.office365.com
 (2603:10b6:5:3b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 13 Mar 2026 05:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 05:45:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 22:45:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 12 Mar 2026 22:45:30 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 22:45:29 -0700
Date: Thu, 12 Mar 2026 22:45:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: <iommu@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<joerg.roedel@amd.com>, <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <maddy@linux.ibm.com>, <sbhat@linux.ibm.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] powerpc/iommu: fix lockdep warning during PCI enumeration
Message-ID: <abOkeDSC20afDkoQ@Asurada-Nvidia>
References: <20260310082129.3630996-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310082129.3630996-1-nilay@linux.ibm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f4aa2f-c61a-4db9-c841-08de80c3c117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T47xcPM7HX3W+PymGoRJbPhXuZ4AJMTSVgmXZbrWhAT35UMDi13KGntmeT74N6jVP0PC7gQUDySQ5VGouXVw34fCjQOYf4NVcoa3Z36PPk2jyOWqTD4Xm2DLRNTaxhGMcY3zhn2H92yDjLDvdJXp498yEKbbFE10AtCC+7+Z1Lx/Ysw5SoMXp/hbKwDsnmhlxNpbxpB0ZB44dytIFNDpfkQ98XdlQICxnazU1Wsss3LweflHKNNVhRGZqF88Ej/J5zE+KEYvzjBHOgsDTE2aiRcG2V8aySxUdaC6xSR9/vjOWgKkaRFuXtKJNs1O7TIWzeCoy6Z6oR2HwiTdg+NYBWd6PJprSzdUqq8uxvJrGpEP2JuvIw/85mWMBekGyLFZfkFUxwLpFhSUO5iSMVa1CZrv1MuEebxj6+LG2mG2ecWaf2xgH10U7uZFcmNREceGLQCj0haqH5NR8Mo8E8RYKIkkV4VvFN3CWx1o2KZ4O85B7UY4wXmt55rxY/RT7l7uvJMWewEZgRv54qRdh9xaQL9qchdFGBhGquhYz1yTbEa+4wveReOz7vLt7Q9qd7P8NIscP18kiql14hvbc4nbeXP/x+RzV/HRvxwj5z9KrIAMjGGemIIrzkYJoBIaloGoILetDUuEIwHhPooZdPKhPKxOT+QU/mgCZ0mobohpF+iQUu7fgq0qEKQlzzQkP6KjcRrdDw4ja1IkxaxijRAgeK5YU16JDmBw26znurG+oAxYOAiXhfj6e0f3qW5WXZtAapDW4Nb9WxrxCuq7kYTlhg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	74DKkHtsLINejtmkkoxM7rVOiUGF2Arpfgqq2zRr68Shmhzb8lx3lnivnREsZtCUsdxrTAdIU+QSPQwFSpsT0+10WTKSbGfu0G6eaOjh13MEvRqPgqih2UKDQz+iziV4cJvNhQb5kJXQM3m6vhHIDLAXtxEQ/DMuWPHdbsr5f/wDr5dCSor9m3hMxbj4ghZ5vk577Fh34Rkn+PUnG3g/JEtQwHfsgUl+KFS1RiuG4Aalx84Sv0yueHbn05LEnWro5wWxmOgcPmOJUz7LrRQaPAubX6bhAc7PqErsqXnfu0QiO/jTXIfbGaJZpVjn0/c2jd64M1H5IJBs3aasU82wTgLK8EGil2mEdkChJkRbiho+G8bNxTEgdbUqAg9CYy17nyCG8xXbSlgtOjLydWvcdiSoCKr41sbdRsNwUhF3wXTEIh9iNkIw31THx86tlpNK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:45:37.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f4aa2f-c61a-4db9-c841-08de80c3c117
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225251-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9AA0427D7B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 01:51:24PM +0530, Nilay Shroff wrote:
> Commit a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev()
> helper") introduced iommu_driver_get_domain_for_dev() for driver
> code paths that hold iommu_group->mutex while attaching a device
> to an IOMMU domain.
> 
> The same commit also added a lockdep assertion in
> iommu_get_domain_for_dev() to ensure that callers do not hold
> iommu_group->mutex when invoking it.
> 
> On powerpc platforms, when PCI device ownership is switched from
> BLOCKED to the PLATFORM domain, the attach callback
> spapr_tce_platform_iommu_attach_dev() still calls
> iommu_get_domain_for_dev(). This happens while iommu_group->mutex
> is held during domain switching, which triggers the lockdep warning
> below during PCI enumeration:
> 
> WARNING: drivers/iommu/iommu.c:2252 at iommu_get_domain_for_dev+0x38/0x80, CPU#2: swapper/0/1
> Modules linked in:
> CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc2+ #35 PREEMPT
> Hardware name: IBM,9105-22A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (RB1120_115) hv:phyp pSeries
> NIP:  c000000000c244c4 LR: c00000000005b5a4 CTR: c00000000005b578
> REGS: c00000000a7bf280 TRAP: 0700   Not tainted  (7.0.0-rc2+)
> MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 22004422  XER: 0000000a
> CFAR: c000000000c24508 IRQMASK: 0
> GPR00: c00000000005b5a4 c00000000a7bf520 c000000001dc8100 0000000000000001
> GPR04: c00000000f972f10 0000000000000000 0000000000000000 0000000000000001
> GPR08: 0000001ffbc60000 0000000000000001 0000000000000000 0000000000000000
> GPR12: c00000000005b578 c000001fffffe480 c000000000011618 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: ffffffffffffefff 0000000000000000 c000000002d30eb0 0000000000000001
> GPR24: c0000000017881f8 0000000000000000 0000000000000001 c00000000f972e00
> GPR28: c00000000bbba0d0 0000000000000000 c00000000bbba0d0 c00000000f972e00
> NIP [c000000000c244c4] iommu_get_domain_for_dev+0x38/0x80
> LR [c00000000005b5a4] spapr_tce_platform_iommu_attach_dev+0x2c/0x98
> Call Trace:
>  iommu_get_domain_for_dev+0x68/0x80 (unreliable)
>  spapr_tce_platform_iommu_attach_dev+0x2c/0x98
>  __iommu_attach_device+0x44/0x220
>  __iommu_device_set_domain+0xf4/0x194
>  __iommu_group_set_domain_internal+0xec/0x228
>  iommu_setup_default_domain+0x5f4/0x6a4
>  __iommu_probe_device+0x674/0x724
>  iommu_probe_device+0x50/0xb4
>  iommu_add_device+0x48/0x198
>  pci_dma_dev_setup_pSeriesLP+0x198/0x4f0
>  pcibios_bus_add_device+0x80/0x464
>  pci_bus_add_device+0x40/0x100
>  pci_bus_add_devices+0x54/0xb0
>  pcibios_init+0xd8/0x140
>  do_one_initcall+0x8c/0x598
>  kernel_init_freeable+0x3ec/0x850
>  kernel_init+0x34/0x270
>  ret_from_kernel_user_thread+0x14/0x1c
> 
> Fix this by using iommu_driver_get_domain_for_dev() instead of
> iommu_get_domain_for_dev() in spapr_tce_platform_iommu_attach_dev(),
> which is the appropriate helper for callers holding the group mutex.
> 
> Cc: stable@vger.kernel.org
> Fixes: a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev() helper")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

