Return-Path: <stable+bounces-179417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D8B55EF0
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 08:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE0F1C278F8
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 06:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA662E7646;
	Sat, 13 Sep 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h0xwzk6P"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F452BCFB
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744851; cv=fail; b=VjDW+ZESWKqm8+Is9+ES1Lgo0elLIVX4xMj+DnX+ktmEB/RHZ9mSXGGhY08BnidAzaUrPCpcAl5Jgx3bXQeqrdCXqwHNkLdrFYUYit7iylj1HKCmVx8l7WxzDLFH9y/+QqR7CBmWWoKB/j8zvcp83xZ0vUD1jnAH1RrpcdGDUBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744851; c=relaxed/simple;
	bh=L8WrpGk1DorcbGSuDdgRbaGsB7k07uTQ0uU0whlFxgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eZN2zNaEBrFOH4Z6RUUI9/i5P0ki67dj6S4kjoKqnI166/n8DMIlGIwgGdNp8lCBsKSaJxyMI8C50SkC1Qi6TRT+zcx7k6oSX9lnaelfkeNt0zD6ifec4N6z3JVS71wubkoDqnmMNFHylAmnlp4aVrsjmrwrNw4C0ebAXysHIOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h0xwzk6P; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGwEO849bn/UWIH6PQs1XlnUAOSft5S6pYGiystkXZrZzxU6c2F3StWi/tYyiIQNuLlzix+nelZPagqOD1fcB4xEJT7ECGEV25O3u/3fI6zKBnj6jvmRI5R0IAr/Tsy1mYUJ0gdThzZFOxW2aVJnTOoF90zOUEUr5+8NRU5TINZ0iksneCtAKZaYPfDEHxEgeKmRUqHxzZdNHDvnDA9dCMQauEjmC+mbq6ZsUgLbmCPfrowNKOolXl+KXKHdvmf/Ac90hnEhLW+hPB26rfsst+rFDiv07M44oJJO2vUh3TCkQecVFHOLCJxKaWlIwx0syBxhtyxhyIQlYshDUhC60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/gzzIMsI32JTOG/qw5D0Rxl7up0bywzWLqUfr7G5PI=;
 b=YRYp/vIG02pLO0fDhshiKOSY1c8dBjjx2SYre3QA3M4x1Hl5lXUqZcpbM9VkZFpy5bFzYsfNg0sD3s8cPdJSxKWeRj5KVCJn783wIKBecny9RvtLARBIVVsF/rHKyJkTSTaj1H6VdSnJgKKT60aUQP2TFaaTEmXg/MqpjamNQZjCumS4aYkZpjw2i7wFWW5r4wzF60H7g1ddelXQqKo//8VAPFWS3Gy8Oju9GzTa6qvnUJqubImshPw0CyAbA+KPlXvK3+/3bms70y7rJnG4bQjdWZfUITEPC0tqJHz/XFYNKzanj8QdNCFy5QIqQ3oNPNzroEi+ndV/0jM0v5sNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/gzzIMsI32JTOG/qw5D0Rxl7up0bywzWLqUfr7G5PI=;
 b=h0xwzk6P9gfXDcwVkKoDvSyKZ6eEIGbu7JhAaE6+JgE/1Y9NPGQib4owBpvuAzPSpAIc+s2ZV/0fyc177tIxgyaExOX6GwOkhucIMvJAolHCExUisRLOoptomn9rzNzRR2kaRYeFIi3qnCl/Xzb90x4HMzLZ8Mg7xFWz3Hli+qU=
Received: from BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 06:27:23 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::f9) by BLAPR03CA0073.outlook.office365.com
 (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.19 via Frontend Transport; Sat,
 13 Sep 2025 06:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Sat, 13 Sep 2025 06:27:23 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 23:27:19 -0700
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <stable@vger.kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2] iommu/amd/pgtbl: Fix possible race while increase page table level
Date: Sat, 13 Sep 2025 06:26:57 +0000
Message-ID: <20250913062657.641437-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: c24e7e9c-49ab-4e21-b801-08ddf28e9995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3hU96gCsetYBn4jrafElYAuu4LE24+TfMUr6amrRePKrv8NyuB2gmxR+NcK/?=
 =?us-ascii?Q?TusY3fgOSRx//MGhf2+2xTW5HKqd/bVPqKlepbb6puHxy2HHDVrUtREEQUVK?=
 =?us-ascii?Q?HE3nUsGeFBBoGx40FIBi4u91Thq4OD0Z4W+Jgv7c1+r3mYKl7Frf13FMW48h?=
 =?us-ascii?Q?vhAQLeRIswEjaV+ZjzA3kVEce2qCaeM0y9L0bADjuDtr02zh+/Z73k5WnXIN?=
 =?us-ascii?Q?G8DQ9jNzMq6SsLzB3rqEus68vsbvxR07cOnKBh1gbNiAlHZ+Ro0CTUX1QoFJ?=
 =?us-ascii?Q?zlufyLQ7uB8EOw8UDYAVgE2UnWW4CmcVLPTVb8i/tDgxfHEX+yzWX+S05QaA?=
 =?us-ascii?Q?RqHBp+xHjZgHg/jjy+QTNbsgZWNKmUJYg7qkMLq9B2dbz7F8UDKP3xWqJTLv?=
 =?us-ascii?Q?I6fvlt+/+HesDlN5y59xL/3QfrY6CTtDl8MLkkCnlx5sYGVE5ep2D3Qh7qWb?=
 =?us-ascii?Q?6CNooFSJ1ccJL9s+Zvw/N07wnrJioS8Y7zbPUbbjAjIXDXPffB40D1dNSONe?=
 =?us-ascii?Q?mpwx5ZSvhky5rjRoz8VQGg3HMFtP7EIOdR9XANDN6BieqNmRb3jzuCwogMgG?=
 =?us-ascii?Q?sYNr/OgN0SQuYHrOqP1cQtX5jb7w9fc2+iZSJ6kbiROFxykLaDxcHinfrJ4z?=
 =?us-ascii?Q?2qdn2XhfK39S987RpP6sb0NeOHqxagE5jT8WCL8Cg68ca/6eQOKCH/JsCS4T?=
 =?us-ascii?Q?mSBrzGKmNtzF41GQnk69x0cOG4NB/1cA88vSYpix2rRVnGSYFEr1JAzCR6Hq?=
 =?us-ascii?Q?Y3O8O1vxTeXdE/OKSjKg8MLGqyu0qo/D+nsMrEIDS0dNKflAg2YqZ/vokswM?=
 =?us-ascii?Q?GUDa4jpuAh2WjljaM/kThDhCobdlUKDVN3zstCUA/QxYiy34ELP0pCL18HFW?=
 =?us-ascii?Q?mvr//ipyHfyKLYVvqBFrO0ozZTW0P5sVsMl33Trepcg/4kP6k2/eOY04QGpG?=
 =?us-ascii?Q?OuFzl6B2MUcdVKTlZzePUYN+jwo7mjskXU+/La3VWwa+DuMGfC3YPuNZYKAN?=
 =?us-ascii?Q?unoKfMCnxuSvnOza3ydo/uAj2Tav6noO/AEwTAKNPCHGUK1aqT8E6vhxsObS?=
 =?us-ascii?Q?sv7bG1rgedzJyTGexa+5VX/FDWE62qE3XVqqpvMYPo9MBd2U+bfz9XCYaFOD?=
 =?us-ascii?Q?qFYE7dhC0Fm5VKgIVO5iwNlRUb6S9ZOTmST+dSSevVXAm1BR3pO7DdVEhXbw?=
 =?us-ascii?Q?j5ukcj9RH0+Cmmu85/X5XHWoIs9iSReqYpmyDJEATShjZR007NoM2w+XuuHE?=
 =?us-ascii?Q?VSlJ2O6+b3AFz5PlufqtkIDQzXKxYXzx2MLMnp071q4I8GLTwm453q+mHk8k?=
 =?us-ascii?Q?8e6BUzrSDIJQwXAJZM3Krc7MgfLKTiBQuH6Ka/pSeJCy3AfazMRfAZAkEDNO?=
 =?us-ascii?Q?Hccl2zDXmAc9aciCg+6voM99Go82IIf22eNjtmec1cCTm9wJeY4CR1Rv+2yc?=
 =?us-ascii?Q?yBNQCuYSp3b6H/FNThbwrLJUcGWTgvroELDSPiuDs3GXrDy2Jgv0b4/gNqOn?=
 =?us-ascii?Q?EXsCNRZ7vEmElwwTw1DVk3dHM9kZ3IJcotaj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 06:27:23.2059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c24e7e9c-49ab-4e21-b801-08ddf28e9995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

The AMD IOMMU host page table implementation supports dynamic page table levels
(up to 6 levels), starting with a 3-level configuration that expands based on
IOVA address. The kernel maintains a root pointer and current page table level
to enable proper page table walks in alloc_pte()/fetch_pte() operations.

The IOMMU IOVA allocator initially starts with 32-bit address and onces its
exhuasted it switches to 64-bit address (max address is determined based
on IOMMU and device DMA capability). To support larger IOVA, AMD IOMMU
driver increases page table level.

But in unmap path (iommu_v1_unmap_pages()), fetch_pte() reads
pgtable->[root/mode] without lock. So its possible that in exteme corner case,
when increase_address_space() is updating pgtable->[root/mode], fetch_pte()
reads wrong page table level (pgtable->mode). It does compare the value with
level encoded in page table and returns NULL. This will result is
iommu_unmap ops to fail and upper layer may retry/log WARN_ON.

CPU 0                                         CPU 1
------                                       ------
map pages                                    unmap pages
alloc_pte() -> increase_address_space()      iommu_v1_unmap_pages() -> fetch_pte()
  pgtable->root = pte (new root value)
                                             READ pgtable->[mode/root]
					       Reads new root, old mode
  Updates mode (pgtable->mode += 1)

Since Page table level updates are infrequent and already synchronized with a
spinlock, implement seqcount to enable lock-free read operations on the read path.

Fixes: 754265bcab7 ("iommu/amd: Fix race in increase_address_space()")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: stable@vger.kernel.org
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/io_pgtable.c      | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5219d7ddfdaa..95f63c5f6159 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -555,6 +555,7 @@ struct gcr3_tbl_info {
 };
 
 struct amd_io_pgtable {
+	seqcount_t		seqcount;	/* Protects root/mode update */
 	struct io_pgtable	pgtbl;
 	int			mode;
 	u64			*root;
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index a91e71f981ef..70c2f5b1631b 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
+#include <linux/seqlock.h>
 
 #include <asm/barrier.h>
 
@@ -130,8 +131,11 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 
 	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
 
+	write_seqcount_begin(&pgtable->seqcount);
 	pgtable->root  = pte;
 	pgtable->mode += 1;
+	write_seqcount_end(&pgtable->seqcount);
+
 	amd_iommu_update_and_flush_device_table(domain);
 
 	pte = NULL;
@@ -153,6 +157,7 @@ static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
 {
 	unsigned long last_addr = address + (page_size - 1);
 	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
+	unsigned int seqcount;
 	int level, end_lvl;
 	u64 *pte, *page;
 
@@ -170,8 +175,14 @@ static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
 	}
 
 
-	level   = pgtable->mode - 1;
-	pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	do {
+		seqcount = read_seqcount_begin(&pgtable->seqcount);
+
+		level   = pgtable->mode - 1;
+		pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	} while (read_seqcount_retry(&pgtable->seqcount, seqcount));
+
+
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
 
@@ -249,6 +260,7 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 		      unsigned long *page_size)
 {
 	int level;
+	unsigned int seqcount;
 	u64 *pte;
 
 	*page_size = 0;
@@ -256,8 +268,12 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	if (address > PM_LEVEL_SIZE(pgtable->mode))
 		return NULL;
 
-	level	   =  pgtable->mode - 1;
-	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	do {
+		seqcount = read_seqcount_begin(&pgtable->seqcount);
+		level	   =  pgtable->mode - 1;
+		pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
+	} while (read_seqcount_retry(&pgtable->seqcount, seqcount));
+
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
@@ -541,6 +557,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	if (!pgtable->root)
 		return NULL;
 	pgtable->mode = PAGE_MODE_3_LEVEL;
+	seqcount_init(&pgtable->seqcount);
 
 	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
 	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
-- 
2.31.1


