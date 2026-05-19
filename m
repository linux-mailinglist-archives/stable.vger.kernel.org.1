Return-Path: <stable+bounces-249650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DiSCqahDGq8jwUAu9opvQ
	(envelope-from <stable+bounces-249650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:45:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AE583458
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 092093055565
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3673EA953;
	Tue, 19 May 2026 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcWeEAaO"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC2343884;
	Tue, 19 May 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212706; cv=fail; b=eVUa++JrIkUTtM4/qo/tW9r0W4MSKkZ5EIsQI1Ozyd0gABSvXg+oNeFsoNBZDJjmwCa5dxqmztt7EovAPCuWtE2D1iOx7eE0fCB+P+IiVpBiGRho53WXXYb5Xg9M3b6shTdciSeHydO9z2+QJIukQET6zgvqkSpC6SUkf6DTiVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212706; c=relaxed/simple;
	bh=W+Euj/3JpTOvoPQ8zJpJWi8GGFTUC1MP0CXXpnZlwjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O3UFMAz7ktDljUaTiBX4QlRlzSfQDfszPZZmoA/zEufNtZ6bYozGzCmexJxlPnE0mK3yIMfw0w+bk6A0DGUvNgvGPw2bbIvteRb0o/5YOMqauSnM3CdXyuxPtyGf7xKz6vMsFfbP/siY8+6azzpX+0iZgnPgk9VNJNDNu7+r2SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcWeEAaO; arc=fail smtp.client-ip=40.93.195.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGBXpYMMXFx74JkNf+6wBBBdLD2fZDUw2m78dMIi6zFWqt8EMvAg6EwHyCwMaoFNSlRUXUg0QbepXdEmeYeMGF2olN2Aw8Ei2WSkc7ycwpuvvjAc/zjRAfZ8T5QHsqoL8kafggtXyE/tGytnyv4k8aPECL41TJDrYIrZ01IZhACJjmzo5wfZjQUq0Xm3Ax8auralBEzsBNeuEpz33BCypdCeWRqsxTI+QZ2L9uI/6VpHljFcK1l7/JYg1ZtmRvnhEL6j66xELpQaRlZWVzB1y201JkBVPPpebb9Hidzg/pCoYRpufRWAKSGlfC9uvfxRXvz4GI0a44TJYAghAk566g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=351dAeoF1ZrvJOBOk/cybCSencf8gbbhZ0EnrQe1xaE=;
 b=x3tV6COiTflULUZQ9NRrHu+wkxUZpcHM+1ECAaZQvTemBSgtQRDQTsFSQU0br81BCogrJqaHgCwvUnWAmXitjhJCE6KwyYV8b/dVaFOWDjA5YTgEui461Ljx6m0RLkIUvelMzYw5BYCvkiKv3k1rcNhcrOXHA0iztk+5/e0zKClV9KRObTcMCwegPZTlnEzE+cvkvNXqK4KbKp9D4SzkpY32304E69mqP+iXcotPh0Y+ZlinZSQkYbXs5HLI+MvP5wKhep+pmJPN+HaozMBIcGvvGyYKOwOsR6W7KmCd9XzncFum6eALnjkLJACuTGn0bOZ6OvVKbNDaMnBU/i0+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=351dAeoF1ZrvJOBOk/cybCSencf8gbbhZ0EnrQe1xaE=;
 b=PcWeEAaOIvngeKrtVskWQiYYh+jJvOH+X8KyI5Y9glCkPTMKCEWhkHLsb/FWk5y2HRti+WGN9LdPGWqysiqGc6CHTbBOKsaUmxYd88STHC+1R+ftICtZYB0pqoVA7+KjXqkHyXh2oIdxEl5w/xqiA7yAU8KfhzcIA8fvM3WBMKwARXwOR+Lr6rkvbMgoDrJrrO+MiK79qiN8PBPy8F6PQs9dbg2Nj5E7yaSUV4AJXkSgSpP7dUkI8Nb3p0kXNVUT4qatlWEvKFHaB5126+iowGjaCEQDM/Ah0eLsxi3G6cHgYCBQHEIVJ3+LdcnjJML22MkahXhhg/ohoai/sAsLYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.34; Tue, 19 May
 2026 17:44:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 17:44:54 +0000
Date: Tue, 19 May 2026 14:44:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, kees@kernel.org,
	baolu.lu@linux.intel.com, miko.lenczewski@arm.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH v5 3/6] iommu/arm-smmu-v3: Suppress EVTQ/PRIQ events in
 kdump kernel
Message-ID: <20260519174453.GF3602937@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
 <6e5828f3288aed6f9e9f4e0ca54e7fbd9f439274.1778416609.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5828f3288aed6f9e9f4e0ca54e7fbd9f439274.1778416609.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0304.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: a95a48c6-2019-4bcb-186a-08deb5ce562b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|18002099003|4143699003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5tpcuKQKkaPAS9YTwbrM+GaTDkh1x6AKQpZS0EpESmKWTdDjtZbmn3bc0ybZYRZKd+uzd3XHZ3BWhEQsSpb4yMACn8QW7XqoWQOD4TTDdUogx8eO02QKE4yX8cGqDPH+r+tvg+h1lFJiAVLnxW0BSiN34WGb14QPn0EotSbATWTaiYramqTBaGZjZgcGZsOuJuibJT8QAUQ5ruw9d7AEwbXtgKCZpxm2HJCbxSfAApwpm3hP2Tvujo1cF55IeLLdvHD2raB5lNp2/vrgeTdjfj2F4bJ7VqbQ139fjm+N8fWkkx3Qv8tIvu4gxIa1uL8sppKWOdkfg4R0lnAoH9BMlfnIbcjJesCDyaELk/mw9bOJ54qPA+NOmYOnUQ+RyA9zLdJtbuK034gtZf4w3SYbdpj2Ynetm72jjZh7YSqIPdl1/q76Bu7xNcG88EofFY8nVyBkIs9aWhvhVfpH+OibaUhsL697ULGM+GJaCqsmJQEFuurnWIUUl/qJJJzUuvjWXIaQ6Lu5U4oyWxa/d9nRTEwnibusOcgbIYbfOueqF2smtp5AZ/o0xaOyK/2JY8dVMrJiXGaD6/Utl69/SQ4nfkL2yLDei9/7XwE5Kc5PrcSdtzaDTQM9Tj+5+c3aWVJQXMQTBNY5QsWSfanz8Ja7VLKQfikiRkX27xBLo/eZU724l9zPGp7g81B1dr5WbIEv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(18002099003)(4143699003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZvoI9cDNeMQ/QUGRaeRBxYR4fmI11pv0SGBjJfNmJBwvMwbksmgTbDIfIGsO?=
 =?us-ascii?Q?YkG19pJ20WKt49qpW+X4QrzhauIp3AENl2V903yf3ac7qWwdlO2o/xlfvZBK?=
 =?us-ascii?Q?6Xy2CzFHKmsVUMkSrFLHbrazZS5QVGMBfBYY+1mjGD36Gn4e67XfzhP0c+Xq?=
 =?us-ascii?Q?ETiUmUdMuxYddFPvbCkztKPRhM+c+5swGrMEe/JXys6V/PydG9RNL9Kz95d9?=
 =?us-ascii?Q?27LN1sGeQ76hG6BkNIdf/tqqJybxQ1zoRyXbp5VuvoYq4uq+pELw8ariblmT?=
 =?us-ascii?Q?xpO+hvp1QsQFuQLU/eDWZ2m6E9KEF9Wsdm42eh28KMCeD37YjEG6Km7sjZRk?=
 =?us-ascii?Q?rUWdKLuXfyctpFBPfAByx1+cCw/PQIQKZ7VNJcTHNlvKqd8Du7nLQAMJGtoY?=
 =?us-ascii?Q?juMjBwFk+VbBxoh1pxUWcPQD6Bb9mGAHvU/0w1SBbnQc4R3hGKYlxmiV2wVk?=
 =?us-ascii?Q?2yldBIGt6umo8jpsjZUzfKrZIqg8G5oHt9xXBgI5JRW4r4fShEQDu687zowS?=
 =?us-ascii?Q?sW9QyAuQN9cYUYNdE6viISbQ7natjXsak4XQiSMwgmxAtOo+5S0teUPsVRnp?=
 =?us-ascii?Q?Uc7GiOTu6RVRALZ9hjQSSobYP0Zs4iv1d/4mfPVI4/Fj2Rnl0gLGL0FxDaR/?=
 =?us-ascii?Q?2TlnlNiQEqeRDx8qtR5+fYJhMTiVrX6WR1HKWaU8z9GEqzrELVfd3oHSvQae?=
 =?us-ascii?Q?Q6ACV4lparuwcumSH3396spTAEfhbb9hJoM7o8bttny/Ws6+6uoYWDy8GSfU?=
 =?us-ascii?Q?ZSRiCm6WFBINZCqbcqY4zFNpIJBGnu9bkbdiTdht6kDuZpwvpa8UdCvDu3DJ?=
 =?us-ascii?Q?ijRASVG2YY3H7rMI0/i8m/yOXV2lLJeYvFwXEhtuk8CLdjxjoIv+yqCIy8dk?=
 =?us-ascii?Q?2BcnfLF3AIKTS1xleWAVyPsGH2Fd5eel1JJixXPItSQa6S1fn5xUOPVPX2yN?=
 =?us-ascii?Q?fweStH6zUf3O4ESfRTkPgcbe5HJC8xpxbQLj+Aa2/P0N7itIgHvqmScWJJ42?=
 =?us-ascii?Q?0K3l8YrcljJOaMg2p9bx+sZmaLLwe9SYJTs8X9qwV0DwoVzGudNzhUoz2R3+?=
 =?us-ascii?Q?oJaq+K/HJwZ3rAevDpOaUQ1DL/8416YI2YpHOqGk3AF8EB3m4IrShTEL+04h?=
 =?us-ascii?Q?roKHLyM+so3xxLttHGcha6RbjEB4fR/dm0xgOLlOvCKMFijHdE6jLGd86/pT?=
 =?us-ascii?Q?efTXeYaFS3Hn9WtpVQPhRTKAFLSh2vkqQ0eF82jAJ5dW8UxekCQC3O7/crLQ?=
 =?us-ascii?Q?4aw8ldMgIUQuIIuXr0hKk2PqKO+sNJOu3OjTHOXKReI5dli3Ra+U8Zo/wEct?=
 =?us-ascii?Q?3GxsSSaIwoz766e/EvtlleXUvILd9cRiM/oHkdrQ4aTgYZBw/ohH3jkwALkz?=
 =?us-ascii?Q?vr0tmuLUbuI9cEQE534iEkbGvgonoZCIXhkAx049Mg06vT9MyaxceDZV+v/a?=
 =?us-ascii?Q?mYuh5g4PAvvTJqVgKPFVClYNXfABe+uHhpQOIEGBETjj/BMKzmeiCPqiI2b+?=
 =?us-ascii?Q?j5kftKtdcoWm1CcIqPsGrL+Uk82VRL+uN0hHi5TBF6tZNFGk2vj1knyG0sJm?=
 =?us-ascii?Q?x3RlY3ob4ghs33J3Mf2wD46YTMmxMavDaP1uy0RXKRCWMXkWGNqK7S53DP18?=
 =?us-ascii?Q?eEtJP88FK3LYkS+CzBPFUmqTphXasxlH8CYB2IsqZUqGXW5leB+pAasCS8Zu?=
 =?us-ascii?Q?oJW48nU0bi2cyUltUNs7Y+QlHqJQlFq/d5ECrswIwBDPONRy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95a48c6-2019-4bcb-186a-08deb5ce562b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:44:54.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWY/DLN6yAwH1Abj1pOIpiyI0uM3KD3CuUETOv2Y8MRXZHkPGg3tjyx4FdQ+yEAK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249650-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C29AE583458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 10, 2026 at 02:23:02PM -0700, Nicolin Chen wrote:
> In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
> which could trigger event spamming. Also, we cannot serve page requests.
> 
> Skip the IRQ setup for EVTQ/PRIQ in arm_smmu_setup_irqs(), and guard the
> thread functions against being entered via a combined-IRQ delivery while
> the queue is disabled.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 +++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 579c8af82d6b6..ebb0826d74541 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2364,6 +2364,14 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>  				      DEFAULT_RATELIMIT_BURST);
>  
> +	/*
> +	 * A combined IRQ might call into this function with the queue disabled.
> +	 * E.g. kdump, where stale HW PROD vs SW CONS would drive a bogus drain
> +	 * and a CONS write to a disabled queue.
> +	 */
> +	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_EVTQEN))
> +		return IRQ_NONE;

I don't think we should be doing register reads on these paths. 

Why not load a different irq function instead?

Jason

