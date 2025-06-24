Return-Path: <stable+bounces-158321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F8CAE5B73
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 06:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6D51BC153D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 04:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43A223DD6;
	Tue, 24 Jun 2025 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XoJMr/DB"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5F192584;
	Tue, 24 Jun 2025 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738431; cv=fail; b=mPBgPYrGuCJTofsQp6nxWLFZcWQ8BQxo6oEgzIKrEKaKjS6+ACAGGHRBxv7sxgtD79YP+11MnM1ARZh3mNbSWx4Y0bARqZdoSebZpmFZZHKgFvoFB70XRSwuP05oaD7GZmGODBfnrwZI/Nasfv9jgLMmiFDO36j/CcgEY/RMB7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738431; c=relaxed/simple;
	bh=6uPLVqoVwz4CNcgK1YZLTTHPvcZx9JSF00oTmBHeQOg=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NAx7CTcFd9zXvn8LlHJWPOfbjYHnwT4q7faG1s1L+K8AgG3gVrFlC71TxoSyGc4VA80b4A+Pq5qlC9aYa7JduysQ92WjOxRhgJ4WcjYn4VRpzVF5JCarNkYltH0s6rC4FXGidLdZ7UGr8sZEsRrXpFXCrmFVBrLwVgfxuXsCFjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XoJMr/DB; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzZvsxsQe0MdxNlyhICvFn2e7/+gYOLAE9Sm1O9w5uzDB7ABgt1HT1CdqKdRu78CHglW0VzmLZJee4G9BbY332d678oS0k6KA4iqfRMhqb76/05kkLDj4zYJLGVvlUjseTsHS49B5z1vV70b0DG7W1SHrzKDYc9K1yteloezj4cRmMxRHJLtPRs1KIKrY4/bWbh3OcyJ5Ce7kRC+XM9IIWwoD7vyJ8VSRtoLdQQekXQ1/3Pgc7huxR0N4SA4Ye+V1V2MLwXKn9X3wO9wuVNpKq+8cfjFQ7UndwYKtWMz3m6k0rAiqx3ytr824ekoE4++axPIwhZs+rKk3r6NYx3QfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ03aJlz9iLTtiqCz5U/t8109GWxD+Mwx0sK6lanJRQ=;
 b=gvrooNOToT2QMNIILb6Ys8Sn94heuU8CbPjqiDXWWwaCldkF4omXhWWfVyWHaIJaKx+WmI6US28mF5D0LepELZgfSRafHWskzd4UCjBNvYfCPD3pIOGf3ryWh7B6MfpRvd/KLk5b5eOJo/rtZOhz4Uz/ojFKKfHEzeBTbwsPXpey7pu78ypI4Mcss44HjhAAj0+ja5OBNTm7ZN3Y4fz7gEZNefjRiogNQiiTox/znHfHxqp7oo7H2DvPr+4qWdErERWUgWVJHPiG9phGLfRbnsgzW5FVkxbXid3j4Lc3bU+SgX2I7RyoM0CL5We9nPxWKvgAqgGoiumF67A69AO/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ03aJlz9iLTtiqCz5U/t8109GWxD+Mwx0sK6lanJRQ=;
 b=XoJMr/DBMg7NsvzKFWOZVR/MOLlIae8OD30OTLT0GBVNFTmyDnRrqcQBve+kyaR5aqAz7KgUfWMgEiRCHZmfa0kHHyQBuUbOphQ++t0/lKf4cszFxuW19ZyUCWFyvVcJGuCRC95oJ+J7NCvmfklStOf/qggNTABv3cGScl34b3A=
Received: from MW4PR03CA0355.namprd03.prod.outlook.com (2603:10b6:303:dc::30)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.20; Tue, 24 Jun 2025 04:13:47 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::68) by MW4PR03CA0355.outlook.office365.com
 (2603:10b6:303:dc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 04:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 04:13:46 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 23:13:42 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<thomas.lendacky@amd.com>, <aik@amd.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
In-Reply-To: <20250609080841.1394941-1-nikunj@amd.com>
References: <20250609080841.1394941-1-nikunj@amd.com>
Date: Tue, 24 Jun 2025 04:13:39 +0000
Message-ID: <858qlhhj4c.fsf@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: eec626f0-1cdb-4012-aabd-08ddb2d583c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06XGizGslDpKnU76Lbapz8b/JPrHsrJgBY9InxnK6WIcRW/qc6qCV++MbSCC?=
 =?us-ascii?Q?9RsduGBhq/f0KCwT2TGg/9BF635FHwkeCUmCTXfkUGRV6wQCoj3q63Sajkum?=
 =?us-ascii?Q?QPjs8xpDla6AJ2fbNWbmt5K3oHhDfU2910LcbrC13s7HJnDZA8VaRkJPqoXp?=
 =?us-ascii?Q?Qx2QddaC5bGTHa0tpwt83pbS8oUQBni0fFevyBLgNZxmxsDC7LdTCHY7o/Nh?=
 =?us-ascii?Q?SL86am/fX47x76Dgl7TbLQ/3MrQ894thrWBYB1VtYYyG9pjAnYzBo20F/mj0?=
 =?us-ascii?Q?D4eR2yyEYtBBUIdkRadnLsoud8f/KIdbnmb14Ev8WkioeqRIbocyhtAKC4AI?=
 =?us-ascii?Q?Tzhn5dd8F2DDC2IgfAkBDN/W36OdrGgBvSKdp5YeR9TXxxhcHUOQlIIv8AFf?=
 =?us-ascii?Q?VlXefbUmSdFsDHE7KD0iX24DSXd9S451Psi7xCwluNcp3LjX+2kiWkV544RP?=
 =?us-ascii?Q?zBPicDdce/L64N1+HKHkNh3B0EQBWYwI+Hycwe8wzhQGO9MyKs5Nifu5M2RD?=
 =?us-ascii?Q?XQvU3FoVh5sAIGdUwZl3f28qsRX3cwuAegpXbqoZJ/s3VtnSnJxZXhQdsurZ?=
 =?us-ascii?Q?kU0fgfsbJm3Ve/SSI1iv7khyMyLFA+6GhKhs4iTIKzlU2tVbNyW5QrIZb4l8?=
 =?us-ascii?Q?LITOMTDOUuVM0Yu8cgws2Q2EUip8dlUmHkISHM3R2Wk7mi2Os7JUC7zXH09t?=
 =?us-ascii?Q?pZHaMNsrvUQPAE9EXWsGZgZaWTSA+H0AIg/fWiuKPig4FING1X/JpeR7FGd/?=
 =?us-ascii?Q?ixnzB0lb2McQ9eEHFBDiq9F5ZxxOP2edCzBKb3tM5lAhTX+Lf4cmdpS2Z4lC?=
 =?us-ascii?Q?qnLBn3qyaAnifcTEaKVt3YDvS+KVfv4WzTVwr5fSXWNd06C/s0sEbz/YqAKu?=
 =?us-ascii?Q?rv6BfMit+HyBTEciyEfjUvIAviiJ6yzcvT1UwceRNxxtsQNIojXhMIkiO/vf?=
 =?us-ascii?Q?2q9IbAMfYFE3+IPvg+PcrtVGRbV+1OhmPV4gg0TX78qoMInkKaSyZM0/Sz2g?=
 =?us-ascii?Q?bM4HHG4U+ioiYoVu6EvXJ+KMoScGyS5wY2pBBPev3Y6UCvfAHqyw36ueVm22?=
 =?us-ascii?Q?oEwQ+GPFRxdjoZQXrei4d5YGptvyHtFL0M/CxuyADgVdqVQqzJPcVnSikbMZ?=
 =?us-ascii?Q?6K/b2fSKkXLBYCgfm1Q9FMSQl2d9Pxwgqg0XQNwLqu4pfDFNp9TLsz5pWqU/?=
 =?us-ascii?Q?1gBN7z7+d8M6dfd5H2AhOn0n8qTK0M0xdhUrPsMzSJCxAf18WDkQtqjzNXvg?=
 =?us-ascii?Q?wow+F/BwytofFDQDZzrJwj37eMUxhK9lzBNCQmEhcwVcFPrvlqZEPTj9UEND?=
 =?us-ascii?Q?FAe4C8Cv0pb9+yFEN/LgePevfsaBp/gQ0/YiS2ImxxxOiM8azx8drOSkA7hC?=
 =?us-ascii?Q?fLwiPe7DnTwc+56mnp4zFqbktPTceIcV/1JK6bYdLiVRNWWivgfDceyHaGN6?=
 =?us-ascii?Q?qvUm73spX6pgBp6FfVoAOEBtIRRW5SrdKHKeoHQgLbkrMFNKjxe0x2vDJJNI?=
 =?us-ascii?Q?o5pwxZz3DsdV8ttUWEUnXpZL9GtBf3w8dHY8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 04:13:46.3556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec626f0-1cdb-4012-aabd-08ddb2d583c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

Nikunj A Dadhania <nikunj@amd.com> writes:

> When using Secure TSC, the GUEST_TSC_FREQ MSR reports a frequency based on
> the nominal P0 frequency, which deviates slightly (typically ~0.2%) from
> the actual mean TSC frequency due to clocking parameters. Over extended VM
> uptime, this discrepancy accumulates, causing clock skew between the
> hypervisor and SEV-SNP VM, leading to early timer interrupts as perceived
> by the guest.
>
> The guest kernel relies on the reported nominal frequency for TSC-based
> timekeeping, while the actual frequency set during SNP_LAUNCH_START may
> differ. This mismatch results in inaccurate time calculations, causing the
> guest to perceive hrtimers as firing earlier than expected.
>
> Utilize the TSC_FACTOR from the SEV firmware's secrets page (see "Secrets
> Page Format" in the SNP Firmware ABI Specification) to calculate the mean
> TSC frequency, ensuring accurate timekeeping and mitigating clock skew in
> SEV-SNP VMs.
>
> Use early_ioremap_encrypted() to map the secrets page as
> ioremap_encrypted() uses kmalloc() which is not available during early TSC
> initialization and causes a panic.
>
> Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

A gentle reminder for review.

Thanks
Nikunj

> ---
>  arch/x86/include/asm/sev.h |  5 ++++-
>  arch/x86/coco/sev/core.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 58e028d42e41..655d7e37bbcc 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -282,8 +282,11 @@ struct snp_secrets_page {
>  	u8 svsm_guest_vmpl;
>  	u8 rsvd3[3];
>  
> +	/* The percentage decrease from nominal to mean TSC frequency. */
> +	u32 tsc_factor;
> +
>  	/* Remainder of page */
> -	u8 rsvd4[3744];
> +	u8 rsvd4[3740];
>  } __packed;
>  
>  struct snp_msg_desc {
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index b6db4e0b936b..ffd44712cec0 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2167,15 +2167,39 @@ static unsigned long securetsc_get_tsc_khz(void)
>  
>  void __init snp_secure_tsc_init(void)
>  {
> +	struct snp_secrets_page *secrets;
>  	unsigned long long tsc_freq_mhz;
> +	void *mem;
>  
>  	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
>  		return;
>  
> +	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
> +	if (!mem) {
> +		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECURE_TSC);
> +	}
> +
> +	secrets = (__force struct snp_secrets_page *)mem;
> +
>  	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
>  	snp_tsc_freq_khz = (unsigned long)(tsc_freq_mhz * 1000);
>  
> +	/*
> +	 * Obtain the mean TSC frequency by decreasing the nominal TSC frequency with
> +	 * TSC_FACTOR as documented in the SNP Firmware ABI specification:
> +	 *
> +	 * GUEST_TSC_FREQ * (1 - (TSC_FACTOR * 0.00001))
> +	 *
> +	 * which is equivalent to:
> +	 *
> +	 * GUEST_TSC_FREQ -= (GUEST_TSC_FREQ * TSC_FACTOR) / 100000;
> +	 */
> +	snp_tsc_freq_khz -= (snp_tsc_freq_khz * secrets->tsc_factor) / 100000;
> +
>  	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
>  	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
> +
> +	early_memunmap(mem, PAGE_SIZE);
>  }
>
> base-commit: 337964c8abfbef645cbbe25245e25c11d9d1fc4c
> -- 
> 2.43.0

