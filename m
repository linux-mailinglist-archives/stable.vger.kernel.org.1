Return-Path: <stable+bounces-246992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALRkFCi+BGoBNgIAu9opvQ
	(envelope-from <stable+bounces-246992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B231E538994
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5475630143E9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65413A718C;
	Wed, 13 May 2026 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qCraSahs"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418612DEA74
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695578; cv=fail; b=kvptNWxEgufbjMmSG/0R9VDCMSMeZP7AlDySqhD/GP5QoMw58nDkXbxLeJlD6bNLmxIqVJmh1fvHX3IJOi8F5Yl5buvY5U5NgcaTU8PV9AD9KPlRNW9u2xqLiwsJoVy9SdwiRhe2X0BgKp195Dt/Ra71aeWKJZMrcXbX4wJS6s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695578; c=relaxed/simple;
	bh=a3jwHSsemvVBydMhwWg4cqYZBYMYk2gfy2i6eTmAe8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXWlX4K8PqzQ28WUM+4RiHrU8/Tl0qO59N8DiDfwqYV6Jurjx6w8xQNh35G29hOVHi9xGQFszbOQHlydGnU0YCwwF350HAiuRBkmAmZqd9cYNrna+aSI0G+u91U5Q3+LEFAP4yvW3t+6ZZRptyNUkF5JtCjaO6d9sq13UEmgI/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qCraSahs; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amf/CXq3tWClthfKO3zChxiREKSJm+1puVr5pW+myIErjgltg+sukX9lwk0wurqTHoTmCNCEc/WaKlrLSUVXuirdIXQ9+1zohphqEZlsnjAwPu2bNN3DQAGhQu9XeBf6QCjxO/QMWfJXrI9fLtwSz/0XczjMShVL6u9MqosYJv/8Sw73Rlqmh5kKw366Np5G27cJuOygXaHhhe2rRFdpDOIPBmbpoWF8TVwvGlKmymvDTQjc3aS79t0WBGWxzCA7qwbsOvunf+AMZY2YgK+2yzsPJnj3wJkp0KCgp2pIYGeRdgFesIIgqy9IufHvFJrUQm0G+4UjvDYDQ5pv6L1D2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFN+gxC7enK2Z99fniI12ZQ4mOUHkHhCERBOKbQInDs=;
 b=q3jJ3P9xLjtCLQIx8Bvth+UshztrSGAjICrlbiHSRuh2ZGuSPmu1/BetBshiGlXuP+ZCjYJ3wp2+/ypf1AfGSToZRx7LQs6FC8BDHEy5IcqZRxYS3MkCpJTXJ1n6HEPSFkSUsNzyLDBuOCUpyHTdj7ytdFSgGV7+NC8hk0L4jklm+1lNi5lmT4LsC60DogYkMzusFB66vINiP98oeJmzLWiu47ArPxqmV90rPRcVRkP8DkqbRVJV6eEiiEzPc2VlpWfPOWjJW9hC2eEmymtjwYB7qIAwCJjq/wgPJOfVvsQ43C76OVLoMOagSs0YqEMvFIqgMLk3jxCB125jZfzX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFN+gxC7enK2Z99fniI12ZQ4mOUHkHhCERBOKbQInDs=;
 b=qCraSahsrWXjHc7GoejpmkLrC1BBzjW2KahYo/AH+26Hld9XE+t6GSI0UkWtjPnO6CwumZwsKrkDFU15qb3XmtWLT5aNoMtCkRHTorYGHA8eWqUeTWQaYxexyhaROTdXIxDBIlnK8h7cueII8rA7oS8tFNkyJYD2VNwlYgYkROghoyYu6a1aHCx8exxwFnUGnP03Aapu5sgkuJzyvC8kgJ1KI4tUlX/GzsWJb1YhDthGY6YP8Qd/C67efb1Ovz6R3TmlGgvKEmI0vUdyt/muUnHpNOOXHOscD8syvT4j0O6oGwub4CtIYVyV5H/L8mk9Kc7iXzx+uToSaXISnOUakA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 13 May
 2026 18:06:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 18:06:08 +0000
Date: Wed, 13 May 2026 15:06:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 4/5] iommupt: Check for missing PAGE_SIZE in the
 pgsize_bitmap
Message-ID: <20260513180607.GC787748@nvidia.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <agS04F8UmZwWZNao@google.com>
 <agS6jQII_2PsAuZh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agS6jQII_2PsAuZh@google.com>
X-ClientProxiedBy: YT4PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 32eac4e7-0a33-4f94-b0fd-08deb11a4ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|11063799003|4143699003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	szXuoAaMTr/c+TopsgLV/LUeNFT7yGRGanNpGjciy+ggbG6mbRAz12A+EuhprLkyf3gHKT1bn+Fg2huVRR2EYkyITmnrjUdUGRTT4MqNGzSEEr9WQKjCwj74Il67Tr/3XLx4gAH3QoMJxxuRfVOtYv4tuFVgA5zyF2dVGxzuRypQ2mzhScAZ0tIzQ9JcuIdHLXEVr0Yh+oBbUsyjMMnD/gAHyaVp/oklap+XlOf0e8Hd5LyTkOYwSSVwTT0RFFbafFKtLvxWnkn0ctAv8eE7XjVOzYHg5M2R2z14E0on0CObBQonvLq2UrdjkpcbeETDuOohZJLEOrYvU59Fqvdb8TUdTr13Y9aGHXXwEuR3mfAr7+HGGZfivf56zKfrHo0UxdlvLQv86V9XUSREt6VK3djrK98pcc8lAE66LTRdmg5buJbg5f9uAT2fSY+I27oEroPCe+lgEmIm6Z8BJTHuPeIbk4vCKp0By+CF3UZic5LJHj/hAApjjeCGIJVjBjiFhoKHXh6RnHvQP4BdF2LtENs+E1H3k2Ua1k9J1MplMakBiwFbMgUSP6pVqdQpxMG4xzjaKnp5bQsEzdObq2sTA/m5rusBTxSpTfWpF9NALaAV1w/rP5L6WOU+R5mPYgzxEK1h6PanynHZU3COQWe22B5nakekcCQbA/2/7j7sxANhJ447aoNM+k+isxawiYDW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(11063799003)(4143699003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uulOGLHhdMZPQ/nTOqkq38R/dOuia6cU6QWJ0erYUgiAbsMkE4O8kny1Tpr6?=
 =?us-ascii?Q?F7kjJyMbq44fCUVdcvacc17nAt7fA53f3qnMSmFk9nnChQ6xH1fZI+WRH8o8?=
 =?us-ascii?Q?buGkogl0bIP9U67yuPD+3l4HJwCniu8DMh/iILHzISv1z1QoPtl82P8QxV8V?=
 =?us-ascii?Q?YKkX4NoMkgmsR15mubeVUsQppi8f5Ea36FqGGZtt6BYD3+idUXCbzC+hwcuJ?=
 =?us-ascii?Q?Vmig4c/l//Zeb9R7F6K+6YN3heE1gg9Zh2/CJOzTJd7eI6G1ThrIUCrdpcGS?=
 =?us-ascii?Q?uubYTMU+/xqx68bjVBAIwQjx4TCRtghM8k3RPTkqNsn2y54hsEprwCfykmyA?=
 =?us-ascii?Q?pdvjgNnVOBGiL/RscDiaE9I0ZUs+E2lbXoeO5DU0DnDDMOY/fmHD7EBb9N9r?=
 =?us-ascii?Q?rRIDq+JGr7ugWOy3lPVHSBL+7jeS8bsRN/QTdowhAXf3n/gfaEK9kH6Kd9B+?=
 =?us-ascii?Q?/EWNv2aE37MerZNniaCS0zcwJN6I1F1vmUR/DA0qrbME49WRidudcCDgzs6h?=
 =?us-ascii?Q?MUMrUaT9RNuEDapTB6JuumfiE19qvBKbe8prrO/Z7FqKQjFBVnY9D0IYIXhL?=
 =?us-ascii?Q?o4374034CuC0JsApd243LjORzQaEHkpzxtamAh3DoG7jAyS4QUab5m1mQ/14?=
 =?us-ascii?Q?QLT+NUIKLmBhK6DV1FXQ21xz7InRE3TnwgAv44AFeYvD8ZW8/kpFUUf+A073?=
 =?us-ascii?Q?ZszB2w432EjZg2EOAvIcxHVphnPxdnTdO4nZ8sF/HgYBZWsikMFoVBz9iI34?=
 =?us-ascii?Q?KLWVCcVv3WDlWowA2rlxfK3kS1hD/18H2j1mdLIvXvUOLEZGSLSdaFc0EFty?=
 =?us-ascii?Q?GpHlWkplCYBErvBUK3H/fgHxZhI893ZVuN4zxt0UBP+XDfALgRjCc1Dj/dTp?=
 =?us-ascii?Q?UHwuu+sfdlwDfD6NiFvMt+B3P7kII9HdrhhSi/2pLuwwgkI1GeNYlUhyZXoh?=
 =?us-ascii?Q?Y24d70iBzoynVBjrrybr9gznomxeD0zbZd3kWTyg9FUHQL0evn7OrlB8uhAB?=
 =?us-ascii?Q?8QaugRBkPOqx15deelHghJFTCaHELKfR85OAq8ZkdUvc+cJzE5O0LXQxoE1N?=
 =?us-ascii?Q?2TNdYw10eJzGxzKpxx240aWoz+SeRrCXc19qn0s11ycDwmgBe6aVFMfQOYED?=
 =?us-ascii?Q?xqqqpNyzasNoxMF+oaLm1YDFDis+vjgo+pJqVV0mhG0HCTgKrn9jmdY5c0a7?=
 =?us-ascii?Q?AYgxw+vV+I0BD42DFuCrKrxLdyhziZY4kvv8Xy3HmKd70hE0d4lhoCj8mQlY?=
 =?us-ascii?Q?e3FERk1lH3eNus0IsvVue9mtCqyuNrePYSDookscuKSUZq/hGLxLOBEaSkU1?=
 =?us-ascii?Q?vgodgcbtpTlVIlVX9GaRBPKKtb0hHdUaHffqSgvZyT8F+Lo0/FUkKUZiQ2aA?=
 =?us-ascii?Q?niytv1Y32Scb65R1I5/exFQYCDci4k5cmDe38IQJVqjikC/e0qFF1gOwZfvn?=
 =?us-ascii?Q?OxIAyoAnFZyOY7ISepkSpYjScsdX45OgV2Pse/pZxIqlCrZ3DGAaKmEy4ZaW?=
 =?us-ascii?Q?nuA0Fw5aLWrEdd20O2beZflzfFWP/0oGUhgdjerJ6EuPWSUyq3uOrwypDG0R?=
 =?us-ascii?Q?m92CBuWtenN5pDCQriWaQx2MxjsvPH1ZgeoTIuxvvw4yrW8Tsz8u9hweI5Gw?=
 =?us-ascii?Q?XrdWgszWIzQjqpji4JWXrHvjRwD/JB96TZoL5JKhDu7PBPrMv+aZnDOY6B8+?=
 =?us-ascii?Q?IptQ7flnyZuZqQxPWgqOikeKN6NLx9T6XIQTxpAVQsdXq2xB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32eac4e7-0a33-4f94-b0fd-08deb11a4ed9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 18:06:08.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqwxc6/6hCJhjJnyjN2EsWSl7Vr53jqxlsZAElZzIitLEDfT6Na00CC6HIYy1Cdu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
X-Rspamd-Queue-Id: B231E538994
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246992-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 05:57:13PM +0000, Samiullah Khawaja wrote:
> On Wed, May 13, 2026 at 05:46:22PM +0000, Samiullah Khawaja wrote:
> > On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
> > > Sashiko pointed out that the driver could drop PAGE_SIZE from the
> > > pgsize_bitmap. That is technically allowed but nothing does it, and
> > > such an iommu_domain would not be used with the DMA API today.
> > > 
> > > Still, it is against the design and it is trivial to fix up. Lift
> > > the PT_WARN_ON to the if branch and just skip the fast path.
> > > 
> > > Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > > drivers/iommu/generic_pt/iommu_pt.h | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> > > index 19b6daf88f2ab1..4877b05291c9d4 100644
> > > --- a/drivers/iommu/generic_pt/iommu_pt.h
> > > +++ b/drivers/iommu/generic_pt/iommu_pt.h
> > > @@ -920,8 +920,8 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
> > > 		return ret;
> > > 
> > > 	/* Calculate target page size and level for the leaves */
> > > -	if (pt_has_system_page_size(common) && len == PAGE_SIZE) {
> > > -		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
> > > +	if (pt_has_system_page_size(common) && len == PAGE_SIZE &&
> > > +		likely(pgsize_bitmap & PAGE_SIZE)) {
> > > 		if (log2_mod(iova | paddr, PAGE_SHIFT))
> > > 			return -ENXIO;
> 
> After thought nit:
> 
> I wonder if the error handling of iova and paddr alignment should also
> be deferred to non-fast path? Basically lift the iova and paddr check
> in the parent if?

That would break support for < PAGE_SIZE tables which I've tried to
keep generic support for. Similar checks already exist in the generic
code in a more general way, probably the first is
pt_compute_best_pgsize().

Thanks,
Jason

