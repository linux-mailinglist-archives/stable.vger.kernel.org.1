Return-Path: <stable+bounces-245841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLQBFLNdA2qE5QEAu9opvQ
	(envelope-from <stable+bounces-245841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:04:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53167525624
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51ACD305E038
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8394383336;
	Tue, 12 May 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Klk6skQH"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525813B1EE2
	for <stable@vger.kernel.org>; Tue, 12 May 2026 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604388; cv=fail; b=ZvnVqk1VuHmkB6b1lmALKF+0j79waXkVtLe2ZzBzEJSEbMpUgy8lo8waLe6YSObEG8UpRr7/EDJ9XYMqU0nE8sk/zxHdfh/XJEDpDqqzwVM8ptpxZUaLpwJhi7OMYFhNphdefrVp8PxQ3wbsd2p3p/UiqIwohgMQ+1Q8b9NvTeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604388; c=relaxed/simple;
	bh=phgSrTs6YeQMpI6idRSf1+cMurjqIcAnzaDygL7mY6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNCRZPJBw4bT6RcUlN4OtMUr4LYRjg6Blt7NOsYc9swePTK/waqECQR75owBnC921OeXyu8HZmAzR2oMRhAO/W2FSqu2dSy6oePXwdbcyRx7q2uPj3tssvQp11/mvTnLNNgqbTXzTGyP0Unhb0X+n4ROtNRPlccCM+saCBaif58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Klk6skQH; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeuXO8xwmOp5SrGZ3N5tooDoKPT/USKmmg/LoTYJ7gnvz3OV3a36f941w0rjmHDC51RTrJwMLsbKpXidXFaX/qQc775XCeet8Z6cThaaIr/TVD71kDZtnhrfH06KV4+AiOKDcDMca52EmtUOnw8rH636Gc0YnkOkHYSLQe2OPRF2BhJWcaTraLGIBBAUSqextJbLgnm/viTL6nwMTYMX7hEDbvhu/Bahd8JYK9iA8HAHm0Ikc77saO30CIgs2vUGlS3dSqgr9BrT484wVGm0hGcM1A3U1vTwjDlarG6A3UTRhPGEVhc7Z4xSKx0kHL5SG8ooMwdnLXelmdzo8HJyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAD9wM29JPXR0rO8UfjfX/SvQYqEFWpDBTRQSnXzY+U=;
 b=LXJUHLZbwPK8b/QRIwrYvHZTQcTvhB8CXBw0759vEcGbHP+BIHDmO8aFCtQ6OXvXboXa2EKe6zLH6DMee6evVr7qmRQ9FQZBZtsZZIPMFc4byBLmMErtpWDzTMimaLv7AE6WAQZnhnxOU9pcnJ/kRTqUW08tt2DaRZlZtyD/76GXiOAm0fdETsZ+MMXKiGkFAKxawRlBi1H7lUjU8IvakXofmNmBjEr9jt6NIzfXVYG973I1z4fdxZPJ/TPueIurzazZ4rzRHLr6wlZNjkg2yAWoyDFXzTTcG3C7C/d6WhVIyJ/iRuMY2uYWBmvfr3RGLrR5/zYy/4Z/BHR2pBpCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAD9wM29JPXR0rO8UfjfX/SvQYqEFWpDBTRQSnXzY+U=;
 b=Klk6skQHTCistwcz/+ByCDEiBziWD4VN8ngho2u3iyoOcQnHTnYmdeKK56AD6RB4o0PvcYZuUz0oZG5xn7pnxr7Kk3EhJbwYlDHX+5LX1PKgB9PWqpbXhEWGqH43KxJSvQbuJxqGSP6KuXjQWEVxf39IG8Ke+TD3nvU345yOSBUJ7HisDnRZgWond1EaHGwQ0wZ7PStDot+rMEvIFWziqIVoavmDy1X+SAAswR7JUiom51L6JiFZ39dnvF2nj0A1b7gb32EvuuCVkQOU2oT+GYhJ8ER7aO6J6Bc81DPlMuMBduQVt7NxiWRhvY731wzXeRgefkdQ55Rkd1lvAO6jNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:46:20 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 16:46:20 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	stable@vger.kernel.org
Subject: [PATCH rc 3/5] iommu: Handle unmap error when iommu_debug is enabled
Date: Tue, 12 May 2026 13:46:15 -0300
Message-ID: <3-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
In-Reply-To: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:52d::18) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 807dcde0-b860-4de2-a981-08deb045fdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	mIgLCq1XAVRTRLGEO7EV1w/yeui01NgZ6Ui44h2ph5IFcsR6g3E7BLtmUBFf4jN7OLbxyyVi+03btSZ4LdVrP+WyZF+rBDc2ps4hKDBdeyq1z7cUlbVkt5QMz7mtyg6c33l/c1mc7GeVAYLw2pXi7GeEdgOGuwnyTcURhbqmW1oEl+bKUBHcedCZJyV2GdyfpicVokkOxtcDieOYB+sTtp5O5SieqV9sDXllIq/Jc/97iAa2pIzpWbREztHtykARiVRPzvo0kwRKkIw7fQo6sxa1JU872poFPOdGqwzNr9LzMy4bT4LWWgyRJZQ3kDOTt/zGHe08DekQ1qP2Cg9HHeCC5EGkWbJ9zMP+4k8yIsLwko3ddxDfTvGpuvJz6H/pIwznqJFlLs8+Ce/PizcLHMkoqfFxoWoC2UdvQhoMOldh047n3vxxFOS9tkadZvyMoNSXxm0T3j1f7UcCRqX/IkplnQtBC2i8p3613LpM2eNaDqXd4WIIPH0bEd0/sm0Z3Pz9Gq2eWLAoPMv1A/t96U3mqSDIq3E81hbVFZJK15KsyScqz6kKIfK8Phyl9jV1QtVVlkC8S3EVU2+X5KwVa3ZtBZQsaTGlArRUhznZRdxsuFbd8yXgpLBbu5CefN+o7ixwq9dvLFux8lNXC6eFeDcDDSULvcrfX+/KmHrgy4kW3pOjOIEdD5klYp+Bk82A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0+ehTS0u3C/GjzkEY8MWQ+WCE2s4TvOeqqvDn6hj8GtHtvIHQGa3UtqXJQGS?=
 =?us-ascii?Q?lb3E1Rsp9ZgBVh4N1WiPph5N2UxUYByFeG3Yvc5wI9Cko2Wrqx62srM825WA?=
 =?us-ascii?Q?OjCgnzSA4SwD8nizTimJPxVpxNKiNwpKPDf41qBiqUys4ODFKXPOxKXNvTjA?=
 =?us-ascii?Q?5zOqmDqhjIeLUNxWaIcuntB033hUV5cJwxXXMdm6tjcks9X9pshz4kuleQzm?=
 =?us-ascii?Q?LaJucDQwbp3Ldqt4qJZr7Z7cqEkKzp3BJtcmTc+PzW883IajrLdDuMdeodyb?=
 =?us-ascii?Q?Unm/1V3FsmwUU/xW1F7XXFr5Pav5SEI3Av7dkyvjA/AT15Nz9iccSMDajncL?=
 =?us-ascii?Q?aCPp/WMGZh0RSIEs3HE/LGw5S6O33AKuq2l1qdBPKzcByzRu3ND2VK9Vo2Q1?=
 =?us-ascii?Q?TCDytLoqAovCojmG94VrpXP14TiWR7+V/VJEpFVMOo5PM9zgd7j4XFsC7Wvm?=
 =?us-ascii?Q?ATuDGQhM3h2fe9GTjDId8F0+iqfpTya9Ft3/VSYuliYN09kRORNGv6YL8coH?=
 =?us-ascii?Q?GbkKzGpXsIsyZOPIX2tLoOOSq5z1mkUbVaAVaJnvHpa5ceaoEt9+bVe15tBV?=
 =?us-ascii?Q?NwGx5yVlJ+sh5sk/QHoQW/8TqehmbuEELQGTdDVn3pRqECPH1r3KPvewTuB6?=
 =?us-ascii?Q?QND8arV7p56dM9LkslDMDS2dFGJV1nWfCI8dxlasy0pojVyX0O9HjsNqy/at?=
 =?us-ascii?Q?/WAAiDoue90zGTWgUnKrTh/Dj5cAllXTdpLCboFD1D10ZPaAfXkd1IpgHj0v?=
 =?us-ascii?Q?T1JeudpFPo3bLxEJBBo6BEtrh/snPlDJIw5ZiiDJHUoqXHuqZVhAk3iTEocZ?=
 =?us-ascii?Q?INVtmFnL9+qxA6y4UvZ8hr7bgqjMr25zvMjwC9trxx5j7jpDoWPbm/SfxShT?=
 =?us-ascii?Q?MA85IcLUjxw3EaYbr5fA6IhHAoTKU9IXU9ZSXwf6bm+eGYgisDot3D0DR7IQ?=
 =?us-ascii?Q?tMTBVGPcjHhpMauoitTdVE/wxzY111wj4Xm7T8mIn+M6zh24EoD/ejQn0uVp?=
 =?us-ascii?Q?VG8HNRD0h9ZxemdjLlJZvdjhY94Cf4R/Foy+Id0MfJPmSuky/EM7gIaBT2+Z?=
 =?us-ascii?Q?Mad4yJ0+4up44sJU2z3Nr9R9f2N3BwRk9q6R1QoaWj/LYiwvp6sySwnUhPbs?=
 =?us-ascii?Q?VgFAneXe8sbkCaEbubBjbg2elTDLpQMBRn9ZQQS8Q8ilC3CqiDIblxlEKPQi?=
 =?us-ascii?Q?XJkgjn3IpvDI4dsasGIOop/2VxitFVf7q0hxz4XRKCxuquhIXS1H2xeB9FME?=
 =?us-ascii?Q?YKpF9micB6zdJm6Vp+1NTd5or0QpTYzkDkiwE8s/ChmypBkhSvABUET6K77Q?=
 =?us-ascii?Q?5iAauktEBQOiOgrf0tCu8/qR1svEvzd4IbkD7BzZxGQk2diN3OyoIkWsbTfq?=
 =?us-ascii?Q?XAh4xAwIj5z8oDWhpgj+C9WcdOa9GIezPxTD6jQUo1nsby5P2Bxr1m1Jjvl3?=
 =?us-ascii?Q?jUKl8W/Rxe4Ja9fAfdy7WGwWpFbjzG9NEm3bb6a40iOEqA5ExzXGwae8Wh4F?=
 =?us-ascii?Q?lT5Zp3hDZ/KGz/90Gy8kS2cdBdRSeObbUW+pFlLxic61WHj9BtDlE2gzFb5z?=
 =?us-ascii?Q?DTu3eVUjIUouhD6UBwayyhzVdzdmjuBLiJQq7Lx7ciuw+NcCPEKPFekxUQUm?=
 =?us-ascii?Q?FdVDhndnwISWlt26S6T2nhBfg92NxCWAVsKrvaJSGp3OZIhfIZQA9iivsuqM?=
 =?us-ascii?Q?dvblS+azdjWt6wXOOeLaZL6gSQZTksWkKhBm1lDX9Yth1znP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807dcde0-b860-4de2-a981-08deb045fdac
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:46:19.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q71pKK1ixljTEsFb1F8dun6Ur5IckHPtq3DHtwPQrVdi+gCaq+BipHrsZ79ZHlxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173
X-Rspamd-Queue-Id: 53167525624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245841-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko noticed a latent bug where the map error flow called iommu_unmap()
which calls iommu_debug_unmap_begin()/iommu_debug_unmap_end() however
since this is an error path the map flow never actually established the
original iommu_debug_map() it will malfunction.

Lift the unmap error handling into iommu_map_nosync() and reorder it so
the trace_map()/iommu_debug_map() records the partial mapping and then
immediately unmaps it. This avoid creating the unbalanced tracking and
provides saner tracing instead of a unmap unmatched to any map.

Fixes: ccc21213f013 ("iommu: Add calls for IOMMU_DEBUG_PAGEALLOC")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 49 +++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e334588a2476b4..e5fa9875900228 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2575,12 +2575,11 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 
 static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
 				    unsigned long iova, phys_addr_t paddr,
-				    size_t size, int prot, gfp_t gfp)
+				    size_t size, int prot, gfp_t gfp,
+				    size_t *mapped)
 {
 	const struct iommu_domain_ops *ops = domain->ops;
-	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
-	size_t orig_size = size;
 	int ret = 0;
 
 	if (WARN_ON(!ops->map_pages))
@@ -2603,31 +2602,25 @@ static int __iommu_map_domain_pgtbl(struct iommu_domain *domain,
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
-		size_t pgsize, count, mapped = 0;
+		size_t pgsize, count, op_mapped = 0;
 
 		pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
 
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
 			 iova, &paddr, pgsize, count);
 		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
-				     gfp, &mapped);
+				     gfp, &op_mapped);
 		/*
 		 * Some pages may have been mapped, even if an error occurred,
 		 * so we should account for those so they can be unmapped.
 		 */
-		size -= mapped;
-
+		*mapped += op_mapped;
 		if (ret)
-			break;
+			return ret;
 
-		iova += mapped;
-		paddr += mapped;
-	}
-
-	/* unroll mapping in case something went wrong */
-	if (ret) {
-		iommu_unmap(domain, orig_iova, orig_size - size);
-		return ret;
+		size -= op_mapped;
+		iova += op_mapped;
+		paddr += op_mapped;
 	}
 	return 0;
 }
@@ -2645,6 +2638,7 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
 		phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct pt_iommu *pt = iommupt_from_domain(domain);
+	size_t mapped = 0;
 	int ret;
 
 	might_sleep_if(gfpflags_allow_blocking(gfp));
@@ -2656,24 +2650,19 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
 				 __GFP_HIGHMEM))))
 		return -EINVAL;
 
-	if (pt) {
-		size_t mapped = 0;
-
+	if (pt)
 		ret = pt->ops->map_range(pt, iova, paddr, size, prot, gfp,
 					 &mapped);
-		if (ret) {
-			iommu_unmap(domain, iova, mapped);
-			return ret;
-		}
-	} else {
+	else
 		ret = __iommu_map_domain_pgtbl(domain, iova, paddr, size, prot,
-					       gfp);
-		if (ret)
-			return ret;
-	}
+					       gfp, &mapped);
 
-	trace_map(iova, paddr, size);
-	iommu_debug_map(domain, paddr, size);
+	trace_map(iova, paddr, mapped);
+	iommu_debug_map(domain, paddr, mapped);
+	if (ret) {
+		iommu_unmap(domain, iova, mapped);
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.43.0


