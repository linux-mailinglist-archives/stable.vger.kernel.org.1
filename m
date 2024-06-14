Return-Path: <stable+bounces-52135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92690831D
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 07:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438D72837EA
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 05:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB3C12D760;
	Fri, 14 Jun 2024 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="ZnX4T+77"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1F2F43
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341254; cv=fail; b=ds1WAaMz0Zm++OAzH+PlM7y32DwPqBmkPEGgCun/F1KpUUL0xplS7bxURNCSHSqf/Is+NXZzF60RDku8IJ758dnVKrTPJkOzRK3266KDuPyTcfG0QZ4ytgnhCxVIRvc1qDulZEdMfuap4tLoFnnb4o1z80byw/VwKTzVesC4QZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341254; c=relaxed/simple;
	bh=Djo8jl1t1VukJ9vpjAE7LzMqYWjqexga7lIDyx6YyqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spRrN2d2AjaizEyE4L1/JvnB7GmSee4hq9OfloxkY+hOVwiVTEjyqCYoi/OhMAgx6rFQrNXDXxjpEqq4LiOZhHQx0TwZrdsPanaKcG+Kfvn2akQXdmQK10V0rfVy2e3uWrqlCvQOi51e+22LvE4Xp1G6oPMJn1+QyemCHX/tVn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=ZnX4T+77; arc=fail smtp.client-ip=40.107.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1BCK29nVA1L1E8i74LTWW53D9uxeBGRGaHVkkOJCNMjFixTTuLEAExCLS2WtlehXKcnC50E80VbHT3QNpYJgGPov0I1HYaHStMyeGiJuALAF+j5kcEj9ucJRFIHFsGGdAuOvvFMLq9xlNecUT/CqC9oXcDDinfJ8KB+/jZ3Sk1NZAtoUw9EGc+tt9Av3eJWwcNETUfaf4jbCyWG/rZgovjjlMR9jKkuzlsrYxSz0LRqNXSV4wPOBEpy98UqFtqFiaj0Sxs2EhHq/YT1ZjgwYAwT2OnLZq8j4JEdYvAu2MxOA0jrxhgZV83aAjp926pGZwptXkq0q4K00mI5QP96xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StcPLT8iBZrcmgmnWlrBQhBRFJfMc0uPnHWPb3YKyHw=;
 b=eIUMZ1NekxyHju+s9kJXht5mcgoDYqgRnWN77ikrp+dqlSVxgFEgHXJKNvnTB0Ndiop9q5flQit16c5s0Cz3gSvXidLBs5yC3WPH2TQrt0DkCKCEzf5fSB0mLJTzqQVhNCJyzuRuNW8D3tYk1aL41+Rvp7fR/92XzKRXElNxciqFsNfDil9SCLLj/B+vFu8tGvf2kmqreXWOVgBx+SlBR+Pf7hx8MSF4k9D41ZH5ZcISFl4gLgcjL8l3Tn25T/MUkNJk7FMPAZupYr+y6KYer5Eygybu93IUJcAeLBk5aEKktWqDsAJPhqdn/XLSoRQigA24G6QiTtE3xh9dbUhsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StcPLT8iBZrcmgmnWlrBQhBRFJfMc0uPnHWPb3YKyHw=;
 b=ZnX4T+77WvomCzHl4s305dyXQdIFlrkwFJxiH8+CuJqhlwIoA7cImBB36l6h25Am9wVjYK6HlT97c5n7oJi0I6lx6k/rloKTIPEXGwIE5+NQd8YX7foKqlIhyTU1JShGzRnIEGZydhLTpCSmKmE7j25wIQ117iTB45pg2vYQIB0=
Received: from KL1P15301CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:820:3d::8)
 by SEZPR02MB7136.apcprd02.prod.outlook.com (2603:1096:101:194::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.39; Fri, 14 Jun
 2024 05:00:49 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:820:3d:cafe::b0) by KL1P15301CA0054.outlook.office365.com
 (2603:1096:820:3d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Fri, 14 Jun 2024 05:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 05:00:47 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 13:00:46 +0800
From: <hailong.liu@oppo.com>
To: <stable@vger.kernel.org>
CC: Hailong.Liu <hailong.liu@oppo.com>, Michal Hocko <mhocko@suse.com>, "Barry
 Song" <21cnbao@gmail.com>, Oven <liyangouwen1@oppo.com>, Barry Song
	<baohua@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Chao Yu
	<chao@kernel.org>, Christoph Hellwig <hch@infradead.org>, Gao Xiang
	<xiang@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/vmalloc: fix vmalloc which may return null if called with __GFP_NOFAIL
Date: Fri, 14 Jun 2024 13:00:32 +0800
Message-ID: <20240614050032.18812-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024061303-heap-catalyst-0a58@gregkh>
References: <2024061303-heap-catalyst-0a58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEZPR02MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b629ac-e519-413b-f62b-08dc8c2ef430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|1800799019|7416009|376009|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLuUw5fARIuDABOYU0iI9FmjHT3Gz9qz/gk+XLqPwlFCx2eUafkrStVzdwuL?=
 =?us-ascii?Q?EeUDZvK4xtAG8Zw5TNO2r2XpNDFaw06OA1nT/hXQW6byCjW0kCqoWUur0Wj+?=
 =?us-ascii?Q?t3LxqIlF71f3a4st94rUOIG9bz5XEIWfa4k0vhemqYz/KYQ1HQFgw1mdWUWE?=
 =?us-ascii?Q?z+nv2zH6yj7iS8ePy1lIR+o8OfOzu4bQr5XDHaMmf9Mqp0cDFyAWoCcx9nfw?=
 =?us-ascii?Q?3hWxB9doH1NokqtUy5y+SBO/37hL9yK2yfG5fpyDqQIVoQLqEzNIk50IQM+9?=
 =?us-ascii?Q?B77hXFA5QO2wnbTCOqwfSL/Q2ItUg6CopzXcoITTehsTj1coJ/WsYMgLdjZm?=
 =?us-ascii?Q?7r1arg+VB1/uvaCiCZr4DnqKJ9dz1PJUoBuFWD66ha6ITrozwNmSwWZZhlDx?=
 =?us-ascii?Q?UDBopbzPDduYnDmeOgoj1ZipIED4u6qQc8I/TFSW5zVSFdKHiBCB1W8+uXu4?=
 =?us-ascii?Q?9Y9sK2f0mIq//1giS5GE/piNJlmoEc36Ulu642ifjSK/x1ROs+jCeeb+E+/1?=
 =?us-ascii?Q?P6r/VN5CHySYufT3G1iowKcf6Xivh5nrhdlg74LsREls4RHyZ4NgtFrCVqDE?=
 =?us-ascii?Q?Mkh+rkwQvJIyKKxABI2Py5dKrngoGY+FJe3Bv011Q65PDnTwI47ht/eOgcqf?=
 =?us-ascii?Q?SCgAnSydw6gLpmU/EBekxx8qnNShFfK+/kiOMzHacyu2fFKs1p+nAj8zq/Uy?=
 =?us-ascii?Q?9Wu1tG2IxAqs9tn9LEYnwwp51I18ecFxEE7e03twuePniJTtU3gP4A5iYBOV?=
 =?us-ascii?Q?GpCUoK0z2ys2qqfrgu0UQWS6dDTJKYrCOD7r/tsiPE5wAYrfxH+xntWbt4rN?=
 =?us-ascii?Q?vzYHfsfZ7lpMKnFDtuClsNiddJOfign3oYIQhXjd3yuM2/nSUfjJwRJvoI/J?=
 =?us-ascii?Q?db+kS0Ka9mOgTFDgT2hHzEbp939f3da9ceE8x8F/O7LH4rJ8GK0VpoVFPSm4?=
 =?us-ascii?Q?wXqsy/9pjqCADhhq0PXY0lCMxaZpzBeXRHhgPSd8VuigVq2cNa1/1ofraSxn?=
 =?us-ascii?Q?pvo6i1SckDr1PfRAd0Vyu4o1fi4hxUG56xK3kFitjwZKEud/6Xv7wUjh4pKR?=
 =?us-ascii?Q?FZnBFMoLd31WqJf/uTF7shbPIddnAmIdLnjqOC/VKSdaXVrXtGbVdw35XpJz?=
 =?us-ascii?Q?xxUdN1lx2eBmm/lYGSXOH7Jnlt7MOtnwPOHZGJP/l/91Fhv7ql9ViOnpFJju?=
 =?us-ascii?Q?XxlI0aNTPR9lCu4ERPlVNnkdiBu7ef92oyczMv0GpdmaBk9P9rqJhVXZy/CL?=
 =?us-ascii?Q?N0v19redp5xx/8yrAKCkHMpoZ4LJRGETtIOVJwdIW0GsqcyY3lJLOdbK89wn?=
 =?us-ascii?Q?o+YWuKEcW3aQBRtznmDujniA3nFuhGzJcw8ZdRU3FFfSTSHjJSbG3xzytl7n?=
 =?us-ascii?Q?oTCNFyp59q8moG9BgnUC1kRYw0JIzxvu/0H43I2JQxVdU5HZTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(36860700008)(1800799019)(7416009)(376009)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 05:00:47.1439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b629ac-e519-413b-f62b-08dc8c2ef430
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7136

From: "Hailong.Liu" <hailong.liu@oppo.com>

commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
includes support for __GFP_NOFAIL, but it presents a conflict with commit
dd544141b9eb ("vmalloc: back off when the current task is OOM-killed").  A
possible scenario is as follows:

process-a
__vmalloc_node_range(GFP_KERNEL | __GFP_NOFAIL)
    __vmalloc_area_node()
        vm_area_alloc_pages()
		--> oom-killer send SIGKILL to process-a
        if (fatal_signal_pending(current)) break;
--> return NULL;

To fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
if __GFP_NOFAIL set.

This issue occurred during OPLUS KASAN TEST. Below is part of the log
-> oom-killer sends signal to process
[65731.222840] [ T1308] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/apps/uid_10198,task=gs.intelligence,pid=32454,uid=10198

[65731.259685] [T32454] Call trace:
[65731.259698] [T32454]  dump_backtrace+0xf4/0x118
[65731.259734] [T32454]  show_stack+0x18/0x24
[65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
[65731.259781] [T32454]  dump_stack+0x18/0x38
[65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
[65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
[65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
[65731.260047] [T32454]  notify_die+0x114/0x198
[65731.260073] [T32454]  die+0xf4/0x5b4
[65731.260098] [T32454]  die_kernel_fault+0x80/0x98
[65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
[65731.260146] [T32454]  do_bad_area+0x68/0x148
[65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
[65731.260204] [T32454]  el1_abort+0x3c/0x5c
[65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
[65731.260248] [T32454]  el1h_64_sync+0x68/0x6c

[65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
--> be->decompressed_pages = kvcalloc(be->nr_pages, sizeof(struct page *), GFP_KERNEL | __GFP_NOFAIL);
	kernel panic by NULL pointer dereference.
	erofs assume kvmalloc with __GFP_NOFAIL never return NULL.
[65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
[65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
[65731.260339] [T32454]  read_pages+0x170/0xadc
[65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
[65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
[65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
[65731.260437] [T32454]  __do_fault+0xd0/0x33c
[65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
[65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
[65731.260509] [T32454]  el0_da+0x44/0x94
[65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
[65731.260553] [T32454]  el0t_64_sync+0x198/0x19c

Link: https://lkml.kernel.org/r/20240510100131.1865-1-hailong.liu@oppo.com
Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Reported-by: Oven <liyangouwen1@oppo.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Chao Yu <chao@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Gao Xiang <xiang@kernel.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 8e0545c83d672750632f46e3f9ad95c48c91a0fc)
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 67a10a04df04..c2d3abb6d027 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2923,6 +2923,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
+	bool nofail = gfp & __GFP_NOFAIL;
 	struct page *page;
 	int i;
 
@@ -2976,7 +2977,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	/* High-order pages or fallback path if "bulk" fails. */
 
 	while (nr_allocated < nr_pages) {
-		if (fatal_signal_pending(current))
+		if (!nofail && fatal_signal_pending(current))
 			break;
 
 		if (nid == NUMA_NO_NODE)
-- 
2.34.1


